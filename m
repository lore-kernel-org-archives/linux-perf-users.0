Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD15044C8C;
	Wed, 31 Jul 2024 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722455392; cv=none; b=aLqkITFNB1dL1IEGO1fq3h/jZEzPQo6OMu1LGNn5zXYOp+tawQ9SK3y72jl7AUVGKrzcjdRIRFGWqBnWiFtEkoElgS/Ku3wXHl0W+JTtuGJxy/+0EpqBaD+oXEgk9hajOUijav/uS+/4lq6Lw5xQmIt8WB2QbI/f1iLMs/qK+f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722455392; c=relaxed/simple;
	bh=20gKXEXTK8VIyi+nE8h75ijIGylrFzdTx1H2khvTszk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u3UiPsXTDOZHs5fevAJcrM5xUl0erhPB/SU8LcrICGaAvOJNgwjAp1CxL8hY6FSYQQfqrpRvm99GKX+ba1AnI3n5i/gXV7suGva0JSGZLUw+GVECQk9SU73+wtHCZxDnN8NiZiBC6sFxIl17QG2xh/Qpq1a9JRNRchx4QyOkPTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuogfBj8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuogfBj8"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc6a017abdso40109535ad.0;
        Wed, 31 Jul 2024 12:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722455390; x=1723060190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6v9o4zScOdEllBGdTnnqF9VoudU1tyn9kQkpBN7sqKs=;
        b=OuogfBj8s0oyTE5gm7jTTlM76At1Toh6Gd7xTRNSgn8pv2PbfN00opXQBvdEWIFLfM
         GwUANIHsMBIdXTdwcJPu1jnquyj58RyvlIAQdfhmYtEQJ21XTS5HKP28ofBDp3yFFJDS
         AFxw4WVAaUsQee9WXRS9fudKGsM/LokZHwVgZwjAsdsY1HCn5xkRTvlNWnZ7PiE4+3PB
         KSdl1+sS4VWJY0PrXGCS8SA4YAdnm9NL5yCOudFkrLU9/yMglP1ixykkTaRnDCMjVdJH
         5e7IaDnp19gOrpS2w8Mx4yXPVyM8mC8DokYmn0sSMjOLkcR+hQj+3mTXYC2krG1PVxLi
         FPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722455390; x=1723060190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6v9o4zScOdEllBGdTnnqF9VoudU1tyn9kQkpBN7sqKs=;
        b=HcvjoF04V9PA/PcHGICT+y6+wWG/Ql/8vlSgeWZmIWNtQkq7pQl+I/NIZtf37ygjqo
         Oyjfgg6YA/UqvpXUVdIunezG715htwcC5YvfBqwYFC6PYW/nq5718rRrAnscj1uDYxlP
         wQ5fmRzBirVnaG1p6aZsmOX8z8MB0zz2MxLwoFvmoKqQn/ziaumy84d2KLm8KdsZ5wj5
         sAHJ/j3ax2iEq95lDDbtOo+OEcR98D2HaA2H1jfqwzpPiLRhdMp9CWfGcLD0iQTel4MA
         06tLy4YCKp8n6ibhG4F+0uNuwngjTXvLgTpxoXj89S4/Bcu+gjP7n7FeeuiMg0cPw2iE
         /cCA==
X-Forwarded-Encrypted: i=1; AJvYcCXpVFSgeHLXBb9P+/BUqXrM+3oyMsEMk8T/K77tWia2MNnpkvF8KTqTMWfuDcBkyz21F4UQ00HWtdc2vu04AU+fcG7JrYPLWKL4WbJuIO8Jjqp3qSBEdAWfI3CxDnfkcVm2hC3lzYdaPfPOD7hJSg==
X-Gm-Message-State: AOJu0YxtKKkX99ml+gnmVpdrucAzBN+490T1mdO0+ylh+HNLO6kaZhdS
	2jOBF+lgbu6xRIiNqItpGpnCo/eDTToXfxq+NW9YxQXKEuPrCiKIWhbNe2Tr
X-Google-Smtp-Source: AGHT+IGehEEcS+enj0EspwScI/3zo6PW8V7AgzbdCJHgT/+ul8/I4SyVxvFCuWSgocyrEpfP9203Uw==
X-Received: by 2002:a17:903:228d:b0:1fb:8f72:d5e9 with SMTP id d9443c01a7336-1ff4d2135d3mr4061175ad.48.1722455389767;
        Wed, 31 Jul 2024 12:49:49 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7837e40sm124708615ad.0.2024.07.31.12.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 12:49:49 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] perf trace: Augment struct pointer arguments
Date: Thu,  1 Aug 2024 03:49:36 +0800
Message-ID: <20240731194939.4760-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

prerequisite: This series is built on top of the enum augmention series
v5.

This patch series adds augmentation feature to struct pointer, string
and buffer arguments all-in-one. It also fixes 'perf trace -p <PID>',
but unfortunately, it breaks perf trace <Workload>, this will be fixed
in v2.

With this patch series, perf trace will augment struct pointers well, it
can be applied to syscalls such as clone3, epoll_wait, write, and so on.
But unfortunately, it only collects the data once, when syscall enters.
This makes syscalls that pass a pointer in order to let it get
written, not to be augmented very well, I call them the read-like
syscalls, because it reads from the kernel, using the syscall. This
patch series only augments write-like syscalls well.

Unfortunately, there are more read-like syscalls(such as read,
readlinkat, even gettimeofday) than write-like syscalls(write, pwrite64,
epoll_wait, clone3).

Here are three test scripts that I find useful:

pwrite64
```
 #include <unistd.h>
 #include <sys/syscall.h>

int main()
{
	int i1 = 1, i2 = 2, i3 = 3, i4 = 4;
	char s1[] = "DI\0NGZ\0HE\1N", s2[] = "XUEBAO";

	while (1) {
		syscall(SYS_pwrite64, i1, s1, sizeof(s1), i2);
		sleep(1);
	}

	return 0;
}
```

epoll_wait
```
 #include <unistd.h>
 #include <sys/epoll.h>
 #include <stdlib.h>
 #include <string.h>

#define MAXEVENTS 2

int main()
{
	int i1 = 1, i2 = 2, i3 = 3, i4 = 4;
	char s1[] = "DINGZHEN", s2[] = "XUEBAO";

	struct epoll_event ee = {
		.events = 114,
		.data.ptr = NULL,
	};

	struct epoll_event *events = calloc(MAXEVENTS, sizeof(struct epoll_event));
	memcpy(events, &ee, sizeof(ee));

	while (1) {
		epoll_wait(i1, events, i2, i3);
		sleep(1);
	}

	return 0;
}
```

clone3
```
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <linux/sched.h>
 #include <string.h>
 #include <stdio.h>
 #include <stdlib.h>

int main()
{
	int i1 = 1, i2 = 2, i3 = 3, i4 = 4;
	char s1[] = "DINGZHEN", s2[] = "XUEBAO";

	struct clone_args cla = {
		.flags = 1,
		.pidfd = 1,
		.child_tid = 4,
		.parent_tid = 5,
		.exit_signal = 1,
		.stack = 4,
		.stack_size = 1,
		.tls = 9,
		.set_tid = 1,
		.set_tid_size = 9,
		.cgroup = 8,
	};

	while (1) {
		syscall(SYS_clone3, &cla, i1);
		sleep(1);
	}

	return 0;
}
```

Please save them, compile and run them, in a separate window, 'ps aux |
grep a.out' to get the pid of them (I'm sorry, but the workload is
broken after the pid fix), and trace them with -p, or, if you want, with
extra -e <syscall-name>. Reminder: for the third script, you can't trace
it with -e clone, you can only trace it with -e clone3.

Although the read-like syscalls augmentation is not fully supported, I
am making significant progress. After lots of debugging, I'm sure I can
implement it in v2.

Howard Chu (3):
  perf trace: Set up beauty_map, load it to BPF
  perf trace: Collect augmented data using BPF
  perf trace: Fix perf trace -p <PID>

 tools/perf/builtin-trace.c                    | 253 +++++++++++++++++-
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 121 ++++++++-
 tools/perf/util/evlist.c                      |  14 +-
 tools/perf/util/evlist.h                      |   1 +
 tools/perf/util/evsel.c                       |   3 +
 5 files changed, 386 insertions(+), 6 deletions(-)

-- 
2.45.2

