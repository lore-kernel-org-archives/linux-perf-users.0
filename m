Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048913;
	b=I9V9iPK0T/l7+6zeeVkygx/vSj7ywY+KLwcZYwj3IXMqT/QwWTPcywbUkXLoIHFtIl0I
	 dt1itfKMsk6Gt4PasZJUfqmmFFO3cUwnPreWHu2tab3T90o0nXMJBss7H2+J9bKW3Vt8c
	 Oc5OVGvvdHeykVMtTFEvnZyu6VmcNJKCB9+0VSABY3/m9xeBq/kajQEWiEl9R8RE0bEI2
	 pcpy5po2yHJA2cwfKRktbrrc0PwH13JCcnjzrHJI+OLXHvXmiXBzAcaB2v6f9R7LCF4Gn
	 kcCsMYH8o8RaQk0hRP6dfP3O43HdPdoqFY6LRehAgVtEDiu38pbBQ0SHFPr4rGYnNBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048913;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kqMwZFJHdt9WBJa8epFjgUbYUuMKAtuu3+QKYu33qJc=;
	b=1nNch2sM2puOnLVQg5f6LKD9xA4GtlepHT8p1jFZRFrBL2GiL3HfgeFlf7pvfPLnJ2OD
	 Oh56LQ7uydelcfWKTZRRaXdVHgGElIyd/3xndVxXCLyhh5BY140snMqNcEE7mHolYgwwb
	 Xi3HbETIGvRBEpakUzpaky1G6oEp7bR2jr/fuUC+29qlXYUM2qLJr6Bs+86SXlyXVnacc
	 sLAnyVynTRqD8XQJDvNoXpPGfFt5/QDDcVluL1lkMNCNRCnQNSzuOv5fltkT+R08Ga0r/
	 01jYbH/c/ttDULj6TYkVPFYhBolkCR34gW3A2xQJeB2QNVVpDtj0dO8gLMS0gIN5rTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UjDVHc0u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F8F606A32D
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UjDVHc0u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05D31F0089F;
	Sat,  7 Nov 2026 10:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048912;
	bh=kqMwZFJHdt9WBJa8epFjgUbYUuMKAtuu3+QKYu33qJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UjDVHc0uk9AHpA8NMDg1fwsIzMs40QBeJtmHrpozHwKPzkaDp0k3/lo09ZW9qH+vl
	 ip+Sb2HoImD+Fthd8om++csMYoivOQ7LfT3/DzGANsrbccGdTJjzaCbYSoheoBfZcX
	 U6BvJkjCzYONy8GwGFkfaArrmE4aKigcp2bUJCx34V0xcEnUFOsZTYK7KHZNancdiX
	 5QTIC4FI8mHsqfADegOZycKoJuDsqyK2X7dxeOlWiN2bmwN+Ez/iF/d1NhhP6KWhzn
	 EmmzrhnKHc9qKfneP+koPTcpN7jMpezJh6vQurWQJm14VLKimEKdIpGlBPaV0kubDv
	 9dY2lgfxvL5Lw==
Message-ID: <sashiko-outbox-202832@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/15] drivers/perf: apple_m1: Add Apple M4 Series
 Support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107-m3-plus-pmu-events-v2-7-acf1e78da039@gmail.com>
References: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
 <20261107-m3-plus-pmu-events-v2-7-acf1e78da039@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 10:55:12 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Myria Sarvay <myrialsarvay@gmail.com>
>=20
> Add support for the CPU PMU found in the various M4 SoCs. This PMU is
> almost exactly the same as the M3 PMU, just with different event
> encodings.
>=20
> One notable difference, is the addition of the various ARM_* events,
> which appear to implement the PMUv3 specific events that the arm PMU
> specification provides. Hook them up with the various perf events so
> that more can easily be counted on M4+ devices.
>=20
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-m3-plus-pm=
u-events-v2-0-acf1e78da039@gmail.com?part=3D7

