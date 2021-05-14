""" TODO """

load("@build_bazel_rules_apple//apple:providers.bzl", "AppleBundleInfo")

AdditionalSchemeInfo = provider(
    """   
    TODO
    """,
    fields = {
        "scheme_build_action_target": "TODO",
        "scheme_test_action_targets": "TODO",
    },
)

def _additional_scheme_info_impl(ctx):
    test_action_targets = [
        struct(
            name = test_target[AppleBundleInfo].bundle_name,
            environment_variables = ctx.attr.test_environment,
        )
        for test_target in ctx.attr.test_bundle_targets
    ]

    return [
        AdditionalSchemeInfo(
            scheme_build_action_target = ctx.attr.build_target[AppleBundleInfo].bundle_name,
            scheme_test_action_targets = test_action_targets,
        ),
    ]

additional_scheme_info = rule(
    implementation = _additional_scheme_info_impl,
    doc = "TODO",
    attrs = {
        "build_target": attr.label(
            mandatory = True,
            doc = "The build target to attach the additional scheme info to.",
            providers = [AppleBundleInfo],
        ),
        "test_bundle_targets": attr.label_list(
            mandatory = False,
            doc = "A list of test targets that should be appended to the build_target",
            allow_empty = True,
            providers = [AppleBundleInfo],
        ),
        "test_environment": attr.string_dict(
            mandatory = False,
            allow_empty = True,
            doc = "Extra environment variables to pass during tests",
            default = {},
        ),
    },
)
