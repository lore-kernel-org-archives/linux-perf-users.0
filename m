Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16FC22D793;
	Thu, 13 Feb 2025 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487616; cv=none; b=u1PCcesd1ce97JLOd1A5psyccGMiai2CCQuxz0aF+zyvOMMzgIYB9k5PahXubq8i01hfvzXsFd1dw8N6T7lHanI6fSvIxcuR+K7he2D38MFYvFLk3Ukn7HVwPWxGepbKGLxzKG0szbn5wA53pKevDpLur4mQR6Yb8TYw3NHtho8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487616; c=relaxed/simple;
	bh=NZnCqDkOhajZT2bOObOrNs/a6LW7+uo/PJNgqAQZ6KE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DqVPl83QaARw63jMxw4gW/En4jXyThhItMW6VFXqR28bLuepGKNESDSQdu3E67LseGKXVzcgJB3gpg6hox4WlFwiPRwple5pH9wSgx9cZAFVqQFWED5qQRZQQKKNc90+tbXmcMsuIR5S7dzc65CyEEFrimPb1QJBAhe41KwKtAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIjUfO6t; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIjUfO6t"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f62cc4088so26185655ad.3;
        Thu, 13 Feb 2025 15:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739487613; x=1740092413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fm+qJgELrQ3bndRl/HLXGm1wcqOr9YUYYiUv1Q3uwuo=;
        b=OIjUfO6t6qszqf6T8qJnjysADhPKc6ZdUAkVgNKOjl2v9NY0/1aSuOULKvk7z3KpOI
         EvRTOgA93pU2/40RIG5TTHDFe8rz31v5ewaP1J/J+5ar3mbq9/vy2LzMjDIgmMim03Q0
         LjL3jpg/GOs+4YtSHRa3SZp+owXEsEuOA1PDGWapEyY60Y97LWoRiVsj3bx5u9qu7/u7
         QeMqTX5fjZIQWKHPU7pY73qAXNkNSfkJQ5AnNFl0MYQPowPLeRerSmmL3KjqYqfv3qlV
         VHfUMuJPQv73Nng8+74YPoTCbC82RWtuCi2zaA0i3BHhYCmNoWcZUq0a4WwmCbQoquME
         CpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487613; x=1740092413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fm+qJgELrQ3bndRl/HLXGm1wcqOr9YUYYiUv1Q3uwuo=;
        b=lcDEW4ISUuqbRz2zgoyXUzOIqqbGNFvATwhnQkKjPx3ChZzx3tskt+duaYobTV/k0L
         Clt0WW0928GJJ7Z2CVUbBcNGbfFmWMxkZq51NMFOwDBdJXw736LVX1nIfvF+b9PgC9gS
         UmdUW1PxC0UmSHZxwj2fLw+us0Q/JSNi5oWRkqTeS9h1vW3puImF/5llfBGLfblLBWe6
         iQwV+6B5IKOrV/UhGl7aypJrIwGhQbRdYHPan6I9YvV+QdQn8TKLCObp7dOjC287Wgn2
         804nQ/+l/lmo/WljmvCS11C1+rotS+S7SZo4g7OiIXQS5gGEPesGWB9l+wDvIfUa+JUg
         l3Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWHOywYqQe4n3u/O6xkvTEjC2QQw5gPbhqzjphzHeKRTxPJ55KkWvuYSJpTmEKMoOnaoA9vF3/XRn2DD4w=@vger.kernel.org, AJvYcCXjprgNnfHxW+Q2AknDRfALQ2KNbO0F7cJh/NXIgMPF22oTy7sOIEjqbOwVZvLDLRtm5eVorjnC87rCTPZRHqx0qA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNGXJerEhKmTXM1Sepa/8TbOJ8uAoXl2T9IXyepE4gfJDUMVpN
	o259ycuqztK7GanY+cIJfZB07x+F1eriUQwoG/Qu9yaETch5sSUg
X-Gm-Gg: ASbGnctUGyUxj9SrGFKxY86YyWF/8BE/5X0O/a2jt3kt+WLzyixJZdbCP7CZ6lHz7Fn
	jpg1EmhOgo9AtSpYJWhcGhdSXinoh7LTM08r7EK6RK6vhUsOat51eQdpTMcv4BrNZqsva1yqI9Y
	Z0NOLMOBc3wWsNkzAppMud+o/MxrFBCkJBieQ1c/PBD84m+qSiBv5NMKM1Yk5olK2auPalwuduH
	h5P6DrqW42Y125gbockl3989GdDEKdw4W+K6sjxRxdgOFa1vpmNSA+WBvIb26fUTM6cRWPZMLx/
	dGuHxQbQJFBynnLFrXDfSsKn1UOg21KTUtSCobr2+huwZsc=
X-Google-Smtp-Source: AGHT+IF0YEokBg/Trf9tygD8uDJ6kk54EDGR0Hs40vOpYJdsHIwRq4vgui0cLy7+ckTO/hLFyNPOQA==
X-Received: by 2002:a17:902:d549:b0:216:6901:d588 with SMTP id d9443c01a7336-220d1ed1f92mr90870315ad.15.1739487612799;
        Thu, 13 Feb 2025 15:00:12 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349210sm17641735ad.11.2025.02.13.15.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 15:00:12 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v15 00/10] perf record --off-cpu: Dump off-cpu samples directly
Date: Thu, 13 Feb 2025 14:59:59 -0800
Message-ID: <20250213230009.1450907-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v15:
 - Fix workload recording bug pointed out by Arnaldo.
 - Rename struct stack to struct __stack as suggested by Arnaldo.
 - Delete the extra offcpu workload now that recording workload is fixed,
   use 'sleep 1' for testing instead.
 - Add more tests for the off-cpu-thresh option.

Changes in v14:
 - Change the internal off_cpu_thresh_us to off_cpu_thresh_ns, i.e. use
   nsec instead of usec

Changes in v13:
 - Move the definition of 'off_cpu_thresh_ns' to the same commit as
   dumping off-cpu samples in BPF, and give off_cpu_thresh_ns a default
   value before the --off-cpu-thresh option is parsed.

Changes in v12:
 - Restore patches' bisectability, because the ordering of patches has
   changed.
 - Change 'us = ms * 1000' to 'us = ms * USEC_PER_MSEC'

Changes in v11:
 - Modify the options used in the off-cpu tests, as I changed the unit
   of the off-cpu threshold to milliseconds.

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
 tools/perf/builtin-record.c              |  33 +++++++
 tools/perf/builtin-script.c              |   4 +-
 tools/perf/tests/shell/record_offcpu.sh  |  71 ++++++++++++++
 tools/perf/util/bpf_off_cpu.c            | 118 ++++++++++++++---------
 tools/perf/util/bpf_skel/off_cpu.bpf.c   |  98 ++++++++++++++++++-
 tools/perf/util/evsel.c                  |  41 +++++++-
 tools/perf/util/evsel.h                  |   2 +
 tools/perf/util/off_cpu.h                |   3 +-
 tools/perf/util/record.h                 |   1 +
 10 files changed, 323 insertions(+), 57 deletions(-)

-- 
2.45.2

