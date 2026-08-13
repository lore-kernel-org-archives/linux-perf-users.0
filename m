Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6337B38D686
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 23:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786663787; cv=none; b=Tc+awG0jn9rJEYdZNlXGRhsEGyOqH5QW6wONOvuLUxb/FD9Nar3jI6CI82QFrleIoihoRUefyb2rjxRs6gDsnfbKieLozBP0G1U2sOniqXkq01N+K30dup1+hGF0w8slhmdR73kUQeOHpHFv5n9gSigRzNjSM+QNoLsDBCTbpaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786663787; c=relaxed/simple;
	bh=EimwxpZWCrMyHmuWID1qz5fHpS27DJsIcCFWuTGVJ1A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hERVlOqTWIBgPi5v5Rdzlp+PwiKpJmeSju5H2XHD6byUp/As1Bkqmg3ZyBRaI3uAjFSwdtL6f1u5ognrC5GM/EXrF/bf4VMEMtfqOhjS5cjB5X4PPshVgEq2zd/dnePYRLxp4nS3Ua35TgV5HTJd7UWcWaxiGJigqk4BYMopdgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgdwMsRe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgdwMsRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E801F00A3D;
	Thu, 13 Aug 2026 23:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786663786;
	bh=2JQIj9LL3/G8xImLidRcYuSV6008+A9PfiFsG184bvk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EgdwMsRe71gAxdfzrGxvYE5uAY1iXkicJe4XXaUh7Y5i29lwVLTO6MeWXlBL2l82F
	 GRISySGoXKa+lqv1BCDSprJjNjddmJX0ywZHdBmZsyImW9N/yGAENPDEU+HSSCnuT2
	 dvZ/G026XPl4SFM/BAUx7YntWZIcjl7WKUqEVevy4smYPczQeVTlZh09P/mMvi/OZR
	 Q9r1Ci/894mermZfwd1dI2dLxD8beODyB6CAXfBH5Twlx28bPSeS9orpBt+aUHW9zP
	 J5/gz1LRqSvCHz3bBfqOpkRLSOIUXs6iKNr1UtMtivfdB38pyUauAPLP2LnDaASy6t
	 4HOrZpC27D3/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/8] perf header: Properly warn/print when
 libtraceevent/libbpf support is missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260401161324.332356-4-irogers@google.com>
References: <20260401161324.332356-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:29:45 +0000
Message-Id: <20260813232946.08E801F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Returning -1 for unsupported features in `process_*` callbacks cau=
ses `perf_header__process_sections()` to abort prematurely, silently skippi=
ng all subsequent header features.
- [Medium] `perf record` unconditionally prints errors for BPF features whe=
n compiled without `libbpf`.
--

--- Patch [3]: [PATCH v4 3/8] perf header: Properly warn/print when libtrac=
eevent/libbpf support is missing ---
commit e5ac8f49aacee07fccb1639de8607d4e1627acf5
Author: Ian Rogers <irogers@google.com>

perf header: Properly warn/print when libtraceevent/libbpf support is missi=
ng

By removing the features from feat_ops with ifdefs the previous logic
would print "# (null)" when perf processed a feature that lacked
builtin support. Remove the ifdefs from feat_ops and in the relevant
functions print errors/messages about the lack of support.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
> -#ifdef HAVE_LIBBPF_SUPPORT
> -static int write_bpf_prog_info(struct feat_fd *ff,
> +static int write_bpf_prog_info(struct feat_fd *ff  __maybe_unused,
>  			       struct evlist *evlist __maybe_unused)
>  {
> +#ifdef HAVE_LIBBPF_SUPPORT
>  	struct perf_env *env =3D &ff->ph->env;
>  	struct rb_root *root;
>  	struct rb_node *next;
[ ... ]
> @@ -1067,11 +1070,16 @@ static int write_bpf_prog_info(struct feat_fd *ff,
>  out:
>  	up_read(&env->bpf_progs.lock);
>  	return ret;
> +#else
> +	pr_err("ERROR: Trying to write bpf_prog_info without libbpf support.\n"=
);
> +	return -1;
> +#endif // HAVE_LIBBPF_SUPPORT
>  }

[Severity: Medium]
Will this cause spurious error messages and failures on every invocation of
perf record when compiled without libbpf?

Previously, when HAVE_LIBBPF_SUPPORT was absent, the feature was missing fr=
om
feat_ops and silently skipped. Because record__init_features() unconditiona=
lly
sets HEADER_BPF_PROG_INFO, won't perf_header__adds_write() now call this
function, print the error, and return -1 on every run?

[ ... ]
> -static int write_bpf_btf(struct feat_fd *ff,
> +static int write_bpf_btf(struct feat_fd *ff __maybe_unused,
>  			 struct evlist *evlist __maybe_unused)
>  {
> +#ifdef HAVE_LIBBPF_SUPPORT
>  	struct perf_env *env =3D &ff->ph->env;
>  	struct rb_root *root;
>  	struct rb_node *next;
[ ... ]
> @@ -1100,8 +1108,11 @@ static int write_bpf_btf(struct feat_fd *ff,
>  out:
>  	up_read(&env->bpf_progs.lock);
>  	return ret;
> -}
> +#else
> +	pr_err("ERROR: Trying to write btf data without libbpf support.\n");
> +	return -1;
>  #endif // HAVE_LIBBPF_SUPPORT
> +}

[Severity: Medium]
Similar to the issue above, won't this unconditionally print an error and
fail perf record if libbpf is not supported, since HEADER_BPF_BTF is also
unconditionally set in record__init_features()?

[ ... ]
> -#ifdef HAVE_LIBTRACEEVENT
> -static int process_tracing_data(struct feat_fd *ff, void *data)
> +static int process_tracing_data(struct feat_fd *ff __maybe_unused, void =
*data __maybe_unused)
>  {
> +#ifdef HAVE_LIBTRACEEVENT
>  	ssize_t ret =3D trace_report(ff->fd, data, false);
> =20
>  	return ret < 0 ? -1 : 0;
> -}
> +#else
> +	pr_err("ERROR: Trying to read tracing data without libtraceevent suppor=
t.\n");
> +	return -1;
>  #endif
> +}

[Severity: High]
Does returning -1 here cause perf_header__process_sections() to abort
prematurely and silently skip all remaining header features?

When processing features, perf_header__process_sections() iterates over the
added features:

    for_each_set_bit(feat, header->adds_features, HEADER_LAST_FEATURE) {
        err =3D process(sec++, header, feat, fd, data);
        if (err < 0)
            goto out_free;
    }

If perf encounters a perf.data file containing HEADER_TRACING_DATA but lacks
libtraceevent support, it looks like it will break out of the loop and skip
any features that appear after it in the bitmask (such as COMPRESSED or
CPU_PMU_CAPS), which could cause downstream failures like missing
decompression metadata.

Should this return 0 instead of -1 so that processing can continue?

[ ... ]
> -#ifdef HAVE_LIBBPF_SUPPORT
> -static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_=
unused)
> +static int process_bpf_prog_info(struct feat_fd *ff __maybe_unused, void=
 *data __maybe_unused)
>  {
> +#ifdef HAVE_LIBBPF_SUPPORT
>  	struct bpf_prog_info_node *info_node;
>  	struct perf_env *env =3D &ff->ph->env;
>  	struct perf_bpil *info_linear;
[ ... ]
> @@ -3402,10 +3422,15 @@ static int process_bpf_prog_info(struct feat_fd *=
ff, void *data __maybe_unused)
>  	free(info_node);
>  	up_write(&env->bpf_progs.lock);
>  	return err;
> +#else
> +	pr_err("ERROR: Trying to read bpf_prog_info without libbpf support.\n");
> +	return -1;
> +#endif // HAVE_LIBBPF_SUPPORT
>  }

[Severity: High]
Like process_tracing_data() above, won't returning -1 here abort
perf_header__process_sections() and skip the rest of the features in the fi=
le
if libbpf is not supported?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260401161324.3323=
56-1-irogers@google.com?part=3D3
