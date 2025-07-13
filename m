Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A108F58;
	Sun, 13 Jul 2025 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752419560; cv=none; b=acBCbqshCo8ebRB+8/GNtuisYNFTiElPtGhCK3k+5OJ7QGsa69Ipc6xOwqXhRfuJ1ttmIbpVu+kHdQ8hFW4dIDcdkOhpeIVVJ2pFiZKfO/CnU0lo4G3vSfBIz3stVWeY0VnlsUbk1P3ceE5EOCgH0m5X+cGG8Km+ypdO1O1dcPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752419560; c=relaxed/simple;
	bh=WhXhD8DoE5hAI18sbrgYoirqUWMUbYaQdRp4TZni8no=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MbADpBjVRFUNLaS56CY3EKLsHYd2eRWANiZs1X4U77towHY/NDpM7D4QY06I0suWJhDKvnWJiEed3T8nN6hSBAF9AA0xRLJnHKfpbTp7OsdzhSnAg4xOZRJW4BoA00GTMTSpfdvBaHBviQ/3RhICJCO38TSW+GIyVyoEYz0LcTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyUo5d1T; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyUo5d1T"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-748e63d4b05so2058926b3a.2;
        Sun, 13 Jul 2025 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752419556; x=1753024356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aOHtBlXea9cd3aN0INW94Xle4LZ4tirGxfQi/1kIgss=;
        b=LyUo5d1T5KMbJ2k1EsnYby83IMZMylDaFmUN6Pz3uBAvKjJm/W7Lbyzf2LeTgY0EdW
         fTAOwcCncyqCyjglMIrVinV2i+CWJkC39vf0EjQunK22KjepG2fCWZFy482H6pe2jOYy
         S5halcGeabb4DVJ1TSZp9R9lcdXuPvPlmSTYLLKmYZTRqNJj0KS4+BXPe1A3q1GWkyQe
         H2UyHV7CuBxxXCEb8SSBg3Wrm8dmvVAuHJaQSPu6gr6/BwIH2c8j2zh+8ieqI5tXXVHH
         gHxS5YF7WpoqY8graL8mFZgHK9A0YTdH2DWMBMBHH5iAbQahbTLViqs6Q6KGnul1loXG
         C14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752419556; x=1753024356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aOHtBlXea9cd3aN0INW94Xle4LZ4tirGxfQi/1kIgss=;
        b=CfnsEJiB4CO52W+2zbbcQOo42NvsGeU1i+74ufPxr7Oua8OIWqY/zQcryeDwWgLnbY
         8hamZ20XzyMt2qpxRsA3QWtdplsMnvFW3e5njmq+GxwMjavINEUSqGLIOAZUEsJjZj4f
         b4gALKT4aXeWPGdNNHItElTV/ODl8+o24nTvIcwSuEijX66jqoWDmcoowBGLJnTtQ+LW
         LesJpay9P3I9m8HszXcU2Ky56Ew2YM8oPrsoM2cblPuDJb4kOXBIbvN4l2cGx81Zp5sP
         LXcIQUPEaEc352eFFlViIoE7EUKI9Z08G79UtDWY68OQv949pJfktANz9KvPBOhVngl8
         bAhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVO+eAG/iP9j+vTYlb0swynf+/p/adyhn4VKS7YR54nTIxpYkfXQBM8+7fDUbkKisClH6a1s5igmZ9S5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN3qqa9KbM1Tg4l2W6/qWtwTp/t3JFX1BvzLICIViKEjf1niQa
	KGHSITHd1ieLMJx7BQ1M8H3ibT6AguVrYvVF3RsGY5RDEnLqMTgygwXI
X-Gm-Gg: ASbGnctIdnLwSMr6Ie3p0lGPLf9uQmo4JG16NCePbJAtkkkuX4WnBXtFvkUVtH1iFA+
	YHcnfHOd99OTeCo29neSmh8yjf39L6qHdlW3BTk8USvI+WqWyHzoYAowYEZe4ZEScEsBPMNSOPd
	vvtUh77mB+uRrbtDVOvFkUQo44vtkPG1KoRq+rbpr24RGI8grQoIcFj6UNx7tdxbBolqo/lgxH7
	5KRZVSyvhD9zZnW6ptqSKN6mVoTHgr6B4/B1ynMP+S8p23/eKM/92zpwIF1ugHcR0j62+pK+Din
	Y3EzVNgHd9OS3CAKyenu2ug1WQP3ZtzIguQAjTcwsA8a9E+T1hRshx+ttDcXRVlY3q931BSnbNP
	DrE90JKM7inSzzmqNBV8NOHAG6ukYig==
X-Google-Smtp-Source: AGHT+IFfS9CYUZRVVqfQakPYkDfbYFTQ4i7frj2W2HT7q+V2vCSSPfXsTH4UwgX8Xr9t+y7mbk/w6A==
X-Received: by 2002:a05:6a00:92a8:b0:74c:efae:ffae with SMTP id d2e1a72fcca58-74ee03a19acmr11235698b3a.5.1752419556077;
        Sun, 13 Jul 2025 08:12:36 -0700 (PDT)
Received: from archlinux ([205.254.163.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd7341sm8956513b3a.15.2025.07.13.08.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 08:12:35 -0700 (PDT)
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
Subject: [PATCH v2] perf stat: Fix JSON output formatting in iostat_prefix()
Date: Sun, 13 Jul 2025 20:42:24 +0530
Message-ID: <20250713151224.43764-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.50.1
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
perf_stat_config. Note, I didn't test it since my system doesn't support
it.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 tools/perf/arch/x86/util/iostat.c | 40 +++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 12 deletions(-)

Changes since v1:
- Fix issues in formatting

diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
index 7442a2cd87ed..d7ae19fb83e5 100644
--- a/tools/perf/arch/x86/util/iostat.c
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -403,18 +403,34 @@ void iostat_prefix(struct evlist *evlist,
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
+		if (config->json_output) {
+			if (ts) {
+				double timestamp = ts->tv_sec + (double)ts->tv_nsec / 1e9;
+				sprintf(prefix, "{\"interval\": %.6f, \"device\": \"%04x:%02x\", ",
+					timestamp, rp->domain, rp->bus);
+			} else {
+				sprintf(prefix, "{\"device\": \"%04x:%02x\", ",
+					rp->domain, rp->bus);
+			}
+		} else if (config->csv_output) {
+			if (ts) {
+				sprintf(prefix, "%lu.%09lu%s%04x:%02x%s",
+					(unsigned long)ts->tv_sec, ts->tv_nsec,
+					config->csv_sep, rp->domain, rp->bus, config->csv_sep);
+			} else {
+				sprintf(prefix, "%04x:%02x%s",
+					rp->domain, rp->bus, config->csv_sep);
+			}
+		} else {
+			if (ts) {
+				sprintf(prefix, "%6lu.%09lu %04x:%02x ",
+					(unsigned long)ts->tv_sec, ts->tv_nsec,
+					rp->domain, rp->bus);
+			} else {
+				sprintf(prefix, "%04x:%02x ",
+					rp->domain, rp->bus);
+			}
+		}
 	}
 }
 
-- 
2.50.1

