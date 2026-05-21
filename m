Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD423ED3A6
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386142; cv=none; b=BiqzWeDkrRZ8bEEiHG7JDXDPExJnDqWC93C6pd551BBKexmfayXWgqAIYiGeGRrNDunwirRu+z0mo+cjaMr474avEL+TO46OIoyFJGk+Dp+nOqgQSU+mD+Dy88NH3K1Y0+l5plgTPnjRlNuLTHwi/tZNFJa2hPuxTOj9cWEMDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386142; c=relaxed/simple;
	bh=PWE9Gdh37LLWr2tuhdLq7S0nam4hEYHuSpRBBLVwGH8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=NWPJOiFLPC895Ttud/t3CF4in2myvTg2ljX966LkeYAWd5XwGeLWxYiIQOEHbIKl3CcCCJ9pqdTSE9+k+dgS6p+1eDbxG7sEtVSDAy6y6rGIOJsA5MFiiYvpmZVXASqt4kjz3S0uMbpyHAeAUWK5vOC6Zy9N3mgfWH+khZK6Ly4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IqvmpDlK; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IqvmpDlK"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-3041ab826ddso3655307eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 10:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779386139; x=1779990939; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OwJZ4rFsTmpxwL5qtXdjOZznkVLQwCVlL2xsNs7R4ac=;
        b=IqvmpDlK/jgf7Z+WIqA9PFOok65Yo6m9r82eXiUfmzgjZnSdZcKv3UORCsDUYAW1Lm
         Vw8w9h/C8VHmarok44C08i2HRTbB9hFnoj9DhubzZ2LN0vPQhJGOVcnasoo27BCFzuqM
         CoGyg6emUQYaDxMsmK6aICaKuJLBfIcuyEYJm/k0CnjKBaONOMP6aN3zEPXumM+S1kil
         nJOyNvMCzEJ2P6JxqQpzThggv2wvnBvSno0gJ8tnPBCpStWDJXQHFU6IQH/Zy2voK6UZ
         DoJ9kMcFwdRg2irSVlRCEMjMG9ONyF7Yzs46t3fwyswmRbFbktwktgqO0ea9cXH0iPaK
         o7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779386139; x=1779990939;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OwJZ4rFsTmpxwL5qtXdjOZznkVLQwCVlL2xsNs7R4ac=;
        b=OYE6sbXY5aUxiQ1o/dVp7GjxWSAPr/XiLZfDcp+laYQ644krYREAypNC5cE9345OIz
         kLMwDM0CcCHMqmTzOEJcHuXeQ3sEc0OfiyuiBXfWrou6I5VB7eK/t/RyBQOsRAO4F71w
         URySCuvS0n5L0LURSORCNYw72ldsY7hoHFHrLzXf6Una6q8UNvz5HFg/fqH9dYl3e4D8
         MzPlGQxwO00tOfw0CIVaSSu+Zsb91EeQ8zDyw+6Cy61HeLhRVLSHxOBMvDvTqpfiVH0y
         LoRfz5GEbDJewGbG5w+qdUqzvicVxjQGCnCx+YEhMX+FEfumbzdRTN5IC7n79aDZL1Rx
         FC+w==
X-Forwarded-Encrypted: i=1; AFNElJ85mipKzUzn9ptGYmOBfpc5psWFC6YhqYDEHV6JGBbFe1EsQTQZ17T3CFySKuMN5uIfdnS/08iuIc2Flcp+PdID@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8K7vpFZTKwKCy/7tpn5eLCcZOw9v7XZCTuAM6vEXDlNOOhMNL
	Ar4uRk/nh0Hjqj0iWm/21qD4p9cSbUesggk/Z9Z/vKcW94qIvX2ooridkelOv3A/SePDNy2W+pG
	WduMA08tIzA==
X-Received: from dlbpk2.prod.google.com ([2002:a05:7022:3842:b0:134:ce13:c1a1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6da7:b0:2f2:6dde:df50
 with SMTP id 5a478bee46e88-30449054359mr112838eec.17.1779386138766; Thu, 21
 May 2026 10:55:38 -0700 (PDT)
Date: Thu, 21 May 2026 10:55:35 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260521175535.1531810-1-irogers@google.com>
Subject: [PATCH v1] perf python: Clean up and restructure setup.py
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Clean up and restructure the python setup script to resolve pylint
warnings, improve code quality, and increase robustness and
readability, targeting Python 3.9+ (the Linux kernel build minimum
Python version).

Changes:
- Restructure the script to use a `main()` function as the entry point,
  leaving only imports, classes, and pure functions at module level.
- Eliminate all global/module-level variables, making them local to
  `main()` or the respective classes/functions.
- Make `clang_has_option` a pure function by passing all necessary
  parameters explicitly.
- Extract clang compiler flag filtering into a new
  `filter_clang_options` helper function. This function uses a loop
  over a tuple of options, replacing ~30 lines of repetitive blocks
  and reducing branch/statement complexity in the main flow.
- Cleanly define attributes in `__init__` for `BuildExt` and `InstallLib`
  and read environment variables dynamically within the methods, removing
  their dependency on global variables.
- Replace legacy Popen with subprocess.run for safer process handling.
- Use list-based flag filtering (split, filter, re-join) instead of regex
  `re.sub` substitutions on space-separated compiler flag strings. This
  avoids boundary bugs and safely handles flags with arguments (e.g.
  `-fcf-protection=full`).
- Safely parse `CC` env var using `shlex.split` to handle quotes and pass
  compiler arguments as `list[str]` lists to helper functions, avoiding
  redundant string formatting and parsing.
- Remove unused `import re`.
- Rename setuptools command subclasses to PascalCase (BuildExt, InstallLib).
- Add type annotations to functions and methods.
- Add missing docstrings for module, functions, and classes.
- Split long lines to adhere to standard limits.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/setup.py | 253 +++++++++++++++++++++++++--------------
 1 file changed, 166 insertions(+), 87 deletions(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index b65b1792ca05..55ff7d8cba7e 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -1,108 +1,187 @@
-from os import getenv, path
-from subprocess import Popen, PIPE
-from re import sub
+"""Setup script for perf python extension.
+
+This script is used to build and install the perf python binding.
+It handles compiler-specific flags, especially for clang, and configures
+the setuptools Extension.
+"""
+
+import os
 import shlex
+import subprocess
+import sysconfig
 
-cc = getenv("CC")
-assert cc, "Environment variable CC not set"
+from setuptools import setup, Extension
+from setuptools.command.build_ext import build_ext as _build_ext
+from setuptools.command.install_lib import install_lib as _install_lib
 
-# Check if CC has options, as is the case in yocto, where it uses CC="cc --sysroot..."
-cc_tokens = cc.split()
-if len(cc_tokens) > 1:
-    cc = cc_tokens[0]
-    cc_options = " ".join([str(e) for e in cc_tokens[1:]]) + " "
-else:
-    cc_options = ""
 
-# ignore optional stderr could be None as it is set to PIPE to avoid that.
-# mypy: disable-error-code="union-attr"
-cc_is_clang = b"clang version" in Popen([cc, "-v"], stderr=PIPE).stderr.readline()
+def clang_has_option(cc: str, cc_args: list[str], src_feature_tests: str, option: str) -> bool:
+    """Check if clang supports a specific option.
 
-srctree = getenv('srctree')
-assert srctree, "Environment variable srctree, for the Linux sources, not set"
-src_feature_tests  = f'{srctree}/tools/build/feature'
+    Args:
+        cc: The compiler executable.
+        cc_args: Compiler arguments from CC environment variable.
+        src_feature_tests: Path to the feature tests directory.
+        option: The compiler option to check (e.g., "-mcet").
 
-def clang_has_option(option):
+    Returns:
+        True if the option is supported, False otherwise.
+    """
     error_substrings = (
         b"unknown argument",
         b"is not supported",
         b"unknown warning option"
     )
-    cmd = shlex.split(f"{cc} {cc_options} {option}") + [
+    cmd = [cc] + cc_args + [
+        option,
         "-o", "/dev/null",
-        path.join(src_feature_tests, "test-hello.c")
+        os.path.join(src_feature_tests, "test-hello.c")
     ]
-    cc_output = Popen(cmd, stderr=PIPE).stderr.readlines()
+    try:
+        res = subprocess.run(cmd, stderr=subprocess.PIPE, stdout=subprocess.DEVNULL, check=False)
+        cc_output = res.stderr.splitlines()
+    except OSError:
+        return False
     return not any(any(error in line for error in error_substrings) for line in cc_output)
 
-if cc_is_clang:
-    from sysconfig import get_config_vars
-    vars = get_config_vars()
+
+def filter_clang_options(cc: str, cc_args: list[str], src_feature_tests: str) -> None:
+    """Filter out unsupported clang options from sysconfig CFLAGS and OPT.
+
+    Args:
+        cc: The compiler executable.
+        cc_args: Compiler arguments from CC environment variable.
+        src_feature_tests: Path to the feature tests directory.
+    """
+    config_vars = sysconfig.get_config_vars()
     for var in ('CFLAGS', 'OPT'):
-        vars[var] = sub("-specs=[^ ]+", "", vars[var])
-        if not clang_has_option("-mcet"):
-            vars[var] = sub("-mcet", "", vars[var])
-        if not clang_has_option("-fcf-protection"):
-            vars[var] = sub("-fcf-protection", "", vars[var])
-        if not clang_has_option("-fstack-clash-protection"):
-            vars[var] = sub("-fstack-clash-protection", "", vars[var])
-        if not clang_has_option("-fstack-protector-strong"):
-            vars[var] = sub("-fstack-protector-strong", "", vars[var])
-        if not clang_has_option("-fno-semantic-interposition"):
-            vars[var] = sub("-fno-semantic-interposition", "", vars[var])
-        if not clang_has_option("-ffat-lto-objects"):
-            vars[var] = sub("-ffat-lto-objects", "", vars[var])
-        if not clang_has_option("-ftree-loop-distribute-patterns"):
-            vars[var] = sub("-ftree-loop-distribute-patterns", "", vars[var])
-        if not clang_has_option("-gno-variable-location-views"):
-            vars[var] = sub("-gno-variable-location-views", "", vars[var])
+        if var not in config_vars:
+            continue
+
+        # Split into individual flags to avoid regex boundary issues
+        flags = config_vars[var].split()
+
+        # Remove -specs=...
+        flags = [f for f in flags if not f.startswith("-specs=")]
+
+        options = (
+            "-mcet",
+            "-fcf-protection",
+            "-fstack-clash-protection",
+            "-fstack-protector-strong",
+            "-fno-semantic-interposition",
+            "-ffat-lto-objects",
+            "-ftree-loop-distribute-patterns",
+            "-gno-variable-location-views"
+        )
+        for option in options:
+            if not clang_has_option(cc, cc_args, src_feature_tests, option):
+                # Remove the option and any variant (e.g. -option=...)
+                flags = [f for f in flags if not f.startswith(option)]
+
+        # Re-join flags
+        config_vars[var] = " ".join(flags)
+
+
+class BuildExt(_build_ext):
+    """Custom build_ext command to set output directories."""
+
+    def __init__(self, *args, **kwargs):
+        self.build_lib = None
+        self.build_temp = None
+        super().__init__(*args, **kwargs)
+
+    def finalize_options(self) -> None:
+        _build_ext.finalize_options(self)
+        build_lib = os.getenv('PYTHON_EXTBUILD_LIB')
+        build_tmp = os.getenv('PYTHON_EXTBUILD_TMP')
+        if build_lib:
+            self.build_lib = build_lib
+        if build_tmp:
+            self.build_temp = build_tmp
 
-from setuptools import setup, Extension
 
-from setuptools.command.build_ext   import build_ext   as _build_ext
-from setuptools.command.install_lib import install_lib as _install_lib
+class InstallLib(_install_lib):
+    """Custom install_lib command to set output directory."""
 
-class build_ext(_build_ext):
-    def finalize_options(self):
-        _build_ext.finalize_options(self)
-        self.build_lib  = build_lib
-        self.build_temp = build_tmp
+    def __init__(self, *args, **kwargs):
+        self.build_dir = None
+        super().__init__(*args, **kwargs)
 
-class install_lib(_install_lib):
-    def finalize_options(self):
+    def finalize_options(self) -> None:
         _install_lib.finalize_options(self)
-        self.build_dir = build_lib
-
-
-cflags = getenv('CFLAGS', '').split()
-# switch off several checks (need to be at the end of cflags list)
-cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
-if cc_is_clang:
-    cflags += ["-Wno-unused-command-line-argument" ]
-    if clang_has_option("-Wno-cast-function-type-mismatch"):
-        cflags += ["-Wno-cast-function-type-mismatch" ]
-else:
-    cflags += ['-Wno-cast-function-type' ]
-
-# The python headers have mixed code with declarations (decls after asserts, for instance)
-cflags += [ "-Wno-declaration-after-statement" ]
-
-src_perf  = f'{srctree}/tools/perf'
-build_lib = getenv('PYTHON_EXTBUILD_LIB')
-build_tmp = getenv('PYTHON_EXTBUILD_TMP')
-
-perf = Extension('perf',
-                 sources = [ src_perf + '/util/python.c' ],
-		         include_dirs = ['util/include'],
-		         extra_compile_args = cflags,
-                 )
-
-setup(name='perf',
-      version='0.1',
-      description='Interface with the Linux profiling infrastructure',
-      author='Arnaldo Carvalho de Melo',
-      author_email='acme@redhat.com',
-      license='GPLv2',
-      url='http://perf.wiki.kernel.org',
-      ext_modules=[perf],
-      cmdclass={'build_ext': build_ext, 'install_lib': install_lib})
+        build_lib = os.getenv('PYTHON_EXTBUILD_LIB')
+        if build_lib:
+            self.build_dir = build_lib
+
+
+def main() -> None:
+    """Main entry point for the setup script."""
+    cc_env = os.getenv("CC")
+    assert cc_env, "Environment variable CC not set"
+
+    # Safe parsing of CC environment variable which might contain options/quotes
+    cc_tokens = shlex.split(cc_env)
+    cc = cc_tokens[0]
+    cc_args = cc_tokens[1:]
+
+    # Run CC -v to check if it is clang.
+    try:
+        cc_info = subprocess.run(
+            [cc, "-v"], stderr=subprocess.PIPE, stdout=subprocess.DEVNULL, check=False
+        )
+        cc_is_clang = b"clang version" in cc_info.stderr
+    except OSError as e:
+        raise RuntimeError(f"Failed to execute compiler '{cc}': {e}") from e
+
+    srctree = os.getenv('srctree')
+    assert srctree, "Environment variable srctree, for the Linux sources, not set"
+    src_feature_tests = f'{srctree}/tools/build/feature'
+
+    if cc_is_clang:
+        filter_clang_options(cc, cc_args, src_feature_tests)
+
+    cflags = os.getenv('CFLAGS', '').split()
+    # switch off several checks (need to be at the end of cflags list)
+    cflags += [
+        '-fno-strict-aliasing',
+        '-Wno-write-strings',
+        '-Wno-unused-parameter',
+        '-Wno-redundant-decls'
+    ]
+    if cc_is_clang:
+        cflags += ["-Wno-unused-command-line-argument"]
+        if clang_has_option(
+            cc, cc_args, src_feature_tests, "-Wno-cast-function-type-mismatch"
+        ):
+            cflags += ["-Wno-cast-function-type-mismatch"]
+    else:
+        cflags += ['-Wno-cast-function-type']
+
+    # The python headers have mixed code with declarations (decls after asserts, for instance)
+    cflags += ["-Wno-declaration-after-statement"]
+
+    src_perf = f'{srctree}/tools/perf'
+
+    perf = Extension(
+        'perf',
+        sources=[os.path.join(src_perf, 'util/python.c')],
+        include_dirs=['util/include'],
+        extra_compile_args=cflags,
+    )
+
+    setup(
+        name='perf',
+        version='0.1',
+        description='Interface with the Linux profiling infrastructure',
+        author='Arnaldo Carvalho de Melo',
+        author_email='acme@redhat.com',
+        license='GPLv2',
+        url='http://perf.wiki.kernel.org',
+        ext_modules=[perf],
+        cmdclass={'build_ext': BuildExt, 'install_lib': InstallLib},
+    )
+
+
+if __name__ == '__main__':
+    main()
-- 
2.54.0.794.g4f17f83d09-goog

