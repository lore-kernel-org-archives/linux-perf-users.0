Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B982FFDFA
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540878; cv=pass; b=Nn0dpNXI9FVwr0qFODCl/9G/3EFJMDqd+v1gPMv7w7Ny3FC7V2wAI5Lwfml9GuRj5+4U9/Lycyz1fzIhIJb4yXwtFZqq7G0YF4QiYkCO6eIWUoFEpLMSKC8oDXp9s5thPtwfKraoME4fUARoPCFu3ytxKkhG3StxR+u4jVUEtuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540878; c=relaxed/simple;
	bh=urIIFwDCdWAK34onKuLXJ1hrtsco0FxwK4U14DFWbb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwzoJIOOouHZC3vApZyjrfwGi/b1NzsphDO8Vvt1ME2BLg0RSUAEUr1xVoFIm/vAjs6iQRMTqAr4bZN8PFGMPBN/Om2xN8QozY7iChf80OEwCclY72wnMYFB/C5bjYgFfLG/IAXpBDTQI1pRDU05RV1MOORetFmNtbGu5YSEeXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iEV4+ODu; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iEV4+ODu"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0d06cfa93so9705ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 11:07:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769540874; cv=none;
        d=google.com; s=arc-20240605;
        b=RwxL1L+WaE7yDE7W9vYdqaYxVluB9CjB0ibG77RTowvHNqEi+ad5o+3t9Q39+LZN8I
         sVJW/cJggYTbFOqlJ8apAN6BweVNgotAGqlAV26A4iMUp51VaSYpMUcra/7ahigm1urs
         r04ZX09dSeI9sOPU3SizC1/PUg/8ePsOWwm2wpx3FIjCNkkle5PgLHsoi+Uilvp4oLFC
         Yt9UPba0nPKWrZiNJ4SnvTgtIJVRvYlXJ881BrcZxUZCUzbJc/0VsdTMh08/KG2KybgR
         SgY5NnvZy5DNfNRQ4gAOK3haUaiPb1UxQ4/6FT9tIxjZjVSyTfIYI6MzQRUo5RzTCuGa
         JL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PdYVKoPSvOw/L0lYFnEfLC+5ATp/EMO+wdpJLYpb3EQ=;
        fh=dPmOUqL5g+o3nCsitEVppGTmJWv/SoH9qGFusy32i5g=;
        b=BcU8z0bcmjXKA7loRXI/gxCIwkBLCl/so+M/jbNacRv1Y/AJcsuBmPdGk62oSMw4MF
         7jdlvHyX0mOVbD2rKUGFw7zfqPYoyJct9Q/aoBoM0fyeFsx6IlqpzEBdxH7tMusArh4q
         ULGc1Yy5T4l5oh+lJX1t/xoY1cBlTebJmnUNqvRtYG5ncT4cJ2kOiHOtWifLjwUMUT9H
         rLQL2YEpmAGThNauxxmBWsdwf9aP+XIVdw8kbWBLp4+6d4z0Z2xsk+5QsZg4N4wgQ5JH
         cKZeiIqaugQgfOeI6dParlgBckXaRMMeBPzb01rJH2OTvPKnSxMQnsh/6C5mSfaGpY+q
         HTXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769540874; x=1770145674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdYVKoPSvOw/L0lYFnEfLC+5ATp/EMO+wdpJLYpb3EQ=;
        b=iEV4+ODuYPTgPNbzKyCtLYbCsf7kTWsxs+tkWBOJxq7pmDWjXLX9w/J3lNCfJFCLDM
         7mmYApWaqFETVcoQ6AH9rF+J4eZ4gHRy/5cwVQWWcfcVIXBfA0F4wqPhwoZ39cRqAfOq
         ef5lydHmeCMDXkB9LntXogyDm2OdvLUhf65Ejz4Lu84b/wT/sIJGzbCkcXLW//uy/TGP
         X3ucXcz8CjRkXSrZM9ETlS1Cv3Kigjn4Au0/2BDzK7PNSE/yLqbTLe9d4H4ITIecakrs
         EhZK69aESNWbKZcGigtfJNgnGoU8+MoQJ+6BWjhNcgocOq58FX8eIo1VRuVVQUWoZrZw
         sJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769540874; x=1770145674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PdYVKoPSvOw/L0lYFnEfLC+5ATp/EMO+wdpJLYpb3EQ=;
        b=DTKFBLa/d7AHSHZx/DqFfuLpkbgS64bTUbXEUiRpBIx3B7lHQEsas98bAHEniJnzTS
         aPzOsz6pwKaH6LDAb3Frf8yygfxvG9QRjCSgRqxye/01ae3hVz3Si3aJhmRU0W79Aug0
         U785WoPX2ENfcAIAMbVlajfTeLsYWkcwEBxV186vlNVsEgZXLU94brhOuqAmu8raahqY
         /CRo94sjlhqhDQ2t/dhM5BFmvRWMGzaSrJovz51cKCxWK34B9usEpFb6nj+Ya1YcUOPR
         sN9p+rJzTSi+mMtupn4Ba5Uh9kgEgU6ygSq6NnpAs18IRc3hpiVeb7tYTElegVKBPQfg
         Lq+A==
X-Forwarded-Encrypted: i=1; AJvYcCW3v7d/JVMKBsn2ntBX/H6WT9FokN1Pfz0FYD+rZi6nu9tvh9jr2QVEAX+WZczAy7FnhOKJBjuK5RLBVsYhcWv6@vger.kernel.org
X-Gm-Message-State: AOJu0YxwShAtNJj2tsw4XDnp/28RiVfjwf35yMH91kSbL8TxV9QNX3iS
	UL8QtinPg9qwhtyPgAkZqWxZJYDt0WqUYx3cd7Cg9SAX9t9YcGVXb5lJIC0s01rqtqqdhFb4pdz
	MljAfsf6ZUWcNI8Oizjqh8hKKhzpe0jJ6m3Ok4vRp
X-Gm-Gg: AZuq6aIFZKq8aJCkzB6zkZmoATdPZjhuaXlCFrHcfhGR+eCVmfQkTyXIJ9OYDXZlwIr
	Q4iNwWaH+F6hOPBsMzK2uO4irVrXiOJa6vbegdU38MR77azFPrsQdD8Vu0GKHrZvsi2qT8LE/XH
	i+xvTDh+wRAW5lVUSs4CmpmR7espP1AWOrYq2ILTE+e0FoSNM2DTMOjAs5TkrmG6cq9l9RCLsT0
	2oPgsJR4zZWA9rJlv4vwWUkDLmi/27+4PfV2CVBZVczAHVDsnWsUW2EnWx84G9WoivX74rmHAm8
	v0un3XWnXmBYlWGK5zLerm5N
X-Received: by 2002:a17:903:38cc:b0:2a7:4151:2c74 with SMTP id
 d9443c01a7336-2a870b63e57mr2453415ad.16.1769540873513; Tue, 27 Jan 2026
 11:07:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aXjjSR1s3CJQn0bY@x1>
In-Reply-To: <aXjjSR1s3CJQn0bY@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Jan 2026 11:07:41 -0800
X-Gm-Features: AZwV_Qg-vkoG063DHBhGQ5cMLZF24Bzmsw9DPggISimSN0MSY8UOE3PI52UqHbg
Message-ID: <CAP-5=fUor0SPQ8PjEHHaE1qSnZ5TX1H=feUCERzwXGibqKAfNg@mail.gmail.com>
Subject: Re: [PATCH 1/1 next] perf strlist: Remove dont_dupstr logic, used
 only once
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 8:09=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Ian Rogers noticed that 678ed6b707e4b2db ("perf strlist: Don't write to
> const memory") breaks the 'Remove thread map' 'perf test' entry, because
> it keeps pointers to the temporary string introduced to avoid touching
> the const memory.
>
> This is because the thread_map__new_by_[pt]id_str() were the only
> methods using the slist->dont_dupstr knob to keep pointers to the
> original const string list, as it uses strtol to parse numbers and it
> stops at the comma.
>
> As this is the only case of dont_dupstr use, dupstr being the default,
> and it gets in the way of getting rid of the last const-correctness,
> remove this knob, with it:
>
>   $ perf test 37
>   37: Remove thread map   : Ok
>   $
>
> Fixes: 678ed6b707e4b2db ("perf strlist: Don't write to const memory")
> Reported-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/strlist.c    | 25 ++++++++-----------------
>  tools/perf/util/strlist.h    |  2 --
>  tools/perf/util/thread_map.c | 18 ++++++------------
>  3 files changed, 14 insertions(+), 31 deletions(-)
>
> diff --git a/tools/perf/util/strlist.c b/tools/perf/util/strlist.c
> index 98883672fcf47102..50add72575e0c60c 100644
> --- a/tools/perf/util/strlist.c
> +++ b/tools/perf/util/strlist.c
> @@ -12,20 +12,16 @@
>  #include <linux/zalloc.h>
>
>  static
> -struct rb_node *strlist__node_new(struct rblist *rblist, const void *ent=
ry)
> +struct rb_node *strlist__node_new(struct rblist *rblist __maybe_unused, =
const void *entry)
>  {
>         const char *s =3D entry;
>         struct rb_node *rc =3D NULL;
> -       struct strlist *strlist =3D container_of(rblist, struct strlist, =
rblist);
>         struct str_node *snode =3D malloc(sizeof(*snode));
>
>         if (snode !=3D NULL) {
> -               if (strlist->dupstr) {
> -                       s =3D strdup(s);
> -                       if (s =3D=3D NULL)
> -                               goto out_delete;
> -               }
> -               snode->s =3D s;
> +               snode->s =3D strdup(s);
> +               if (snode->s =3D=3D NULL)
> +                       goto out_delete;
>                 rc =3D &snode->rb_node;
>         }
>
> @@ -36,20 +32,18 @@ struct rb_node *strlist__node_new(struct rblist *rbli=
st, const void *entry)
>         return NULL;
>  }
>
> -static void str_node__delete(struct str_node *snode, bool dupstr)
> +static void str_node__delete(struct str_node *snode)
>  {
> -       if (dupstr)
> -               zfree((char **)&snode->s);
> +       zfree((char **)&snode->s);
>         free(snode);
>  }
>
>  static
> -void strlist__node_delete(struct rblist *rblist, struct rb_node *rb_node=
)
> +void strlist__node_delete(struct rblist *rblist __maybe_unused, struct r=
b_node *rb_node)
>  {
> -       struct strlist *slist =3D container_of(rblist, struct strlist, rb=
list);
>         struct str_node *snode =3D container_of(rb_node, struct str_node,=
 rb_node);
>
> -       str_node__delete(snode, slist->dupstr);
> +       str_node__delete(snode);
>  }
>
>  static int strlist__node_cmp(struct rb_node *rb_node, const void *entry)
> @@ -165,12 +159,10 @@ struct strlist *strlist__new(const char *list, cons=
t struct strlist_config *conf
>         struct strlist *slist =3D malloc(sizeof(*slist));
>
>         if (slist !=3D NULL) {
> -               bool dupstr =3D true;
>                 bool file_only =3D false;
>                 const char *dirname =3D NULL;
>
>                 if (config) {
> -                       dupstr =3D !config->dont_dupstr;
>                         dirname =3D config->dirname;
>                         file_only =3D config->file_only;
>                 }
> @@ -180,7 +172,6 @@ struct strlist *strlist__new(const char *list, const =
struct strlist_config *conf
>                 slist->rblist.node_new    =3D strlist__node_new;
>                 slist->rblist.node_delete =3D strlist__node_delete;
>
> -               slist->dupstr    =3D dupstr;
>                 slist->file_only =3D file_only;
>
>                 if (list && strlist__parse_list(slist, list, dirname) !=
=3D 0)
> diff --git a/tools/perf/util/strlist.h b/tools/perf/util/strlist.h
> index 7e82c71dcc422d7e..3e9533e66ca9ee11 100644
> --- a/tools/perf/util/strlist.h
> +++ b/tools/perf/util/strlist.h
> @@ -14,7 +14,6 @@ struct str_node {
>
>  struct strlist {
>         struct rblist rblist;
> -       bool          dupstr;
>         bool          file_only;
>  };
>
> @@ -24,7 +23,6 @@ struct strlist {
>   *             found
>   */
>  struct strlist_config {
> -       bool dont_dupstr;
>         bool file_only;
>         const char *dirname;
>  };
> diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
> index ca193c1374ed4823..48c70f149e9201dc 100644
> --- a/tools/perf/util/thread_map.c
> +++ b/tools/perf/util/thread_map.c
> @@ -164,19 +164,16 @@ static struct perf_thread_map *thread_map__new_by_p=
id_str(const char *pid_str)
>         struct dirent **namelist =3D NULL;
>         int i, j =3D 0;
>         pid_t pid, prev_pid =3D INT_MAX;
> -       char *end_ptr;
>         struct str_node *pos;
> -       struct strlist_config slist_config =3D { .dont_dupstr =3D true, }=
;
> -       struct strlist *slist =3D strlist__new(pid_str, &slist_config);
> +       struct strlist *slist =3D strlist__new(pid_str, NULL);
>
>         if (!slist)
>                 return NULL;
>
>         strlist__for_each_entry(pos, slist) {
> -               pid =3D strtol(pos->s, &end_ptr, 10);
> +               pid =3D strtol(pos->s, NULL, 10);
>
> -               if (pid =3D=3D INT_MIN || pid =3D=3D INT_MAX ||
> -                   (*end_ptr !=3D '\0' && *end_ptr !=3D ','))
> +               if (pid =3D=3D INT_MIN || pid =3D=3D INT_MAX)
>                         goto out_free_threads;
>
>                 if (pid =3D=3D prev_pid)
> @@ -223,24 +220,21 @@ struct perf_thread_map *thread_map__new_by_tid_str(=
const char *tid_str)
>         struct perf_thread_map *threads =3D NULL, *nt;
>         int ntasks =3D 0;
>         pid_t tid, prev_tid =3D INT_MAX;
> -       char *end_ptr;
>         struct str_node *pos;
> -       struct strlist_config slist_config =3D { .dont_dupstr =3D true, }=
;
>         struct strlist *slist;
>
>         /* perf-stat expects threads to be generated even if tid not give=
n */
>         if (!tid_str)
>                 return perf_thread_map__new_dummy();
>
> -       slist =3D strlist__new(tid_str, &slist_config);
> +       slist =3D strlist__new(tid_str, NULL);
>         if (!slist)
>                 return NULL;
>
>         strlist__for_each_entry(pos, slist) {
> -               tid =3D strtol(pos->s, &end_ptr, 10);
> +               tid =3D strtol(pos->s, NULL, 10);
>
> -               if (tid =3D=3D INT_MIN || tid =3D=3D INT_MAX ||
> -                   (*end_ptr !=3D '\0' && *end_ptr !=3D ','))
> +               if (tid =3D=3D INT_MIN || tid =3D=3D INT_MAX)
>                         goto out_free_threads;
>
>                 if (tid =3D=3D prev_tid)
> --
> 2.52.0
>
