Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0B14F85DA
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178615; cv=none; b=HZWsJ2+tuSwwfzlv/7eYZk7Xvt8CCt7Rf7AkdvhelP/PAjAyHjZZe9/cfyR8CSoLmNZMpo/6BmilBciqDFPOjjuCEgJahekvssOnPGT1/gGQEKqoH5j7mdOOiMEAYCvY+XamzWRugpZo1ZjWwmn6x5NR0l+htM7HJ7R2kNAUjZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178615; c=relaxed/simple;
	bh=SRhoJfr/JOvDdbWqwcp/0UMJCv4qGyWnUWi1zgqIFdQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BIG+XlfqdPW4fjXeSSIV0v9eTFouNsVj4M3AQcEjJb2fVb11bSOnZ0BYAefrf+897azypMawGc0GJQ0IgP0kadOdnji8leURpLmoJLEKqWgCNhb9RnNalLurgFZgLTrUVi2ub1A01jf8hFXkMXU2b2MLy5h4FKzuy+UXV8Xbvxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQpxaEEM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQpxaEEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5D41F000FF;
	Wed, 23 Sep 2026 15:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790178614;
	bh=SRhoJfr/JOvDdbWqwcp/0UMJCv4qGyWnUWi1zgqIFdQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AQpxaEEMlziOwGn6xwTJH8YCqmSQdDHCVCTzDGrEM6JHaDjjSG2zx3j/66Drp835L
	 WaO9659vBP+PbTlzH9j30KSZiBXKXU9Ke5Ogl+BwWK8FHmsbX8UvKLlJgGbgj68UBi
	 sa6/SYGWX14RdBIX0LdwhA4N4IyyJfRbcS0Qj+PFXiQl5iSfCgChLGJDtubtU38XyE
	 +2GwjCWERqD7JbFgYPDb0Q8KsxVJ2+orUznfEnS+oEmLt17G/4SVZMckegk3bJAG9V
	 PWFemOAgQvHPvXMF2eyOoElqNxHEtJ255r/+ZzA14uPok3XoJ9OkdQhC/YyV65PrmK
	 T7MUF1vr3iJ/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/14] perf cs-etm: Centralize packet ISA
 initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-4-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-4-6ab8c07a5455@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:50:13 +0000
Message-Id: <20260923155014.5F5D41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Exception packets need their own ISA so the frontend can generate samples
> directly from them. Currently, ISA initialization is limited to instructi=
on
> range packets.
>=20
> Move ISA initialization into cs_etm_decoder__buffer_packet() and use a
> common helper to obtain it from the OpenCSD element. Populate the ISA for
> instruction ranges, context updates and exceptions, leaving it unknown
> for other element types.
>=20
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-perf_cs_et=
m_fix_non_taken-v2-0-6ab8c07a5455@arm.com?part=3D4

