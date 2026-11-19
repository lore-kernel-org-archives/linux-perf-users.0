Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115684;
	b=N5673XnH2KRlPd3JWaeAwP/dMG1bD+hROBjeA1lJluuoA+hsv1RtvZRRiAUjOf0KdO0v
	 y/BWxNzat6MFJiz4ZQQaJxTcJM5nh0UGi1P5XbdZB1TIL3kHGS3y8Ga2cfQ0FRbwkim8p
	 aVoxKWlM6//GZXsMO1bEAW2h94wzZpObc16lXYnHrcK/XjNSGxkSjJqicEuwVNaaqu/20
	 7eRdFPdeXjThxa98gSSVZQH38nBujrPQo4qO2BpwZkiY7o7nzTms7QCDu4xXDeX0kamXQ
	 g8cMiPPXlmA8DMTX70xmMA4Sj4l0Sk30P0Oz2V8UslPRvD+hBU+L6+6PxS5RUFYS7Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115684;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ACw2InB0LZRGHliBkmLryiL0puMly4yrsYsI6/8TAzI=;
	b=kbipCLfQEkrfcgXV37cim3+4nQ6bm0rdS20iH/d/RA8trlnoiuW7syEoYj2gC1M8oSs8
	 ynCtQamk7s0U/ZK7ahihSt1vHb5p/xc0mVgaBjsjyWOO+wLiR3MQI2yfMClWkh6aLq7D4
	 Pe82pumsjnahkqnM5Dqs687un2VT5VBTPpNF4aYt06pq/PyJyUJHuHbHsY/2rhhskv2UP
	 xEa3PFwmHIBIdYp25I9UGwVFGmW2RTAIdTdPBPOXYS4o8zI/nA4SiC838R6Oj9XdOVvmb
	 uen9QpNkeBI6pYpUZhQ55HrIZSi2cApdsxs3Jd3XAfs4BIEHdW4MwPmfUHCW/snYXOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h0VoSSlO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1A1606A320
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h0VoSSlO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FC91F000C5;
	Thu, 19 Nov 2026 19:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795115684;
	bh=ACw2InB0LZRGHliBkmLryiL0puMly4yrsYsI6/8TAzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h0VoSSlOmqcqfgaN9edhwJrpODxQ57VbmjlLXG0kn/+1bFlcIhjLdihhjMPm2+nMx
	 b0oECnFQSz24SMQtkUgbaNQ1Q2GIlpFsdw/X+ZB149Sm458iectHHFrWRtC54TlCPq
	 E97NmCWnQQdSXzqLGFU+A7qgu0GhfRLf+oT5s+himbLHeABy3YszzhHttHll1Nu/yq
	 xQTcz8AbIATf6YIS97amWs2uIf0kFl/zzqovFPQXaufD+Xy+n1KlMdFhpcEMRvwn4y
	 bNrJh1gHauGC7fFTXvk17JjNg8gNXn28mRSQnSMh8sTiPjUZaVghXoJtLgWhBNHr8A
	 tR0OBFI5QFPMg==
Message-ID: <sashiko-outbox-223849@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 33/33] KVM: arm64: selftests: Add test case for
 Partitioned PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-34-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-34-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:14:43 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend arm64/vpmu_counter_access to run all PMU counter access,
> PMCR.N validation, and overflow interrupt tests against both the
> emulated vPMU and the Partitioned PMU.
>=20
> Introduce enum pmu_impl (EMULATED vs. PARTITIONED) and thread it
> through the test setup helpers to configure
> KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION and
> KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS when testing the Partitioned PMU.
>=20
> Exercise PMCCFILTR_EL0 and live PMCCNTR_EL0 counting before validating
> unimplemented counters so that Partitioned PMU vCPUs transition to
> VCPU_PMU_ACCESS_GUEST_OWNED even when PMCR_EL0.N =3D=3D 0. On hosts witho=
ut
> FEAT_HPMN0, allow n =3D=3D 0 whenever max_counters >=3D 2 and verify that
> counter 0 (hidden behind traps while physical MDCR_EL2.HPMN =3D=3D 1) sti=
ll
> raises UNDEFINED on direct and indirect accesses and is RAZ/WI in the
> bitmap and software-increment registers.
>=20
> Skip out-of-bounds counter access exception tests for other counters
> when the PMU is partitioned, as hardware does not guarantee an UNDEFINED
> exception on accesses to counters >=3D MDCR_EL2.HPMN.
>=20
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D33

