Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1567133F59A
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080468; cv=none; b=R/a0mHnaJz/t7OLjvnQKo8zSWQiabghgIAnP9DdaT9/9/KbN2M1DrRnsT8S1KlfO5y+hrch4xx8mudG2NsjHwknr82Bza8NG26qjdma2MhHV2UPNIcRn+PyZ3HrHc3yW7zZG9l0UoC4o8ts8wW2l0NWvS+37t9+2l2FBhWzr4kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080468; c=relaxed/simple;
	bh=cQdVTLlo2GuI27ijkUKg2PKzPJwzrlht3YxXVhWZw7I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MGzviHMje8yLAdxH31BzyB417LE3ZFU9XDvk8GVUZ5NyRU0ejnSeL+3+sXaGH3E9FBzLohyygI5ZyrQcUO+VUqhxM3miZWRZkygOM1r3bor6cGfqV0JVnxmfZ3YyFDzFPKe8/eR1hQFA7gKVMPPhawYjA+e2wBH2SIDPBZlSbnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfa5MIBs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfa5MIBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473E21F000FF;
	Tue, 22 Sep 2026 12:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080466;
	bh=r/P6P+T5PzcqX7wt0FviblLsq07HGJoGU14kAJwOGsc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kfa5MIBshYq6JCkX8JoEbQ64hwMAV2BphdzXhE3ok6oCgMs01lgRkBs1A7B4wFXBO
	 uzhK23rJSRDUF7Gz9PvvAPIGX1r36wTH+3++M5MBJjQ8v3K3oHkda3o9xjB2v44y2j
	 UnsFRA8MLUKLssGUiHuIOFyK/C0/L+nKL5bfEXbibymaIki/+AgieT+8DaWCtThQS1
	 vSgPLfhO3Xw9pFsI3N3qmaokiMk5pGH/WgP8EgOsEXP/nICo9HdvADXzkYfT+rC7M/
	 TCUtUvFCJ9HHvjPKL2AtqARVsbFa9g0nnmIf5BJ4FNB3J8LmLuHbC/MheLsx9FuuMh
	 /uwlq6VfgnxIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/7] perf mem record: Request PERF_SAMPLE_CPU by
 default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260922122623.1029132-7-acme@kernel.org>
References: <20260922122623.1029132-1-acme@kernel.org>
 <20260922122623.1029132-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 12:34:25 +0000
Message-Id: <20260922123426.473E21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The data type profiling per-sample stream keys cross-CPU contention on
> sample->cpu; without PERF_SAMPLE_CPU that field is the (u32)-1 "no CPU
> info" sentinel, so same-instance accesses from different cores are
> indistinguishable from same-CPU traffic.  'perf mem record' already
> passes -d (addr) and -W (weight) explicitly to the record parser, add
> --sample-cpu as well and document it in perf-mem(1).
>=20
> The rec_argv array only had room for nine arguments per PMU plus the
> user arguments, not counting the up to eight __cmd_record() adds itself,
> which a new argument would overflow on PMUs with separate load and store
> events; reserve space for the fixed arguments too.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922122623.1029=
132-1-acme@kernel.org?part=3D6

