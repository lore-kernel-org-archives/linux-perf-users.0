Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464C726056E
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2025 22:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765404338; cv=pass; b=MFvCkxD5YXLL7o3in9WEb3DywJAVgXa0bqr91pRlBYoucq5GYHxabLglO3GAkISw9L1ulCmDugwbiGyp9KdNUh8Xz8/hfx35j34xw5Cn5HsxerDiYZBMhg5gJwAZsOeqT4uRZHn1A+HBlZ/uS7+aHtEYLaHZvSfOzlgzISpDGXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765404338; c=relaxed/simple;
	bh=YaHPhK9K9MlUuKe1T7Oj53UXHOehWvE/JBH6DaB0rlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYq+6ex0fEInbQ1Yr1wk2nSsmW8CeRDhQ6oLIpwBt3GzsMZZHRV0wZA4gD7NHYxmSnT3y4sHKNczZkNacRVmWiTLRKZ5cYo75BnTyOuG4pvC7aXIvV/gw5Rpg8BBT6eVl+ZX6Rm9EOZQZxaH7lK75DIQHR+MCbuRrhCsVruea88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1BDxB1mp; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1BDxB1mp"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2980343d9d1so25355ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2025 14:05:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765404334; cv=none;
        d=google.com; s=arc-20240605;
        b=D8J1mx4tTGGb5MyEhQcDxf3bDQlyNOo/YSwOZccxAVg+elbrexAAyCUpg6EwemZZmA
         XgpYlYsB4TZxrji7XJhQaJOJyUT2QgvMTeYz/2Fl+nmKHGGE4zx+GuWd7vI4cFgSj7XS
         R2znKSRJpLXteMhUqx2XNbbgJXh13fq2OxQ0qwtRWUEo2TkuN9MQXYNY6b1YIPgPlRt1
         0cpTdHsBfQbI8F8NKapOdvSWW6wnB/KorPnmx+rnhzeLpa/FMr/5btTnqoWCkOdig/JS
         qjL1geWhYMGrUelawolo9xHeZUh4WEMis562POm2JUYn5nybaXA9LYBtMsr8fYJwIovB
         iKNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zf0CLyhh9XE4rR8idUFmiczPVQuqzFdqmqmc6AJeS+s=;
        fh=AHRblmFmTqDMBo/T9Bil027w5E+0qWgoVUXa6FdgpDQ=;
        b=TbGGNP3Kyb5x9v0XwO5c0hSl5DSJHm5qymi7JU/86PVSp/Rv3Vt25gXqC4eLRcCCta
         K4ykwn0kddqhqvX14v/U8l/Aacwiya6XgbU01D5LUoq3hshgMlW718HXgCXjpL9IVsEv
         Ug+dKLonub0ELeW3Ir33IQLZTfE+71bCvvDfupGdCGQVkPtSmk9esRGaxRFvobFitPaJ
         z/DHBcgloaUMNLfANk1SGLHdCGKNovd4FJwHglHXKaaWdyQdOOP8n7PdYMpSENqZ4emD
         kanZNmOv8NtI8F2CKN6PrBAEYuHx7zpcWcukAnvTdjY9XoY7GENn8pRh8kpNPV+kmf0r
         9Aag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765404334; x=1766009134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zf0CLyhh9XE4rR8idUFmiczPVQuqzFdqmqmc6AJeS+s=;
        b=1BDxB1mpiP7Ut3s24534/uK+dJLi5PO0kC80Jk+Vq26IzOCOLQ1oINrWDFLQxnjEZf
         3iOm15WZEKk2Awj/R8qxgoEkXZTT58MntWypUsb9L2Ryysrb4iz9xmc7Bu9RRBxdM91R
         MxL9ksVrtVX4+3tTkbLXGUTFem7o9HiHbpD/7AtgDrkl551xvDovvdI18sAw21hWE2qS
         8Q5l3+S1i4gN3zFS+n3hby+TTyyNzPOOougp01e3FAi+oY9ObKjR+/vGOmw6FW1vsh/z
         2suzbv38y+a+OzUNyTV1PpB1N9DyXQJRpuqFBEgHYFKHuzJSZU2xM3MgYc6qEWcIv5Qh
         VlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765404334; x=1766009134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zf0CLyhh9XE4rR8idUFmiczPVQuqzFdqmqmc6AJeS+s=;
        b=dfITl1LZLGzR2Bef7eU0NnqcKsT1KHaWFjKi4A9CVkvVWRk3HOIlpPVUGNny1LKeBz
         9Lp0JnfBl7cVn1PLklFOO0xsQ756eUuXYBv1DSag8uY5OTJwJH/tYBSg5RHRjScMk+kb
         ja+bhQI9hyr/og8CyxhQt3tr+z8U/CEulpJZNu/dnEH9JbaRyxfbHQzNE3ihEOJwP8s1
         gsvGRlnwGp9JDN+Uq2+ybxUkD8TAX3ebUtpphapvtCYXUUCW7ppU1s9qKmFKY6WvNhXu
         xsz+qiivP9UP7QLysOfgmrHK5c9yiGo688JYDUBqOv9JQnUBzAnyCXc/LTlHW/pwSfIf
         jZxg==
X-Forwarded-Encrypted: i=1; AJvYcCVVLgZlDCFjF3gCHN6Bd/YRIiTUEazauj4SPQ6Uatc0H2yH9CmSp3tp8Y/4zZd7Pa/z6oYAuVHlVFoWgTyCcv8k@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2WE0cfQxveq3IJUYD4tBvH8tPMSwlthLSlAoI2M9BazuUUDgR
	XFIxjd+4ELehtsn9MMF59fbw67b1YF6RE0/RTLU+Q24mCA+X8keqkrN3rNdevlFiXk+u53/z4fy
	Tf5FjIqy1YWzI+9UrLk0TDJaoQXPNv1p5BRJPGNsu
X-Gm-Gg: AY/fxX4hh6viF7kBgCIlI2D1LKpyfqvMLso08yLvaBdOZDCBMP3E8rp8hmm1FsffEsP
	p9xboylCU8XJxrwHEtmGI90WxY/cXbBB1wAktZEGJCDmkT11h062qGOAmBe1RouVb03dQgYsgkP
	cg6gWBwNljS7dDww4fjjgK+4BIvlL+mWzgv3te1jfeBY742lGcR3mnzYwXkl3QJu7qKcR9dz23l
	TOvVoLb22TXZ21XioK8dqzkHXz5BuuXV24xjRml/1VnSFNmL8z/cgnE8j2hExmlH6PJQZet
X-Google-Smtp-Source: AGHT+IEMPlf2j0Ecy0eDDIvDUE7c2ahNUI7yoLGruflKTBqKQOPy6xaufeGDm4K14X9HtIMXKb3tnuobtzLma+MdRVM=
X-Received: by 2002:a17:902:f544:b0:26d:72f8:8cfa with SMTP id
 d9443c01a7336-29eed44b201mr408415ad.13.1765404334209; Wed, 10 Dec 2025
 14:05:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210023327.1669863-1-namhyung@kernel.org>
In-Reply-To: <20251210023327.1669863-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Dec 2025 14:05:23 -0800
X-Gm-Features: AQt7F2qKGr2jBIWxCrmf2q-kRDQ4m-cDZSBnndf_wXmszy8dSdXpLWHt4Lzdqvs
Message-ID: <CAP-5=fXsrKvKAtAW3b-OzAdzg00hW-py-9eMvCxoY3Vs4p+7iw@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf record: Split --data-mmap option
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
> Currently -d/--data option controls both PERF_SAMPLE_ADDR bit and
> perf_event_attr.mmap_data flag.  Separate them using new --data-mmap
> option to support recording only one of them.
>
> For data-type profiling, data MMAP is unnecessary but it wastes a lot
> of space in the ring buffer and data file.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-record.txt |  8 +++++++-
>  tools/perf/builtin-record.c              | 19 +++++++++++++------
>  tools/perf/util/evsel.c                  |  5 +++--
>  tools/perf/util/record.h                 |  2 ++
>  4 files changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Docume=
ntation/perf-record.txt
> index e8b9aadbbfa50574..c402e74172f6a22d 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -344,7 +344,8 @@ OPTIONS
>
>  -d::
>  --data::
> -       Record the sample virtual addresses.  Implies --sample-mem-info.
> +       Record the sample virtual addresses.  Implies --sample-mem-info a=
nd
> +       --data-mmap.
>
>  --phys-data::
>         Record the sample physical addresses.
> @@ -861,6 +862,11 @@ filtered through the mask provided by -C option.
>         Prepare BPF filter to be used by regular users.  The action shoul=
d be
>         either "pin" or "unpin".  The filter can be used after it's pinne=
d.
>
> +--data-mmap::
> +       Enable recording MMAP events for non-executable mappings.  Basica=
lly
> +       perf only records executable mappings but data mmaping can be use=
ful
> +       when you analyze data access with sample addresses.  So using -d =
option
> +       would enable this unless you specify --no-data-mmap manually.
>
>  include::intel-hybrid.txt[]
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 2584d0d8bc820676..cbfbd9bb10634093 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1881,7 +1881,7 @@ static int record__synthesize_workload(struct recor=
d *rec, bool tail)
>                                                  process_synthesized_even=
t,
>                                                  &rec->session->machines.=
host,
>                                                  needs_mmap,
> -                                                rec->opts.sample_address=
);
> +                                                rec->opts.record_data_mm=
ap);
>         perf_thread_map__put(thread_map);
>         return err;
>  }
> @@ -2191,7 +2191,7 @@ static int record__synthesize(struct record *rec, b=
ool tail)
>
>                 err =3D __machine__synthesize_threads(machine, tool, &opt=
s->target,
>                                                     rec->evlist->core.thr=
eads,
> -                                                   f, needs_mmap, opts->=
sample_address,
> +                                                   f, needs_mmap, opts->=
record_data_mmap,
>                                                     rec->opts.nr_threads_=
synthesize);
>         }
>
> @@ -3006,8 +3006,9 @@ int record_opts__parse_callchain(struct record_opts=
 *record,
>         ret =3D parse_callchain_record_opt(arg, callchain);
>         if (!ret) {
>                 /* Enable data address sampling for DWARF unwind. */
> -               if (callchain->record_mode =3D=3D CALLCHAIN_DWARF)
> -                       record->sample_address =3D true;
> +               if (callchain->record_mode =3D=3D CALLCHAIN_DWARF &&
> +                   !record->record_data_mmap_set)
> +                       record->record_data_mmap =3D true;
>                 callchain_debug(callchain);
>         }
>
> @@ -3686,6 +3687,9 @@ static struct option __record_options[] =3D {
>         OPT_CALLBACK(0, "off-cpu-thresh", &record.opts, "ms",
>                      "Dump off-cpu samples if off-cpu time exceeds this t=
hreshold (in milliseconds). (Default: 500ms)",
>                      record__parse_off_cpu_thresh),
> +       OPT_BOOLEAN_SET(0, "data-mmap", &record.opts.record_data_mmap,
> +                       &record.opts.record_data_mmap_set,
> +                       "Record mmap events for non-executable mappings")=
,
>         OPT_END()
>  };
>
> @@ -4249,9 +4253,12 @@ int cmd_record(int argc, const char **argv)
>                 goto out_opts;
>         }
>
> -       /* For backward compatibility, -d implies --mem-info */
> -       if (rec->opts.sample_address)
> +       /* For backward compatibility, -d implies --mem-info and --data-m=
map */
> +       if (rec->opts.sample_address) {
>                 rec->opts.sample_data_src =3D true;
> +               if (!rec->opts.record_data_mmap_set)
> +                       rec->opts.record_data_mmap =3D true;
> +       }
>
>         /*
>          * Allow aliases to facilitate the lookup of symbols for address
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 9cd706f6279313c2..ec6552a6f667fec6 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1445,10 +1445,11 @@ void evsel__config(struct evsel *evsel, struct re=
cord_opts *opts,
>                 attr->inherit_stat =3D 1;
>         }
>
> -       if (opts->sample_address) {
> +       if (opts->sample_address)
>                 evsel__set_sample_bit(evsel, ADDR);
> +
> +       if (opts->record_data_mmap)
>                 attr->mmap_data =3D track;
> -       }
>
>         /*
>          * We don't allow user space callchains for  function trace
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index ea3a6c4657eefb74..93627c9a73387ddd 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -40,6 +40,8 @@ struct record_opts {
>         bool          record_cgroup;
>         bool          record_switch_events;
>         bool          record_switch_events_set;
> +       bool          record_data_mmap;
> +       bool          record_data_mmap_set;
>         bool          all_kernel;
>         bool          all_user;
>         bool          kernel_callchains;
> --
> 2.52.0.223.gf5cc29aaa4-goog
>
