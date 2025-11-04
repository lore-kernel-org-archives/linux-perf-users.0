Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3532D757EA
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Nov 2025 05:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762233372; cv=none; b=OAF1P0XfjI9tk0VYbjqO6jHxy160KozqHnd4D+CZE9u6I7x8AjFeJF3tYrAO1vxZC1+IwRn5HrJWceEY/wivJ9ct1L+5oTCCXmSSTmJZpXxUudWC0f+UcYXgwI45wCAhE94LmktbiTVfI4MGn/4O27ztgmv32bWWlUp9WNndbgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762233372; c=relaxed/simple;
	bh=nBA5miH7/Qz55ZmhSHMlH75RHc06u1G1Vw5QkkRj+9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nv6gYtS1JhjPXw4+o1+H0Rsn59usZhwW67y+3np/xD6/k+Zy2/WJtCMd6KoVS4VymknRwXSXsSuhYCzoF4tgx5s814cBLmr8t+vXqVJsAOJJTS5VN0JnMyMts70D+2g6xZX/OzIqJwH8MdGu0JaXxi4sviLFsUnLQ8DpyqnhJLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B0Fkoi4V; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B0Fkoi4V"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27d67abd215so130355ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Nov 2025 21:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762233369; x=1762838169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtkcQ+7QlbPCMjWQf4qR2PUXjMqZjQBaQE63KR+6lZI=;
        b=B0Fkoi4VZ0UZS/EP9QjXSF6To+1YKY0ubWUR+Fqias3xGgpUWOml4o6Tfqn7kKQ7bt
         Zi9hMFMRhTj7Tir+6znEAsRCxdtPB7YTpwn8wqIIl+pxX5MSnuKyP4QZjibvG1czc7tn
         FNxxifsc4jXtbpQDYUcTaij9mXuDSDZKhjiuwgR9/K2uccYoctiDVrpK+Yuhx1T+HxkM
         enpIefRsLk5EVe7l436ubcMjiL11ot6EaCSysXfqShiVQuaopj87BkqZ26aX0tsQGTCz
         lQbqB7ZDOtU43DHpFGwqKMzeuc8qaKJQSY3sWLq6pXJ+pLVAm+LB1pW3Lh61sgvO/7Pm
         XoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762233369; x=1762838169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtkcQ+7QlbPCMjWQf4qR2PUXjMqZjQBaQE63KR+6lZI=;
        b=ANrOnZr5s1ItYgM8OFMzQ9jINhfbScOIPYjTKbqUXoZJI2pNL/8KbyicI7973cCaa4
         sZLDGPgoAQzNxkec/t0bmQhqqpQi1jlbpjcQyC2CVef+a/VhyJmLUp39ezQu1d9viH5S
         EeJNKX5URq2vTOevAQVPnP9gQQTRmdrqpRTpu2xUecHRlL+THqrAPkfILroDMOHiWqzT
         fFPPxzGb7s+W04QmfToTcuJFXuyLJWor/VnAupRYbM+ICSZFn0r537sVl4LL1UeYZxEY
         h1Io5/2We/FpidApaUiJv3OCOCYB/HFgKYpP72BVI39baipPE0Ryg4JuSd5vYpzUlb1k
         sWew==
X-Forwarded-Encrypted: i=1; AJvYcCWyNn3SBxA1G7oWJ62IWZwd/xA+MSLjVv44yYsKUYdMeFKTR6HLNNs0Q9YL7m1A1kfN0MVNMWaFcWqchYJU1Jap@vger.kernel.org
X-Gm-Message-State: AOJu0YwzoWF8cSvlQWalV8TuAwkRcYuEtnCiwOdjhPliPtej5pMXl2RZ
	AtpYKC3n2dxewh625JkkROftrQuoUTkkzZej3pCWxiWtWpJtv5K/cI2g6EeJ5hje+O+JBuXiwJl
	kVDIcMxDsMaYlkE6BSTRWB4+VIscqqWtQnJtAMZxJ
X-Gm-Gg: ASbGncuIp+q+gWhE0FebPt35UdmsE/EMAK38cJfK2u4lBBfz/JLthYK8fEbf7lxQylo
	b3VZYgnYv7dEUZP5a3zsFIvNhdYUB0mCRuhqiwhJGzPXtrXikp3WAEEAneCeTpgoAehcgeLo/vZ
	F7rZU7SL1qb2a8d+r3y1tsaXytP1e+oBCGrY41j6LN0zfRHhRr7jzCUyrn8aDwU2D6TePIHFliw
	mulSMIjohO2XGskgojZIFtLBs8xr4qBPqeQ+Spfo+c8VAQr1UusEtaBjpE0
X-Google-Smtp-Source: AGHT+IGmW8nRI10W77Cb5vNSTQ/6CVF/p1MggMX7AIzvbiRI1Vjs0B0mstlxdO9pox65Yw5H0W2MFZw7WDk1KSwyyTo=
X-Received: by 2002:a17:903:22c1:b0:293:2a8:3f9b with SMTP id
 d9443c01a7336-29601e363c7mr1873545ad.15.1762233368825; Mon, 03 Nov 2025
 21:16:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104042632.1560922-1-namhyung@kernel.org>
In-Reply-To: <20251104042632.1560922-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Nov 2025 21:15:57 -0800
X-Gm-Features: AWmQ_bnI1d3ADTxfRC455NMxgRnbXNF-EzyzxTtyhbBh1UhqvfJydtyoSo9VKuE
Message-ID: <CAP-5=fWuAx-uKp0g__hy9zQQiir83_KCVY4XzjW8uob3Coox7w@mail.gmail.com>
Subject: Re: [PATCH] perf record: Make sure to update build-ID cache
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 8:26=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Recent change on enabling --buildid-mmap by default brought an issue
> with build-id handling.  With build-ID in MMAP2 records, we don't need
> to save the build-ID table in the header are of a perf data file.

nit: s/are of/of/

>
> But the actual file contents still need to be cached in the debug
> directory for annotation etc.  Split the build-ID header processing and
> caching and make sure perf record to save hit DSOs in the build-ID cache
> by moving perf_session__cache_build_ids() to the end of the record__
> finish_output().

The changes to builtin-record look okay, but do we need to worry about
`perf mem record` and similar? The header change will impact all
perf.data file generation.

Thanks,
Ian

>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-record.c | 30 +++++++++++++++---------------
>  tools/perf/util/header.c    |  1 -
>  2 files changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index ffb94a8339b03ec2..fe10bb7f35cbea05 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1890,15 +1890,14 @@ record__finish_output(struct record *rec)
>         }
>
>         /* Buildid scanning disabled or build ID in kernel and synthesize=
d map events. */
> -       if (!rec->no_buildid) {
> +       if (!rec->no_buildid || !rec->no_buildid_cache) {
>                 process_buildids(rec);
>
>                 if (rec->buildid_all)
>                         perf_session__dsos_hit_all(rec->session);
>         }
>         perf_session__write_header(rec->session, rec->evlist, fd, true);
> -
> -       return;
> +       perf_session__cache_build_ids(rec->session);
>  }
>
>  static int record__synthesize_workload(struct record *rec, bool tail)
> @@ -3083,7 +3082,7 @@ static int perf_record_config(const char *var, cons=
t char *value, void *cb)
>                 else if (!strcmp(value, "no-cache"))
>                         rec->no_buildid_cache =3D true;
>                 else if (!strcmp(value, "skip"))
> -                       rec->no_buildid =3D true;
> +                       rec->no_buildid =3D rec->no_buildid_cache =3D tru=
e;
>                 else if (!strcmp(value, "mmap"))
>                         rec->buildid_mmap =3D true;
>                 else if (!strcmp(value, "no-mmap"))
> @@ -4192,24 +4191,25 @@ int cmd_record(int argc, const char **argv)
>                 record.opts.record_switch_events =3D true;
>         }
>
> -       if (!rec->buildid_mmap) {
> -               pr_debug("Disabling build id in synthesized mmap2 events.=
\n");
> -               symbol_conf.no_buildid_mmap2 =3D true;
> -       } else if (rec->buildid_mmap_set) {
> -               /*
> -                * Explicitly passing --buildid-mmap disables buildid pro=
cessing
> -                * and cache generation.
> -                */
> -               rec->no_buildid =3D true;
> -       }
>         if (rec->buildid_mmap && !perf_can_record_build_id()) {
>                 pr_warning("Missing support for build id in kernel mmap e=
vents.\n"
>                            "Disable this warning with --no-buildid-mmap\n=
");
>                 rec->buildid_mmap =3D false;
>         }
> +
>         if (rec->buildid_mmap) {
>                 /* Enable perf_event_attr::build_id bit. */
>                 rec->opts.build_id =3D true;
> +               /* Disable build-ID table in the header. */
> +               rec->no_buildid =3D true;
> +       } else {
> +               pr_debug("Disabling build id in synthesized mmap2 events.=
\n");
> +               symbol_conf.no_buildid_mmap2 =3D true;
> +       }
> +
> +       if (rec->no_buildid_set && rec->no_buildid) {
> +               /* -B implies -N for historic reasons. */
> +               rec->no_buildid_cache =3D true;
>         }
>
>         if (rec->opts.record_cgroup && !perf_can_record_cgroup()) {
> @@ -4306,7 +4306,7 @@ int cmd_record(int argc, const char **argv)
>
>         err =3D -ENOMEM;
>
> -       if (rec->no_buildid_cache || rec->no_buildid) {
> +       if (rec->no_buildid_cache) {
>                 disable_buildid_cache();
>         } else if (rec->switch_output.enabled) {
>                 /*
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 4f2a6e10ed5cc0bd..4de7ca16b5522c47 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -335,7 +335,6 @@ static int write_build_id(struct feat_fd *ff,
>                 pr_debug("failed to write buildid table\n");
>                 return err;
>         }
> -       perf_session__cache_build_ids(session);
>
>         return 0;
>  }
> --
> 2.51.2.997.g839fc31de9-goog
>
