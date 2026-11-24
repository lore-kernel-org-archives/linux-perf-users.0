Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521937;
	b=ZO7LphhD+JB0KVqbaz3rUIulwVTnQD4dnJwntkGtlf1WmzAsj1CpWuO+cjoQwEn7VuLS
	 usenZeobFA2UHsUsTC6Jq1xgtRkN0wkEJiGHDUXTelxvd3G6/8kODasodbPCSn5rXT2v4
	 q0yuFBax5clzZk687Z2fSbLrFHFGDUKzv5nVws8/pjWHAfOGMcJZ4yngPIXPlQ/8j/H0v
	 WIXv2c6KH8vzAR2VFKdBXzOoJib4hkJtmIIFLzdS4HTY7xeqzSruOH53SH0BG1zbwLYDO
	 PSskqJM5pmeB1dp0CkfNBXBWj1vDkHIFAsBMZq5DgY+mA4+lP7dnGhKLfZIHbo5UYzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5IernkkwA+DoP/JgvUM6f7W9BvN1ADy096tR+AYqelk=;
	b=q++3lmjaqo8BMMsdqmCgGWaZsGT6i6KCmD89mVGGzJdJt/6z3OQ6nQH5WTXz91EKX5j9
	 c6FQob/fi7JZeeI2d1tgD3NbCA3ES4/N6SsmckKdt6RKR96snRg5bb7BkM/+nnX45p5Fn
	 nP4kPcA5IaX1AOS6viyxN2FhYtrhHJ92CnAoQjgo8w0UTY21o060Ilx5YMdJi9nQmJxpt
	 nlZvujRY1ctoDJGEb8xob/9F9lakU7Dzi5YxQ7wI0m9ljJs3C0ZrOf3lGnalqo93W5Mhd
	 YCJ9Z/h/mvIN40pllohpZvmAa1EiLea5F9NzPbcizDHI/0f+9QCB/n0BrZWVbcsfdPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jo8RUMQZ;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C1606A322
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 12:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C3C1606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jo8RUMQZ
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2f07a960666so24085085ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 04:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795521937; x=1796126737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5IernkkwA+DoP/JgvUM6f7W9BvN1ADy096tR+AYqelk=;
        b=Jo8RUMQZgn4cqGAq/vlqdQ95A0r8L14yCvkuzGm7is2hPSuCO+yRyUSqmQFvcNL/20
         D6tehF9nWi2kzHPw8dc+hRSiiBMLaP1fWS/C4sbeXkyOtOM0jAHkdNt7jsIcqyEFIDcO
         KE5/ZcjyPvUsU0JANb/HXWcn0NV3wdANyTjoFiRuXM/GnBqxdS6i3qbRtPqfCNqQcLkI
         gRZG92HTbuloPRK20VkbVywmH7jhDXdvDtkmrKkTHJjEP53mhU2xrzlFwlWxzlKo2Exu
         BWfKPnVeW4vVw2QyZlpWNx8ceDXStxajzesj5LkmVmaziUyJirHykcGNgKW3DBKdAHLt
         Idtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795521937; x=1796126737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5IernkkwA+DoP/JgvUM6f7W9BvN1ADy096tR+AYqelk=;
        b=dTSJ+8lLLuAg0KWCXdGNnu0UtFQOIb5qRcfnQhLQmZlRDgZswToFFtJ221B/kZncpx
         UPstp0rFGguCIQV/ijVxEEwQjKCQoN2LglHNwa0P1kkADcRyzZEEISaZ+S39xMyeWayg
         xYYSQPDnB5vIOj/WSLRlKmJ/TnEtP4XMY45jjGlQp2dTw4a2KVD+ksgLuumge5QYmD1P
         +LlH+RY8ZFqIvi9aznYc3NjW2dqJKupkTu6u5pltgd2p3v863nrGNXIqSs+7FgzRpV/k
         2D6ClsXesn6pvpKXyV3/A1pKCoWGLoxqngdY5RgLg8OkT8FvBgjD1UUg4QX7zV4j2REB
         pi5g==
X-Forwarded-Encrypted: i=1; AL+hErGAQmhRVYhssk13Vtxl9iocTJyquuEyCFZe6LPoCZxDr20tdfq7AWiVHSn5yc5teW180mvnFOCA9Z0oBxqaSoQI@vger.kernel.org
X-Gm-Message-State: APuU4Z8tKCJK13ww4BWepLeHT22a1Fs0PWy01661HnQuQfWEfLFAmW4M
	JoNRERfL1ltsV3gqHSzzLUBgqPUNXMZzxzzvx6Yiy580YiT3qDms9yQj
X-Gm-Gg: AZFdTZfObMN0Cl8yPpWmBU7FkyPKzFNueHnANaX32vaUUU0aZBgyfwRrPcati3nPseC
	25Esn5zHHPC9fjrUPNmrJM/jC6aet+uHP8zskFaCmqnTM+sjLmoP2/B9S0IpQwzS6tAujb3VvAX
	rhbxoazZqkzffD74hxoER1Fqq7t1+yFluOmyCykN3ZjkYnLfthv9BLhKQDvHXLbOBVnqtBHhHwz
	9Axzjq/oZCtWHulTkxB0XAewJZ6eu7gW+T1cc5N8JZPfBGoL1eiLjKsp/wFZAQI4sXDqZ0T7z5W
	fXKeNX1rrd8s+IVmOje027MpAyCgRGejoUnoLZcC5B10dWO4rS5Nri8OK3D4ZqOvKbcbO7VTf4u
	eTMo7/BGfqE6hMc20dDthk0zbb+BzFiarjAbwpW2/3ZRvxsIaqkjMgcHl/nzecR9hs+4qv0Jm+s
	Ons3PcYvWuab7zGZ5Dom5Yb7hcyq6P2UBP8PGNtWzenwbIwc8b4B6Xo0ud1D+h2oA+Qj/2kQiEG
	EDuTvLZIp6nR54cRlSzX8LKOyBJ+7xODjzOYjiWygy0jMgDqbK+PLIJyuuHv2sIEPeP9nxP01TZ
	ScIiCHbwTqvM4T9oHhXNGlVlXhGxuT0mSFPZFUHLnOdsVgilSP7xi9iDWHj6oA9Mkebikwgcf72
	Ez4iBl/JK9AVPOurFuHq06jkYVgahVeTyjPDocFdsVgNRAnpxo26vNME1peC5JZhsasQ+gNoTof
	a5610rYjq7WmRZELRgYqhzhW8zMlm/3PAgUTe/3Ee7pICjBM9MZHfSBrh9AQh7NaeNCNtVHXrkL
	QNYXN47vFen2oqxKHMKwNF9ra8dv91iOUDfDnaUiMQ1LVYf+EAR/k98H/wEgFOq
X-Received: by 2002:a17:902:eccf:b0:2e9:77c0:c7ab with SMTP id d9443c01a7336-2f03f1277f8mr140248475ad.29.1795521936572;
        Tue, 24 Nov 2026 04:05:36 -0800 (PST)
Received: from localhost.localdomain (27-32-254-230.static.tpgi.com.au. [27.32.254.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f07d6d4bddsm39621705ad.62.2026.11.24.04.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:05:36 -0800 (PST)
From: Daniel Wade <danjwade95@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Kyle Zeng <kylebot@openai.com>,
	Aditya Chillara <aditya.chillara@oss.qualcomm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] perf: Wake pollers when CPU hot-unplug detaches an event
Date: Tue, 24 Nov 2026 22:35:03 +1030
Message-Id: <20261124120503.334-3-danjwade95@gmail.com>
X-Mailer: git-send-email 2.39.0.windows.2
In-Reply-To: <20261124120503.334-1-danjwade95@gmail.com>
References: <20261124120503.334-1-danjwade95@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CPU hot-unplug now detaches events with DETACH_EXIT, so is_event_hup()
is true for them and a fresh poll() returns EPOLLHUP. A task already
sleeping in poll() is not woken, because __perf_remove_from_context()
does not call perf_event_wakeup() the way perf_event_exit_event() does
on the task-exit path. It sleeps on until its own timeout.

Queue the event's irq_work, as merge_sched_in() does when it puts an
event into ERROR.

Suggested-by: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
Signed-off-by: Daniel Wade <danjwade95@gmail.com>
---
New in v3.

 kernel/events/core.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2de4c3cc37ac..bccf16beb325 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -15345,6 +15345,9 @@ static void __perf_event_exit_context(void *__info)
 	list_for_each_entry(event, &ctx->event_list, event_entry) {
 		__perf_remove_from_context(event, cpuctx, ctx,
 					   (void *)(DETACH_EXIT | DETACH_GROUP));
+		/* Kick perf_poll() for is_event_hup(). */
+		event->pending_wakeup = 1;
+		irq_work_queue(&event->pending_irq);
 	}
 	raw_spin_unlock(&ctx->lock);
 }
