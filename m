Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795418364;
	b=ont5fifYKJ/PFg/1inJb2rloAcAT2bxibKZsCACuC5H7jZasxqM9XA34XQQpRQdq20WO
	 oiGPpW80OoxXFetKBDRWg/TLt1NHVQmaHUknLSKHogtVe6miVFJJUVTM0gzfdOMgLd8g8
	 c7Hno41pl9/+vhLNL5X6gwlI7hpS3lPI4otpgCjQjb2q8kGCAf/TX5FMltRHwegiqdGys
	 vyVmByoMUYbqjNTUdBPMRbjnivAGquvWgqitYU3YsvkRLTssO+s4JEIJzS5awIMJzNVqt
	 uM8JIec4aHAq3oO/VtzSrb6TRT+sWH6zInkkXxjXRcGYFd2BF7JdKIUR3ouvcqUYTJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795418364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=InT91oisEFmdndrqcS8mrchaCKx4oa3ZvByTCs2ke2Y=;
	b=bx4kf4b12/Mm1JPT2Ku1sqV7ImQ0LO58m4DDMPEp06aeKeh+A1X9dbRIQGq5WQRHKAjA
	 62fZcok63DcpBENMP+0P/ySoxlAE9Xr9NKJixJHqFfk+gDWIkvK3QFh0CmRFA5H3Wlwun
	 Tr/NyoujGUP46wWNvy+5RTM4guBTyeQftT57OhWx8BKakAD1lgsFHIu8stYfTlbqXpZpE
	 fcBlV0GX3jIqcjfdPb9ov81csJmLCmWyS6kp5XQMxNo6pPgygMD4E2ueBpj7N6zb9DA/k
	 wJ7MOIEyGGSVfiKjn7vgtQogXajHBWnG5aVg22dXGrCZ37d3dNoVbVWkmFjS5uNctuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=O6m2OMtp;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D679606A31E
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 07:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D679606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=O6m2OMtp
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4cbf700ddccso2212349b6e.0
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 23:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795418363; x=1796023163; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=InT91oisEFmdndrqcS8mrchaCKx4oa3ZvByTCs2ke2Y=;
        b=O6m2OMtpz7fQsxr4ivwMxIwnMaMjXc3+cgVm7Kr5GhOSUlPIg8EfxlAxO67Ar4sqtn
         tMemnwowyVy2m1+6yaETzMXk18BMvEYnF8GnsuDtElGc95dirPeB9GgmUHBV1Jf27II+
         s1+/XkNUeoqWz31JDImy29hYQomOdptctCfzgxEiOLPkCpYDTYeDbz2BbOQuFMqPvSh7
         cY/04Rw96I7SUWfI04yE20lnfHQ690xntjfAfK9Cre9Jf58hKLYscUgxBght6K1Xd9Iy
         wiUxU1XhIq9PNzyWAqt7sUwP8qBtl8cns4ZFi5o/2F5CuTI2nEwY1vM6wRjoKUjRg8AC
         cb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795418363; x=1796023163;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=InT91oisEFmdndrqcS8mrchaCKx4oa3ZvByTCs2ke2Y=;
        b=nobmX+dbEZhkfolABvtlHGZd5CG8luClvUHwtpeY+K2IeOcX4mQ9KkSuMjy+CBxAyu
         1EBbKMxOMHP4WuchcSnhLHtJm12ZsMK5c/wGDRcQBkt855NsJiZ8zkXbiG2MPzj1JSP/
         z1ZS75qXC8MZYUBwwWe1fd/rJ8XFZ+JCq6OYlE5xzQucQpcSaBR6cP4fyvSPNeNi4A37
         QB6pHusofQAK69isePtKrmzYmDQzi3xlzK/gCBu9A3eWN0ggHYeib8tyngFULVraOp7+
         CvttUUjuX+n2JyDvM94c+c2XNX829nr3JQm8YA32UqibiYzgfIdSdIB2FOCp77sYk6D5
         ztbA==
X-Forwarded-Encrypted: i=1; AL+hErGbfYVwLrtjB8G5RJ5g0epVDl+4oP7pj4SPNQUwZnOeJ3gpAyrIfK0IMgMq4F2BkMjcAPJl1S2IRrozmpI9HZCh@vger.kernel.org
X-Gm-Message-State: APuU4Z9dbMIi/MbzhD2OG6Sty9x2IQ5L4P/MTYNkOYbomkJsfXE9shuS
	fLYJ2DmGRghEusBVhgES/VqCL1vQgbaOKiZ+ovOwtqW4cSFEnpmDZg+/F9eEr6+3Etv2P0F/cpP
	+VMpVF2oy2g==
X-Received: from oapa41.prod.google.com ([2002:a05:6870:46a9:b0:494:a4d4:8e0b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:1384:b0:4ce:a4fc:a848
 with SMTP id 5614622812f47-57a06a0da3amr13118058b6e.6.1795418362986; Sun, 22
 Nov 2026 23:19:22 -0800 (PST)
Date: Sun, 22 Nov 2026 23:19:00 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123071913.653315-1-irogers@google.com>
Subject: [PATCH v1 00/13] perf fixes: off-cpu, stat, tool PMU, bperf, and
 bpf-filter fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Song Liu <songliubraving@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series collects standalone bug fixes across perf off-cpu, libperf
evlist, perf stat, the tool PMU, bperf (--bpf-counters), and perf
bpf-filter:

1. 'perf off-cpu' fixes (patches 1-2):
   - Zero the stack trace buffer before lookup and bound callchain
     length by MAX_STACKS in off_cpu_write() so full 32-frame stacks do
     not read and write past off_cpu_raw.
   - Fix swapped PID and TID packing in direct off_cpu_dump() BPF
     samples so multi-threaded direct off-CPU samples match
     off_cpu_write() and __set_offcpu_sample().

2. 'libperf', 'perf stat', 'tool' PMU, and '--bpf-counters' fixes
   (patches 3-9):
   - Drop any existing per-evsel CPU map and re-propagate all evsels in
     perf_evlist__go_system_wide() so evlist->all_cpus is rebuilt
     without retaining the "any CPU" (-1) placeholder.
   - Assign unique synthetic IDs to non-perf_event_open events (tool,
     hwmon, drm, retire_lat) for 'perf stat record' so counts are not
     all attributed to ID 0.
   - Serialize and restore per-evsel 'cpus' (rather than 'pmu_cpus')
     across 'perf stat record' and 'perf stat report', retaining
     backward compatibility for older perf.data files.
   - Return false for PERF_PMU_TYPE_TOOL in perf_pmu__is_software() and
     guard group leader handling so grouping tool PMU events with kernel
     PMU events does not hit BUG_ON() in get_group_fd() or fail in
     evsel__read_group().
   - Enable enable_on_exec tool PMU events in evlist__start_workload()
     so workload runs do not report 0 for duration_time, user_time, or
     system_time.
   - Compute enabled time in the wait4 rusage fallback for exited
     user_time and system_time events (e.g. with -D delay).
   - Restrict bperf (--bpf-counters / :b) to compatible counters and fix
     mixed, hybrid, cgroup, and repeat (-r) counter lifecycle bugs.

3. 'perf bpf-filter' and tracepoint filter fixes (patches 10-13):
   - Attach unpinned BPF sample filters via PERF_EVENT_IOC_SET_BPF
     instead of bpf_program__attach_perf_event_opts() to fix the
     bpf_link memory/FD leak reported by LeakSanitizer.
   - Deep-copy evsel->bpf_filters in evsel__clone() (fixing
     --for-each-cgroup) and release runtime BPF filter state in
     evsel__close() (fixing 'perf stat -r' repeat runs).
   - Add SEC("tracepoint") perf_tp_sample_filter for
     PERF_TYPE_TRACEPOINT events (with !CONFIG_CGROUPS CO-RE guards and
     selective pinning) so context-independent BPF filter terms (uid,
     gid, tid, pid, cpu, time, cgroup) do not fail with -EINVAL.
   - Route tracepoint --filter strings to BPF filters only when
     referencing non-field BPF terms (with tracefs format fallback when
     built with NO_LIBTRACEEVENT=1) and reject ambiguous mixed filters.

Notes on prior postings:
- Patch 3 was previously posted unchanged as patch 4/4 in
  https://lore.kernel.org/linux-perf-users/20261027170415.2815859-4-irogers@google.com/
  (patches 1-3 of that series were applied to perf-tools-next).
- Patches 10, 12, and 13 are extracted from the front of the earlier
  lock_held() v7 series, with patch 12/13 split into two commits and
  updated with !CONFIG_CGROUPS CO-RE guards and NO_LIBTRACEEVENT=1
  support.

Ian Rogers (13):
  perf off-cpu: Bound callchain length in off_cpu_write()
  perf off-cpu: Fix swapped PID and TID in direct off_cpu_dump() samples
  libperf evlist: Recompute CPU map when an evsel goes system wide
  perf stat: Give non-perf_event_open events unique IDs for stat record
  perf stat: Preserve per-evsel CPU maps across stat record and report
  perf pmu: Don't treat tool PMU as a kernel software PMU for event
    grouping
  perf evlist: Enable tool PMU events when starting a workload
  perf stat: Respect the enabled time of exited user_time/system_time
    events
  perf stat: Fix --bpf-counters with non-bperf, hybrid, and mixed events
  perf bpf-filter: Fix bpf_link leak by using PERF_EVENT_IOC_SET_BPF
  perf bpf-filter: Copy bpf_filters in evsel__clone() and close on
    evsel__close()
  perf bpf-filter: Support BPF sample filters on tracepoint events
  perf parse-events: Route non-field tracepoint filter terms to BPF
    filter

 tools/lib/perf/evlist.c                      |  12 +-
 tools/perf/Documentation/perf-record.txt     |  14 +-
 tools/perf/builtin-stat.c                    |  37 ++-
 tools/perf/tests/event_update.c              |  43 +++-
 tools/perf/tests/shell/stat.sh               |  16 ++
 tools/perf/util/bpf-filter.c                 | 225 ++++++++++++++++---
 tools/perf/util/bpf-filter.h                 |  10 +
 tools/perf/util/bpf_counter.c                | 115 +++++++---
 tools/perf/util/bpf_counter.h                |  14 ++
 tools/perf/util/bpf_counter_cgroup.c         | 145 ++++++++----
 tools/perf/util/bpf_off_cpu.c                |   4 +-
 tools/perf/util/bpf_skel/off_cpu.bpf.c       |   2 +-
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 101 +++++++++
 tools/perf/util/evlist.c                     |  34 ++-
 tools/perf/util/evsel.c                      | 150 ++++++++++---
 tools/perf/util/evsel.h                      |   2 +-
 tools/perf/util/header.c                     |   5 +
 tools/perf/util/parse-events.c               | 179 +++++++++++++--
 tools/perf/util/pmu.c                        |   2 +-
 tools/perf/util/stat.c                       |  18 ++
 tools/perf/util/synthetic-events.c           |   7 +-
 tools/perf/util/tool_pmu.c                   |  30 ++-
 tools/perf/util/tool_pmu.h                   |   2 +
 tools/perf/util/tp_pmu.c                     |  55 +++++
 tools/perf/util/tp_pmu.h                     |   1 +
 25 files changed, 1057 insertions(+), 166 deletions(-)

-- 
2.56.1.750.gf70dc682cf-goog

