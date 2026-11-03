Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793700891;
	b=mpXTzDFfgWZfjJfT8NsZm7N3pU+5s+YiBiihHGYSsX7yBKVzSu11F2ahGH7DbxpqTMQU
	 14u+B9nZ9ef1A1ctUrxhCqLwgEwrRNSQhvmNFXhuf+e3iYBMNg/CKFUsAN3bTAFGNTyhH
	 u1ACJU/TH4McpycSPqZKB7Cw8yFNs6CLWRGuYq3SyiTVd4UakzZn4Tr8PxKV72CxSoJUb
	 YPO0htDtT5ec8lIAbZDkynp26HiJRMKRcoIN88mon1WIbIvNHgdRsOJuf/dn0Ckx74qpF
	 o6qtYndVuF875+PToNYfjnGYdXOR3aE8Q3tG10qpwQq/AV/2ENHuQz2S4MT5hWwbb/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700891;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=keMyQ7ytAKy7+1sHii2UPtmhNcMfsXpes56UIgnBLdk=;
	b=1vt92ZZShpwisjclm2eSOUrxOrDe1JplWmPxzW5mX8IoQu3SHnWZCW6q1hJgDCYdFHUV
	 EvYoaRd2i8HsxjpMdZbdEWVybqMPUMrVRL1itJo9RxKuW1Wy2avuirRe5npSlt2LpwspC
	 2QN4mcxNWAtfZcIc+/YHotCS2a/aegv6y34Ia3+2aC64bfylhUJVZ/h5kd/fzUNqpNEqT
	 GqObSWoXLpw9JYLiULVsNuiQpPP+/Rll9Mr1p3r/zjoWQfKXVARtQ4PirUfwevjTm7dIl
	 nsAk8ERmlcXpQfRvk0asGnwo7/spGtlUKL0ZtiPTaHVAJX5R9xIjRF6OBBjO8jHzU1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EsMjZSPB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD96606BF85;
	Tue,  3 Nov 2026 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EsMjZSPB
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793700890;
	b=sw8FtTAZha4Nl7GA0Cilkvz40m0MX7QBbEbme4zyqKSsb12b6QauPs89K2isoYTHPGi3
	 F8eUCikvFzxM16BbukVfy2NAat9/tIlyvB2GrT9PSkoMrp0nF+cscA5SMykcrvc4+2Zu6
	 CSqQuyvOT5/QaJWHSO4UTOog2M94lt6J5g+IoL4QeatGC+KCUO3Plj+SWIfntAccKVDtW
	 AfKdsMiBmvqjeUnvXysTsvuSmMyVhQ5g014ExVUTqG6l30X3r0yJ5NWWevJcZadz9m8TO
	 NbioEIEGLwX+Ky/wEwIs/9ZAvCsa6sVyoDSP9THuUIo1BTsYCoQRIi0AIXJMxa4y9+Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700890;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=keMyQ7ytAKy7+1sHii2UPtmhNcMfsXpes56UIgnBLdk=;
	b=KiN+1wcuz/B5z+UckNYKNibWJ5E+TxmH1SnxssEyBCjv589QocmVG4lpjj9dBSuaKsKG
	 iwUdNx47PSnMP6rLafIQ3+LYnRZlZ9VFaLhJ0kWG5MGHora8coxKMh2J7dGpVmcshT+Tc
	 MCwStD9rOlEIO2oRdvHYhk5bBEh6MOC+Ycl22emVISeNK9fei/96MLBAf4QsWDE8JO5yk
	 j1y96jrm7G7dFbCju+hKQ4WICnO2U+uDVNcVZGPp1j6N3hNw9DXPBcA5+4EW8N+DkI92F
	 54qUZiBCiTqGABOfrkEv7/3UoJkjDgNWF2yZzTaSK9jdUfp5EfwwHWKuWQYUGU/W3Iw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A9D291F00919;
	Tue,  3 Nov 2026 10:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700890;
	bh=keMyQ7ytAKy7+1sHii2UPtmhNcMfsXpes56UIgnBLdk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EsMjZSPBcFaXI7Wcq66wheN7KbC0stGjXtMB7tz3VosBsQ7oR3dWrpzqfW381RaJp
	 K9s6BP7cLELd+nv3SEewVqyxaJQmWH4mdGsvKMTc4whuD+sR4HFGGRnhezTFNNZmtL
	 yn5fSAuzX+31XRgsYMUXuYZ6aVwHRmQ6BHrQQrVFSsyZtXF5Ou/g3RLJUM2fGhOJau
	 lPiQq9kwE1ZEHFrrOhlpzDD2hlVHYA7oGABQrIPcdMor0GeWjDOsJ4+7sBqiILkMun
	 0ncbrbv9kF9QyKCL3SK3CKWpF/2BvrRHvw+qT09COwzI4WRTgl1jS21hwQ4UyAWIHA
	 J51tkuP13sQ2A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E6194468B1;
	Tue,  3 Nov 2026 10:14:47 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Date: Tue, 03 Nov 2026 21:14:43 +1100
Subject: [PATCH 08/13] drivers/perf: apple_m1: Add Apple A18 Support
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
Message-Id: <20261103-m3-plus-pmu-events-v1-8-a8eb6c1139fe@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2108;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=UCf5Ut3/9kqWE1oyxM0BkEKM/qq87rW8s0tj0xwB5ms=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYsl5uEdXzn3Ez62zT8rshMy99n2rktfbv5WYD+R+fg
 g9+4ymV+mvaUcrCIMbFICumyKJvmqY9ma3hUuky1y0wc1iZQIYwcHEKwESC6xkZFrtqv5zdO1vm
 nrn/+98LQwTfO/l8M97yQ3K7zZHNOblPdBn+mZZm2xz23P4tvnj156jbUQXJ2fVhk9yX/uKROiq
 p7ZHOAwCT20yk
X-Developer-Key: i=myrialsarvay@gmail.com; a=openpgp;
 fpr=2F35662B930680D275A645B452444118A8ADFEE9
X-Endpoint-Received: by B4 Relay for myrialsarvay@gmail.com/default with
 auth_id=1027
X-Original-From: Myria Sarvay <myrialsarvay@gmail.com>
Reply-To: myrialsarvay@gmail.com
Content-Transfer-Encoding: 7bit

From: Myria Sarvay <myrialsarvay@gmail.com>

The A18 has events and affinities identical to the M4, so use it.

Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index bdbd138cf1db..775f3d5aba7e 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -1149,12 +1149,23 @@ static int gen ## _pmu_ ## family ## _init(struct arm_pmu *cpu_pmu)				\
 #define m4_pmu_set_event_filter		m3_pmu_set_event_filter
 #define m4_pmu_format_attr_group	m3_pmu_format_attr_group
 
+#define a18_pmu_enable_event		m4_pmu_enable_event
+#define a18_pmu_map_event		m4_pmu_map_event
+#define a18_pmu_get_event_idx		m4_pmu_get_event_idx
+#define a18_pmu_set_event_filter	m4_pmu_set_event_filter
+#define a18_pmu_map_pmuv3_event		m4_pmu_map_pmuv3_event
+#define a18_pmu_init_pmceid		m4_pmu_init_pmceid
+#define a18_pmu_events_attr_group	m4_pmu_events_attr_group
+#define a18_pmu_format_attr_group	m4_pmu_format_attr_group
+
 APPLE_PMU_INIT(m1, icestorm)
 APPLE_PMU_INIT(m1, firestorm)
 APPLE_PMU_INIT(m2, avalanche)
 APPLE_PMU_INIT(m2, blizzard)
 APPLE_PMU_INIT(m3, sawtooth)
 APPLE_PMU_INIT(m3, everest)
+APPLE_PMU_INIT(a18, tahiti_e)
+APPLE_PMU_INIT(a18, tahiti_p)
 APPLE_PMU_INIT(m4, donan_e)
 APPLE_PMU_INIT(m4, donan_p)
 APPLE_PMU_INIT(m4, brava_e)
@@ -1165,6 +1176,8 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
 	{ .compatible = "apple,brava-p-pmu",	.data = m4_pmu_brava_p_init, },
 	{ .compatible = "apple,donan-e-pmu",	.data = m4_pmu_donan_e_init, },
 	{ .compatible = "apple,donan-p-pmu",	.data = m4_pmu_donan_p_init, },
+	{ .compatible = "apple,tahiti-e-pmu",	.data = a18_pmu_tahiti_e_init, },
+	{ .compatible = "apple,tahiti-p-pmu",	.data = a18_pmu_tahiti_p_init, },
 	{ .compatible = "apple,sawtooth-pmu",	.data = m3_pmu_sawtooth_init, },
 	{ .compatible = "apple,everest-pmu",	.data = m3_pmu_everest_init, },
 	{ .compatible = "apple,avalanche-pmu",	.data = m2_pmu_avalanche_init, },

-- 
2.56.0


