Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE152F39AB
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560493; cv=none; b=EVoN0hkBC7qYDDg0MJOH6o6MHY46NW3XJ8uKFrmhkrB//LFayJ3Pp51aSMFvTJa8MVEKIN6xA1lI8kNXACds2NQ+TeTTOgX+x7l5VAXQCBeKtHeS++SlVwssUDHxS1sPszPNd0s2x2n7UGVwcIKvYZGPnUCAPvgKjyzgqu9X9O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560493; c=relaxed/simple;
	bh=QjT4uDqBhRCcU1QIr2RFc/YzPU4dJZ7mHH4LWxbD0VU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EJbsmAt/oq6/AmlD7oIYWkYTzzetiYjil00OC0iHkj9COHCNdmVELvc4jx2yqOEK8e34Ys/Mn/Ul44WmHqmDW1HXXXS5HYjsBiOGNANowgSgddnIEI4s9d+vxDlc6NzKnJmiZVQG6UmLoMVC76lgNfpmPoEFVfdJBJ64cqu99G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bb3n6p1S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bb3n6p1S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5ED1F000E9;
	Mon, 15 Jun 2026 21:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781560491;
	bh=3RLSsNOn8fZs5UGfrFNqWtq2mJWIZyIoKj+CLnOTBjk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bb3n6p1SK1Y8a6yJk1oqcX3D3xkIoMrs2E9cEhxOph0spe9G5mzznC5Sn8mPNvRIU
	 gt9UHGJP53WTNtRsj4/b6QnKRDBnsk60UxVs7/ZXAFhFYQ7qpNhbh/ayczJ0CX0/dI
	 onQBoV1bCI0fbw6WUBPyfqdeVSDTLikR0Ww4ZwxSrRAplNsWx5Q1PbQkMIAbgfjfxF
	 ONSmDPBEXkVOW5r8c4TeWVmqA1cFzJXfl3z1KxXmL7Bw+7+Z+ZAT+q4dga9JKHGkF3
	 s8se6Vp6VWlNl4uyCl8kuNBtAgIj5szvDeqenDkZIKx4XKgdeMKpQwc3T8yXW7bI2v
	 vPI0LyKR//bbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] perf c2c: Free format list entries when
 c2c_hists__init() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615213657.35776-7-acme@kernel.org>
References: <20260615213657.35776-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 21:54:51 +0000
Message-Id: <20260615215451.9F5ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `perf_hpp__setup_output_field()` mistakenly appends format element=
s to the global `perf_hpp_list.fields` instead of the local `list->fields`,=
 leading to an unbounded accumulation of `c2c_fmt` structures.
- [Medium] `hpp_list__parse()` and the `PARSE_LIST` macro silently overwrit=
e and drop error return codes during format parsing.
--

commit f3900597f4c802568083103a6a640b3c7cb043fa
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf c2c: Free format list entries when c2c_hists__init() fails

This commit fixes a memory leak in the error path of he__get_c2c_hists().
It calls perf_hpp__reset_output_field() before freeing the hists container
when c2c_hists__init() fails, ensuring dynamically allocated format entries
are properly unregistered.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -226,6 +226,7 @@ he__get_c2c_hists(struct hist_entry *he,
> =20
>  	ret =3D c2c_hists__init(hists, sort, nr_header_lines, env);

[Severity: Medium]
This isn't a bug introduced by this patch, but does hpp_list__parse()
(called within c2c_hists__init()) silently drop error return codes?

Looking at the PARSE_LIST macro in tools/perf/builtin-c2c.c, it initializes
ret =3D 0 internally on every invocation:

#define PARSE_LIST(_list, _fn) \
    do { \
        char *tmp, *tok; \
        ret =3D 0;

In hpp_list__parse(), sequential macro invocations mean the first error
code can be discarded:

    PARSE_LIST(output, c2c_hists__init_output);
    PARSE_LIST(sort,   c2c_hists__init_sort);

If the output parsing encounters an error, it breaks out and correctly sets
ret, but the subsequent sort parsing invocation immediately resets ret =3D =
0.
Additionally, if strdup fails, it breaks but leaves ret =3D 0.

Could this cause allocation or parsing failures during c2c_hists__init()
to be silently ignored, returning success despite missing formatting?

[Severity: High]
This is a pre-existing issue, but is there an unbounded accumulation of
c2c_fmt structures occurring when he__get_c2c_hists() initializes
per-cacheline history lists?

When c2c_hists__init() sets up the local list, it eventually calls
perf_hpp__setup_output_field(). This function takes a local list parameter
but uses an inline wrapper that hardcodes the global list:

tools/perf/util/hist.h:perf_hpp__column_register() {
    perf_hpp_list__column_register(&perf_hpp_list, format);
}

Because perf_hpp__setup_output_field() in tools/perf/ui/hist.c uses this
global wrapper (perf_hpp__column_register(fmt)) instead of the local
variant, the format elements intended for each cacheline's local history
get appended to the global perf_hpp_list.fields.

Since perf c2c can process millions of cachelines, could this cause the
global list to endlessly accumulate dynamically allocated format elements?

>  	if (ret) {
> +		perf_hpp__reset_output_field(&hists->list);
>  		c2c_he->hists =3D NULL;
>  		free(hists);
>  		return NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615213657.3577=
6-1-acme@kernel.org?part=3D6
