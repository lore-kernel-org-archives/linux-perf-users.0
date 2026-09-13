Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED1A385D99
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 03:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789270930; cv=none; b=Sa+SyPeDG0giLEc/x3Rz+BXCUVRSLt2urFOTJD1YnhCTl0CET489c1j9YpUFntDe3yx1enOm6psKN95gTzH+eVOzGRTuLkLJf8qjLvfm5KF3rYLqnmTK8u2RZg73WkV8lMxhAiYtmYW3oPC5nLLZuPK9c879LzpI2vEdegfS90w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789270930; c=relaxed/simple;
	bh=1b88AB6i3CGp2vl6Kj7kAo9WtJU6xixPWCDRjPcwLag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jZThpp8ER4FvjfilTMdZ2OwHU7mLrBiyhKNj/O9aHiloAmcaUZUZsYdsmtzZcXnqzzo48yojv3kEuR5ZSrTnvQpzge+nqEKTMG8b+FBCLCIOI/nAdLIWO9P08DdNS2VJ0szNpCJXVGZUIJhVVHqk+Rd4IWLrktt8kg/5wb59UyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7YwZkZL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7YwZkZL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0F21F00893;
	Sun, 13 Sep 2026 03:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789270928;
	bh=1b88AB6i3CGp2vl6Kj7kAo9WtJU6xixPWCDRjPcwLag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d7YwZkZL/9sMnFEDn1xqtg27/+M7+w9/H5qqMxC+w6DRBIp4oEA+O9jp2HsFzfaCH
	 na/QVVYC0CxSMZV3TuTyzpvINs4bQMOqX6YxzbJvxaQGBYBmR9NlacgUQpC2H3IRNN
	 BanpjTmhsghTOw0ssQKtiGlzbB5KTiPWByTCs5oDvSOh5oaCUqui3KNPwEKSKlaZce
	 1Lhr/Ejgph/OJKbGi9/8NtrCN7FnHtTIHDT4+kXhm3FrfmoXiztFEK9uZ3fUcDlWFq
	 00pJIOHb7BsMZi7laB+4E4wRnOz8lI5s0u4g4emWoSa+FFPAodZMT/HJUhrA9bXgJ+
	 DVjT8yF2uo/HA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8] perf mem record: Request PERF_SAMPLE_CPU by
 default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913032632.116277-9-acme@kernel.org>
References: <20260913032632.116277-1-acme@kernel.org>
 <20260913032632.116277-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 03:42:08 +0000
Message-Id: <20260913034208.7B0F21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The data-type profiling per-sample stream keys cross-CPU contention on
> sample->cpu: without PERF_SAMPLE_CPU the cpu field is the (u32)-1 "no
> CPU info" sentinel, documented as such in perf_session__deliver_event(),
> and same-instance reads and writes from different cores are
> indistinguishable from same-CPU traffic, so pahole's false-sharing
> detector cannot tell them apart.
>=20
> builtin-record.c already defines --sample-cpu and 'perf mem record'
> forwards unknown options to the record parser, so passing it explicitly
> works today; make it the default, next to the -d (addr) and -W (weight)
> the command already requests, documenting it in perf-mem(1).
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913032632.1162=
77-1-acme@kernel.org?part=3D8

