Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794159185;
	b=zlX2kbzaD6Rf02sJyTqXJfx+IaHkrSlk6B/+uG0MiMTXHAkVjKXZ6mG3KWR0+y4cDwOY
	 Z16Fb0/9ffbmoc7CELMT/MxAhH8D1nryOa7tiKi+1uaVZn8vzB7m4HVMwjm4gZp1I7O9V
	 mysBZEzrWYI3wpLl0vT4G+k/YXvypmjXsJE01EVY4oZz36qGEhwybDoBEmA8GblDQUTHz
	 P/W83M173eqDqcdw+DgpwtOuLVxo4zrjBoPM/9uLiyXhw+fZSKfpl6MfcRpk4sPU//dE5
	 xATZiEaMRuH8SRPRHNqb1Cd20YE24AKRkVY3qECrGD6ngN5dmZqTftLRP6nTe11m4VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794159185;
	h=DMARC-Filter:DKIM-Signature:X-Forward-Email-ID:
	 X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:Mime-Version:Content-Transfer-Encoding:Content-Type:
	 Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=mmRDTsFTMdkB1knSlLyF6ragoIMpPyE7Nd3fqt3pBKI=;
	b=xWAx4WsamvEw5e+AfC2tTCirs7//lKweC5YUaO2qO51rI8BJs1x6bpZI9YoWk9n9Bpm3
	 lWPIsiRn7snI1+MZUvw9bZyX6/OJ5BuEE7BRJqPIUNbCXiCqIv86IIa0LvrFIjgkexSwU
	 oTL2GlVA1AhOQsxiT/Nl6lE3mMQM7fyLhCTrb5jiCmIqnkRb0UoavzWFypfP8tfudizci
	 dxQchvVXp6YQmiKltOdaBK3GJakezGcShZ4Mn9g77JqG/CyBOyYcUI/UIlQfiFk721l0Y
	 i+7WH9LMIuF4d8u8j268nFfVxk+0PRbk1AoIVRsVnnFc6om93hfPWpkca7liGssLOSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ubuntu.com;
	spf=pass smtp.mailfrom=fe-bounces.ubuntu.com;
	dkim=pass header.d=ubuntu.com header.i=@ubuntu.com header.a=rsa-sha256 header.s=fe-953a8a3ca9 header.b=slSmwU3H;
	arc=none smtp.remote-ip=149.28.215.223
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1585D606A31C
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Nov 2026 17:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1585D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.a=rsa-sha256 header.s=fe-953a8a3ca9 header.b=slSmwU3H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: To: From: Subject: Cc: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1794159177;
 bh=mmRDTsFTMdkB1knSlLyF6ragoIMpPyE7Nd3fqt3pBKI=;
 b=slSmwU3HRLRUzQNPP4oiH4+wP4RhHx0pOhQKAEdLjgL77ReW7807UIJqOdOfrcB0O2l5Uzt1B
 9hjB3VViHcxqwslBR1+uDQuH+SJapSMpwFfYAR9vuIq+xktLSvozOxhttStfzM7lf7R3Ieh0HF/
 XppHcwqGw+qaMcD4/6aDGFkfSQNRvRflgYl0u3jL2+o6giuTSn+NfFMDRHQMzFrAAlPA3migo3b
 maOH16KrDAG8OE8Yn2irBbKLf7a3tN2cZOJBc3ODwEfsUABfRfyBT9h+hHfs7Hao1DFLtvQ/jLS
 E3jrZne5Oeng3Nu77Dve71LK2DyuOyn00VQ9K7YbPHWw==
X-Forward-Email-ID: 6af0b240935e4de7801c9067
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.19.13
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Sun, 08 Nov 2026 12:32:46 -0500
Message-Id: <DMQ0CENBZQGW.L35BD1BXYE9Z@ubuntu.com>
Cc: <linux-arm-kernel@lists.infradead.org>,
 <linux-perf-users@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <asahi@lists.linux.dev>, "Yuvan Shen"
 <yuvanshen09@gmail.com>, "Nick Chan" <towinchenmi@gmail.com>
Subject: Re: [PATCH 00/13] drivers/perf: apple_m1: Add M3/M4/A18 Pro Support
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: <myrialsarvay@gmail.com>, "Will Deacon" <will@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Sven Peter" <sven@kernel.org>, "Janne Grunau"
 <j@jannau.net>, "Neal Gompa" <neal@gompa.dev>, "Marc Zyngier"
 <maz@kernel.org>
X-Mailer: aerc 0.21.0
References: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
In-Reply-To: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>

On Tue Nov 3, 2026 at 5:14 AM EST, Myria Sarvay via B4 Relay wrote:
> This series adds support for the CPU PMU in the new M3, M4 and A18 SoCs
> presed in apple devices. These PMUs have new encodings for events, along
> with larger codes for these events. All of these events are as Apple
> describes them in the various kpep files found under /usr/share/kpep on
> macOS 27. More events may exist, but we have no idea of their affinity,
> or what they actually count, so we don't include them here.
>
> These patches have been tested on my own M2 (t8133-j413) and M3
> (t6031-j514c) devices, as well as by Yuvan on their M4 (t8132-j713)
> device.
>
> If possible, the device tree changes should probably go through
> apple-soc, as this is where the recently picked up M4 Pro/Max dts are.
>
> Tested-by: Yuvan Shen <yuvanshen09@gmail.com> # on t8132-j713
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
> ---
> Myria Sarvay (12):
>       dt-bindings: arm: pmu: Add Apple M3/M4/A18 Pro SoC CPU PMU compatib=
les
>       drivers/perf: apple_m1: Remove unused variables
>       drivers/perf: apple_m1: Support per-implementation event size
>       drivers/perf: apple_m1: Use macros for per-implementation init func=
tions
>       drivers/perf: apple_m1: Add Apple M3 Series Support
>       drivers/perf: apple_m1: Add Apple M4 Series Support
>       drivers/perf: apple_m1: Add Apple A18 Support
>       arm64: dts: apple: t603x: Add PMU Device Nodes
>       arm64: dts: apple: t8122: Add PMU Device Nodes
>       arm64: dts: apple: t604x: Add PMU Device Nodes
>       arm64: dts: apple: t8132: Add PMU Device Nodes
>       arm64: dts: apple: t8140: Add PMU Device Nodes
>
Maybe the folder should be renamed to 'apple_arm' or something like
that?

> Nick Chan (1):
>       drivers/perf: apple_m1: Support per-implementation event tables
>
>  Documentation/devicetree/bindings/arm/pmu.yaml |   8 +
>  arch/arm64/boot/dts/apple/t6030.dtsi           |  12 +
>  arch/arm64/boot/dts/apple/t6031-base.dtsi      |  12 +
>  arch/arm64/boot/dts/apple/t6041.dtsi           |  12 +
>  arch/arm64/boot/dts/apple/t8122.dtsi           |  12 +
>  arch/arm64/boot/dts/apple/t8132.dtsi           |  12 +
>  arch/arm64/boot/dts/apple/t8140.dtsi           |  12 +
>  drivers/perf/apple_m1_cpu_pmu.c                | 664 +++++++++++++++++++=
+++---
>  8 files changed, 662 insertions(+), 82 deletions(-)
> ---
> base-commit: acb925da49876e74b806ccd48a7518d2d3368e5d
> change-id: 20260929-m3-plus-pmu-events-e4010ab44135
>
> Best regards,
> -- =20
> Myria Sarvay <myrialsarvay@gmail.com>

