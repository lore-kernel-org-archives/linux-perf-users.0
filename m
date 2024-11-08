Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A371D433B;
	Fri,  8 Nov 2024 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098506; cv=none; b=UD3U+ii7g4b3Dc7Nj3EF/yvkXV815lsEpxR4Wl5nANPTfr5Zjt2XBpvVfi7c3+TRxlDuBET9YrVlFl6zh4M45kcwEd+EHtHCwDCzOKhzDJuEuqfv8AQwiShjekkJBXHpDBp8ZRlWdnHsDmKQp5pgGWQe3K0bOS5GZzaQJR4CdYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098506; c=relaxed/simple;
	bh=y3DsjrvyJyv/t5lx4Njw3z63FZ+UaLMTSt8dT3OM85U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kdQx7jU3kZAJO2XDGa8xu3d9jRlEV5Q8XNM8EQfwhV5ILEnlHgXMhrhvN+i5OSWdbUZArMwdDiJEcPP1Ggx7vCuRLQWgEaygyJQVdi3Kv1Lif5kp25mhLEvFoYmraJcQThSbgjdsIwo8jpok9u+E8wnRWVRJtQ6beGeafinACPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuL+Ftu7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuL+Ftu7"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-72410cc7be9so1802985b3a.0;
        Fri, 08 Nov 2024 12:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731098504; x=1731703304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mgtNKAkUMbTToa6H1q713jw8/jIoFzb2lWM/9uORDx0=;
        b=MuL+Ftu7s53P73QSLuTUytfKHKH50GC+xDPwi8OOpyDMnEy8tu93VeR+eDJGhbpI3i
         KZYtyHvE3hlo12iQCQNz7wXlwfjuQ0wyvQ23I2E28+PGEgVitqJe/wJGh9401BOVXt4C
         3aoLCh11ZlcAOfRPUVX7QDadSNXdxKdB+9ZTuRlNOuKMyh6nx35MVjOhT8lca57guSTx
         vCdt/QB9m+Jzbnnb7k5j1F0X03Abid6l9Bl/K0ApLv6h/dZ57NeSdydwe8+u0OnE36AH
         Jv+O76tpW/QyeX2yk3HMkHYAleNhk66mTRujOIyhDJ2Ld5ph52LpUoOcwO//BWUf/Nxp
         COIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731098504; x=1731703304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgtNKAkUMbTToa6H1q713jw8/jIoFzb2lWM/9uORDx0=;
        b=Ik/vKcCDXPKVmQIMz4cG5SPpo2SkLi68aGSH3UgI8VR2otcHEnsEPUzVAb5mk6wt2K
         TUBhPP+AMBD5yXoVAaK/zLRpuKBoahBMZTI9NsGSL8rWGqcI9imwGOGlKlY5MXCYv6ot
         UasT9FROg6zLX/qBDISLOsoBCv2kfaCS/RYPAzeyChBILK3gjNydclGRXxKPRikePVOT
         pNSycwbzNMZ7XeGOqysY+YJv3NcIyLU/Irk48xCb6inUj/5P3JwXGi9iFO2TWxuzXMvc
         p5bTNdSCC34BGwmJabtnfSg8QNcoyUyMSeIklDBb8ssTlZ78icAp1FXxSiLZIzGWCKUY
         d6PA==
X-Forwarded-Encrypted: i=1; AJvYcCWl7Mxsvm84TUclMm+0xfl5T+o4H8Nc2V6eFouc0V3bubcz6XLm+kTGIbM2yQyF3Yg4Jcv1+SDvohgDOKzgQoMUwQ==@vger.kernel.org, AJvYcCXlmzLEXE/qUHQHq/sY8tZKRx8jvYt2TDsI2nOE3LYHkOPgmPKoIxHmSOwxuEMN5BuqsKRiel5+KDQxnec=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUiBdQmJOo5PY2TZ4pAELV8hNVQ9EUBUJE4PvUuRAZph5h2ayy
	Fk01VaGn2So+/2FDqCkfL9zloVJkvXsAaDa5A8AA0tIz2UGx+RJh
X-Google-Smtp-Source: AGHT+IEGLlTeWN1vINgIJupTve0EUAhEpv8rE7D1QK9bIOM3AHyYD9brwPKlGVKV7J6q/1qOQgk9VQ==
X-Received: by 2002:a05:6a21:3396:b0:1dc:ec2:e9fa with SMTP id adf61e73a8af0-1dc22b43bbfmr5652654637.39.1731098504577;
        Fri, 08 Nov 2024 12:41:44 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffe3sm4221945b3a.2.2024.11.08.12.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:41:44 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org,
	peterz@infradead.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mingo@redhat.com,
	mark.rutland@arm.com,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v7 00/10] perf record --off-cpu: Dump off-cpu samples directly
Date: Fri,  8 Nov 2024 12:41:27 -0800
Message-ID: <20241108204137.2444151-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
 tools/perf/tests/shell/record_offcpu.sh |  31 ++++++-
 tools/perf/tests/tests.h                |   1 +
 tools/perf/tests/workloads/Build        |   1 +
 tools/perf/tests/workloads/offcpu.c     |  16 ++++
 tools/perf/util/bpf_off_cpu.c           | 115 ++++++++++++++----------
 tools/perf/util/bpf_skel/off_cpu.bpf.c  |  85 ++++++++++++++++--
 tools/perf/util/evsel.c                 |  34 ++++++-
 tools/perf/util/evsel.h                 |   2 +
 tools/perf/util/off_cpu.h               |   3 +-
 tools/perf/util/record.h                |   1 +
 13 files changed, 264 insertions(+), 56 deletions(-)
 create mode 100644 tools/perf/tests/workloads/offcpu.c

-- 
2.43.0

