Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C990D21421E;
	Mon, 31 Mar 2025 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432218; cv=none; b=YYyPgJv/RYAEfRTDdajcqF1KKwrdWPdwVuBxKagZmabFSCZPPqOl/hpBHOXwAQkgzMSl9iaxJU3HK55iFC49kJyRK1c+iiAo5RUvsRxb+7hazBwKKNvrBrPWoD+IEfk5QEglcvhi+jqG6N3HWXmgGp2RAaLYag1eRw8e3MJJTHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432218; c=relaxed/simple;
	bh=1k7wfiUjLvDc0oD8hF/7/N+tECtT1tiHPpq4YW/Bwdg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=muPezYyA7wr+YE/gL6G5Tlst4bYoNrYVi2xxvtIT4P9Ia29J2csSInDamHtZS/3qCvELTOTkSMGoOaVbL4ytm/pRWmK3eHvR6jTaNwUMcn0oGA36H+jyvY7uqvMRaO9S4+GBe2tw4UFchi7sKgp92rZnfkCxA1C3t9SOgQnZcrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5e7AoIQ; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5e7AoIQ"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2243803b776so7742865ad.0;
        Mon, 31 Mar 2025 07:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743432215; x=1744037015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6OeNAcmiThB49WdycxJho/lyo9T9VpLPBujpK5ApRhg=;
        b=g5e7AoIQMrYdsbNe77XJ3gDTQ1DdwmsdRcCK9OF48XVRVv5JIGEQU+6FK6yFigbMgU
         EvPR4cjqA/y1IBdbMKHCfUJX8Jf+9C2Yw2HIkfjsN+SWo2KQMtYl1R7Y7qXARadwQr5L
         TzSwaF/cVMNM0o83qCOh8ehzEG+yCgVSbhnhrGMCz8Bbj6uYj52lG9hp9cQZa6gwP0HQ
         l+OPWxWvxNX6COjyN3RYLQtk5i9TVZaQSxHWjyk1QlYppJIcOGKjovKPCqaauzsl60ji
         yLXBigAoD0VL6duXYmboG6Kbys1C2niL1cmI/g1OCfOHVLf6JVhfmul40Dkws8MrrwSN
         q1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743432215; x=1744037015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6OeNAcmiThB49WdycxJho/lyo9T9VpLPBujpK5ApRhg=;
        b=IWGvmYED9deC9sHkVa1N9hgzb5RVjnH3KObbvoxFL5uc+UvVJUXtQveev53eQWMwC6
         rEZVkk0Kew4OzqUgHhPComL1uujk5iqmwCPUd/LYpOwhtNzL4+VzS/zju4o08f6CR+l9
         lof/im/6P0axqsCztwzGOAhQ06O7gPMuIsols1P0+6bNO3POYRI5/52CxYCrG0mCGGqc
         9dOjb7glP8HG//neHHRABV8HlIsLVRVXwYEbcJfrz/x77nOuo2Y5vb5Y8SqoKnsnDC22
         q4hv3waa87nKmgw0lApMgZspn8RHvE23xIxPUXn0lWiuex8+4uz3bi+BIppa55WLMVBd
         fBSg==
X-Forwarded-Encrypted: i=1; AJvYcCV1fcT5+qd0GIWJo5eAxlEuxaHwFVcVgezLoc7m1J/Bk2PKmXJVC5wcrYgoGjoGwocvv1qrQtZsU8x2qM1hiwB7Dg==@vger.kernel.org, AJvYcCXASmmO6MpWTWM9H+Mz+vfkP5QuKtIIcKtmDtj1PLRRa5M3xJzs50YGCPx6qabACKufCC+ejazHEX/8quI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwN21VnoVIsFvQPa4H8/jpy3qL0lUHYF5aY2L6V/WAwQk+Ttdk
	0xz1OTDKmWMVA7vSCs9dJg5NwAEQyp3tslz7z6n/T5py19FQ1oR2nFuGSi7OhRgC1A==
X-Gm-Gg: ASbGncsU02ulFlNLlRhiJ4Wt1hsTTuLxoiH9cui1tAPPOl4SJG9qJlHSueTVt3y9RNw
	Xz2BQS5QXWdsWvgiXt1nky9P67J+W4XR/DiRAsjsm9D6HAz4aem3ZYdSMkwflOJiq2E0Klv2hmQ
	lXOb0SZ/J5FdqLDI7M15XCvDc2qMMM3AC/Bnk+UssVV3o91zfh39sudHSf8zwujyvDBRnxbdTR4
	m1uyEseeuzWxIHsG76h6//+pgX3lliTvr3kIwy3oICCRArPPFZgZpbqHVyqailmD9FS4Cqe5WBn
	lOf6as3hexM8/iS6DDWpK5QPTfjndAmrNakRC6N37T9oKETqM6ABz3IpERh0sVHzpoUIzLQ=
X-Google-Smtp-Source: AGHT+IE/DDrZ2ZWjOx8brhjMz69HQaVZRBK9VOo82IiKfky+Z+TK9eua/q/0dyP8hsucVMqNqGEVcg==
X-Received: by 2002:a17:902:f709:b0:224:7a4:b2a with SMTP id d9443c01a7336-2292f942aa8mr171906545ad.11.1743432214969;
        Mon, 31 Mar 2025 07:43:34 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1f7dcdsm69548345ad.216.2025.03.31.07.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 07:43:34 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v3] driver: tx2: Add NULL check in tx2_uncore_pmu_register
Date: Mon, 31 Mar 2025 22:43:24 +0800
Message-Id: <20250331144324.12940-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kasprintf() returns NULL if memory allocation fails. Currently,
tx2_uncore_pmu_register() does not check for this case, leading to a
NULL pointer dereference.

Add NULL check after devm_kasprintf() to prevent this issue.
No automated tools were used; this was found during manual code review.

Fixes: 69c32972d593 ("drivers/perf: Add Cavium ThunderX2 SoC UNCORE PMU driver")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V2 -> V3: Dropped the redundant error message as suggested by Markus.

 drivers/perf/thunderx2_pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 6ed4707bd6bb..24443ab5d998 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -738,7 +738,8 @@ static int tx2_uncore_pmu_register(
 
 	tx2_pmu->pmu.name = devm_kasprintf(dev, GFP_KERNEL,
 			"%s", name);
-
+	if (!tx2_pmu->pmu.name)
+		return -ENOMEM;
 	return perf_pmu_register(&tx2_pmu->pmu, tx2_pmu->pmu.name, -1);
 }
 
-- 
2.34.1

