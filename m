Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614001;
	b=pIEQuLVEHDf3Prpja95GPLYCaO7lTitlykNIV9vuT6U7qk4F5/JYNw5szJ4pS3b5O8lc
	 5ME/CRFdRlIkTT/QFUA7M+6yIJFpMoiVDGJeI96J0DcqpJ+bCyLm2IyhYE+WztQny3AE1
	 cMTcRTvnSdl0gJOyUuW0Ex5ts28+9EUgyDcApUcXT4Y7wXjLGqHVMx18rtTeVmvx9yyH6
	 NwMLwI1m4KN2ojkjJeJqoLXYsXHdko0V7hfqBKksOGAAxT3LBsOTPhrscKUeQreWoc2ei
	 Vtp6UyzIbtCxf0qQEw5VytcET26S7PxLDm1zk6ztmRUYC3dnK7z5Bpswado0138/ajw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614001;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PXhLT+HkqPWGo+TOUQnD7RJ8VkIm6SzDcjefiXpa5dc=;
	b=3+wqDFd5l3hbOKhp2n/dFHj7Oc9H8R7Y0wcIaLkU18bABUY+YxAcuWm9ZSkhsb/xUf6D
	 gQkePsScjZ575YusbRuq+ljbqVBz2zi+/JKvSvC1egC3y0W7681NywhlEOJvr7iozXJDV
	 +LjlQYnggJ/hfALxLwfBlPbqgbcnw4g7rDZcU+8Wch5MSMPcnlGR7edZQ9MzJGdc0zyVn
	 naVGNHjkiCDrmpFwuofqaJQVRlTL1f+HyVCqGFAXwUjuCka1PxHD28NIsVBQkAZcYM288
	 tUoeQZ/AMp2Ko7pjsW1WKyFWnUvHSRsUzeppi2aifaTvxaKRewVs+Ssm8SEsaHMxH8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EiDb5Il2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CDF606A33A
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 23:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EiDb5Il2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED7C1F000CF;
	Fri, 13 Nov 2026 23:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794614000;
	bh=PXhLT+HkqPWGo+TOUQnD7RJ8VkIm6SzDcjefiXpa5dc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EiDb5Il2GisT3GUkqJrYO6vY4Qy/T4cS8XFu6jlu5V1nCilJX3R4mmlRPznNVcBYd
	 C0A5CbXcl0GgJqt0rRPCnh6Ub183QqH1wZmjczzPFQY7QjTxicQlQOTHqMpM4ju5+j
	 zGyeZWbdkj/w44uYIwCDKLf5wKfRTp0aDmDRNA1kNNVn+tPwfrxkX8MPK1Khl2Hmmw
	 1EeSBygReUF29GFvsP5SFgVRzT0A6nV07vu8/PcJzfAOSVqsP93Y4xJ2L8PxbczvEn
	 pGLH2dGDGyRsFJHAg8nDcM2wtJdb3SMVy9IyIIDSS9K7xUgOApfzIc9p51a71ZX7Uh
	 LnkUEaMvJtt7g==
Message-ID: <sashiko-outbox-213881@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] MIPS: SiByte: Wire up the CPU interrupt
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <f.fainelli@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBFUkZPUk1BTkNFIEVWRU5UUyBTVUJTWVNURU0=?= <linux-perf-users@vger.kernel.org>
In-Reply-To: <20261113233358.538698-2-f.fainelli@gmail.com>
References: <20261113233358.538698-1-f.fainelli@gmail.com>
 <20261113233358.538698-2-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 23:53:20 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Initialize the MIPS CPU interrupt controller on SB1250 and BCM1480 so
> CPU-local interrupts have a configured irq_chip and handler. Reserve IRQs
> 128 through 135 above both interrupt mapper ranges, and dispatch BCM1480
> IP7 through the CPU controller as SB1250 already does.
>=20
> This provides the CPU-local IP7 interrupt needed by the SB1 performance
> counters without overlapping the SiByte interrupt mapper IRQ numbers.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113233358.5386=
98-1-f.fainelli@gmail.com?part=3D1

