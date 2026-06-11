Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12708175A7E
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 23:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218841; cv=none; b=VofYRy/k4eOguBqcnfQjb/Mx7/0K5pSVV4ZJTBGFgWxwVEEn0p6JNBmssc+3Qty6NsFm0/QakFrq4drnIDL0cOi14+iXMC5r9cVQbtMVbDo0blr0Jb3d0Q4kkPGA5Cox0x+6+dick5Uembn1xqVRwwffYw6X+nOyf2pTrHbCUE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218841; c=relaxed/simple;
	bh=klaJzG3PKlGtCGAJekZJbKNBzXXy0rocEZ6jngmvMQ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ER0Jsh+lkHsibIm97O2fdKsHodzYCPrzM3mzqYRaMFGG2q6OUnUD9hu2BdfEzpgfiGP8rglNiiU0fiSs5CEwXz6vfkJg8jkPiqMOwNrZWwBHKbM6LdA5CdnKEvIoDEXvZZSpWANXFHQXY1bh0v5BbMOBnw/reIkTbw2ou8Z7GAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCmVeVWU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCmVeVWU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB861F000E9;
	Thu, 11 Jun 2026 23:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781218839;
	bh=/EyGZ6s2KnW39oG0Qrb387bhRTg3g10LZCajFfllPUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jCmVeVWUBJYcJjwMHp4oYzd2NF/xpExZ+enSRVcvGcuvNYTcyjV11eAY3pIaDV/3/
	 tiqd11+bDdmpwb+0sgTVURRSV1Fg+L2Mdd1S1LkcxXSL9Y4xVmv+xKu13azvOVJ2FS
	 8LglogVeOFxPPWl+Pr9jtuYQYAJtPbIjaEexZgiejD15Cd+5AoSFpVgX8k+1eWfsJ8
	 DamNWACcHZq38AChQ5cMcfvOkz0wueEd3UvEtOJVqcofY8vXtA+mMp+GGGlyJtK09d
	 oNDmlNZHjkBlsCVjLLjKhIQvNQjMxKgQptTpG0SQQ0Pwa9fichHm8/UMPVhgPe1y8Z
	 bB3rPhNo+wgpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 15/19] perf python: Expose brstack in sample event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611224455.201994-16-irogers@google.com>
References: <20260611224455.201994-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 23:00:39 +0000
Message-Id: <20260611230039.7FB861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The Python wrapper for branch entry flags misses several bitfiel=
ds defined in the C struct branch_flags.
--

commit c718355255bbd068e6fbf979ba0148e02764940c
Author: Ian Rogers <irogers@google.com>

perf python: Expose brstack in sample event

This commit implements pyrf_branch_entry and pyrf_branch_stack to allow lazy
iteration over branch stack entries in python scripts.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 16e415bd4a169..56449183a9e76 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -997,6 +1001,154 @@ static PyObject *pyrf_sample_event__get_callchain(=
PyObject *self, void *closure

[ ... ]

> +static PyGetSetDef pyrf_branch_entry__getset[] =3D {
> +	{ .name =3D "from_ip",      .get =3D (getter)pyrf_branch_entry__get_fro=
m, },
> +	{ .name =3D "to_ip",        .get =3D (getter)pyrf_branch_entry__get_to,=
 },
> +	{ .name =3D "mispred",   .get =3D (getter)pyrf_branch_entry__get_mispre=
d, },
> +	{ .name =3D "predicted", .get =3D (getter)pyrf_branch_entry__get_predic=
ted, },
> +	{ .name =3D "in_tx",     .get =3D (getter)pyrf_branch_entry__get_in_tx,=
 },
> +	{ .name =3D "abort",     .get =3D (getter)pyrf_branch_entry__get_abort,=
 },
> +	{ .name =3D "cycles",    .get =3D (getter)pyrf_branch_entry__get_cycles=
, },
> +	{ .name =3D "type",      .get =3D (getter)pyrf_branch_entry__get_type, =
},
> +	{ .name =3D NULL, },
> +};

[Severity: Medium]
Are there plans to expose the remaining fields from struct branch_flags
(such as spec, new_type, priv, and not_taken)?

It appears these bitfields are missing from the Python properties array her=
e,
which might prevent userspace Python tools from accessing complete branch
stack data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611224455.2019=
94-1-irogers@google.com?part=3D15
