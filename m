Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308843BD224
	for <linux-perf-users@vger.kernel.org>; Sun,  2 Aug 2026 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785682654; cv=none; b=egy5u7KyX02AFt/H7bQfiEbvbFScGGS1XVeP2gCi+w4QS5kZC3nMeMtUTKknC8So79W+/BVRt6J7vsfksyPpp0OLdRdJzjWsPaVC8okAb69JDlHRAcnmT+KwKW9UI3v6D3rdIINrZt89LBJkMWiFvMpJHWpMDpckaJpxIgjIs8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785682654; c=relaxed/simple;
	bh=QSGEqyGTdhD/X4eMea122bh8yWGSWxs8G3Z7lVq1NkI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XrMdq8WkYjh5e0UqOL72qXyJ7UWvQjjEFc1wvAnaqIz6Xw+GERa3ByO2zsWnp346YqXXM0QaADLgjUHh4Ew35Dfoon+o6ad8PLmAtrg9M3FnlT7J32mHF0AAvTOnv3jebQLFDFNsSHod2c+uWg7s1VfWms23AqWv51jFy2rnmyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZwtPqc3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZwtPqc3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCCF1F000E9;
	Sun,  2 Aug 2026 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785682652;
	bh=5zgz7vsM5MgefQUo9MWH96a22qM4mvuTWhlpD0/Yh/0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RZwtPqc37w7p2m4ngqrGtk2zl7o9BmYfGiYMw9dyvwgJcyiqLYAsucsCaP3AGiqiA
	 UUFxggEuTx0Q+POwqJCP1PwR1FTfL8dU/0+gIrmR4tB5sMJJk6Ztwjw4et7vbHEN54
	 kpv1+1cB/ZTYfpRljTsHGCuFoCzR5o8VaOnfw8wb3zQ6Lt9IZFwe/SQMYE5nstNicT
	 MC8kevjbBEF7OePjSrYEFBF3wZnqJr8bDOBpepGXPl+o/DaqKFspJusftXFNnDVrR9
	 0KbksTbqS6tSfUJr4FocG0/RTyOYgaqJBNcpBjfn79G83lKct680DDptiALUXO9zqN
	 yUNT9xuCyyCyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf c2c: Fix error masking and OOM handling in
 hpp_list__parse()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260802142313.154514-2-acme@kernel.org>
References: <20260802142313.154514-1-acme@kernel.org>
 <20260802142313.154514-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 14:57:32 +0000
Message-Id: <20260802145732.ABCCF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The patch introduces early exits in `hpp_list__parse` on parsing=
 errors, skipping the critical `perf_hpp__setup_output_field` initializatio=
n. Callers like `c2c_hists__reinit` ignore this error, causing histograms t=
o be rendered without necessary output fields.
- [Low] Missing explicit inclusion of `<string.h>` and `<stdlib.h>` for POS=
IX libc functions introduced by the patch.
--

--- Patch [1]: [PATCH 1/2] perf c2c: Fix error masking and OOM handling in =
hpp_list__parse() ---
commit 52205c976b0de26bcbb5609f521d63f4dbe4ebec
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf c2c: Fix error masking and OOM handling in hpp_list__parse()

This commit fixes error masking in hpp_list__parse() by checking strdup()
return values and preserving the first error across PARSE_LIST calls.
It prevents silently treating OOM failures as empty input.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index c9584dbedf77a..332d360ca5334 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c

[ ... ]

> @@ -2093,8 +2093,18 @@ static int hpp_list__parse(struct perf_hpp_list *h=
pp_list,
>  	char *sort   =3D sort_   ? strdup(sort_) : NULL;

[Severity: Low]
Does this file need explicit inclusions for string.h and stdlib.h?

The perf subsystem guidelines require standard POSIX inclusions for musl
compatibility when using functions like strdup() and free().

>  	int ret;
> =20
> +	/* strdup() returns NULL on OOM, don't silently treat as empty */
> +	if ((output_ && !output) || (sort_ && !sort)) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
>  	PARSE_LIST(output, c2c_hists__init_output);
> +	if (ret)
> +		goto out;
>  	PARSE_LIST(sort,   c2c_hists__init_sort);
> +	if (ret)
> +		goto out;
> =20
>  	/* copy sort keys to output fields */
>  	perf_hpp__setup_output_field(hpp_list);

[Severity: Medium]
Does skipping perf_hpp__setup_output_field() leave the output fields list
uninitialized when an error occurs?

Callers of hpp_list__parse(), such as resort_cl_cb() and perf_c2c__report(),
appear to ignore its return value. For example:

tools/perf/builtin-c2c.c:resort_cl_cb() {
    ...
    c2c_hists__reinit(c2c_hists, c2c.cl_output, c2c.cl_resort, env);
    ...
}

tools/perf/builtin-c2c.c:perf_c2c__report() {
    ...
    c2c_hists__reinit(&c2c.hists, output_str, sort_str,=20
                      perf_session__env(session));
    ...
}

If an error is returned due to invalid keys or OOM, the callers proceed with
a broken state, which could lead to rendered histograms without necessary=20
output fields.

[ ... ]

> @@ -2111,6 +2121,7 @@ static int hpp_list__parse(struct perf_hpp_list *hp=
p_list,
>  	perf_hpp__append_sort_keys(&hists->list);
>  #endif
> =20
> +out:
>  	free(output);
>  	free(sort);
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802142313.1545=
14-1-acme@kernel.org?part=3D1
