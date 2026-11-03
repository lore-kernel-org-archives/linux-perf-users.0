Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793700889;
	b=SL1RBeVuai/1iZaVZq8GG2/PnYAumFMOE5tVwJXwPXjJYXG5cgeg4bgDCB+JDTJfrmz4
	 StyaE20iadbHonZHqQpo+RqewNTb/jcHEOY7k5W3XdqMhf3SyCByu3H6NMMucWCVq/Y+n
	 8dddaODPeZnbD2QeWETpkAbUhzj33hWKL30mbDw7dCCjqHaTrQ5eMqabuithskaRpBPsb
	 YArJy4aOutsRju2aRAEM3U4YI63Z/ew2ywHddRhk61kAUjvNuZScts69KgwA21NnVt0Yz
	 acsQZlysvAWBdaIYAGx2XVZOqY1DjVCNzi7965HpiDxBSUCZnCexmDdVm2YveouTn+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700889;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=M0JkceVfwO3LS/QIKaOJlicT3A1Tg45AAM0ivl3Rd0M=;
	b=oVUUvfsxPWT/kZRy+HldBlOhoFibV7rWdCsWzdJOKCuTtbLCgh61aZ0ku0jV98f4DNDn
	 d1EO8G2KHOfxJYWMRrino+Pq18nQ/+5hSizVmYRVptEFmoFS7mFJdvk00MGCn53smwip/
	 r1P505iEH3E4yI63nyEuaJ9VAtYzLyLcoxO/M/sREv6KrOHNm6VEPSgUJKQ9IAlUWxACl
	 8WrOWWSgq2GP22X+5kp1xQlIEacHVF1tMG1WbdW7+apyulRBhRoOkG+hBPyHRmDhOuF1z
	 dGsnoRjNGH7MPTilLeGiXAmFZKBXu70ZflQnJEdmPWIB0qQQ7wjRkb+hK1sM7ERiQnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P9lmu3hB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EF7606A329;
	Tue,  3 Nov 2026 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P9lmu3hB
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793700888;
	b=htRVTrAgXhOgEPjz/sK6Go/9NcotKpgkuda0aG2kugpkvq9mdXGinEwsNBSeu54HShgh
	 6t9tjWKeXJT6y7HRr+Y48MJcVKnHH8gzvUync2iqFYKX//rBifrN1gzbNnpK++BvVz7b1
	 qqMqKVj4RhotIV8aEK6eShTJybeRdBWhXbSOHNlZ9TP+ai40+QPp+T4Qyh2MP3i9ZYxMY
	 rrVRNJ61Emgpl+a1NpWY+xMIpXEuGfQnsLjpB8boJ199Tz2d37jiAX8WLFiLeRtTyjU2D
	 GTYe0D8mhS7rAucqcLU76fkYd7gQ01eMJFKFaaZa2LadMcos/BcDizlKo9QdV38KDAA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700888;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=M0JkceVfwO3LS/QIKaOJlicT3A1Tg45AAM0ivl3Rd0M=;
	b=SKGs8OEPQgsEvgeo9GYgoTm6XLPjVeZRD0hCWxjxOLT/QhRISbPb6rUB9gQS99n6L/hF
	 Bfpo9W03RQRd971Rze8zzd7EmOz5sl1/Vw9Ur8ugj8ywNLh3VWBEXMS58hpjopSHercRB
	 ymXDQUzGbk+2uv8jifR5LJiUpkR6m4zOfre3DY8FHak5u9OU7nPp2PHF+qjFd+a1bOV1M
	 w0wj02NxbwYuD/LAWBe3fYBMnwUtx7VOW/C6ggGcJzxaEyw7R9pVE8XBIvY7U7DXSapxA
	 igZa+nhXtcJWlmQlILkJSG/Dz4BcWfzoy7Mwfyqwq+zHftDaWi2zGtiz8C3PugsxSZA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 285B11F00A18;
	Tue,  3 Nov 2026 10:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700888;
	bh=M0JkceVfwO3LS/QIKaOJlicT3A1Tg45AAM0ivl3Rd0M=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=P9lmu3hBVo6DC7Nt7SXgOcfsn6vzsOnL0t+dkXpGupLM2K9PicmHzaVnIrGWcyobg
	 Zx32a62SNhvRjr6BMyJzH1DrnLT2oGKj3mZKBRYwcNmIvOjXroPq56123mwsX7KlFR
	 bSgYPfyjlnPsaj8V4JcVoYgm7wxhuI+vUI3ru/fTRf7H0q1tnI3IPXTOdSfBbpXXI6
	 uAh9f3ZHL3jZfUBY/SkpoO6hkCVGsF38VTdg1CvGwVs1Ij3pPL2XUEWbp9Ix5Bptuq
	 HKidtpdKw6rjNAF05FAqUPPzdTUnTQbWVCMkhWAZQQCT1n+fW904k/qjSWWYg6XRqD
	 sVM4EAEJHuwxw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 72A7546895;
	Tue,  3 Nov 2026 10:14:47 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Subject: [PATCH 00/13] drivers/perf: apple_m1: Add M3/M4/A18 Pro Support
Date: Tue, 03 Nov 2026 21:14:35 +1100
Message-Id: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NWw6CMBQFt0L6bZO+ad2K4aOPq9ZYwD6ICWHvo
 vg5yZw5KyqQIxR07laUYYklTuMO9NQhf7fjDXAMOyNGmCKGGZw4np+t4Dk1DAuMtWAQhBLrhKB
 con04Z7jG9y96GQ4uzT3A12/pb2R4tf2tHhpytgD2U0qxnjvrnWEyWGF0r6AXThPlfRDa9pLqw
 ALnSoMMaNi2DwaYU23CAAAA
X-Change-ID: 20260929-m3-plus-pmu-events-e4010ab44135
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Yuvan Shen <yuvanshen09@gmail.com>, 
 Myria Sarvay <myrialsarvay@gmail.com>, Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2375;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=sBJetOAUcs63xW7bNzY0oakU4G0NRaHuxPFAqWDArRM=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYsl5uET52a55/klOs9oXDF5qf2wV9WX5qpv+asleL3
 aZMZTloadPbUcrCIMbFICumyKJvmqY9ma3hUuky1y0wc1iZQIYwcHEKwEQCNzP8r670vBTLtyVN
 3XHPpJ9TxHakH68IW/2tvNnpsp9BnwjLRkaG873dGrdOWK1kO9A58Urb2f4Xn+5efD7/et1bjdQ
 DaRcWMgEAU69Pcw==
X-Developer-Key: i=myrialsarvay@gmail.com; a=openpgp;
 fpr=2F35662B930680D275A645B452444118A8ADFEE9
X-Endpoint-Received: by B4 Relay for myrialsarvay@gmail.com/default with
 auth_id=1027
X-Original-From: Myria Sarvay <myrialsarvay@gmail.com>
Reply-To: myrialsarvay@gmail.com

This series adds support for the CPU PMU in the new M3, M4 and A18 SoCs
presed in apple devices. These PMUs have new encodings for events, along
with larger codes for these events. All of these events are as Apple
describes them in the various kpep files found under /usr/share/kpep on
macOS 27. More events may exist, but we have no idea of their affinity,
or what they actually count, so we don't include them here.

These patches have been tested on my own M2 (t8133-j413) and M3
(t6031-j514c) devices, as well as by Yuvan on their M4 (t8132-j713)
device.

If possible, the device tree changes should probably go through
apple-soc, as this is where the recently picked up M4 Pro/Max dts are.

Tested-by: Yuvan Shen <yuvanshen09@gmail.com> # on t8132-j713
Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
---
Myria Sarvay (12):
      dt-bindings: arm: pmu: Add Apple M3/M4/A18 Pro SoC CPU PMU compatibles
      drivers/perf: apple_m1: Remove unused variables
      drivers/perf: apple_m1: Support per-implementation event size
      drivers/perf: apple_m1: Use macros for per-implementation init functions
      drivers/perf: apple_m1: Add Apple M3 Series Support
      drivers/perf: apple_m1: Add Apple M4 Series Support
      drivers/perf: apple_m1: Add Apple A18 Support
      arm64: dts: apple: t603x: Add PMU Device Nodes
      arm64: dts: apple: t8122: Add PMU Device Nodes
      arm64: dts: apple: t604x: Add PMU Device Nodes
      arm64: dts: apple: t8132: Add PMU Device Nodes
      arm64: dts: apple: t8140: Add PMU Device Nodes

Nick Chan (1):
      drivers/perf: apple_m1: Support per-implementation event tables

 Documentation/devicetree/bindings/arm/pmu.yaml |   8 +
 arch/arm64/boot/dts/apple/t6030.dtsi           |  12 +
 arch/arm64/boot/dts/apple/t6031-base.dtsi      |  12 +
 arch/arm64/boot/dts/apple/t6041.dtsi           |  12 +
 arch/arm64/boot/dts/apple/t8122.dtsi           |  12 +
 arch/arm64/boot/dts/apple/t8132.dtsi           |  12 +
 arch/arm64/boot/dts/apple/t8140.dtsi           |  12 +
 drivers/perf/apple_m1_cpu_pmu.c                | 664 ++++++++++++++++++++++---
 8 files changed, 662 insertions(+), 82 deletions(-)
---
base-commit: acb925da49876e74b806ccd48a7518d2d3368e5d
change-id: 20260929-m3-plus-pmu-events-e4010ab44135

Best regards,
--  
Myria Sarvay <myrialsarvay@gmail.com>


