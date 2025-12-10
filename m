Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACD3274B5F
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2025 22:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765404409; cv=pass; b=f7Arq7xK49DaI1gXrTT3H6U5MfNONkIuubWlGaF7JpD+B9veMsRhpXF8fvjR1Ykl3+nSQm5X2Rfc66YwwUZROj8oLkKDEPjEUq/pGghe4xiC9ygE9sSUHDmzM/eZQR352npe3sjUFGOd3c4QgqzR1Yfs8h/qPV0vUFeI2pFgieA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765404409; c=relaxed/simple;
	bh=0vTYp/lWWDj0dF7HQMSRkliWabNYrjnEj5AQmwuXbb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJzMUvaahgYdM9qla6hWKCcrd2Uc/qwH9U8HSlQP1uUVzOBE6kbo6x759pjzWHrDqjvEntnPrRao+R3FqdC9+s0iTq2jJgJFlMv4PA6JaodXvd4W8bczSpwY3tK9U4Dgj3GGXGcyrI+EPCdmQ7gAOJ9AFw7zXpBSfeKkq5eQiY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3AqON2Gw; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3AqON2Gw"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29e7ec26e3dso65035ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2025 14:06:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765404407; cv=none;
        d=google.com; s=arc-20240605;
        b=RYd8hePuUHciJr6HYMT9hUpVb6jGKIEPLxgriH2YkFfd7bM8ma5oGBJ4NOdPArE7/J
         k11QlUM+4JNNJD4Q0CYCR6dxvYtK6Ee84B8iT63QIh++ydsdQr8szi4o2HTRlQCJZi6t
         J2a4MBiht9E18wu7MwvX4PrpIHaQNAqtjSU0u+YmR+ercAh8O8oYzOhh/YBuKkb120V/
         +VtKxttxpJxocTsBC3m7lV4o5Ahaw9NR4GjDzyY2EuQnkRGPXdXjOmLRiaOrQkcheL3r
         FrU8UpHjO5t2vphyuJHb4aJo8tuMS8FNoCcFnYrlGjK3iD/LDPU7f9BXNvY6cScTNzdU
         zbqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yM7nB8neDjhlmJ9kpdY+jNThw8WdKdywm5+o+lrNnMM=;
        fh=7eZBtFDqOL9ICPzbn5ruTnCk9FV/MB8y1K5twCJAmdA=;
        b=QnkPHPcQ4gg6ncaEnP+YVCT69gWxwEnO/UbCvyFZFQE79vUWtMjKC8VmK3fy/3Lc8G
         tGcDpajcvNg4PD4cqtM72cpaM3J1eOeconRUIBNn6y6yCtTsP8YJ1/3pENhDBz96Uhh2
         AkuM/55cnw44iDQ/Ni2iTn0VGaX6pchCy7TiMDUje9T9G5iju/fIKvFB7ZVXIC75Jdul
         bUMC5gtggWpGQwXqOWm18oN83BiFawLBfBXrQknHaDSQYyXDWShe5QzpSbHniXejNLCA
         5C8n3eUAVMX80H77Lb7lgm9NPs3cZhbEwPMNVdHP7NoFTSRkka1IS4+UufZwpeXgKPk2
         6Oew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765404407; x=1766009207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yM7nB8neDjhlmJ9kpdY+jNThw8WdKdywm5+o+lrNnMM=;
        b=3AqON2Gw2i2TYLbOvQ8McQASW4ZXWCW1lIUxCDGLktg2p9QSOad5AbGK+K8yuZ2mJO
         r1fz7ATMBZVCIoZxbk1ffIeUlV1zPQw8xr+75jNxF/OV8MXIdHJVay+Gppm1zQv44PK1
         C+eUJy7czNoGvn2SpH3k1478GE/lP3aeZZ/b6vtd97WbMeQpwRjwMPyCxcKHzG6GzHXB
         qjHyUvlnkT5V/skzzn8WiNocdNH/kX2TbWNVm5EVxlIDJyc4EBQnwgLG0i3/SasuGmgs
         F/vkiAc9ckTH1dzejweas0HWCaxI92Rjxjw9jZ+v+psMqgZ2b9Tshrply5PKyeFMTUxS
         E2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765404407; x=1766009207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yM7nB8neDjhlmJ9kpdY+jNThw8WdKdywm5+o+lrNnMM=;
        b=wpqs3cFMuTd3AuUtYwcANsVMEb/UkX0IDUEgC/ERhYnR9YULSqxm33Xs3LP4ZOiXRk
         4RFFM877WrDtk5DMoMY92N3squyHfL4VHXfX6qrfTsn2M9UmjcKvwid/9/cjnUqOOlk8
         5kk2Kdv49WvlsFM5Y9bCFnAueC1oP2oPGCoVSr659TD1Uxg0hzUsUhRB//hRC+aNC9qj
         T5qocySvEK0NlevwyZ7OtlsNMJmqMIHhClg6pE7sWLA105ysrCx5uwMHlDNXM8p11bcT
         WoKNCwoUMw6HEgYMR29sV6jkPkr5ZyQJYZQDPowoKrjB1qO5FIHznHp3quXURydXez34
         AGSg==
X-Forwarded-Encrypted: i=1; AJvYcCUuy2IkdyvckGZbFMRrF62EHfNJjF6VH0eqQ018U8RhIPkW5aQ5oPVBXNL7Qkldtwli12VGRjps0r0ImVuPSHg5@vger.kernel.org
X-Gm-Message-State: AOJu0YxvVNI+V1CaFlmSi6614+BRzTrNS7+hy2HQ8nuEJz2efYBXmlo7
	rvrajT9VK1VP2gBsPrQOV54+gjXCEPOswNUDbbriMLxLboMU3GVQs/HGv6N7qh51RTYhdCG3BW2
	RvRdjm4YsD96bUJY5Y+xUP2amDYH4VyOWdiwIDba/
X-Gm-Gg: AY/fxX7nayhZ9OMjdXLoWQyVUptJhnhux4O5y4S+dc9ByvYcwBvz08NMKy7E1JlZE+v
	Sny+6DWxYVF4xcNTiTVzPMQ8S7hmFlfyW87vFerMg+CGQ9d9FTYfXZsknGi+4MtvmZ1eD+/ecma
	DtoRJ4268UX0dsSqHd3d/D2n/BbJomACr50PJPFMOgCQDe40um/g0GwLmweCJq5fgOsanWOMCY0
	8oknhDebuTsO5OLsAZ+4kQh1OXJwzsVqWOYpxZ1cJePIcj2T6n1K6VUY7QviLYcwK89f+Ki
X-Google-Smtp-Source: AGHT+IFBGRLXp+tjR4YAUs7LRUCYuMLeEQ/DXCkCRzQP1oTNw/pGs8yDwGVYKYt5wJVC7CwHufa0oMsz79MeDYS5LfQ=
X-Received: by 2002:a17:902:cccb:b0:299:c368:6b20 with SMTP id
 d9443c01a7336-29eed44e280mr315165ad.19.1765404406542; Wed, 10 Dec 2025
 14:06:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210023327.1669863-1-namhyung@kernel.org> <20251210023327.1669863-4-namhyung@kernel.org>
In-Reply-To: <20251210023327.1669863-4-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Dec 2025 14:06:35 -0800
X-Gm-Features: AQt7F2qnondnEIz5Obw_I0Qi7GAmHjhyvidHsxjpv5XK_41xya11x8PbXBY37bc
Message-ID: <CAP-5=fX2mr0qQhmbR2tVm_ZU6S5S2Az+Q4XfQpMAudRk+b8YOA@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf report: Update sort key state from -F option
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 6:33=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Factor out __sort_dimension__update() so that it can be called from -s
> and -F option parsing logics.  Otherwise the following command cannot go
> into the annotation mode.
>
>   $ perf report -F overhead,type,sym
>
>   Warning: Annotation is only available for symbolic views, include "sym*=
" in --sort to use it.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/sort.c | 100 ++++++++++++++++++++++-------------------
>  1 file changed, 54 insertions(+), 46 deletions(-)
>
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index c51604eaae0a4b90..5e27a66e3ccb0bbe 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -3531,6 +3531,56 @@ static int add_dynamic_entry(struct evlist *evlist=
, const char *tok,
>         return ret;
>  }
>
> +static int __sort_dimension__update(struct sort_dimension *sd,
> +                                   struct perf_hpp_list *list)
> +{
> +       if (sd->entry =3D=3D &sort_parent && parent_pattern) {
> +               int ret =3D regcomp(&parent_regex, parent_pattern, REG_EX=
TENDED);
> +               if (ret) {
> +                       char err[BUFSIZ];
> +
> +                       regerror(ret, &parent_regex, err, sizeof(err));
> +                       pr_err("Invalid regex: %s\n%s", parent_pattern, e=
rr);
> +                       return -EINVAL;
> +               }
> +               list->parent =3D 1;
> +       } else if (sd->entry =3D=3D &sort_sym) {
> +               list->sym =3D 1;
> +               /*
> +                * perf diff displays the performance difference amongst
> +                * two or more perf.data files. Those files could come
> +                * from different binaries. So we should not compare
> +                * their ips, but the name of symbol.
> +                */
> +               if (sort__mode =3D=3D SORT_MODE__DIFF)
> +                       sd->entry->se_collapse =3D sort__sym_sort;
> +
> +       } else if (sd->entry =3D=3D &sort_sym_offset) {
> +               list->sym =3D 1;
> +       } else if (sd->entry =3D=3D &sort_dso) {
> +               list->dso =3D 1;
> +       } else if (sd->entry =3D=3D &sort_socket) {
> +               list->socket =3D 1;
> +       } else if (sd->entry =3D=3D &sort_thread) {
> +               list->thread =3D 1;
> +       } else if (sd->entry =3D=3D &sort_comm) {
> +               list->comm =3D 1;
> +       } else if (sd->entry =3D=3D &sort_type_offset) {
> +               symbol_conf.annotate_data_member =3D true;
> +       } else if (sd->entry =3D=3D &sort_sym_from || sd->entry =3D=3D &s=
ort_sym_to) {
> +               list->sym =3D 1;
> +       } else if (sd->entry =3D=3D &sort_mem_dcacheline && cacheline_siz=
e() =3D=3D 0) {
> +               return -EINVAL;
> +       } else if (sd->entry =3D=3D &sort_mem_daddr_sym) {
> +               list->sym =3D 1;
> +       }
> +
> +       if (sd->entry->se_collapse)
> +               list->need_collapse =3D 1;
> +
> +       return 0;
> +}
> +
>  static int __sort_dimension__add(struct sort_dimension *sd,
>                                  struct perf_hpp_list *list,
>                                  int level)
> @@ -3541,8 +3591,8 @@ static int __sort_dimension__add(struct sort_dimens=
ion *sd,
>         if (__sort_dimension__add_hpp_sort(sd, list, level) < 0)
>                 return -1;
>
> -       if (sd->entry->se_collapse)
> -               list->need_collapse =3D 1;
> +       if (__sort_dimension__update(sd, list) < 0)
> +               return -1;
>
>         sd->taken =3D 1;
>
> @@ -3578,8 +3628,8 @@ static int __sort_dimension__add_output(struct perf=
_hpp_list *list,
>         if (__sort_dimension__add_hpp_output(sd, list, level) < 0)
>                 return -1;
>
> -       if (sd->entry->se_collapse)
> -               list->need_collapse =3D 1;
> +       if (__sort_dimension__update(sd, list) < 0)
> +               return -1;
>
>         sd->taken =3D 1;
>         return 0;
> @@ -3644,39 +3694,6 @@ int sort_dimension__add(struct perf_hpp_list *list=
, const char *tok,
>                                 sort_dimension_add_dynamic_header(sd, env=
);
>                 }
>
> -               if (sd->entry =3D=3D &sort_parent && parent_pattern) {
> -                       int ret =3D regcomp(&parent_regex, parent_pattern=
, REG_EXTENDED);
> -                       if (ret) {
> -                               char err[BUFSIZ];
> -
> -                               regerror(ret, &parent_regex, err, sizeof(=
err));
> -                               pr_err("Invalid regex: %s\n%s", parent_pa=
ttern, err);
> -                               return -EINVAL;
> -                       }
> -                       list->parent =3D 1;
> -               } else if (sd->entry =3D=3D &sort_sym) {
> -                       list->sym =3D 1;
> -                       /*
> -                        * perf diff displays the performance difference =
amongst
> -                        * two or more perf.data files. Those files could=
 come
> -                        * from different binaries. So we should not comp=
are
> -                        * their ips, but the name of symbol.
> -                        */
> -                       if (sort__mode =3D=3D SORT_MODE__DIFF)
> -                               sd->entry->se_collapse =3D sort__sym_sort=
;
> -
> -               } else if (sd->entry =3D=3D &sort_dso) {
> -                       list->dso =3D 1;
> -               } else if (sd->entry =3D=3D &sort_socket) {
> -                       list->socket =3D 1;
> -               } else if (sd->entry =3D=3D &sort_thread) {
> -                       list->thread =3D 1;
> -               } else if (sd->entry =3D=3D &sort_comm) {
> -                       list->comm =3D 1;
> -               } else if (sd->entry =3D=3D &sort_type_offset) {
> -                       symbol_conf.annotate_data_member =3D true;
> -               }
> -
>                 return __sort_dimension__add(sd, list, level);
>         }
>
> @@ -3695,9 +3712,6 @@ int sort_dimension__add(struct perf_hpp_list *list,=
 const char *tok,
>                                     strlen(tok)))
>                         return -EINVAL;
>
> -               if (sd->entry =3D=3D &sort_sym_from || sd->entry =3D=3D &=
sort_sym_to)
> -                       list->sym =3D 1;
> -
>                 __sort_dimension__add(sd, list, level);
>                 return 0;
>         }
> @@ -3711,12 +3725,6 @@ int sort_dimension__add(struct perf_hpp_list *list=
, const char *tok,
>                 if (sort__mode !=3D SORT_MODE__MEMORY)
>                         return -EINVAL;
>
> -               if (sd->entry =3D=3D &sort_mem_dcacheline && cacheline_si=
ze() =3D=3D 0)
> -                       return -EINVAL;
> -
> -               if (sd->entry =3D=3D &sort_mem_daddr_sym)
> -                       list->sym =3D 1;
> -
>                 __sort_dimension__add(sd, list, level);
>                 return 0;
>         }
> --
> 2.52.0.223.gf5cc29aaa4-goog
>
