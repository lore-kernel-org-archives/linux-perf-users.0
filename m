Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602FC13AA38;
	Fri, 22 Nov 2024 04:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732250327; cv=none; b=EZmbqAXCSgVLeT2DiGyC3nofBpFMT4EfIgEdslMTwTnSHxILX91HhHumtqOcAi3f3J4rF2nxRLywn2SaCt4gqcaCeqnTJXXlbCbiCCAZLqIFlR+te1V2iWx8/LMRi30fKsfBuCKkSBxTOLKv80bPkdquPWGZADJlabJDIPXVcuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732250327; c=relaxed/simple;
	bh=BYhCFmhDMduO3ARbtrswO7Ek3KThv/iO7UkyjNUzd4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BS/eivrKpPaJlAYpmyQ9LEhUjkDsUiYB/OGwq94iQbrTmkgTfvKx7Np2JTL5ttZK4g3/ZoV9ygY5xNk3c7K8px6oXKhWV2FIAjxOcXkIZg6nvvogxQ9gnvCm/QbfzksX6LhmuHSz9s6i/34d7W9vn+QCHqgpaCUojEy4GQcdMaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kotZR0ge; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kotZR0ge"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20e576dbc42so18019515ad.0;
        Thu, 21 Nov 2024 20:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732250325; x=1732855125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/h1pIJ3312yHGYsnEocw6No9r6/oy5ggxyElkApYy6k=;
        b=kotZR0gehuw7gpmVVOiqQ0HlWFn7T0gQWCwmXxvDNErilTp63184/N3tTHVDGFTvOf
         fcYDBfDzNHx1aED9K7A4RFbQs2AZ2RjJtYA9R0PRLI7BYnr5JgpXEQQ1iXAUEDotefqU
         CmUpO2i1tz9eXsCI+X9L6uo12H66+BbG1nHfjDZx7QELLtOHeBhqnsr1Z9jmJmPI4B7I
         H3qx6S/xQxxh9OcGLyM6B/nx30Bpx4/aGuLpWvv27PVE3NQXA+iewW6dSQl8k/u4DfqJ
         iakEkeAFGG47UHEZIMtdXdoIqtTDJO5nEbpYgLiaVIcOZ21NdxYJTUIvr5w4ikeOowfY
         +0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732250325; x=1732855125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/h1pIJ3312yHGYsnEocw6No9r6/oy5ggxyElkApYy6k=;
        b=Pjw422aE3tlEC2pRcNa+X9AludroW6c2asi7YzxDdfOPTcOP07kJ1otGL0hhjITL+K
         sInL59ixAhbVJK6nUh5B93mGcwdfHCHaE5xyst53VIPWZauAgMsKfPq8qrabrRRKjl1j
         Yo6w5qJPA8wbPW+zVaNmxSiaqdufYJT3Rof6MJMvkzNpnhzIc+fElXt5WDqiHrBmya6z
         gIph2rMDaSILg/9qneid0Hs0xdhyUOAmj3PJz/R2eDf0mpArIMNzpTpEyfx5bR0/GxDc
         CvMkfTH08vn1hgzbqNKkURSJZjZH/ti+zw8SsIIaOPdSfdRNwOicG3/QQO7eIqNBL9zq
         16xg==
X-Forwarded-Encrypted: i=1; AJvYcCVcJPf37vil+3liFAE/5eipZemmnrIuX/4eudidre8LuPH7t24fGsux4memLGVomgsj1NBAPLPdybpd/NA=@vger.kernel.org, AJvYcCWQpr9PS5lftRr74t53r/snUMsRI3em6fEcfjpoQF2aCajG2vbh5nK80pIM5O64u8m5OJrbGfJ7L7pVIAxVm0v66A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5DHrKSXZIJb/3t9hFWJ2jt50s+q00zeKAmdqy/gC9XSuyOsew
	4u/ST9Kz6oL+d34DYk5o27aSexrJbLqCjXw+IUhQz5NObHk5ZeAS
X-Gm-Gg: ASbGnct97vY1st95hDuHf8Aj3HClZpAHDHx44O8NN/EALLx8oW9LNkKv7cR90oLRhJo
	VYDgy9dJmmQT9kksx15K8vWZMdN8XpoPso4/UmbCXPDQk82jt8EdrZmfg33/sJIHJWLq7a6S0wc
	N6pV+/pgHq3o6XozJ1/x1OQORK8E7ag4Oyh+OclmnrbtG9XOlSp8bCvg54TBr84BC/h8fF5fhdN
	xLh0nClV9Yde0wJgE0ksaOrcf87Gxf+ULnvrotvBkDRaHLsDSC0pXS25uc6mqEFL6kbVjVbGGSa
	w9LVWM0ketU=
X-Google-Smtp-Source: AGHT+IFO6oUnde6NOV5u1mFyXGXBpHqLezmYbSIyMFQt8O4fcSnZV0ol3PeVv78QXiLXFKqli9S4sA==
X-Received: by 2002:a17:902:f791:b0:211:e66d:7450 with SMTP id d9443c01a7336-2129f6ba4cfmr25119185ad.32.1732250324442;
        Thu, 21 Nov 2024 20:38:44 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc1544bsm6638135ad.193.2024.11.21.20.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 20:38:44 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v9 00/10] perf record --off-cpu: Dump off-cpu samples directly
Date: Thu, 21 Nov 2024 20:38:30 -0800
Message-ID: <20241122043840.217453-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
  perf record --off-cpu: Add --off-cpu-thresh option
  perf evsel: Expose evsel__is_offcpu_event() for future use
  perf record --off-cpu: Parse off-cpu event
  perf record --off-cpu: Preparation of off-cpu BPF program
  perf record --off-cpu: Dump off-cpu samples in BPF
  perf evsel: Assemble offcpu samples
  perf record --off-cpu: Disable perf_event's callchain collection
  perf script: Display off-cpu samples correctly
  perf record --off-cpu: Dump the remaining samples in BPF's stack trace
    map
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

