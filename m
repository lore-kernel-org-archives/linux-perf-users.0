Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154D5299957
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765572766; cv=none; b=o/xX2LhVVVwhVOBpc9cMZzFIFqvrs2GD51p0FIT2tw0vr29csAdomkOc3uCjCXj6K73h6dVT6EkNVJ+dY48n8fwoJa7krOT/XWqw4z0/fMpBuHp4j3mVf/JyFKlR8vbUd+hAP5CVK6t4yClC1r1DrhnY3AE60xMyFHSO2yAQSgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765572766; c=relaxed/simple;
	bh=9fYRrimgIiTKXZYd/EF9KOl9MYrzTOyNOD93TwEfSV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lIvJFt3iG22haOwncH5V2/Icslu3fWtG6I//yo55PPruRJ3N6EWEhoq8FC89i/QeM0O8ghRkvI/jka0Wt8OMbbCDLfD9saqNlJSI/I2ZYTpcCVVeoCky7c1e4AwS5LIoZ/Z7MMNMHgumdYTi1w+Adfrzb27FigFtLHmUCjMTLno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqL/2i3o; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqL/2i3o"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6492e25cd7eso2486112a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 12:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765572763; x=1766177563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9sFZwm6P/eTEW8HSDvzBFG/JtDhhHz6uY5r4w0vG+u4=;
        b=EqL/2i3okkIImhkeQektOdrp6v54DKCgEt5CMXkDK2hQRk00aSwF1BMx/4fa9Wlv+e
         XkWSbtgVGApb44pIxlbs0U+0DJx5Yqvx+vM3DaI2rHMnokXUp5hNXFBTVNF3uNRXyCMH
         88zwaA/ewgXMiOQDMk74XJPR5Tl0iO92yJkGfNqpQRhtaXPZ9thG9uC0HxwlMNh4tjML
         xmBVoQYFf4lnSkkvn+/UFGAhAvA4D2RF+aPYKpg1b79RLBYjGLKojBbPP3Qa090y+XFR
         WhbvlDuP2XsI4jlU8E2aWkuDoiRZXLk3dFsP3UTHZ7OaHp30RjywhPGI11Nh1tun9dt9
         YaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765572763; x=1766177563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sFZwm6P/eTEW8HSDvzBFG/JtDhhHz6uY5r4w0vG+u4=;
        b=O3v6N6koqedCs5y0dwBzELqQFmM6Mt814HIQO/37QqlLmogGgpngdqO8Y0W/WmURFP
         MsJFwCe1bi9gX20tA9ePzrVmKgEwnMdrl7wS7QybS9SKgJ4Jwt1aeiOR+SopwClfLepm
         0ggSyPJezz508kePq5O5F6rB2pqzfzqhl2f1uWL0gLOginHIoDG4kQM5xf7n4FfGTLNd
         eeXBEBeOmXLlvwKdnHIR6mJA29KyiENJGyukA2H+SGiPcBe90sbeX1mtrbe8+He77ofr
         XY2oXm49ixQ4iGQaseYv88VguvMu906iWjOU0tmVqloiOEAlefDU0R4cvy9qztP7dSG1
         QzKg==
X-Forwarded-Encrypted: i=1; AJvYcCXkZ+LhPxFdcMJUSi5D4Brp1e6QSzh8zr4km7iKZgVz457rqEYsy4pCTH842MvXlpHo3cY84KOMDiMHIiumZAkF@vger.kernel.org
X-Gm-Message-State: AOJu0Yydt+k5xM/tdDogo8mCmxLtV8WTKKd+3YKMOONi/9X1WbHfbedm
	oegiiAxetU9ABaQHFCFtMxLHzkN6RPc8BNgz1dEPgBDWRq2Y/oOqVIvf
X-Gm-Gg: AY/fxX5i0e0L+GVhO6se2e91wuDaa9pzGD6TOeMfyNUOL46xPB3azw2VES1KaqM4qGH
	zR7iUDJr2Jusq8wGU5KPMUA3sQsoft3y+7ZjilICkTamIPMVbWhQhUYOuzThUpaWdJUubFPYs2u
	j5Hq/zTiMPPZqzsBvYWlXagTXGsQ0yPmXo5tChLlX2Le90h15H5jxQYikXdd/YoL3/n8TGuVXB7
	Ot1jD8CfUxOWsJJDSUA9utDSfP6GdiICi2P9GEkKnYRXvj9GQ/J5qwkKdTfkK/1Dvn4X/EApqrC
	Pa1uKI24zn9RQAsMfflUlymUZHKz5PeLN4FWGwyA1u9Du9fViFdUYEAbr7UvdI11TmGDs6VR8cN
	J93yAI0SXaarlAgHUqkI5GQ3IpsUcJsHajynbgraMVXBm72lyTvr10WCqTQhh/o6jJeG9cbZnY1
	wMxFMKQ/eEKdI15W0=
X-Google-Smtp-Source: AGHT+IGauNGo93h3WEI/GJLU8tPuFP6dTz6xspdiaMF5oCtj94YYZxyDSgzm2KKKpYumZ6r/xvEekg==
X-Received: by 2002:a05:6402:3133:b0:640:e7bc:d3ce with SMTP id 4fb4d7f45d1cf-649875a5929mr4355420a12.11.1765572763049;
        Fri, 12 Dec 2025 12:52:43 -0800 (PST)
Received: from osama.. ([2a02:908:1b4:dac0:1401:37b6:6a29:b0c5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64982227ba1sm6260075a12.33.2025.12.12.12.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 12:52:41 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] arm64: hw_breakpoint: warn on invalid breakpoint length
Date: Fri, 12 Dec 2025 21:52:30 +0100
Message-ID: <20251212205230.84606-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some tools (e.g. perf) incorrectly assume that breakpoints should be
sizeof(long), but this is wrong for AArch64 where breakpoints must be
4 bytes. Add a warning when we silently fix up the parameter so tool
developers can get notified.

This addresses the FIXME comment by adding diagnostic output rather
than breaking existing tools by returning -EINVAL.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 arch/arm64/kernel/hw_breakpoint.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index ab76b36dce82..4d31842e5d91 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -475,11 +475,13 @@ static int arch_build_bp_info(struct perf_event *bp,
 				return -EINVAL;
 		} else if (hw->ctrl.len != ARM_BREAKPOINT_LEN_4) {
 			/*
-			 * FIXME: Some tools (I'm looking at you perf) assume
-			 *	  that breakpoints should be sizeof(long). This
-			 *	  is nonsense. For now, we fix up the parameter
-			 *	  but we should probably return -EINVAL instead.
+			 * Some tools (e.g. perf) incorrectly assume that
+			 * breakpoints should be sizeof(long). This is wrong
+			 * for AArch64 where breakpoints must be 4 bytes.
+			 * Warn the user and fix up the parameter.
 			 */
+			pr_warn_once("hw_breakpoint: invalid AArch64 breakpoint length %d,
+				fixing to 4 bytes\n", hw->ctrl.len);
 			hw->ctrl.len = ARM_BREAKPOINT_LEN_4;
 		}
 	}
-- 
2.43.0

