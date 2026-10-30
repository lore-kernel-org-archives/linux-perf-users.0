Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373777;
	b=Fk1KORc+zWjnTen3a784qUrdLDE4m0nFkgWFU8Ty7x9a+rflxEEdjkq1mzIqMBHORIoI
	 ow+RlrF4J1jXwmyPNw6/zVslUjALxsb+laZpvq7URzqQS3L1G6HVsU0baAUXYkZ6BAZO9
	 g6djqGOO/idnmptvevG7PjtMJ74A3Gsi+K2/CbTMfS+hd+x71ov97YI3+9jSDjO742/jp
	 mJcIvs3iyG33eROOgX2Hu18flEj4neVlGE8rmHIOYD8mmRI49LpC3GXj+TvbzkQdNzxzU
	 yok26pHzs7jEkz4Voim4ylbSBChTOc2+AAss/p1a8Hn+S47o9xV6r6zUiFBm+4itS5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373777;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ospbVq+GrdcFVqQkIRMLYLeeYApJ8hVfpgkH70fJ1fY=;
	b=C/Jgcq6ll0GYuzyxZhYHkXm8ofLJbopt9lgfNvaKVNdR7b+b8hEo1HEUFqNb4FMpFlp6
	 /t34WS8HMS+KJsQi1u+6S2xvgAxJ184j5RObpwnRvLf70tJ5KKO87JKSK7MCgxVEKthNJ
	 BAjzfQfsAsXDGTm/d6Tz7Jxd5RTDZf5IJcC6pITIM2qF/6iXWd//J6iV/n5vZrNKG3FlW
	 6s/i1IONkSsxHMocuv0A95xsXXwsa+tfnjgpKWrZSchdlVJPIvdPCMZCC684H3z3y2qBW
	 OrTQr/8lXSxm9ayUCpedGJeIfz8u+lXf06XvdWQzxxL00cl/+h5H+DqoHDMqU+q1lkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6KAovex;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A22D606A31E
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6KAovex
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6F41F000C1;
	Fri, 30 Oct 2026 15:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373777;
	bh=ospbVq+GrdcFVqQkIRMLYLeeYApJ8hVfpgkH70fJ1fY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V6KAovex5o2sbiacUeo0ymt8TOJwq5L0r3cZQH10RLA65lNMF7SWoa8lUmDiOHe67
	 aiwiqWjZb8A+ua4hQeN0ozjN8bOitEAJlckzQOnEpC1RoYxd/zE8AkOiwauyuSWLhh
	 yoKAt1rDvRNwV62Hha+aUEuQWslwM+EqCm7kVOqakVs5PaPflgk+ink/zXXBPukjyi
	 l8OLecDq3mvXF6HdSBaYQ7PJLiVdte2d4UHRh+hZULMLc+e8+LvPxvB4e9QVgafMlU
	 xCfsOwBtFFslX4Qrsi+6T1I36ur2Vda3ATabaQ5ndBTOrTKBO9yaFZYKQjDmAOjTje
	 AO10HybM5JS+g==
Message-ID: <sashiko-outbox-191163@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/14] perf cs-etm: Classify exception calls using
 the exception packet
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-9-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
 <20261030-perf_cs_etm_fix_non_taken-v3-9-7629b52ab047@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:22:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> ETMv4 and ETE use the same exception number for SVC, HVC and SMC.
> Identify SVC by inspecting the instruction before the preferred return
> address in the exception packet.
>=20
> Preserve the exception level and preferred return address from OpenCSD,
> and use them with the packet's ISA in cs_etm__is_syscall() and
> cs_etm__is_sync_exception(). This makes exception call classification
> independent of the preceding instruction range.
>=20
> Name the exception address pref_ret_addr in an anonymous union shared
> with the range end_addr, keeping the packet layout unchanged. Name the
> cs_etm__is_svc_instr() address argument ret_addr and document that it
> checks the instruction immediately before the return address.
>=20
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-perf_cs_et=
m_fix_non_taken-v3-0-7629b52ab047@arm.com?part=3D9

