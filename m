Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22465191F98
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 20:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780692376; cv=none; b=nOqxs/SHUDi9B5+iKSVMEWBizQtHsRJjYQrxPsKg8XJU33B4y1ZqAm+gDsSJlpBH/JO9e0m3HTxE1QOFs/HgmYrjtGg/c2PZucl+Mhzfv87NI642TaLwEGk5blhEWuuY0YrC7fX8xSwjZgpgoyBrym+aGyftQgvHGh1sSlTWvOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780692376; c=relaxed/simple;
	bh=JBhdftWugT3B651heR7j4M6J0Fu6JyhmOkOpnVMcEJY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IvfdCuEz1BBdesQEd3Pt4nzNE0Um2u557MRwOYkqEFc3xpRz2GoF5lvB6yYs24kMHGYcvj5SM5/L6kvsRdG0rqEFeY9G5FA/6m0lNal/jEtzmmq9w95OSIbZRg4sZ2DYZuEsFoMqc3R+9DhWRx/sVTbVwFCLYU+Ne+gJncBjjnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxLsp9CM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxLsp9CM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02FA1F00893;
	Fri,  5 Jun 2026 20:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780692374;
	bh=1LHOOm6wd1JbqYsHGYl/fqt4r8JEj8OcJtEfcgbpBnA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PxLsp9CMBKRQdhYtyUvugz1JxD6JY0sI7koAlG8kVH9EqbHZGc+0UTG5i3luNMe8f
	 XDVsS/SCDjKVHsvv8DOq0SsPpjGsXW02Qb/AdGBNIwyjc5fXWLmqjvuE7hO4NXGzwz
	 uDDDt39PoIvnMy+YsmUYwFw5aLFydHIB8LgdiWRUGWhYZNusugo0XSse9ntUQjcPrG
	 irgukUweKlqBCK75XMt9IjMjDXnhdsCkDZZGN9AZsRGoDN2l0XXru9D+lYmFH5dhqQ
	 smh5JfGq00/aY/Hek/jtkLp1t0syCToDgddmuRGN+d3VWTGksO9g6JbLMCBIsrdX0F
	 amjrBQO6GZW9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] perf c2c: Bounds-check CPU and node IDs before
 bitmap and array access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605203316.1758661-4-acme@kernel.org>
References: <20260605203316.1758661-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 20:46:14 +0000
Message-Id: <20260605204614.A02FA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The bounds check for `cpu` uses signed comparison, allowing negati=
ve indices to bypass the check and cause an out-of-bounds read on `c2c.cpu2=
node`.
- [High] Dangling pointer in `he__get_c2c_hists()` error path leads to Use-=
After-Free and Double Free.
--

commit e95c9ca109b5c13c67d968858ca1ace26fe8c4c9
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf c2c: Bounds-check CPU and node IDs before bitmap and array access

This commit adds bounds checks for CPU and node IDs before accessing bitmaps
and arrays in builtin-c2c.c. These checks help ensure that a crafted
perf.data file with exceedingly large IDs cannot cause out-of-bounds heap
writes.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
[ ... ]
> @@ -386,7 +394,12 @@ static int process_sample_event(const struct perf_to=
ol *tool __maybe_unused,
>  		 * Doing node stats only for single callchain data.
>  		 */
>  		int cpu =3D sample->cpu =3D=3D (unsigned int) -1 ? 0 : sample->cpu;
> -		int node =3D c2c.cpu2node[cpu];
> +		int node;
> +
> +		/* cpu2node[] has c2c.cpus_cnt entries from env->nr_cpus_avail */
> +		if (cpu >=3D c2c.cpus_cnt)
> +			cpu =3D 0;
> +		node =3D c2c.cpu2node[cpu];

[Severity: High]
This isn't a bug introduced by this patch, but does this bounds check
allow negative indices to bypass it?

Because cpu is declared as a signed int, if sample->cpu is a large value
like 0xFFFFFFFE, it converts to a negative integer (e.g., -2). The bounds
check uses signed comparison, so the negative value bypasses the check,
resulting in an out-of-bounds read at c2c.cpu2node[-2].

>  		c2c_hists =3D he__get_c2c_hists(he, c2c.cl_sort, 2, machine->env);

[Severity: High]
This is a pre-existing issue, but can he__get_c2c_hists() create a
dangling pointer on its error path?

Inside he__get_c2c_hists():

hists =3D c2c_he->hists =3D zalloc(sizeof(*hists));
if (!hists)
        return NULL;

ret =3D c2c_hists__init(hists, sort, nr_header_lines, env);
if (ret) {
        free(hists);
        return NULL;
}

If c2c_hists__init() fails, it frees hists but leaves the dangling pointer
in c2c_he->hists. Because c2c_he outlives the function execution, later
during shutdown, c2c_he_free() will access the dangling pointer and trigger
a use-after-free and double free.

>  		if (!c2c_hists) {
>  			ret =3D -ENOMEM;
>  			goto out;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605203316.1758=
661-1-acme@kernel.org?part=3D3
