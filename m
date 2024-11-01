Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055261E47B6
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Nov 2024 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730495894; cv=none; b=ksQ6+wMtpAHovHB5HVghRnuZazXFJVOAFI/xS9iYZ1CKY2XtHpDm3Ic0ioxVx30eI0VnfGswID28VRZ+LfxW7OGqMQ47R9K1nI8T7RnJOG3fqQaPM5z//u4dMxDopw9o9kwwtsjA1gTeRIorgD5vpKcGqyiiaFESf7Pxd5uzzLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730495894; c=relaxed/simple;
	bh=AXaKmiz1BPQtO2iQli6F6rV4sK5t/IYfLGMeASUAz3s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ka00uDguZSkwt+Ym7oXECg9YV4v4tKdxKJH0lvT1uWFskteBffJtpmZYiKwBYKB9CrnVvbRrFF597z4rjYoCh0hBTc8RWYrRBw3Anawy9/+SG6grEPQarpja+UEgtbIR4zdshoVBtDKVM6RTPPBPvacKj6X7JZtJJVKk4+nlmDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WvWPXgHZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WvWPXgHZ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02fff66a83so4129753276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Nov 2024 14:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730495892; x=1731100692; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KFX7yvC3uxLOE0+Ihey450D1Cp+BaYpjbmXJpiztrUI=;
        b=WvWPXgHZ3Ptp0wIVorugku0quL5+fKPyHgOdcsyivfOk3vlB6BPVUPHDK0AWYLpNg6
         77iyCqjjPO/wquA3JDBgfscbMTsN5cVIBXi5PTCJe5xKE151Sk5vbfDVRAKNHDc+z+AN
         VKjIuPUsodSw+YF9ZQ42qIg6Towjgp9YUFdOSm7lyIW4xPvf2pNKUuGROEN+NdKrSFyQ
         RZduOjhyAoDvsX+R0525zEjUPDAy7w+sHCTnYujRPl/AClvMDKa1jgW4oTh4+YewCpzf
         LypoX7eOM8+LKLmgy/wxX6PkvoX1UOe1Uv8fG0NuQe9/9aaPoUh2+TiKZMEfVRIasQnN
         v8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730495892; x=1731100692;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFX7yvC3uxLOE0+Ihey450D1Cp+BaYpjbmXJpiztrUI=;
        b=FI5luFuGFZyzsV5CFegBXuPoK40VjPa61du2pNv1Kb+WtC1H4TSHvw4AY9M/sVPLu2
         fYOYnzwm9CnvetaiovUQ0XycJnwCJSTHJdw/pSRyxH4rNbq7+Tkoil98CAm9ZPhuH14X
         V8MwSt5kOlmAHEjNboGMYD/WtxSfjAiR28B0EGaZ42/8McuhAJ1UEPksfLpK2G5Dg29k
         e4BmKsVTPU6Y/KA4NZzxSeEeXVweNOFQPtynIcbUx3NkSQ+BZxogcTMNK412ueKcxHm2
         xHqTPZjLAqp8unZmu9oDbSENCjE9kREwK440NxYoynsc66XB3Bd1lBo2FXT/bxWXHm/s
         AJtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6gfbmAFewdUYL9xHW74I02CqE2J+v8m42kTQoX6vXcpaIqaKfg7ENcWoM/36LcRPEMPCQd3tsquMfB8QvcMeE@vger.kernel.org
X-Gm-Message-State: AOJu0YzVh3FOPEUOmYuRl9CX7n+PQ7hGqYJFOB4Us6wWx5s4QkA9UegX
	h48YBe3UdS5KGFXqUHU8YlXIbcdsSi/KWlhDf3itTKscd4v2ShROvL4SvMBHZbukvu5IMd8Bznz
	qAQ==
X-Google-Smtp-Source: AGHT+IFzp1ZkvjZarXFv7ndXQiRnJC0i3qabDPbnFkimDF8b30bYVnAD68cjpnIzcFlKFCf57DfDFgniUns=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:ce7])
 (user=ctshao job=sendgmr) by 2002:a25:b847:0:b0:e30:dfb5:8a8d with SMTP id
 3f1490d57ef6-e30e5a03f2fmr4698276.2.1730495891733; Fri, 01 Nov 2024 14:18:11
 -0700 (PDT)
Date: Fri,  1 Nov 2024 21:17:56 +0000
In-Reply-To: <20241101211757.824743-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101211757.824743-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101211757.824743-2-ctshao@google.com>
Subject: [PATCH v2 2/3] perf: Reveal PMU type in fdinfo
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Chun-Tse Shao <ctshao@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It gives useful info on knowing which PMUs are reserved by this process.
Also add extra attributes which would be useful.

```
Testing cycles
$ ./perf stat -e cycles &
$ cat /proc/`pidof perf`/fdinfo/3
pos:    0
flags:  02000002
mnt_id: 16
ino:    3081
perf_event-attr.type:   0
perf_event-attr.config: 0
perf_event-attr.config1:        0
perf_event-attr.config2:        0
perf_event-attr.config3:        0

Testing L1-dcache-load-misses//
$ ./perf stat -e L1-dcache-load-misses &
$ cat /proc/`pidof perf`/fdinfo/3
pos:    0
flags:  02000002
mnt_id: 16
ino:    1072
perf_event-attr.type:   3
perf_event-attr.config: 65536
perf_event-attr.config1:        0
perf_event-attr.config2:        0
perf_event-attr.config3:        0
```

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 kernel/events/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index cdd09769e6c56..c950b6fc92cda 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -55,6 +55,7 @@
 #include <linux/pgtable.h>
 #include <linux/buildid.h>
 #include <linux/task_work.h>
+#include <linux/seq_file.h>

 #include "internal.h"

@@ -6820,6 +6821,17 @@ static int perf_fasync(int fd, struct file *filp, int on)
 	return 0;
 }

+static void perf_show_fdinfo(struct seq_file *m, struct file *f)
+{
+	struct perf_event *event = f->private_data;
+
+	seq_printf(m, "perf_event-attr.type:\t%u\n", event->orig_type);
+	seq_printf(m, "perf_event-attr.config:\t%llu\n", event->attr.config);
+	seq_printf(m, "perf_event-attr.config1:\t%llu\n", event->attr.config1);
+	seq_printf(m, "perf_event-attr.config2:\t%llu\n", event->attr.config2);
+	seq_printf(m, "perf_event-attr.config3:\t%llu\n", event->attr.config3);
+}
+
 static const struct file_operations perf_fops = {
 	.release		= perf_release,
 	.read			= perf_read,
@@ -6828,6 +6840,7 @@ static const struct file_operations perf_fops = {
 	.compat_ioctl		= perf_compat_ioctl,
 	.mmap			= perf_mmap,
 	.fasync			= perf_fasync,
+	.show_fdinfo		= perf_show_fdinfo,
 };

 /*
--
2.47.0.163.g1226f6d8fa-goog

