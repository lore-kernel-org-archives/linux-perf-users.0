Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794028786;
	b=zrPbwlTFKG6smFeRGZ+WFhK8Dx/i93OfWT9l4hkf/ELy0B5s6YupIRrXAZWg3uzFQ0/F
	 Ga0XJIrKBG8NhiPJ24MSNJp/7uchYitml5cbdpZUJGpOOWf41zngN7d2OO183pSWEMFPX
	 6CXjl0Upz59VnZblTRF7ZmOqUZLCEcy9FqlpicAqoPE/N/EAirrGSVPjshsLU98daU+Ho
	 9E/HToavbazA8TP4R++MeTPH89FhqrIB8os86nTGORqkx4itNrP9IJMNx40RAB/c7BbXr
	 tpZV3Y8CShUZSssYG0P0WkWnLpbercxlXfHuhOw0ckl/yxF65atSmX9h+piVBNH0E8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794028786;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CRKRefjx9StmuX5X3vunRAaEMjqGGfElYpmoFv8zZTY=;
	b=c1VR2gnWE9b7mVRysgBAi28XV1GdAA8MxX3RbWHj2mSmiHB27xrd0rMWBsIy0WrvCJte
	 ju3I3YpjBdRiuOQxmwXm2h5a8YbKEbqZFiIJ4S7nviqKl2UYTqrNmj1xawEEEic/Xxk1q
	 tqwn++CiF1mEsjzaMpdnOnEsgiPVxAIsmkGCJ0VMBSVLPjIbHn16Cmvnr//9J15/SeSMD
	 xmqzXlctNW22bpe435r+mPXv6bdZVmZHvodZ36EOLl7hKXMvK39J0nUKFbbOGGhWuVymG
	 M43O7dqOnyv+8HwQIXAgtMeHA9X/8n7gp8K/fHWHma8aIm/IOft+kuOCC+59QMS72Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuQGAuq5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FD4606A326
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 05:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuQGAuq5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE86C1F0089F;
	Sat,  7 Nov 2026 05:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794028785;
	bh=CRKRefjx9StmuX5X3vunRAaEMjqGGfElYpmoFv8zZTY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BuQGAuq5HYfFWvdHcA31hxQdGqohvJuBRnkaO+CVMyQ8UhcMmj9uhnFfzv9wgtIvA
	 K+/xeAcUa2HXCKulUqmSJpjcnWwK/H4AmvyspZrRbRfGA/FWkXnYgXi9wwEyY8MuYz
	 C7LOAkiKvHMHAbgSWd1GIedbg/sVvf1kgpNtkvf30W8tMddzyKFGXzncp+HoEro4yD
	 k63Mn3FvB/2Zg2HEJSCJq9nsSbZaJkwB4eezx4235g7a1A/p6FdIthNfLETW6d5ORk
	 qfXVwveOcuFamaofq4LiN+KNTfceW+j63z/bqSPqF3B9csOJgiuDYHor9SUzFciOvn
	 G3YLQbkZxr+UQ==
Message-ID: <sashiko-outbox-202609@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf vendor events arm64: AmpereOne/AmpereOneX: Fix
 typos
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261107051730.1880691-1-takano32@gmail.com>
References: <20261107051730.1880691-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 05:19:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Three distinct words are misspelled in eight description fields in the
> AmpereOne and AmpereOneX PMU tables: "Preditable" in BPU_BTB_UPDATE
> (AmpereOneX only), "satisified" in LD_FROM_ST_FWD, and "misprediciton"
> in the branch_mispredict metric.  jevents.py copies the strings into the
> generated tables, so perf list prints them and a grep for the correct
> spelling misses the entries.
>=20
> Fix both fields where an entry has them; the metrics entries carry only a
> brief description.  No event code, metric expression or reported value
> changes, and the generated tables are not tracked, so the diff is JSON
> only.  ISTALL - the other codespell hit here - is the ETM stall-control
> bit name, left alone.
>=20
> Written with Hermes Agent, an LLM assistant.  Running jevents.py on this
> change produces none of the three words; perf was not rebuilt, so the
> perf list output was not checked.
>=20
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107051730.1880=
691-1-takano32@gmail.com?part=3D1

