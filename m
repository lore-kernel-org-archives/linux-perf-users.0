Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE5A226CF7
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Jul 2025 03:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751512259; cv=none; b=NCC0byZCzmShwDHh/E54pYVXPwGCxkueANsciLO9ljckT6aDWL2SgDO4wo0J74zKnBZOX7utJ+dkEPy0EQm7BapmmxviCQDncaeETe9sf1139x0JPrpA58erAEqoz17sVJqxT+7UIJN1grgVXUE2LtLT8Ekb9wabgGawEp5KQls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751512259; c=relaxed/simple;
	bh=l/SThSkCdIMsnI8u/x3NmemmZnc0BDEkBxVHFT9dU9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXlnVFGoyh3XBMry1J2LGkkwY7PvFHJHdUnFy6D4DeWR3Li7jQXZrjSldyM+TsVN6J5J20q1JiA6i7399NstgSJpoXZ41BQmiRXHzqSqPK1z3oxARHXCTygvmk8jRarXVT2qPIQdhguhy9kBP4WoFI1I2hOTL4nDm+WsZpB97JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hJLBOz6+; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJLBOz6+"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so120045ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Jul 2025 20:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751512256; x=1752117056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftN7RGlJl1guhpmdSyk5/dfvrSzoGYwSxauHC16WSO4=;
        b=hJLBOz6+qnvYbG8voTsnY3Bk3EyzOsLXcqagIXLmRrIUB92Wj/blYxUDHh7bUr0Tg1
         ACmqjaMQ645nNpxRn2erNFbMoAX91u0srUMgXwQ8gvfYaPKgXlVFkfw/meraxwIPCQCP
         ExvLp2VbC/mU6U7QhaVQ418YXkFzgjLTNTrxVqCKYWa3IpvhojylsnMl4p8UnB5P9stX
         B5BNW2d7eqg5ucI6d7D0eeJWbyeWrG8sSgwD7ST5j+QITvhAw63p5xG+KNfuzi648efC
         +xc6Tr55eu+iQcxX9NPenGofFWM5v/OBsNb1FTzU9+iicPNWl80liQpGfLonOeBY2jtw
         obhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751512256; x=1752117056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftN7RGlJl1guhpmdSyk5/dfvrSzoGYwSxauHC16WSO4=;
        b=aCnFQeuL4hsuLyfVAgtOGNgWSZyFyYAefHKLCPCthOLLJ6LTmhYmJZNtrhmHisljOz
         1VvNQPiN/jIbFaG9JTFvlwpASVRDJj35X799HyQjzecoKYo4K6c6eCvtoUkHBI1aBF99
         0t4aFNIvyoUwMiq15laGKb4VUDOuzlK9L532GvV1FKP2AxwJyOIN0AEFyYGeIlTsWTNe
         zzJJDdDQTkgxoo9tRKGOXycqNNe5Ex0oJwQfT71ULLg+VBf9o0fELc6m/eQdidzCRDsA
         wpnyZcrj9sTpPh4GgasKsoJgUPEomm9bnKTzhPIuL6vgKJB5mfoVjlKlp98Yk3/wN7S3
         veYw==
X-Forwarded-Encrypted: i=1; AJvYcCXnXtWw39LKvRcqPXsYwD+QMW9ms2jSX12WDChNM0xOmymOd0z5COsqynQCmlaAJSN2t1nk9WRRjm6smmQ4UFPe@vger.kernel.org
X-Gm-Message-State: AOJu0YwR4m4qxW4cCtejmIsttfz5IYYhmDMNhpZck53iI6VwWu+4LYhV
	ot5IuU5zt4v24OCY4El3ob1gR2KRFpgt3kTXRji4kIgbre9exjJ6ejyJu6eenRPIAdGex5aiF5F
	bLf4L599C/ObxKeIGJaRFhx1X4doHIVOhWPwwUTpp
X-Gm-Gg: ASbGncsMpPs8bFZo3iLqp9mpuhg/PZ/b6Fj5az4rZj9CpNFwt5kfjLH9JwbzdGtDkT+
	Z5HA5I0wqLuSHQg5tR+2FPOWYjL9cn0oMVx4gELk7FwMuwmir/OymUvE1E7AWwsKtjEHp2IIFKE
	3plR0cvJUJ2SHZJMSP4rPJwo+3PDArh0BxQu/k5W2xk76+
X-Google-Smtp-Source: AGHT+IEdc6WuLA6lnn2mMAEBWo0Fz8E346PGJBnLEaLSDC/nzbkIVv/ZO7sOj2a2U/3rkLrUlHodFHzR8x+f5HICllo=
X-Received: by 2002:a05:6e02:2198:b0:3e0:58e6:d8a3 with SMTP id
 e9e14a558f8ab-3e05d28e7b6mr1134135ab.27.1751512256413; Wed, 02 Jul 2025
 20:10:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703014942.1369397-1-namhyung@kernel.org> <20250703014942.1369397-8-namhyung@kernel.org>
In-Reply-To: <20250703014942.1369397-8-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Jul 2025 20:10:44 -0700
X-Gm-Features: Ac12FXyBMj3ZJaQUgsZq7GruGBflUeaUxIS4EgmWW_xkG1hwteXZqtgtKXd6zmc
Message-ID: <CAP-5=fVjjSENsdAt+QyBHJ3-yjdwHSLMgZZ_z80YtRQMZvjbiw@mail.gmail.com>
Subject: Re: [PATCH 7/8] perf sched: Fix memory leaks in 'perf sched latency'
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 6:49=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> The work_atoms should be freed after use.  Add free_work_atoms() to
> make sure to release all.  It should use list_splice_init() when merging
> atoms to prevent accessing invalid pointers.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-sched.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 087d4eaba5f7160d..4bbebd6ef2e4a791 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1111,6 +1111,21 @@ add_sched_in_event(struct work_atoms *atoms, u64 t=
imestamp)
>         atoms->nb_atoms++;
>  }
>
> +static void free_work_atoms(struct work_atoms *atoms)
> +{
> +       struct work_atom *atom, *tmp;
> +
> +       if (atoms =3D=3D NULL)
> +               return;
> +
> +       list_for_each_entry_safe(atom, tmp, &atoms->work_list, list) {
> +               list_del(&atom->list);
> +               free(atom);
> +       }
> +       thread__zput(atoms->thread);
> +       free(atoms);
> +}
> +
>  static int latency_switch_event(struct perf_sched *sched,
>                                 struct evsel *evsel,
>                                 struct perf_sample *sample,
> @@ -3426,13 +3441,13 @@ static void __merge_work_atoms(struct rb_root_cac=
hed *root, struct work_atoms *d
>                         this->total_runtime +=3D data->total_runtime;
>                         this->nb_atoms +=3D data->nb_atoms;
>                         this->total_lat +=3D data->total_lat;
> -                       list_splice(&data->work_list, &this->work_list);
> +                       list_splice_init(&data->work_list, &this->work_li=
st);
>                         if (this->max_lat < data->max_lat) {
>                                 this->max_lat =3D data->max_lat;
>                                 this->max_lat_start =3D data->max_lat_sta=
rt;
>                                 this->max_lat_end =3D data->max_lat_end;
>                         }
> -                       zfree(&data);
> +                       free_work_atoms(data);
>                         return;
>                 }
>         }
> @@ -3511,7 +3526,6 @@ static int perf_sched__lat(struct perf_sched *sched=
)
>                 work_list =3D rb_entry(next, struct work_atoms, node);
>                 output_lat_thread(sched, work_list);
>                 next =3D rb_next(next);
> -               thread__zput(work_list->thread);
>         }
>
>         printf(" --------------------------------------------------------=
---------------------------------------------------------\n");
> @@ -3525,6 +3539,13 @@ static int perf_sched__lat(struct perf_sched *sche=
d)
>
>         rc =3D 0;
>
> +       while ((next =3D rb_first_cached(&sched->sorted_atom_root))) {
> +               struct work_atoms *data;
> +
> +               data =3D rb_entry(next, struct work_atoms, node);
> +               rb_erase_cached(next, &sched->sorted_atom_root);
> +               free_work_atoms(data);
> +       }
>  out_free_cpus_switch_event:
>         free_cpus_switch_event(sched);
>         return rc;
> --
> 2.50.0.727.gbf7dc18ff4-goog
>
