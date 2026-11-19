Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115711;
	b=mL21hi0vpmrXMAkV8xM9sFRnJ1xFQ1tGA2Xbzn+Bdn6bv8xI7LA7FgZM/tjOGM2qCYuj
	 tuBVGHlZMZE6S1CxH67qsjA4GpPiqotSdSIEwRCo0ZcfyuJc2J5chaNmRAOJZpDApGEfH
	 rat+RCElYvOZg0fOCw/9hdTDeskB352k7SNSa+rqhBDWxxUq7ICEp0xGbhvToSi40oPa4
	 zleyomEB0aQ/LeSv7QBFtem3l2QAwGoXoNPgmfw2OLye4rNq2sPRfXEH8lmNE+erSo4LX
	 V5ieLaY4GydrECF2mCmuZteV5gQKouSCu6TrsbJ6k/39wXnF0UFRfK3R/SBP1zw+KkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115711;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bEctUBEGsRvbDydzGdTUPnc41KV/OoM0qzTTw6ZZr4A=;
	b=ywfd7DVAe4feVoUrf9IMT8lcpGZuFO7mG2DT05fCeeUJmwkjk1ZJ+d71Pml7XVP3xRMs
	 d7+2xsQCL/CT9OEV+lmUu9tM96NyEgVjDhdRZIxejYHXRJ5L145goLzXMqfxkUVtkUuNY
	 nBIk7ZMekWzxGeHOsEzBjfc7qPRGWDmsavU52H+vfXLD6Hlh3+agNINBMP6AXdQwGTcsL
	 JibllCehXF0Y/fJrKvlPVBmdysB/L9V003bbHPgQPL9SMlCbPdr753ESzd1psZUqP1tXY
	 1sBtMN5Mq8EXU63Erpy1G+sMUHeqbYoGYaNid10WL2BG5TkOHs8W5l50OlRrJp9U+1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTlQvTue;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0D3606A32C
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTlQvTue
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085991F000C7;
	Thu, 19 Nov 2026 19:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795115711;
	bh=bEctUBEGsRvbDydzGdTUPnc41KV/OoM0qzTTw6ZZr4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aTlQvTuens9Gksp/0qJ0P5nNU025IAHOP5ZUgkh9tvsm7MBh7ddcmhIa+8fUHp2Af
	 rBVx8+FBfQrkrcChLxgdAbepjZFKp8nGh9dRHpgUOAJZ66wYVDNsMRRxs2naNED87Y
	 GJSFd/1s9gGP2qS06bRdj62Mi/Wr3TKGU61q+Emt3333yKD0sOJ32s7JExurj709dD
	 mxevJwkd/0Z1tzePZUmPUTCVW7VWBT5Zrq0Z7Dh0YJwMzjWKZPW97Hk/P0kzuZkcF6
	 wvyDgC8UiV/LMeZk7R4wQFE7e210L7e5hWrsD/OsNIs5mkH9aiEAe6/CRb3lv22QDG
	 KxxN0ENsBAqLw==
Message-ID: <sashiko-outbox-223852@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 25/33] KVM: arm64: Detect overflows for the
 Partitioned PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-26-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-26-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:15:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Evaluate whether any enabled and unmasked guest counter has overflowed
> in kvm_pmu_part_overflow_status() so KVM updates the virtual PMU
> interrupt level in the vGIC (or userspace IRQ state) across VM entries
> and host PMU overflow interrupts:
> - Harvest any live guest overflow bits from physical pmovsset_el0 into
>   shadow PMOVSSET_EL0 and clear them in hardware when the partitioned
>   PMU is loaded on the local CPU.
> - Check (PMOVSSET_EL0 & PMINTENSET_EL1) against PMCR_EL0.E for guest
>   counters 0..HPMN-1 and PMCCNTR_EL0, and against MDCR_EL2.HPME for
>   nested hypervisor counters HPMN..N-1.
> - In kvm_pmu_handle_guest_irq(), raise KVM_REQ_IRQ_PENDING and kick the
>   vCPU (or queue overflow_work when running in NMI context) when an
>   unmasked guest overflow occurs.
>=20
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D25

