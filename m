Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906062F52
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jan 2024 00:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705623260; cv=none; b=vAH7Un0I+GAcxxC0H1dxrAmKwSCmEY5dJalf6R1JpM4kTfk4nuZiPMxk6Nz4knZj3HbxtTWTPbcjnpanXLH0//CMgIjUFLSzYC+0H/nx6sI6UU0faB4t/uHZ8IgGa5MxE8/+fDUegiQ2Hr6Lx2BfVOYnU8upU4wYQUPHI+jjupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705623260; c=relaxed/simple;
	bh=3622UZiYTMAps9fbTXA59oDeFjLFPk6fc41GnG+9ElA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZCcvT150BGDNrhYgk5MF2nIJV8MxLJqFfsnr4sFZpTApVJWCJDzVcNLyFSXpfINhePdNZB9qNyIezOM7B0pqeKY6H70kAaeaXyh6H/IZHd0otLGtLjx0voolTwRiU6JXG+T1G+aeRNslKB6sRAAxMl+5MQSkk+gs8cbNpHJK26E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=EAHGi4sB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="EAHGi4sB"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d70c150632so1737265ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jan 2024 16:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1705623259; x=1706228059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hEmM3vmtzdKl0VwvFdVPj5xDGeYkLg3iqjbEyKv8xM=;
        b=EAHGi4sBFq4E70+oyXfcJgh8JejvoQfg6y70LujDnGNW/nQOK9LEZJMPMZcZYCYo1F
         2ncaGimK3K2P/N05NrVZXPV4ips16A8D5lj31KH8UHVEAplH0q4u4wgoO4zN2uZdDxU0
         SokB2JECL0+E2SY+ppU5oUWAJU+YvZ/QnM2xulqWen/U98PUR/EiplgxGSafz0xBUWa2
         XU3TKx0QjHgl14oL5yg7K56xQUt2WjL8eQVZWBGKuicvbXvqCGET6lHctm35vbiskLTX
         nQz+dpMWZx2icGdjq5nrRfeDxyj/hDqnrddGgrjvqxxPFEaqnid6C1+SgQDpIj8JGHdJ
         3YmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705623259; x=1706228059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hEmM3vmtzdKl0VwvFdVPj5xDGeYkLg3iqjbEyKv8xM=;
        b=ufu68X61mS9IJo5EEephEUtTG2gVlAVAuDEujGRpd0atfN6Wjm/9HWASxNNZIvdwlK
         ieebReD2ztbgsSwIhbiLMvlByVfUE5Xd/ZLWLhqaIQCWwbiFIprfVaSymloRp7wY8IBb
         Ig6qLsRNR0Fv3yVJbYLm17jSb/BdtQpRPpzyNj+HLlJZLWwWjrRt04YdJO5BXWkrfXi2
         zt3sy1fbsb9T8e+2VW9k/SpQSm1j/8RmWsxnwOA+eHmXeDmZ9p7LFHeNt+LTOGJVqQ51
         ElbNrZpw9Q+HWN02WUr2LZ/RAnh43K3o1SBShLIr+6vmz97PGSGOviE2rFUJA6BQnCbu
         hxKA==
X-Gm-Message-State: AOJu0Yzx7e+W0dbUYLlbgNiVF0FpH7jjrCS8DoT26NJLGLN0Mg8+l9Eb
	+YxZXLXTx/m6rXqA1YZiPVxbnp8CXHAkRz8yLdugPGzowwv2dCGkgmRPqHFirQ==
X-Google-Smtp-Source: AGHT+IF9V/6JdoU8QuZRMVkRzj+UeTRxHQatHPLLvh6dQW/ZvCNMdhB946SuxRg0AqXn3f3Ur/VeDQ==
X-Received: by 2002:a17:903:26c4:b0:1d4:f29f:e13b with SMTP id jg4-20020a17090326c400b001d4f29fe13bmr1639156plb.40.1705623258923;
        Thu, 18 Jan 2024 16:14:18 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id mj7-20020a1709032b8700b001d1d1ef8be6sm1921238plb.267.2024.01.18.16.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 16:14:18 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Song Liu <song@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v4 3/4] perf/bpf: Allow a bpf program to suppress all sample side effects
Date: Thu, 18 Jan 2024 16:13:50 -0800
Message-Id: <20240119001352.9396-4-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119001352.9396-1-khuey@kylehuey.com>
References: <20240119001352.9396-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Returning zero from a bpf program attached to a perf event already
suppresses any data output. Return early from __perf_event_overflow() in
this case so it will also suppress event_limit accounting, SIGTRAP
generation, and F_ASYNC signalling.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Acked-by: Song Liu <song@kernel.org>
---
 kernel/events/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 24a718e7eb98..a329bec42c4d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9574,6 +9574,11 @@ static int __perf_event_overflow(struct perf_event *event,
 
 	ret = __perf_event_account_interrupt(event, throttle);
 
+#ifdef CONFIG_BPF_SYSCALL
+	if (event->prog && !bpf_overflow_handler(event, data, regs))
+		return ret;
+#endif
+
 	/*
 	 * XXX event_limit might not quite work as expected on inherited
 	 * events
@@ -9623,10 +9628,7 @@ static int __perf_event_overflow(struct perf_event *event,
 		irq_work_queue(&event->pending_irq);
 	}
 
-#ifdef CONFIG_BPF_SYSCALL
-	if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
-#endif
-		READ_ONCE(event->overflow_handler)(event, data, regs);
+	READ_ONCE(event->overflow_handler)(event, data, regs);
 
 	if (*perf_event_fasync(event) && event->pending_kill) {
 		event->pending_wakeup = 1;
-- 
2.34.1

