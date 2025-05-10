Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7035233086;
	Sat, 10 May 2025 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746898746; cv=none; b=PvEL42t9uTz4V0tLAOU1kvWQm/F1GLlZ+iWT/5sQ5za6gHo2Ru5Sgti/O3fD4B4++LK4JeRzsNu9xoeA8OdBAyG9HRb0K9D70OKI44Rt7Q81AcwNPc6eU08IvNjO8VWnwqnqNA67us6mFznTXEw3UM0meu8t+p4UVCXugHwPeHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746898746; c=relaxed/simple;
	bh=55t2jOzwJu/Pe94Z1MGgGTsjmdsmro44z4m15Q30ch4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YZQyy+H7H7yUIzIB07oBYh+swzXw7pfY5zRYJY4eoGUZM3h5DujIlNzdn1iQnyKTcC/SNZK1QDFdvs3DoBUD/oE6B5eHupsctkdsXGUBEgcNoLiMKLzCx/CIjCWvunu8+D4uXPV7j2kPGaW7nB34Li++xzjkyH6YLh28sOMJr7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWdod1Zq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWdod1Zq"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22e16234307so33918035ad.0;
        Sat, 10 May 2025 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746898745; x=1747503545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RF8ffXs2a5We2CWtSW9yaEOhQbyIvm2awu47Uy03/dI=;
        b=eWdod1ZqPKmuFvgKEKcJdhEjHcWAHGU768yy2aBQIWwAhP8c5F5ejETjYQdLYv/rHA
         HTo5Bt70akg/tOO5nY1AdkQh5NZ3NWOFXMZEQFixtN/laAWReuS4lGWKVH3iL6ClgcQ4
         rNRXc8U59+8e2whra+wzQCVz2TLNOUxEXGDQKT1+ERtxL5JuKL37lykrvJI/wbrMaY9G
         26MTK/1jchUStXoRqWIBNSCGKrCdm6guTRq+ctID2jPo8stnA3RwaiGLhH8LL7BEGt8Z
         iu2bi7EJnlEMk/4bmKDm4G+NlYBKSyzhJrttsTcuHcx+ILY430/ZCmazpjunNoWMCO3V
         A60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746898745; x=1747503545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RF8ffXs2a5We2CWtSW9yaEOhQbyIvm2awu47Uy03/dI=;
        b=KKVgYuyNQSPgbY2n65YlG96mPDnRgjz70er43GMl+X8J1ME6DIYsU3D3sT8SR2LkOJ
         3/BiniebwE2osO+hxEw0b0kmkCw3lWhatCLxzlhBslgFh9/0RIVe4Zho8/Xutgvf3Zkq
         3wsMZ7nBe0/g8C2No3f0JbqKcWVyi2u3i3ZANcz0rGC5bcrOas5nbcILUB8zDJDJx8qi
         UTU5/NFZ+gOhE1LL2h1FtYGcGTTppnnQdkIO7KZ24UrxnrmDV+9Utq5FCIvw/jM9d2WX
         HtJYO1R9RbPOgSemV778LbsBFpJk8c96UP/FJKLd3G1UBfytTwKEFcTLuX/jEuBf4196
         289Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsCaGwxxQY/Sjm+TR+YYdRb+qY4hp4weEnCMdW8A3bzL8s0rGqyhvvwEWr9O5U5bWs1+vg9BHgaJexoo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeDw+yT40/3Uh5JHRx7gzw91RZkHlA7GOXW8tJ2ZRYVpBvh7jh
	G864AbHuoZCyee6yyFf+lFiXuDjILq4OBW06sfpevB6mgJdYHG5W
X-Gm-Gg: ASbGncsIFEPpMp2hWjsxGOEr8CycQ6Y6MPRIDzoLYm3ViuMznTsvwzXba+/xxGhAkA7
	GWmWz7BIG97AMk2Gajmmfck5sTcnNcuI+U8kg/gBoP2bCE53mZwqDGYQCpBIHzDOCqZGuAJBpRi
	z0wVQfxZ0aBsr9X/Y6DtSDby3ct7E/7ot66Hq5YgZ1bhoxvWRP61IksK6jYlSeP6Y57S9jp3Qiw
	i20P0Zus+pJta/80aXlkAtGZd0wEsxbGREF7iBrWt1GKN1epM0lRIEqXZ1zfiw5lEzoywBnN9Z0
	9PJ8hQK1fFD63GLBXbVc7gY1eLsGsH05+GJ8YRaIwuKAQ56BVqd4ZLAozvw0F3t4qkN1KBWysB0
	FmGY=
X-Google-Smtp-Source: AGHT+IGTSxQPyOYD2KYBCUKfHwpds4RRWRANwFMGm8fDWS9SWeC9Jtl+M+LV9FTIZF/FsTZvk/vGyQ==
X-Received: by 2002:a17:902:e806:b0:215:58be:334e with SMTP id d9443c01a7336-22fc9340996mr94447795ad.10.1746898744533;
        Sat, 10 May 2025 10:39:04 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:7b7f:bab1:cfed:9805:ea32:5760])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc82a4c41sm35651255ad.237.2025.05.10.10.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 10:39:04 -0700 (PDT)
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
Subject: [PATCH] perf stat: Fix JSON output formatting in iostat_prefix()
Date: Sat, 10 May 2025 23:08:25 +0530
Message-ID: <20250510173825.32444-1-suchitkarunakaran@gmail.com>
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

