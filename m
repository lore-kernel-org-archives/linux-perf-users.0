Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CA719DF8D;
	Thu,  5 Jun 2025 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749146427; cv=none; b=sY5dLU2EAyKrlnwRuF49OPuCuCQuRES3o6vwZ5p8QEiua3odC/87HkvvQQdxKdxaDfVLDHxSUA3C3nSTY1PqG4v7M7iD5YKBsfwQyj9noQVm6QBRD38ELk7A9FNKs/MxnR11Q5cCGWML6FGMXNLOjOxlavMSj0kDVkPjurh9SFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749146427; c=relaxed/simple;
	bh=55t2jOzwJu/Pe94Z1MGgGTsjmdsmro44z4m15Q30ch4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pGLXSn4FouMBp2hFFXcGoKakKlXWqFMpoqjHZBsjoc0cL5sLnvgkqWqbOI+077KH4TkhpWrVHv8x6+wwmELOrQuEuWgWZ15WH7RtYSBsHXbkym/LLDhiHzoN8D54MDWblg2OPNgOhKNYS0Bv6Kk00dTwC06Xn0cW3K8cTF0H9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dv6PqxsS; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv6PqxsS"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-747c2cc3419so1028548b3a.2;
        Thu, 05 Jun 2025 11:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749146425; x=1749751225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RF8ffXs2a5We2CWtSW9yaEOhQbyIvm2awu47Uy03/dI=;
        b=Dv6PqxsSe/F8WQQvl3KK7EbDGn4S0pD4Ta/iyhnIllWoTThmEsyjowrCvTqq3cRR2W
         ky2mvyDmKVcM66Sy8bYf5sZr8Pkczn7Q04J04EDQwBO2mDDA8Ij8VHKsO2u3786knpiC
         523j/u8U10YoYzRS7EiXycRWW+8g5qDg19rtP6plXLEJcEzpGSvScdYifYz6T9KZExiS
         NTgpg3+HbOchPnN32e2zgJRSP7xByjiCwgWIiUTvWmjPel2t6bTU6eKwbslrTpNvkaE8
         yB+tqvLT+bAbFQBJlXwgmGtFpWA+2K70eVLVK857WOtSA0fRyuW0JwYM1GuhZNX/SnyN
         1BbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749146425; x=1749751225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RF8ffXs2a5We2CWtSW9yaEOhQbyIvm2awu47Uy03/dI=;
        b=Jfy3lGd9Co5QZOiwJXA+w3nZ3pfs0rKzPcctwBqCtL+6Xaedz0SN0emj+BBQ+Ixpyx
         wq6OANHqx5LbGM8kWq6pkVPJx9sgxHLNZh9zO4aNZe93Z0azc/r8XeXV/bhK3QP59X1N
         Asl2b80PDfV6b3gPOAdkN2F5MbGN3s6wC2jfjymktAKSU1MjNdGwi7zbDXoJOFe28TwQ
         EgCu7O6n8mxG9ULIZAzjHodpHkRo1q5VkuBHUyZyCQWig24JH3DO/Gdqsy3UOvOc54ow
         HshPGq1HYmxNRTG2MBg3BTPGd5rI+BWxDuthlrtbB2EvJh7fyWv5K01Quz2vInoISqct
         ln7g==
X-Forwarded-Encrypted: i=1; AJvYcCVbCb+wzcvLNuWDbDN7IBbN/KTpf2S1F8wz0E2oHYC3EVwBwGbIk02ByoOGzLIRmE/d16Re5Z4sdchPwcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJJU/r03y/qJ1pzar5G/PBR9rEfHLZ21yi6MeOBHlCgPi2ElHj
	fPTGvmZ553iHvc4yI37YYmZfabffv5yBqvQhPj+o5S4ExILfGMmX2IYp
X-Gm-Gg: ASbGncv3IULPmmtqt4dyBXWcv8ULzBkEU19k2jxV8xQAg5t6RyvOlAfCP/WifMu5kCs
	iOXNLpXy2V3buoZQj17hScUNN5HI4Ov+pSiTQHRSlBK9IgXvMNBd9SoGhbHfO3cNIabaJRu2pJM
	N7fHHSbA5lS6LSPbWHTvvv9+Bq2+kiSRVVqO+85JWwGKkFNGhbGWqWignUz5oWO7Py8yru9BOzQ
	9dnUAAI6J5k7NQmSALwphOoNLkM053an2LEEyZ/w3th0ksiMI5MwSnzB6Z3ap2s5QfXPar7rFHC
	cUxI/EEBGKPiufJw6fsRYFGWJnhTtAQcK6YZRLliZTT9A/1CcP5qNjrJRlzsnrZ5GaKt9whG3dX
	uCjrISTfG9g==
X-Google-Smtp-Source: AGHT+IG35nhW2BaKHY08+bd9r62M+r94Fyct1DOa+cXTe18W6zYbZVo0lDD3CUa75gAzRZSVhbE65w==
X-Received: by 2002:a05:6a00:14c2:b0:747:ab61:e4fa with SMTP id d2e1a72fcca58-74827ea5744mr825231b3a.14.1749146423838;
        Thu, 05 Jun 2025 11:00:23 -0700 (PDT)
Received: from localhost.localdomain ([205.254.163.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affafaf6sm13405708b3a.100.2025.06.05.11.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 11:00:23 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH RESEND] perf stat: Fix JSON output formatting in iostat_prefix()
Date: Thu,  5 Jun 2025 23:30:11 +0530
Message-ID: <20250605180012.16788-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iostat_prefix() function previously included a TODO noting that its output
format was incorrect in JSON mode. This patch corrects that by conditionally
formatting the prefix string based on the output mode specified in
perf_stat_config.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 tools/perf/arch/x86/util/iostat.c | 35 ++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
index 7442a2cd87ed..1d9c20dab5c7 100644
--- a/tools/perf/arch/x86/util/iostat.c
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -403,18 +403,29 @@ void iostat_prefix(struct evlist *evlist,
 	struct iio_root_port *rp = evlist->selected->priv;
 
 	if (rp) {
-		/*
-		 * TODO: This is the incorrect format in JSON mode.
-		 *       See prepare_timestamp()
-		 */
-		if (ts)
-			sprintf(prefix, "%6lu.%09lu%s%04x:%02x%s",
-				ts->tv_sec, ts->tv_nsec,
-				config->csv_sep, rp->domain, rp->bus,
-				config->csv_sep);
-		else
-			sprintf(prefix, "%04x:%02x%s", rp->domain, rp->bus,
-				config->csv_sep);
+		if (ts) {
+			if (config->json_output)
+				sprintf(prefix,
+					"\"interval\" : %lu.%09lu, \"device\" : \"%04x:%02x\"",
+					(unsigned long)ts->tv_sec, ts->tv_nsec,
+					rp->domain, rp->bus);
+			else if (config->csv_output)
+				sprintf(prefix, "%lu.%09lu%s%04x:%02x%s",
+					(unsigned long)ts->tv_sec, ts->tv_nsec,
+					config->csv_sep,
+					rp->domain, rp->bus, config->csv_sep);
+			else
+				sprintf(prefix, "%6lu.%09lu %04x:%02x%s",
+					(unsigned long)ts->tv_sec, ts->tv_nsec,
+					rp->domain, rp->bus, config->csv_sep);
+		} else {
+			if (config->json_output)
+				sprintf(prefix, "\"device\" : \"%04x:%02x\"",
+					rp->domain, rp->bus);
+			else
+				sprintf(prefix, "%04x:%02x%s", rp->domain,
+					rp->bus, config->csv_sep);
+		}
 	}
 }
 
-- 
2.49.0

