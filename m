Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C83359703
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Feb 2026 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031084; cv=none; b=Y8bPsRpjhP+xobifW5lDfatUnvWWXAVBBqmPT9DV0Wuf2A44tXgFDcXZ+yA75zyRJ7CBuAChhwWaVRtLC+97GEJMpS6+LY1bV6WL7JRiXvo7kpIv+0xFcnpRrFJbH/jC2bZpI5xvJDxxK+EFoFqeVOWMtfreUUnIJNgwwO6/+ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031084; c=relaxed/simple;
	bh=JSwlaJuSmvG1RtjK+9L/dsEVDHhEiHC3E6ttw/jwti0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H68INXerlRrP2i8qnvFxTtqXIX1WtvxEe7rLxtqOzVbBnAO93cGVw5DWwfQuZ+19/S8sIS4RIodu9J0evUxTdFDIKCoI21F//o0cyIfcb+f+h0wvPQovQsDBtjczagkqAlqTN7fYuvD/EM1wxNoldI7wvReDA2YHUWk32JU+Fjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JW0l9+Gz; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JW0l9+Gz"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82307c6902eso2183057b3a.3
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Feb 2026 03:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770031083; x=1770635883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QyoII6nqzBeIWsDGEglX8EZ/BM8yJuMFD3qz9JYR7y0=;
        b=JW0l9+Gz5TArnFI24SS3yoxkP6gY3T5v5PQhx7rINjrCbQc8iEt0Y+xI0wU8DVwwnv
         5etVk10PWhJiWMPTKWFekf5YBNQyCZYWzreRP2MjFsuTEQ0F4aQUTnnTqBE6QrUEvXFa
         oMmsCEtK/954YHzxdUkQUeZFN9vkd2jTlEH6igbQ5fBTi4ztLEujhIbzr3Qy9EH/Nsfm
         16uOqUmBgklLVup5kfRi4CgpAAyQU2UmXxTnyusyVKHQO1cgr/WOkUp3nzZQIh3DxPpz
         sHcBX+R2oEaO8qJWs4L92azG7YgClMWEy2AfzncJqlcS4rK/VIU551gCVcBhHWy+QA0s
         udNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770031083; x=1770635883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyoII6nqzBeIWsDGEglX8EZ/BM8yJuMFD3qz9JYR7y0=;
        b=mhMCY5W59XGY/iHq92mfTDqEq3+mQvk73GeaC6+29lEDuaqAl1knFSeuMqXJyuPArn
         p/1PL5s2kbN5rfD2uPQXzWWiRrAFY/3xn8hNkyR4lR0RinPjWy/FXSpaOT9lMIyxeJN6
         UAYzOnGYizxDz1Pb/h7W59l8sXHI/DnJz1h5GtQrFEc8tGFo3SOXFBoRj4UQgRCIIjWi
         Cf6KmpmVMwmtEhdmtgtGRpprcdK6AX2l+KKWIt0sRxtSLhGp/hwtn56apHv/832j/W/u
         MIPBdAZlrYo2WRxQ6CjuyiC1zKZuXQt/0QJ/kLDZA3qoz4lIKlERvCDFPmsNtHcZlhrB
         hryw==
X-Forwarded-Encrypted: i=1; AJvYcCV3LirGgdSWoj1FLcMNYFKPil4n6WgIS9Rz5XIT8PHGriG+1/DfhG/XSagw3AHazLjmReL9RswQuY9B3ND1I6/F@vger.kernel.org
X-Gm-Message-State: AOJu0YxnrxqV37nQ/AeMhyQ82SCY28SBISCpYLtlS6/Kfn5AVhLqg9ai
	GM45CayqA15q6AGAy5/RrpRPrzLmO3ak8NuJ08TQL2tdpTNv/bghlogPYSBALBAvfBU=
X-Gm-Gg: AZuq6aIM3868OIxQR5S3uwp0brSYSJO2hW33us2Nv1u2164oforUxZ19dL2SL1Q+V4s
	lOY5NwRjme09n2rzcZSDSE+MjIVid0JAQY1kdsWfTuyazXhpaA9wfSoV7p3Y6KjS1mo+jHIvH6D
	eblIPr+/So1D8i/F4RnFKB8f/k1p4GtOk/vkc/uHfy1QSSLk3Ll2btRZhXqFzMqNvCaCd2J9Fs0
	G3BdAjBJMhtM7qe+j0qSigjdOgRggj4E5OjCFspGUWdjwOvMXwqoNnYziAyGk5lfvXTqul6OFm9
	91HqE/4mLQeQyHXEWCErMaVTAjWq7cC7m54hsmvgTzS3ajH8DklioFWy5RPOnwDL+88pvYFO0N6
	37eNqtNUZIw3iGStTW4Z85Lm21XjBU09cxA2dMa3c+rVTgl8TPnSa4DqwbsyzirL2gm+l7Oliww
	U/e1A=
X-Received: by 2002:a05:6a00:1249:b0:823:9b7:9c0e with SMTP id d2e1a72fcca58-823ab75f14cmr11353585b3a.34.1770031082825;
        Mon, 02 Feb 2026 03:18:02 -0800 (PST)
Received: from n37-012-226.byted.org ([240e:83:200::8a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c32944sm16015811b3a.57.2026.02.02.03.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 03:18:02 -0800 (PST)
From: "qingwei.hu" <qingwei.hu@bytedance.com>
To: atish.patra@linux.dev,
	anup@brainfault.org,
	will@kernel.org,
	mark.rutland@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qingwei Hu <qingwei.hu@bytedance.com>
Subject: [PATCH] RISC-V: Skip stopping cycle counter
Date: Mon,  2 Feb 2026 19:17:28 +0800
Message-Id: <20260202111728.4067036-1-qingwei.hu@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qingwei Hu <qingwei.hu@bytedance.com>

In the riscv_pmu_sbi driver, pmu_sbi_stop_all() is intended to stop
all available counters. However, counter 0 (the cycle counter) should
be excluded from this operation because the counter may be used in
user mode by rdcycle.

Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
---
 drivers/perf/riscv_pmu_sbi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 7dd282da67ce..2bc0050dabd2 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -900,11 +900,15 @@ static int pmu_sbi_get_ctrinfo(int nctr, unsigned long *mask)
 static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
 {
 	/*
-	 * No need to check the error because we are disabling all the counters
-	 * which may include counters that are not enabled yet.
+	 * No need to check the error because we are disabling all available
+	 * counters (except the cycle counter) which may include counters
+	 * that are not enabled yet.
+	 *
+	 * Cycle counter is excluded because it might be accessed by user
+	 * mode via rdcycle.
 	 */
 	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
-		  0, pmu->cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
+		  0, pmu->cmask & ~BIT(0), SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
 }
 
 static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
-- 
2.39.5

