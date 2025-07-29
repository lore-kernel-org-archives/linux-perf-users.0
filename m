Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8948720D4F9;
	Tue, 29 Jul 2025 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772793; cv=none; b=hl2BtIBHbaotUT89NYuQe/LLExn0Qp+uJZ3K+cKYPaC4iRNK4iBR95MNQudzdenpQxoJVmYYRUfUPkhOSio7p6DWy6F4DVIYesAyiw4lTWvq8js9XJ4DWz1a4vhWL7krPksFfv0/SyBJvzGxLVLyz0LiqebSIhrkCEknR5/e4/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772793; c=relaxed/simple;
	bh=9X7FbclAlAgH064Wn2VJEp64tOlkfUs5O5CddFL27Os=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xscix6Z4MdRBbVDememmpAH8R3RFgQqsme3eKhyH1xdb/TpCUeu+qU4vLG9pxmBEkwBQNC11vPtUZMZeGF/TEIhiaZcIKxqze/1aG2bHek29zmQgNxa9MrADzkJROPS+LCMT8O0h0Xkkwv2+cTJZMJeIsY6cdMLB6foyF/SQp54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbGmnjzU; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbGmnjzU"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so6494281a12.0;
        Tue, 29 Jul 2025 00:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753772792; x=1754377592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVwEerSqyXqjnTvB4E0wQkicRSlmUziq2hhxax3RXag=;
        b=GbGmnjzUm7wfF37vejwEqHSLukHyEhJci84j89JO65WkjsQ0oAY4gxHpvKH/zjLgm+
         7Q3rbT6YrHHJ08Ln37JNH7px69uuGA/TWP2Q3+Bz9y5SGooOMWZjzhr0cNDy63iwhhxY
         ju/hjC9OlTh2kvi15CLCC5ONU6ehJSpWIvqw2boUPRprJ4AuWjf0yBqs7Bl8ZHZrwzJ0
         yLDKksBrFFSVd9h6DQGmP4K5to81rmmoT8pB0VZLev072Y2WIsqYMGRQB78KL7QjmkJh
         ePLSbIlopoMnJ4Iwy/fS3GdobHWlbU9kbdR0i9tFF2bdYCRR8LpHw+wirEIWudFoU7mA
         bSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753772792; x=1754377592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVwEerSqyXqjnTvB4E0wQkicRSlmUziq2hhxax3RXag=;
        b=EiAuYDTq7Od3VA83Mp8HoorA33QfTGsPtcguzmFpAL26HkblHpASbvIheWbLcwEm3d
         RMlDhddO79z0zzVspQCS6vd1tTUX0a0jw2qPpWIqhEEeularzPCSbGY64eMHjFjC/uKS
         vPD3vflfRNfBokU7J2o/yHHFCW2SKg+pgng+aRkkX6fhkMS0Z719/+ZDYbAFhZJA3T0M
         KnUeHZcjsezwP2Pbg1vd2S5P12kdQZtdGGjvuC27pTODI563jYCxnnCTcewrA22vZamn
         2qjac7dmMc0TrRvOHqqab1WSiOvPIfF0l1B97fX99yGptBMxSMEHEt588UUV6L5nUdUF
         Iytg==
X-Forwarded-Encrypted: i=1; AJvYcCU2EnrQrsDgzYPe2SVfFEHiJ3wq68G7YqoIZi3YiqieWfm8Iardv/SNn35fsOtg5PAQN6KbzfuHzkN0oBXlmTjJLw==@vger.kernel.org, AJvYcCWbw9uoIaxKxKxGJef2fcfGd8XI6BoWsFoGRV2xZbJAtL9hFUAXDOjul+M/pxFp8IYqcP+DLYyHKNjjvEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Kfu4B3YhcOGUspjD8PAdHFgOxfyN6ND3bXzTLP9R476hslZH
	ALJ3iMAjLoYq7pJrAw/IgO5lvlUbVAVmHLKM5i6VOCuREnK8xdC0qQSz
X-Gm-Gg: ASbGncs+eT1ErLcv6aGKgSYvxaKK6o9rqpndmvRDRjNLu9bvWBivYLInYxOnHGsf2RZ
	xsAbtX8NzyRF/2zbE/onxjyNf3aAmtG5W9PLsIggIk9ExfVjq2RVtHOkCNDByoIpe6o4ikLfotV
	5zU0ABFMRKZU3nh1W+lwHUaEYkNecLD8O25T5rZV2GmbPZ8EtoD2DhKf+cXzrZJXHz99gZ/UNKe
	X7poqrNJHEdVMmOGl+615I7pSHpd9PoVW7MuYwZ8rAU/ylXi8T9u6G61AfWUZbE9uucJvAo/EbD
	BxFxEql+ntLspoO2qE2dU3PNNY/csz/IHw+QveOcIoc5qqqh7YTXswOwy4WyahCx49BdMj6b3XA
	pwhLxnkLySLQmtUlTl/Q3O9o9
X-Google-Smtp-Source: AGHT+IFwHc/m22qVlTvdQ4PIQixQsuTFAFaEOuAgj5iw0EdQMBeT/2y7vmG4ge4xXg9Q0A2ouF47lQ==
X-Received: by 2002:a17:903:230c:b0:240:96a:b81d with SMTP id d9443c01a7336-240096abbc8mr122047935ad.5.1753772791731;
        Tue, 29 Jul 2025 00:06:31 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:2:f21::2a1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe512d29sm70039485ad.140.2025.07.29.00.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 00:06:31 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ryan Chung <seokwoo.chung130@gmail.com>
Subject: [PATCH] event/core.c: fix warning format specifier to use %llu instead of %lld for u64 values.
Date: Tue, 29 Jul 2025 16:06:03 +0900
Message-ID: <20250729070620.527482-1-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Updates the perf duration warning to use the unsigned 64‑bit format specifier `%llu` instead of `%lld`, ensuring the format matches the `u64` types.

No functional change intended.

Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 22fdf0c187cd..b8d7c4a64c44 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -602,7 +602,7 @@ static u64 __report_allowed;
 static void perf_duration_warn(struct irq_work *w)
 {
 	printk_ratelimited(KERN_INFO
-		"perf: interrupt took too long (%lld > %lld), lowering "
+		"perf: interrupt took too long (%llu > %llu), lowering "
 		"kernel.perf_event_max_sample_rate to %d\n",
 		__report_avg, __report_allowed,
 		sysctl_perf_event_sample_rate);
@@ -655,7 +655,7 @@ void perf_sample_event_took(u64 sample_len_ns)
 	perf_sample_period_ns = NSEC_PER_SEC / sysctl_perf_event_sample_rate;
 
 	if (!irq_work_queue(&perf_duration_work)) {
-		early_printk("perf: interrupt took too long (%lld > %lld), lowering "
+		early_printk("perf: interrupt took too long (%llu > %llu), lowering "
 			     "kernel.perf_event_max_sample_rate to %d\n",
 			     __report_avg, __report_allowed,
 			     sysctl_perf_event_sample_rate);
-- 
2.43.0

