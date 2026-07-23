Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2E445D189
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827635; cv=none; b=bfYtxXF1ERtkoz0NWSLjsZ2JvIb2BQq9/gI7ztH+gr0Axz1yN35NgTiukIgzxQ4rCPCo6m0erukhkqM3IZ8JwbyXXFMKVgEsTO2rtoF6bz4YSI/ZmgW2ue5kjLUDPzdGrGSOC31t8x3iFEungVf2rqNd+2JybLzixc7WBdX2LgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827635; c=relaxed/simple;
	bh=C7Z7K1BulSESEBQ/+UlGp72Yj4mR7Jtl0/w8OavXy2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LZ7Z0ULs0n7S7WiydRXJU3j8ENIXdxO03JkFSpVdUGAe1xxzXW63B5s9ke3Pziyku99YdoCd2c3rHsGSZlrdFmDpybmvrt/nqaPVgHCeu8SW6tQuway7grgaL8DceR0Mm40diuK8iDjAd1hrAOzlNgmYY8FF7/cqlmkQzcJruS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wGiGkM5e; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGiGkM5e"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so1358316a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 10:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784827633; x=1785432433; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uSdpLIP0nAJC3ExFWOnDyPKsA7zEkDfiYwulEoupMUI=;
        b=wGiGkM5eueARuYp3J7EW9/OOeqD2kZ5DoCLQ6MHuDm7WtQsF6EnFYaAgGp+Ho02eXL
         HcGFchabXyO5R7hSZ5cbkrm275gvxlEJJEhFs2iG5pvLev1HHfQLwkQCdWotTpbdPPes
         UJ8JYehELprsyodbiLjSz7UEOtW/1F8LiUSOgeYuKx++fdcLl4useBaPD33YLi6n203v
         KEz+4ir4DZw65fjz/krp/aF0SIo5JkLjXTya6vlNHS9k2zph2atgn3xwZyT1RwG9snD+
         I3V8IMF4aYGVq0KfxV1S2nB0s+/lBpNxfnxleCTP5IIIXs6GLCAJCUGVF77W3p5beSi0
         Xllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784827633; x=1785432433;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uSdpLIP0nAJC3ExFWOnDyPKsA7zEkDfiYwulEoupMUI=;
        b=J9ClFOrfblF9toftXcFdkB1I+ecM2f/sufojSD4L/4Tf/iHCMYFrM4PIeb6x7aK/Sg
         GM9vavTR5x2jHHWcls9S1lSewQKpAocRxJmODkmUbOrinxhtm/6rNLfn4DgR2UxmpDfl
         xe8CJCXGKX5hzIjQlpZfYROyIrziNlrQM9WlkbWOPSW1Zt9i/nkMMPkpGwDHkYoWuC98
         FX2kQJ1MsyDsnzGGExW/7pFVQSW3M7tJ9LA1XphftjkFmXRBH2YXbOi+YqQ8ABbrEvMj
         G69huJHgO134HqcIxWIwGuiXKhsHN25ZrUGkXhMCsmTJRcFqWM+wIz1zmdkmQs1y5Eqx
         4I7w==
X-Forwarded-Encrypted: i=1; AHgh+RpIYz7Sw4J38jzYnO6eVmqG22vNAgVOuM5EaCJuYf8BV8oLOYaW7O+wKkwDom2A4EeTYSneADNJb6qn+T1epuI7@vger.kernel.org
X-Gm-Message-State: AOJu0YyA/SVG2Ml080B40LFDcvcBpuLZTGjoArUZIy9XXaQ6N+MZIM2P
	pzYEiNdEsncZRN2LvZOk56a/D6UfoJM2sl2XdRK5BtBkpNAyNURFtriq+4JqwCXjATmL4vvyt1R
	VaImhzvJ6XQ==
X-Received: from dlec17-n2.prod.google.com ([2002:a05:701b:4291:20b0:13d:1fe2:b775])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f06:b0:37f:9ce2:348c
 with SMTP id 98e67ed59e1d1-38ec661d2c9mr4262249a91.29.1784827632740; Thu, 23
 Jul 2026 10:27:12 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:27:09 -0700
In-Reply-To: <20260723164421.1232688-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723164421.1232688-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723172709.1271166-1-irogers@google.com>
Subject: [PATCH v3] perf python: Clean up and restructure setup.py
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, namhyung@kernel.org, 
	peterz@infradead.org
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
- Cleanly define attributes in `__init__` for `BuildExt` and
  `InstallLib` and read environment variables dynamically within the
  methods (including `srctree` in `InstallLib.run`), removing their
  dependency on global variables.
- Replace legacy Popen with subprocess.run for safer process handling.
- Use quote-aware flag filtering (`shlex.split`, filter, `shlex.join`)
  on sysconfig CFLAGS and OPT instead of regex `re.sub` substitutions.
  This avoids boundary bugs and safely handles quoted arguments and
  options with values.
- Rely on setuptools to handle user CFLAGS from the environment
  directly rather than manually prepending them to extra_compile_args.
- Safely parse `CC` env var using `shlex.split` to handle quotes and
  pass compiler arguments as `list[str]` lists to helper functions,
  avoiding redundant string formatting and parsing.
- Remove unused `import re`.
- Rename setuptools command subclasses to PascalCase (BuildExt,
  InstallLib).
- Add type annotations to functions and methods.
- Add missing docstrings for module, functions, and classes.
- Split long lines to adhere to standard limits.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
v3:
  - Address Sashiko review feedback:
    - Use shlex.split() and shlex.join() in filter_clang_options()
      to handle quoted arguments.
    - Resolve NameError for src_perf in InstallLib.run() by resolving
      srctree/src_perf dynamically.
    - Remove manual CFLAGS splitting and duplication in main(), letting
      setuptools apply environment CFLAGS.
  - Add SPDX-License-Identifier header tag.
v2: Rebase
---
 tools/perf/util/setup.py | 256 ++++++++++++++++++++++++++-------------
 1 file changed, 169 insertions(+), 87 deletions(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index cb14554454a2..8380980ade4c 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -1,112 +1,194 @@
-from os import getenv, path
-from subprocess import Popen, PIPE
-from re import sub
+# SPDX-License-Identifier: GPL-2.0
+"""Setup script for perf python extension.
+
+This script is used to build and install the perf python binding.
+It handles compiler-specific flags, especially for clang, and configures
+the setuptools Extension.
+"""
+
+import os
 import shlex
 import shutil
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
+        # Split into individual flags using shlex to preserve quoted arguments
+        flags = shlex.split(config_vars[var])
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
+        # Re-join flags preserving quoting
+        config_vars[var] = shlex.join(flags)
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
+        build_lib = os.getenv('PYTHON_EXTBUILD_LIB')
+        if build_lib:
+            self.build_dir = build_lib
 
     def run(self):
         _install_lib.run(self)
-        shutil.copy2(f'{src_perf}/python/perf.pyi', self.install_dir)
-
-
-# switch off several checks (need to be at the end of cflags list)
-extra_cflags = ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
-if cc_is_clang:
-    extra_cflags += ["-Wno-unused-command-line-argument" ]
-    if clang_has_option("-Wno-cast-function-type-mismatch"):
-        extra_cflags += ["-Wno-cast-function-type-mismatch" ]
-else:
-    extra_cflags += ['-Wno-cast-function-type' ]
-
-# The python headers have mixed code with declarations (decls after asserts, for instance)
-extra_cflags += [ "-Wno-declaration-after-statement" ]
-
-src_perf  = f'{srctree}/tools/perf'
-build_lib = getenv('PYTHON_EXTBUILD_LIB')
-build_tmp = getenv('PYTHON_EXTBUILD_TMP')
-
-perf = Extension('perf',
-                 sources = [ src_perf + '/util/python.c' ],
-		         include_dirs = ['util/include'],
-		         extra_compile_args = extra_cflags,
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
+        srctree = os.getenv('srctree', '.')
+        src_perf = os.path.join(srctree, 'tools/perf')
+        shutil.copy2(os.path.join(src_perf, 'python/perf.pyi'), self.install_dir)
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
+    # switch off several checks (need to be at the end of cflags list)
+    cflags = [
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
2.55.0.229.g6434b31f56-goog

