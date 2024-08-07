Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE8084DE4;
	Wed,  7 Aug 2024 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045136; cv=none; b=lZiEp/jd87Ge7NWp1kBPUObniiv4ZWBDBe8dlkq4bI41TSGbmfxdTKtXV7Vm5EZeSpBHlI8i9E3IhDUlTemEZ/llOHsv5tCPQiIulf1uovIXKzsS9ydfAsWMx/ZWzmtAg1B7pPZCoQEST8q0cwdoQEweHrnql73EMQ4rPCdzZtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045136; c=relaxed/simple;
	bh=2VYp0BI/kPi28iuKF1qBrEFXPnNCKO/C9rxIuPP1jnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q1l4wkE5eApbn3CJid6jiRE9BEmREmOobyyLWGuveJ4g6TqgaY3tr/qeBc1jpw8stzewpquDBB2MgZJdeoVgpvsO2dkoPFiSBjSYqgCsI6f+TpkBrKo4x/Hq2Ao+MobYlzymgbG1xMOZV4SpjuiwHgOgOYtdSDH+tDgDDGbtd3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsR9WEVL; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsR9WEVL"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7a1be7b5d70so956953a12.0;
        Wed, 07 Aug 2024 08:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723045134; x=1723649934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3JFWGoKjky3ndaB5sBCSGzwEOQ6qqMNssjKu1Qp1eRM=;
        b=YsR9WEVLB65xeWXv9Q/RRkrctKJqdHJ6dvjx3Ro5TaTUweLOk8GoWZibvB1bwIqbGG
         pnc7QJxE8z7C+kDcl0cZJjoLfDQJx+j3vBQQ/FZ2LI3OSiSITGGywdpEbobJdO66qmlz
         yUoSgF4aAhNdnz999krrQC0HQgI9sElTzNM1cGliKxvM4JEq6RSOIPCGOJqkoO0x78eo
         FfsX2JrxpqZ496KG5l88OWDpO7x+iUmOz0SfqDe1n2uWWfXXa89bLep8GOxak3fgtnAG
         vtWC2/bXyQHB7ROkbSxmv98/GHTO3/9ACoxIdmZS5jzwuNk6Jg9O73vy6QXcIzK8dVWN
         nN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723045134; x=1723649934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3JFWGoKjky3ndaB5sBCSGzwEOQ6qqMNssjKu1Qp1eRM=;
        b=AXe2DKXe+VVvSXot6qAyCRVDSRgGxWaQak7y8/7rajs65DewuSTFvmu6ZoZnkaxFP/
         ixRZmwJSW6Vf15TNg7mLX5Xa6Ls+j3tdlf/bfkH6kKjiCU76JTq8Yrgp0NBg1hQ+0CWf
         YKwCkim4IM+edWfrUunjJ6aCHLX6fwSjiIWtixWgaPnUGXd9M91VingJGPpqIj7lUBp8
         P+6nK9wIfuacPQu97G6RwlAkJAheojeVJiGHCikF20XB6Qj1JakM4clGOO2TantaKjX2
         hHruXl9skPQu0SeXzmOaK/BPjxXiQ9jOLwAwKHUNb7gSkLdURnT3tO0M1Fr6ZV3Bop+r
         ni+w==
X-Forwarded-Encrypted: i=1; AJvYcCWMzeb1snjRqcWpuan1imWk3wWzQPhNjXcelNQtj/+9F7V0eXR4oMDUQJNPrdEio8s8GLhm80RXNCUn9Mj2Zi2InPFrcsdOgV7SfUpRTcK9+gKAqPz5PGJhkEL1E20p3acWWd/6af052kjHcHgp4A==
X-Gm-Message-State: AOJu0YyHKzXXYPT1yGFwqe6zM2CBF3bAP2Y1XCGQ+hvNNmjGPmhvGPTl
	2togmBnNH8V/HahN4cbbCctHA15fdeGZFU7m6Rl2TCq2gXwRVu9S
X-Google-Smtp-Source: AGHT+IGP+OP4jwPFT7gS6plDcxAgEeDUUx8BYzXV/9E+u+oURvXPxh2384VYFJYiM/i8pSxmsuRMMw==
X-Received: by 2002:a17:902:da89:b0:1fb:77e7:27b2 with SMTP id d9443c01a7336-200854f9c4amr38134975ad.18.1723045133908;
        Wed, 07 Aug 2024 08:38:53 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59297329sm108097375ad.247.2024.08.07.08.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:38:53 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: namhyung@kernel.org
Cc: irogers@google.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/9] perf record --off-cpu: Dump off-cpu samples directly
Date: Wed,  7 Aug 2024 23:38:34 +0800
Message-ID: <20240807153843.3231451-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


Howard Chu (9):
  perf evsel: Set BPF output to system-wide
  perf record --off-cpu: Add --off-cpu-thresh
  perf record --off-cpu: Parse offcpu-time event
  perf record off-cpu: Dump direct off-cpu samples in BPF
  perf record --off-cpu: Dump total off-cpu time at the end.
  perf evsel: Delete unnecessary = 0
  perf record --off-cpu: Parse BPF output embedded data
  perf header: Add field 'embed'
  perf test: Add direct off-cpu dumping test

 tools/perf/builtin-record.c             |  26 ++++
 tools/perf/builtin-script.c             |   5 +-
 tools/perf/tests/builtin-test.c         |   1 +
 tools/perf/tests/shell/record_offcpu.sh |  27 ++++
 tools/perf/tests/tests.h                |   1 +
 tools/perf/tests/workloads/Build        |   1 +
 tools/perf/tests/workloads/offcpu.c     |  16 +++
 tools/perf/util/bpf_off_cpu.c           | 176 +++++++++++++++---------
 tools/perf/util/bpf_skel/off_cpu.bpf.c  | 135 ++++++++++++++++++
 tools/perf/util/evsel.c                 |  49 ++++---
 tools/perf/util/evsel.h                 |  13 ++
 tools/perf/util/header.c                |  12 ++
 tools/perf/util/off_cpu.h               |  10 +-
 tools/perf/util/record.h                |   1 +
 tools/perf/util/session.c               |  16 ++-
 15 files changed, 401 insertions(+), 88 deletions(-)
 create mode 100644 tools/perf/tests/workloads/offcpu.c

-- 
2.45.2

