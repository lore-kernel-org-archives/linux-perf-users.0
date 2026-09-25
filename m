Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F444C14E9
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350531; cv=pass; b=oe1zkqJ18qcMe4Iy1ad08CFo1hbWAYIeF6VHjVIv8dcmrU/CTY8FrSTvMBEToqjxQ/Y1HavAsHeYWPv/DKKvSc+PfWC/pVWSFrhVTeY3JTGDLBC6k6XH2EAYogMRlkdKgfHoLoqszvCTdhpiyD35pwG16+Q/q6I26Xrt50rAHmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350531; c=relaxed/simple;
	bh=RAoOMJMUrGIpi9eEAqhAD+QmAkUJY6O+uOU1JTBkWRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hb+fqYY/ZDAyvIE+sYOAqCQ2pEtTu4/eMi++vTVeVrp+g888PCDwtbhMoXy5Bpuk+FTWoexIezCn9pNNbOPedGlag08piKjez72RlvF+EBkKAYgU3aPb5ne1p5IAkL2iO5zuyKphRWs59uAOdnqh4up5VL3JP4EwEkCIBC7NdZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ey6zJfUY; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ey6zJfUY"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53113d72966so258271cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 08:35:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790350525; cv=none;
        d=google.com; s=arc-20260327;
        b=fMssWWJgQq6QJP4KB8ejtoRhS0KgbRKPv+wM221y7qq4uVG1rRe0kj7gNz+3iRYinc
         b7XcT2ttQoo6JsTQixEzzvJTgb5W/PnAT1QFzt4mLVWSQ0ztGcOlcQPRN0LgiXe4/8oE
         m+SS/+yKjcBzddw/QVowKYx/WGsvz2H6j+l8+hW1r2QsGG14hYcnYR3YIH+7yAQHlWJW
         pMV5l6EcsR6f8eCsz8wixvrq/SB/DHvmwnmKLz7CDMwhfqJC5mtWZ6VMRXAzRQP1oFkH
         UqDkIlD+WsFAt9RQD9bfno/+Eolw4lW4IJShBji19y7QAqzRr2vsYWvrKx2uGnzCb6Sj
         NvKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1AUFR0bcaYiiInCheMd1ljiLonx4ECB6w1hYaXq4GC8=;
        fh=Of1jB6cA5yDILgsmvwj155fA8URDp3NMuot3++IK0+c=;
        b=BxI1E3DKnLd05eZ0DlQ8UxeHy+FTqoVSfLkgwlDQnShDZke215EcSnicBd2eCcZWC0
         +10JSoXUUZ9thN8xpiWts1MsP/Kv60rOOrB41cUJdAq+ctQc6f8VJ8LeNy0PijpZWAQp
         i6368hmBjoI8D0o4wnNCBrHWt7XL2ftnrYrKkObSDsWpgQCIzFpgqR6rH6WuifL6HQ1S
         hUURFsw6mBcBeSq9fIWmsXVITcXYgt5azgmQ9OddvTYAVOJX/i/An3YmO4c6vXJqZ/wN
         v270fv7joyijO1SmRL32OYHm6JLxXuB6g43rI6AR6JP2AoEaAVg7yURopRoYEV8//nF3
         kBBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790350525; x=1790955325; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1AUFR0bcaYiiInCheMd1ljiLonx4ECB6w1hYaXq4GC8=;
        b=ey6zJfUYLyCIoz1mrxEO59dQhDnwDB7w1bSoQqlWkv3cA68mqFoX0AYXfVEXA/DKR+
         F6XRtQiR8J6V/S7hsg3g29U/Hg50VAQ629/j0DrO5PAAzUb787g3Xhv8vSrZb+e08dhA
         hnS7KtTC3BCM1Su4q7mxTnmh22E0ZYSo35LHZXeA2tlOai3z/0/ONP3feCJrYwPnVsM5
         k03M3cs270sJ6Bf2p0NV8qgLqAX+4doE0MftntUZp3W5ZMjIpnycqoSSvVSE6aGr3jyX
         lMz0uHO0RSdhQJ3IHTzmbdF5/RGjVdMKdTBry/C9oto5c5cbAdPmYVJHNupZmGzGVczf
         Rqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790350525; x=1790955325;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1AUFR0bcaYiiInCheMd1ljiLonx4ECB6w1hYaXq4GC8=;
        b=q0VNt6wFyZbiU7jVSZVjcsJ3QZoRCH5mTUsgYxoKSejHlIag0T/wz5Aio6i1y6Jynm
         YxS5dFP+O/xkgWXxhFxVuITb+VyPqcqeLYQR3elx9LpVnb9fVE0R7QoSCAzeoNV+M/MD
         +Op3Mv+3JbmFs/O2Ik8Pp23uevt/6/4L+R4MNfv8hc9mSVbGN7Wj5o2TxVtfUm5oHbev
         AunzB4BuCrL0hrYjshvQJuc21OuVn1iCR+RWKw+OzPF4zt1hVY9MJeFzO4hXAwOAfusW
         VX+kmUzdCbaU/okkKeEiZ5QhIljpMI/JEx4jpnIc7QhjKjU80ITeuyf4apDGUUV6SNZs
         gBaA==
X-Forwarded-Encrypted: i=1; AKwUvBzO7JGms+fW8z6YCp8Hn+Cjx7ALb3ZhLya2U48aW+m8Tc37RZDj5Uzi1Wb0IHUV07HU54cDzHzwII6yMI3wqQWX@vger.kernel.org
X-Gm-Message-State: AFuF++kGHa7hOXKPlH+Z32Jp06SFDXqIzj0Vci5asqy/FPZQV8FO/UlO
	lscCs1BmT8kxOjIXzb/QqTLSVt2T7AcFJ3crj8b/wJk1cX7OXB0tIs7RIicatlUIr0dbwnE+xcR
	cJrUlCGYwQogWy+Qzmc9sCtDbUadO9ZILKTO9Ofpq
X-Gm-Gg: AYBFou2cyRY27IsPCN6Cam5gum2y2FIg9kwWwNjkwvMZBoBObl57DJGg/hg1QtyQLOs
	3+nyjiQ0MvunBAg69hVHU1YmfXiH8t4pzqztH/TrYsukfbJ1kZ8SfmygDxDdIy6Wr6miCQ0pY3D
	9wYnO/w8A9D+/MdS16Lrldc1NMzXTcrri9TRIGpa3x8dqdUpOZjeOJMikHZAFUCyHQQYY5xMjNz
	hvkBjRQKTGMVFfcBMW92mU5XCfyXq/g61BEWTFh/6B6832ktgjG4aZ75o023Smy2xk5wSO5ffl6
	fGwSDKxDvXKS1zgb/V8ZR2P411ubh3vfP5d4iSk2yyokczjpqgabIo+TqBcKr9ErlmZgrj/rIrs
	SQnz0PRCdcas=
X-Received: by 2002:a05:622a:11c4:b0:532:9003:35b1 with SMTP id
 d75a77b69052e-5331a787127mr4687681cf.2.1790350524211; Fri, 25 Sep 2026
 08:35:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925150657.1826942-1-acme@kernel.org> <20260925150657.1826942-4-acme@kernel.org>
In-Reply-To: <20260925150657.1826942-4-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Sep 2026 08:35:11 -0700
X-Gm-Features: AclHuK-fU_qeSERmmmdA31MBwT80wErUCN7Csl_mpnfIUlMovHvI8q0yBKAe7og
Message-ID: <CAP-5=fVM6qFD0QZfD6HeYoxoyYP355gtDYN7+-Q0vAV3NioKcw@mail.gmail.com>
Subject: Re: [PATCH 3/6] perf annotate-data: Resolve type DIEs in the debug
 file they came from
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 8:07=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> 'perf report -s type' hangs burning CPU on the dwz compressed debug
> info of libz.so.1 (zlib-ng): die_collect_vars() saves the
> dwarf_dieoffset() of the type DIE, which is relative to the file it
> lives in - the dwz alt file for the types shared by more than one CU -
> and update_var_state() resolves that offset in the main debug file,
> parsing whatever is at it, here a typedef whose DW_AT_type refers to
> itself.
>
> Record whether the type DIE came from the alt file and resolve the
> offset with die_get_type_die() in that file, with no fallback.
>
> Fixes: 06b2ce75386df04b ("perf annotate-data: Maintain variable type info=
")
> Fixes: 55ee3d005d62279d ("perf annotate-data: Add a cache for global vari=
able types")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/annotate-data.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index e9b58a3d587be45b..bc9698abc6a9e055 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -739,6 +739,8 @@ struct global_var_entry {
>         u64 start;
>         u64 end;
>         u64 die_offset;
> +       int die_tag;
> +       bool from_alt;  /* die_offset is relative to the alt (dwz) file *=
/
>  };
>
>  static int global_var_cmp(const void *_key, const struct rb_node *node)
> @@ -776,7 +778,7 @@ static struct global_var_entry *global_var__find(stru=
ct data_loc_info *dloc, u64
>  }
>
>  static bool global_var__add(struct data_loc_info *dloc, u64 addr,
> -                           const char *name, Dwarf_Die *type_die)
> +                           const char *name, Dwarf_Die *type_die, bool f=
rom_alt)
>  {
>         struct dso *dso =3D map__dso(dloc->ms->map);
>         struct global_var_entry *gvar;
> @@ -798,6 +800,8 @@ static bool global_var__add(struct data_loc_info *dlo=
c, u64 addr,
>         gvar->start =3D addr;
>         gvar->end =3D addr + size;
>         gvar->die_offset =3D dwarf_dieoffset(type_die);
> +       gvar->die_tag =3D dwarf_tag(type_die);
> +       gvar->from_alt =3D from_alt;
>
>         rb_add(&gvar->node, dso__global_vars(dso), global_var_less);
>         return true;
> @@ -872,12 +876,14 @@ static void global_var__collect(struct data_loc_inf=
o *dloc)
>                         if (pos->reg !=3D -1)
>                                 continue;
>
> -                       if (!dwarf_offdie(dwarf, pos->die_off, &type_die)=
)
> +                       if (!die_get_type_die(dwarf, pos->die_off, pos->d=
ie_tag,
> +                                             pos->from_alt, &type_die))
>                                 continue;
>
>                         get_global_var_info(dloc, pos->addr, &var_name, &=
var_offset);
>
> -                       global_var__add(dloc, pos->addr, var_name, &type_=
die);
> +                       global_var__add(dloc, pos->addr, var_name, &type_=
die,
> +                                       pos->from_alt);
>                 }
>
>                 delete_var_types(var_types);
> @@ -902,7 +908,8 @@ bool get_global_var_type(Dwarf_Die *cu_die, struct da=
ta_loc_info *dloc,
>
>         gvar =3D global_var__find(dloc, var_addr);
>         if (gvar) {
> -               if (!dwarf_offdie(dloc->di->dbg, gvar->die_offset, type_d=
ie))
> +               if (!die_get_type_die(dloc->di->dbg, gvar->die_offset,
> +                                     gvar->die_tag, gvar->from_alt, type=
_die))
>                         return false;
>
>                 *var_offset =3D var_addr - gvar->start;
> @@ -932,7 +939,8 @@ bool get_global_var_type(Dwarf_Die *cu_die, struct da=
ta_loc_info *dloc,
>
>  ok:
>         /* The address should point to the start of the variable */
> -       global_var__add(dloc, var_addr - *var_offset, var_name, type_die)=
;
> +       global_var__add(dloc, var_addr - *var_offset, var_name, type_die,
> +                       !die_same_file(cu_die, type_die));
>         return true;
>  }
>
> @@ -987,7 +995,8 @@ static void update_var_state(struct type_state *state=
, struct data_loc_info *dlo
>                                 continue;
>                 }
>                 /* Get the type DIE using the offset */
> -               if (!dwarf_offdie(dloc->di->dbg, var->die_off, &mem_die))
> +               if (!die_get_type_die(dloc->di->dbg, var->die_off,
> +                                     var->die_tag, var->from_alt, &mem_d=
ie))
>                         continue;
>
>                 if (var->reg =3D=3D DWARF_REG_FB || var->reg =3D=3D fbreg=
 || var->reg =3D=3D state->stack_reg) {
> --
> 2.53.0
>
