Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="TKGWwN1B"
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42AFEA
	for <linux-perf-users@vger.kernel.org>; Sun, 10 Dec 2023 20:55:58 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d0a5422c80so35465525ad.3
        for <linux-perf-users@vger.kernel.org>; Sun, 10 Dec 2023 20:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1702270558; x=1702875358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoADJIsaU4bvjYI7gdqH4FQT1qltoRFf88+tkPG8tZk=;
        b=TKGWwN1BMSfkcarzFN58mcceccPtTKo8f+lsaSmGESfSjcWXVzeVturjsETQBsbmFx
         KoFzR0qSE93M3dMBH8rwryOSXnsHsy/ktAVjRiH8ZWThdUmvvFdSo6m+o39XW1tLokql
         TZZCzt2UKeWBkgUg15enpKP+v+8vlN4oR/uaWp52O7LdaqWQJXf99XOf2xc90YSpbfX/
         aPRFQdKIKvUP+O25NwGvrJ6cywElGOKbvQQ81ttlMgK29w2zSm3KQ3o7B7Xo9Vlw2xSC
         9INEfPcO6VTPC4wEaYbnmjqIO922djMFHBBlTQ/kUX5QYXtleLSNqrGZzCy3toqswhN1
         an9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702270558; x=1702875358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoADJIsaU4bvjYI7gdqH4FQT1qltoRFf88+tkPG8tZk=;
        b=TA/+TdBxzX7xkT6V9B4xfGTCZTsTOTEfFPE3P1WGyGD7Uqvgx/v/bD2lTNa+iWQERW
         VkCGFTXvqo71G0HkbEf3z1it9mhhltb3nHQr21CkZrVMr8qTf+tJfEB6pALdNzEBdUS9
         C//GLg/3GF4ScyrOu0/0YfGi0FdOFEkB76n5ZSxV/3FDd9jfNdT879bLURfw98cXqRUh
         jrRajnL/jWXaK4qxsrymdxu0mp0VvziN6+k6C2vnuZRr6PD1GmDYrCnJkNCTkzmfEMsP
         A/gQ0SOwAAimGmSPVWWPRDFTWnPgNEZ4ypJ0t2YbtTHNNAdpL4du7f7kpMGonZVSf9kW
         9xiQ==
X-Gm-Message-State: AOJu0YysZoImNa1OdB2IYAZXcIUhyvgPWeCJOTelge1XpVa4SY4b2dzB
	+kYfCgm3ZT1UHE0pszd+4UeuEw==
X-Google-Smtp-Source: AGHT+IHW/xB8+qfj2EAC1FWaRV9BV7vEy4h+GdJx19JjFNP+gJ4a3gVBh6F+eeS7FTFAgLsaSJA/jg==
X-Received: by 2002:a17:902:bc84:b0:1d2:e976:bd21 with SMTP id bb4-20020a170902bc8400b001d2e976bd21mr3501188plb.94.1702270558222;
        Sun, 10 Dec 2023 20:55:58 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902b78b00b001d2ffeac9d3sm3300623pls.186.2023.12.10.20.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 20:55:57 -0800 (PST)
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
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 3/4] perf/bpf: Allow a bpf program to suppress all sample side effects
Date: Sun, 10 Dec 2023 20:55:42 -0800
Message-Id: <20231211045543.31741-4-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211045543.31741-1-khuey@kylehuey.com>
References: <20231211045543.31741-1-khuey@kylehuey.com>
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
---
 kernel/events/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 54f6372d2634..d6093fe893c8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9541,6 +9541,11 @@ static int __perf_event_overflow(struct perf_event *event,
 
 	ret = __perf_event_account_interrupt(event, throttle);
 
+#ifdef CONFIG_BPF_SYSCALL
+	if (event->prog && !bpf_overflow_handler(event, data, regs))
+		return ret;
+#endif
+
 	/*
 	 * XXX event_limit might not quite work as expected on inherited
 	 * events
@@ -9590,10 +9595,7 @@ static int __perf_event_overflow(struct perf_event *event,
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

