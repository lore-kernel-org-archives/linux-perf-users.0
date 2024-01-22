Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3A3FBFC
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jan 2024 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705904752; cv=none; b=bjWKn5fzDnE8KPi+F8Vu3uvo/mhcLhTe67ekjYwee6nrYcmGQpohz1XL5bic1hsePNCr8kCzsz/qYhpKt3WeAWnxFeyxoAKmLdo4QDCjMegRQqWd6QuggnEu82hGXrDEvkIIO372kAS9lrz0nL/CJ9KAKmdg02gVY7wXKFoPfYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705904752; c=relaxed/simple;
	bh=PX2QIRe/Ic85BaGVX4Y1MwT3KJ9EiLQ96IEJSBjyAmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JMfzCaS5wv3W8Pxk8k/rZfWYYa7p2vITVAPTStjyY4X4H7p2LVgAhcM0LVhSujhUosZssgCh7m9/pLrL9frkqeL1jRwxCDrwkOwejt2zjaDXol4J5wzfozlixJQqGP/YNK+6E7/hgj4ljaA8Nb7HRr5wfCQTnKkNErs7KbDuANo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=I6iPxPpg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="I6iPxPpg"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d746856d85so1097415ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 21 Jan 2024 22:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1705904750; x=1706509550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HG1Z9345f9l/NkzG8Y/mlPsfRpv6azyFKs0IWGP/jfI=;
        b=I6iPxPpgibdZmdGTFHQ3YWOZDl3GyH3s2NYG0Rx4+Cih6gJ2JsArkBciumk59fxrKK
         nh8SfP5VylN6We9SpQ+vRuAdIvEExLSZq8JjOxZL5cG9QgWqzTkHWgEk4qj/9m6dpv/3
         U5yUIOXndWH5zVsn8GIvzjDKwa9Jfbhfp038ORPkmqovMxvEtNdQS5flBVozKyEQU8vj
         rw7n4OPzlPYYV2heM6g6J5kzvrDC8iw616N/YVefDFcKxmuG35M9UBLbpLMIxtdI7aTK
         1Ovhco2IlJeGpvV/vSp3elrt2fdahanZz7Su/Lz0RM/X86wi0Uhop1xFimDz47oh6RsR
         iClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705904750; x=1706509550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HG1Z9345f9l/NkzG8Y/mlPsfRpv6azyFKs0IWGP/jfI=;
        b=bL5D637NQOQTq7+d2VzinGAC6x6frJwxjnMx4OofsWBZUsIe8VYKvRgCX3ui3j0fMf
         vzaVSxgtsWp47ypWt+ciCpXSGrfATISGMcM6beS+7NsbfwAn5CxREYlTakcCvXiB4abN
         Lqz88Eok6wWk12WDxdPRpvCP7Aalye0VUOqkFU/DK4Ze0vSn9DVxOS2XFrrEftKnlzJY
         g2VCaidQfZaorELOso8aystgFefB3sH87cWuFGfXbcw2Wa/wzejcLuLlLNKnrx4DWCZD
         YpM9OJpXgxTBI3CpBq2kJg0LClLc83SPBtEtrYJsL9MNy/jQ7YsGxTqzr4Phu4A6Q6Io
         PyHg==
X-Gm-Message-State: AOJu0YzaL/JmqhhIX51/eLswHVnHKGwDn3bdOcIu388JNvnPn5XryUt5
	OaVJeP/F2i/z8B3zkTGpq7Ztj4fnu7rOJRazPVmFLnbMrfZUxS8g12V3ocu5Ww==
X-Google-Smtp-Source: AGHT+IGjwwlnVe73yDG0DhM2YMf89F/r9yfjLGi1/9gc8G0ZQeVTjIN2iKAG0BT0jk+WB4Z4UIUUgA==
X-Received: by 2002:a17:902:e5c5:b0:1d7:4060:78b3 with SMTP id u5-20020a170902e5c500b001d7406078b3mr821096plf.39.1705904750581;
        Sun, 21 Jan 2024 22:25:50 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090282c500b001d7248fdc26sm4317771plz.69.2024.01.21.22.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 22:25:50 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	Song Liu <song@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v5 3/4] perf/bpf: Allow a bpf program to suppress all sample side effects
Date: Sun, 21 Jan 2024 22:25:34 -0800
Message-Id: <20240122062535.8265-4-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122062535.8265-1-khuey@kylehuey.com>
References: <20240122062535.8265-1-khuey@kylehuey.com>
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
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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

