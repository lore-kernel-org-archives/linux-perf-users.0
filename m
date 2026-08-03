Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812BE424D47
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781564; cv=none; b=R+rOn0J34Hfte08yMsZPQJN+XTNVx1WDRQjR0CfP17Y/ciDA+Ete7gdq82xFVzrPDHMFEV2POVLfWFNedfmuNiM3oHX0O9VtBGC5bK2AmceOM+lKJ2pKUWoT8bbdpepeJFFs6CDwaZA2XR4mj/qeEM3aHF646zcqyFwh1XUnP+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781564; c=relaxed/simple;
	bh=hJ8HIjHcaycEtBKjI9PCxt2iwAsL8F/JrGMv/n5wBNY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fiPfRPF59cLeXK8i+Up77ZWl78dEs9wy09rOeLqRVV9nYQN75pPowzzAVwVawtL0gnAko91TNDU00HMya+HrrWZREbQVYVhnGP71tepqh7RgzjfBM3OtS28Un6DJRFd7h26YtEILrO89Tr7302s0A2oJurlN7KK01ZRPjFyVDjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv5c+kJA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv5c+kJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FDF1F00A3A;
	Mon,  3 Aug 2026 18:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781563;
	bh=F1CFoO2S7mhCX4+bKYugbdbnI2nD3m/KRyO1TnwA6lg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fv5c+kJANrqTBDIByXmRNXlXPO0pGvwcrKcB7YZoGz2JLvOTdZJIDg1j7ZOPoBk9M
	 UAAOr/0UEem5+6riugdRjW01vPcca2QUDPxeXWggf2ahuN3XsOb8ArgcCClz8KcXsM
	 KMw7D/MK2Cjj3Ajn0wQB54k1r04daeoynkLViEopxZhvIBGNpqSR8mukSj/TIsBGeY
	 +FJoqVJ5tn0mWcH2gL8UJK1EK4scPtIKLGO15XwPX4uyqIdGNMpmbdtVu3oPs0h2Xf
	 vhIHJWuDjbHchll9Q26w9KyuFgzJ1FVOqGQLEgJKGaNS8yy9YLh6UD+aHrEy6QUzzX
	 fzCfNmMYODyqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf c2c: Fix error masking, OOM, and unchecked
 caller errors in hpp_list__parse()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803180703.194916-2-acme@kernel.org>
References: <20260803180703.194916-1-acme@kernel.org>
 <20260803180703.194916-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:26:01 +0000
Message-Id: <20260803182602.D5FDF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The string parsing loops in `setup_sort_list()` and `setup_outpu=
t_list()` silently ignore and overwrite memory allocation errors (-ENOMEM),=
 leading to partially initialized sort or output fields being treated as su=
ccessful.
--

--- Patch [1]: [PATCH 1/2] perf c2c: Fix error masking, OOM, and unchecked =
caller errors in hpp_list__parse() ---
commit eb21379d23b3ae985cd662b484d5da281ac1387b
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf c2c: Fix error masking, OOM, and unchecked caller errors in hpp_list__=
parse()

This commit fixes multiple issues in hpp_list__parse(), including error
masking during string parsing, unhandled strdup() OOM failures, and uncheck=
ed
function returns. It also updates underlying sort and output functions to
return -ENOMEM instead of -1 on allocation failures.

> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 005e7d85dc4a5..616a583e3d4d6 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
[ ... ]
> @@ -3882,8 +3889,7 @@ int sort_dimension__add(struct perf_hpp_list *list,=
 const char *tok,
>  		if (sort__mode !=3D SORT_MODE__MEMORY)
>  			return -EINVAL;
> =20
> -		__sort_dimension__add(sd, list, level);
> -		return 0;
> +		return __sort_dimension__add(sd, list, level);
>  	}
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(hpp_sort_dimensions); i++) {

[Severity: Medium]
This is a pre-existing issue, but by explicitly propagating -ENOMEM out of
sort_dimension__add() and output_field_add(), does this highlight a bug in
their callers?

In setup_sort_list() and setup_output_list(), the parsing loops only check
for -EINVAL and -ESRCH:

ret =3D sort_dimension__add(list, tok, evlist, env, level);
if (ret =3D=3D -EINVAL) {
	...
	break;
} else if (ret =3D=3D -ESRCH) {
	...
	break;
}

If sort_dimension__add() or output_field_add() returns -ENOMEM, the loop
continues without breaking, and a subsequent successful token will overwrite
the error. This can cause the perf tool to silently continue with a partial=
ly
configured state instead of aborting on memory allocation failure.

Should these loops be updated to catch other error codes like -ENOMEM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803180703.1949=
16-1-acme@kernel.org?part=3D1
