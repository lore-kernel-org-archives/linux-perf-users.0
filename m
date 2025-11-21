Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE4E2D3221
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Nov 2025 23:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763766601; cv=none; b=DrGrECB8fB5DECFEqUAZuex5dEg/5p0DsvVDyfzZoIkm2nMVaUBzq99xT4d9QFDbfzzww0O6hPLPwittNo73VLhgCMPalis18JJGwNxLe2acodiKqbHDm+Loxw5ICpVhQh81lsUdn8eTYevGee+2LqJkycownKNZ6u1EYZ43TQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763766601; c=relaxed/simple;
	bh=WQ+E42jjzx5EtriBU1AkfRWskkM+RaFSDeEMNlxJRBk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cqoZtqmEO4NIQYuQaCPz2tjE3H2z0DMFTj4A2J5hNEeyQTT9oCYFpOQc3BpIKw2RS+XOPowtZdxfATCTE5yei4Wn9uHedVMHawEcncguuxVX9U0bKKnj3LpbyK7OyjTCu0RcSJEgENf/48p5vP66/WzpVHq4DaL72H/upVNBJwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T606xHfo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T606xHfo"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b969f3f5bb1so4502552a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Nov 2025 15:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763766596; x=1764371396; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7bEhGrYPGcFfMtBX9//YASMyCXpxJhGnB+vTdwTPOKI=;
        b=T606xHfoZqBR1Y5sjFrNGZfVRiUWm7mEi7lcLW/tAYHLYtCuwKhit1gOswoxY0Ysue
         OdVLIolKDk7q2EDSWo7Pydi6Y+dQZSSJ2FmZej1zIs/hM05zgQ0AdFrrPwAD274kQs0i
         ibC4K+wY9dsupDpxCVLQa7IT7q5acrVxocCl7u6bwBo4eWIAIjtpIwjraDQxdSnUW0qa
         e/Kga9pv5jvxi9DxH9CyF7UuOqWus6XlYoe4jyRd/Z3pE6okDYNLjSZ5vZazh388IoOM
         L7jKLQOUscZKNcd1wciBO8ZYd1sqCwiNTr4Z+DXlF6QbWP0laOrrLVGMfHVna53ylSyB
         Q8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763766596; x=1764371396;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7bEhGrYPGcFfMtBX9//YASMyCXpxJhGnB+vTdwTPOKI=;
        b=cFpxIm3oMdZbnBj04LQmu16SoWpA3TtUFiuf6XpLLAFa4L8Rl63MCDZclyeWLuw9dH
         JvTe68xEDTQze7kJYC29VKY+jetNIzqndRr7h8scwjgcjSRfJLRgPYYwMfRTCrl2rrHP
         0UtpcLUjPU/Yh8cYlChJZXLsMrB1Kzm+u26HsfZTikDx+Oi8o6gw/Apsq2VXK5xfmixr
         NrjWPV/7R/m4k6uLkC/4jbVgb2UQiZZAkKqdzef4FYBSeegXBKrAGfeo2BZ9Tcd/EGEH
         A4FlX4XZOKQRGOFu6LOMPCdOsky1gcS9ztMJSStclRfMFpGPancx5OCw7XvZAHTlzDZx
         jgCw==
X-Forwarded-Encrypted: i=1; AJvYcCVxBb/UvXDP5Alg7YJo9eQu5Ugz3HfQ8t/HmDPB68pbGtlQQbzE4nsoqIq80d0ZT0EbOMu1dQ3mS81iPREFunr4@vger.kernel.org
X-Gm-Message-State: AOJu0YzQNM4UDx93Kg8Bc6d8z/Hrnrldifr2HchbqrP9y0ykTwXtzpvc
	+qT1iSPerMnbvoy0nNzW7vmD8mZ4PJJaxU5jUpiSq59UZuNrAufH4/JZzchbnZjCugZ3S0ECnZF
	KCPjKUA==
X-Google-Smtp-Source: AGHT+IEu2Ztp3ev6snMBcQPFyM/Hy1k8pVn8YDEGyVmHtHrx6RdTB4cBtdZfbZRp2RA3uY2wY2oocxt9X20=
X-Received: from dycog5.prod.google.com ([2002:a05:7301:9a85:b0:2a4:791c:9e95])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:f05:b0:2a4:3593:c7da
 with SMTP id 5a478bee46e88-2a71962cfbbmr1050225eec.26.1763766595706; Fri, 21
 Nov 2025 15:09:55 -0800 (PST)
Date: Fri, 21 Nov 2025 15:09:11 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121230951.3240124-1-ctshao@google.com>
Subject: [PATCH v5 1/2] perf: Reveal PMU type in fdinfo
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Ian Rogers <irogers@google.com>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	thomas.falcon@intel.com, kan.liang@linux.intel.com, howardchu95@gmail.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It gives useful info on knowing which PMUs are reserved by this process.
Also add config which would be useful.
Testing cycles:

  $ ./perf stat -e cycles &
  $ cat /proc/`pidof perf`/fdinfo/3
  pos:    0
  flags:  02000002
  mnt_id: 16
  ino:    3081
  perf_event_attr.type:   0
  perf_event_attr.config: 0x0
  perf_event_attr.config1:        0x0
  perf_event_attr.config2:        0x0
  perf_event_attr.config3:        0x0

Testing L1-dcache-load-misses:

  $ ./perf stat -e L1-dcache-load-misses &
  $ cat /proc/`pidof perf`/fdinfo/3
  pos:    0
  flags:  02000002
  mnt_id: 16
  ino:    1072
  perf_event_attr.type:   3
  perf_event_attr.config: 0x10000
  perf_event_attr.config1:        0x0
  perf_event_attr.config2:        0x0
  perf_event_attr.config3:        0x0

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
v5:
  Added config1, config2 and config3 and print output in hex.

v4:
  lore.kernel.org/20250603181634.1362626-1-ctshao@google.com/
  Removed the first patch in v3 since it is merged.
  Retested to make sure the patch still work.

v3: lore.kernel.org/20241106003007.2112584-3-ctshao@google.com/

 kernel/events/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7541f6f85fcb..17a71fe1d538 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -56,6 +56,7 @@
 #include <linux/buildid.h>
 #include <linux/task_work.h>
 #include <linux/percpu-rwsem.h>
+#include <linux/seq_file.h>

 #include "internal.h"

@@ -7212,6 +7213,20 @@ static int perf_fasync(int fd, struct file *filp, int on)
 	return 0;
 }

+static void perf_show_fdinfo(struct seq_file *m, struct file *f)
+{
+	struct perf_event *event = f->private_data;
+
+	seq_printf(m, "perf_event_attr.type:\t%u\n", event->orig_type);
+	seq_printf(m, "perf_event_attr.config:\t0x%llx\n", (unsigned long long)event->attr.config);
+	seq_printf(m, "perf_event_attr.config1:\t0x%llx\n",
+		   (unsigned long long)event->attr.config1);
+	seq_printf(m, "perf_event_attr.config2:\t0x%llx\n",
+		   (unsigned long long)event->attr.config2);
+	seq_printf(m, "perf_event_attr.config3:\t0x%llx\n",
+		   (unsigned long long)event->attr.config3);
+}
+
 static const struct file_operations perf_fops = {
 	.release		= perf_release,
 	.read			= perf_read,
@@ -7220,6 +7235,7 @@ static const struct file_operations perf_fops = {
 	.compat_ioctl		= perf_compat_ioctl,
 	.mmap			= perf_mmap,
 	.fasync			= perf_fasync,
+	.show_fdinfo		= perf_show_fdinfo,
 };

 /*
--
2.52.0.rc2.455.g230fcf2819-goog

