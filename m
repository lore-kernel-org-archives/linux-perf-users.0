Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="DMpiC/Ho"
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB55B10F5
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Dec 2023 08:35:12 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d0a5422c80so9623605ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Dec 2023 08:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1701966912; x=1702571712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXhJZgRGOB5Sycf3QWqHrD17iXmXG1N3cpy0e+e8qfo=;
        b=DMpiC/Hon0R+3JwN8VGCqbuqzpnpWSu5pqBmcD9KUHVsbS11Mi8u5NBERxWWg/lGEq
         wwplDbbfBd7ZotHqL9Hg5bQRfd6wrwiak0rirXKR3XiFEcaoYP4EjjynBVYyxq0N1wLR
         A8EfFRf8m1mZG2VjVsuGib2P1Kx6T69q3Yzi8xvS/rO4eg95ANSkwLA1RVEhyKp8pIao
         gXbWsYjentZeJ0hY7C3HjXFFTEr4Mn548jUcNbQFpvxrDYNkNH/Za0pFvlYD8cG63SAt
         G7QwGBh5XBhmGHtgp7Vs38ha4HQHOxbF8QCBHHTfcyyGLN/MZrYEHTJWyQc7/vy9mxr/
         GbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701966912; x=1702571712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXhJZgRGOB5Sycf3QWqHrD17iXmXG1N3cpy0e+e8qfo=;
        b=GKlVXURB89AUoNIl7QME8MdxnTn2ZFTsVraoODjBSBrEzq36W+Wbmw8EGIUU3gpPIs
         H2Q2IeHkwJ2hDHHVQN7lnZQ1mZDNaTwPqIid44TEteHFVdz7IXDelGatRh7hRP+jP42z
         FigTMA/F0JAzMrYU6MjaOe+tLY/eFB+n4RhrdDMFoNO2JTE8wMw09zG0MGoP0MJply65
         RyT6+6krkec7Rp6IohMspSFfZhqV8e1+OaqsCMqVSKXdUpze/l2XGZvJ9Y2IzUl1noYc
         CyDwpnRsfyqkle/i9eZo8OtLYhVyMxaLbqOJsF6Cz83VWEAIwDVRtS1bIKI88zihGcIB
         XsSg==
X-Gm-Message-State: AOJu0YxQv7jYvOs2dK/bRLQRXmDm+SUFLvM5CRbS/zonYJggeUj8VoTx
	C9wjzXH7m2HBdSjhtJjjqKJaMg==
X-Google-Smtp-Source: AGHT+IHwJu6hYJPY1MxRyAcC09H7E2C4OK2vcYFScd3fqXrSpb+ZHHISC7s17+15XDaXO2CMHBPIPw==
X-Received: by 2002:a17:902:dacf:b0:1cf:c42c:cfbd with SMTP id q15-20020a170902dacf00b001cfc42ccfbdmr3656529plx.0.1701966912115;
        Thu, 07 Dec 2023 08:35:12 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id iw15-20020a170903044f00b001d1cd7e4acfsm6143plb.201.2023.12.07.08.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 08:35:11 -0800 (PST)
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
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 1/3] perf: Reorder overflow handler ahead of event_limit/sigtrap
Date: Thu,  7 Dec 2023 08:34:56 -0800
Message-Id: <20231207163458.5554-2-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207163458.5554-1-khuey@kylehuey.com>
References: <20231207163458.5554-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The perf subsystem already allows an overflow handler to clear pending_kill
to suppress a fasync signal (although nobody currently does this). Allow an
overflow handler to suppress the other visible side effects of an overflow,
namely event_limit accounting and SIGTRAP generation.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 kernel/events/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b704d83a28b2..19fddfc27a4a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9541,6 +9541,12 @@ static int __perf_event_overflow(struct perf_event *event,
 	 */
 
 	event->pending_kill = POLL_IN;
+
+	READ_ONCE(event->overflow_handler)(event, data, regs);
+
+	if (!event->pending_kill)
+		return ret;
+
 	if (events && atomic_dec_and_test(&event->event_limit)) {
 		ret = 1;
 		event->pending_kill = POLL_HUP;
@@ -9584,9 +9590,7 @@ static int __perf_event_overflow(struct perf_event *event,
 		irq_work_queue(&event->pending_irq);
 	}
 
-	READ_ONCE(event->overflow_handler)(event, data, regs);
-
-	if (*perf_event_fasync(event) && event->pending_kill) {
+	if (*perf_event_fasync(event)) {
 		event->pending_wakeup = 1;
 		irq_work_queue(&event->pending_irq);
 	}
-- 
2.34.1

