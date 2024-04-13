Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FBA2135A
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Apr 2024 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713017811; cv=none; b=nOU9j+9u2/UXo16UNrCIpQCol+c4DtH1falCRZj721SAa0NCdfoaV58BqARyQPBFi1b+MGztNn9gr7Q2zi5889U19D2NcTaZBWF/+bWuHWZq/zRywbeM6Sz8l4M5kzksS7nvdimfNKwufI0TszQcax/y9XjvzoTw4pI+qb7OAqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713017811; c=relaxed/simple;
	bh=DU50FXhrCuqhtNLOaapUXMuCslN3deTrvJGkJumTsUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U/BJ3VDPpjtGmmiMUMhdRBYZ6eDtyLHJzyuPGGtou0uS8xhYb6AK9ldhESTzT/+qrn2ry1g8ZI8IMKqGPkwjR1UwQGTFsIA5BdsfbElaXvlZQI5azOVqMu7pCE6RJdekOcUHhn+xUT0IgGGtqbNXbJJXutu9QEbZw9tC212Q6sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=cAPy4kkf; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="cAPy4kkf"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc742543119so1680361276.0
        for <linux-perf-users@vger.kernel.org>; Sat, 13 Apr 2024 07:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1713017809; x=1713622609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDrdykoIXMbP7phUYiJI1yePs0EFYaz2XrXDwzySQjw=;
        b=cAPy4kkfSUmZR+hXckSUlPaaef5IwNiFk1XkRTaHmRByL/XdYZzAVkZQw3fQ2RkU/H
         PDsFtC1QBrJ9aFBk8g878ctQYK/V6YLzMLkGl0Bqrmka7nOk6KnPPPSK9Y+/W5bSPOsu
         OIUwymznFCGbP2wHqXfzNSAtBsk0cx7S885WCO1ru/X2bHU3PpZmG+3AMw8wNkDIu8QJ
         QaxuE71FaXyggY+CpM3JqIe77nuRMXEts1Msn9AqGrANKZSrW94MYnYaQJJ3s8BRTcR7
         fjd+LFixychMnKqi8syz/vjfg2/8v/WobLdfYLEIB423mgOOYi5x1r3Rnd8OWWVEIZts
         7f3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713017809; x=1713622609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDrdykoIXMbP7phUYiJI1yePs0EFYaz2XrXDwzySQjw=;
        b=Ioa5MMa6w3KZwr1Fqu8XjvDepRKjoWNvdvDgfZlP78AO702P6yhTGeGe7P81R9G2Hu
         DV/fmDheNW6ZD1VJAyPjCPR93eadbkE25fovQXG/QHfcA6eLDqF+Xju126dLTL7W1xyO
         w4Jj6tuEhQSD9CbhOrwuWdd/+OkYFNX8ncA+qlHHfutCQxf+WdXLevBn/5R0hitb4Woq
         2Bj9WLRrcbvASneN2Isg2C2KzRez/LXu3rm1RpaEUkWvb07l0091XR/wi1ePlVIp68ir
         JKaaij9L+9gPIbw7zJKtevMPt1r08OFF7S1XXhZyvV0k8voiKl6P7QCcQG0+dCG1Ma+y
         Fing==
X-Forwarded-Encrypted: i=1; AJvYcCXi8URtuJBpqDcZ0J1NbOcseVObdZ9pS6vp5LlSM2l5VWme4wcfb7elg3zrtG7gg//HG44VlGV2vBZUu0aWBu8HQHw+qij96fWoTMQndJXvyQ==
X-Gm-Message-State: AOJu0YxPZx46K/nSdjZOjlqkTVoSrwU4dUbZdddW3e3tb7dpoTnHCNz9
	WMF8flA1a8bQJ307OB1xN6HW/fV3kw6AP11dO8KgOBSXFwXe16wpHD1W5G1dxQ==
X-Google-Smtp-Source: AGHT+IEPuFA7BoJq94Q7691/uH1K4Hr0sbggqPd6G24r2jhNxtEzpxxCYcjtl26dmMUD1ygx7+PSww==
X-Received: by 2002:a5b:890:0:b0:dc7:4460:878a with SMTP id e16-20020a5b0890000000b00dc74460878amr4899160ybq.3.1713017809304;
        Sat, 13 Apr 2024 07:16:49 -0700 (PDT)
Received: from ip-172-31-11-157.us-east-2.compute.internal (ec2-3-145-99-109.us-east-2.compute.amazonaws.com. [3.145.99.109])
        by smtp.googlemail.com with ESMTPSA id v5-20020a254805000000b00dcdb6934617sm1193349yba.62.2024.04.13.07.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 07:16:48 -0700 (PDT)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rodgers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 2/3] perf/ring_buffer: Trigger IO signals for watermark_wakeup
Date: Sat, 13 Apr 2024 07:16:18 -0700
Message-Id: <20240413141618.4160-3-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240413141618.4160-1-khuey@kylehuey.com>
References: <20240413141618.4160-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_output_wakeup() already marks the perf event fd available for polling.
Trigger IO signals with FASYNC too.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 kernel/events/ring_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 60ed43d1c29e..4013408ce012 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -22,6 +22,10 @@ static void perf_output_wakeup(struct perf_output_handle *handle)
 	atomic_set(&handle->rb->poll, EPOLLIN);
 
 	handle->event->pending_wakeup = 1;
+
+	if (*perf_event_fasync(handle->event) && !handle->event->pending_kill)
+		handle->event->pending_kill = POLL_IN;
+
 	irq_work_queue(&handle->event->pending_irq);
 }
 
-- 
2.34.1

