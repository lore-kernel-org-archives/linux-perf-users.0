Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B33139D1B;
	Thu, 12 Dec 2024 02:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970290; cv=none; b=ARxF6tJGhbgDbijydInBVaU1beDGgE8z/YOnt5gU+hwocBpYp1F5KsxvMNnwKyW525saKvsVBZEUz1VKzP/JkZqkOMCFjaOulnYqISPHlSstw9ImvSBg5HHCKhdPbh0azk2eIKfOB8R/kwGvYhdEOsxnzIT2bzPbO53s5gXCuFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970290; c=relaxed/simple;
	bh=1Vq54nFGZI2LD8bqlPpxggZBMaIR3Ih1Mv73QV77RwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GJNTpKnnTttLVHoq4jp7PHwjorvbwSWbfQQozcwIr5eS+M2C6g3Y+HFnwRkAzp04BeFYrFYz7UIOFXZl99krw+Hz8sf89AD9jZwaiw4T9ToZ5FXCR19Mjo0g4uGPvs49phbJ30Z2YUHRtdRXDMLTEFHaye9DsiP8gwel21CllW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pq48H079; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pq48H079"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso60929a91.0;
        Wed, 11 Dec 2024 18:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733970288; x=1734575088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MIOEkCCUVr1M8Q/rXf2ejChYeCgi49uuHnM0OItqbkY=;
        b=Pq48H079Ct+AhCAKaC/lbskiRNZpGnbCtQ+cWdqJqN8cKRUk63lAGIG+NZGQdUMGyF
         y4dyaWrTpobPMJD2kY2LdsdRVBG8MArxwJTixarTDrTTTxdxgvDL8r8/FSfVv0atKebe
         fpVLcYsRNO4440N6So8F7hSRsP9yox9/umnY1fdmjXa68Cl6O35ROlet0zcoK1+tPxwY
         zV1RFs81hrl8xIcifgmIN2QtYbndub21n10swtueb1ldbTU/AU97OuJoeG3Gpffv2MjR
         doyvJ6KjQE+vB3CwTlW+pY2nV97l6UGVnkkETdfnvXCOSFZZBzjq0bF+SRTdXNkS9oxS
         6oSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733970288; x=1734575088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIOEkCCUVr1M8Q/rXf2ejChYeCgi49uuHnM0OItqbkY=;
        b=nQoYdOyExmA5XwAudE8UkLjQBePYFv8dDhTIJpi/3XD835+Tagi9Vo/uCOt2yHpmW3
         K+6pjwzwET9bEx73r6aV4qBQQaOAIDOYT+GrqLQgviLhkvJtDpD57lo9aejaAeLDGaHl
         wW9MfHYlWsitcocNOnHjRJYhusXfsT/7AuFySItmJWyOjH76wPjg9injGCkuYQpfoS3V
         oAzBynWyz12pcLwX9sV9GgRrKVG2+3+y+VGMQ++FJ6lFJ0vnXg4OljkbOSam20hBaHPG
         1n9+GWofineKTUjLV51Gt5fHsQzGTzsWDvH0goIIVvhCLI31aKLHlNlw98Y2HdDS7CZE
         4KVg==
X-Forwarded-Encrypted: i=1; AJvYcCUPLTy4UOKX2gqI4oxVM2PdZ6zKVATt6FKsyp2pfpGpm9lTWnq+p+WwW2HeCy1it9zJUfQN4Xdee8F6g94796T0GQ==@vger.kernel.org, AJvYcCXEXXBKZtGcojqLC4HOBzq+D+OD6ok9QQTXW1WRQ8v3e4UeedrY0CjtTp5vnnyGaLg/LmktQcjC9qo5vPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0rjpqlwLMbaXK92sTF3QGsjtEoman4oFln2smQKfkxtSx8oXf
	OZIPSlmhip2c/SiWejQdjTwZlSFplYHV14n/llPqmKjON4ELliF3
X-Gm-Gg: ASbGncsHqPX438sdYwQn3Eyw+lq0HnD0ziHv/TNwTXfdVPYPqQ+rHlPoD4f8stVn33Z
	btFyQJ/SC3dPZZvh3seuV2DnluiedGcxRn586aacIt+aFqeVZT3iT3h3n/614fOA0GtptFNoaSu
	yXIVGRlECPFjh97XSwnayoqS4g4HOWvblEwJ8HiH7QF2TB6dPskNuWeRMGbrS48xJd+qvjeCrPz
	bPN0JVM8EjVrzuMDzfHX1vwuVNnRIHq2a71+P9en5TFplYx1vKePI9kMG6xQO8I3wAyu4PxHzkk
	EWNgd9zyH0Kh
X-Google-Smtp-Source: AGHT+IEv+8uHT5ZkrH77TVt8eyID5Hnjtvv1X71iIArU2Ivk0lhaFLpMd6v4YCxYG7lOyPpC11JfOQ==
X-Received: by 2002:a17:90b:3c83:b0:2ea:3f34:f18f with SMTP id 98e67ed59e1d1-2f1392b75b0mr3200417a91.19.1733970287636;
        Wed, 11 Dec 2024 18:24:47 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142daeb5asm112583a91.12.2024.12.11.18.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 18:24:47 -0800 (PST)
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
Subject: [PATCH v12 00/10] perf record --off-cpu: Dump off-cpu samples directly
Date: Wed, 11 Dec 2024 18:24:10 -0800
Message-ID: <20241212022420.1035999-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v11:
 - Restore patches bisectability, as the ordering of patches has
   changed.
 - Change 'us = ms * 1000' to 'us = ms * USEC_PER_MSEC'

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
 tools/perf/tests/workloads/offcpu.c      |  16 +++
 tools/perf/util/bpf_off_cpu.c            | 118 ++++++++++++++---------
 tools/perf/util/bpf_skel/off_cpu.bpf.c   |  97 ++++++++++++++++++-
 tools/perf/util/evsel.c                  |  41 +++++++-
 tools/perf/util/evsel.h                  |   2 +
 tools/perf/util/off_cpu.h                |   3 +-
 tools/perf/util/record.h                 |   1 +
 14 files changed, 297 insertions(+), 58 deletions(-)
 create mode 100644 tools/perf/tests/workloads/offcpu.c

-- 
2.43.0

