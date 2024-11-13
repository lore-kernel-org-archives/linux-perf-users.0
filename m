Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7933C0C;
	Wed, 13 Nov 2024 00:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457703; cv=none; b=te4rjglw8UZ+AhSMTYGSGzQeESCxb8U+hiSIcFIzFQSBuo83nySVbW5BfCTgQsJ5s1wuQVLF3Pff8JN1kUWqv6xHCTv/BXyhP7LvKO/M6s6akbEHW6ZiJs4ytpYxf7r0UpA4xM8iZK1CeLcWcGPIa5YsxI7fgDLIjxanY1tm8Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457703; c=relaxed/simple;
	bh=TIyCo5T9LHP74xPER7cR4Zj3zBwHNP6/+8kfAsjCvtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uGidPq14frgf3iupL+xndjAv6qPBAfxPITOLCCB+dZ2ALRO0+Xy1EkNL9cMIAI3KS5SIfsIHKdMovACCsWHdgTUKNt/ubz/90KIjhO+clv4x/mnMxEXtRBVHPmqy5ltN8g8lfJSgXalNvJzKghuv36VMxxRPfMb80F7bHnhTLRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lN7eiZlv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN7eiZlv"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ce5e3b116so56180885ad.1;
        Tue, 12 Nov 2024 16:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731457702; x=1732062502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HeJx4f/doTM5rrgRndUVTXYY1qNuiNyXI+q37KwJf4A=;
        b=lN7eiZlvxuzm/aFu5JI5aykuU36ZGxiWAIT7SQcOMDWf7ehrpESUFCUYBzmwgXzeXY
         Dn1hI/qsXRvhcDnlaSmdc2h2CzY0mIAdAMveq4FUyikPg9goWksk9Sfs+rRXPMDoE7YO
         0hEbroSutsRtH7p1ll2KQJ/n1CrGZXR/TOhyOBJjxnBqJJQU+THXw+WkMg0cuLekEVuA
         u7FGR78Q193QveDjR9CVrwspH+yOObFCRFGHgvuXVJmeuvrdZGZeGsF7L6YfVyXHjXpP
         IFBO91TJLBBVaDfuqhaJoTLN6Dya89JMwxMM0aZ0FxnnZcPzYXcuh7PP8TlawjovpjSv
         VGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731457702; x=1732062502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeJx4f/doTM5rrgRndUVTXYY1qNuiNyXI+q37KwJf4A=;
        b=t6zP0K2XV6ntjR0COEUPFUNx1P7dgK7m1dRB0pZbEixLakCZqpdY9nZ+6Iero1s0nX
         Kq8H90xgD/hSVZ3x3zhYQsregeLB9ufZxSgHWj3d1tUyU1zKPnGSqjNBvWbDzv6v+aPH
         7m9Ab4s/5pnToZ+7Fq4NSNCakkfc/g2SXu+GYyZQDQwfonL3yS5OSQJIpCI9+U+h6up8
         zf8+QpklgcY8G/3ynLYCnSTQZKF+ftT17igYTTpAtdQ+lTQO3NkEQCfJQ1eswBw3ACk3
         zeRP4cS5N7uf+wQT+G6R/Q4JlFVrMySlF3KL9u22GnqV44tnkNed0vGpKsvMHKzD8ZxO
         VUZA==
X-Forwarded-Encrypted: i=1; AJvYcCUif9So/axG5lkBayF6D3R4EIZn8xuUMZ4pqaQbUOOw0R1/jM2p3PavTeQei/Rv3qKMfBgcGrZnizs5kNc=@vger.kernel.org, AJvYcCV4lT/Bf+Q+2+K47SgKD7mTx5N/TiLRFWdRLzykAvMxYH1b9zblMH9ehZq8b9USn9VdZaCBF4Jwq8Da6HzW5DQ3yw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/M3HmAayzw9A63j7idUgwZLG5+i8WPRidkbAsO86K99isv85d
	YlPrlLZFwxmEro0XzzyhCu1vcVLHH8n0uoMF/BVKr8EASBIEvFKCCtNwZtettb8=
X-Google-Smtp-Source: AGHT+IHy2dNX/we2wD0LCjSiLT2/abXJ7kxLWUjXZay3GkMDebHYcE/IpaNN9L39z0qbCA5NulKSPQ==
X-Received: by 2002:a17:902:cf02:b0:211:6b68:ae89 with SMTP id d9443c01a7336-21183e6e6f8mr208682075ad.54.1731457701564;
        Tue, 12 Nov 2024 16:28:21 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e458bdsm100158425ad.133.2024.11.12.16.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 16:28:21 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org,
	peterz@infradead.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mingo@redhat.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v8 00/10] perf record --off-cpu: Dump off-cpu samples directly
Date: Tue, 12 Nov 2024 16:28:08 -0800
Message-ID: <20241113002818.3578645-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v8:
 - Make this series bisectable
 - Rename off_cpu_thresh to off_cpu_thresh_us and offcpu_thresh (in BPF)
   to offcpu_thresh_ns for clarity.
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

 tools/perf/builtin-record.c             |  26 ++++++
 tools/perf/builtin-script.c             |   4 +-
 tools/perf/tests/builtin-test.c         |   1 +
 tools/perf/tests/shell/record_offcpu.sh |  35 ++++++-
 tools/perf/tests/tests.h                |   1 +
 tools/perf/tests/workloads/Build        |   1 +
 tools/perf/tests/workloads/offcpu.c     |  16 ++++
 tools/perf/util/bpf_off_cpu.c           | 117 ++++++++++++++----------
 tools/perf/util/bpf_skel/off_cpu.bpf.c  |  97 +++++++++++++++++++-
 tools/perf/util/evsel.c                 |  34 ++++++-
 tools/perf/util/evsel.h                 |   2 +
 tools/perf/util/off_cpu.h               |   3 +-
 tools/perf/util/record.h                |   1 +
 13 files changed, 282 insertions(+), 56 deletions(-)
 create mode 100644 tools/perf/tests/workloads/offcpu.c

-- 
2.43.0

