Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC8F3793AA
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639699; cv=none; b=IPqbdSTc/+4GsOxT9o9b9PR9buUo5x2M6IuSTepwtbQx6pmDQNCkauBvFhMz9qWYEB7Fsu46HBU2voXhvUxDaTqlQ2dw/+OsSM+m7GL/2IKoEmF8N290EAK3Xxl6BBhio+XQNJch4RVsCgR/Zhk6oy9VUvwTdM7eXqTABR2QG6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639699; c=relaxed/simple;
	bh=ZqNstQue1XEbQxzY1PCWWFzK/KnxIjO3TSbNVR4qirY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N+Gpk1Nc3ouPO3IiUvLi7kEWCTjIuJ5vAiog24q27uKa05fWl+gAOEITHt7CKuVd2ctoP9GPWAUjx3OVLyuunAkO0TWoTzie9bVaa2t3ia83t2QpZIogObe+yu3eGB0qjIr1XwiceHNPtJSr3tIKi4lHx41COMVF+sacCRHqqv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIyLAsQE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIyLAsQE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D051F00ACA;
	Tue, 16 Jun 2026 19:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781639698;
	bh=VQHDGrV6x9Bnb3KYbMgtsC4f2Bz4STQdvGfB5hgYhbI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TIyLAsQEE5dMuDXyblZDQkfzzLtZiSsjG4tjMH8U1U1m5Pcfy3ozT2Hh8Cz69djIt
	 StMi+7qKYWFJFjBZei/z6MeDr6Xv7ncXeWxfS8fReYyoUvJHxh2fzPnkIj4AYgIEDM
	 oJ5Dr/ASeYFnJcfdJbUj7NeNWwndCA5ohxVMpT6CTR5qQl249EsldHOnKd2oEgey2V
	 dkZoKuOXm8dZWVrW5tIz07Nr/d6xHFvTtFCXHOyZVzkN3CzU6SECxp21y9GYw1zESf
	 rbM/PQj8CaD7tOYlv2aAbItKzHrNNi4+7CDfiugm/9U5cDrrUAbY6ook7os77FXntH
	 qRq41SmTcC07g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] perf c2c: Free format list entries when
 c2c_hists__init() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616193033.10035-7-acme@kernel.org>
References: <20260616193033.10035-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 19:54:58 +0000
Message-Id: <20260616195458.84D051F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] perf_hpp__setup_output_field and perf_hpp__append_sort_keys corrup=
t the global perf_hpp_list when passed a local list.
--

commit 22c7f5ad675216ec0ff17ec1087b36169d928283
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf c2c: Free format list entries when c2c_hists__init() fails

When c2c_hists__init() fails partway through hpp_list__parse(),
dynamically allocated format structures that were already added to
hists->list are leaked because he__get_c2c_hists() frees the hists
container without first unregistering the format entries.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 07c7e8fb315e6..eabb922ef295e 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -226,6 +226,7 @@ he__get_c2c_hists(struct hist_entry *he,
> =20
>  	ret =3D c2c_hists__init(hists, sort, nr_header_lines, env);
>  	if (ret) {
> +		perf_hpp__reset_output_field(&hists->list);

[Severity: High]
This is a pre-existing issue, but it looks like c2c_hists__init() triggers a
state corruption.

When c2c_hists__init() initializes the local &hists->list, does it call
perf_hpp__setup_output_field() and perf_hpp__append_sort_keys() which then
mutate the global perf_hpp_list instead of the passed local list?

Looking at tools/perf/util/hist.h:

static inline void perf_hpp__column_register(struct perf_hpp_fmt *format)
{
	perf_hpp_list__column_register(&perf_hpp_list, format);
}

When perf_hpp__setup_output_field() in tools/perf/ui/hist.c loops over the
provided local list's sort keys, it incorrectly triggers registration into =
the
global list via perf_hpp__column_register().

Similarly, perf_hpp__append_sort_keys() in tools/perf/ui/hist.c calls
perf_hpp__register_sort_field(), which also hardcodes insertion into the gl=
obal
&perf_hpp_list.sorts.

Does this mean dynamically allocated format structures from potentially tho=
usands
of local cachelines are erroneously appended to the global UI format list
instead of the local list?

>  		c2c_he->hists =3D NULL;
>  		free(hists);
>  		return NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616193033.1003=
5-1-acme@kernel.org?part=3D6
