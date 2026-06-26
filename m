Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07998362130
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jun 2026 07:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782458036; cv=none; b=P2emkW95PNXPOwO88vm66riVwnMQmBCqmEYL+YuA39md/S0q1TKguSam7YXhN+UG6nYMH8eH6DzQJq5yLcnxQqYHrtX1GkRzboQigwUZ4l+iZ1XaKEFK9EIDf+LzzJZMIkRyVf376Z8towALVCPCLFIQay3rdV9avy2TL1TBmls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782458036; c=relaxed/simple;
	bh=z2Wvh6fSVJlD5kRwsiEyvbicptmQWKkDMz34bhM3hbA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oILbBd7RH23KizXnY3S2AlaAZ/Dc5gtyPzreamota2IxwKngCG9ks6INrc4pvtwrvlYXs+sKlZi2uduloz+f+XKLavCFI+A95bfn+RYRElct2zAP5RZb9nga0ZAP+RvbTNdQATEv516z4wbz0ZaL9A3y1XMD8ClUdq045+B0OFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeSAixv0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeSAixv0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3931C1F000E9;
	Fri, 26 Jun 2026 07:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782458033;
	bh=/P76opxal01Y/GuKuRHJbwC1oJA84JnKjiCktEym7Ng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UeSAixv0coiZAQ3VDTxiQkfy9e9dEfVJ/1pB+HMzKsbeIAnbtCTyqWtTJ9jpP8vih
	 5WLYYbM+5tyQM9f1+uSk0odcZyxA9kPqtZfGPLOkqJmphRzmvA5LzItzDF2fjI/Hd/
	 s81OKdgYwVBNzsCsluEW67vAT5KmhEF63OKIb5gl0CzKPE5PF4ZSuaGLAUux61ntJ4
	 x8cB3RsMyVvgHDz8yBGrkJHwn8pIOHxR/NtZ0UH9eR4iEl9Tnsumq+CIMf058IaoTZ
	 zAzTWT2nOg6S53/sovRlUhq8tb/NpvXrFCJawUr89JxNyc63iEWVEoUf6BaAViOriP
	 ZzH+dZRPTt/wA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/14] perf c2c: extract shared data structures into
 c2c.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260626070355.1556721-2-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
 <20260626070355.1556721-2-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 07:13:52 +0000
Message-Id: <20260626071353.3931C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Missing feature fallback inline stubs for SLANG-dependent functi=
ons in header.
- [Medium] Asymmetric memory management API leading to potential resource l=
eaks.
- [Medium] Global namespace pollution with generic function names.
--

commit e451cf21befaafcbe2925718151023dd5ccba2cc
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: extract shared data structures into c2c.h

This patch moves c2c_hists, compute_stats, c2c_hist_entry, and perf_c2c
structure definitions from builtin-c2c.c into a new shared header c2c.h.
This allows the upcoming function view browser to reuse these types.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index c9584dbedf77a..33271554e354b 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
[ ... ]
> @@ -141,9 +76,9 @@ static const struct option c2c_options[] =3D {
>  	OPT_END()
>  };
> =20
> -static struct perf_c2c c2c;
> +struct perf_c2c c2c;
> =20
> -static void *c2c_he_zalloc(size_t size)
> +void *c2c_he_zalloc(size_t size)
>  {
>  	struct c2c_hist_entry *c2c_he;

[Severity: Medium]
By exporting c2c_he_zalloc(), is there a risk of memory leaks since a
corresponding free function is not exported?

Looking at the rest of c2c_he_zalloc() in builtin-c2c.c, it allocates sever=
al
sub-structures:

    c2c_he->cpuset =3D bitmap_zalloc(c2c.cpus_cnt);
    ...
    c2c_he->nodeset =3D bitmap_zalloc(c2c.nodes_cnt);
    ...
    c2c_he->node_stats =3D calloc(c2c.nodes_cnt, sizeof(*c2c_he->node_stats=
));

Any external module (like the new function view) that uses this allocator
won't have an encapsulated way to clean these up, forcing manual duplication
of the teardown logic to avoid leaks.

[ ... ]
> @@ -1928,7 +1816,7 @@ static struct c2c_dimension *dimensions[] =3D {
>  	NULL,
>  };
> =20
> -static void fmt_free(struct perf_hpp_fmt *fmt)
> +void fmt_free(struct perf_hpp_fmt *fmt)
>  {
>  	struct c2c_fmt *c2c_fmt;
> =20
> @@ -1936,7 +1824,7 @@ static void fmt_free(struct perf_hpp_fmt *fmt)
>  	free(c2c_fmt);
>  }
> =20
> -static bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
> +bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)

[Severity: Medium]
Could the removal of the static keyword here lead to symbol collisions?

Since fmt_free() and fmt_equal() lack a subsystem prefix (like c2c_ or
perf_c2c_), exporting these generic names to the global namespace increases
the risk of collisions during static linking or Link-Time Optimization with
other perf tool objects.

> diff --git a/tools/perf/c2c.h b/tools/perf/c2c.h
> new file mode 100644
> index 0000000000000..3e974dd1d7ee6
> --- /dev/null
> +++ b/tools/perf/c2c.h
[ ... ]
> +#ifdef HAVE_SLANG_SUPPORT
> +int perf_c2c__browse_cacheline(struct hist_entry *he);
> +#endif

[Severity: Medium]
Should this header provide a fallback stub for perf_c2c__browse_cacheline()
when HAVE_SLANG_SUPPORT is not defined?

The perf subsystem build guidelines require header files to provide
compatible dummy inline stubs (e.g., returning -ENOTSUPP) when feature
defines are absent. Omitting the #else block here might lead to missing
functionality or build breakages on systems lacking SLANG.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626070355.1556=
721-1-jiebin.sun@intel.com?part=3D1
