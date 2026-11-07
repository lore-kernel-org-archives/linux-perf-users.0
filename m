Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794048549;
	b=iws9Ks2cO1X2rO9I7ut5zstVlro/dRairTcnn7tRuAqBG0Y82AeAVNJtvE3i46qoLbva
	 rPSS0EQuYxll40BGPuS6Mq1wKyhYSXz1f5cLagmDpcqSdvaPm1B8gY7NEyUlkYLS2Q5sU
	 fcZ/AtJW7QhS3J97sTTIXMu/99EVoJqZKcFmDSQlC98aS9oO5ylMHC72Smc5KBoA/sQKx
	 znpYu5pOyOCLWdXYljp3YAqHmvJ53yeF7a3n6DnAkSHwC3kaFoKuQd06vKHH59nguXgQd
	 fuvmn7I0t87pK4hjrhjeAUVZM9e7gd+zwAhA5ClzQC7EAI+Gp7i4pAGwmEoYhpO3VYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048549;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=F6jX/+Nqs2fcYN6TvsVCxH9Qlb1iwQl+YtobY55zdXo=;
	b=mQGImswV3ayzM7XlVH/LUNnDRG1IoGTzLS9xs8JYz4YrwbwL9po2DoGsorsMkN43xFNK
	 swvyv0rdVURyTkD0yNBKZzURKJQxkSo+KGzrwQ6n8y4ZqFOtyr1tybbDEbYZjSRpgFFeH
	 OqAUuDGDSDKk2CIk047K1aFxpuX3SJIpQg6YVlRkgcCEHLw3/LCS09P+/HURK40ZNHRZh
	 s13K7svUoU2VwGDAhKeMOS3wC9tMRTk/5UCWXUW2Q9nRtrqoSX/edwvpPiKsnc4WYAYUY
	 jRboaYk1vOx4AVCIH68CXdJWjiLrfThdDNdB2eEwT3ncOEhrOTpqyzZFAQHJ3oqsvfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bAHsVhJX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62664606EE83;
	Sat,  7 Nov 2026 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bAHsVhJX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794048549;
	b=LLL8Kx5NMHYg/xqYcEEJFq90VNrzWtLH3XAie0DwG6tnRuS0tAnEpnfGjzTUZl7O8iMq
	 Pyt2mHTqlQG6RrQGH9+ZQZwmEitAq7JBgdLikY/FHqW3XuRjyDh2MS+ID7Nr/Slo4eN6H
	 rIej/HD7BiCCixMf7RfxNiIecB1/0BdV9VDq0D1oVkLlGiEJhQI7NSMCAjHcS2tjmO0EA
	 VbSlb28KPny/TMYUSpQ7esilj0+yYz2kU5TiF+fKN7z5vg1kBHT47ocmYcsYUNMVbmKTM
	 wUVMK/4iI3J8Xg8Y3hDarARgnoaF728QeW6XrJ6A0brxLyzLiHvG7XKw88ubCPyMfNQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794048549;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=F6jX/+Nqs2fcYN6TvsVCxH9Qlb1iwQl+YtobY55zdXo=;
	b=RGuvcc44dWkatSHh8ZyMjiuq4m/lU9DqpLCnn5fsfcparQX4ckjPp4u3lb9EOAVafk4Q
	 LtSBhbIYdBB6Y6VGVmg+bQmtNwYAFVImfKKOsKbvH2ynbAH6yXAeK6nX5uEETcmFo84DL
	 iKtelE6Rb608n2wcbSKhKNZfhcSQiATxmuJ3iIpblbu+MiEcas9RSzF7vjztU3XgEwui/
	 vKWP4DSXFgT5k16FWecL/oHRLLbRw+vYCqqtz61nB3Bg3re/jpwFVqYszJGVMcv5zWfUX
	 t0p8oTEs0jfNPan9rl6vYhzn1f8+BC9MQ2O4WBb8SWiIPhkQFK+AURrGshoqVdYDg1w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 93FDB1F008A6;
	Sat,  7 Nov 2026 10:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048549;
	bh=F6jX/+Nqs2fcYN6TvsVCxH9Qlb1iwQl+YtobY55zdXo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bAHsVhJXVqRRyDXnhqz/CXoQYhokavqGoRqGv0G9bUsgcdrw+DSGinmJ2niDhESoL
	 oCevq1WnjTw9xGo3GHCXaWMB3gvKHZcSHfnYfbI/C19X54Ca8dlwfdDYkjmIXaA5r3
	 1quYdGH9zHdurGS4Qt4A6kUj1B70/bxtUPLiMOipJN5nxgJ5WsXei3JcZSfHUUUEoL
	 ClFKU3FbFHrvTz/p7lzXkNLhrZs3tnDt7lrV6K1iCt56mGiwTZcijMy5dzsE4h3aA0
	 Ohx96eVKQnqAFTydfCjeI0FsgFoI23p5Rew8HoWsAdXk2uUuUpt3n0wXbhyalfDmEI
	 TdpKNUVPXkbaA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E5A1B47B8E;
	Sat,  7 Nov 2026 10:49:04 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Date: Sat, 07 Nov 2026 21:48:55 +1100
Subject: [PATCH v2 08/15] drivers/perf: apple_m1: Add Apple A18 Support
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
Message-Id: <20261107-m3-plus-pmu-events-v2-8-acf1e78da039@gmail.com>
References: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
In-Reply-To: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1387;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=s/45yDdB8ys2vFBvaE4TXv63SSRkLqDeAYlpyd8V2AY=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYst4zyUyM93DXiI9rWnfb4LvHynVG57bEuTsyN5SkL
 Sr2+3D4g39HKQuDGBeDrJgii75pmvZktoZLpctct8DMYWUCGcLAxSkAE5H2Zvgr5714Rpeyioqf
 w7GnS1Sb25oNN0358UDwwo1TJz7MMno7k5Fhtq/Vx5YCt4c6mzxDbBYlWJloHOFy0TbrZNtpvGD
 fkUBmAFLcRuQ=
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
 drivers/perf/apple_m1_cpu_pmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index d6fa58aee886..318baf1a75c4 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -1154,6 +1154,8 @@ APPLE_PMU_INIT(m2, avalanche)
 APPLE_PMU_INIT(m2, blizzard)
 APPLE_PMU_INIT(m3, sawtooth)
 APPLE_PMU_INIT(m3, everest)
+APPLE_PMU_INIT(m4, tahiti_e)
+APPLE_PMU_INIT(m4, tahiti_p)
 APPLE_PMU_INIT(m4, donan_e)
 APPLE_PMU_INIT(m4, donan_p)
 APPLE_PMU_INIT(m4, brava_e)
@@ -1164,6 +1166,8 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
 	{ .compatible = "apple,brava-p-pmu",	.data = m4_pmu_brava_p_init, },
 	{ .compatible = "apple,donan-e-pmu",	.data = m4_pmu_donan_e_init, },
 	{ .compatible = "apple,donan-p-pmu",	.data = m4_pmu_donan_p_init, },
+	{ .compatible = "apple,tahiti-e-pmu",	.data = m4_pmu_tahiti_e_init, },
+	{ .compatible = "apple,tahiti-p-pmu",	.data = m4_pmu_tahiti_p_init, },
 	{ .compatible = "apple,sawtooth-pmu",	.data = m3_pmu_sawtooth_init, },
 	{ .compatible = "apple,everest-pmu",	.data = m3_pmu_everest_init, },
 	{ .compatible = "apple,avalanche-pmu",	.data = m2_pmu_avalanche_init, },

-- 
2.55.0


