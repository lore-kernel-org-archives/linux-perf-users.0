Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB20B27B343;
	Fri, 16 Oct 2026 00:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109970; cv=none; b=QeD7NNSIHVxPpX8LYjlE7BkpG2ffEG/yf6tYeFnGurjZUXYdFs00JV9I3MkideMqiSsrbTmihWNkMQ2FB+c+ZjgQ8vnYxkO9I5vZ+br8LcUygJwrV53uXyomi+BpY0SYTn5jxxXpUMxMhIEGVtMs+re6/EgtyGWUp3e4U0VxGgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109970; c=relaxed/simple;
	bh=AJRC/EJP26R7GP9341+2au/mlOjOmKMx+JihA0+IYZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnEqjK7H/Z4jeobtjtMoiw7CIwMAJXJmDRFI+46SVtw9TsdqnZq8ZSrzY3cpWq4/bTcz0lMcBSOAeGEJnz7QpBh3NnJpMhoHvQFfG24OD2TJvNPjPLfLhhykrvQxyVYK0fLYzUvAKjYIt3aOSrDlfKRyJAUhUC37cY1kwS9UvL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQ25lL5R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQ25lL5R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360E01F000C4;
	Fri, 16 Oct 2026 00:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109968;
	bh=kFW/ZHgq36LhTL8ozzccEPjsajTBwUO3CppyGfOhoxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iQ25lL5RQVYzCbRd/hctoausG2FDzrBl/yLIgiVqQw5ME9JznXcy0Rwi6uGRPMbRi
	 wDmJLtNainVBG4BRGAKT5b8FVTwfOlgQ7VNxhdPaqcy3QyzWOwpKmy9D8cwSZgUBzv
	 snoMTZO9RlEru3lpzl0V1qR6d8QZwwZiiu2s8/uEvKs9T6kABC8ABPFWOnPanZienu
	 /+llyIp+E56Pp2/ISzoM9/ue/9/2sdZKVDTv3FU5tZhVnzD0lBi3+XNbifRTgTJiu9
	 QhsqUrhauEV1/U2M3avaxodeFvV27UgmOpiBfSkrdsFW854yxC0XjVWeswFxk2z74X
	 aMQ2CbYj3X2mQ==
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
Subject: [PATCH v3 14/19] perf test attr: State, spelled out in a line, why a test is skipped
Date: Thu, 15 Oct 2026 21:18:38 -0300
Message-ID: <20261016001843.71978-15-acme@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016001843.71978-1-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
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
index ef1e29f96cc418e4..a42e890ed73efc90 100644
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
@@ -385,6 +388,9 @@ def parse_version(version):
         return None
     return [int(v) for v in version.split(".")[0:2]]
 
+def format_version(version):
+    return ".".join(str(v) for v in version)
+
 # Test file description needs to have following sections:
 # [config]
 #   - just single instance in file
@@ -450,13 +456,17 @@ class Test(object):
 
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
@@ -472,18 +482,20 @@ class Test(object):
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
@@ -493,27 +505,26 @@ class Test(object):
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
@@ -557,20 +568,36 @@ class Test(object):
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
@@ -580,10 +607,17 @@ class Test(object):
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

