Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E303E7BCA
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825070; cv=none; b=RZMRz9T/LZ70BprnBv2Y1eMxJgtPbU8Rj9m/xgpBWrq5ZqWxktmqIiVCvZNEhsC13dUwQUV3JUG0aeXqAryGGjaU6RjKtsu3X5p51ww6rrmzJ0vsmN8vxMXIGK9c5t8e7n86iN+OpF4UyRe/+Vt1c5XlcQmAIKOPXDnvBzwQ9UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825070; c=relaxed/simple;
	bh=H5f/jZNxtKdhBIogXkdiX/ObDwTOheRpqVofpkcPXJ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sDhMVJIgHz2Jftu2HlPmnMx2ZEaH6mCGR12V221C63l82b9qRtHpw0KGllq96dVlmruiYh05gKbkFlArV5SMY5hu9I5AjfRIjLP5l0E7RbUORLrir63v7mHp1Wl2HF9gbc2pgPn6ry8euK1wBhqDIpfVdduZO2HooIXCINz/rac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N0HisUZs; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N0HisUZs"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cceabd70f5so23054535ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 09:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784825065; x=1785429865; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/fguQcClVNog0VqgUtDPGk0XZ5rwJBQNhp6T1KiWiIo=;
        b=N0HisUZsa00khtGdJzGeN898FdAcryF28kpA6fG4PHCvp5a1lXtmgUVR8UdeE2TU+Z
         zP9zXwfFd3z8vkQ0zJUcd2yrgsGkb3mAYIujZqoByz2Ocg9445E0eeBUfrmgBW8QUDlg
         AJVJP4mVAYlQ1UGS5BoZhYcVyEdaB0xneIRrAtxBaABEdfz1ub0i89U+E6sVTfZTYnXV
         oORY6+Luga1hvWJ+xDXDxI6/sg3SbLmfYtu3VyUrkhoX+s/FnquqpLfA6i2GJE3onNLn
         87MhrYDRUcP5QJk0nh5bX1/H2e389Um+c7mt8GCN7LihzT2TAZfjG4DjJ2jQg9S70H0v
         NZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784825065; x=1785429865;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/fguQcClVNog0VqgUtDPGk0XZ5rwJBQNhp6T1KiWiIo=;
        b=EWbGu+UOd8ZX+PepbHeyrXyK6fgIrjyColDgpSQBCUMLBekHwaJW2b/fFstc9P3Clw
         o7Ykb2UpGa6PEc1bdWAykWs6JmnJtw4YHlGNp9n5QIrNjMViLdwNFbQR2OfzOOL2cF5n
         DPSSJ0eIZ5IazF0gCyukdY7BWba6CotqjSkO07XbzWdyKdTa4RFWP2LXGg1URr+NQXs8
         RWEHf55DwBHx7UKRrtS0nqMLsKOrbsErntotPmskpp/+Q7zBxkVh7L406CAFQ8VOn0iZ
         tl8p+EoII7VbxE+E9HxnmlghqD2G3QPrHIJWVxojmjg7Wa8s/+VnbJMaDdDpRedVluHn
         kjbg==
X-Forwarded-Encrypted: i=1; AHgh+Rr31g2NeodPDw9LzTzuA5VGfNUniSmynW8wGEwmxb3amjoCzKO0L1DqqaPwsqA8TBgaD+VpgO3aV4Wxsrr2b5lJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzzaDWAIHT0WvQqsdMvrccdf1HrWUxVJFyHPw9bOXsbzZZMKDjn
	mU0TvwGPkMJeteOgGTQ1/v1ceZoFCyGlahvb141oIdcgCygDkVaSwhnIp475JZHM5mW//9U+8LW
	AsOatMs6k1w==
X-Received: from dlbec11.prod.google.com ([2002:a05:7022:d8b:b0:13b:9ad0:582f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3489:b0:3c4:2eb6:c3a0
 with SMTP id adf61e73a8af0-3c44b00b782mr4077377637.30.1784825064672; Thu, 23
 Jul 2026 09:44:24 -0700 (PDT)
Date: Thu, 23 Jul 2026 09:44:21 -0700
In-Reply-To: <amGnWXQgP9Hu5xUT@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <amGnWXQgP9Hu5xUT@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723164421.1232688-1-irogers@google.com>
Subject: [PATCH v2] perf python: Clean up and restructure setup.py
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org, acme@kernel.org
Cc: adrian.hunter@intel.com, irogers@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
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
v2: Rebase
---
 tools/perf/util/setup.py | 248 ++++++++++++++++++++++++++-------------
 1 file changed, 164 insertions(+), 84 deletions(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index cb14554454a2..1385f07424b7 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -1,112 +1,192 @@
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
+        build_lib = os.getenv('PYTHON_EXTBUILD_LIB')
+        if build_lib:
+            self.build_dir = build_lib
 
     def run(self):
         _install_lib.run(self)
         shutil.copy2(f'{src_perf}/python/perf.pyi', self.install_dir)
 
 
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
2.55.0.229.g6434b31f56-goog

