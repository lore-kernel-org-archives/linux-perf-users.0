Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FDC230BE9
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 03:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789270734; cv=none; b=Lh0i54mhNzRHrVLm9863Pmm9OPrIKaq1BNwbUdBw1XEvwtj4/+mhvjVYZzSjRqj9eYiGI5XWsoiYoXBb4B8xQQV/J4Wg45TjtH8gr1dCJS7vusTHTO5B95ZDZKxUedwHMrc6wDGa/9otb7Th1uTWSacp6T4Q+dA7uhwnNT5CeKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789270734; c=relaxed/simple;
	bh=0qsDpl9Wj+kpFuDnSqiK8rvFB0ZGXSyRQPBXr9SiX5A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P8/f5VJRAdf3HGwUeOxQdictyTfHPTc4+ckFwG1G/723Ghbi/HHlvMykX/4ukBUzkqYgK7YQJyn9an5+dW4+YJuB/TuUbbdH0Kk9Ppn8mYHlMF8AzPxL837dBJBJbax3RYVVch79TTGU1mvp1PbBqbhP38OIj2Sz7eKirjAN3Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRJcHeFb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRJcHeFb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09721F000FF;
	Sun, 13 Sep 2026 03:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789270732;
	bh=0kyZj/xC7DLFJSds0nTxsqfrl6lbmdnL/ZZN/pX8XVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TRJcHeFb/6fV3NudioiD5idkVEkRjnymAi5CGCljwPIHdgJAfAJEdUdBh3RK889fR
	 9+p5ewj8vaLsFWz5FI5LNSvS89c53gW1h5fGI2ryFntNKIg1D8DtK9WcvtrQXglD0v
	 pMELAR2zG2X/JBdYK6jzkhUGkVMmcLotfnSvgGzwW8ZpZR0R8YxFWCP4kc+2Wy0riA
	 24tiE3lu5vKwYS05BXHYFJk65Px0aKZq7jzvHMy71wnWCkD5MHf9QbfW0m70M9qLwG
	 PU+hctrkYTgJw28vVDwdSNoqAQMMDha5DI1qRGg/ZNSa7N33GdRM5Ok0Yqto+hD9ll
	 yfukFIv2kbe1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/8] perf annotate-data: Resolve type DIEs in the
 debug file they came from
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913032632.116277-8-acme@kernel.org>
References: <20260913032632.116277-1-acme@kernel.org>
 <20260913032632.116277-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 03:38:52 +0000
Message-Id: <20260913033852.B09721F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded recursion and iteration in DWARF member type chasers (`d=
ie_find_member` and `die_get_member_type`).
--

commit 2cb5592a12267288ad7685ab9363967d18e8063c
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: perf annotate-data: Resolve type DIEs in the debug file they came =
from

This commit resolves type DIE offsets in their correct debug file to prevent
an infinite loop in die_get_pointer_type(). It introduces bounded recursion
and iteration (MAX_TYPE_CHASE, MAX_MEMBER_DEPTH) to safely handle corrupted
or cyclic DWARF structures.

> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index d7160f87ac7d7..e35f724ea6835 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -266,16 +266,35 @@ Dwarf_Die *die_get_type(Dwarf_Die *vr_die, Dwarf_Di=
e *die_mem)
>  		return NULL;
>  }
> =20
> +/*
> + * The chases below cross typedefs and qualifiers to get to the type that
> + * is actually meant, and a DIE that is not what it looks like, e.g. one
> + * parsed at an offset that is not the start of a DIE in the file it was
> + * resolved in, can have a DW_AT_type that refers back to itself, which
> + * makes them spin forever: 'perf report -s type' did exactly that on the
> + * dwz compressed debug info of zlib-ng (libz.so.1), burning all of a CPU
> + * with no output while resolving a hist entry in build_tree().
> + *
> + * No sane chain is this long, so give up instead of hanging, telling ab=
out
> + * it so that the broken debug info can be looked at.
> + */
> +#define MAX_TYPE_CHASE 32
> +
>  /* Get a type die, but skip qualifiers */
>  Dwarf_Die *__die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)

[Severity: High]
This is a pre-existing issue, but since we are bounding DWARF chases here
to prevent hangs on cyclic structures, should die_get_member_type() also
have similar limits?

When processing broken DWARF info, if a nested structure's real type resolv=
es=20
back to itself without advancing the offset, this loop in die_get_member_ty=
pe()=20
can spin infinitely:

tools/perf/util/dwarf-aux.c:die_get_member_type() {
    ...
    while (tag =3D=3D DW_TAG_structure_type || tag =3D=3D DW_TAG_union_type=
) {
        member =3D die_find_child(&mb_type, __die_find_member_offset_cb,
                                (void *)(long)offset, die_mem);
    ...
}

Similarly, does __die_find_member_cb() require a recursion bound?

If it encounters a self-referential unnamed structure, it can perform
unbounded recursion through die_find_member(), potentially leading to a
stack overflow:

tools/perf/util/dwarf-aux.c:__die_find_member_cb() {
    ...
    else if (!dwarf_diename(die_mem)) {
        Dwarf_Die type_die, tmp_die;
        if (die_get_type(die_mem, &type_die) &&
            die_find_member(&type_die, name, &tmp_die))
            return DIE_FIND_CB_END;
    ...
}

Could these unbound paths cause perf report to hang or crash when processin=
g=20
untrusted or corrupted perf.data profiles?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913032632.1162=
77-1-acme@kernel.org?part=3D7
