Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABF93043D8
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Dec 2025 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765625038; cv=none; b=Eiy9SIlzyDNhlHo15GmETF7FXQSs0cZMVHKGdIHxG6+Nu1jGWOIiAlsjyhyUL1Hw+XwxIN7W2yoe96vVVqA3HHMV0cLubYTqGTxhANYjqwfDUybiebiBn1Npwx9rKb2d1V3QT+/2vGuhWbfZJsv3f0budzsxnBFJ/23CB4Kdk8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765625038; c=relaxed/simple;
	bh=YUb6eCJc2It5mGWeIKRhG0AajcF/ry4goXO3kCBbqQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4ABMWKNo33eY1FkbyFN5DshiNcNl1MZK9KyBRISsM69YbVTnRdHaHUDsv9kyyyDFaGR7d5erXHpX9drQdBVt9B2G0RZ1FEu0Rg/ZBntPDP/svewPuYuXbwAHaFYXRsHWXbls2Ry6i5zig3CPtf+UBRdioFc3WCL/0S1eXT+eE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHR+5p/O; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHR+5p/O"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6492e7925d2so2320201a12.3
        for <linux-perf-users@vger.kernel.org>; Sat, 13 Dec 2025 03:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765625036; x=1766229836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vjpSv14GaC6bVnOsXqyBmuVelpdv//4j+xpDz+T18ZA=;
        b=YHR+5p/Oujzv+X9RPHQXshsfkzpgOcDonVn6X3Q1khY0KSq+grz80OYt47cPfkzvHY
         B0f2P5TNAdmW22++4gKMpeiZ/0J9gvXWFzkptC8ZCVDb4ziCYIw3xTAWMk91NBCOb60T
         ec5A7/h0Wb3hBgGyAM425d8zfLw2I3bAMT5Z2S+3crU7dP26LqgV038+WNSioslv/Znv
         ucgRh3W5DnJb8WF4UkOS2tbsMcvffHq0MtRYQtTIa1p2xdoS8HlUqYpvQWpIUFVxOsQQ
         oSwtNnAC+TvDeeBE+B9uDuFw1ExuKU/RmtnmZbHr7ZqN9T3xCs7NhmUkmLFYSRppEms0
         OFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765625036; x=1766229836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjpSv14GaC6bVnOsXqyBmuVelpdv//4j+xpDz+T18ZA=;
        b=qV43C24vRmUUdaOlT3MNAsRmek7tk5SqAt0LwyUwOI4+VzUUdaYm8IfwVxZ4dRqOsR
         13Fuh/Nrt1qdhFxjmvQyZoBLvh9RxBsesPlMtA11Z63KvZpw9UmRENtNJMQRA8LMYXce
         u8FmIdbDS7q56pIvuLMKWrZ/oVwqofRlkVRmPefXWYMF/+x/K9ANiAvvu0PH41xqZzaw
         uK6n41g+Id5xZTlEWexbBhZ3oYfZuZ0ZSrf8glVyTpMHEMGniw05Ujx7VX7ZR5rSyFuC
         //9K+IwOWl3nFGDCxkye/EKo/MiC3sqPY+86Ob5vJWDHEsGSvazYBRJ/3ASQT+yTN6Kf
         m3Yg==
X-Forwarded-Encrypted: i=1; AJvYcCX7oUm8aCH25bJjlwVW4aWELA3Hb7m0L1qO4qPoyD+k51ezsCXdsfuRHCaptlTfBhiJxVT7/wdd5Sv+zX/mHgd/@vger.kernel.org
X-Gm-Message-State: AOJu0YxZfdieg4i3xrifpx/JoiTDoHp6RZWIYz3IVbFRVDFhV+S6DjIo
	/Nbape9nFT8UZkzNYWKbxzyC5rIScRunQqO9v8vsWnnJxEPVqXSy91c3eVNx5Q==
X-Gm-Gg: AY/fxX41AQmSKUoGZahdTaBqZKwJBK69MODRSeUhiSLn+6LXhbCYec45s63npJ7bGCq
	cCJRK+cqYxFwv/dvTzdrWeEPK4f4xB/+NN1DXnOfUUzawPz7vxEG1DkNbqIJOcwk/tgGv2mFmDV
	RxiF37paMwJuSC8XI23dAR3JXVsnB04FgpRETyMfRzrhyUdLJ/u8W4SYRu1Ry3XSqOwGjg41f73
	+aEMEES/qYF2Mz2SV0At8OdnCM2nLUYEHCYS5o/tba1gGMiqfJLxuWqfcHeuNxeMeCv2/RUuV8V
	zJE1U+cdlbWrTQgHDQkorZJpp3gmPPeNmhwEkXYJG5Spwe49TCPzhFfTY8oSKClVYI22l2lQSyh
	wiufRY/TvPuhsuSaGmQ/4/MIMlmb7KnBeXyq8DoJ5PqWWEZiA+1X+CYHsoacAUjAF40oX/gc5oV
	Q6QAkH+5Eicx7y05vsihdf571ZXQ==
X-Google-Smtp-Source: AGHT+IEYxe6Uk2UQSbaAfOrK6Hid6iWaqht7OeoTZHp/E0x3y8PM9pi89/83Voy42lfYQGlSBhaidQ==
X-Received: by 2002:a17:907:94c7:b0:b76:f5b8:79e5 with SMTP id a640c23a62f3a-b7d235cfe6emr493959666b.3.1765625035543;
        Sat, 13 Dec 2025 03:23:55 -0800 (PST)
Received: from osama.. ([2a02:908:1b4:dac0:609b:e733:f100:d3dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa56a7f9sm822910466b.51.2025.12.13.03.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 03:23:55 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v2] arm64: hw_breakpoint: warn on invalid breakpoint length
Date: Sat, 13 Dec 2025 12:23:35 +0100
Message-ID: <20251213112336.26503-1-osama.abdelkader@gmail.com>
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
v2: fix warning messageline splitting
---
 arch/arm64/kernel/hw_breakpoint.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index ab76b36dce82..cce306145d78 100644
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
+			pr_warn_once("hw_breakpoint: invalid AArch64 breakpoint length %d, fixing to 4 bytes\n",
+				     hw->ctrl.len);
 			hw->ctrl.len = ARM_BREAKPOINT_LEN_4;
 		}
 	}
-- 
2.43.0

