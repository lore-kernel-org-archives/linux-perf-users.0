Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853686;
	b=OixcOhK+QpY5ewjLIR21FPxIXsTYjkZ+L1GerxYrfxjKOerezRue9zQLRgQJuNQArPT8
	 /JeSjt3PWTVORzIFWU8SFkE4z3veu5FwvK5T1HtUTNzeppobfgvx5x9YmkSgN3QsBc7eH
	 TkbmMgr8rxo9uvA+rtt+nGiJYC2GY8jd+VtsBxbluOAF6CnjjkDpjuEb1ysPXPgm6bQuG
	 KAAnqqjnCWM1gEjclYrmSAXU2qs45dVFP8RZWcnvJE1IrWodsDqqWLyOxyflhd098IkGr
	 qTH2BNZ7DGn181Du8Es5L+ARw26b0N1cfdrqOMC84Nlrj1fpKpSjeXyd1nMw+cqUdvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853686;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uCHFCcVDPJ3SgVTW8b/FBH/mTA+9kEqF9dktRcg4nfk=;
	b=qTqVCdqRBK5jqSt/dR8yjh9Tne2tsdhTfJj7BNjwWSKOFoiaI7jz/1M6sgzVrpt8IxjX
	 6Xws2ApVu5IR7BASfXQyFhCS45C+tU0ydKAwuo/vpIzyJck/MD+z3GPN8BTlAxRpAsOVQ
	 TA1ftlcswVWL3qW4VyyVBoVnR1OrGJvRBEimfee6l/usDzFNbw0fh9WQBKuIoOeZdU/X1
	 d5a61HpptHunHrNHEjw7k8PV+EbLOKBT4V9Ni3PtoT3SV7w4AWftaziLskMI3XxUypzoe
	 mGSXcmtFZxxx35ZRZ9kqTYzEWpBHUa14zEmUwAgno0Z2n84fEl6DtLn6uFWySNLY9UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I3lZKnTD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17C1606A33F
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I3lZKnTD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AC11F000CB;
	Mon, 16 Nov 2026 18:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853686;
	bh=uCHFCcVDPJ3SgVTW8b/FBH/mTA+9kEqF9dktRcg4nfk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I3lZKnTDQGGiyF9ee+ueC0RjD5h14O37QV4omwxDZX7GAOzsXYCyi/f5DKf990BZw
	 UMSEKZy6Kqe8TjJ0t8nvAzoXQyd/7qvTlyjnftz1RzAX/L0KLmYxTNeTednljwQbnP
	 1vjrv2Bhdm15zQFwF8mDC0jgbFegnshUqqXjXbdreUmS6724goVPXCU/BtaClVMbb5
	 otHlnyyoCzxIiPIpequffUD6njM8JJjXUk7DrGccJrkvMAwPdTrpJVZ0wmFb2rBXEp
	 3LxMu4gryHFme4GYhj9m6lA/vcA46IINrpzW7H2EHIoQlPKcn1kgZE/aCfWqUwmnRS
	 uP+EB/OLP2MOw==
Message-ID: <sashiko-outbox-217498@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] device property: Add firmware node IRQ affinity
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116-acpi_arm_pmu_registration_hmp-v1-1-0371d4eca626@arm.com>
References: <20261116-acpi_arm_pmu_registration_hmp-v1-0-0371d4eca626@arm.com>
 <20261116-acpi_arm_pmu_registration_hmp-v1-1-0371d4eca626@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 18:28:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Platform IRQ affinity lookup currently selects the OF or ACPI helper
> directly. Add fwnode_irq_get_affinity() and an irq_get_affinity operation
> implemented by both firmware types.
>=20
> Use the new helper for platform devices, preserving the existing fallback
> to cpu_possible_mask when affinity information is unavailable.
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-acpi_arm_p=
mu_registration_hmp-v1-0-0371d4eca626@arm.com?part=3D1

