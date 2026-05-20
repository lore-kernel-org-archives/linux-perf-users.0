Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EB534D93B
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306161; cv=none; b=kHdh6ZAe8rNmuu+j3R3igrs/TxApUP69UaWuy+V+XmL3Wrp5PnXGrhgB9/t4K0hfIYaPufkloJOqYfVn6EiPaKXV32ck9IX0JMAOziZRUyM5IeWmw1XG2VYxRlMG1N4tgBTy3p8wEdeT3G13n4guB08z/i8Wc19IUatFNHVXz9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306161; c=relaxed/simple;
	bh=gXLh4JA3jvkWSIRfVaf8WwFYKkm/e5hnOTjAK+elvE0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nbYZMdT4DR4lAqlBl0UtAkP/N7mX1NA8HcnnvBhmGZYNTpb9NPZ4TA3LiB3qJhGsViEY0MQWGc/DFl8kB80jnWNeW6ICg+KdP4imxGPZUg761IAHIuDMYctVRBtvoUMWAHa2Sj62ptHEfDBtLiqhTAzf+bL/7DM+gp0c5Cy72Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOKas1KO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOKas1KO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B61B1F000E9;
	Wed, 20 May 2026 19:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779306160;
	bh=Z0FDjIDVZRRPMDaih5BUps7mparYC34D+3MBIbpS6aM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aOKas1KOEF3a1s4uhvVDMA9Og1R2eJEFXvQpv+PYOGat0Fd+9x0ucgP0z7PzV995K
	 Xy/ABazaI7PQI3XVFJ22TuGfF23PI+7EMznWzC0jB/0xecO3aje+bxkfbXVWc4zV9r
	 1hGkUnCb7R8TcQQzQ/nkO+CCnOMCM5sSetxJrL9cmbXs3kQa1Fp1GxGXagHxKULIlL
	 8uv7q+agZdINDrflK+49QCvLeIsIdoceIC1hea8tP72nsVjotEov5Evh7Lxj7lSC7h
	 GWfHxyBOQDuAscZsA7luZsKXQZhWsj0xeBYi12SKfAUvVQy7bMtHuYXfNwyzdvYpQY
	 g9Rx/4iDYXqaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 12/32] perf inject: Don't pass evsel with sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260520190538.142018-13-irogers@google.com>
References: <20260520190538.142018-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 19:42:39 +0000
Message-Id: <20260520194240.4B61B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Buffer overflow and event corruption in `perf_event__synthesize_mm=
ap2_build_id()` due to a typo when capping `build_id_size`.
--

commit 2cd2e94f594b8a44bc5330a9f9007347d463ab0e
Author: Ian Rogers <irogers@google.com>

perf inject: Don't pass evsel with sample

As struct perf_sample now directly contains its own resolved evsel pointer,
passing the evsel separately is redundant and clutters the interface.
Remove the redundant evsel parameter from inject-specific handlers and
structures, ensuring the tool always directly accesses the evsel bound to
the sample.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 85bee747f4cd2..de812a2befbc7 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c

[ ... ]

> @@ -2309,6 +2304,7 @@ int perf_event__synthesize_mmap2_build_id(const str=
uct perf_tool *tool,
>  {
>  	union perf_event ev;
>  	size_t ev_len;
> +	u64 sample_type =3D sample->evsel ? sample->evsel->core.attr.sample_typ=
e : 0;
>  	void *array;
>  	int ret;

[Severity: High]
This is a pre-existing issue, but while reviewing this function, I noticed
a buffer overflow in the build ID capping logic further down in the
function.

When capping the build ID size, the code assigns the capped size to
ev.build_id.size instead of ev.mmap2.build_id_size:

	ev.mmap2.build_id_size =3D bid->size;
	if (ev.mmap2.build_id_size > sizeof(ev.mmap2.build_id))
		ev.build_id.size =3D sizeof(ev.mmap2.build_id);
	memcpy(ev.mmap2.build_id, bid->data, ev.mmap2.build_id_size);

Because ev.mmap2.build_id_size remains untouched, the subsequent memcpy()
can write past the end of the ev.mmap2.build_id array on the stack.

Does this typo allow for a stack buffer overflow when processing crafted
perf.data files or ELF notes with arbitrarily large build IDs?

I understand this is fixed later in the patch series by the commit "perf
synthetic-events: Bound check when synthesizing mmap2 and build_id events".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520190538.1420=
18-1-irogers@google.com?part=3D12
