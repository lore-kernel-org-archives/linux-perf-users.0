Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F6D55E73
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Nov 2024 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853017; cv=none; b=fG17X62SG3qJBYwIwxooNvPr42ghE5ZpaSwrAq3fYcnbXxYn/7ZHNiClMQSXS9sPbziJ3pYt/c3DzcXjGqhqxO09RdJ4RPcP9fIOz3WpfXEgKqygrRPzIdQB5HBP7I9d86DYRlSPUypAIf0hsgMWY8Hiy1zYZNuh6rALv7MHE4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853017; c=relaxed/simple;
	bh=ipcKC+Xvjs/o+uXqM0HBhCtZoSw03gVtAaqWOi3zBKY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qHPjDDUzVdYzakNkF8TXDyHq/E5cNS4odHLlyIMd1YTb+IwI5F6n6OTW2lcZIJRcEq5NLwMOZFHV65WBMkaCtkSr9Tp9U+hUK4L1n9BKVFOJbw0X7OrBhnnDVWqyJ2m02ZINa/xrF95se8Rg5GqWG/0V1BGOwWiorIN1XfFaRfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qIqx/bMF; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qIqx/bMF"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ecb7d90673so6562673a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Nov 2024 16:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730853012; x=1731457812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GAoTW3tUs2GtkxTfJFEZH6td7ala8u+wh1yVC3NdyWs=;
        b=qIqx/bMFAfEsMaT8U/7WUNspoOsVaoPtc8E/UaHdaWlhPdc4yAVo9Kjh3/Kq41Z4ra
         g04xA298Jcu9rsmymOx0JD9SD5Vd91lG4GPsRb8Y1zOxycq1dCrket6pOXyHJCJAFhKQ
         w2dzf3MKo7a+1vo7a9Y/9TKKGRQXgD5S1f5OR41YHTRPG4m6wmDCISx3n8spu8dbYz9t
         hrvGh96KPTC0HDfbZ5RMWZup1YO6f0QPx+S9KU+sUa1e9Zr1fi1TzxhKsYq2AzeG49bq
         Y+x2jWnIJJ1LkJHdJB6lg+GdAQD0lG+6neRt+TcyIvouAMV5P0maUnxTbUKvkGqcA21C
         W7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730853012; x=1731457812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GAoTW3tUs2GtkxTfJFEZH6td7ala8u+wh1yVC3NdyWs=;
        b=EqvklFKF6Kww+C5WZrTUsCfieDiWg4ENqYn9zZT534XiMJtogM6VwMe2dkD21+75L0
         BieGzWDxAZAevCB1u0MUKqpTFiDMIKiLqI7Tx199V+xCaXH0UvqVdAbvQwzm4YrisECF
         FutdM6t2sKLYxU+5iS5AkDquw6xQLFTvZcZS69lgmxi5hxASSyZ/EBLUfcdxXlGaG7Vw
         t/hx2Nu3CaQMoxFwcP8rNTDg2E8hVjH3JgzOqWSg9snMfPq6Cy9O5z+Mo13tzUwcqTzo
         wfsqAJH50TOnNU2m3H77huFHg/kBWfHqphuGHHM6LUlBNWTb59XzT1mjUZVWu2+KHMgD
         s8xQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0RMmrs9Vvreo1dMzdwn+lLmeYJiSrPf/zJkc9dy+a8OLO6pCebeL9qIpH5fnNjzWj9Y5Xbjj6aa358JXCISZd@vger.kernel.org
X-Gm-Message-State: AOJu0YxpBgKNaTA7K77DnZkSbXcCRqC02bLUXMvzng4T7h8rWm3jLDpX
	HX6j29B7qtE/+RzeIM0NrPrDSPqxRShCDYDByLhxKLFJ10nvsqZbmRmvvwOhJRlAzNbXZx9y/oP
	sWQ==
X-Google-Smtp-Source: AGHT+IGyAvc3UlnyxoY/s+DSBEx42PIPHB2evs1WX6ROqJhqhRsN02w8YFLGFUPp2xXFilKc/9DOuYBKnK0=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:ce7])
 (user=ctshao job=sendgmr) by 2002:a63:dd4b:0:b0:7ea:3fa9:9fce with SMTP id
 41be03b00d2f7-7ee4130b465mr50558a12.7.1730853012257; Tue, 05 Nov 2024
 16:30:12 -0800 (PST)
Date: Wed,  6 Nov 2024 00:30:06 +0000
In-Reply-To: <20241106003007.2112584-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241106003007.2112584-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241106003007.2112584-2-ctshao@google.com>
Subject: [PATCH v3 2/3] perf: Reveal PMU type in fdinfo
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Chun-Tse Shao <ctshao@google.com>, Weilin Wang <weilin.wang@intel.com>, 
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
  perf_event_attr.config: 0

Testing L1-dcache-load-misses:

  $ ./perf stat -e L1-dcache-load-misses &
  $ cat /proc/`pidof perf`/fdinfo/3
  pos:    0
  flags:  02000002
  mnt_id: 16
  ino:    1072
  perf_event_attr.type:   3
  perf_event_attr.config: 65536

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Change-Id: Ibea5618aaf00bae6f48a9b2a6e7798ab2b7f23ce
---
 kernel/events/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index cdd09769e6c56..398cac8b208b9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -55,6 +55,7 @@
 #include <linux/pgtable.h>
 #include <linux/buildid.h>
 #include <linux/task_work.h>
+#include <linux/seq_file.h>
 
 #include "internal.h"
 
@@ -6820,6 +6821,14 @@ static int perf_fasync(int fd, struct file *filp, int on)
 	return 0;
 }
 
+static void perf_show_fdinfo(struct seq_file *m, struct file *f)
+{
+	struct perf_event *event = f->private_data;
+
+	seq_printf(m, "perf_event_attr.type:\t%u\n", event->orig_type);
+	seq_printf(m, "perf_event_attr.config:\t%llu\n", (unsigned long long)event->attr.config);
+}
+
 static const struct file_operations perf_fops = {
 	.release		= perf_release,
 	.read			= perf_read,
@@ -6828,6 +6837,7 @@ static const struct file_operations perf_fops = {
 	.compat_ioctl		= perf_compat_ioctl,
 	.mmap			= perf_mmap,
 	.fasync			= perf_fasync,
+	.show_fdinfo		= perf_show_fdinfo,
 };
 
 /*
-- 
2.47.0.199.ga7371fff76-goog

