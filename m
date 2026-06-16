Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA933370ACF
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573025; cv=none; b=dDJ+l6uL/5nCo32APlydqTmt4L+5LL+Lm9ziJheiMtnWzFwewrUzhPdvDdCUIUgY7vSXaJmtfdfdeHcsSrAvWHh8O5l7CQ2oJUDV33C1kHGCgTiCt2S7/cb1IXXp1wX+xOLdraDsI0Ag0+MuzAX3rnaR12myKv+KA4x3lq96V/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573025; c=relaxed/simple;
	bh=TsZzZah5GpmqcCV3EaLNnp/bEKdMHpCyyEY9CFQ6BzE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I4J0R+SsbcMASxzMtK5hnTRZwnI/eKAN0Y2K7uZHQpl1WAwXYZDbGImqvzjQ2bGMWjwlJphWvQE5VsHC8xSWEy+jPwm7nCa05Mv1e+J4mmGssV8A9HN86kdhIGu6ie21d4+m2oq1vUnxtoOtEP2H+L5ainso9Acyy45po8sdyx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxGyoYWR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxGyoYWR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE4B1F00A3A;
	Tue, 16 Jun 2026 01:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781573024;
	bh=vXhL1YGHyH1eGl5owuIpRGCs9AzUDfUbaYV0eBK3WHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dxGyoYWRW3SKZPqEWj/SAY3YRa7Ps5HNvqxGJRx8v3wqkAIHLrW8yEHh8OxelRWCa
	 1L25VuMVjdYm03nzKtBJoXk/oPw4sXz3g8A1/j6iLvDQpxh3ng3bQPRa9mIZvJY6rR
	 YyprIH8Y1fyZIkMMsWOoq9sXGVIwveC9PHwYbmQrSBwocHO/LoDJzO8gTf/a/D4NZg
	 o6IfbQOGy/DkqqPp9AIpXM6sFlQfVXOYCjGJWc9LYfWkyqZaS9r/Hkyezp0ywV2Ot8
	 eWOh9txhLyadLnRpT9Lp1R4dZM7siaQofibb5Yuder3b39sNdVkmzUU4ePknHCKVek
	 hxO6SNdwD/tDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] perf c2c: Free format list entries when
 c2c_hists__init() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616010834.37618-7-acme@kernel.org>
References: <20260616010834.37618-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:23:43 +0000
Message-Id: <20260616012343.BDE4B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] perf_hpp__setup_output_field() unconditionally appends missing sor=
t keys to the global perf_hpp_list instead of the provided local list.
- [Medium] Error return from PARSE_LIST(output, ...) is silently overwritte=
n by PARSE_LIST(sort, ...) in hpp_list__parse().
- [Medium] Out-of-memory failures during string duplication are silently ma=
sked as empty inputs in hpp_list__parse() and kvm_hpp_list__parse().
--

commit 82a61a9eafaa1d6dd28dc01f46106f2ec1acc81e
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
perf c2c: Free format list entries when c2c_hists__init() fails

This commit fixes a memory leak in the error path of he__get_c2c_hists(). It
ensures that dynamically allocated format structures are correctly cleaned =
up by
calling perf_hpp__reset_output_field() before freeing the hists container.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 07c7e8fb315e6..eabb922ef295e 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -226,6 +226,7 @@ he__get_c2c_hists(struct hist_entry *he,
> =20
>  	ret =3D c2c_hists__init(hists, sort, nr_header_lines, env);

[Severity: Medium]
This is a pre-existing issue, but I noticed something when looking at
c2c_hists__init() -> hpp_list__parse().

When an invalid --fields key is provided, the first PARSE_LIST(output, ...)
macro correctly sets ret to an error code and breaks its internal loop.

However, the subsequent PARSE_LIST(sort, ...) macro invocation immediately
resets ret =3D 0:

tools/perf/builtin-c2c.c:hpp_list__parse() {
    ...
    PARSE_LIST(output, c2c_hists__init_output);
    PARSE_LIST(sort,   c2c_hists__init_sort);
    ...
}

Does this silently swallow the error from the output parsing, returning
success and allowing execution to proceed with an invalid configuration?

[Severity: Medium]
This isn't a bug introduced by this patch, but while reviewing the parsing
logic in hpp_list__parse() and kvm_hpp_list__parse(), I noticed how strdup()
failures are handled.

If strdup() fails due to memory exhaustion, the resulting variables become =
NULL:

tools/perf/builtin-c2c.c:hpp_list__parse() {
    char *output =3D output_ ? strdup(output_) : NULL;
    char *sort   =3D sort_   ? strdup(sort_) : NULL;
    ...
    PARSE_LIST(output, c2c_hists__init_output);
}

Since PARSE_LIST short-circuits a NULL list to success (0), does this mask
out-of-memory failures as empty inputs, skipping configuration entirely
instead of properly aborting?

[Severity: High]
This is a pre-existing issue, but looking deeper into the initialization
path, perf_hpp__setup_output_field() seems to append missing sort keys
to the wrong list.

The function iterates over the local list->sorts, but then calls
perf_hpp__column_register(fmt):

tools/perf/ui/hist.c:perf_hpp__setup_output_field() {
    perf_hpp_list__for_each_sort_list(list, fmt) {
        ...
        perf_hpp__column_register(fmt);
next:
        continue;
    }
}

This inline wrapper explicitly targets the global perf_hpp_list:

tools/perf/util/hist.h:perf_hpp__column_register() {
    perf_hpp_list__column_register(&perf_hpp_list, format);
}

Could this pollute the global list with pointers to dynamically allocated
format structures owned by the local c2c_hists or kvm_hists?

If so, does this lead to use-after-free vulnerabilities for concurrent
global list accessors when the local list is destroyed?

>  	if (ret) {
> +		perf_hpp__reset_output_field(&hists->list);
>  		c2c_he->hists =3D NULL;
>  		free(hists);
>  		return NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616010834.3761=
8-1-acme@kernel.org?part=3D6
