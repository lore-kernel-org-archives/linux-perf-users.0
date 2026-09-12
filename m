Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C522931FB;
	Sat, 12 Sep 2026 08:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789200223; cv=none; b=R33TCw95PbQM2EBeJOLm0XaGEbvf3bfI2PqW4rimvJFDllLkUlfNcFxL03zISFPQqlUWAvbZ5UqLwiKfBTf+YdU4bCRGmBh7mFy+eQRsj4OjUbqHvmNBKjLpVu5d495wIzTEBd1JI2L8x0aRY3RN6SV9LounxK7CWmira/7CsPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789200223; c=relaxed/simple;
	bh=ILKNp+WUMz7m60Cj2U3b3QKfAIuTdzWdXrka2tpZqXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BCOtiIlVRoywWSkShR7kfnGl3Eo20ACu0HTaIEViNanOU6ZWZmKIQynkCBXNQ5YiEOA2x+SViEsywqbAoOfVL0nKdPFczXuNRtiy0suAoISGI21B+s5iMaIc6TkAM8826Im5xiVdh14J6ttmCSwor8RV+uIM+QcG+Jn034TRFGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkZiD4uF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkZiD4uF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0EC2C2BCF4;
	Sat, 12 Sep 2026 08:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789200222;
	bh=ILKNp+WUMz7m60Cj2U3b3QKfAIuTdzWdXrka2tpZqXw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=bkZiD4uF5TCVrUKm68zSiu3UsGrSnIROJB8jRqeUX0SgnekRupH45MgAKqAVHFzhn
	 uVOVmxgy4NCSHafnrSf+sICm8tSeYW6jG1ziihWox+nY96AmlBZ+KoA3qf8mjbVBjv
	 o9QcxiNQnyKwSXX9mk6879UnB9WzT8bk658znHSEuh+GX/Rlq5CrUylHVvhYbcKflu
	 +B7KKIAJ3i6EvnaAPvVhmsU+fEiUlAPmfmK2+LIS/3XLuFk+oh9Ah4IiDK/A66yxW5
	 rXGP5taFECRp98rp2yAX8taCg+51fiipg1DhzM03AZTQ2XNlqzV0EW2C//7B6+acKf
	 9YKlDMmbU/0Pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2F1C88E4D;
	Sat, 12 Sep 2026 08:03:42 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Date: Sat, 12 Sep 2026 18:03:35 +1000
Subject: [PATCH] drivers/perf: apple_m1: Add macOS 27 M2 Event
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-m2-9f-pmu-name-v1-1-da682557453c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB3QKajjVYoLm07aEZJKYkQQ7
 96oy7f4f4coQSVCX+wQZNWoP59RlwWY7+g/gvrOBqqoqbgmdIRscXYJ/egE246NbejBtmXI0Rz
 E6nYNn8PtmF6TmOW8wHH8AWdXnI5yAAAA
X-Change-ID: 20260912-m2-9f-pmu-name-789cf6239f79
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 Myria Sarvay <myrialsarvay@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1883;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=WE/9S0PEWj724ZfvllqIPRhYse7Qz5ha7AiDrC/FTsg=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYspayxz65P616LZ9MUu9hz417PhrzyN/98Wr2pZPXq
 g4Kqv4IMn/eUcrCIMbFICumyKJvmqY9ma3hUuky1y0wc1iZQIYwcHEKwET0rRgZlv4v+ytisH/V
 bqWbC7UP50ttuHTvbs7Vdjcvb+b+oMU3lBgZdvy9F5kzfcrGTY6/DLfXWXYdFnbz/DBZV4Jt0QP
 NvyEKzADqTksT
X-Developer-Key: i=myrialsarvay@gmail.com; a=openpgp;
 fpr=2F35662B930680D275A645B452444118A8ADFEE9
X-Endpoint-Received: by B4 Relay for myrialsarvay@gmail.com/default with
 auth_id=1027
X-Original-From: Myria Sarvay <myrialsarvay@gmail.com>
Reply-To: myrialsarvay@gmail.com

From: Myria Sarvay <myrialsarvay@gmail.com>

This patch adds another known PMU event that can be found under
/usr/share/kpep on macOS 27 for M2 macs. INST_SIMD_ALU_VEC purports to
count "Retired non-load/store vector Advanced SIMD instructions", and as
we already noted, can only be registered on counter 7. Though this event
only shows up on the M2 kpep records, it can be set on M1 CPUs, and
records something.

Link: https://github.com/0ax1/apmc/blob/9cff99a9df2ae055f1e3065c64f633e38bb6beec/counters/m2.md
Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 81b6f1a62349..1f73c8a77462 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -81,7 +81,7 @@ enum m1_pmu_events {
 	M1_PMU_PERFCTR_INST_SIMD_ALU				= 0x9a,
 	M1_PMU_PERFCTR_INST_LDST				= 0x9b,
 	M1_PMU_PERFCTR_INST_BARRIER				= 0x9c,
-	M1_PMU_PERFCTR_UNKNOWN_9f				= 0x9f,
+	M1_PMU_PERFCTR_INST_SIMD_ALU_VEC			= 0x9f,
 	M1_PMU_PERFCTR_L1D_TLB_ACCESS				= 0xa0,
 	M1_PMU_PERFCTR_L1D_TLB_MISS				= 0xa1,
 	M1_PMU_PERFCTR_L1D_CACHE_MISS_ST			= 0xa2,
@@ -150,7 +150,7 @@ static const u16 m1_pmu_event_affinity[M1_PMU_PERFCTR_LAST + 1] = {
 	[M1_PMU_PERFCTR_INST_SIMD_ALU]				= BIT(7),
 	[M1_PMU_PERFCTR_INST_LDST]				= BIT(7),
 	[M1_PMU_PERFCTR_INST_BARRIER]				= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_9f]				= BIT(7),
+	[M1_PMU_PERFCTR_INST_SIMD_ALU_VEC]			= BIT(7),
 	[M1_PMU_PERFCTR_L1D_CACHE_MISS_LD_NONSPEC]		= ONLY_5_6_7,
 	[M1_PMU_PERFCTR_L1D_CACHE_MISS_ST_NONSPEC]		= ONLY_5_6_7,
 	[M1_PMU_PERFCTR_L1D_TLB_MISS_NONSPEC]			= ONLY_5_6_7,

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260912-m2-9f-pmu-name-789cf6239f79

Best regards,
--  
Myria Sarvay <myrialsarvay@gmail.com>


