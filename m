Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF421340401
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619976; cv=none; b=FAsKZVZZ6aw3voWYRav4vFLeSP8fOdjYhfIInuNkOPYOD36l/KR4JAQpx7zMVzG84t3rh6JkSvYoznWwoK3Tx0Q92+yN/nO2pp4jjqZwHjPDKtpa4SDnVEW2H83FhYkkIu7sJmWTEQY5jUfgILRbTXmHlpLQv4lkl/vpI6Ledr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619976; c=relaxed/simple;
	bh=3mZePbY9lFX4g/sxLYVYVO3Z+gYDG3iWiIAK4E6Jri8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MTU7MoOe44KXDeIOij/btLtxOIdTPUTSXZseHxiPWZ4aocEFeB2qt9keTu1tM1uCipKXqyOa2FaKIELEf5onRYyFYw/Km+h7CzHw8alt9qhUmP7Q3FH3zPVx3vKzxDUDZXO1c6SvzSFidWc9uMjqB6dQvIuUjiW/xepELr1XOHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ipVfBq+I; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ipVfBq+I"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3441e2b3fc3so2045354eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790619974; x=1791224774; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j4naJAeRRmFk7UJ3Wsb4JlhoX93sYP2A+pETg3XEi1Q=;
        b=ipVfBq+I/Wvc3OiZkn0DYJJ4VwC/Zu3NJhLz3MkX4rLSoAfTNOlFFTl9d+Mr0Bnjw8
         eztSsFDIvpwlPHIgSzhd08EwM9YgA0Qfz6RMMiylCuktoStDsR0XQHCya6799tRD8JQG
         F+ocGXiSHdrNdbBTx6wNfeO+QpDghKGcxnaK5nSSi7JpTfri75P+Wnv0Bl068jV+lkir
         p3I1dS9bfRi+nklcUBvwtPBcu3QO/NRA9BCfH7RZNChqjlJ40EoivAQawSdTnvZsjOGU
         XyHcwIf6EqR3QHH+hNFIDDQb2x4iBHRZ6GCwMuS4q3DpQTdaPweRsU3eHLwHP2whBlgs
         3YRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619974; x=1791224774;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j4naJAeRRmFk7UJ3Wsb4JlhoX93sYP2A+pETg3XEi1Q=;
        b=d9m5F1HjGH43xk2zsHDF9bJZjqdK5Xz03GLiNq4TMTynYRF8Z/TJ94cCLB39X8BnHW
         9soSmCEU7/boZSMXDjBYPph28bnIKGk6BuKVHQl2Zxmgl2ce0PAbubyP+7U+r8M4O5Pi
         Vvoge7055e0gkkT9zLsbQjVZkiRbWTo/Aj3XymEImnSg5KeRrBYWnlDxoXpJEpeNw7s3
         A7c+DPt/d8Iu5kS3KUqOzOp1/PxuW2oC2jEppOZWDZIpCXgT78vro5T6ytobpKDTUmgh
         xqOLvQJGHzn7najr9FFkQ0tzR22hNVX5OtbJSS5mpB3rZGbjKD5PRiEzQ07O1KpHdvqZ
         /HqQ==
X-Forwarded-Encrypted: i=1; AKwUvBy5M3ZF02gLZ82hbL65FlVv11A09VNjy9MPuOHyOzL1EXL7+uJ3XX4gGm1KwIg3Z+DnR1Ym3XixEDYIxfSGjEWh@vger.kernel.org
X-Gm-Message-State: AFuF++m6GD71PWSRjjic0fv6pEbWOstjNXblq5Kuc3mbgPURCjUyhRGT
	9dF4xVOUjdpdQ5gPabcK3jQmORh6W2E+vt/VH1cNkKocmjUUm5cpECMlEAa7qvNel5b8nSUZBB9
	QFdBeSt3zmg==
X-Received: from dlbep12.prod.google.com ([2002:a05:7022:108c:b0:149:37d9:7f80])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:241a:b0:145:15d:3717
 with SMTP id a92af1059eb24-146cdebc52dmr10813184c88.10.1790619973362; Mon, 28
 Sep 2026 11:26:13 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:25:39 -0700
In-Reply-To: <cover.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928182605.3649015-1-irogers@google.com>
Subject: [PATCH v6 00/26] perf trace: Fix BPF filtering and make tracing tests non-exclusive
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

perf trace's BPF programs return 0 from raw_syscalls:sys_{enter,exit} to
filter, which drops the event for every other session using the
tracepoint. Fix that, and bugs found on the way, so the perf trace and
probe tests can run in parallel.

Patches 1-6 fix reading augmented arguments.

Patches 7-10 fix starting the BPF summary, and the syscall tracepoints'
internal fields being taken for arguments.

Patches 11-18 fix the filtering. Namhyung's series [2], patches 11, 17
and 18, sends sys_exit as well as sys_enter through the bpf-output event
so nothing is vetoed. That event only works for the first thread of a
task target and not for its children, so patches 14-16 open it on every
CPU and select the target's tasks in BPF, keyed by process when
inheriting. Patch 19 adds --no-syscall-augment.

Patches 20-26 scope the tests' probes and events to their pid so they
can drop the exclusive tag.

Aaron's series [1] overlaps patches 4 and 5, whose approach was
preferred. In [1], 3/7 steps over a string by its size rounded up to 8,
but the BTF augmenter packs arguments unaligned, so the second path of
rename-like syscalls is misread. 2/7 doesn't step over the zero sized
argument a failed read leaves, so the next argument rereads it. [1] also
has checkpatch warnings, Reported-by without Closes: and 112 column
lines.

From [2], Jakub's 1/5, using the kernel's syscall tracepoint structs, is
left out as these fixes don't need it and patches 1, 2, 15 and 17 change
the same code. It can follow on top. 3/5 adds common_type to the existing
structs instead and, among the changes noted in it, always returns 1
from augmented__output(), as returning 0 from the tail called augmenters
still vetoed the tracepoint. 5/5 keeps trace+probe_vfs_getname.sh
exclusive, as without BPF every perf trace opens its probe.

The series applies on top of [3], which fixes the vfs_getname tests on
v7.0+ kernels and changes the same lines as patch 21.

Tested on x86_64, the trace and probe tests pass under 'perf test -r3'.
Every patch builds with and without BUILD_BPF_SKEL.

[1] https://lore.kernel.org/r/20260919005530.728615-1-atomlin@atomlin.com
[2] https://lore.kernel.org/r/20250814071754.193265-1-namhyung@kernel.org
[3] https://lore.kernel.org/r/20260926223905.6865105-1-irogers@google.com

v6:
 - Shorter commit messages and comments (Namhyung).
 - Keep v5 8-9/23 as patches 4 and 5 rather than Aaron's [1], see above.
 - New patch 6 copies sockaddr arguments by their length, so IPv6
   addresses are shown.
 - Namhyung's 2-4/5 with patches 15 and 16 replace v5 11-15/23, and his
   5/5 replaces v5 22/23, see above.
 - Seed the target's tasks before the events are opened, rather than
   re-reading /proc after attaching, keyed by process when inheriting.
   Tasks that don't fit are reported as lost, suggesting
   --no-syscall-augment.
 - Patch 14 moves bpf-filter's convert_to_tgid() to thread_map.c, fixing
   a read after free and a comm containing "Tgid:" being taken for it.
 - Split v5 7/23 into patches 8-10, stopping at the first internal
   field (Namhyung).
 - --no-syscall-augment is its own patch (Namhyung).
 - Drop v5 3-5/23, now applied.
 - Drop v5 16/23, as perf-tools-next's port of task-analyzer to the perf
   module made the same change.

Ian Rogers (22):
  perf trace: Set the augmented arg header in the augmenters that omit
    it
  perf trace: Include the augmented arg header in nanosleep's payload
    length
  perf trace: Don't read sample padding as an augmented argument
  perf trace: Bounds check augmented arguments before reading them
  perf trace: Bound the fixed size augmented argument beautifiers
  perf trace: Copy sockaddr arguments by their length
  perf trace: Start BPF summary before starting workload
  perf trace: Stop at internal fields when walking syscall arguments
  perf trace: Don't allocate syscall arg formats for internal fields
  perf trace: Only take augmented arguments from the BPF output event
  perf trace: Use the CPU map index for the BPF output event's fds
  perf trace: Destroy the BPF skeleton if it fails to load
  perf thread_map: Add thread_map__tgid()
  perf trace: Filter the target's tasks in BPF
  perf trace: Open the BPF output event on every CPU for task targets
  perf trace: Add an option to disable syscall augmentation
  perf test common: Only disable probes in clear_all_probes
  perf test probe_vfs_getname: Scope probe name to PID and make
    non-exclusive
  perf test record+probe_libc_inet_pton: Scope event to PID and make
    non-exclusive
  perf test trace_summary: Improve error diagnostics
  perf test trace_btf_general: Drop --max-events=1 and make
    non-exclusive
  perf test uprobe_from_different_cu: Scope probe name to PID

Namhyung Kim (4):
  perf trace: Split unaugmented sys_exit program
  perf trace: Do not return 0 from syscall tracepoint BPF
  perf trace: Remove unused code
  perf test: Remove exclusive tag from perf trace tests

 tools/perf/Documentation/perf-trace.txt       |   6 +
 tools/perf/builtin-trace.c                    | 441 ++++++++++--------
 tools/perf/tests/shell/common/init.sh         |  21 +-
 .../perf/tests/shell/lib/probe_vfs_getname.sh |  25 +-
 tools/perf/tests/shell/probe_vfs_getname.sh   |   3 +-
 .../shell/record+probe_libc_inet_pton.sh      |  85 +++-
 .../shell/record+script_probe_vfs_getname.sh  |  16 +-
 .../shell/test_uprobe_from_different_cu.sh    |   7 +-
 .../tests/shell/trace+probe_vfs_getname.sh    |   5 +
 tools/perf/tests/shell/trace_btf_general.sh   |   8 +-
 tools/perf/tests/shell/trace_summary.sh       |  15 +-
 tools/perf/trace/beauty/beauty.h              |  17 +
 tools/perf/trace/beauty/perf_event_open.c     |  31 +-
 tools/perf/trace/beauty/sockaddr.c            |  49 +-
 tools/perf/trace/beauty/timespec.c            |   2 +-
 tools/perf/util/bpf-filter.c                  |  29 +-
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 210 +++++++--
 tools/perf/util/bpf_skel/perf_trace_u.h       |  14 +
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |   9 +
 tools/perf/util/bpf_trace_augment.c           |  89 +++-
 tools/perf/util/thread_map.c                  |  26 ++
 tools/perf/util/thread_map.h                  |   1 +
 tools/perf/util/trace_augment.h               |  34 +-
 23 files changed, 800 insertions(+), 343 deletions(-)
 create mode 100644 tools/perf/util/bpf_skel/perf_trace_u.h


base-commit: 0ae6fc78c5ce0dfd18d8712a50f0fd4602eff103
prerequisite-patch-id: 8c69aafd92a5783df1ce11b7ab792ab39508380e
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

