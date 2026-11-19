Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116092;
	b=YkYcHuhjCcLuSYX368mx6snvX8PvQXOpc+PvP/dve2HcKWLrXLY0KcHQJpX4nUcUYG/f
	 CNnLhfjL4Lqt0+bujyWhUrkaR3C1/MBx/KBtNcVWwnMcmEY4GdNNTTLDaWZmafVmA7CEj
	 oZs2SO9TsM9P+/B04dLktRYb3CbPywYw1OCqSRYjhPdErWlNAlobAcdw0AZz5R7q1AojU
	 2jJX8LtATJh64biuPiTUdqUu9JxVZl94LSbQGPm/CvHVhW8abC1Ke4FxDd5bKdWFds0Lp
	 hh/J5o2ZfM+GCBn9D1MwkcKZhLzh1BURVxL8oOZEL9Thpuhi3s3v2u8Q+KAPyY02+nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116092;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8jYfGOA61EzC40djfFZnWJOmxaquHVzAP3ZbSiYqMm0=;
	b=nDhwjYTTwiv5N1NHvQHJpz1onIFIvg1z5y/wjyLUNmCXmn388OjlLrabLj0pFhgqnUVB
	 gTjaK17/hKe24+v4trPUzd3l4o79/Ku/ur97Ft/gwMSppnU56/gCNfDjrK75h+5KfWflT
	 g0rzzPLd2bei03Q6XlaZrbM26XteHSMW70QXCrFdiJ6lMZi0OaqdfFht7HplhB0AMZ+Eo
	 m2bdMYP44nSspC1fIPpEcV5QeoVOkZFDAcQRxbBL51YBDwqV1ONrPMYyaVDVYYBsoaKhL
	 c3OJjwvXvHHuRePhmQpPYD1O68XsX/ZrLSFysjHQmyhYUaQqzE2t519w8ajCbAAg3Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cnf+mzKX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983E9606A32C
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cnf+mzKX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1979A1F000C5;
	Thu, 19 Nov 2026 19:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116092;
	bh=8jYfGOA61EzC40djfFZnWJOmxaquHVzAP3ZbSiYqMm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cnf+mzKX7j/m+Yi5sXEl8f/gPTPKTwWGjQ292sE42RaudhhpZ/xirC7ZpyiM7oqQ6
	 5xn1UirOZPrVb8cGqOTmfGp1aM2G+to/9shAG3d47xmvnak0m+aKSovDcCPthUj+Km
	 gIKvbe58Z0kfB6BHYVvdgxGQX5TX++cuIa0Nk3bD5q7JdM2eVBuvj1OyCooxHrThT5
	 7D2iGuugtHjdsBG8N+gX3tPSeklgf0n8slwGMITeQYdV5oXu13C/6eToib5VI8wySL
	 5QrRN8ksV+7B55zuouOyH5+LZbPHmd+tkY9UuFXBN78U+iFlpbt+vBJIDl9R5gI1Gv
	 C6scsCcWUyNhQ==
Message-ID: <sashiko-outbox-223867@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 22/33] KVM: arm64: Apply dynamic guest counter
 reservations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-23-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-23-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:21:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Reserve and release guest PMU counters dynamically during vCPU load and
> put rather than statically at VM creation.
>=20
> Add kvm_pmu_set_guest_counters() in arch/arm64/kvm/pmu-direct.c, called
> from __kvm_pmu_load() and __kvm_pmu_put() with local interrupts
> disabled. When the requested guest counter mask collides with active
> host events in cpuc->used_mask (or when releasing counters after
> squeezing a host event), invoke perf_pmu_resched_update() with
> kvm_pmu_update_mask() to update per-CPU cpuc->cntr_mask between
> scheduling host events out and back in; otherwise update cpuc->cntr_mask
> directly. Warn once in armpmu_add() if a pinned host event fails counter
> allocation while guest counters are reserved.
>=20
> Skip releasing and re-reserving host counters across nested ERET and
> nested exception transitions (IN_NESTED_ERET and IN_NESTED_EXCEPTION)
> since the vCPU remains on the same physical CPU.
>=20
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D22

