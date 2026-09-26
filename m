Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7D3B388A
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403760; cv=none; b=ITCFpWoQEk2zmOqhTmzuVnS+TzOEMO4WbrrXB0nFmUuynkcdcjaScMz1Bd/N+oirjQWF7MrKbM0e2SEe0iMpClnJ274NE+9okE26LIH8dKowoQUx+B1cx5d37grVOJQe9mSZpunD2yZ27FLd7ncwAo6SUcshtnePhKRsiUCXLR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403760; c=relaxed/simple;
	bh=Fn4HfE4LXHMfTtTLpJjzDvhXcHBAw1JVyBLCM3fp7w8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g0d+dk4wyzBIKZNJ+VJoHNe9ucgJWv/jgwmx3R5as/8lArxw12DypFgVle8WzjR6U1dYjyCc8tZ2jsyyvm1dz+Yf30JKh1vxdmaG+aNAU5iSi1dCMdBnpgS9uYlY3SqchZHkdjR1Cdk24ukIGhPXht0bPZxBQhWu2mse8ffFQZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bKrnLkWY; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bKrnLkWY"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c0d568830so3398642eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403750; x=1791008550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7aETo/PbKZvLc1JqCT1gG0U1TbH1v1geqKkkF0V8FiQ=;
        b=bKrnLkWY/Z/yaNBivfk602/L5FIGs52/lLuy4BF8/20Ovy8NCYmxy66mUmP//xXjFj
         a5kRfUM5JcmcHOqjptK3V/NZKrlXt1+0aItLv0qB93dFMXJDowwLZ1utX81rmj1nh6mc
         P27LPa1OonWXgDs19Ukt+xS4TawHEsZZXr8tAnKPU5rL6G/c8zGfCX4j9nFOzBcGFuLz
         ood8RsSDd80ZQ8Utg0cbl35bRjfna+4DshDucmTpy5omlpPge8jrSo4eXJQwlyOHA9MR
         bFAkJVHPJjrEcuVwrtGXYgDOjAtjxCdoWST6ZKl8LHkvBlyhjYUivtM3UvVTCNf01C3X
         cv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403750; x=1791008550;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7aETo/PbKZvLc1JqCT1gG0U1TbH1v1geqKkkF0V8FiQ=;
        b=0eJRK6xcrX5MEjWp+LatgJAELATayxqQyzxIkSrLim302WT0wPr2MUwnPxSg4MjBvQ
         LwRHkhHtsHVha74tKIwmCAPhgKOC4PU7/Vz8LprbAA+Jw2y9jIDZlHfq69oaGKXHvSGw
         k9fU8mdbULG71cG7aTMgSSz2mHxh0r3+lK1QjFLymtwn2gA1bRyGhjcXhcEL3J00PLoa
         bBkXchHTFOMiKO675mw/YWc9y9ThmwtiHLKqCaNcj8+jlDR0JLU7c2StCBSZpZ6y/miF
         jcrSp7ivi1qLYADdrk549z1GNFeiZf8cmyHM+XVyHIuItvkjZdwpxpkyBVfelUlx7o/D
         cHKw==
X-Forwarded-Encrypted: i=1; AKwUvBzFtguAEp630EfxxK/q+pxmrh52WsYJ5eRWw3n3MK1YdtEzzCewuvsPZu/fbRdUHQRhKCqPmB9nYtolcncDlpBf@vger.kernel.org
X-Gm-Message-State: AFuF++nViA7TvsCKHIYorNdnqzNSyIg7CY0Oj0WIfLiejGviMp4ShiDb
	9enw/SLI9rjpWxXqcT5WBOUF6GMLfsO1INADsCZpEdANVWTPfGC4vWQ8ngOvk0BvA1bBtkK5mbx
	5rVRP6QVuvw==
X-Received: from dlag22.prod.google.com ([2002:a05:701b:2516:b0:143:7cf0:d45a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4588:20b0:145:541:a346
 with SMTP id a92af1059eb24-146d0c50c0cmr1822645c88.46.1790403749838; Fri, 25
 Sep 2026 23:22:29 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:20:12 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-46-irogers@google.com>
Subject: [PATCH v4 45/49] perf python: Move and clean up parallel-perf.py
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Move parallel-perf.py from tools/perf/scripts/python/ to
tools/perf/python/ as it is a standalone Python utility that invokes
'perf script' in parallel across time slices and CPUs. Update
tools/perf/tests/shell/script.sh accordingly.

Also fix bugs and clean up the script to pass mypy and pylint without
suppression comments:
- Fix Work.command() to return the shlex.quote()-escaped command string
  (previously sh_cmd was computed with shlex.quote() and discarded in
  favor of unquoted self.cmd).
- Close self.popen.stdout in the parent process after spawning the
  consumer subprocess in Work.start() when --pipe-to is used, ensuring
  the producer receives SIGPIPE if the consumer exits early and avoiding
  leaking the pipe file descriptor.
- Convert method and function names to snake_case, specify utf-8 file
  encodings, and add type annotations and docstrings.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/parallel-perf.py         | 1250 ++++++++++++++++++++
 tools/perf/scripts/python/parallel-perf.py |  989 ----------------
 tools/perf/tests/shell/script.sh           |    4 +-
 3 files changed, 1252 insertions(+), 991 deletions(-)
 create mode 100755 tools/perf/python/parallel-perf.py
 delete mode 100755 tools/perf/scripts/python/parallel-perf.py

diff --git a/tools/perf/python/parallel-perf.py b/tools/perf/python/paralle=
l-perf.py
new file mode 100755
index 000000000000..a43b003634fd
--- /dev/null
+++ b/tools/perf/python/parallel-perf.py
@@ -0,0 +1,1250 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Parallel perf script."""
+#
+# run a perf script command multiple times in parallel, using perf script
+# options --cpu and --time so that each job processes a different chunk
+# of the data.
+#
+# Copyright (c) 2024, Intel Corporation.
+
+import subprocess
+import argparse
+import pathlib
+import shlex
+import time
+from typing import Any
+import copy
+import sys
+import os
+import re
+
+glb_prog_name =3D "parallel-perf.py"
+glb_min_interval =3D 10.0
+glb_min_samples =3D 64
+
+
+class Verbosity():
+
+    def __init__(self, quiet: bool =3D False, verbose: bool =3D False,
+                 debug: bool =3D False) -> None:
+        """__init__."""
+
+        self.normal =3D True
+        self.verbose =3D verbose
+        self.debug =3D debug
+        self.self_test =3D True
+        if self.debug:
+            self.verbose =3D True
+        if self.verbose:
+            quiet =3D False
+        if quiet:
+            self.normal =3D False
+
+# Manage work (start/wait/kill), as represented by a subprocess.Popen comm=
and
+
+
+class Work():
+
+    def __init__(self, cmd: list[str], pipe_to: str,
+                 output_dir: str =3D ".") -> None:
+        """__init__."""
+
+        self.popen: Any =3D None
+        self.consumer: Any =3D None
+        self.cmd =3D cmd
+        self.pipe_to =3D pipe_to
+        self.output_dir =3D output_dir
+        self.cmdout_name =3D f"{output_dir}/cmd.txt"
+        self.stdout_name =3D f"{output_dir}/out.txt"
+        self.stderr_name =3D f"{output_dir}/err.txt"
+
+    def command(self):
+        """command."""
+
+        return " ".join(shlex.quote(x) for x in self.cmd)
+
+    def stdout(self):
+        """stdout."""
+
+        return open(self.stdout_name, "w", encoding=3D"utf-8")
+
+    def stderr(self):
+        """stderr."""
+
+        return open(self.stderr_name, "w", encoding=3D"utf-8")
+
+    def create_output_dir(self):
+        """create_output_dir."""
+
+        pathlib.Path(self.output_dir).mkdir(parents=3DTrue, exist_ok=3DTru=
e)
+
+    def start(self):
+        """start."""
+
+        if self.popen:
+            return
+        self.create_output_dir()
+        with open(self.cmdout_name, "w", encoding=3D"utf-8") as f:
+            f.write(self.command())
+            f.write("\n")
+        stdout =3D self.stdout()
+        stderr =3D self.stderr()
+        if self.pipe_to:
+            self.popen =3D subprocess.Popen(
+                self.cmd, stdout=3Dsubprocess.PIPE, stderr=3Dstderr)
+            args =3D shlex.split(self.pipe_to)
+            self.consumer =3D subprocess.Popen(
+                args, stdin=3Dself.popen.stdout, stdout=3Dstdout, stderr=
=3Dstderr)
+            # The consumer now owns the read end of the pipe. Close this
+            # process's copy so that the producer receives SIGPIPE if the
+            # consumer exits early, and so that the descriptor isn't leake=
d
+            # for the lifetime of this Work.
+            self.popen.stdout.close()
+            self.popen.stdout =3D None
+        else:
+            self.popen =3D subprocess.Popen(
+                self.cmd, stdout=3Dstdout, stderr=3Dstderr)
+
+    def remove_empty_err_file(self):
+        """remove_empty_err_file."""
+
+        if os.path.exists(self.stderr_name):
+            if os.path.getsize(self.stderr_name) =3D=3D 0:
+                os.unlink(self.stderr_name)
+
+    def errors(self):
+        """errors."""
+
+        if os.path.exists(self.stderr_name):
+            if os.path.getsize(self.stderr_name) !=3D 0:
+                return [f"Non-empty error file {self.stderr_name}"]
+        return []
+
+    def tidy_up(self):
+        """tidy_up."""
+
+        self.remove_empty_err_file()
+
+    def raw_poll_wait(self, p, wait):
+        """raw_poll_wait."""
+
+        if wait:
+            return p.wait()
+        return p.poll()
+
+    def poll(self, wait=3DFalse):
+        """poll."""
+
+        if not self.popen:
+            return None
+        result =3D self.raw_poll_wait(self.popen, wait)
+        if self.consumer:
+            res =3D result
+            result =3D self.raw_poll_wait(self.consumer, wait)
+            if result is not None and res is None:
+                self.popen.kill()
+                result =3D None
+            elif result =3D=3D 0 and res is not None and res !=3D 0:
+                result =3D res
+        if result is not None:
+            self.tidy_up()
+        return result
+
+    def wait(self):
+        """wait."""
+
+        return self.poll(wait=3DTrue)
+
+    def kill(self):
+        """kill."""
+
+        if not self.popen:
+            return
+        self.popen.kill()
+        if self.consumer:
+            self.consumer.kill()
+
+
+def kill_work(worklist, _verbosity):
+    """kill_work."""
+
+    for w in worklist:
+        w.kill()
+    for w in worklist:
+        w.wait()
+
+
+def number_of_cp_us():
+    """number_of_cp_us."""
+
+    return os.sysconf("SC_NPROCESSORS_ONLN")
+
+
+def nano_secs_to_secs_str(x):
+    """nano_secs_to_secs_str."""
+
+    if x is None:
+        return ""
+    x =3D str(x)
+    if len(x) < 10:
+        x =3D "0" * (10 - len(x)) + x
+    return x[:len(x) - 9] + "." + x[-9:]
+
+
+def insert_option_after(cmd, option, after):
+    """insert_option_after."""
+
+    try:
+        pos =3D cmd.index(after)
+        cmd.insert(pos + 1, option)
+    except (OSError, ValueError, RuntimeError):
+        cmd.append(option)
+
+
+def create_work_list(cmd, pipe_to, output_dir, cpus, time_ranges_by_cpu):
+    """create_work_list."""
+
+    max_len =3D len(str(cpus[-1]))
+    cpu_dir_fmt =3D f"cpu-%.{max_len}u"
+    worklist =3D []
+    pos =3D 0
+    for cpu in cpus:
+        if cpu >=3D 0:
+            cpu_dir =3D os.path.join(output_dir, cpu_dir_fmt % cpu)
+            cpu_option =3D f"--cpu=3D{cpu}"
+        else:
+            cpu_dir =3D output_dir
+            cpu_option =3D None
+
+        tr_dir_fmt =3D "time-range"
+
+        if len(time_ranges_by_cpu) > 1:
+            time_ranges =3D time_ranges_by_cpu[pos]
+            tr_dir_fmt +=3D f"-{pos}"
+            pos +=3D 1
+        else:
+            time_ranges =3D time_ranges_by_cpu[0]
+
+        max_len =3D len(str(len(time_ranges)))
+        tr_dir_fmt +=3D f"-%.{max_len}u"
+
+        i =3D 0
+        for r in time_ranges:
+            if r =3D=3D [None, None]:
+                time_option =3D None
+                work_output_dir =3D cpu_dir
+            else:
+                time_option =3D "--time=3D" + \
+                    nano_secs_to_secs_str(r[0]) + "," + \
+                    nano_secs_to_secs_str(r[1])
+                work_output_dir =3D os.path.join(cpu_dir, tr_dir_fmt % i)
+                i +=3D 1
+            work_cmd =3D list(cmd)
+            if time_option is not None:
+                insert_option_after(work_cmd, time_option, "script")
+            if cpu_option is not None:
+                insert_option_after(work_cmd, cpu_option, "script")
+            w =3D Work(work_cmd, pipe_to, work_output_dir)
+            worklist.append(w)
+    return worklist
+
+
+def do_run_work(worklist: list[Work], nr_jobs: int,
+                _verbosity: Verbosity) -> bool:
+    """do_run_work."""
+
+    nr_to_do =3D len(worklist)
+    not_started =3D list(worklist)
+    running: list[Work] =3D []
+    done: list[Work] =3D []
+    chg =3D False
+    while True:
+        nr_done =3D len(done)
+        if chg and _verbosity.normal:
+            nr_run =3D len(running)
+            print(
+                f"\rThere are {nr_to_do} jobs: {nr_done} completed, {nr_ru=
n} running",
+                flush=3DTrue, end=3D" ")
+            if _verbosity.verbose:
+                print()
+            chg =3D False
+        if nr_done =3D=3D nr_to_do:
+            break
+        while len(running) < nr_jobs and len(not_started):
+            w =3D not_started.pop(0)
+            running.append(w)
+            if _verbosity.verbose:
+                print("Starting:", w.command())
+            w.start()
+            chg =3D True
+        if len(running):
+            time.sleep(0.1)
+        finished: list[Work] =3D []
+        not_finished: list[Work] =3D []
+        while len(running):
+            w =3D running.pop(0)
+            r =3D w.poll()
+            if r is None:
+                not_finished.append(w)
+                continue
+            if r =3D=3D 0:
+                if _verbosity.verbose:
+                    print("Finished:", w.command())
+                finished.append(w)
+                chg =3D True
+                continue
+            if _verbosity.normal and not _verbosity.verbose:
+                print()
+            print("Job failed!\n    return code:", r,
+                  "\n    command:    ", w.command())
+            if w.pipe_to:
+                print("    piped to:   ", w.pipe_to)
+            print("Killing outstanding jobs")
+            kill_work(not_finished, _verbosity)
+            kill_work(running, _verbosity)
+            return False
+        running =3D not_finished
+        done +=3D finished
+    errorlist: list[str] =3D []
+    for w in worklist:
+        errorlist +=3D w.errors()
+    if len(errorlist):
+        print("errors:")
+        for e in errorlist:
+            print(e)
+    elif _verbosity.normal:
+        print("\r", " "*50, "\rAll jobs finished successfully", flush=3DTr=
ue)
+    return True
+
+
+def run_work(worklist: list[Work], nr_jobs: int =3D number_of_cp_us(),
+             _verbosity: Verbosity =3D Verbosity()) -> bool:
+    """run_work."""
+    try:
+        return do_run_work(worklist, nr_jobs, _verbosity)
+    except BaseException:
+        for w in worklist:
+            w.kill()
+        raise
+
+
+def read_header(perf, file_name):
+    """read_header."""
+
+    cmd =3D [perf, "script", "--header-only", "--input", file_name]
+    with subprocess.Popen(cmd, stdout=3Dsubprocess.PIPE) as proc:
+        out =3D proc.stdout.read() if proc.stdout else b""
+    return out.decode("utf-8")
+
+
+def parse_header(hdr):
+    """parse_header."""
+
+    result =3D {}
+    lines =3D hdr.split("\n")
+    for line in lines:
+        if ":" in line and line[0] =3D=3D "#":
+            pos =3D line.index(":")
+            name =3D line[1:pos-1].strip()
+            value =3D line[pos+1:].strip()
+            if name in result:
+                orig_name =3D name
+                nr =3D 2
+                while True:
+                    name =3D f"{orig_name} {nr}"
+                    if name not in result:
+                        break
+                    nr +=3D 1
+            result[name] =3D value
+    return result
+
+
+def header_field(hdr_dict, hdr_fld):
+    """header_field."""
+
+    if hdr_fld not in hdr_dict:
+        raise RuntimeError(f"'{hdr_fld}' missing from header information")
+    return hdr_dict[hdr_fld]
+
+# Represent the position of an option within a command string
+# and provide the option value and/or remove the option
+
+
+class OptPos():
+
+    def init(self, opt_element=3D-1, value_element=3D-1, opt_pos=3D-1, val=
ue_pos=3D-1, error=3DNone):
+        """init."""
+
+        self.opt_element =3D opt_element		# list element that contains opt=
ion
+        self.value_element =3D value_element  # list element that contains=
 option value
+        self.opt_pos =3D opt_pos			# string position of option
+        self.value_pos =3D value_pos		# string position of value
+        self.error =3D error			# error message string
+
+    def __init__(self, args, short_name, long_name, default=3DNone):
+        """__init__."""
+
+        self.args =3D list(args)
+        self.default =3D default
+        n =3D 2 + len(long_name)
+        m =3D len(short_name)
+        pos =3D -1
+        for opt in args:
+            pos +=3D 1
+            if m and opt[:2] =3D=3D f"-{short_name}":
+                if len(opt) =3D=3D 2:
+                    if pos + 1 < len(args):
+                        self.init(pos, pos + 1, 0, 0)
+                    else:
+                        self.init(error=3Df"-{short_name} option missing v=
alue")
+                else:
+                    self.init(pos, pos, 0, 2)
+                return
+            if opt[:n] =3D=3D f"--{long_name}":
+                if len(opt) =3D=3D n:
+                    if pos + 1 < len(args):
+                        self.init(pos, pos + 1, 0, 0)
+                    else:
+                        self.init(error=3Df"--{long_name} option missing v=
alue")
+                elif opt[n] =3D=3D "=3D":
+                    self.init(pos, pos, 0, n + 1)
+                else:
+                    self.init(error=3Df"--{long_name} option expected '=3D=
'")
+                return
+            if m and opt[:1] =3D=3D "-" and opt[:2] !=3D "--" and short_na=
me in opt:
+                ipos =3D opt.index(short_name)
+                if "-" in opt[1:]:
+                    hpos =3D opt[1:].index("-")
+                    if hpos < ipos:
+                        continue
+                if ipos + 1 =3D=3D len(opt):
+                    if pos + 1 < len(args):
+                        self.init(pos, pos + 1, ipos, 0)
+                    else:
+                        self.init(error=3Df"-{short_name} option missing v=
alue")
+                else:
+                    self.init(pos, pos, ipos, ipos + 1)
+                return
+        self.init()
+
+    def value(self):
+        """value."""
+
+        if self.opt_element >=3D 0:
+            if self.opt_element !=3D self.value_element:
+                return self.args[self.value_element]
+            else:
+                return self.args[self.value_element][self.value_pos:]
+        return self.default
+
+    def remove(self, args):
+        """remove."""
+
+        if self.opt_element =3D=3D -1:
+            return
+        if self.opt_element !=3D self.value_element:
+            del args[self.value_element]
+        if self.opt_pos:
+            args[self.opt_element] =3D args[self.opt_element][:self.opt_po=
s]
+        else:
+            del args[self.opt_element]
+
+
+def determine_input_file_name(cmd):
+    """determine_input_file_name."""
+
+    p =3D OptPos(cmd, "i", "input", "perf.data")
+    if p.error:
+        raise RuntimeError(f"perf command {p.error}")
+    file_name =3D p.value()
+    if not os.path.exists(file_name):
+        raise RuntimeError(f"perf command input file '{file_name}' not fou=
nd")
+    return file_name
+
+
+def read_option(args, short_name, long_name, err_prefix, remove=3DFalse):
+    """read_option."""
+
+    p =3D OptPos(args, short_name, long_name)
+    if p.error:
+        raise RuntimeError(f"{err_prefix}{p.error}")
+    value =3D p.value()
+    if remove:
+        p.remove(args)
+    return value
+
+
+def extract_option(args, short_name, long_name, err_prefix):
+    """extract_option."""
+
+    return read_option(args, short_name, long_name, err_prefix, True)
+
+
+def read_perf_option(args, short_name, long_name):
+    """read_perf_option."""
+
+    return read_option(args, short_name, long_name, "perf command ")
+
+
+def extract_perf_option(args, short_name, long_name):
+    """extract_perf_option."""
+
+    return extract_option(args, short_name, long_name, "perf command ")
+
+
+def perf_double_quick_commands(cmd, file_name):
+    """perf_double_quick_commands."""
+
+    cpu_str =3D read_perf_option(cmd, "C", "cpu")
+    time_str =3D read_perf_option(cmd, "", "time")
+    # Use double-quick sampling to determine trace data density
+    times_cmd =3D ["perf", "script", "--ns",
+                 "--input", file_name, "--itrace=3Dqqi"]
+    if cpu_str is not None and cpu_str !=3D "":
+        times_cmd.append(f"--cpu=3D{cpu_str}")
+    if time_str is not None and time_str !=3D "":
+        times_cmd.append(f"--time=3D{time_str}")
+    cnts_cmd =3D list(times_cmd)
+    cnts_cmd.append("-Fcpu")
+    times_cmd.append("-Fcpu,time")
+    return cnts_cmd, times_cmd
+
+
+class CPUTimeRange():
+    def __init__(self, cpu):
+        """__init__."""
+
+        self.cpu =3D cpu
+        self.sample_cnt =3D 0
+        self.time_ranges =3D None
+        self.interval =3D 0
+        self.interval_remaining =3D 0
+        self.remaining =3D 0
+        self.tr_pos =3D 0
+
+
+def calc_time_ranges_by_cpu(line, cpu, cpu_time_ranges, max_time):
+    """calc_time_ranges_by_cpu."""
+
+    cpu_time_range =3D cpu_time_ranges[cpu]
+    cpu_time_range.remaining -=3D 1
+    cpu_time_range.interval_remaining -=3D 1
+    if cpu_time_range.remaining =3D=3D 0:
+        cpu_time_range.time_ranges[cpu_time_range.tr_pos][1] =3D max_time
+        return
+    if cpu_time_range.interval_remaining =3D=3D 0:
+        ts =3D time_val(line[1][:-1], 0)
+        time_ranges =3D cpu_time_range.time_ranges
+        time_ranges[cpu_time_range.tr_pos][1] =3D ts - 1
+        time_ranges.append([ts, max_time])
+        cpu_time_range.tr_pos +=3D 1
+        cpu_time_range.interval_remaining =3D cpu_time_range.interval
+
+
+def count_samples_by_cpu(_line: list[str], cpu: int,
+                         cpu_time_ranges: list[Any]) -> None:
+    """count_samples_by_cpu."""
+
+    try:
+        cpu_time_ranges[cpu].sample_cnt +=3D 1
+    except (OSError, ValueError, RuntimeError, IndexError):
+        print("exception")
+        print("cpu", cpu)
+        print("len(cpu_time_ranges)", len(cpu_time_ranges))
+        raise
+
+
+def process_command_output_lines(cmd, per_cpu, fn, *x):
+    """process_command_output_lines."""
+
+    # Assume CPU number is at beginning of line and enclosed by []
+    pat =3D re.compile(r"\s*\[[0-9]+\]")
+    p =3D subprocess.Popen(cmd, stdout=3Dsubprocess.PIPE)
+    while True:
+        line =3D p.stdout.readline()
+        if line:
+            line =3D line.decode("utf-8")
+            if pat.match(line):
+                line =3D line.split()
+                if per_cpu:
+                    # Assumes CPU number is enclosed by []
+                    cpu =3D int(line[0][1:-1])
+                else:
+                    cpu =3D 0
+                fn(line, cpu, *x)
+        else:
+            break
+    p.wait()
+
+
+def intersect_time_ranges(new_time_ranges, time_ranges):
+    """intersect_time_ranges."""
+
+    pos =3D 0
+    new_pos =3D 0
+    # Can assume len(time_ranges) !=3D 0 and len(new_time_ranges) !=3D 0
+    # Note also, there *must* be at least one intersection.
+    while pos < len(time_ranges) and new_pos < len(new_time_ranges):
+        # new end < old start =3D> no intersection, remove new
+        if new_time_ranges[new_pos][1] < time_ranges[pos][0]:
+            del new_time_ranges[new_pos]
+            continue
+        # new start > old end =3D> no intersection, check next
+        if new_time_ranges[new_pos][0] > time_ranges[pos][1]:
+            pos +=3D 1
+            if pos < len(time_ranges):
+                continue
+            # no next, so remove remaining
+            while new_pos < len(new_time_ranges):
+                del new_time_ranges[new_pos]
+            return
+        # Found an intersection
+        # new start < old start =3D> adjust new start =3D old start
+        if new_time_ranges[new_pos][0] < time_ranges[pos][0]:
+            new_time_ranges[new_pos][0] =3D time_ranges[pos][0]
+        # new end > old end =3D> keep the overlap, insert the remainder
+        if new_time_ranges[new_pos][1] > time_ranges[pos][1]:
+            r =3D [time_ranges[pos][1] + 1, new_time_ranges[new_pos][1]]
+            new_time_ranges[new_pos][1] =3D time_ranges[pos][1]
+            new_pos +=3D 1
+            new_time_ranges.insert(new_pos, r)
+            continue
+        # new [start, end] is within old [start, end]
+        new_pos +=3D 1
+
+
+def split_time_ranges_by_trace_data_density(
+    time_ranges, cpus, nr, cmd, file_name, per_cpu, min_size, min_interval=
, _verbosity
+):
+    """split_time_ranges_by_trace_data_density."""
+
+    if _verbosity.normal:
+        print("\rAnalyzing...", flush=3DTrue, end=3D" ")
+        if _verbosity.verbose:
+            print()
+    cnts_cmd, times_cmd =3D perf_double_quick_commands(cmd, file_name)
+
+    nr_cpus =3D cpus[-1] + 1 if per_cpu else 1
+    if per_cpu:
+        nr_cpus =3D cpus[-1] + 1
+        cpu_time_ranges =3D [CPUTimeRange(cpu) for cpu in range(nr_cpus)]
+    else:
+        nr_cpus =3D 1
+        cpu_time_ranges =3D [CPUTimeRange(-1)]
+
+    if _verbosity.debug:
+        print("nr_cpus", nr_cpus)
+        print("cnts_cmd", cnts_cmd)
+        print("times_cmd", times_cmd)
+
+    # Count the number of "double quick" samples per CPU
+    process_command_output_lines(
+        cnts_cmd, per_cpu, count_samples_by_cpu, cpu_time_ranges)
+
+    tot =3D 0
+    mx =3D 0
+    for cpu_time_range in cpu_time_ranges:
+        cnt =3D cpu_time_range.sample_cnt
+        tot +=3D cnt
+        if cnt > mx:
+            mx =3D cnt
+        if _verbosity.debug:
+            print("cpu:", cpu_time_range.cpu, "sample_cnt", cnt)
+
+    if min_size < 1:
+        min_size =3D 1
+
+    if mx < min_size:
+        # Too little data to be worth splitting
+        if _verbosity.debug:
+            print("Too little data to split by time")
+        if nr =3D=3D 0:
+            nr =3D 1
+        return [split_time_ranges_into_n(time_ranges, nr, min_interval)]
+
+    if nr:
+        divisor =3D nr
+        min_size =3D 1
+    else:
+        divisor =3D number_of_cp_us()
+
+    interval =3D int(round(tot / divisor, 0))
+    if interval < min_size:
+        interval =3D min_size
+
+    if _verbosity.debug:
+        print("divisor", divisor)
+        print("min_size", min_size)
+        print("interval", interval)
+
+    min_time =3D time_ranges[0][0]
+    max_time =3D time_ranges[-1][1]
+
+    for cpu_time_range in cpu_time_ranges:
+        cnt =3D cpu_time_range.sample_cnt
+        if cnt =3D=3D 0:
+            cpu_time_range.time_ranges =3D copy.deepcopy(time_ranges)
+            continue
+        # Adjust target interval for CPU to give approximately equal inter=
val sizes
+        # Determine number of intervals, rounding to nearest integer
+        n =3D int(round(cnt / interval, 0))
+        if n < 1:
+            n =3D 1
+        # Determine interval size, rounding up
+        d, m =3D divmod(cnt, n)
+        if m:
+            d +=3D 1
+        cpu_time_range.interval =3D d
+        cpu_time_range.interval_remaining =3D d
+        cpu_time_range.remaining =3D cnt
+        # init. time ranges for each CPU with the start time
+        cpu_time_range.time_ranges =3D [[min_time, max_time]]
+
+    # Set time ranges so that the same number of "double quick" samples
+    # will fall into each time range.
+    process_command_output_lines(
+        times_cmd, per_cpu, calc_time_ranges_by_cpu, cpu_time_ranges, max_=
time)
+
+    for cpu_time_range in cpu_time_ranges:
+        if cpu_time_range.sample_cnt:
+            intersect_time_ranges(cpu_time_range.time_ranges, time_ranges)
+
+    return [cpu_time_ranges[cpu].time_ranges for cpu in cpus]
+
+
+def split_single_time_range_into_n(time_range, n):
+    """split_single_time_range_into_n."""
+
+    if n <=3D 1:
+        return [time_range]
+    start =3D time_range[0]
+    end =3D time_range[1]
+    duration =3D int((end - start + 1) / n)
+    if duration < 1:
+        return [time_range]
+    time_ranges =3D []
+    for _i in range(n):
+        time_ranges.append([start, start + duration - 1])
+        start +=3D duration
+    time_ranges[-1][1] =3D end
+    return time_ranges
+
+
+def time_range_duration(r):
+    """time_range_duration."""
+
+    return r[1] - r[0] + 1
+
+
+def total_duration(time_ranges):
+    """total_duration."""
+
+    duration =3D 0
+    for r in time_ranges:
+        duration +=3D time_range_duration(r)
+    return duration
+
+
+def split_time_ranges_by_interval(time_ranges, interval):
+    """split_time_ranges_by_interval."""
+
+    new_ranges =3D []
+    for r in time_ranges:
+        duration =3D time_range_duration(r)
+        n =3D duration / interval
+        n =3D int(round(n, 0))
+        new_ranges +=3D split_single_time_range_into_n(r, n)
+    return new_ranges
+
+
+def split_time_ranges_into_n(time_ranges, n, min_interval):
+    """split_time_ranges_into_n."""
+
+    if n <=3D len(time_ranges):
+        return time_ranges
+    duration =3D total_duration(time_ranges)
+    interval =3D duration / n
+    if interval < min_interval:
+        interval =3D min_interval
+    return split_time_ranges_by_interval(time_ranges, interval)
+
+
+def recombine_time_ranges(tr):
+    """recombine_time_ranges."""
+
+    new_tr =3D copy.deepcopy(tr)
+    i =3D 1
+    while i < len(new_tr):
+        # if prev end + 1 =3D=3D cur start, combine them
+        if new_tr[i - 1][1] + 1 =3D=3D new_tr[i][0]:
+            new_tr[i][0] =3D new_tr[i - 1][0]
+            del new_tr[i - 1]
+        else:
+            i +=3D 1
+    return new_tr
+
+
+def open_time_range_ends(time_ranges, min_time, max_time):
+    """open_time_range_ends."""
+
+    if time_ranges[0][0] <=3D min_time:
+        time_ranges[0][0] =3D None
+    if time_ranges[-1][1] >=3D max_time:
+        time_ranges[-1][1] =3D None
+
+
+def bad_time_str(time_str):
+    """bad_time_str."""
+
+    raise RuntimeError(
+        f"perf command bad time option: '{time_str}'\n"
+        "Check also 'time of first sample' and 'time of last sample' "
+        "in perf script --header-only"
+    )
+
+
+def validate_time_ranges(time_ranges, time_str):
+    """validate_time_ranges."""
+
+    n =3D len(time_ranges)
+    for i in range(n):
+        start =3D time_ranges[i][0]
+        end =3D time_ranges[i][1]
+        if i !=3D 0 and start <=3D time_ranges[i - 1][1]:
+            bad_time_str(time_str)
+        if start > end:
+            bad_time_str(time_str)
+
+
+def time_val(s, dflt):
+    """time_val."""
+
+    s =3D s.strip()
+    if s =3D=3D "":
+        return dflt
+    a =3D s.split(".")
+    if len(a) > 2:
+        raise RuntimeError(f"Bad time value'{s}'")
+    x =3D int(a[0])
+    if x < 0:
+        raise RuntimeError("Negative time not allowed")
+    x *=3D 1000000000
+    if len(a) > 1:
+        x +=3D int((a[1] + "000000000")[:9])
+    return x
+
+
+def bad_cpu_str(cpu_str):
+    """bad_cpu_str."""
+
+    raise RuntimeError(
+        f"perf command bad cpu option: '{cpu_str}'\n"
+        "Check also 'nrcpus avail' in perf script --header-only"
+    )
+
+
+def parse_time_str(time_str, min_time, max_time):
+    """parse_time_str."""
+
+    if time_str is None or time_str =3D=3D "":
+        return [[min_time, max_time]]
+    time_ranges =3D []
+    for r in time_str.split():
+        a =3D r.split(",")
+        if len(a) !=3D 2:
+            bad_time_str(time_str)
+        try:
+            start =3D time_val(a[0], min_time)
+            end =3D time_val(a[1], max_time)
+        except (OSError, ValueError, RuntimeError):
+            bad_time_str(time_str)
+        time_ranges.append([start, end])
+    validate_time_ranges(time_ranges, time_str)
+    return time_ranges
+
+
+def parse_cpu_str(cpu_str, nr_cpus):
+    """parse_cpu_str."""
+
+    if cpu_str is None or cpu_str =3D=3D "":
+        return [-1]
+    cpus =3D []
+    for r in cpu_str.split(","):
+        a =3D r.split("-")
+        if len(a) < 1 or len(a) > 2:
+            bad_cpu_str(cpu_str)
+        try:
+            start =3D int(a[0].strip())
+            if len(a) > 1:
+                end =3D int(a[1].strip())
+            else:
+                end =3D start
+        except (OSError, ValueError, RuntimeError):
+            bad_cpu_str(cpu_str)
+        if start < 0 or end < 0 or end < start or end >=3D nr_cpus:
+            bad_cpu_str(cpu_str)
+        cpus.extend(range(start, end + 1))
+    cpus =3D list(set(cpus))  # remove duplicates
+    cpus.sort()
+    return cpus
+
+
+class ParallelPerf():
+
+    def __init__(self, a):
+        """init."""
+        self.nr =3D 0
+        self.jobs =3D 0
+        self.file_name =3D None
+        self.hdr =3D None
+        self.hdr_dict =3D None
+        self.cmd_line =3D None
+        self.min_time =3D None
+        self.max_time =3D None
+        self.time_str =3D None
+        self.time_ranges =3D None
+        self.cpu_str =3D None
+        self.cpus =3D None
+        self.split_time_ranges_for_each_cpu =3D None
+        self.worklist =3D None
+        self.per_cpu =3D None
+        self.interval =3D None
+        self.min_size =3D None
+        self.min_interval =3D None
+        self.pipe_to =3D None
+        self.output_dir =3D None
+        self.cmd =3D getattr(a, 'cmd', None)
+        self.no_per_cpu =3D getattr(a, 'no_per_cpu', False)
+        self.dry_run =3D getattr(a, 'dry_run', False)
+        self._verbosity =3D getattr(a, "_verbosity", Verbosity())
+
+        for arg_name in vars(a):
+            setattr(self, arg_name, getattr(a, arg_name))
+        self.orig_nr =3D self.nr
+        self.orig_cmd =3D list(self.cmd)
+        self.perf =3D self.cmd[0]
+        if os.path.exists(self.output_dir):
+            raise RuntimeError(f"Output '{self.output_dir}' already exists=
")
+        if self.jobs < 0 or self.nr < 0 or self.interval < 0:
+            raise RuntimeError(
+                "Bad options (negative values): try -h option for help")
+        if self.nr !=3D 0 and self.interval !=3D 0:
+            raise RuntimeError(
+                "Cannot specify number of time subdivisions and time inter=
val")
+        if self.jobs =3D=3D 0:
+            self.jobs =3D number_of_cp_us()
+        if self.nr =3D=3D 0 and self.interval =3D=3D 0:
+            if self.per_cpu:
+                self.nr =3D 1
+            else:
+                self.nr =3D self.jobs
+
+    def init(self):
+        """init."""
+
+        if self._verbosity.debug:
+            print("cmd", self.cmd)
+        self.file_name =3D determine_input_file_name(self.cmd)
+        self.hdr =3D read_header(self.perf, self.file_name)
+        self.hdr_dict =3D parse_header(self.hdr)
+        self.cmd_line =3D header_field(self.hdr_dict, "cmdline")
+
+    def extract_time_info(self):
+        """extract_time_info."""
+
+        self.min_time =3D time_val(header_field(
+            self.hdr_dict, "time of first sample"), 0)
+        self.max_time =3D time_val(header_field(
+            self.hdr_dict, "time of last sample"), 0)
+        self.time_str =3D extract_perf_option(self.cmd, "", "time")
+        self.time_ranges =3D parse_time_str(
+            self.time_str, self.min_time, self.max_time)
+        if self._verbosity.debug:
+            print("time_ranges", self.time_ranges)
+
+    def extract_cpu_info(self):
+        """extract_cpu_info."""
+
+        if self.per_cpu:
+            nr_cpus =3D int(header_field(self.hdr_dict, "nrcpus avail"))
+            self.cpu_str =3D extract_perf_option(self.cmd, "C", "cpu")
+            if self.cpu_str is None or self.cpu_str =3D=3D "":
+                self.cpus =3D [x for x in range(nr_cpus)]
+            else:
+                self.cpus =3D parse_cpu_str(self.cpu_str, nr_cpus)
+        else:
+            self.cpu_str =3D None
+            self.cpus =3D [-1]
+        if self._verbosity.debug:
+            print("cpus", self.cpus)
+
+    def is_intel_pt(self):
+        """is_intel_pt."""
+
+        return self.cmd_line.find("intel_pt") >=3D 0
+
+    def split_time_ranges(self):
+        """split_time_ranges."""
+
+        if self.is_intel_pt() and self.interval =3D=3D 0:
+            self.split_time_ranges_for_each_cpu =3D (
+                split_time_ranges_by_trace_data_density(
+                    self.time_ranges, self.cpus, self.orig_nr,
+                    self.orig_cmd, self.file_name, self.per_cpu,
+                    self.min_size, self.min_interval, self._verbosity
+                )
+            )
+        elif self.nr:
+            self.split_time_ranges_for_each_cpu =3D [split_time_ranges_int=
o_n(
+                self.time_ranges, self.nr, self.min_interval)]
+        else:
+            self.split_time_ranges_for_each_cpu =3D [
+                split_time_ranges_by_interval(self.time_ranges, self.inter=
val)]
+
+    def check_time_ranges(self):
+        """check_time_ranges."""
+
+        for tr in self.split_time_ranges_for_each_cpu:
+            # Re-combined time ranges should be the same
+            new_tr =3D recombine_time_ranges(tr)
+            if new_tr !=3D self.time_ranges:
+                if self._verbosity.debug:
+                    print("tr", tr)
+                    print("new_tr", new_tr)
+                raise RuntimeError("Self test failed!")
+
+    def open_time_range_ends(self):
+        """open_time_range_ends."""
+
+        for time_ranges in self.split_time_ranges_for_each_cpu:
+            open_time_range_ends(time_ranges, self.min_time, self.max_time=
)
+
+    def create_work_list(self):
+        """create_work_list."""
+
+        self.worklist =3D create_work_list(
+            self.cmd, self.pipe_to, self.output_dir, self.cpus, self.split=
_time_ranges_for_each_cpu)
+
+    def perf_data_recorded_per_cpu(self):
+        """perf_data_recorded_per_cpu."""
+
+        if "--per-thread" in self.cmd_line.split():
+            return False
+        return True
+
+    def default_to_per_cpu(self):
+        """default_to_per_cpu."""
+
+        # --no-per-cpu option takes precedence
+        if self.no_per_cpu:
+            return False
+        if not self.perf_data_recorded_per_cpu():
+            return False
+        # Default to per-cpu for Intel PT data that was recorded per-cpu,
+        # because decoding can be done for each CPU separately.
+        if self.is_intel_pt():
+            return True
+        return False
+
+    def config(self):
+        """config."""
+
+        self.init()
+        self.extract_time_info()
+        if not self.per_cpu:
+            self.per_cpu =3D self.default_to_per_cpu()
+        if self._verbosity.debug:
+            print("per_cpu", self.per_cpu)
+        self.extract_cpu_info()
+        self.split_time_ranges()
+        if self._verbosity.self_test:
+            self.check_time_ranges()
+        # Prefer open-ended time range to starting / ending with min_time =
/ max_time resp.
+        self.open_time_range_ends()
+        self.create_work_list()
+
+    def run(self):
+        """run."""
+
+        if self.dry_run:
+            print(len(self.worklist), "jobs:")
+            for w in self.worklist:
+                print(w.command())
+            return True
+        result =3D run_work(self.worklist, self.jobs, _verbosity=3Dself._v=
erbosity)
+        if self._verbosity.verbose:
+            print(glb_prog_name, "done")
+        return result
+
+
+def run_parallel_perf(a):
+    """run_parallel_perf."""
+
+    pp =3D ParallelPerf(a)
+    pp.config()
+    return pp.run()
+
+
+def main(args):
+    """main."""
+
+    ap =3D argparse.ArgumentParser(
+            prog=3Dglb_prog_name, formatter_class=3Dargparse.RawDescriptio=
nHelpFormatter,
+            description=3D"""
+run a perf script command multiple times in parallel, using perf script op=
tions
+--cpu and --time so that each job processes a different chunk of the data.
+""",
+            epilog=3D"""
+Follow the options by '--' and then the perf script command e.g.
+
+	$ perf record -a -- sleep 10
+	$ parallel-perf.py --nr=3D4 -- perf script --ns
+	All jobs finished successfully
+	$ tree parallel-perf-output/
+	parallel-perf-output/
+	=E2=94=9C=E2=94=80=E2=94=80 time-range-0
+	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
+	=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 out.txt
+	=E2=94=9C=E2=94=80=E2=94=80 time-range-1
+	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
+	=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 out.txt
+	=E2=94=9C=E2=94=80=E2=94=80 time-range-2
+	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
+	=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 out.txt
+	=E2=94=94=E2=94=80=E2=94=80 time-range-3
+	    =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
+	    =E2=94=94=E2=94=80=E2=94=80 out.txt
+	$ find parallel-perf-output -name cmd.txt | sort | xargs grep -H .
+	parallel-perf-output/time-range-0/cmd.txt:perf script --time=3D,9466.5044=
61499 --ns
+	parallel-perf-output/time-range-1/cmd.txt:perf script --time=3D9466.50446=
1500,9469.005396999 --ns
+	parallel-perf-output/time-range-2/cmd.txt:perf script --time=3D9469.00539=
7000,9471.506332499 --ns
+	parallel-perf-output/time-range-3/cmd.txt:perf script --time=3D9471.50633=
2500, --ns
+
+Any perf script command can be used, including the use of perf script opti=
ons
+--dlfilter and --script, so that the benefit of running parallel jobs
+naturally extends to them also.
+
+If option --pipe-to is used, standard output is first piped through that
+command. Beware, if the command fails (e.g. grep with no matches), it will=
 be
+considered a fatal error.
+
+Final standard output is redirected to files named out.txt in separate
+subdirectories under the output directory. Similarly, standard error is
+written to files named err.txt. In addition, files named cmd.txt contain t=
he
+corresponding perf script command. After processing, err.txt files are rem=
oved
+if they are empty.
+
+If any job exits with a non-zero exit code, then all jobs are killed and n=
o
+more are started. A message is printed if any job results in a non-empty
+err.txt file.
+
+There is a separate output subdirectory for each time range. If the --per-=
cpu
+option is used, these are further grouped under cpu-n subdirectories, e.g.
+
+	$ parallel-perf.py --per-cpu --nr=3D2 -- perf script --ns --cpu=3D0,1
+	All jobs finished successfully
+	$ tree parallel-perf-output
+	parallel-perf-output/
+	=E2=94=9C=E2=94=80=E2=94=80 cpu-0
+	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 time-range-0
+	=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 c=
md.txt
+	=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 o=
ut.txt
+	=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 time-range-1
+	=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
+	=E2=94=82=C2=A0=C2=A0     =E2=94=94=E2=94=80=E2=94=80 out.txt
+	=E2=94=94=E2=94=80=E2=94=80 cpu-1
+	    =E2=94=9C=E2=94=80=E2=94=80 time-range-0
+	    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
+	    =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 out.txt
+	    =E2=94=94=E2=94=80=E2=94=80 time-range-1
+	        =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
+	        =E2=94=94=E2=94=80=E2=94=80 out.txt
+	$ find parallel-perf-output -name cmd.txt | sort | xargs grep -H .
+	parallel-perf-output/cpu-0/time-range-0/cmd.txt:perf script --cpu=3D0 --t=
ime=3D,9469.005396999 --ns
+	parallel-perf-output/cpu-0/time-range-1/cmd.txt:perf script --cpu=3D0 --t=
ime=3D9469.005397000, --ns
+	parallel-perf-output/cpu-1/time-range-0/cmd.txt:perf script --cpu=3D1 --t=
ime=3D,9469.005396999 --ns
+	parallel-perf-output/cpu-1/time-range-1/cmd.txt:perf script --cpu=3D1 --t=
ime=3D9469.005397000, --ns
+
+Subdivisions of time range, and cpus if the --per-cpu option is used, are
+expressed by the --time and --cpu perf script options respectively. If the
+supplied perf script command has a --time option, then that time range is
+subdivided, otherwise the time range given by 'time of first sample' to
+'time of last sample' is used (refer perf script --header-only). Similarly=
, the
+supplied perf script command may provide a --cpu option, and only those CP=
Us
+will be processed.
+
+To prevent time intervals becoming too small, the --min-interval option ca=
n
+be used.
+
+Note there is special handling for processing Intel PT traces. If an inter=
val is
+not specified and the perf record command contained the intel_pt event, th=
en the
+time range will be subdivided in order to produce subdivisions that contai=
n
+approximately the same amount of trace data. That is accomplished by count=
ing
+double-quick (--itrace=3Dqqi) samples, and choosing time ranges that encom=
pass
+approximately the same number of samples. In that case, time ranges may no=
t be
+the same for each CPU processed. For Intel PT, --per-cpu is the default, b=
ut
+that can be overridden by --no-per-cpu. Note, for Intel PT, double-quick
+decoding produces 1 sample for each PSB synchronization packet, which in t=
urn
+come after a certain number of bytes output, determined by psb_period (ref=
er
+perf Intel PT documentation). The minimum number of double-quick samples t=
hat
+will define a time range can be set by the --min_size option, which defaul=
ts to
+64.
+""")
+    ap.add_argument("-o", "--output-dir", default=3D"parallel-perf-output"=
,
+                    help=3D"output directory (default 'parallel-perf-outpu=
t')")
+    ap.add_argument("-j", "--jobs", type=3Dint, default=3D0,
+                    help=3D"maximum number of jobs to run in parallel at o=
ne time "
+                         "(default is the number of CPUs)")
+    ap.add_argument("-n", "--nr", type=3Dint, default=3D0,
+                    help=3D"number of time subdivisions (default is the nu=
mber of jobs)")
+    ap.add_argument("-i", "--interval", type=3Dfloat, default=3D0,
+                    help=3D"subdivide the time range using this time inter=
val "
+                         "(in seconds e.g. 0.1 for a tenth of a second)")
+    ap.add_argument("-c", "--per-cpu", action=3D"store_true",
+                    help=3D"process data for each CPU in parallel")
+    ap.add_argument("-m", "--min-interval", type=3Dfloat, default=3Dglb_mi=
n_interval,
+                    help=3Df"minimum interval (default {glb_min_interval} =
seconds)")
+    ap.add_argument("-p", "--pipe-to",
+                    help=3D"command to pipe output to (optional)")
+    ap.add_argument("-N", "--no-per-cpu", action=3D"store_true",
+                    help=3D"do not process data for each CPU in parallel")
+    ap.add_argument("-b", "--min_size", type=3Dint, default=3Dglb_min_samp=
les,
+                    help=3D"minimum data size (for Intel PT in PSBs)")
+    ap.add_argument("-D", "--dry-run", action=3D"store_true",
+                    help=3D"do not run any jobs, just show the perf script=
 commands")
+    ap.add_argument("-q", "--quiet", action=3D"store_true",
+                    help=3D"do not print any messages except errors")
+    ap.add_argument("-v", "--verbose", action=3D"store_true",
+                    help=3D"print more messages")
+    ap.add_argument("-d", "--debug", action=3D"store_true",
+                    help=3D"print debugging messages")
+    cmd_line =3D list(args)
+    try:
+        split_pos =3D cmd_line.index("--")
+        cmd =3D cmd_line[split_pos + 1:]
+        args =3D cmd_line[:split_pos]
+    except (OSError, ValueError, RuntimeError):
+        cmd =3D None
+        args =3D cmd_line
+    a =3D ap.parse_args(args=3Dargs[1:])
+    a.cmd =3D cmd
+    setattr(a, "_verbosity", Verbosity(a.quiet, a.verbose, a.debug))
+    try:
+        if not a.cmd:
+            if a.cmd is None and len(args) <=3D 1:
+                ap.print_help()
+                return True
+            raise RuntimeError(
+                "command line must contain '--' before perf command")
+        return run_parallel_perf(a)
+    except (OSError, ValueError, RuntimeError, KeyboardInterrupt) as e:
+        print("Fatal error: ", str(e))
+        if a.debug:
+            raise
+        return False
+
+
+if __name__ =3D=3D "__main__":
+    if not main(sys.argv):
+        sys.exit(1)
diff --git a/tools/perf/scripts/python/parallel-perf.py b/tools/perf/script=
s/python/parallel-perf.py
deleted file mode 100755
index be85fd7f6632..000000000000
--- a/tools/perf/scripts/python/parallel-perf.py
+++ /dev/null
@@ -1,989 +0,0 @@
-#!/usr/bin/env python3
-# SPDX-License-Identifier: GPL-2.0
-#
-# Run a perf script command multiple times in parallel, using perf script
-# options --cpu and --time so that each job processes a different chunk
-# of the data.
-#
-# Copyright (c) 2024, Intel Corporation.
-
-import subprocess
-import argparse
-import pathlib
-import shlex
-import time
-import copy
-import sys
-import os
-import re
-
-glb_prog_name =3D "parallel-perf.py"
-glb_min_interval =3D 10.0
-glb_min_samples =3D 64
-
-class Verbosity():
-
-	def __init__(self, quiet=3DFalse, verbose=3DFalse, debug=3DFalse):
-		self.normal    =3D True
-		self.verbose   =3D verbose
-		self.debug     =3D debug
-		self.self_test =3D True
-		if self.debug:
-			self.verbose =3D True
-		if self.verbose:
-			quiet =3D False
-		if quiet:
-			self.normal =3D False
-
-# Manage work (Start/Wait/Kill), as represented by a subprocess.Popen comm=
and
-class Work():
-
-	def __init__(self, cmd, pipe_to, output_dir=3D"."):
-		self.popen =3D None
-		self.consumer =3D None
-		self.cmd =3D cmd
-		self.pipe_to =3D pipe_to
-		self.output_dir =3D output_dir
-		self.cmdout_name =3D f"{output_dir}/cmd.txt"
-		self.stdout_name =3D f"{output_dir}/out.txt"
-		self.stderr_name =3D f"{output_dir}/err.txt"
-
-	def Command(self):
-		sh_cmd =3D [ shlex.quote(x) for x in self.cmd ]
-		return " ".join(self.cmd)
-
-	def Stdout(self):
-		return open(self.stdout_name, "w")
-
-	def Stderr(self):
-		return open(self.stderr_name, "w")
-
-	def CreateOutputDir(self):
-		pathlib.Path(self.output_dir).mkdir(parents=3DTrue, exist_ok=3DTrue)
-
-	def Start(self):
-		if self.popen:
-			return
-		self.CreateOutputDir()
-		with open(self.cmdout_name, "w") as f:
-			f.write(self.Command())
-			f.write("\n")
-		stdout =3D self.Stdout()
-		stderr =3D self.Stderr()
-		if self.pipe_to:
-			self.popen =3D subprocess.Popen(self.cmd, stdout=3Dsubprocess.PIPE, std=
err=3Dstderr)
-			args =3D shlex.split(self.pipe_to)
-			self.consumer =3D subprocess.Popen(args, stdin=3Dself.popen.stdout, std=
out=3Dstdout, stderr=3Dstderr)
-		else:
-			self.popen =3D subprocess.Popen(self.cmd, stdout=3Dstdout, stderr=3Dstd=
err)
-
-	def RemoveEmptyErrFile(self):
-		if os.path.exists(self.stderr_name):
-			if os.path.getsize(self.stderr_name) =3D=3D 0:
-				os.unlink(self.stderr_name)
-
-	def Errors(self):
-		if os.path.exists(self.stderr_name):
-			if os.path.getsize(self.stderr_name) !=3D 0:
-				return [ f"Non-empty error file {self.stderr_name}" ]
-		return []
-
-	def TidyUp(self):
-		self.RemoveEmptyErrFile()
-
-	def RawPollWait(self, p, wait):
-		if wait:
-			return p.wait()
-		return p.poll()
-
-	def Poll(self, wait=3DFalse):
-		if not self.popen:
-			return None
-		result =3D self.RawPollWait(self.popen, wait)
-		if self.consumer:
-			res =3D result
-			result =3D self.RawPollWait(self.consumer, wait)
-			if result !=3D None and res =3D=3D None:
-				self.popen.kill()
-				result =3D None
-			elif result =3D=3D 0 and res !=3D None and res !=3D 0:
-				result =3D res
-		if result !=3D None:
-			self.TidyUp()
-		return result
-
-	def Wait(self):
-		return self.Poll(wait=3DTrue)
-
-	def Kill(self):
-		if not self.popen:
-			return
-		self.popen.kill()
-		if self.consumer:
-			self.consumer.kill()
-
-def KillWork(worklist, verbosity):
-	for w in worklist:
-		w.Kill()
-	for w in worklist:
-		w.Wait()
-
-def NumberOfCPUs():
-	return os.sysconf("SC_NPROCESSORS_ONLN")
-
-def NanoSecsToSecsStr(x):
-	if x =3D=3D None:
-		return ""
-	x =3D str(x)
-	if len(x) < 10:
-		x =3D "0" * (10 - len(x)) + x
-	return x[:len(x) - 9] + "." + x[-9:]
-
-def InsertOptionAfter(cmd, option, after):
-	try:
-		pos =3D cmd.index(after)
-		cmd.insert(pos + 1, option)
-	except:
-		cmd.append(option)
-
-def CreateWorkList(cmd, pipe_to, output_dir, cpus, time_ranges_by_cpu):
-	max_len =3D len(str(cpus[-1]))
-	cpu_dir_fmt =3D f"cpu-%.{max_len}u"
-	worklist =3D []
-	pos =3D 0
-	for cpu in cpus:
-		if cpu >=3D 0:
-			cpu_dir =3D os.path.join(output_dir, cpu_dir_fmt % cpu)
-			cpu_option =3D f"--cpu=3D{cpu}"
-		else:
-			cpu_dir =3D output_dir
-			cpu_option =3D None
-
-		tr_dir_fmt =3D "time-range"
-
-		if len(time_ranges_by_cpu) > 1:
-			time_ranges =3D time_ranges_by_cpu[pos]
-			tr_dir_fmt +=3D f"-{pos}"
-			pos +=3D 1
-		else:
-			time_ranges =3D time_ranges_by_cpu[0]
-
-		max_len =3D len(str(len(time_ranges)))
-		tr_dir_fmt +=3D f"-%.{max_len}u"
-
-		i =3D 0
-		for r in time_ranges:
-			if r =3D=3D [None, None]:
-				time_option =3D None
-				work_output_dir =3D cpu_dir
-			else:
-				time_option =3D "--time=3D" + NanoSecsToSecsStr(r[0]) + "," + NanoSecs=
ToSecsStr(r[1])
-				work_output_dir =3D os.path.join(cpu_dir, tr_dir_fmt % i)
-				i +=3D 1
-			work_cmd =3D list(cmd)
-			if time_option !=3D None:
-				InsertOptionAfter(work_cmd, time_option, "script")
-			if cpu_option !=3D None:
-				InsertOptionAfter(work_cmd, cpu_option, "script")
-			w =3D Work(work_cmd, pipe_to, work_output_dir)
-			worklist.append(w)
-	return worklist
-
-def DoRunWork(worklist, nr_jobs, verbosity):
-	nr_to_do =3D len(worklist)
-	not_started =3D list(worklist)
-	running =3D []
-	done =3D []
-	chg =3D False
-	while True:
-		nr_done =3D len(done)
-		if chg and verbosity.normal:
-			nr_run =3D len(running)
-			print(f"\rThere are {nr_to_do} jobs: {nr_done} completed, {nr_run} runn=
ing", flush=3DTrue, end=3D" ")
-			if verbosity.verbose:
-				print()
-			chg =3D False
-		if nr_done =3D=3D nr_to_do:
-			break
-		while len(running) < nr_jobs and len(not_started):
-			w =3D not_started.pop(0)
-			running.append(w)
-			if verbosity.verbose:
-				print("Starting:", w.Command())
-			w.Start()
-			chg =3D True
-		if len(running):
-			time.sleep(0.1)
-		finished =3D []
-		not_finished =3D []
-		while len(running):
-			w =3D running.pop(0)
-			r =3D w.Poll()
-			if r =3D=3D None:
-				not_finished.append(w)
-				continue
-			if r =3D=3D 0:
-				if verbosity.verbose:
-					print("Finished:", w.Command())
-				finished.append(w)
-				chg =3D True
-				continue
-			if verbosity.normal and not verbosity.verbose:
-				print()
-			print("Job failed!\n    return code:", r, "\n    command:    ", w.Comma=
nd())
-			if w.pipe_to:
-				print("    piped to:   ", w.pipe_to)
-			print("Killing outstanding jobs")
-			KillWork(not_finished, verbosity)
-			KillWork(running, verbosity)
-			return False
-		running =3D not_finished
-		done +=3D finished
-	errorlist =3D []
-	for w in worklist:
-		errorlist +=3D w.Errors()
-	if len(errorlist):
-		print("Errors:")
-		for e in errorlist:
-			print(e)
-	elif verbosity.normal:
-		print("\r"," "*50, "\rAll jobs finished successfully", flush=3DTrue)
-	return True
-
-def RunWork(worklist, nr_jobs=3DNumberOfCPUs(), verbosity=3DVerbosity()):
-	try:
-		return DoRunWork(worklist, nr_jobs, verbosity)
-	except:
-		for w in worklist:
-			w.Kill()
-		raise
-	return True
-
-def ReadHeader(perf, file_name):
-	return subprocess.Popen([perf, "script", "--header-only", "--input", file=
_name], stdout=3Dsubprocess.PIPE).stdout.read().decode("utf-8")
-
-def ParseHeader(hdr):
-	result =3D {}
-	lines =3D hdr.split("\n")
-	for line in lines:
-		if ":" in line and line[0] =3D=3D "#":
-			pos =3D line.index(":")
-			name =3D line[1:pos-1].strip()
-			value =3D line[pos+1:].strip()
-			if name in result:
-				orig_name =3D name
-				nr =3D 2
-				while True:
-					name =3D f"{orig_name} {nr}"
-					if name not in result:
-						break
-					nr +=3D 1
-			result[name] =3D value
-	return result
-
-def HeaderField(hdr_dict, hdr_fld):
-	if hdr_fld not in hdr_dict:
-		raise Exception(f"'{hdr_fld}' missing from header information")
-	return hdr_dict[hdr_fld]
-
-# Represent the position of an option within a command string
-# and provide the option value and/or remove the option
-class OptPos():
-
-	def Init(self, opt_element=3D-1, value_element=3D-1, opt_pos=3D-1, value_=
pos=3D-1, error=3DNone):
-		self.opt_element =3D opt_element		# list element that contains option
-		self.value_element =3D value_element	# list element that contains option=
 value
-		self.opt_pos =3D opt_pos			# string position of option
-		self.value_pos =3D value_pos		# string position of value
-		self.error =3D error			# error message string
-
-	def __init__(self, args, short_name, long_name, default=3DNone):
-		self.args =3D list(args)
-		self.default =3D default
-		n =3D 2 + len(long_name)
-		m =3D len(short_name)
-		pos =3D -1
-		for opt in args:
-			pos +=3D 1
-			if m and opt[:2] =3D=3D f"-{short_name}":
-				if len(opt) =3D=3D 2:
-					if pos + 1 < len(args):
-						self.Init(pos, pos + 1, 0, 0)
-					else:
-						self.Init(error =3D f"-{short_name} option missing value")
-				else:
-					self.Init(pos, pos, 0, 2)
-				return
-			if opt[:n] =3D=3D f"--{long_name}":
-				if len(opt) =3D=3D n:
-					if pos + 1 < len(args):
-						self.Init(pos, pos + 1, 0, 0)
-					else:
-						self.Init(error =3D f"--{long_name} option missing value")
-				elif opt[n] =3D=3D "=3D":
-					self.Init(pos, pos, 0, n + 1)
-				else:
-					self.Init(error =3D f"--{long_name} option expected '=3D'")
-				return
-			if m and opt[:1] =3D=3D "-" and opt[:2] !=3D "--" and short_name in opt=
:
-				ipos =3D opt.index(short_name)
-				if "-" in opt[1:]:
-					hpos =3D opt[1:].index("-")
-					if hpos < ipos:
-						continue
-				if ipos + 1 =3D=3D len(opt):
-					if pos + 1 < len(args):
-						self.Init(pos, pos + 1, ipos, 0)
-					else:
-						self.Init(error =3D f"-{short_name} option missing value")
-				else:
-					self.Init(pos, pos, ipos, ipos + 1)
-				return
-		self.Init()
-
-	def Value(self):
-		if self.opt_element >=3D 0:
-			if self.opt_element !=3D self.value_element:
-				return self.args[self.value_element]
-			else:
-				return self.args[self.value_element][self.value_pos:]
-		return self.default
-
-	def Remove(self, args):
-		if self.opt_element =3D=3D -1:
-			return
-		if self.opt_element !=3D self.value_element:
-			del args[self.value_element]
-		if self.opt_pos:
-			args[self.opt_element] =3D args[self.opt_element][:self.opt_pos]
-		else:
-			del args[self.opt_element]
-
-def DetermineInputFileName(cmd):
-	p =3D OptPos(cmd, "i", "input", "perf.data")
-	if p.error:
-		raise Exception(f"perf command {p.error}")
-	file_name =3D p.Value()
-	if not os.path.exists(file_name):
-		raise Exception(f"perf command input file '{file_name}' not found")
-	return file_name
-
-def ReadOption(args, short_name, long_name, err_prefix, remove=3DFalse):
-	p =3D OptPos(args, short_name, long_name)
-	if p.error:
-		raise Exception(f"{err_prefix}{p.error}")
-	value =3D p.Value()
-	if remove:
-		p.Remove(args)
-	return value
-
-def ExtractOption(args, short_name, long_name, err_prefix):
-	return ReadOption(args, short_name, long_name, err_prefix, True)
-
-def ReadPerfOption(args, short_name, long_name):
-	return ReadOption(args, short_name, long_name, "perf command ")
-
-def ExtractPerfOption(args, short_name, long_name):
-	return ExtractOption(args, short_name, long_name, "perf command ")
-
-def PerfDoubleQuickCommands(cmd, file_name):
-	cpu_str =3D ReadPerfOption(cmd, "C", "cpu")
-	time_str =3D ReadPerfOption(cmd, "", "time")
-	# Use double-quick sampling to determine trace data density
-	times_cmd =3D ["perf", "script", "--ns", "--input", file_name, "--itrace=
=3Dqqi"]
-	if cpu_str !=3D None and cpu_str !=3D "":
-		times_cmd.append(f"--cpu=3D{cpu_str}")
-	if time_str !=3D None and time_str !=3D "":
-		times_cmd.append(f"--time=3D{time_str}")
-	cnts_cmd =3D list(times_cmd)
-	cnts_cmd.append("-Fcpu")
-	times_cmd.append("-Fcpu,time")
-	return cnts_cmd, times_cmd
-
-class CPUTimeRange():
-	def __init__(self, cpu):
-		self.cpu =3D cpu
-		self.sample_cnt =3D 0
-		self.time_ranges =3D None
-		self.interval =3D 0
-		self.interval_remaining =3D 0
-		self.remaining =3D 0
-		self.tr_pos =3D 0
-
-def CalcTimeRangesByCPU(line, cpu, cpu_time_ranges, max_time):
-	cpu_time_range =3D cpu_time_ranges[cpu]
-	cpu_time_range.remaining -=3D 1
-	cpu_time_range.interval_remaining -=3D 1
-	if cpu_time_range.remaining =3D=3D 0:
-		cpu_time_range.time_ranges[cpu_time_range.tr_pos][1] =3D max_time
-		return
-	if cpu_time_range.interval_remaining =3D=3D 0:
-		time =3D TimeVal(line[1][:-1], 0)
-		time_ranges =3D cpu_time_range.time_ranges
-		time_ranges[cpu_time_range.tr_pos][1] =3D time - 1
-		time_ranges.append([time, max_time])
-		cpu_time_range.tr_pos +=3D 1
-		cpu_time_range.interval_remaining =3D cpu_time_range.interval
-
-def CountSamplesByCPU(line, cpu, cpu_time_ranges):
-	try:
-		cpu_time_ranges[cpu].sample_cnt +=3D 1
-	except:
-		print("exception")
-		print("cpu", cpu)
-		print("len(cpu_time_ranges)", len(cpu_time_ranges))
-		raise
-
-def ProcessCommandOutputLines(cmd, per_cpu, fn, *x):
-	# Assume CPU number is at beginning of line and enclosed by []
-	pat =3D re.compile(r"\s*\[[0-9]+\]")
-	p =3D subprocess.Popen(cmd, stdout=3Dsubprocess.PIPE)
-	while True:
-		line =3D p.stdout.readline()
-		if line:
-			line =3D line.decode("utf-8")
-			if pat.match(line):
-				line =3D line.split()
-				if per_cpu:
-					# Assumes CPU number is enclosed by []
-					cpu =3D int(line[0][1:-1])
-				else:
-					cpu =3D 0
-				fn(line, cpu, *x)
-		else:
-			break
-	p.wait()
-
-def IntersectTimeRanges(new_time_ranges, time_ranges):
-	pos =3D 0
-	new_pos =3D 0
-	# Can assume len(time_ranges) !=3D 0 and len(new_time_ranges) !=3D 0
-	# Note also, there *must* be at least one intersection.
-	while pos < len(time_ranges) and new_pos < len(new_time_ranges):
-		# new end < old start =3D> no intersection, remove new
-		if new_time_ranges[new_pos][1] < time_ranges[pos][0]:
-			del new_time_ranges[new_pos]
-			continue
-		# new start > old end =3D> no intersection, check next
-		if new_time_ranges[new_pos][0] > time_ranges[pos][1]:
-			pos +=3D 1
-			if pos < len(time_ranges):
-				continue
-			# no next, so remove remaining
-			while new_pos < len(new_time_ranges):
-				del new_time_ranges[new_pos]
-			return
-		# Found an intersection
-		# new start < old start =3D> adjust new start =3D old start
-		if new_time_ranges[new_pos][0] < time_ranges[pos][0]:
-			new_time_ranges[new_pos][0] =3D time_ranges[pos][0]
-		# new end > old end =3D> keep the overlap, insert the remainder
-		if new_time_ranges[new_pos][1] > time_ranges[pos][1]:
-			r =3D [ time_ranges[pos][1] + 1, new_time_ranges[new_pos][1] ]
-			new_time_ranges[new_pos][1] =3D time_ranges[pos][1]
-			new_pos +=3D 1
-			new_time_ranges.insert(new_pos, r)
-			continue
-		# new [start, end] is within old [start, end]
-		new_pos +=3D 1
-
-def SplitTimeRangesByTraceDataDensity(time_ranges, cpus, nr, cmd, file_nam=
e, per_cpu, min_size, min_interval, verbosity):
-	if verbosity.normal:
-		print("\rAnalyzing...", flush=3DTrue, end=3D" ")
-		if verbosity.verbose:
-			print()
-	cnts_cmd, times_cmd =3D PerfDoubleQuickCommands(cmd, file_name)
-
-	nr_cpus =3D cpus[-1] + 1 if per_cpu else 1
-	if per_cpu:
-		nr_cpus =3D cpus[-1] + 1
-		cpu_time_ranges =3D [ CPUTimeRange(cpu) for cpu in range(nr_cpus) ]
-	else:
-		nr_cpus =3D 1
-		cpu_time_ranges =3D [ CPUTimeRange(-1) ]
-
-	if verbosity.debug:
-		print("nr_cpus", nr_cpus)
-		print("cnts_cmd", cnts_cmd)
-		print("times_cmd", times_cmd)
-
-	# Count the number of "double quick" samples per CPU
-	ProcessCommandOutputLines(cnts_cmd, per_cpu, CountSamplesByCPU, cpu_time_=
ranges)
-
-	tot =3D 0
-	mx =3D 0
-	for cpu_time_range in cpu_time_ranges:
-		cnt =3D cpu_time_range.sample_cnt
-		tot +=3D cnt
-		if cnt > mx:
-			mx =3D cnt
-		if verbosity.debug:
-			print("cpu:", cpu_time_range.cpu, "sample_cnt", cnt)
-
-	if min_size < 1:
-		min_size =3D 1
-
-	if mx < min_size:
-		# Too little data to be worth splitting
-		if verbosity.debug:
-			print("Too little data to split by time")
-		if nr =3D=3D 0:
-			nr =3D 1
-		return [ SplitTimeRangesIntoN(time_ranges, nr, min_interval) ]
-
-	if nr:
-		divisor =3D nr
-		min_size =3D 1
-	else:
-		divisor =3D NumberOfCPUs()
-
-	interval =3D int(round(tot / divisor, 0))
-	if interval < min_size:
-		interval =3D min_size
-
-	if verbosity.debug:
-		print("divisor", divisor)
-		print("min_size", min_size)
-		print("interval", interval)
-
-	min_time =3D time_ranges[0][0]
-	max_time =3D time_ranges[-1][1]
-
-	for cpu_time_range in cpu_time_ranges:
-		cnt =3D cpu_time_range.sample_cnt
-		if cnt =3D=3D 0:
-			cpu_time_range.time_ranges =3D copy.deepcopy(time_ranges)
-			continue
-		# Adjust target interval for CPU to give approximately equal interval si=
zes
-		# Determine number of intervals, rounding to nearest integer
-		n =3D int(round(cnt / interval, 0))
-		if n < 1:
-			n =3D 1
-		# Determine interval size, rounding up
-		d, m =3D divmod(cnt, n)
-		if m:
-			d +=3D 1
-		cpu_time_range.interval =3D d
-		cpu_time_range.interval_remaining =3D d
-		cpu_time_range.remaining =3D cnt
-		# Init. time ranges for each CPU with the start time
-		cpu_time_range.time_ranges =3D [ [min_time, max_time] ]
-
-	# Set time ranges so that the same number of "double quick" samples
-	# will fall into each time range.
-	ProcessCommandOutputLines(times_cmd, per_cpu, CalcTimeRangesByCPU, cpu_ti=
me_ranges, max_time)
-
-	for cpu_time_range in cpu_time_ranges:
-		if cpu_time_range.sample_cnt:
-			IntersectTimeRanges(cpu_time_range.time_ranges, time_ranges)
-
-	return [cpu_time_ranges[cpu].time_ranges for cpu in cpus]
-
-def SplitSingleTimeRangeIntoN(time_range, n):
-	if n <=3D 1:
-		return [time_range]
-	start =3D time_range[0]
-	end   =3D time_range[1]
-	duration =3D int((end - start + 1) / n)
-	if duration < 1:
-		return [time_range]
-	time_ranges =3D []
-	for i in range(n):
-		time_ranges.append([start, start + duration - 1])
-		start +=3D duration
-	time_ranges[-1][1] =3D end
-	return time_ranges
-
-def TimeRangeDuration(r):
-	return r[1] - r[0] + 1
-
-def TotalDuration(time_ranges):
-	duration =3D 0
-	for r in time_ranges:
-		duration +=3D TimeRangeDuration(r)
-	return duration
-
-def SplitTimeRangesByInterval(time_ranges, interval):
-	new_ranges =3D []
-	for r in time_ranges:
-		duration =3D TimeRangeDuration(r)
-		n =3D duration / interval
-		n =3D int(round(n, 0))
-		new_ranges +=3D SplitSingleTimeRangeIntoN(r, n)
-	return new_ranges
-
-def SplitTimeRangesIntoN(time_ranges, n, min_interval):
-	if n <=3D len(time_ranges):
-		return time_ranges
-	duration =3D TotalDuration(time_ranges)
-	interval =3D duration / n
-	if interval < min_interval:
-		interval =3D min_interval
-	return SplitTimeRangesByInterval(time_ranges, interval)
-
-def RecombineTimeRanges(tr):
-	new_tr =3D copy.deepcopy(tr)
-	n =3D len(new_tr)
-	i =3D 1
-	while i < len(new_tr):
-		# if prev end + 1 =3D=3D cur start, combine them
-		if new_tr[i - 1][1] + 1 =3D=3D new_tr[i][0]:
-			new_tr[i][0] =3D new_tr[i - 1][0]
-			del new_tr[i - 1]
-		else:
-			i +=3D 1
-	return new_tr
-
-def OpenTimeRangeEnds(time_ranges, min_time, max_time):
-	if time_ranges[0][0] <=3D min_time:
-		time_ranges[0][0] =3D None
-	if time_ranges[-1][1] >=3D max_time:
-		time_ranges[-1][1] =3D None
-
-def BadTimeStr(time_str):
-	raise Exception(f"perf command bad time option: '{time_str}'\nCheck also =
'time of first sample' and 'time of last sample' in perf script --header-on=
ly")
-
-def ValidateTimeRanges(time_ranges, time_str):
-	n =3D len(time_ranges)
-	for i in range(n):
-		start =3D time_ranges[i][0]
-		end   =3D time_ranges[i][1]
-		if i !=3D 0 and start <=3D time_ranges[i - 1][1]:
-			BadTimeStr(time_str)
-		if start > end:
-			BadTimeStr(time_str)
-
-def TimeVal(s, dflt):
-	s =3D s.strip()
-	if s =3D=3D "":
-		return dflt
-	a =3D s.split(".")
-	if len(a) > 2:
-		raise Exception(f"Bad time value'{s}'")
-	x =3D int(a[0])
-	if x < 0:
-		raise Exception("Negative time not allowed")
-	x *=3D 1000000000
-	if len(a) > 1:
-		x +=3D int((a[1] + "000000000")[:9])
-	return x
-
-def BadCPUStr(cpu_str):
-	raise Exception(f"perf command bad cpu option: '{cpu_str}'\nCheck also 'n=
rcpus avail' in perf script --header-only")
-
-def ParseTimeStr(time_str, min_time, max_time):
-	if time_str =3D=3D None or time_str =3D=3D "":
-		return [[min_time, max_time]]
-	time_ranges =3D []
-	for r in time_str.split():
-		a =3D r.split(",")
-		if len(a) !=3D 2:
-			BadTimeStr(time_str)
-		try:
-			start =3D TimeVal(a[0], min_time)
-			end   =3D TimeVal(a[1], max_time)
-		except:
-			BadTimeStr(time_str)
-		time_ranges.append([start, end])
-	ValidateTimeRanges(time_ranges, time_str)
-	return time_ranges
-
-def ParseCPUStr(cpu_str, nr_cpus):
-	if cpu_str =3D=3D None or cpu_str =3D=3D "":
-		return [-1]
-	cpus =3D []
-	for r in cpu_str.split(","):
-		a =3D r.split("-")
-		if len(a) < 1 or len(a) > 2:
-			BadCPUStr(cpu_str)
-		try:
-			start =3D int(a[0].strip())
-			if len(a) > 1:
-				end =3D int(a[1].strip())
-			else:
-				end =3D start
-		except:
-			BadCPUStr(cpu_str)
-		if start < 0 or end < 0 or end < start or end >=3D nr_cpus:
-			BadCPUStr(cpu_str)
-		cpus.extend(range(start, end + 1))
-	cpus =3D list(set(cpus)) # Remove duplicates
-	cpus.sort()
-	return cpus
-
-class ParallelPerf():
-
-	def __init__(self, a):
-		for arg_name in vars(a):
-			setattr(self, arg_name, getattr(a, arg_name))
-		self.orig_nr =3D self.nr
-		self.orig_cmd =3D list(self.cmd)
-		self.perf =3D self.cmd[0]
-		if os.path.exists(self.output_dir):
-			raise Exception(f"Output '{self.output_dir}' already exists")
-		if self.jobs < 0 or self.nr < 0 or self.interval < 0:
-			raise Exception("Bad options (negative values): try -h option for help"=
)
-		if self.nr !=3D 0 and self.interval !=3D 0:
-			raise Exception("Cannot specify number of time subdivisions and time in=
terval")
-		if self.jobs =3D=3D 0:
-			self.jobs =3D NumberOfCPUs()
-		if self.nr =3D=3D 0 and self.interval =3D=3D 0:
-			if self.per_cpu:
-				self.nr =3D 1
-			else:
-				self.nr =3D self.jobs
-
-	def Init(self):
-		if self.verbosity.debug:
-			print("cmd", self.cmd)
-		self.file_name =3D DetermineInputFileName(self.cmd)
-		self.hdr =3D ReadHeader(self.perf, self.file_name)
-		self.hdr_dict =3D ParseHeader(self.hdr)
-		self.cmd_line =3D HeaderField(self.hdr_dict, "cmdline")
-
-	def ExtractTimeInfo(self):
-		self.min_time =3D TimeVal(HeaderField(self.hdr_dict, "time of first samp=
le"), 0)
-		self.max_time =3D TimeVal(HeaderField(self.hdr_dict, "time of last sampl=
e"), 0)
-		self.time_str =3D ExtractPerfOption(self.cmd, "", "time")
-		self.time_ranges =3D ParseTimeStr(self.time_str, self.min_time, self.max=
_time)
-		if self.verbosity.debug:
-			print("time_ranges", self.time_ranges)
-
-	def ExtractCPUInfo(self):
-		if self.per_cpu:
-			nr_cpus =3D int(HeaderField(self.hdr_dict, "nrcpus avail"))
-			self.cpu_str =3D ExtractPerfOption(self.cmd, "C", "cpu")
-			if self.cpu_str =3D=3D None or self.cpu_str =3D=3D "":
-				self.cpus =3D [ x for x in range(nr_cpus) ]
-			else:
-				self.cpus =3D ParseCPUStr(self.cpu_str, nr_cpus)
-		else:
-			self.cpu_str =3D None
-			self.cpus =3D [-1]
-		if self.verbosity.debug:
-			print("cpus", self.cpus)
-
-	def IsIntelPT(self):
-		return self.cmd_line.find("intel_pt") >=3D 0
-
-	def SplitTimeRanges(self):
-		if self.IsIntelPT() and self.interval =3D=3D 0:
-			self.split_time_ranges_for_each_cpu =3D \
-				SplitTimeRangesByTraceDataDensity(self.time_ranges, self.cpus, self.or=
ig_nr,
-								  self.orig_cmd, self.file_name, self.per_cpu,
-								  self.min_size, self.min_interval, self.verbosity)
-		elif self.nr:
-			self.split_time_ranges_for_each_cpu =3D [ SplitTimeRangesIntoN(self.tim=
e_ranges, self.nr, self.min_interval) ]
-		else:
-			self.split_time_ranges_for_each_cpu =3D [ SplitTimeRangesByInterval(sel=
f.time_ranges, self.interval) ]
-
-	def CheckTimeRanges(self):
-		for tr in self.split_time_ranges_for_each_cpu:
-			# Re-combined time ranges should be the same
-			new_tr =3D RecombineTimeRanges(tr)
-			if new_tr !=3D self.time_ranges:
-				if self.verbosity.debug:
-					print("tr", tr)
-					print("new_tr", new_tr)
-				raise Exception("Self test failed!")
-
-	def OpenTimeRangeEnds(self):
-		for time_ranges in self.split_time_ranges_for_each_cpu:
-			OpenTimeRangeEnds(time_ranges, self.min_time, self.max_time)
-
-	def CreateWorkList(self):
-		self.worklist =3D CreateWorkList(self.cmd, self.pipe_to, self.output_dir=
, self.cpus, self.split_time_ranges_for_each_cpu)
-
-	def PerfDataRecordedPerCPU(self):
-		if "--per-thread" in self.cmd_line.split():
-			return False
-		return True
-
-	def DefaultToPerCPU(self):
-		# --no-per-cpu option takes precedence
-		if self.no_per_cpu:
-			return False
-		if not self.PerfDataRecordedPerCPU():
-			return False
-		# Default to per-cpu for Intel PT data that was recorded per-cpu,
-		# because decoding can be done for each CPU separately.
-		if self.IsIntelPT():
-			return True
-		return False
-
-	def Config(self):
-		self.Init()
-		self.ExtractTimeInfo()
-		if not self.per_cpu:
-			self.per_cpu =3D self.DefaultToPerCPU()
-		if self.verbosity.debug:
-			print("per_cpu", self.per_cpu)
-		self.ExtractCPUInfo()
-		self.SplitTimeRanges()
-		if self.verbosity.self_test:
-			self.CheckTimeRanges()
-		# Prefer open-ended time range to starting / ending with min_time / max_=
time resp.
-		self.OpenTimeRangeEnds()
-		self.CreateWorkList()
-
-	def Run(self):
-		if self.dry_run:
-			print(len(self.worklist),"jobs:")
-			for w in self.worklist:
-				print(w.Command())
-			return True
-		result =3D RunWork(self.worklist, self.jobs, verbosity=3Dself.verbosity)
-		if self.verbosity.verbose:
-			print(glb_prog_name, "done")
-		return result
-
-def RunParallelPerf(a):
-	pp =3D ParallelPerf(a)
-	pp.Config()
-	return pp.Run()
-
-def Main(args):
-	ap =3D argparse.ArgumentParser(
-		prog=3Dglb_prog_name, formatter_class =3D argparse.RawDescriptionHelpFor=
matter,
-		description =3D
-"""
-Run a perf script command multiple times in parallel, using perf script op=
tions
---cpu and --time so that each job processes a different chunk of the data.
-""",
-		epilog =3D
-"""
-Follow the options by '--' and then the perf script command e.g.
-
-	$ perf record -a -- sleep 10
-	$ parallel-perf.py --nr=3D4 -- perf script --ns
-	All jobs finished successfully
-	$ tree parallel-perf-output/
-	parallel-perf-output/
-	=E2=94=9C=E2=94=80=E2=94=80 time-range-0
-	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
-	=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 out.txt
-	=E2=94=9C=E2=94=80=E2=94=80 time-range-1
-	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
-	=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 out.txt
-	=E2=94=9C=E2=94=80=E2=94=80 time-range-2
-	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
-	=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 out.txt
-	=E2=94=94=E2=94=80=E2=94=80 time-range-3
-	    =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
-	    =E2=94=94=E2=94=80=E2=94=80 out.txt
-	$ find parallel-perf-output -name cmd.txt | sort | xargs grep -H .
-	parallel-perf-output/time-range-0/cmd.txt:perf script --time=3D,9466.5044=
61499 --ns
-	parallel-perf-output/time-range-1/cmd.txt:perf script --time=3D9466.50446=
1500,9469.005396999 --ns
-	parallel-perf-output/time-range-2/cmd.txt:perf script --time=3D9469.00539=
7000,9471.506332499 --ns
-	parallel-perf-output/time-range-3/cmd.txt:perf script --time=3D9471.50633=
2500, --ns
-
-Any perf script command can be used, including the use of perf script opti=
ons
---dlfilter and --script, so that the benefit of running parallel jobs
-naturally extends to them also.
-
-If option --pipe-to is used, standard output is first piped through that
-command. Beware, if the command fails (e.g. grep with no matches), it will=
 be
-considered a fatal error.
-
-Final standard output is redirected to files named out.txt in separate
-subdirectories under the output directory. Similarly, standard error is
-written to files named err.txt. In addition, files named cmd.txt contain t=
he
-corresponding perf script command. After processing, err.txt files are rem=
oved
-if they are empty.
-
-If any job exits with a non-zero exit code, then all jobs are killed and n=
o
-more are started. A message is printed if any job results in a non-empty
-err.txt file.
-
-There is a separate output subdirectory for each time range. If the --per-=
cpu
-option is used, these are further grouped under cpu-n subdirectories, e.g.
-
-	$ parallel-perf.py --per-cpu --nr=3D2 -- perf script --ns --cpu=3D0,1
-	All jobs finished successfully
-	$ tree parallel-perf-output
-	parallel-perf-output/
-	=E2=94=9C=E2=94=80=E2=94=80 cpu-0
-	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 time-range-0
-	=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 c=
md.txt
-	=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 o=
ut.txt
-	=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 time-range-1
-	=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
-	=E2=94=82=C2=A0=C2=A0     =E2=94=94=E2=94=80=E2=94=80 out.txt
-	=E2=94=94=E2=94=80=E2=94=80 cpu-1
-	    =E2=94=9C=E2=94=80=E2=94=80 time-range-0
-	    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
-	    =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 out.txt
-	    =E2=94=94=E2=94=80=E2=94=80 time-range-1
-	        =E2=94=9C=E2=94=80=E2=94=80 cmd.txt
-	        =E2=94=94=E2=94=80=E2=94=80 out.txt
-	$ find parallel-perf-output -name cmd.txt | sort | xargs grep -H .
-	parallel-perf-output/cpu-0/time-range-0/cmd.txt:perf script --cpu=3D0 --t=
ime=3D,9469.005396999 --ns
-	parallel-perf-output/cpu-0/time-range-1/cmd.txt:perf script --cpu=3D0 --t=
ime=3D9469.005397000, --ns
-	parallel-perf-output/cpu-1/time-range-0/cmd.txt:perf script --cpu=3D1 --t=
ime=3D,9469.005396999 --ns
-	parallel-perf-output/cpu-1/time-range-1/cmd.txt:perf script --cpu=3D1 --t=
ime=3D9469.005397000, --ns
-
-Subdivisions of time range, and cpus if the --per-cpu option is used, are
-expressed by the --time and --cpu perf script options respectively. If the
-supplied perf script command has a --time option, then that time range is
-subdivided, otherwise the time range given by 'time of first sample' to
-'time of last sample' is used (refer perf script --header-only). Similarly=
, the
-supplied perf script command may provide a --cpu option, and only those CP=
Us
-will be processed.
-
-To prevent time intervals becoming too small, the --min-interval option ca=
n
-be used.
-
-Note there is special handling for processing Intel PT traces. If an inter=
val is
-not specified and the perf record command contained the intel_pt event, th=
en the
-time range will be subdivided in order to produce subdivisions that contai=
n
-approximately the same amount of trace data. That is accomplished by count=
ing
-double-quick (--itrace=3Dqqi) samples, and choosing time ranges that encom=
pass
-approximately the same number of samples. In that case, time ranges may no=
t be
-the same for each CPU processed. For Intel PT, --per-cpu is the default, b=
ut
-that can be overridden by --no-per-cpu. Note, for Intel PT, double-quick
-decoding produces 1 sample for each PSB synchronization packet, which in t=
urn
-come after a certain number of bytes output, determined by psb_period (ref=
er
-perf Intel PT documentation). The minimum number of double-quick samples t=
hat
-will define a time range can be set by the --min_size option, which defaul=
ts to
-64.
-""")
-	ap.add_argument("-o", "--output-dir", default=3D"parallel-perf-output", h=
elp=3D"output directory (default 'parallel-perf-output')")
-	ap.add_argument("-j", "--jobs", type=3Dint, default=3D0, help=3D"maximum =
number of jobs to run in parallel at one time (default is the number of CPU=
s)")
-	ap.add_argument("-n", "--nr", type=3Dint, default=3D0, help=3D"number of =
time subdivisions (default is the number of jobs)")
-	ap.add_argument("-i", "--interval", type=3Dfloat, default=3D0, help=3D"su=
bdivide the time range using this time interval (in seconds e.g. 0.1 for a =
tenth of a second)")
-	ap.add_argument("-c", "--per-cpu", action=3D"store_true", help=3D"process=
 data for each CPU in parallel")
-	ap.add_argument("-m", "--min-interval", type=3Dfloat, default=3Dglb_min_i=
nterval, help=3Df"minimum interval (default {glb_min_interval} seconds)")
-	ap.add_argument("-p", "--pipe-to", help=3D"command to pipe output to (opt=
ional)")
-	ap.add_argument("-N", "--no-per-cpu", action=3D"store_true", help=3D"do n=
ot process data for each CPU in parallel")
-	ap.add_argument("-b", "--min_size", type=3Dint, default=3Dglb_min_samples=
, help=3D"minimum data size (for Intel PT in PSBs)")
-	ap.add_argument("-D", "--dry-run", action=3D"store_true", help=3D"do not =
run any jobs, just show the perf script commands")
-	ap.add_argument("-q", "--quiet", action=3D"store_true", help=3D"do not pr=
int any messages except errors")
-	ap.add_argument("-v", "--verbose", action=3D"store_true", help=3D"print m=
ore messages")
-	ap.add_argument("-d", "--debug", action=3D"store_true", help=3D"print deb=
ugging messages")
-	cmd_line =3D list(args)
-	try:
-		split_pos =3D cmd_line.index("--")
-		cmd =3D cmd_line[split_pos + 1:]
-		args =3D cmd_line[:split_pos]
-	except:
-		cmd =3D None
-		args =3D cmd_line
-	a =3D ap.parse_args(args=3Dargs[1:])
-	a.cmd =3D cmd
-	a.verbosity =3D Verbosity(a.quiet, a.verbose, a.debug)
-	try:
-		if a.cmd =3D=3D None:
-			if len(args) <=3D 1:
-				ap.print_help()
-				return True
-			raise Exception("Command line must contain '--' before perf command")
-		return RunParallelPerf(a)
-	except Exception as e:
-		print("Fatal error: ", str(e))
-		if a.debug:
-			raise
-		return False
-
-if __name__ =3D=3D "__main__":
-	if not Main(sys.argv):
-		sys.exit(1)
diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/scri=
pt.sh
index 7007f1cdf761..254fc3ae94e7 100755
--- a/tools/perf/tests/shell/script.sh
+++ b/tools/perf/tests/shell/script.sh
@@ -1,6 +1,6 @@
 #!/bin/bash
-# perf script tests
 # SPDX-License-Identifier: GPL-2.0
+# perf script tests
=20
 set -e
=20
@@ -76,7 +76,7 @@ test_parallel_perf()
 		err=3D2
 		return
 	fi
-	pp=3D$(dirname "$0")/../../scripts/python/parallel-perf.py
+	pp=3D$(dirname "$0")/../../python/parallel-perf.py
 	if [ ! -f "${pp}" ] ; then
 		echo "SKIP: parallel-perf.py script not found "
 		err=3D2
--=20
2.56.0.rc1.315.gc6ed9934b7-goog

