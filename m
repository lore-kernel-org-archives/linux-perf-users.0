Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853785;
	b=BJcXJ1aX1+wOm04083IX1Wgiv1Iyr7dKCopxaunCD52yiaXZWVHLXo3hR3QL4hNgRGHA
	 7kvOoZaI8gK5YVe/6lVV0Rwsw0vdosPsFGY5w89E7sWoUMlAcGYg5+2dErqDgS9dPdbUM
	 L0bG7USHDGCUHcKY5YgqTBjJPjjtteLOPJO7KqPJS2NJOwTmOGiIgLQojJxScWKSTOIjL
	 Z7wIy78Nd77qkH7QVfX2xFQl9C8hnZDdhvrfLe8llJJMGEI3JQPFfScUZi3XZdvVoC4Om
	 o0OZJ+gJcfQkwn5H7si4h+khats50QVZVsECXu4HpLBPw96JbhRKGiF8pk3quvlOrNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853785;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=b5aXt2bUjFK5gEVTPCohrrrvZiv71wUeqsiVPYTGiOg=;
	b=TKUJQPuGw7lEpMyyLpCUFLlxi1U7C9T9fnlemZsUHu/so9yNGmA6KevH1Pm60kx2SiuM
	 Ap9Fqhi+99pyPG/wCta7QSXWyuZ4SEy5ThfdY/0Ldkh5Ebm03STlC1CPyRv1PUHUxe5pC
	 AWip7dJJtvyxT8UFJevlG0JHNJazDYM4LjXdqN+U+DY9lIeeYuJrb1GeVcIxVw3aFe64S
	 Kw6Jy4Y6VHVkHh85pNKLyFVrsfllDNUPDV2JWt+/5QPA539mD6/ET8OyeiSPxiM4cXrOP
	 k78ZwoFnekjdsDvan4NgqB1kJrVbCluD19rabHg2QeOm9vw3ezAMGitiP3cD/e/hGEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DI9eeZ0A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A4F606A331
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DI9eeZ0A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6156A1F000CE;
	Mon, 16 Nov 2026 18:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853784;
	bh=b5aXt2bUjFK5gEVTPCohrrrvZiv71wUeqsiVPYTGiOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DI9eeZ0A78gRBuqMLoWOfUPi70HUdieJMmzqyOimTigx1TekGhQqVhR5JqxinX/1r
	 0YRrpem5Na1+9qbC6U9TSqYBU3LccvfFQAAsRXDJvpsuukYatPD7LP6D/ygc6xyIAY
	 BXChBa8jjXHVCPPzg3Q3+wny6IqxPPUKL2jBYX6xT+GHR9uMwERt/gi+nmGoc/hAAH
	 LZH33yDXhLhur3staM3qv+C9J0Cww9QPRVONUioKAw2aPKK+63R1nkP+6bQW84soQo
	 BEiq75JoaEOxm6qEYw0LsModJDKjuOqNJtrWUV5DRJnn9m0noTcnZbgRSZmsEVG5On
	 aEmrkPaLqkQrw==
Message-ID: <sashiko-outbox-217501@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] perf/arm_pmu: Prepare ACPI registration for per-CPU
 interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116-acpi_arm_pmu_registration_hmp-v1-4-0371d4eca626@arm.com>
References: <20261116-acpi_arm_pmu_registration_hmp-v1-0-0371d4eca626@arm.com>
 <20261116-acpi_arm_pmu_registration_hmp-v1-4-0371d4eca626@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 18:29:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> CPU PMUs may use a separate SPI for each CPU. Extend the existing IRQ
> compatibility check to allow different SPIs in a group while retaining
> the same-PPI requirement.
>=20
> Extend arm_acpi_register_sw_node_irq_affinity() to publish a singleton
> CPU mask for each SPI resource, using the CPU recorded in its mapping
> entry. Keep the full group mask at index zero for a shared PPI or a
> counting-only device with no IRQ resources.
>=20
> Retain zero-GSI CPU PMU entries for counting-only devices. Trust
> firmware to provide GICC interrupt descriptions as specified by ACPI.
> SPE and TRBE remain the common registration interface's callers in this
> commit.
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-acpi_arm_p=
mu_registration_hmp-v1-0-0371d4eca626@arm.com?part=3D4

