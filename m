Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF035443AAF;
	Fri, 16 Oct 2026 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185723; cv=none; b=pLLtL42EScKpnY7YEmmYJCsdUGPkleJ6TwuaUd7+jMfX2f7zxHDk5OFMLykRaUL7FOQKdmtfYpTCQI4C3DBmbG/jVKP8tkcnWGd1eQT0mrEHdyWGrd0hcuLpJWH5LXMkHXLuWVwfP6vclo9RJYH42rk0UwgJ+GiJA3QtER4Fyg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185723; c=relaxed/simple;
	bh=t7w3rIBGsa4Af3BZ8BHHddD2vNJkW/osDtGG+N2YRBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/1a+OrBk3Ir2SRt4O0CTqYSpxtyE/ZRq/mmrBS3g667P6eSCifWMPsmt/6MfsjzDsA+UikWU8SzJnwc/sVFlmh3/faL+jpe4vyMW27ecSLhdkOOFuxlj/JzchfymzsKnNrfuehUf1EZUn9/lbOuKPKvXX5l8Nf7CTtGNcPy/tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKpGL1X8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKpGL1X8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113AF1F000C4;
	Fri, 16 Oct 2026 21:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185721;
	bh=9BtvQL0SqR3j9LZTwodMHPKREEH5LQ5EKL3EypBf02s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OKpGL1X8rhu+yByjUkXn+ccMp31BC65/wXOUm63GEPWy8Dtm1wA88YDfF3NDgzrZd
	 IVsL4lMEdHsEObearOXoJtp1sWKvo+Z5o2lu/sGSIxbVtiCh6cDNWJnaLUhMLxb0J4
	 MA//+CT1qPzxQNc6sVTS+hB/l9v0XMuyldPdlUQk0bbImD45pCcV9AXg0IvUeyZ3s1
	 4WDf97V0s20j3eJukc8H6LJaQA+kFVdeKZvo0BSLPu8+RCiMZvPMoJM8DHiWxd4e3g
	 VPqCelFvNkmp//LynBdXmYH+0Mqwf0H0KWkRjhWSCJqdHTlh0gGBihrZncywuzbZlR
	 s3lULMGsn2X2w==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v4 16/21] perf test attr: State, spelled out in a line, why a test is skipped
Date: Fri, 16 Oct 2026 18:20:57 -0300
Message-ID: <20261016212102.76550-17-acme@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016212102.76550-1-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Per skip the default output shows a self contained one liner:

  unsupp  'test-record-branch-filter-any' exit 255, expected 1, no attrs recorded to verify
  skipped [kernel newer than 6.12] 'test-record-group-sampling'
  skipped [arch = !aarch64, machine = aarch64] 'test-record-graph-default'

The extra notes explaining the reason, with a copy pasteable command to
observe the failure, come in the very same stream when the verbosity is
bumped, at -vvv, nothing is written to a separate place for later
consultation, it is just the logging ladder:

  detail: '/root/bin/perf record -o /dev/null --no-bpf-event -j any kill'
  exited with 255, the expectations want the workload's 1 exit, so there
  are no attrs recorded to verify; this is normally a capability problem,
  run '/root/bin/perf record -o /dev/null --no-bpf-event -j any kill' to
  see why

Note that 'perf test -v/-vv/-vvv attribute' appends a single -v to the
shell test entry (shell_test__run()), so to see the notes one runs the
python module directly, f.i.:

  python3 tests/shell/lib/attr.py -vvv -d tests/shell/attr -p ./perf

The skip functions now return the reason fragment when they want to skip
and None when the test can go on.

The command suggested to observe the failure writes to /dev/null, so it
doesn't leave a perf.data in the directory it is run from.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/attr.py | 106 +++++++++++++++++++----------
 1 file changed, 70 insertions(+), 36 deletions(-)

diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index 09ee496b4947f470..df1993883199866c 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -223,17 +223,20 @@ class Fail(Exception):
         return '\'%s\' - %s' % (self.test.path, self.msg)
 
 class Notest(Exception):
-    def __init__(self, test, arch):
-        self.arch = arch
+    def __init__(self, test, reason):
+        self.reason = reason
         self.test = test
     def getMsg(self):
-        return '[%s] \'%s\'' % (self.arch, self.test.path)
+        return '[%s] \'%s\'' % (self.reason, self.test.path)
 
 class Unsup(Exception):
-    def __init__(self, test):
+    def __init__(self, test, ret, expected):
         self.test = test
+        self.ret = ret
+        self.expected = expected
     def getMsg(self):
-        return '\'%s\'' % self.test.path
+        return '\'%s\' exit %d, expected %s, no attrs recorded to verify' % (
+            self.test.path, self.ret, self.expected)
 
 class Event(dict):
     terms = [
@@ -391,6 +394,9 @@ def parse_version(version):
         return None
     return [int(v) for v in version.split(".")[0:2]]
 
+def format_version(version):
+    return ".".join(str(v) for v in version)
+
 # Test file description needs to have following sections:
 # [config]
 #   - just single instance in file
@@ -456,13 +462,17 @@ class Test(object):
 
     def skip_test_kernel_since(self):
         if not self.kernel_since:
-            return False
-        return not self.kernel_since <= parse_version(platform.release())
+            return None
+        if self.kernel_since <= parse_version(platform.release()):
+            return None
+        return "kernel older than %s" % format_version(self.kernel_since)
 
     def skip_test_kernel_until(self):
         if not self.kernel_until:
-            return False
-        return not parse_version(platform.release()) < self.kernel_until
+            return None
+        if parse_version(platform.release()) < self.kernel_until:
+            return None
+        return "kernel newer than %s" % format_version(self.kernel_until)
 
     def skip_test_auxv(self):
         def new_auxv(a, pattern):
@@ -478,18 +488,20 @@ class Test(object):
             return (items[0], value)
 
         if not self.auxv:
-            return False
+            return None
         auxv = subprocess.check_output("LD_SHOW_AUXV=1 sleep 0", shell=True) \
                .decode(sys.stdout.encoding)
         pattern = re.compile(r"[: ]+")
         auxv = dict([new_auxv(a, pattern) for a in auxv.splitlines()])
-        return not eval(self.auxv)
+        if eval(self.auxv):
+            return None
+
+        return "the auxv condition doesn't hold here"
 
     def skip_test_arch(self, myarch):
         # If architecture not set always run test
         if self.arch == '':
-            # log.warning("test for arch %s is ok" % myarch)
-            return False
+            return None
 
         # Allow multiple values in assignment separated by ','
         arch_list = self.arch.split(',')
@@ -499,27 +511,26 @@ class Test(object):
             arch_list[0] = arch_list[0][1:]
             log.warning("excluded architecture list %s", arch_list)
             for arch_item in arch_list:
-                # log.warning("test for %s arch is %s" % (arch_item, myarch))
                 if arch_item == myarch:
-                    return True
-            return False
+                    return "arch = %s, machine = %s" % (self.arch, myarch)
+            return None
 
         for arch_item in arch_list:
-            # log.warning("test for architecture '%s' current '%s'" % (arch_item, myarch))
             if arch_item == myarch:
-                return False
-        return True
+                return None
+
+        return "arch = %s, machine = %s" % (self.arch, myarch)
 
     def skip_test_requires(self):
         for requirement in filter(None, map(str.strip, self.requires.split(','))):
             if requirement == 'core-pmu':
                 if not core_pmu_available():
                     log.warning("test limitation 'requires %s'", requirement)
-                    return True
+                    return "needs a core PMU, none here"
             else:
                 log.warning("unknown requirement '%s', ignored", requirement)
 
-        return False
+        return None
 
     def restore_sample_rate(self, value=10000):
         try:
@@ -563,20 +574,36 @@ class Test(object):
     def run_cmd(self, tempdir):
         _junk1, _junk2, _junk3, _junk4, myarch = (os.uname())
 
-        if self.skip_test_arch(myarch):
-            raise Notest(self, myarch)
-
-        if self.skip_test_auxv():
-            raise Notest(self, "auxv skip")
-
-        if self.skip_test_kernel_since():
-            raise Notest(self, "old kernel skip")
-
-        if self.skip_test_kernel_until():
-            raise Notest(self, "new kernel skip")
-
-        if self.skip_test_requires():
-            raise Notest(self, "requirements skip")
+        arch = self.skip_test_arch(myarch)
+        if arch:
+            log.debug("  detail: the test file has arch = %s, the machine reports %s",
+                     self.arch, myarch)
+            raise Notest(self, arch)
+
+        auxv = self.skip_test_auxv()
+        if auxv:
+            log.debug("  detail: the auxv condition %s doesn't hold, the bits come "
+                     "from the LD_SHOW_AUXV=1 output", self.auxv)
+            raise Notest(self, auxv)
+
+        kernel = self.skip_test_kernel_since()
+        if kernel:
+            log.debug("  detail: the test file's kernel_since = %s, this kernel is %s",
+                     format_version(self.kernel_since), platform.release())
+            raise Notest(self, kernel)
+
+        kernel = self.skip_test_kernel_until()
+        if kernel:
+            log.debug("  detail: the test file's kernel_until = %s, this kernel is %s",
+                     format_version(self.kernel_until), platform.release())
+            raise Notest(self, kernel)
+
+        requirement = self.skip_test_requires()
+        if requirement:
+            log.debug("  detail: requires core-pmu, nothing countable here, check "
+                     "kernel.perf_event_paranoid and the PMU nodes under "
+                     "/sys/bus/event_source/")
+            raise Notest(self, requirement)
 
         self.restore_sample_rate()
         cmd = "PERF_TEST_ATTR=%s %s %s -o %s/perf.data %s" % (tempdir,
@@ -586,10 +613,17 @@ class Test(object):
         log.info("  '%s' ret '%s', expected '%s'", cmd, str(ret), str(self.ret))
 
         if not data_equal(str(ret), str(self.ret)):
+            plain_cmd = "%s %s -o /dev/null %s" % (
+                self.perf, self.command,
+                self.args.split('>/dev/null')[0].rstrip())
             if self.test_ret:
                 raise Fail(self, "Perf exit code failure")
             else:
-                raise Unsup(self)
+                log.debug("  detail: '%s' exited with %d, the expectations want the "
+                         "workload's %s exit, so there are no attrs recorded to "
+                         "verify; this is normally a capability problem, run '%s' "
+                         "to see why", plain_cmd, ret, self.ret, plain_cmd)
+                raise Unsup(self, ret, str(self.ret))
 
     def drop_dummy_tracking_events(self):
         """
-- 
2.55.0

