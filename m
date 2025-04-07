Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD98219E0;
	Mon,  7 Apr 2025 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744007556; cv=none; b=oZ/EfX4z1tSfJQu3JdmYmoZPH9NbvnxmyTCLM2P5ZNIxPWbnPsjUv+s4VQpP108kJCh4kWJczYpKpG/5tKjvYrRfxn6Z+2gpJpbsk1h6eJvNeImOg+ewQssSllYUKFLQ3c3j+wvWe0/9DSXjQKE0ZuaFzTEiYBt5uAuC3GuWbZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744007556; c=relaxed/simple;
	bh=rgWmwjZniGKCkXyoowbdyQSPJAgjIxa6HwiniR6YaQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hHPrNsuUcpguiLF7hXbYklbQH0iYxCaOp9vIVi756nkzMTt82EniPRuEw28Fuva8AQQcyfNk5eUxcKKthbneamazEPuoDUPKPu/3U8fEsF7bVEtLbwmdY6J1oQP39cwLKMcjjCtv8YsAx9SdGr/OyX3t21Mp8R45xrOfBpaBMm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9VCdnuw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9VCdnuw"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2264aefc45dso49798295ad.0;
        Sun, 06 Apr 2025 23:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744007554; x=1744612354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+FgwxOm7aFKO8+Yjp585HwY/8KQoU+DtbqgD3z9mVQ=;
        b=A9VCdnuwZW4Q1NG49habGkgwf9CUuw2TiVd+pUvcSbyZ5cQ09Hp3czpHV1jZQJIDKI
         zrWW59vIvpLIq3hWHJUE8pce7EPPjQ24VzQg4Q863rgAvcbk/cwu3JfPCVp67kg6GV2G
         wEyqVxvUpdH5kEx9t95KHFm11D2hQQFaMzfSbGjrnLgA19ofq6XeTAGNxIJSnj+ykr26
         mpykPLJYSd8fydQbCFlugoFlmHt3/a3u5BfQrJHGt0tnU+EvTg7I2uVL37ZXk+Kuv/GY
         2hhRAL2nitnsVCMXekymusE0xn9s3S1zwMCjAyxkb2dM+yCx5f7lMd9ISx6QX2jFLi/c
         teWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744007554; x=1744612354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+FgwxOm7aFKO8+Yjp585HwY/8KQoU+DtbqgD3z9mVQ=;
        b=RGBKSwe+Q1Go5+3nw7li7Wbyet8F6k8HmvJ//A7N12V9b7LnL0ekgnh8Xo+EEmXhzE
         wU8xdtYBHBgIFTLsQGOR3Fyz9TrN/QZFbqmuNxWq6p/Qk1nwESn4U8XhydAU7yCFu/ap
         Q8QwezRxuJBwKR76IOcbMNy2/nj4lD1+OPALwwk/V5E0dkkt6q2alq7OvlSYRY9LW1IU
         2dg5N0gfyGSZGZWtrzPzCeKKOmDEciAH8A3FEQUIdpXkWuyPyjDiVYP8AWbb/Lruwg7i
         MGCeOTre+VoQ/aE0lKdqYO4OgGdSExi2XNqbq2X0dKk8v5GHWOb/UQ37DnSLDln2/msV
         Fscg==
X-Forwarded-Encrypted: i=1; AJvYcCVViiG+CzSj8IjIj32KewlkEc+zmMDDFIHPBocTFqVkUU5bjAvdKM0TL3gczjM3hnuAlmU530ZJcwYeKps=@vger.kernel.org, AJvYcCWobK6IRSql+6aWIv75uVyqVpMChUbGLQdFaoCYihM1HkeVbdVJ50tOtaOgK4H4jHdTsT9FKzN92qsP40KhT3Hhag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpUqZvVNo+tlkk9uKzPAgETJQvXQDwmLbcWdW0Q9W2Op7QcrEK
	+iX9QKv8J+YAp53H7Bp8NCGDAqu9kzpJb6WrzIrWpiYwW19Cdvu/
X-Gm-Gg: ASbGnctZOBKCrECLcFczCkcQ93S3/mInx8RpsuJjxgbel3frK/aWhgfteUnjWtx+ix2
	Cjl42vcUmm90NlEQm6uFD2Z+sJUFXo2VztqPhtNS1un/ER0ZWKmW3M4pokSLGKnAhZ1Vtp8JgTv
	SuBcjNw1w1BmxJCAyZ32N/kXu3zvpba1LHQQUfHT+AqwPrIF8CLKglO7htksMqzVLMpMbBy/Yc7
	Lme77kar/ok2SqcnXDLXHpi+Ly33pBnvXE/Yvp2c+DQI1ucrbbjRszFc26K7B9vodM5dKO2h8EQ
	np1gTLKoX/xznBYj824KKsuVQ1gjxHNwi/GFq+PtkA0BBsFLV8ax8lyTXkw=
X-Google-Smtp-Source: AGHT+IHqfdC2hAwF+iHvluludcTR0crAZTyeQqY1dFdw+RUMqBj5erLa4Mr2mQeYTN3YlEylkAXOrA==
X-Received: by 2002:a17:902:cec2:b0:223:2aab:4626 with SMTP id d9443c01a7336-22a8a84ea52mr138936315ad.11.1744007554389;
        Sun, 06 Apr 2025 23:32:34 -0700 (PDT)
Received: from localhost.localdomain ([103.221.69.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d980598csm7694095b3a.77.2025.04.06.23.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 23:32:33 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org (open list:AMLOGIC DDR PMU DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM PMU PROFILING AND DEBUGGING),
	linux-perf-users@vger.kernel.org (open list:ARM PMU PROFILING AND DEBUGGING),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1] perf/amlogic: Replace smp_processor_id() with raw_smp_processor_id() in meson_ddr_pmu_create()
Date: Mon,  7 Apr 2025 12:02:03 +0530
Message-ID: <20250407063206.5211-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Amlogic DDR PMU driver meson_ddr_pmu_create() function incorrectly uses
smp_processor_id(), which assumes disabled preemption. This leads to kernel
warnings during module loading because meson_ddr_pmu_create() can be called
in a preemptible context.

Following kernel warning and stack trace:
[   31.745138] [   T2289] BUG: using smp_processor_id() in preemptible [00000000] code: (udev-worker)/2289
[   31.745154] [   T2289] caller is debug_smp_processor_id+0x28/0x38
[   31.745172] [   T2289] CPU: 4 UID: 0 PID: 2289 Comm: (udev-worker) Tainted: GW 6.14.0-0-MANJARO-ARM #1 59519addcbca6ba8de735e151fd7b9e97aac7ff0
[   31.745181] [   T2289] Tainted: [W]=WARN
[   31.745183] [   T2289] Hardware name: Hardkernel ODROID-N2Plus (DT)
[   31.745188] [   T2289] Call trace:
[   31.745191] [   T2289]  show_stack+0x28/0x40 (C)
[   31.745199] [   T2289]  dump_stack_lvl+0x4c/0x198
[   31.745205] [   T2289]  dump_stack+0x20/0x50
[   31.745209] [   T2289]  check_preemption_disabled+0xec/0xf0
[   31.745213] [   T2289]  debug_smp_processor_id+0x28/0x38
[   31.745216] [   T2289]  meson_ddr_pmu_create+0x200/0x560 [meson_ddr_pmu_g12 8095101c49676ad138d9961e3eddaee10acca7bd]
[   31.745237] [   T2289]  g12_ddr_pmu_probe+0x20/0x38 [meson_ddr_pmu_g12 8095101c49676ad138d9961e3eddaee10acca7bd]
[   31.745246] [   T2289]  platform_probe+0x98/0xe0
[   31.745254] [   T2289]  really_probe+0x144/0x3f8
[   31.745258] [   T2289]  __driver_probe_device+0xb8/0x180
[   31.745261] [   T2289]  driver_probe_device+0x54/0x268
[   31.745264] [   T2289]  __driver_attach+0x11c/0x288
[   31.745267] [   T2289]  bus_for_each_dev+0xfc/0x160
[   31.745274] [   T2289]  driver_attach+0x34/0x50
[   31.745277] [   T2289]  bus_add_driver+0x160/0x2b0
[   31.745281] [   T2289]  driver_register+0x78/0x120
[   31.745285] [   T2289]  __platform_driver_register+0x30/0x48
[   31.745288] [   T2289]  init_module+0x30/0xfe0 [meson_ddr_pmu_g12 8095101c49676ad138d9961e3eddaee10acca7bd]
[   31.745298] [   T2289]  do_one_initcall+0x11c/0x438
[   31.745303] [   T2289]  do_init_module+0x68/0x228
[   31.745311] [   T2289]  load_module+0x118c/0x13a8
[   31.745315] [   T2289]  __arm64_sys_finit_module+0x274/0x390
[   31.745320] [   T2289]  invoke_syscall+0x74/0x108
[   31.745326] [   T2289]  el0_svc_common+0x90/0xf8
[   31.745330] [   T2289]  do_el0_svc+0x2c/0x48
[   31.745333] [   T2289]  el0_svc+0x60/0x150
[   31.745337] [   T2289]  el0t_64_sync_handler+0x80/0x118
[   31.745341] [   T2289]  el0t_64_sync+0x1b8/0x1c0

Changes replaces smp_processor_id() with raw_smp_processor_id() to
ensure safe CPU ID retrieval in preemptible contexts.

Cc: Jiucheng Xu <jiucheng.xu@amlogic.com>
Fixes: 2016e2113d35 ("perf/amlogic: Add support for Amlogic meson G12 SoC DDR PMU driver")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/perf/amlogic/meson_ddr_pmu_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/amlogic/meson_ddr_pmu_core.c b/drivers/perf/amlogic/meson_ddr_pmu_core.c
index 07446d784a1a..c1e755c356a3 100644
--- a/drivers/perf/amlogic/meson_ddr_pmu_core.c
+++ b/drivers/perf/amlogic/meson_ddr_pmu_core.c
@@ -511,7 +511,7 @@ int meson_ddr_pmu_create(struct platform_device *pdev)
 
 	fmt_attr_fill(pmu->info.hw_info->fmt_attr);
 
-	pmu->cpu = smp_processor_id();
+	pmu->cpu = raw_smp_processor_id();
 
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, DDR_PERF_DEV_NAME);
 	if (!name)

base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.49.0

