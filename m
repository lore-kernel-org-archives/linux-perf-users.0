Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B4E1C1F22;
	Wed, 11 Dec 2024 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954425; cv=none; b=RCEDBQ3rtDrczCwU+Ru4DVSoTE5gAP95AfSJtprH4gqYRcUoYSqy71xlKpu5P8xkmZoN4MPOXEuKLsSWxULBIldaSRpuTdNOKwwHU/to9rEff5oK5IMOt4xgN/n2qwfsh9AJJnUAkD6YJm4E5ROa8CE2soauSXVaFWYLzaTvq9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954425; c=relaxed/simple;
	bh=zVpZKbWs32DCAAa+NhyZzfy/nSJyPSbmcjjOe1UggJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eLroJPimAbsaZZhOrnaYSk6Elmq37KO88573Kd7k84gzP8c1B+hRbs4aJqr6ncQvSUlLpfkwXaInhPrClO5iRRjxUBwWwTeC+30FllGWs0RSmWwD0C8hFiuwEB+qYiDgP1MmhUIATFPmFcweBbFXKIwLWyVX7/RCyg7GJF0gsGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCR/oiRj; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCR/oiRj"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ef760a1001so4656392a91.0;
        Wed, 11 Dec 2024 14:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733954423; x=1734559223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0JGH/B9D7zR5mhZlgnOVlQ3Ron7J43KUmelywXNDFWQ=;
        b=LCR/oiRj4bYdNeV5kIbTRc0wG1gyEiU7Uldo5pdtY9CVlXx39y3H2U2UJbMzM8+rLx
         c9/lYtcsGKITFdplhpMibl+mOAFP93DCQctQeqyH9UVnF+ox66uu3zPPtJ3f5U9EnvlR
         wV8JYjp+qKsLdeDGjPSpMI43i+YXIJSIxOQqvAyq8sjc8lMNAWIxvZPbQgG4/BXBCKdx
         utIc6WpKHF42cfnNwQkcY0CEUaAhOrXmqRCOxk7mDwKVe4Sy5DTm5KdX3RB9YcQwgcps
         QY5ipeFkfh9So58iU3FiFUUZ4Y5tgBPaF5vMZVSrJNcFs7E6PkXrYnwe35ZL3JT81w/G
         8QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733954423; x=1734559223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JGH/B9D7zR5mhZlgnOVlQ3Ron7J43KUmelywXNDFWQ=;
        b=VSLloqoHVlU05vqzlGTTSk89KMlHJaNyWlS/G5g0DAfcpIXYaDdB5/ChffYp0tnSWL
         gdaLU4gMXOP9vMY7oZweUOohM7M0KlfOTS4aBiZMqWePwctJ9v8adnRPs65stR3Xcg03
         Re6Vm6v4uOzOlaZ66wOFtnSzNqvGLLYiGc3XEenmUC2d8FRRICj7f5Lrjr2JMSO7CHrR
         +/dOhGdq1RBb2sYGleg6/b92VHiI4TC+EI3LzxEJV9pQCGtb4Si2GT1uLFI5M7AKIicv
         3G9Bm5ewMBULx9X4rfLanvRbjlJt9evKsp/wYhHm2NiBnq8EnfXP/kaFXiOmhE0TvduC
         c35g==
X-Forwarded-Encrypted: i=1; AJvYcCUR7LaYTHRtnuQAC2Mj0W0B//AJ/Fcapqu+2zK46nNNUfi3seB+f1GygLC4Mxk/R/ED8ybN6ucXI4ElXewRhHj46Q==@vger.kernel.org, AJvYcCUSD+khMsaKq228DB+e27A3mlDFEpsV7wYR48W4YvM51SHwYN9OgLHCJAafcpzo1QfsazSFmkNYg8hlre8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5PTq9xbYmRBYqdY//R3WVCNeQKBLrC8NvGE1OfdeIxkgr8bYo
	Sx2830hEd64IFe3AykPQuMorAsqOp9ySZ++6qzVaqDDBGGPJ2r2XwLoDHHLk
X-Gm-Gg: ASbGncuTojiytYObil7ngM++Di9wBZ8h1+yiWsAuCD1NahcpvcGYV+cN1thmsYUHCTd
	U5XOS8Uf0tPmlJpd/ugO4QlFG4np13D1b2PW3UWJ1zuYWT2WK/nADB4YhyeSlLYdhW+LXD7Yhi5
	hNL8NA1AqjKGBWzJwg8dXkVuqiaUYUN0FYO/6oK+twwARHoGnK9oP/C7FLmkk/YH9B4s3kgHym5
	gLXQSfRzHqli4mPJrNYwtYkbQ67cGVJUGcMXRKPSn09uA59xjIEBlq9XVdf98QdTVUDWHCjIo0O
	aWICP2ZBnw==
X-Google-Smtp-Source: AGHT+IFdetYwNbuEiA8NOSiM/Qo0SJ8IN5ep5wcobTX8niXWmx8CByxwQyMvLhNw/cconxG7Nh1c+A==
X-Received: by 2002:a17:90b:4c84:b0:2ee:ee77:2263 with SMTP id 98e67ed59e1d1-2f127f50d18mr7897145a91.7.1733954423457;
        Wed, 11 Dec 2024 14:00:23 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2700cccasm13912665a91.22.2024.12.11.14.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:00:23 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v10 00/10] perf record --off-cpu: Dump off-cpu samples directly
Date: Wed, 11 Dec 2024 14:00:04 -0800
Message-ID: <20241211220014.931479-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v10:
 - Move the commit "perf record --off-cpu: Add --off-cpu-thresh option"
   to where the direct sample feature is completed.
 - Make --off-cpu-thresh use milliseconds as the unit.

Changes in v9:
 - Add documentation for the new option '--off-cpu-thresh', and include
   an example of its usage in the commit message
 - Set inherit in evsel__config() to prevent future modifications
 - Support off-cpu sample data collected by perf before this patch series

Changes in v8:
 - Make this series bisectable
 - Rename off_cpu_thresh to off_cpu_thresh_us and offcpu_thresh (in BPF)
   to offcpu_thresh_ns for clarity
 - Add commit messages to 'perf evsel: Expose evsel__is_offcpu_event()
   for future use' commit
 - Correct spelling mistakes in the commit message (s/is should be/should be/)
 - Add kernel-doc comments to off_cpu_dump(), and comments to the empty
   if block
 - Add some comments to off-cpu test
 - Delete an unused variable 'timestamp' in off_cpu_dump()

Changes in v7:
 - Make off-cpu event system-wide
 - Use strtoull instead of strtoul
 - Delete unused variable such as sample_id, and sample_type
 - Use i as index to update BPF perf_event map
 - MAX_OFFCPU_LEN 128 is too big, make it smaller.
 - Delete some bound check as it's always guaranteed
 - Do not set ip_pos in BPF
 - Add a new field for storing stack traces in the tstamp map
 - Dump the off-cpu sample directly or save it in the off_cpu map, not both
 - Delete the sample_type_off_cpu check
 - Use __set_off_cpu_sample() to parse samples instead of a two-pass parsing

Changes in v6:
 - Make patches bisectable

Changes in v5:
 - Delete unnecessary copy in BPF program
 - Remove sample_embed from perf header, hard code off-cpu stuff instead
 - Move evsel__is_offcpu_event() to evsel.h
 - Minor changes to the test
 - Edit some comments

Changes in v4:
 - Minimize the size of data output by perf_event_output()
 - Keep only one off-cpu event
 - Change off-cpu threshold's unit to microseconds
 - Set a default off-cpu threshold
 - Print the correct error message for the field 'embed' in perf data header

Changes in v3:
 - Add off-cpu-thresh argument
 - Process direct off-cpu samples in post

Changes in v2:
 - Remove unnecessary comments.
 - Rename function off_cpu_change_type to off_cpu_prepare_parse

v1:

As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=207323

Currently, off-cpu samples are dumped when perf record is exiting. This
results in off-cpu samples being after the regular samples. This patch
series makes possible dumping off-cpu samples on-the-fly, directly into
perf ring buffer. And it dispatches those samples to the correct format
for perf.data consumers.

Before:
```
     migration/0      21 [000] 27981.041319: 2944637851    cycles:P:  ffffffff90d2e8aa record_times+0xa ([kernel.kallsyms])
            perf  770116 [001] 27981.041375:          1    cycles:P:  ffffffff90ee4960 event_function+0xf0 ([kernel.kallsyms])
            perf  770116 [001] 27981.041377:          1    cycles:P:  ffffffff90c184b1 intel_bts_enable_local+0x31 ([kernel.kallsyms])
            perf  770116 [001] 27981.041379:      51611    cycles:P:  ffffffff91a160b0 native_sched_clock+0x30 ([kernel.kallsyms])
     migration/1      26 [001] 27981.041400: 4227682775    cycles:P:  ffffffff90d06a74 wakeup_preempt+0x44 ([kernel.kallsyms])
     migration/2      32 [002] 27981.041477: 4159401534    cycles:P:  ffffffff90d11993 update_load_avg+0x63 ([kernel.kallsyms])

sshd  708098 [000] 18446744069.414584:     286392 offcpu-time: 
	    79a864f1c8bb ppoll+0x4b (/usr/lib/libc.so.6)
	    585690935cca [unknown] (/usr/bin/sshd)
```

After:
```
            perf  774767 [003] 28178.033444:        497           cycles:P:  ffffffff91a160c3 native_sched_clock+0x43 ([kernel.kallsyms])
            perf  774767 [003] 28178.033445:     399440           cycles:P:  ffffffff91c01f8d nmi_restore+0x25 ([kernel.kallsyms])
         swapper       0 [001] 28178.036639:  376650973           cycles:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
         swapper       0 [003] 28178.182921:  348779378           cycles:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
    blueman-tray    1355 [000] 28178.627906:  100184571 offcpu-time: 
	    7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
	    7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
	    7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-2.0.so.0.8000.2)
	    7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.0.8000.2)
	    7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
	    7fff24e862d8 [unknown] ([unknown])


    blueman-tray    1355 [000] 28178.728137:  100187539 offcpu-time: 
	    7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
	    7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
	    7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-2.0.so.0.8000.2)
	    7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.0.8000.2)
	    7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
	    7fff24e862d8 [unknown] ([unknown])


         swapper       0 [000] 28178.463253:  195945410           cycles:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
     dbus-broker     412 [002] 28178.464855:  376737008           cycles:P:  ffffffff91c000a0 entry_SYSCALL_64+0x20 ([kernel.kallsyms])
```

Howard Chu (10):
  perf evsel: Expose evsel__is_offcpu_event() for future use
  perf record --off-cpu: Parse off-cpu event
  perf record --off-cpu: Preparation of off-cpu BPF program
  perf record --off-cpu: Dump off-cpu samples in BPF
  perf evsel: Assemble offcpu samples
  perf record --off-cpu: Disable perf_event's callchain collection
  perf script: Display off-cpu samples correctly
  perf record --off-cpu: Dump the remaining samples in BPF's stack trace
    map
  perf record --off-cpu: Add --off-cpu-thresh option
  perf test: Add direct off-cpu test

 tools/perf/Documentation/perf-record.txt |   9 ++
 tools/perf/builtin-record.c              |  26 +++++
 tools/perf/builtin-script.c              |   4 +-
 tools/perf/tests/builtin-test.c          |   1 +
 tools/perf/tests/shell/record_offcpu.sh  |  35 ++++++-
 tools/perf/tests/tests.h                 |   1 +
 tools/perf/tests/workloads/Build         |   1 +
 tools/perf/tests/workloads/offcpu.c      |  16 ++++
 tools/perf/util/bpf_off_cpu.c            | 117 ++++++++++++++---------
 tools/perf/util/bpf_skel/off_cpu.bpf.c   |  97 ++++++++++++++++++-
 tools/perf/util/evsel.c                  |  41 +++++++-
 tools/perf/util/evsel.h                  |   2 +
 tools/perf/util/off_cpu.h                |   3 +-
 tools/perf/util/record.h                 |   1 +
 14 files changed, 296 insertions(+), 58 deletions(-)
 create mode 100644 tools/perf/tests/workloads/offcpu.c

-- 
2.43.0

