Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FD0148FED;
	Fri, 26 Jul 2024 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989716; cv=none; b=pTAzHibzxuQ3EK1jG6HRQ3dSsgzClizMvWhHNVSX05CMOQFWxhHomIPTLXpPxL64pz1U9MZs1D8MZIo4vdOsjuWBsrSjmspcD6sAVYIYTWplGiRwYx4V9CxTGdgswWUuNOgelANqzGmMuLuVtqPtANXpMxD1SvYv/FGdckKKf0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989716; c=relaxed/simple;
	bh=tM+jUfQicsDftWQlzLWPF+Obb6sjMAhVtEsoCFIRiuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I9k5bnC5SqY0JWag30MLfNtTOm8pk8Mkij+ZcQqGzbvXetm1Iajty2EteWQ1y1EB99ShBTw10dOLu2mZcBIdVS80i7Z0eY4ahhiYjl+VcgmONTpSEfL8/v5B7BuLtZAfd5j+TZCPZHM8SL1Z6g//+8ue6AmG7zxMFM0M4oiHufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJhQW2xZ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJhQW2xZ"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7a10b293432so608594a12.0;
        Fri, 26 Jul 2024 03:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721989715; x=1722594515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wgPkinzvbb3tgfMs6RWC2mF6ozgGCTd6+izAae4KhUg=;
        b=CJhQW2xZMKdy+Fg4Ei9s4AY7Q5+Tiror/KupcyNmv+YpP1KPlHdpspqUKQDEnJabps
         nVyOB3RTLHtEHe3KcRZJFEhTlj66IDVXx8JL4KxHBD9+s2hfnuwmucFzyDMTbLdbTHvF
         PhwufDiZFY2s+awNnBlN6CkLxMGulY4+FVTBfG3U3QI4hv6apdig/9XfE3hfFABpXfYr
         yCXoW+i6VgVVXUiktoNnNxvf9FcitpTAcUqm/wnoqIWPBL68nQZ8aK/j0/x/u0DQAZJI
         uEIJ2y4o2d2IcHw9z2ljwDLfDPcJvaAxWyA1iXgvmMHLY+z7sK1gIRfKJTJELTZMJs9c
         /swA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721989715; x=1722594515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgPkinzvbb3tgfMs6RWC2mF6ozgGCTd6+izAae4KhUg=;
        b=k/5EdpexaMVyJ3zLtpbgjDSYF/G8WnscwdTR61rEGA3pt2ANcg93UCvwVgDh9a8nO2
         e1dN/ZVDPmpc2XtUjtje4PaBUuc5ThbM3a8IXA5YEbO21GxUDwu/CVqxhMKeS6IVnvuR
         OD2cfKdDjFigwV+uY3JBJLBQ+Y9yMnr3fUNbm1kY6TnPXxKYCt0zD1nmQtMAZ76RAEgj
         CrFPxKAa7/Ooaz1lszZXqBbt2Jrd9jgjrpgWYl+BXs0X5x3s37gGXxN5ao8ZXgydzSHJ
         pMSSuW8Sw2qhJ8kmaywJ7EEWYA/vCp9HaKqjLMm/2JOUtXTHPkswiZOZ270rtALxzHZQ
         cV7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWS/j7Wasv2LXnDFfa87fvRS9G5qWLfPc82b0yYnEyQ6S5+uRLHwfuabfMEAdQdji+cArafW28amt/zp13bYae1kNeNs4m62p0rkAC5SsAHK56K9kK/Nkv7rbADbEuUoBo07mVPXHXnF7vqeQo+cQ==
X-Gm-Message-State: AOJu0YyYAdbXh+kmeerTiBkm/HTZcxmke7DjxbUg8UFhHdTATDS2YNNP
	koxgaJKc80lc8HY6jJO2GHdXs8SnNn3rRByjZ0nPqQprq/JaTNB3
X-Google-Smtp-Source: AGHT+IFYPLQ/GOZ70o2Tn0OR1MeGamx1kGhbr8fuvh33CPtzt9BA4cojEM+taJMtWsZ8Gvt+WUAGfg==
X-Received: by 2002:a05:6a21:7886:b0:1c2:8d0a:8e9d with SMTP id adf61e73a8af0-1c4728566camr7543645637.7.1721989714545;
        Fri, 26 Jul 2024 03:28:34 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f816da89sm2179964a12.20.2024.07.26.03.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 03:28:34 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: namhyung@kernel.org
Cc: irogers@google.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] Dump off-cpu samples directly
Date: Fri, 26 Jul 2024 18:28:21 +0800
Message-ID: <20240726102826.787004-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=207323

Currently, off-cpu samples are dumped when perf record is exiting. This
results in off-cpu samples being after the regular samples. This patch
series makes possible dumping off-cpu samples on-the-fly, directly into
perf ring buffer. And it dispatches those samples to the correct format
for perf.data consumers.

Changes in v3:
 - Add off-cpu-thresh argument
 - Process direct off-cpu samples in post

Changes in v2:
 - Remove unnecessary comments.
 - Rename function off_cpu_change_type to off_cpu_prepare_parse

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
    blueman-tray    1355 [000] 28178.627906:  100184571 offcpu-time-direct: 
	    7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
	    7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
	    7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-2.0.so.0.8000.2)
	    7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.0.8000.2)
	    7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
	    7fff24e862d8 [unknown] ([unknown])


    blueman-tray    1355 [000] 28178.728137:  100187539 offcpu-time-direct: 
	    7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
	    7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
	    7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-2.0.so.0.8000.2)
	    7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.0.8000.2)
	    7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
	    7fff24e862d8 [unknown] ([unknown])


         swapper       0 [000] 28178.463253:  195945410           cycles:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
     dbus-broker     412 [002] 28178.464855:  376737008           cycles:P:  ffffffff91c000a0 entry_SYSCALL_64+0x20 ([kernel.kallsyms])
```

Howard Chu (5):
  perf record off-cpu: Add direct off-cpu event
  perf record off-cpu: Dumping samples in BPF
  perf record off-cpu: processing of embedded sample
  perf record off-cpu: save embedded sample type
  perf record off-cpu: Add direct off-cpu test

 tools/perf/builtin-record.c             |   2 +
 tools/perf/builtin-script.c             |   2 +-
 tools/perf/tests/builtin-test.c         |   1 +
 tools/perf/tests/shell/record_offcpu.sh |  29 +++++
 tools/perf/tests/tests.h                |   1 +
 tools/perf/tests/workloads/Build        |   1 +
 tools/perf/tests/workloads/offcpu.c     |  16 +++
 tools/perf/util/bpf_off_cpu.c           |  53 ++++++++-
 tools/perf/util/bpf_skel/off_cpu.bpf.c  | 143 ++++++++++++++++++++++++
 tools/perf/util/evsel.c                 |  16 ++-
 tools/perf/util/evsel.h                 |  13 +++
 tools/perf/util/header.c                |  12 ++
 tools/perf/util/off_cpu.h               |   1 +
 tools/perf/util/record.h                |   1 +
 tools/perf/util/session.c               |  23 +++-
 15 files changed, 309 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/tests/workloads/offcpu.c

-- 
2.45.2

