Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E4485652
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932449; cv=none; b=mBwzGR4IjsfnkrvCJ8j1S2n4lvzKuEuL8+IgiZPbLNv0JXGgPXiTAeZH+MSdZszgyTvkQ0of+awaS4odwoBIE/kUws3U8qlphBfeOD28DkWPq16sFPd9qQmYXWMLStkKfXcsRK+g4gEMyTpr//RMUdC+DUNR7n7ZUeTzHMWgKyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932449; c=relaxed/simple;
	bh=PX2QIRe/Ic85BaGVX4Y1MwT3KJ9EiLQ96IEJSBjyAmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MnrFyiJ3MdIt7mACB0Q+2eRvMHab4QohJgby1NlEGCz++4PzZHqGFeAxThiJuKJgDLTfdyYUN58Yut6JxAN/VesI/WaYuyHIAirvGsXy10Rpjl2kNgdJZaBe08SNX83tiQ8ddPa05V05C1il61pJ7zT9Xs3yFk+SyDk33w7sX9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=OPM2+jI5; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="OPM2+jI5"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5dc816e4affso1893149a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 09:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1707932447; x=1708537247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HG1Z9345f9l/NkzG8Y/mlPsfRpv6azyFKs0IWGP/jfI=;
        b=OPM2+jI5a1lsGQN7mpklD9h+LInX4e/9Kti3Ophc6GHXLnrZIOULn5dEbwoQ+cnVSM
         /LsWpst9DYAO7/0u9Uz0o9wnwtFGILz9q0YRJvKVNfmG0Jl5aqKvirnRNa5OUWa8B1GP
         SR5yGTs9QKvKp5Js+L7mzTpFNSZ3eJxEAYSFdvIr+twcCP+Le1AT6LQx+UWbpQMZQAN8
         SVPyITIlvaUcFzbyLV9AMY7dzZHIQCDVthQwfXelaRmMkwC95H+OG+sUTSbWpfiCu+ns
         CaITZlwXfkv6RMcdQ7UAgaKHQFCEHRhTs+xBtgga0XFo4XdmmTMdXRsIzUFjM1LfEOYj
         m/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707932447; x=1708537247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HG1Z9345f9l/NkzG8Y/mlPsfRpv6azyFKs0IWGP/jfI=;
        b=JEc1ft/OYW5cPoOo5NKG8XpOqbkQTXFZxQ1padjODqdvtr8cfL/Vm9YwAa5EqLBemh
         Od6Cogaxazd6q8ueABqlrcN9eSWh++j4o03i4iMA6e/7gQgbK9nFFcM6Cs8uBxT1/BS6
         Qa9V1HcxgjlMRRfWdlL6W+HyOv/7BOlMsjpgidgYaCr8srGck0x55SoawDHu++oYOblI
         PnZ7FwzWfE85dhYnlH1NvGqk4u1+rISxUmSjBtd9NHKquqfJvI68FMSo1TfLkBL468Eo
         YUwZdygBgQWEs3oR7Jia5GU2zggsTpmYab0pNbubaF66ni9Nhch8EWQfLynQR0Bu0qK/
         PaCg==
X-Forwarded-Encrypted: i=1; AJvYcCXpRxkTBwKDNFH+5dRjHLRvuHwlm4RKk3TuNFZ+DYCczhW84+OqzpcuZQVDZOxoIfs9Ansg8XSyLcZCDpToh//fUWjOruXPZtHrz/LTW9iiTQ==
X-Gm-Message-State: AOJu0YzQlaHU/S4D8P2PUYesvKYTIMOxf9BsB7qVQqWd7h96MLsUzWb2
	WB+4buUEeFjM1alTteoOLv4T/mMYFd73Nuogf417Dw58/m/axxxTua8vTqU+rw==
X-Google-Smtp-Source: AGHT+IENtoExpR4R0UgDDuR65Iu+tEswvgeW9/vs4xc1NOLROh77IEBzJgo5ubBcFQUYKsn2dOKbyw==
X-Received: by 2002:a05:6a20:5a05:b0:19e:34ea:36ab with SMTP id jz5-20020a056a205a0500b0019e34ea36abmr2596022pzb.16.1707932446967;
        Wed, 14 Feb 2024 09:40:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXCVm9x2c70Y3aUaKd5dJ9CyzyMqThObPmrRdxYZr+tKeNMU1F1t+87B11jHOCr3NjPSIjrc8unAoIFwG9j0ZWYfOUjq8Y//B8Ho60+jtM9/uIvVF7wEczEsKXfEZdbu4k/Y9gDo56B4zs5WTz7e8HU/vqmCrH6Z6MWpoEhr0laUxGnMeEoblbsvak/hKw7m0PitxNEgtda/ZfHIx0dItrJ+KMd2YuYqP6+nIRaMrV0tkWBYd60QoHOrxAP1b91xYjlvSOiS+hrHyKD+87Vj1ixhRsn3cZeOHk/i5mZamezp2z0CE4R0OzfEWoHj2rf9Ebdhn1/cnVD7Y+EXw1jOIXyYLZaQiQ2HfJEXyp/cgEvJd9nuISq0xMvVvHjqsdlKV2SDcOmjp1mCfBjDHkRZLt2pQEMu/cQUcGGi9PpWFjBJ0N3u1KcM3kfAj3rOcfBr8ouBYBh3YG/6Dn+nmnZP3fQNVfkKmR6Ilx/c0SR4B7kSy7dcKwVlQwpXqUThPCp6ernnDjQJbXCLoZAo4D5a47aC5fgS7he5A8wX+LihWY1lh8=
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id p5-20020aa78605000000b006e0874cbaefsm9567604pfn.27.2024.02.14.09.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 09:40:46 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	Song Liu <song@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RESEND PATCH v5 3/4] perf/bpf: Allow a bpf program to suppress all sample side effects
Date: Wed, 14 Feb 2024 09:39:34 -0800
Message-Id: <20240214173950.18570-4-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214173950.18570-1-khuey@kylehuey.com>
References: <20240214173950.18570-1-khuey@kylehuey.com>
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

