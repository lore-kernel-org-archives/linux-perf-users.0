Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D8B3218B;
	Fri, 27 Sep 2024 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727468863; cv=none; b=MDltamNzgr4CCPTnb3ei/8mZzLOhlKo/dI8TzMWEVbEMeEnXgHV9ardrNu++FZD7M/7O9GX4QjrqOBwTPMI/rlor0KSV77LjiVaQv3Ibb0IKAR1eeB0GldvrI1UupxlnSGnGZnx2aYkLZFZkbqL5AulWEy4RTF8kwFCVV3o9A6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727468863; c=relaxed/simple;
	bh=NDMNmNHMfmhw/JA/fmKB0OuJiTK+oaFkt5P19EaF1FE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OyhMNRDLZjOnCmX7NkP1kXk0WxjogXYb3cyyswmn2Tb/wTqxFHJtgyHnuIgDUEEywmYBD+QMqYahziSJ/9umnx6u88kUc9yKdeiyCEFBHb+ZsvGSoQszClkCwq81/JVr0tKN45wugBJwchN7Pq4FSOGfO3vsvVnnMNwO3Rh7GTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9kqwzLi; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9kqwzLi"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7db238d07b3so2063589a12.2;
        Fri, 27 Sep 2024 13:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727468860; x=1728073660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3cmopgL+WcIzsdLkIwUEYqG54Pf2s74bRl8dXLrdtZ4=;
        b=N9kqwzLiky731F3bV8hO8uCj30Uq351fp5ZAvzUVB7YqiiRpltjUyVxOX5MP+Km87j
         YGP462XJGARL+ILJBEDxX7kzfKB9WZY5BgsHE9je9uaSS+TQ/UY8wL0ttQ101XD90EmE
         KHJEXZQezshSqbfJGG62KydWMm1BevhGZz9GfT/mWfgYg+2+LdJ/xshCgb3YLuv3s6MW
         RSO75ggOFGHleaMeURo+pHrRPM/yukDRU69QQNvbXbuyGOvj3lPbxKZqo1ITF/3Ru/3T
         YEQU4eT+ZO32cdhbyyvUnJoSbD0BAxSmBb7yh9GlH0YsqFdA4K+l/65md3Ojm6DpjKJg
         WYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727468860; x=1728073660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3cmopgL+WcIzsdLkIwUEYqG54Pf2s74bRl8dXLrdtZ4=;
        b=QCYYXiWfa3EztPd4YGMSjGmPWQC6XpI178cCHgNPXkUoQHRNMv9u5QtD+Yg1JhdXaf
         B9NZSYZNoakcc1MVhwmjDK6Ey1726m44EFbySTsVuItSWIPt7cwz3IvbfYKKxkc8VfMM
         /ku7W7iapCIbJ2mAPkfMlEHYHhVz8xMTkkj3bS1Hu4LJzWm59bs3rzhj6JQDRg42lXZf
         wqCAL1sYMzCG+U9vtFPVPZlvoUyeovnPTlxW3ScLUcOAH6SM8ZOcuZDc04ApPICiY6ca
         48YFgYri7XIS1UszyYwZaILR+YPMQGItqhqx4L+TsI8munt2RidgfX496QRwcBksTJ69
         A9eg==
X-Forwarded-Encrypted: i=1; AJvYcCVa8Rl9ZI6NYN52fcyBK5R8+UVRw0+uiYyJAUEE466o9PN8eapwFgf+mifrzzemW0fgsB97WZMh6yyxPLs=@vger.kernel.org, AJvYcCWwL03QcJVvk0YS+QyMtlIoUNJ0ueFbD78mGXCxV9+JNU70QYjQgNYdh8VaVAU5xURxA8fNZMm5XmYMGWQylxOL2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUHnlIseb0+o9MTNc0jNHXJYRUG4OMqetYvhn/Jkry6HOwgvzn
	I6AcTL71huCRUiDtCZVvteskoVhd5yq/lVj3+PpWGBK4yzBAE3rH
X-Google-Smtp-Source: AGHT+IGdABE/p0Thc8dONMWOQAmVXTSIQ0rvZptxY/zcHAqDJ2sRBaelKjPVJ8Zfb8mEnCsorULZtw==
X-Received: by 2002:a05:6a21:394b:b0:1d2:e807:b65b with SMTP id adf61e73a8af0-1d4fa78b41dmr6923974637.37.1727468860479;
        Fri, 27 Sep 2024 13:27:40 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26524c32sm1998410b3a.157.2024.09.27.13.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:27:40 -0700 (PDT)
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
Subject: [PATCH v6 0/8] perf record --off-cpu: Dump off-cpu samples directly
Date: Fri, 27 Sep 2024 13:27:28 -0700
Message-ID: <20240927202736.767941-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Howard Chu (8):
  perf evsel: Set off-cpu BPF output to system-wide
  perf record --off-cpu: Add --off-cpu-thresh
  perf record --off-cpu: Parse offcpu-time event
  perf record off-cpu: Dump direct off-cpu samples in BPF
  perf record --off-cpu: Dump total off-cpu time at the end.
  perf evsel: Delete unnecessary = 0
  perf record --off-cpu: Parse BPF output embedded data
  perf test: Add direct off-cpu dumping test

 tools/perf/builtin-record.c             |  26 ++++
 tools/perf/builtin-script.c             |   4 +-
 tools/perf/tests/builtin-test.c         |   1 +
 tools/perf/tests/shell/record_offcpu.sh |  29 ++++
 tools/perf/tests/tests.h                |   1 +
 tools/perf/tests/workloads/Build        |   1 +
 tools/perf/tests/workloads/offcpu.c     |  16 +++
 tools/perf/util/bpf_off_cpu.c           | 174 +++++++++++++++---------
 tools/perf/util/bpf_skel/off_cpu.bpf.c  | 123 +++++++++++++++++
 tools/perf/util/evsel.c                 |  47 ++++---
 tools/perf/util/evsel.h                 |   6 +
 tools/perf/util/off_cpu.h               |  10 +-
 tools/perf/util/record.h                |   1 +
 tools/perf/util/session.c               |  12 +-
 14 files changed, 359 insertions(+), 92 deletions(-)
 create mode 100644 tools/perf/tests/workloads/offcpu.c

-- 
2.43.0

