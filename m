Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E83EED8;
	Sat,  5 Apr 2025 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743862691; cv=none; b=etXKw+dn10jZZ0X9wQxj1jAwDJGgcE9TphYKaAJEhl4/lnXAkTbUNjYX9vSDoAak6/rfvbGdx6BMl+yZzvbhCln7sArwEAeBXeZB8wrq43+vWPmNuxIzIZOHh2SaWWztm5V+7yKsljxtZ2XrooeGIfsUgi7NPh+Mkngp6QLqsNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743862691; c=relaxed/simple;
	bh=RYogpzNb+dyDpBToF2VgTMzylKQ0FC1QSxDg136hEGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaRtgCkX8h0ciEOcvb/eZvrsXiAajwoEfCb0sRH6nxF9sPx6YuShwCBoBao8LokWYNodihrsLy6wmXOocA5DYZdVP8l9KYMCykI0Km2N3TRzYCOdiuYAxRSD4YE/ybKTl2DH9zhD1SYsnNVQfa8mofWDNr8JSdLo7P6tjlHOIHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kb8v3RMv; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kb8v3RMv"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2255003f4c6so27453535ad.0;
        Sat, 05 Apr 2025 07:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743862690; x=1744467490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnUeLjT9fP32JkaxPR9vv84+FGSPWB+gaQNbEYbIN4g=;
        b=kb8v3RMvnn6bKpS3RWafegWK+e2JYMhiJdqV5sFYQX0ivFNp5xijmW21D5d5t1A/hL
         qFH9b1L3616lVvI5H3eeoGAshr9inGI7G91+XlFT25mimr1LjFjRSnDvlEnjei5vkcD2
         4zeTALft1TNm5Kv/f07oXurTF8COFWXGhzXF4F5Tz0Nu86+ccl2hNdTSJdOt8zlRTj2y
         gmg+InWNVJ//Ol7SxLr6gdaLqyn/Syw+88G5jFjgBeUSxmua1lYYErncfq90JS8fOxIv
         BDyeWOWL2KEocG3YbRh/FDeTSNP5A+yQGlvF2xNPuWVcmJhr8dDOq23nNxGlXEdLMZk4
         ybrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743862690; x=1744467490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnUeLjT9fP32JkaxPR9vv84+FGSPWB+gaQNbEYbIN4g=;
        b=ksvFXmZ0gJgdvOzWeHeNKevvOPycssueH2fpSPoxMjhXcDRugRAU6KYu+PUZj1VbN0
         iv25uy/4XCQUoi3Ms89bun6G8DhCWy5Od9AZ0eLVQXU7eRF2GJKnPp7BsiWCpVKRAMrz
         dYuc7wjQa0BeptAAJc7MHtJ3HvbHZKO7kiD6n6MFvRgnvhnbInfDlW8B+ZdHydIxXz71
         AHxPEUt9FwLfvZzDRZC/cJ/YXgIREslYJCLDwj3fGIw6ByALfjviiH3IkUaS4x+6c6Cm
         jVMHi4lBRAOTCfXY98zrw0C1Q2n58DOE+CTPP3COxlsbS/eucEFKwg0ObvUmY1nraSZP
         Ug7w==
X-Forwarded-Encrypted: i=1; AJvYcCU8OvuRPFFFa5CVY2rPNt0Qvb/sPqFJJHQM3A0VpsfrRYNvwtOMKeH65pDxvSywEnc0ydd2GFm5nCNj1Fa9S7uM4A==@vger.kernel.org, AJvYcCXQeKO7QO92phKOxMek6p3F0tCEJVx/tSFjgRWlWcUot+eHI93qyP7Pm8OS8qeErzeeRwKrACwNKUlADYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsH2FYt+4mpuHPFKSmHOWsB52ZlBErg65A+Ea71Ded7k/6HQ6p
	yM480fcam8iw7W0NCdNyTYzUKzYWNpR6IMGCzkyFKtqEXHUoJO2x
X-Gm-Gg: ASbGncs6iMAgUmpFRuluYlZBAxYxhySw3O7akdFCDoeEYHmclAa0hCVySx0FrrpeaqC
	M6CU8k/ScE5Ow1J1Qdw8sBPEain/z30qkyWLC+c6Qi4uRMyCWy+0HCMLxp60ywWJFdTpmv4KsDe
	zCe+SpW4NKrk2PduqW7opZ2yLys0/gmornuhX35Yk1BKQx6yxlHFEys11U8QtBn9KLDZ9rqtugE
	hcgTikn8yT1gLj2+ONcKYGxqhsnJ5QmN+KicnoqzxRFXl2zpNIgRbTWEOdlrPK0PVwNxspF9amB
	8yau4UcJpvstyZilT3mvb2YsDvZ3SqItBqIA5nDpl1wYTQ9TsO5KXu0WXToF
X-Google-Smtp-Source: AGHT+IG1bSLmCqtU0Pe50nPPGZyI7JsHOdb+YY+DlUZ0ff5jxgC65/9P9e5KWsNLdbVKcSifIg1I9A==
X-Received: by 2002:a17:902:d4cb:b0:227:e980:9190 with SMTP id d9443c01a7336-22a8a0b374fmr104431645ad.44.1743862689679;
        Sat, 05 Apr 2025 07:18:09 -0700 (PDT)
Received: from localhost.localdomain ([27.38.130.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865dfd7sm50208505ad.136.2025.04.05.07.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 07:18:09 -0700 (PDT)
From: Qing Wong <wangqing7171@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qing Wang <wangqing7171@gmail.com>
Subject: [PATCH 1/2] Revert "perf/core: Fix hardlockup failure caused by perf throttle"
Date: Sat,  5 Apr 2025 22:16:34 +0800
Message-ID: <20250405141635.243786-2-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250405141635.243786-1-wangqing7171@gmail.com>
References: <20250405141635.243786-1-wangqing7171@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qing Wang <wangqing7171@gmail.com>

This reverts commit 15def34e2635ab7e0e96f1bc32e1b69609f14942.

The hardlockup failure does not exist because:
1. The hardlockup's watchdog event is a pinned event, which exclusively
occupies a dedicated PMC (Performance Monitoring Counter) and is unaffected
by PMC scheduling.
2. The hardware event throttling mechanism only disables the specific PMC
where throttling occurs, without impacting other PMCs. Consequently, The
hardlockup event's dedicated PMC remains entirely unaffected.

Signed-off-by: Qing Wang <wangqing7171@gmail.com>
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0bb21659e252..29cdb240e104 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10049,8 +10049,8 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
 		hwc->interrupts = 1;
 	} else {
 		hwc->interrupts++;
-		if (unlikely(throttle &&
-			     hwc->interrupts > max_samples_per_tick)) {
+		if (unlikely(throttle
+			     && hwc->interrupts >= max_samples_per_tick)) {
 			__this_cpu_inc(perf_throttled_count);
 			tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
 			hwc->interrupts = MAX_INTERRUPTS;
-- 
2.43.0

