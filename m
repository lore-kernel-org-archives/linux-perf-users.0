Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793700889;
	b=Xyg2BI1Z4TCBifeV5BXqaD5jgcOXFPw2TEzDCNcB8vckuIxSgHcOGyKtXi247H98v5m/
	 Q4WPo9nvYtDROtgTwlxRl50Tf/shSMwfkJdys/I7rPvttdHs2bYCaJadbIpOKEIPpOQzx
	 jTQ4rYf1Zd3HaHXN7lUy43bo+nGwl5A8sEmCVjujvVtLUjMW5cl8hwR9BOx2TEErOzHoU
	 5mBBdsT8C9uSknoyWLWMvW4THTipcHKarHYh1KplWkeSS41yBJgh4mfNT610KZtGJNLeG
	 LeEIqWOLZn7BryhjlXgBdV1cUaubk6ayqJLEA/iVkbjiNkPTln2IYlWDo3NHnIVMB1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700889;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BJNyGdSOOirOq9LaEv4gLULV3sAodWivkwhlHUUZpk0=;
	b=QnweEqjv9sAHcaMSQeWSqqVaymlMefyREHFcteVQaoeaimx9UQT9ueT5h3nPAwH5JZ4n
	 W5J0xDLcWyCWEWwwHW+rYy/HRiajvohhFJZD66quhUo1aWjmnEE7WgeZoI67YVRm6ZuNr
	 teyOc7mzekPyOlPG63i1ylgMrDbpYwGWcjTJk9kfOjEExkPUev4fT6yif6M2sA3/1r5gF
	 KZ+Qf0u26dYG5FydlKMDWLGnIR/qHVOm2zgkK2gOa56lrOViEuT3zvUqjqGZcyp5FKKhj
	 +nJ06joQzoWvHvsFKPT88lgRUl2k/sxrUWSQHSPAcqBgPopa+E2c4Crv57742dMOz3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HW48AcTm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D5B606A336;
	Tue,  3 Nov 2026 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HW48AcTm
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793700889;
	b=Bez9/PTgtvxt2BOggGHD00KW4Dv7YI/saRq/4O73rvbLviRxuTzkKzjVvdivtjK9RvMh
	 6ZULhl8tFvxBQe9xm5jNCX1J0syl0SnWmQ97ESPaNNnaldhHPtu98/5TaXQBQjy8e5IDr
	 lSBUGiX6W4c9Aigl/ygEkL/TuOKGN6NQx5lOaG8Y2AJ1WgVjB3xCzuhAGpJGV8dTSJhmN
	 QEbualFEG+8c5db+tcN4/7gpP+8ndc4IQGmW8YhiPHy5tGqQfMqdCo94ubNup8fBbNvHx
	 SLrONoWQrM7UtbEk5PeKipwzCdgVZ9nyRQHJ+TIIoSFV0DF+PwX9D5N4zHZZk3eeMOw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700889;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BJNyGdSOOirOq9LaEv4gLULV3sAodWivkwhlHUUZpk0=;
	b=vOkPIntng+PClrKuSeE3wbMgoRJcHduSaGlSNWFHv0n/cBvSIdL6RdmvDkPIGh6UYywB
	 sD9D9ffP8CNkiir6syqkKa0c2kh89+ZC+5HGqBKybc4LvkWO3zZfBxaqwecLXMgQeXONx
	 lwFdt0xFdt9fedqlybcT0gv8XY0xMcvCFW2k8tLQiTgAJeJEVQT7YSR9yRbWCv39IEdoD
	 jt25cs+5IzZKDI/l5kAp29CQsrV1YSLS1/QtrZDaeuAvBT0MEGgMYmjeQqJwvuV8oxnfZ
	 ZnPi0/gaQjEKW5UyxZp5z3EUyQ594YwV1RKbRmN8PFD7Q+L9iQctR3fks2ADeY6rMtw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2A8AE1F00A29;
	Tue,  3 Nov 2026 10:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700889;
	bh=BJNyGdSOOirOq9LaEv4gLULV3sAodWivkwhlHUUZpk0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HW48AcTm/KWAEvYZIyTKDYqblUBcr+ZhKRiH9oRKmSAgretFVnSAWR73YdZlPyC+l
	 HXngzouVQ30m/xhlYJ/r7RKaXbnS+gMcv5zMd7MjZrgmhsRaeOoAmNu71UqQ1pxFWO
	 dSEnyW5wASeg6Q5obivmlBWw3oEZrGWvqtGi0bAawBt4nNC8K6sk2NBLKhPeu146hl
	 179UKkZ3xEfez0uRuz0ZshPGDfiZ3hW5h5sSA9BpsiivnQDlqJg4QPx6iJ7ZF6Wun9
	 EJW5+qHUBC3KfKEbmYUDd2Lkik3fYopItmciG1P1mkhu3f0bktjueMJgwvajbXu8J6
	 Iox+TB5Vb6Avw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9190746899;
	Tue,  3 Nov 2026 10:14:47 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Date: Tue, 03 Nov 2026 21:14:37 +1100
Subject: [PATCH 02/13] drivers/perf: apple_m1: Remove unused variables
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-m3-plus-pmu-events-v1-2-a8eb6c1139fe@gmail.com>
References: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
In-Reply-To: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Yuvan Shen <yuvanshen09@gmail.com>, 
 Myria Sarvay <myrialsarvay@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=tqfKByDug9XSrpXX1trL6e24TzZYUYwCyC7bLswrs2o=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYsl5uEcl+dSZ+X5hXZ335TA//YpED/579NTH5antr/
 o4e26K2K9IdpSwMYlwMsmKKLPqmadqT2RoulS5z3QIzh5UJZAgDF6cATGRVIiPD9t28Vy6kuPtK
 avEa9SjJuCe3Xpnr5Jm+7Isq375eX7e3jAzt/CZvnz5dJTy1LLDc9curdb4fvlUfL+sXtP3u/sP
 zcBkPAIF7Sp8=
X-Developer-Key: i=myrialsarvay@gmail.com; a=openpgp;
 fpr=2F35662B930680D275A645B452444118A8ADFEE9
X-Endpoint-Received: by B4 Relay for myrialsarvay@gmail.com/default with
 auth_id=1027
X-Original-From: Myria Sarvay <myrialsarvay@gmail.com>
Reply-To: myrialsarvay@gmail.com
Content-Transfer-Encoding: 7bit

From: Myria Sarvay <myrialsarvay@gmail.com>

These variables are calculated elsewhere as well, remove the extra dead
code.

Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
Fixes: a639027a1be1 ("drivers/perf: Add Apple icestorm/firestorm CPU PMU driver")
---
 drivers/perf/apple_m1_cpu_pmu.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 1f73c8a77462..de4026c63afd 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -421,13 +421,6 @@ static void m1_pmu_configure_counter(unsigned int index, unsigned long config_ba
 /* arm_pmu backend */
 static void m1_pmu_enable_event(struct perf_event *event)
 {
-	bool user, kernel;
-	u8 evt;
-
-	evt = event->hw.config_base & M1_PMU_CFG_EVENT;
-	user = event->hw.config_base & M1_PMU_CFG_COUNT_USER;
-	kernel = event->hw.config_base & M1_PMU_CFG_COUNT_KERNEL;
-
 	m1_pmu_configure_counter(event->hw.idx, event->hw.config_base);
 	m1_pmu_enable_counter(event->hw.idx);
 	m1_pmu_enable_counter_interrupt(event->hw.idx);

-- 
2.56.0


