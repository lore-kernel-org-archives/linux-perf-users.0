Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AE6170854;
	Fri, 27 Sep 2024 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463227; cv=none; b=IXvFamKILKVZO4x/UIXwdlj+Pl6PHAAxC3u8yG1AxRCpb0FgMS1owkaH+HDxhy3oaGpoM7S+/19LYKHqJm3uOhursWvoV2lOwbEizpqre5oM97F7WJDh8ZQZSD7PnnRfvVU2rjKiWxRznYI378RNGTrpYKm3Iz9Onsz8mXtFlTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463227; c=relaxed/simple;
	bh=ahNif2ZitxpgjeuFdwtymeQN2tcpxeW74+z4eOgOWAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A0UzGWHzCas0SOeQZQvsNcPBA9gazKDN/PtoVxLuAnIT/Mx63rD5idCnCUYZjHuOW7oQYrSTlIcnaU9FHytB2QKCUMmb+SZWf8qn/zg2TFEzXEIGD1OMMKS3BVDq2Ag6X/tbxxF61+0m6QeObMePgzuW76djXqzsVSL5BvrbCc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IswfUcXW; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IswfUcXW"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so2013999a12.2;
        Fri, 27 Sep 2024 11:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727463225; x=1728068025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oH5Q3YvVcVG2+Ok6zmjD2cmRE67hBFWupM9iOfac4P4=;
        b=IswfUcXW3icRLl7XM3MpRiONeE6c+ENlhy1c4XghoNrwDe8elv5sbciygjOIG3h78h
         jhnCvqEfWFVfzhoEJUlxl8d0bt6bcveE6NsXzjksiTwOGE+/IAq8iOjq8BWYfwIJQOyN
         uqOrlXn1UFv2YwKhqvKcwjBsbSD2LvXeFmz+1hKsTfk5/TPA2gZrCEStsIVRJeS/Z2i1
         QteRfkYpnJXxg2DNAlomqx8z7hd/YhgYYLuSBzWtzbEbBeHPIMnoZDtVSGE51n1VU5LG
         eiHPCKFup7o6oahFEUWqiwkhgporXAkfd1Kx20CmGwpdFtZ+UmG478UbKHx9MO8x/nIx
         Rp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727463225; x=1728068025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oH5Q3YvVcVG2+Ok6zmjD2cmRE67hBFWupM9iOfac4P4=;
        b=SY19hrgfX4/hJIU5gpjjuU3cwz51Rp4pxdCu6AlXRVmVZX3whXuiQMFifUeo/tALwL
         uRHGyk+SwEqtgo82oy0eIl1G3f0oDQT79s2uIg7kXhcpDCTTM7MXzgGVWFY9qvTYRjUu
         2GuSs6mozbVzuYKJh6W1oEVh9WCC4b6kVuxMRjr+c/H27vCfAXCi/fwS3M9Ub5pFB/CF
         /Whh9s8kJVfjLj3heBFP0U7cDxJiNduCVU1fJI77izm9qefiOQ7Lmmp8uVfgGU+VC1OS
         hlONM8dpbRlMkvIhxXRh2HIE4uMEFHOYKveHs+LgqfU0eLxvbczokRXgiqW/00HrcdP9
         Ut/A==
X-Forwarded-Encrypted: i=1; AJvYcCXEUGS1NshnKt/gKDksIblasnE3qs+lyGh3sNF28U6yVelSDjYKng+ESn6158jViN/EmFkchx1dW5gSYsi7PHw7ag==@vger.kernel.org, AJvYcCXWTV/mx22d8CAPQwz8sdYd3aR0/AQ3oE9Uq4U68dvoEurSa73glGLe9fsvYQ1jTL9VxixxqbVl0kiwzRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycg/jSCHlDlTFfXjjMJ2LIawdLFL1RzSZynP0kK+dnVVbkXv4R
	j7/0mxo9Bt2g4HyuHjFLRqTs/O6SmRuzkUeinM0Xxc4e2vOjws3p
X-Google-Smtp-Source: AGHT+IG2FHBd//nxWvrh5PxGuORgW3ZTYcAXOZ5BENPlCIN1CxMv0U6lX0bLj1TyK4bSvfw5bTo8OA==
X-Received: by 2002:a05:6a00:2383:b0:70a:f576:beeb with SMTP id d2e1a72fcca58-71b25f852e2mr5946397b3a.15.1727463225061;
        Fri, 27 Sep 2024 11:53:45 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264c23b6sm1930244b3a.88.2024.09.27.11.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 11:53:44 -0700 (PDT)
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
Subject: [PATCH v5 0/8] perf record --off-cpu: Dump off-cpu samples directly
Date: Fri, 27 Sep 2024 11:53:32 -0700
Message-ID: <20240927185340.658143-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

