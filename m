Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B3E367281
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967265; cv=none; b=DrLCLQlHaQNnfVA/rY5cDAoUAynT9fOdl+wh7MNmuv3NPDS7rGwO9P5NgyPrt/mhdEjwC+a9UNFd5lu9ocBAa3FDDLMqxBhLVMR0XMyODbHn5qhIjHvUD4RRI6TsB4ikcAgJGFE7bE0Sy85ls6SXEsT0T2OSYapcWGejx5xc9l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967265; c=relaxed/simple;
	bh=zDyCgKElJnJf2Xw0CW6H3IhwBe3zvdoC6phXFcQxMUc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lFaiGHYWpBw6noF3bUufEjFgYfdLOz2JznW4AdSZR8Qso85qEAFG4pCcolYwr70cMhUhfANtfNDJeuD9z5OsYqvrUAcz+2sH7+WFY1uNMZOPT5PUJsxJBo4Mt2xYNqBorVkWrCkm6GJvB1tJ4Wdk/Ywo78bxoNAioMqEA4N7FTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gjuU15zf; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjuU15zf"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbb92868263so2261658a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967262; x=1790572062; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5UJvx6m7Q3V8RaoRGo2HpSBYRSVuVzAgTOi+hsx2xco=;
        b=gjuU15zfYID1UtN6ysQPa4Cy8H2SYwLB0IEf4euIXMoH5nuyUhYzozXR5nLGViPNvi
         enD6v3rVTPgJLf6aZmei13hTz3KzCBIUeCcrfVBIukTAmUC8G51ELHDOBjw5tR3b+8Qr
         XRm6VpC7N3yY5+ZrSAv6ZYwRUFgNTQu9mF2Bx074rVopyMWXm19P0x0NZR+Ejkmlatqw
         E0YzCZY9zayy4QFif9XCvAIX3hpnjDyrxMhrxu8LSoEup/EtZWD+EoTUvuNj70ZuI/NC
         NDNsA8hpWwfd6CKug6H276n9H5P9Jsi42EAj1iy25WioNgJed1q3MypfXhdrDx6G2Nxu
         Kfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967262; x=1790572062;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5UJvx6m7Q3V8RaoRGo2HpSBYRSVuVzAgTOi+hsx2xco=;
        b=Tz4zwtEXR98gGt6oAUP0jn3/qfR+/ZA4J4WJySNayQ9T6DG6IBUkiE1+RKEs0GM1jJ
         bTjIpkCCRHoLnRrQ8LC7pU01vMtGSkGwJVDd720roJHGevTJTvR6qaNuXlWtue4kmyLV
         PgqUcuNrsO4eCa3fRdBBYzwndqVqS/r48kpqM1QyWCDaMG/l6d53R04U4KYYpOAq/qrF
         JMLcYkY00YfDYbRJT5jWHyruYSWOHJQoKRT+zLS7SLiejVeVqBDZk3U8TZYeQAiEyd4Y
         f7IJQ6mWRfNPF2R3EJHsUx7XuN5RsKD87ekEXYDTwUAJd6AmzFObTqwshs8ae3HMrTkc
         i9Tg==
X-Forwarded-Encrypted: i=1; AKwUvBy51baC7KtchkTp6DFxr6VBMr2sAQBIEes717iiSUnXZPZVH9CdmKLed5tERj0Y+uG/OWnkHfcoeE0adg9pcWZX@vger.kernel.org
X-Gm-Message-State: AFuF++l7oFTlnGtYImFcBRPyZqV4UHtaP4Y5Ac9G3agEmuxll8oNJ+Ko
	ghQ5mtgA5ycylde5N6SjBrn4+2aM3d/t5Jw3G365yjULDcilDQCYMR9lKsvC/SF9kCXKhS+187O
	wrigziw+5Dg==
X-Received: from dlbbq37.prod.google.com ([2002:a05:7022:6725:b0:143:8c20:9c79])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e584:b0:3d7:b3c1:cc34
 with SMTP id adf61e73a8af0-3dd8c41a56dmr12371323637.26.1789967262202; Sun, 20
 Sep 2026 22:07:42 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:30 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <bea01e4fc180d6e92361f034ca304033b319da97.1789966896.git.irogers@google.com>
Subject: [PATCH v2 12/49] perf test: Clean up mypy and pylint issues in shell
 test libraries
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Clean up mypy type errors and pylint errors/warnings in
tools/perf/tests/shell/lib/ (attr.py, perf_json_output_lint.py, and
perf_metric_validation.py):
- Fix E0606 (possibly-used-before-assignment) in perf_metric_validation.py
  by importing sys at module level.
- Add type annotations for stack, second_results, collectlist,
  get_bounds(),
  and main() in perf_metric_validation.py.
- Avoid assigning -1 to list[int] expected_items in
  perf_json_output_lint.py,
  rename shadowing variables, and remove redundant lambdas.
- Remove unnecessary semicolons, use lazy logging arguments, specify
  exception types and file encodings, and initialize module-level logger
  in attr.py.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/attr.py            | 86 ++++++++++---------
 .../tests/shell/lib/perf_json_output_lint.py  | 36 ++++----
 .../tests/shell/lib/perf_metric_validation.py | 47 +++++-----
 3 files changed, 85 insertions(+), 84 deletions(-)

diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index bfccc727d9b2..7f3d5b64b00d 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -12,6 +12,8 @@ import re
 import shutil
 import subprocess
 
+log = logging.getLogger('test')
+
 def data_equal(a, b):
     # Allow multiple values in assignment separated by '|'
     a_list = a.split('|')
@@ -89,19 +91,19 @@ class Event(dict):
 
     def add(self, data):
         for key, val in data:
-            log.debug("      %s = %s" % (key, val))
+            log.debug("      %s = %s", key, val)
             self[key] = val
 
     def __init__(self, name, data, base):
-        log.debug("    Event %s" % name);
-        self.name  = name;
+        log.debug("    Event %s", name)
+        self.name  = name
         self.group = ''
         self.add(base)
         self.add(data)
 
     def equal(self, other):
         for t in Event.terms:
-            log.debug("      [%s] %s %s" % (t, self[t], other[t]));
+            log.debug("      [%s] %s %s", t, self[t], other[t])
             if t not in self or t not in other:
                 return False
             if not data_equal(self[t], other[t]):
@@ -118,7 +120,7 @@ class Event(dict):
             if t not in self or t not in other:
                 continue
             if not data_equal(self[t], other[t]):
-                log.warning("expected %s=%s, got %s" % (t, self[t], other[t]))
+                log.warning("expected %s=%s, got %s", t, self[t], other[t])
 
 def parse_version(version):
     if not version:
@@ -149,7 +151,7 @@ class Test(object):
         parser = configparser.ConfigParser()
         parser.read(path)
 
-        log.warning("running '%s'" % path)
+        log.warning("running '%s'", path)
 
         self.path     = path
         self.test_dir = options.test_dir
@@ -159,15 +161,15 @@ class Test(object):
 
         try:
             self.ret  = parser.get('config', 'ret')
-        except:
+        except Exception:
             self.ret  = 0
 
         self.test_ret = parser.getboolean('config', 'test_ret', fallback=False)
 
         try:
             self.arch  = parser.get('config', 'arch')
-            log.warning("test limitation '%s'" % self.arch)
-        except:
+            log.warning("test limitation '%s'", self.arch)
+        except Exception:
             self.arch  = ''
 
         self.auxv = parser.get('config', 'auxv', fallback=None)
@@ -175,7 +177,7 @@ class Test(object):
         self.kernel_until = parse_version(parser.get('config', 'kernel_until', fallback=None))
         self.expect   = {}
         self.result   = {}
-        log.debug("  loading expected events");
+        log.debug("  loading expected events")
         self.load_events(path, self.expect)
 
     def is_event(self, name):
@@ -203,7 +205,7 @@ class Test(object):
             else:
                 try:
                     value = int(items[-1], 0)
-                except:
+                except ValueError:
                     value = items[-1]
             return (items[0], value)
 
@@ -227,7 +229,7 @@ class Test(object):
         # Handle negated list such as !s390x,ppc
         if arch_list[0][0] == '!':
             arch_list[0] = arch_list[0][1:]
-            log.warning("excluded architecture list %s" % arch_list)
+            log.warning("excluded architecture list %s", arch_list)
             for arch_item in arch_list:
                 # log.warning("test for %s arch is %s" % (arch_item, myarch))
                 if arch_item == myarch:
@@ -243,19 +245,19 @@ class Test(object):
     def restore_sample_rate(self, value=10000):
         try:
             # Check value of sample_rate
-            with open("/proc/sys/kernel/perf_event_max_sample_rate", "r") as fIn:
+            with open("/proc/sys/kernel/perf_event_max_sample_rate", "r", encoding="utf-8") as fIn:
                 curr_value = fIn.readline()
             # If too low restore to reasonable value
             if not curr_value or int(curr_value) < int(value):
-                with open("/proc/sys/kernel/perf_event_max_sample_rate", "w") as fOut:
+                with open("/proc/sys/kernel/perf_event_max_sample_rate", "w", encoding="utf-8") as fOut:
                     fOut.write(str(value))
 
         except IOError as e:
-            log.warning("couldn't restore sample_rate value: I/O error %s" % e)
+            log.warning("couldn't restore sample_rate value: I/O error %s", e)
         except ValueError as e:
-            log.warning("couldn't restore sample_rate value: Value error %s" % e)
+            log.warning("couldn't restore sample_rate value: Value error %s", e)
         except TypeError as e:
-            log.warning("couldn't restore sample_rate value: Type error %s" % e)
+            log.warning("couldn't restore sample_rate value: Type error %s", e)
 
     def load_events(self, path, events):
         parser_event = configparser.ConfigParser()
@@ -266,7 +268,7 @@ class Test(object):
         # event' first as a base
         for section in filter(self.is_event, parser_event.sections()):
 
-            parser_items = parser_event.items(section);
+            parser_items = parser_event.items(section)
             base_items   = {}
 
             # Read parent event if there's any
@@ -280,7 +282,7 @@ class Test(object):
             events[section] = e
 
     def run_cmd(self, tempdir):
-        junk1, junk2, junk3, junk4, myarch = (os.uname())
+        _junk1, _junk2, _junk3, _junk4, myarch = (os.uname())
 
         if self.skip_test_arch(myarch):
             raise Notest(self, myarch)
@@ -299,7 +301,7 @@ class Test(object):
               self.perf, self.command, tempdir, self.args)
         ret = os.WEXITSTATUS(os.system(cmd))
 
-        log.info("  '%s' ret '%s', expected '%s'" % (cmd, str(ret), str(self.ret)))
+        log.info("  '%s' ret '%s', expected '%s'", cmd, str(ret), str(self.ret))
 
         if not data_equal(str(ret), str(self.ret)):
             if self.test_ret:
@@ -310,34 +312,34 @@ class Test(object):
     def compare(self, expect, result):
         match = {}
 
-        log.debug("  compare");
+        log.debug("  compare")
 
         # For each expected event find all matching
         # events in result. Fail if there's not any.
         for exp_name, exp_event in expect.items():
             exp_list = []
             res_event = {}
-            log.debug("    matching [%s]" % exp_name)
+            log.debug("    matching [%s]", exp_name)
             for res_name, res_event in result.items():
-                log.debug("      to [%s]" % res_name)
+                log.debug("      to [%s]", res_name)
                 if (exp_event.equal(res_event)):
                     exp_list.append(res_name)
                     log.debug("    ->OK")
                 else:
-                    log.debug("    ->FAIL");
+                    log.debug("    ->FAIL")
 
-            log.debug("    match: [%s] matches %s" % (exp_name, str(exp_list)))
+            log.debug("    match: [%s] matches %s", exp_name, str(exp_list))
 
             # we did not any matching event - fail
             if not exp_list:
                 if exp_event.optional():
-                    log.debug("    %s does not match, but is optional" % exp_name)
+                    log.debug("    %s does not match, but is optional", exp_name)
                 else:
                     if not res_event:
-                        log.debug("    res_event is empty");
+                        log.debug("    res_event is empty")
                     else:
                         exp_event.diff(res_event)
-                    raise Fail(self, 'match failure');
+                    raise Fail(self, 'match failure')
 
             match[exp_name] = exp_list
 
@@ -354,38 +356,38 @@ class Test(object):
                 if res_group not in match[group]:
                     raise Fail(self, 'group failure')
 
-                log.debug("    group: [%s] matches group leader %s" %
-                         (exp_name, str(match[group])))
+                log.debug("    group: [%s] matches group leader %s",
+                          exp_name, str(match[group]))
 
         log.debug("  matched")
 
     def resolve_groups(self, events):
         for name, event in events.items():
-            group_fd = event['group_fd'];
+            group_fd = event['group_fd']
             if group_fd == '-1':
-                continue;
+                continue
 
             for iname, ievent in events.items():
                 if (ievent['fd'] == group_fd):
                     event.group = iname
-                    log.debug('[%s] has group leader [%s]' % (name, iname))
-                    break;
+                    log.debug('[%s] has group leader [%s]', name, iname)
+                    break
 
     def run(self):
-        tempdir = tempfile.mkdtemp();
+        tempdir = tempfile.mkdtemp()
 
         try:
             # run the test script
-            self.run_cmd(tempdir);
+            self.run_cmd(tempdir)
 
             # load events expectation for the test
-            log.debug("  loading result events");
+            log.debug("  loading result events")
             for f in glob.glob(tempdir + '/event*'):
-                self.load_events(f, self.result);
+                self.load_events(f, self.result)
 
             # resolve group_fd to event names
-            self.resolve_groups(self.expect);
-            self.resolve_groups(self.result);
+            self.resolve_groups(self.expect)
+            self.resolve_groups(self.result)
 
             # do the expectation - results matching - both ways
             self.compare(self.expect, self.result)
@@ -401,9 +403,9 @@ def run_tests(options):
         try:
             Test(f, options).run()
         except Unsup as obj:
-            log.warning("unsupp  %s" % obj.getMsg())
+            log.warning("unsupp  %s", obj.getMsg())
         except Notest as obj:
-            log.warning("skipped %s" % obj.getMsg())
+            log.warning("skipped %s", obj.getMsg())
 
 def setup_log(verbose):
     global log
diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index dafbde56cc76..8cde22ac9d97 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -46,46 +46,46 @@ def is_counter_value(num):
 def is_metric_value(num):
   return isfloat(num) or num == 'none'
 
-def check_json_output(expected_items):
+def check_json_output(expected_count):
   checks = {
-      'counters': lambda x: isfloat(x),
+      'counters': isfloat,
       'core': lambda x: True,
-      'counter-value': lambda x: is_counter_value(x),
+      'counter-value': is_counter_value,
       'cgroup': lambda x: True,
-      'cpu': lambda x: isint(x),
+      'cpu': isint,
       'cache': lambda x: True,
       'cluster': lambda x: True,
       'die': lambda x: True,
       'event': lambda x: True,
-      'event-runtime': lambda x: isfloat(x),
-      'interval': lambda x: isfloat(x),
+      'event-runtime': isfloat,
+      'interval': isfloat,
       'metric-unit': lambda x: True,
-      'metric-value': lambda x: is_metric_value(x),
+      'metric-value': is_metric_value,
       'metric-threshold': lambda x: x in ['unknown', 'good', 'less good', 'nearly bad', 'bad'],
       'metricgroup': lambda x: True,
       'node': lambda x: True,
-      'pcnt-running': lambda x: isfloat(x),
+      'pcnt-running': isfloat,
       'socket': lambda x: True,
       'thread': lambda x: True,
       'unit': lambda x: True,
   }
-  input = '[\n' + ','.join(Lines) + '\n]'
-  for item in json.loads(input):
-    if expected_items != -1:
+  json_input = '[\n' + ','.join(Lines) + '\n]'
+  for item in json.loads(json_input):
+    if expected_count:
       count = len(item)
-      if count not in expected_items and count >= 1 and count <= 7 and 'metric-value' in item:
+      if count not in expected_count and count >= 1 and count <= 7 and 'metric-value' in item:
         # Events that generate >1 metric may have isolated metric
         # values and possibly other prefixes like interval, core,
         # counters, or event-runtime/pcnt-running from multiplexing.
         pass
-      elif count not in expected_items and count >= 1 and count <= 5 and 'metricgroup' in item:
+      elif count not in expected_count and count >= 1 and count <= 5 and 'metricgroup' in item:
         pass
-      elif count - 1 in expected_items and 'metric-threshold' in item:
+      elif count - 1 in expected_count and 'metric-threshold' in item:
           pass
-      elif count in expected_items and 'insn per cycle' in item:
+      elif count in expected_count and 'insn per cycle' in item:
           pass
-      elif count not in expected_items:
-        raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
+      elif count not in expected_count:
+        raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_count}'
                            f' in \'{item}\'')
     for key, value in item.items():
       if key not in checks:
@@ -107,7 +107,7 @@ try:
     expected_items = [1, 2]
   else:
     # If no option is specified, don't check the number of items.
-    expected_items = -1
+    expected_items = []
   check_json_output(expected_items)
 except:
   print('Test failed for input:\n' + '\n'.join(Lines))
diff --git a/tools/perf/tests/shell/lib/perf_metric_validation.py b/tools/perf/tests/shell/lib/perf_metric_validation.py
index 3d52f94f22b9..0508c98d84fd 100644
--- a/tools/perf/tests/shell/lib/perf_metric_validation.py
+++ b/tools/perf/tests/shell/lib/perf_metric_validation.py
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
-import re
-import csv
-import json
 import argparse
+import json
 from pathlib import Path
 import subprocess
+import sys
+from typing import Any
 
 
 class TestError:
@@ -77,11 +77,11 @@ class Validator:
 
     def read_json(self, filename: str) -> dict:
         try:
-            with open(Path(filename).resolve(), "r") as f:
+            with open(Path(filename).resolve(), "r", encoding="utf-8") as f:
                 data = json.loads(f.read())
         except OSError as e:
             print(f"Error when reading file {e}")
-            sys.exit()
+            sys.exit(1)
 
         return data
 
@@ -90,16 +90,16 @@ class Validator:
         if not parent.exists():
             parent.mkdir(parents=True)
 
-        with open(output_file, "w+") as output_file:
+        with open(output_file, "w+", encoding="utf-8") as out_f:
             json.dump(data,
-                      output_file,
+                      out_f,
                       ensure_ascii=True,
                       indent=4)
 
     def get_results(self, idx: int = 0):
         return self.results.get(idx)
 
-    def get_bounds(self, lb, ub, error, alias={}, ridx: int = 0) -> list:
+    def get_bounds(self, lb, ub, error, alias=None, ridx: int = 0) -> tuple:
         """
         Get bounds and tolerance from lb, ub, and error.
         If missing lb, use 0.0; missing ub, use float('inf); missing error, use self.tolerance.
@@ -111,6 +111,9 @@ class Validator:
                   upper bound, return -1 if the upper bound is a metric value and is not collected
                   tolerance, denormalized base on upper bound value
         """
+        if alias is None:
+            alias = {}
+
         # init ubv and lbv to invalid values
         def get_bound_value(bound, initval, ridx):
             val = initval
@@ -213,7 +216,7 @@ class Validator:
         @param alias: the dict has alias to metric name mapping
         @returns: value of the formula is success; -1 if the one or more metric value not provided
         """
-        stack = []
+        stack: list[Any] = []
         b = 0
         errs = []
         sign = "+"
@@ -263,7 +266,7 @@ class Validator:
             alias[m['Alias']] = m['Name']
         lbv, ubv, t = self.get_bounds(
             rule['RangeLower'], rule['RangeUpper'], rule['ErrorThreshold'], alias, ridx=rule['RuleIndex'])
-        val, f = self.evaluate_formula(
+        val, _ = self.evaluate_formula(
             rule['Formula'], alias, ridx=rule['RuleIndex'])
 
         lb = rule['RangeLower']
@@ -316,7 +319,7 @@ class Validator:
                 rerun.append(m['Name'])
 
         if len(rerun) > 0 and len(rerun) < 20:
-            second_results = dict()
+            second_results: dict[Any, Any] = dict()
             self.second_test(rerun, second_results)
             for name, val in second_results.items():
                 if name not in failures:
@@ -373,7 +376,7 @@ class Validator:
                     name = result["metric-unit"].split("  ")[1] if len(result["metric-unit"].split("  ")) > 1 \
                         else result["metric-unit"]
                     metricvalues[name.lower()] = float(result["metric-value"])
-            except ValueError as error:
+            except ValueError:
                 continue
         return
 
@@ -383,7 +386,7 @@ class Validator:
         wl = workload.split()
         command.extend(wl)
         print(" ".join(command))
-        cmd = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, encoding='utf-8')
+        cmd = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, encoding='utf-8', check=False)
         lines = cmd.stderr.splitlines() + cmd.stdout.splitlines()
         data = []
         for line in lines:
@@ -397,9 +400,9 @@ class Validator:
         Collect metric data with "perf stat -M" on given workload with -a and -j.
         """
         self.results = dict()
-        print(f"Starting perf collection")
+        print("Starting perf collection")
         print(f"Long workload: {workload}")
-        collectlist = dict()
+        collectlist: dict[int, Any] = dict()
         if self.collectlist != "":
             collectlist[0] = {x for x in self.collectlist.split(",")}
         else:
@@ -441,7 +444,7 @@ class Validator:
         """
         command = ['perf', 'list', '-j', '--details', 'metrics']
         cmd = subprocess.run(command, stdout=subprocess.PIPE,
-                             stderr=subprocess.PIPE, encoding='utf-8')
+                             stderr=subprocess.PIPE, encoding='utf-8', check=False)
         try:
             data = json.loads(cmd.stdout)
             for m in data:
@@ -454,9 +457,9 @@ class Validator:
                 self.metrics.add(name)
                 if 'ScaleUnit' in m and (m['ScaleUnit'] == '1%' or m['ScaleUnit'] == '100%'):
                     self.pctgmetrics.add(name.lower())
-        except ValueError as error:
-            print(f"Error when parsing metric data")
-            sys.exit()
+        except ValueError:
+            print("Error when parsing metric data")
+            sys.exit(1)
 
         return
 
@@ -519,9 +522,6 @@ class Validator:
 
     # Initialize data structures before data validation of each workload
     def _init_data(self):
-
-        testtypes = ['PositiveValueTest',
-                     'RelationshipTest', 'SingleMetricTest']
         self.results = dict()
         self.ignoremetrics = set()
         self.errlist = list()
@@ -572,7 +572,7 @@ class Validator:
 # End of Class Validator
 
 
-def main() -> None:
+def main() -> int:
     parser = argparse.ArgumentParser(
         description="Launch metric value validation")
 
@@ -602,5 +602,4 @@ def main() -> None:
 
 
 if __name__ == "__main__":
-    import sys
     sys.exit(main())
-- 
2.55.0.1082.g2b9226bbc0-goog

