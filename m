Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3976A485518
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Aug 2026 19:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785870950; cv=none; b=QlNpp2QtphqBRtHhJJlSxhQBEA4hr/EXpbapOI/m769XSl0pkIcviYYyY8rzSLB8Z7WcaP0hR9WSuzQDszu9ACEOu8+BBFVHog3sckyglUsVefb/WBLxyVDsrVXdmWxLPqNrS76L27z7scwxJRXOm/1Ebtovho9LzwucnrMliiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785870950; c=relaxed/simple;
	bh=5DV0Dar+4BO8isUZYbYKZ9TZ+KrEi7fIk5jmC0H3Bh4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JzNKsGLSO9BYgsQA4rb94wkNAVKL/rTFOhOyRPz0j5h2jRu2amhhmGVHcEqZEMNOmpFXHRSh6rzhYxxj6fojC0DK7SH8Jad8iJ/7Gr74J8CstPNyVTH2gn9rYeUuZ2N9G0Ivr6I2c830tMqJ54ju/P9OwiMSvfFJ+9RMbzhzAz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TA738Loh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TA738Loh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36471F000E9;
	Tue,  4 Aug 2026 19:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785870949;
	bh=gQtBuY9MNK//mZ73Flkzlp4GJihRy3shYFBnrckPt/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TA738LohIzQ/JbuHOWA/CppCN3WlpueN8hZ/uYCGDFpb4ho8Zx/eX7T3Te4uxycUk
	 vM/lI8Ky+njfKizlNwZW4EWU+vLjP94yU0yEes1RXzd7bESaKTIoZfAOpMKi9OO9+r
	 awf7YdTNwBva5lUqanZZA2XzQ7b4G70JFuYUNOcBDnhXaU3/t23sktd9XNtvfvT2VY
	 8CNgOJcykJ1odn/R+N/mesDexcDb8tNifycQ+2CwaE8+J2Q2de/8IpOxvghMPPzQIF
	 nzwavfJq9F0AOuqIzuKsF9lu1iY5uWHt9PMYCzih1RrLYQctpXJJ2+pMzh7iWplKKn
	 /y4xe3jInQFGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf c2c: Clean up registered formats on
 c2c_hists__init() and c2c_hists__reinit() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260804185830.228763-3-acme@kernel.org>
References: <20260804185830.228763-1-acme@kernel.org>
 <20260804185830.228763-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 19:15:48 +0000
Message-Id: <20260804191548.E36471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] print_pareto() calls hpp_list__parse() on a local stack variable=
 but never cleans it up, leaking dynamically allocated formats.
- [Medium] kvm_hists__init() and kvm_hists__reinit() suffer from identical =
partial-registration leaks when format parsing fails.
--

--- Patch [2]: [PATCH 2/2] perf c2c: Clean up registered formats on c2c_his=
ts__init() and c2c_hists__reinit() failure ---
commit 92165e1ae89bef5baeedb3dd8908e10cf564714e
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf c2c: Clean up registered formats on c2c_hists__init() and c2c_hists__r=
einit() failure

When c2c_hists__init() or c2c_hists__reinit() calls hpp_list__parse()
and it fails partway through, format structures registered are left on
the hpp_list. This commit adds cleanup inside both functions to protect
all callers from leaking partially registered entries.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 160b82694d391..1856cccbee278 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c

[ ... ]

> @@ -2167,8 +2175,16 @@ static int c2c_hists__reinit(struct c2c_hists *c2c=
_hists,
>  			     const char *sort,
>  			     struct perf_env *env)
>  {
> +	int ret;
> +
>  	perf_hpp__reset_output_field(&c2c_hists->list);
> -	return hpp_list__parse(&c2c_hists->list, output, sort, env);
> +	ret =3D hpp_list__parse(&c2c_hists->list, output, sort, env);
> +
> +	/* Unregister any formats added before the failure point */
> +	if (ret)
> +		perf_hpp__reset_output_field(&c2c_hists->list);
> +
> +	return ret;
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but I noticed that print_pareto()
in the same file calls hpp_list__parse() on a local stack variable:

tools/perf/builtin-c2c.c:print_pareto() {
    ...
    ret =3D hpp_list__parse(&hpp_list, cl_output, /*evlist=3D*/NULL, env);
    ...
}

Because print_pareto() returns without ever calling=20
perf_hpp__reset_output_field(), does it leak all allocated c2c_fmt structur=
es=20
on both the success and failure paths?

[Severity: Medium]
This is a pre-existing issue, but kvm_hists__init() and kvm_hists__reinit()=
 in
tools/perf/builtin-kvm.c seem to suffer from identical partial-registration
leaks when format parsing fails:

tools/perf/builtin-kvm.c:kvm_hists__init() {
    ...
    return kvm_hpp_list__parse(&kvm_hists.list, NULL, "ev_name");
}

tools/perf/builtin-kvm.c:kvm_hists__reinit() {
    ...
    return kvm_hpp_list__parse(&kvm_hists.list, output, sort);
}

If parsing fails partway through these functions, will partially allocated
formats remain in the global list without cleanup, replicating the exact le=
ak
pattern fixed here in c2c?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804185830.2287=
63-1-acme@kernel.org?part=3D2
