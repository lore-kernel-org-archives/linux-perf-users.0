Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340F722256C;
	Tue, 20 May 2025 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747734339; cv=none; b=vFYdaYcdL2RomJxr1TlkdB2+O73Xlls8Sh+0wBPE2CUfTusbA6ZG5GopWoMbiokv+ttaM6VM1re8BRhjNY1V0fTdCnULKJHSdXg2sOxL3jkI9MUOCh6zR4t7HuVNuPvl1HByBxJubssGh1KX3Bp7q8dHIdU2CIpwZD7+KXqoao0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747734339; c=relaxed/simple;
	bh=55t2jOzwJu/Pe94Z1MGgGTsjmdsmro44z4m15Q30ch4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aXfI4xGTpr1YemhopQVqBxoStnTa0wcsn9AW/Xd5poztBoN3IFLK/PGQ7N/nsHPXv9jCIcZE70Dh0EN6p+SrKNYVq2TiFvDgefmmnlsF59WX+UlS0Ia+kRfO+rAGu+uFd/UkS82hxp99s3OJd9l5XAxkDC8k+34/AaXID+kOZQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvHXCb+7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvHXCb+7"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c27df0daso2266555b3a.1;
        Tue, 20 May 2025 02:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747734337; x=1748339137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RF8ffXs2a5We2CWtSW9yaEOhQbyIvm2awu47Uy03/dI=;
        b=SvHXCb+7sELvbEyybNopZy3BqroEP5VtAl92gz3FBhyFPcM/pO6CarrISlRs6XZnxP
         QafyX29N7pZ0v1M/MR3h1cfDSs9RBuHZYCPYlAhSGwcCsXZ2eFyOoL6TSu6k6kky61x8
         weqiJHjkYDhejX3SmDKWxPmV8coCoDUZfykIX1SHIE7FjJDkPd6xpDbeV4VJenIq4HB+
         2ptqC8Yx+6I7+PBXrEDW+ykefrDlK3LuIoazqbA84vpeoTn+JJIu71W8yqzPAdjcn2Wx
         2oWv5pHsLiPU0HhZHEYutNAflFzHwXXX/+qfszGicVIoDsATrFY7zTwfce+GM6St4HBL
         DlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747734337; x=1748339137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RF8ffXs2a5We2CWtSW9yaEOhQbyIvm2awu47Uy03/dI=;
        b=ELorIjanlAW5I6yX4o5j4UGQiUTTDBRBPDUP+TrQLovHlBdiQM9pk+F0s620iT65KZ
         l+Q3jdcaVP81N3etwjh7v9pwigrSb7UJ2JhNe2zL0YXNTPhDGWsvOno7ZvjVbINNyuli
         X4mab2tcieHbTDYT5ARohHk1AcpgIZ8P9ISkx3hKP8y6+MMwGM9sVHue0OB8e9mfoaYp
         cIwCliDbenmNGhQAKRjp4vWWzVyMjANAvWmCSCqKztC2I7bYCbDvK9akvBPIz0iSZ4ps
         oIN43rLMLuoWAymB9FvAHLS7PESrP/Shvlqv029AuYRurmlRcJK/rxRbvvlXcBm0goGC
         CfKw==
X-Forwarded-Encrypted: i=1; AJvYcCU4t3RLjWFQOZKt9127I/tSIy5BjnDSEg/OSB7GleOp5VDcCCyreNUME7513/t46Fmo5VDURRquRNP8fQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+cVQb7G3Jx7NykQo//pq9YfsYZnl/RTQIr2dUHzYNymrDTEc3
	N0ER0dIi043UGJZnXkilQhx+OD6MowVxsUu1kHN86E/54+U9ClhSvyr7
X-Gm-Gg: ASbGncvIZTWL0bL8rOeb6ZSpu5/QJxGKdg0dwwejnHel/FiNumI2FbJxF9axDT9wDsk
	KltOYQIJ+3/SbpYQOkMsjRthuYx8khi8B3uMmcFDUbGMx/4VqjG4BivLaga0cUyEbCZyf8+PxFP
	PQUudrhQ1ftA/OtAARLWkK4zpNMRIyFbiOdgbTl2/v+dUFKRQbIoif4ejT9uRFOpCtJ1bvHMLfg
	xI94m0HVJvTDsQfzcGTAQK/QJzjgT/f4JFCjtL4ZPcnFT9PVUteR7VqDwwwlmgluCFs37/6tyai
	pCcxBufokI5PzMXQWnN8LOhrbF3BFJXFnH+YbrphK3q8C1biv/TLP1NYDpMUxRh9irdS8jw4v3D
	Ul1J1MT80Byt+UQ==
X-Google-Smtp-Source: AGHT+IGjC38TxGHkGLNwrYD7Ou7a0rpGqtFyhZa76JxTWq07mNYsWa8kQEbhMKoz4uNlmMMxii9iUA==
X-Received: by 2002:a05:6a00:982:b0:736:a7ec:a366 with SMTP id d2e1a72fcca58-742a97a2bcamr20340316b3a.9.1747734337299;
        Tue, 20 May 2025 02:45:37 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:62fe:9593:f762:39d9:3865:830a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a983551fsm7576457b3a.113.2025.05.20.02.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 02:45:36 -0700 (PDT)
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
Date: Tue, 20 May 2025 15:15:25 +0530
Message-ID: <20250520094525.97706-1-suchitkarunakaran@gmail.com>
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

