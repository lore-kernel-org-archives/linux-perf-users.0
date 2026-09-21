Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830D448167B
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009727; cv=none; b=Xa+DRVbcGQkeoqUOhpLCt+Y/VH28qogmsCvc9J7mUl+5l09Ai9lW21yXs8L1S7gkdqF3g3lN9rV2aYLt8nJGTdr6onbHxwC6ZBw1xi8nCRLL+9wL9dNgV9jXGGH65zdi56W7S5AKo0fhUxpklVGNBeUeTQzFB8498rvgfFVZGp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009727; c=relaxed/simple;
	bh=RTwWgY5zsnH+RAW2ZF2Ds8R2e0RNgx3JeNbhc0B0zwI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xim779tnEv7MnC6Cv5ASzSl965ag8lTHilYQfoE1PqO/5klkmOTWOnOeau8Il2KQNvuEOaSlrGMmD6K5NW8hlPBhTta49wuG4glGEN4aSZF57eyRrbob4/4FHIB36yMztKY4ZyMYhKXptybU0rLMrcObrNl+n0FkFi2O3pXHL0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvMH3H6N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvMH3H6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A14C1F000FF;
	Mon, 21 Sep 2026 16:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790009726;
	bh=0XdDBXT6HNg1O6o+ZdeoKhJ8SMjMzJLPv6G9V5PJLUA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VvMH3H6NRUTmDluESHIcQyIXcSjJWO3NYvj+o3Vl8upxZpQE+L59m8UiVndWYwtCV
	 DYNAWD0GLfaJvnZ/bD09FRhLAmY5qCeRwyrvyYuDo2CkQbS4vAGLi0Qd9jUTQxv1i3
	 8fJ+z4AM/9fKr7jdKtA3LZqBvKb7jqpUt6f8CUBp7+rspO37fYmD5BDsqNoXTnBdFl
	 V1HBSb2NFfYSLWYEbn+7tBdNuWi9FUFFZ8wjjM+k22DuwM7ef5jr9RHGgm4EZPgjRu
	 sh3M+ejxxDll/zdVkBPygBaHr56tx5Pm/vytMnggVZqg1PcH/lSHamtpbMQ8zS6yRi
	 nMui8fw36pRLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] perf mem record: Request PERF_SAMPLE_CPU by default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260921164813.6727-7-acme@kernel.org>
References: <20260921164813.6727-1-acme@kernel.org>
 <20260921164813.6727-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:55:25 +0000
Message-Id: <20260921165526.0A14C1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921164813.6727=
-1-acme@kernel.org?part=3D6

