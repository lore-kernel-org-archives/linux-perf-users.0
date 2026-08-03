Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F08346E67
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781787; cv=none; b=evkgyl56TCe43Y1kIi+8CgW5P3hzMLtSeNn4qvcSAgmGhbRfGeQgDrW+hE45EOBasG9imQ2X32Bf3vSWUyvnBS44H+jYeeKfxkcR4xcxRgGqHn4CJXwOcnJ8yCWONe5+Q+Og2Ugn23K4cE9nKY7VQQreJPcbpUq2EcGwNCBzpYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781787; c=relaxed/simple;
	bh=bEY1mAJCcwfxNIFfUw+bKN+23iF4HcMHJlhEDV4eDEY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J7AWss24RhZ+wpWqnprlzrLszF0KmCX9GALjpk3Lkl2kTLV27C52/KfxGPaZaq9tQvjBhukd6vZK9nyYOK3eTga9QUlO8Oa3K3F/sKZc9zQWOEE/+fIqdcdwR9IN77a0hqvifVANuLNHS/1ps/x0V+EO9gm3GdpuD6yWARW/gkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPudtfZV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPudtfZV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6921F1F000E9;
	Mon,  3 Aug 2026 18:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781785;
	bh=kijr/TF+cLFaqx1gvOFkrh9jteqlKnr1EmPzxLVXMSg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KPudtfZVyfit6ct87qabAWR4yq1KrxbSTr+kKbz6uqeqtwNHKpBevl2FvE7U+PI1O
	 twPBOkAqdHMJwpCKreddNupSWGc4UJLb1y1SHGke5AxCaRfiah2uy77MMaNh0nnIMX
	 10DXBwYw7diN/EzBR9f1kqmI6hUOIu8HINN8eyH8uNAQsTFe65o8u4mE6BKHd/klGL
	 lsCfsIWKQlWexunJBfz1ypHDr8+l+rQ+Y6CMqe/NtKajv9bz42ym2TqLXjwwURghm4
	 19dPjXwifk/1M0qjDs8ou+Z95eQ49WnifTsZKBYrZTUf2n/LzyNxIrDLJVDEDjfoXW
	 iNjueGaA/E64w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf c2c: Clean up registered formats on
 c2c_hists__init() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803180703.194916-3-acme@kernel.org>
References: <20260803180703.194916-1-acme@kernel.org>
 <20260803180703.194916-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:29:44 +0000
Message-Id: <20260803182945.6921F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] perf_hpp__setup_output_field() and perf_hpp__append_sort_keys() co=
rrupt the global perf_hpp_list and fail to populate the provided local list.
--

--- Patch [2]: [PATCH 2/2] perf c2c: Clean up registered formats on c2c_his=
ts__init() failure ---
commit 0cc1bae097f820bedd8cd5517b56916ee9c48ca3
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf c2c: Clean up registered formats on c2c_hists__init() failure

When c2c_hists__init() calls hpp_list__parse() and it fails partway through,
format structures registered are left on the hpp_list. This fix adds cleanup
inside c2c_hists__init() itself so all callers are protected.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 160b82694d391..a01fa1655569c 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c

[ ... ]

> @@ -2159,7 +2161,13 @@ static int c2c_hists__init(struct c2c_hists *hists,
>  	/* Overload number of header lines.*/
>  	hists->list.nr_header_lines =3D nr_header_lines;
> =20
> -	return hpp_list__parse(&hists->list, /*output=3D*/NULL, sort, env);
> +	ret =3D hpp_list__parse(&hists->list, /*output=3D*/NULL, sort, env);

[Severity: High]
This isn't a bug introduced by this patch, but will calling hpp_list__parse=
()
corrupt the global perf_hpp_list?

When c2c initializes its local hpp_list, hpp_list__parse() eventually leads
to calls to perf_hpp__setup_output_field() and perf_hpp__append_sort_keys()
in tools/perf/ui/hist.c. Both of these functions accept a local
struct perf_hpp_list *list parameter, but they appear to use the global list
wrappers instead of modifying the passed local list:

tools/perf/ui/hist.c:perf_hpp__setup_output_field() {
    ...
    perf_hpp__column_register(fmt);
    ...
}

tools/perf/ui/hist.c:perf_hpp__append_sort_keys() {
    ...
    perf_hpp__register_sort_field(fmt);
    ...
}

Could this cause the local lists to miss output columns, while also polluti=
ng
the global list with dangling pointers to dynamically allocated local forma=
ts?

Should these functions be updated to call
perf_hpp_list__column_register(list, fmt) and
perf_hpp_list__register_sort_field(list, fmt) instead?

> +
> +	/* Unregister any formats added before the failure point */
> +	if (ret)
> +		perf_hpp__reset_output_field(&hists->list);
> +
> +	return ret;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803180703.1949=
16-1-acme@kernel.org?part=3D2
