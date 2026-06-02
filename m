Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3B033D4EC
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424034; cv=none; b=WAfQEgZ6I8d7NZrwPypqGeNcbY74njKOEARtv59PVjQUlTZsinSW6jyfePGwFoVBuQYNRiksfw9NWb4WWKvxnlb/zwIG8RMpX3u00/Tm2x9zw1ZDqOKQ1D5AUB/nYYU/6orSO8Ok2qdzutpnhHguHSsVikZOxauMmsaXWqu15SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424034; c=relaxed/simple;
	bh=MGtENHvYjDHS2OfesGf9JR5T5DyBUR+xupm8U+3/Bpw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cbSEjSGT+EwKJ/5ERc5efVprwJ7bwZBeAQJFHG+xnjZawOyBSBvC7olytKyPwqrrDaHXx46TifTvj8OguzqOwYHjslzDoA/LjmSFnRvZrem4Awg2JyWiTZHdMpHJRLeZgytVdzd8SXVv0DUQG/OlifDxGrNC1WjERremkFiUoVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X4vtsi/L; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4vtsi/L"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85807671b1so2181030a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 11:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780424032; x=1781028832; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A4+rXw2EMERb7vlJqmotQkCHdAxC1iDpIiIY2u6cd94=;
        b=X4vtsi/L9yTMafkqaZqiO/WINpCBDzku1/xn0tHwKN9e4ob8/7y8x8YaoCddEGmp/s
         GH5kcCIDy06iUPPM6SmZoi2oc01z+Ev89UGDUZGrp/Dm479BdiwPZM3BbStPO2sY10Hr
         s9EBD/jzubJBiUaPDFR3KBm8DFxSxwI87QCG5Fh+lYtdLdq5VvtU31BSfuPK6RXmUeYu
         Aezulzr5+28p94QFqbkgOM2W+Pg/H00LgUJ9QJ7s0JANw6vkeFbYP+LcLXi8LVxD+bVh
         8qLqr+qCYE5//S9AxHMufpNfWE+sCu34uy4febPbxV354vXow36y7zkcP4ZruSBVnNaE
         5V9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780424032; x=1781028832;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A4+rXw2EMERb7vlJqmotQkCHdAxC1iDpIiIY2u6cd94=;
        b=BKBaD9/NFRsYb1LLubcNuvyUFS5EKYdRVU8SlXGzggyod3Wfg4ph49s3V9Qoa/nbPq
         v16hnUPrcE1YAYTYVQ7QvvitusCuBb+WOcdGJeaxeHaLYy19VhyNne6bR9SWvE50xoK/
         rID5GAkRxesVQXnQHW2Tmpk40BOsCIEx6pYM0/0XliTaVSt1AQiftLcCipWsnbh3emYv
         ReLDDMEwGdKqKv68gzf8eiZxVuBDwE9PnDzq1vgJTI5QdDxcrGgNX3ffkR8naGiFTNfK
         C6OEMEKCJdpQCSLLek/G2GpCqX1j5LBqQeeeoPD6Fye0wwWHeQVCaJqxkv6b32uRr9SO
         QbxA==
X-Forwarded-Encrypted: i=1; AFNElJ9zfZk4h+v7vxR98Y2H4jXTm/QKf7Fm1ezfa2JsGc0KS3zyMZB581A/p0oXbOxdCy71tWBXoQ3/raXq6opL7J+q@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7B0AaqZL+2PpbOlEbEKRwtB+glHM1WpOkVylK6pgQTBh7Zc/q
	/AmrHAFWLNLKQ3H53833bz7WLkKhwjQkJAaeOidBOZr2o2jLcQPo1itBukbOqNvnxFbLvNg+JIl
	QODyn1Q==
X-Received: from pfbgr7.prod.google.com ([2002:a05:6a00:4d07:b0:83f:2ce7:48ce])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a247:b0:838:af72:fb44
 with SMTP id d2e1a72fcca58-84284dc57d6mr58163b3a.2.1780424031894; Tue, 02 Jun
 2026 11:13:51 -0700 (PDT)
Date: Tue,  2 Jun 2026 11:13:48 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602181349.3969429-1-ctshao@google.com>
Subject: [PATCH v8 1/2] perf: Reveal PMU type in fdinfo
From: Chun-Tse Shao <ctshao@google.com>
To: Chun-Tse Shao <ctshao@google.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
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
  perf_event_attr.config4:        0x0

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
  perf_event_attr.config4:        0x0

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Assisted-by: Gemini:gemini-3.1-pro-preview
---
v8:
  - Fix a race condition on 32-bit architectures by acquiring parent or
    child child_mutex inside perf_show_fdinfo() to prevent concurrent
    mutations via perf_event_modify_breakpoint() from causing torn reads
    of breakpoint fields (which alias config1 and config2).
  - Expose missing config4 field in the fdinfo output.
---
 kernel/events/core.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7935d5663944..95d806bba654 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -58,6 +58,7 @@
 #include <linux/percpu-rwsem.h>
 #include <linux/unwind_deferred.h>
 #include <linux/kvm_types.h>
+#include <linux/seq_file.h>

 #include "internal.h"

@@ -7546,6 +7547,33 @@ static int perf_fasync(int fd, struct file *filp, int on)
 	return 0;
 }

+static void perf_show_fdinfo(struct seq_file *m, struct file *f)
+{
+	struct perf_event *event = f->private_data;
+	struct perf_event_context *ctx;
+	struct mutex *child_mutex;
+
+	ctx = perf_event_ctx_lock(event);
+	child_mutex = event->parent ? &event->parent->child_mutex : &event->child_mutex;
+	mutex_lock(child_mutex);
+
+	seq_printf(m, "perf_event_attr.type:\t%u\n", event->orig_type);
+	if (event->pmu)
+		seq_printf(m, "pmu_type:\t%u\n", event->pmu->type);
+	seq_printf(m, "perf_event_attr.config:\t0x%llx\n", (unsigned long long)event->attr.config);
+	seq_printf(m, "perf_event_attr.config1:\t0x%llx\n",
+		   (unsigned long long)event->attr.config1);
+	seq_printf(m, "perf_event_attr.config2:\t0x%llx\n",
+		   (unsigned long long)event->attr.config2);
+	seq_printf(m, "perf_event_attr.config3:\t0x%llx\n",
+		   (unsigned long long)event->attr.config3);
+	seq_printf(m, "perf_event_attr.config4:\t0x%llx\n",
+		   (unsigned long long)event->attr.config4);
+
+	mutex_unlock(child_mutex);
+	perf_event_ctx_unlock(event, ctx);
+}
+
 static const struct file_operations perf_fops = {
 	.release		= perf_release,
 	.read			= perf_read,
@@ -7554,6 +7582,7 @@ static const struct file_operations perf_fops = {
 	.compat_ioctl		= perf_compat_ioctl,
 	.mmap			= perf_mmap,
 	.fasync			= perf_fasync,
+	.show_fdinfo		= perf_show_fdinfo,
 };

 /*
--
2.54.0.1013.g208068f2d8-goog

