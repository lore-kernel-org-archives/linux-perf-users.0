Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50013451056
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625852; cv=none; b=hbTwr7bqWAu7+bCnNKXEJEXjvGmJiWRBPuhUvzzTQj8V4hVIEc+9Mpa+iegeAfTHLiLzDKf1yLTM5HI+68sxxz2dDyaX7pcKrZjBrwjWLS8JeYax16kw72hheUkV9bQfOOrDinfP5GSIcc9t2Ux39kjoDi0WMt5SGRVyp796VUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625852; c=relaxed/simple;
	bh=OsHfuspGzhHzpGXLFd26z8abVl9BZTaqxn7MuLETnEo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TUu/z6zjBQJ6QrX++CUsaanuPk6xfl3DfihJeXUxxtTRj4pZQCfNqLIs4Y40oJX3YhpWWCKmg01XCwB3mKKjkD5Vu5H9KJNXD2sgGRss8gjHZ37QK2xA8VHgybOz5kBejZjFWjA0MZP28DDplAGoojfZTLWA8jGSkgbQ85o7saQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxW+z19q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxW+z19q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B3E1F00A3A;
	Tue, 16 Jun 2026 16:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625851;
	bh=74CXglTdgipKnbZ2wDF+yfeKlujw7yK/kFS1Ehq2UhE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lxW+z19qN2Tzmphr/5qyLB9sqJIOs5R/Ilk51SMDKVWA5Nb270UvrykNv0SeNrAft
	 4vsCe7UwNW99kkeksSjo82evamZKHZeRl01Hsi8fPSRFNiyxHk7SlpYqqt6Ef3evjR
	 /IpEwUB5lmAOtgGDHe/5wFOhrCQCNtH5p11I+2Fwbb/CQ2o1eeXKieNj9vbh9vhlLK
	 /LVMUVXZt/6KFERw9fu3YA/+MOayWFsxea0ZSvvHwmL1p7Co3I1edsxs+pFwEJ8BCy
	 hxhL88lHkVVTNSJEauTO5yrOx5bkdurob/y80CKSlpa7CLKRMAYiVNsQZXOB88DPw5
	 w33JarPVWKfJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] perf c2c: Free format list entries when
 c2c_hists__init() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616153920.6852-7-acme@kernel.org>
References: <20260616153920.6852-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 16:04:10 +0000
Message-Id: <20260616160411.04B3E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `PARSE_LIST` macro and `hpp_list__parse()` silently mask and o=
verwrite parsing and memory allocation errors.
- [High] Silent failure on `strdup()` memory allocation failures in `hpp_li=
st__parse()`.
- [High] `perf c2c` lacks `.feature` and `.build_id` callbacks in `struct p=
erf_tool`, breaking pipe mode.
- [High] `perf_hpp__setup_output_field` unconditionally adds sort fields to=
 the global `perf_hpp_list`.
--

commit 60f91534e79bfc7b6b6e9bfb14eaa60cfbd02be4
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

[Severity: High]
This isn't a bug introduced by this patch, but looking at how
c2c_hists__init() calls hpp_list__parse(), it seems parsing and memory
allocation failures can be silently masked.

Inside hpp_list__parse(), PARSE_LIST() initializes ret =3D 0. When it is
invoked sequentially:

    PARSE_LIST(output, c2c_hists__init_output);
    PARSE_LIST(sort,   c2c_hists__init_sort);

If the first macro fails (e.g., returning -EINVAL), the second macro
invocation overwrites the error code. Additionally, the macro's loop only
breaks on -EINVAL or -ESRCH, failing to catch -ENOMEM. Could this result
in hpp_list__parse() returning success even when field initialization
fails?

[Severity: High]
This is a pre-existing issue, but I noticed another potential problem inside
hpp_list__parse() during memory allocation:

    char *output =3D output_ ? strdup(output_) : NULL;
    char *sort   =3D sort_   ? strdup(sort_) : NULL;

If strdup() fails due to OOM, it returns NULL. The code doesn't check
for NULL before passing it to PARSE_LIST(), which then evaluates
if (!_list) break; and exits with ret =3D 0. Does this cause the function
to silently set up empty dimension lists and report success rather than
propagating -ENOMEM?

[Severity: High]
This is also a pre-existing issue, but when c2c_hists__init() sets up
the output fields, there might be a use-after-free risk related to the
global list.

In perf_hpp__setup_output_field(), when adding a new field, it calls:

    perf_hpp__column_register(fmt);

This wrapper unconditionally targets the global perf_hpp_list:

    perf_hpp_list__column_register(&perf_hpp_list, format);

Since hists->list is a dynamically allocated local list, does this end
up polluting the global list with local format pointers that might later
be freed on error paths?

>  	if (ret) {
> +		perf_hpp__reset_output_field(&hists->list);
>  		c2c_he->hists =3D NULL;
>  		free(hists);
>  		return NULL;

[Severity: High]
This is a pre-existing issue, but while looking at perf c2c tool
initialization in cmd_c2c(), I noticed it lacks .feature and .build_id
callbacks.

    perf_tool__init(&c2c.tool, /*ordered_events=3D*/true);
    c2c.tool.sample =3D process_sample_event;

In pipe mode, system features like NUMA nodes are synthesized into
PERF_RECORD_HEADER_FEATURE events. Because the feature callback is
missing, perf_env isn't populated.

Later, setup_nodes() checks:

    n =3D env->numa_nodes;
    if (!n)
        return -EINVAL;

Does the missing feature callback cause piped inputs and cross-analysis
to completely fail by leaving env->numa_nodes as 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616153920.6852=
-1-acme@kernel.org?part=3D6
