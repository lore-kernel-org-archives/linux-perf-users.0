Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793942258;
	b=d6EhGo7lg02xi0TNfanafvXIhct/UvIlDauYYAXoVBdML9i79Wc5NZj1mHZ98N7l3Dqs
	 KSohpYr3Mh8HA2v3jYfaiTV53bI6l1etrDThgdMdyOHOLp2Kwum95zcTEk15RHzR+jg8/
	 QclV+HdAQBHOgVaQvN4PcwdcCMHrP9IaULSAkAZTH4Aha/GugPNH0B6Q9THCn6PkEuwEB
	 dZuzdlO8LEOILxSs3FKumkYoKjJINqaArXnXnu3llzWUnXn/Z6NsjtDFzS45TyE4FZ/vM
	 9sWjP32sZMHl4jGNqugm65mcwbyuRXxIM/8B2aUMrVtYdus8lQnWoEx3UuxqRxPmlxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793942258;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j4IqpjSZDLNVXX1zRLBvrfcs/ZNUp7ydDQgPsaAQSrg=;
	b=leMsphkScDfnwByP2MrU5n1hFzwKDjmo2c51OxZCDsLvMzJHacPxfFFXYTs/RLAoIK73
	 81+wBL/syYIgLfBHxLPFOerGEUK1a6zr+IcoTBU4Z8a4m0tDEqQoJto25Ut7zGtRB/TKf
	 IRsZsvRGIH94OCnNBMVOTREyIt9EHLX75Gkwkp4ynW68I311tF7rC1PZt0Rrj9KZW4HwO
	 T49XNFrvcXvkggtNDJF9bpL6R8HEkNTjuoh2H0oA288tv/MUYfPBNklmMy70BFWYbyl9q
	 fNt/BJupKKZMUS1mbFlpFx6SGNoXMvjqDgx2mkc+s8ciYDRWEqz6r4GorxlIGGPxRCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K8RcRza5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86086606A333
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K8RcRza5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB0B1F008A1;
	Fri,  6 Nov 2026 05:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793942258;
	bh=j4IqpjSZDLNVXX1zRLBvrfcs/ZNUp7ydDQgPsaAQSrg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K8RcRza5wqYwQs2YvS3xx8cDB2vQh52p+3myATJ9fOhiECcGfR7T/m+ltby9p0YQE
	 GsxnSIvcM5Tzh7KEHALZqM17jKG4+gjcNhuz/kPOVub4V68nLFXc7aXIpnDzOYRvZ3
	 pjCLIcJld0dlImqB3cUnuZx86FbgLtrRCaSb93p/XUeUR7IEym4TRR0/ujhey5tL31
	 Jk0sUtaC4e7GGYF3pR/P2heOk1OJq8W/N7X9lhzvW84/R6midnmRbbfs++q69IcA9m
	 WuWCdpAwVKcZYaoYI1xnVuoc8DHJcmSsuZ3Y5pexR+9h8q+mJcVbfvAy7248Vz9mgS
	 wocBcDJkrM67w==
Message-ID: <sashiko-outbox-200809@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v6 18/20] perf/x86/intel: Refill LBR stack for LBR
 counter events in PMI handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106043257.842864-19-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-19-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:17:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When handling an LBR counter event, the raw LBR counters in the reserved
> field of each LBR entry are cleared after the stack is processed and
> reported to userspace. This prevents raw counter data from leaking.
>=20
> However, if multiple events overflow in the same PMI, an LBR counter
> event may not be the first one processed. In that case, the raw LBR
> counters may already have been cleared by the previous LBR event, so the
> later LBR counter event cannot read the correct values.
>=20
> Refill the LBR stack before processing an LBR counter event when multiple
> events are handled in a single PMI. This restores the correct raw LBR
> counter data for the event in this corner case.
>=20
> This situation is rare, the performance impact from extra refill should
> be negligible.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106043257.8428=
64-1-dapeng1.mi@linux.intel.com?part=3D18

