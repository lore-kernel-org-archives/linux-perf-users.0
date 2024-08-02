Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E9414AD38
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Aug 2024 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722596042; cv=none; b=hIxTJ/1tSYlLaw7zAD5O3kdjzVJwvNCE6TQ3/5YzbW6WIECCx0I4l1m0zivyYBNGzHmpatTSD7FhfNFNIcsO7WncG08wZsTLk/SdeJC77bb/fmLjvQDJYTS9Yst39SdxPsL/d3Q2ihNTiFagA9dBQ+PU9ZECkPaxLKIVDCuGyWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722596042; c=relaxed/simple;
	bh=W3k2qVNyuZkZT893TNnnlsdcL/dnwQiUDPlQIC8IsGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HNObOTMdSbVSpxVApySxY9/P3L4xykoV796Qaq0SsoO01Fg0TTWqhDkO/EN8SGuN0/hzzW5LlNMxF4qeYIJba/VJ744WCnlO2cVcIVl+uNg6LfLZ548QFrLqGqCYlxi+olualanuXpqdSKVPMO7EABumnBlQxNcQknaI2tjuWSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NZI5lUgU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZI5lUgU"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428e0d18666so13162565e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Aug 2024 03:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722596038; x=1723200838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7Dr0n7009Osu6At2MK4/anwH9MI0U9oAcIhAwlkzIw=;
        b=NZI5lUgUOY6BFscr9/5Pwuo6MgTYVZ8J7C8mtAUebPe5T6X6Da3eR8MYa1cOKSCp0D
         jaGK6XYtw0M3l2oKLepnviQwToZbozG87/plDtp1hBArauNK65DRZxE4WNHyl3fRDUT/
         L6aBKj24sSuWPiW6mXTCNeRzL8DTrVlKYwBmO7u6Zxg7sI7l7f+34Gunt7aDJSTwfxNU
         o3TTJoGMwemY1GbIL6tsB0rKfUCWbrmP9qiP8GvPKSDttTqLx+J16i356LC1OmncISCX
         w9y5ZXn85cyargc13NdYfdm7o+5wizcgjyKe3whIJw0iOviLOmrC/35tgN25kDAbrHGG
         m/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722596038; x=1723200838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7Dr0n7009Osu6At2MK4/anwH9MI0U9oAcIhAwlkzIw=;
        b=WTdurX2VfBYOVmwggrD6cpiTl+pNPWPPrfNCKe+6AZNo3u0S7ZivAotcwJp40ZHYt3
         Nh42bRixY2Mf20emSjGtylT7HEj0aFBuBpJTSZuC6eZ/ZCLIc9QGx6Tl4QshqSewUIvv
         5w1ilUucL/GaPYllRZSHg0jFRGeudb/hB1ENJnfPQYC8fkpPDvqegUYRivSovzEO8/ER
         MV8MH7J2nFyMZ5RmAsjQCeTovCKcYycxsRcbFbwOu1WUK9hhl1BQ4MvJLdleC493hv+z
         eFWoSiRjSWwcqCGb3Eyi3AjKc9z27/cZjo9xE3GUscHzSNY8wQ+GfgwI/pFbFXGQEOJF
         ApSA==
X-Forwarded-Encrypted: i=1; AJvYcCWy2+KKJG869bp/Zyl60vK5V2JGnGsvsgJpyVE5b43/y6EK1Drdrde7bdvIH4H6s4BoD8DPvXDJlFVAuyTxuyS4/Ks9La+nR+rBCR6fPTut5g==
X-Gm-Message-State: AOJu0YxzQhgrWxvLBpi0poZc4qoYMFmo4aVQE0rYLaH/EB411cvKk26l
	/8KrrV9iIGBrSefYCOJJCQQBiqc2EkB0bC9zcQrAKy5Tz6TwJ5Nruq0a53KW7o4=
X-Google-Smtp-Source: AGHT+IFb9LhZT64CqpWqP+bdwdX02NxjxA9v78/EehVjlumFJh1+ABYER1FHg3us71gvalOpldYGIQ==
X-Received: by 2002:a05:600c:1546:b0:426:5f0b:a49b with SMTP id 5b1f17b1804b1-428e6b7c1aemr20635345e9.23.1722596037778;
        Fri, 02 Aug 2024 03:53:57 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8adc7dsm89534845e9.14.2024.08.02.03.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:53:57 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-kernel@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf/x86/intel/bts: Fix comment about default perf_event_paranoid setting
Date: Fri,  2 Aug 2024 11:52:55 +0100
Message-Id: <20240802105256.335961-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default paranoid setting was updated in commit 0161028b7c8a
("perf/core: Change the default paranoia level to 2") so this comment is
no longer true.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/x86/events/intel/bts.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 974e917e65b2..8f78b0c900ef 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -557,9 +557,6 @@ static int bts_event_init(struct perf_event *event)
 	 * disabled, so disallow intel_bts driver for unprivileged
 	 * users on paranoid systems since it provides trace data
 	 * to the user in a zero-copy fashion.
-	 *
-	 * Note that the default paranoia setting permits unprivileged
-	 * users to profile the kernel.
 	 */
 	if (event->attr.exclude_kernel) {
 		ret = perf_allow_kernel(&event->attr);
-- 
2.34.1

