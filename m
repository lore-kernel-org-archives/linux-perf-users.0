Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB8544AB6C
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394089; cv=none; b=qqFLVVUJwEg/0pkKKbn+kZzn0FS9UzISNOylRf7z4ArLu+vJSw1/WbtgPV7gwspSmN/Ofe+tLk4RsOhmQKhtghcXX75JNYdpp2LgxVmh6cx0oWan5tmTA82UYzUwrPoy9qXaZNCXINBohQQcd8Zso3H3K81kGILTuSXXFlXqq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394089; c=relaxed/simple;
	bh=oGmWh47pEtU77hLQKsiJXN7N+qMNHGrFMdapRbltZG8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qJb7Jcu1x7Vo4lW8YxVOpYtTJYJVFZxvW4HPtvUc5jrZTjhp853yxeKMcpAsGZn2KfkFRsaW8Nskzv/iU3jsHZRnx3zRKIBgjpmBSQaWOfn2BA1Og93erCW/GPdDIQoqbN46kjovXgVnBfeA1fJQuRkgMMMeinomGndOBQFiPcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNZsPrFt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNZsPrFt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405391F000FF;
	Mon, 14 Sep 2026 13:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789394087;
	bh=8YHSiL9S8SiKFwa/d15VF6GPiroDVChnyk914pWJ+aY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WNZsPrFtRgPfSqbnRFtUGounZjsKdiOk8TAjhPbJKG/rsnMThERhR+ZlAAkVX6Wl4
	 1O1lEWYmNCvMrirTEsWY2mstmOpCBJ9CST0LhlFoJsjfolcRJc6brw4qKgiHeVeA11
	 ly526p9atIjqWbzBqeYRhAH7Ni/fo+dh4CSds6abHuDwEvXoPtbof19Dyg3KgnZMIk
	 eKNE0NHPQ/MaNG8gygKUohd9m96Z0Y+fDxn41b/Xt9AjNW06DIDnL5lAieHECEBQ6B
	 8UrPDAf28Lh1tjOlHg7lWefVYyyoaPbGg2WEmNttaJOQnxD5tgoYIGXrJGZGPi6DmW
	 orfgjCLZiK+jQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] perf annotate-data: Resolve type DIEs in the debug
 file they came from
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914125451.2045-8-acme@kernel.org>
References: <20260914125451.2045-1-acme@kernel.org>
 <20260914125451.2045-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 13:54:46 +0000
Message-Id: <20260914135447.405391F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded recursive calls in `__die_find_member_cb` when processin=
g anonymous structures can lead to stack exhaustion.
- [High] Missing loop iteration bound in `die_get_member_type` allows an in=
finite loop on cyclic DWARF structure references.
--

commit ea0e3dfe9a708661f7cdcfe58f9fbe047a513329
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf annotate-data: Resolve type DIEs in the debug file they came from

A 'perf report -s type' on a 783 MB AMD IBS data type profiling session
hangs, burning all of a CPU and producing no output. This resolves the
type DIEs in the debug file they came from to prevent hanging on
self-referencing typedefs and qualifiers. It also adds depth and recursion
bounds to type chasers.

> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index 4e4c587640823..06d27868887bd 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
[ ... ]
> @@ -221,6 +221,15 @@ static bool data_type_less(struct rb_node *node_a, c=
onst struct rb_node *node_b)
>  	return strcmp(a->self.type_name, b->self.type_name) < 0;
>  }
> =20
> +/*
> + * Members of struct/union members are added recursively, and the same D=
IE
> + * that is not what it looks like, the one that makes the type chasers in
> + * util/dwarf-aux.c spin, can make a member's type point back at one of =
its
> + * own ancestors, recursing until the stack is gone.  Nothing usable com=
es
> + * out of nesting members this deep anyway.
> + */
> +#define MAX_MEMBER_DEPTH 8
> +
>  /* Recursively add new members for struct/union */
>  static int __add_member_cb(Dwarf_Die *die, void *arg)

[Severity: High]
This is a pre-existing issue, but while we are adding MAX_MEMBER_DEPTH to
prevent stack exhaustion here, what about __die_find_member_cb() in
tools/perf/util/dwarf-aux.c?

If we process a corrupted DWARF file with an anonymous structure member that
forms a cycle, couldn't this initiate an unbounded recursive search down the
anonymous structure member chain and also exhaust the stack?

tools/perf/util/dwarf-aux.c:__die_find_member_cb() {
        ...
        else if (!dwarf_diename(die_mem)) {     /* Unnamed structure */
                Dwarf_Die type_die, tmp_die;
                if (die_get_type(die_mem, &type_die) &&
                    die_find_member(&type_die, name, &tmp_die))
                        return DIE_FIND_CB_END;
        }
        ...
}

> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index d7160f87ac7d7..7acb431fd34a8 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
[ ... ]
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
>  {
> -	int tag;
> +	int tag, chase =3D 0;

[Severity: High]
This isn't a bug introduced by this patch, but since we are preventing
infinite spinning on cyclic DWARF types here, is there a similar missing
loop iteration bound in die_get_member_type() in tools/perf/util/dwarf-aux.=
c?

If a crafted DWARF file contains a cyclic struct/union definition (e.g., an
anonymous embedded struct whose type points back to itself) located at
offset 0, would this traverse downwards infinitely and hang the tool since
offset and tag remain unchanged?

tools/perf/util/dwarf-aux.c:die_get_member_type() {
        ...
        while (tag =3D=3D DW_TAG_structure_type || tag =3D=3D DW_TAG_union_=
type) {
                member =3D die_find_child(&mb_type, __die_find_member_offse=
t_cb,
                                        (void *)(long)offset, die_mem);
                if (member =3D=3D NULL)
                        return NULL;

                if (die_get_real_type(member, &mb_type) =3D=3D NULL)
                        return NULL;

                tag =3D dwarf_tag(&mb_type);
        ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914125451.2045=
-1-acme@kernel.org?part=3D7
