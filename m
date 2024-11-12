Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5BB217919;
	Tue, 12 Nov 2024 20:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731444763; cv=none; b=e6PvNw7qoW66q8NB5fj88ScfpuF18TzU8hC11f+JbMdaoBPFdKp5YsWoeCizXt1ecm4IVfTMgSQBQVkyERjToTamjKbos4NSEeg3izIiQ7XWpRHU8Y9nPilE+iuWp0cG5Xhx4tgdFjuXv6f2pcY70p30N8dZAcc8m7hR7iF3+Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731444763; c=relaxed/simple;
	bh=9GMfZQ5Ip9KHeMMy0DqnWqvkp/JNNRJp6GKyIdRHYew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cA/77/vxdRgVh/B3fmzzq0jK4tc9DcEYLG8aMjkt21KmkmpN31xQ/oI1aQhJUm2H+d+gbYMZtCJzAZuPmQxz0aWTv+z2xoswpiY+9vzfzRDh3ImVQw7LX4E98V9txjjDETVEzA2nlaeGCgr00l4mC5ZH70/OGUWM03VMvlAVBko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZuzibMm; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZuzibMm"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ea8419a57eso65119537b3.1;
        Tue, 12 Nov 2024 12:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731444760; x=1732049560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aTdOwZNBTcb2LQzKC0Do+9aYHX1AwZT62fazeLw4DY=;
        b=lZuzibMmWj6MQQUmpYsBoxoLqy69O1xAcnIsMnYDa8h9n5ItCaL6nbLovIZeiUVYhJ
         B9eLoC4tZKUB5TB1sT1NlRVZz7xGhATGXhGcpiZSX4YoIsYn5yL2fIiNK6nOOj78yEoL
         cfrWY3T5qtBpsNYQP35cJ59v+1NVkMsYNZ6KJQfD1c3Uwi39LzIMVquJVqeBYAvzjTlw
         zTGZKsVF7rWAHfJE4g9Nu9tSKwTvxDpPxdIKciKv80ba4Zk7NhXVmDNHF7t7UTVrSHmJ
         TKSu30o+unWWJis/jQGGNIEjrTk6SlWnNb1r8M+jIeDy2Y8jxnmNBxAqbVzcLZE/tk+i
         JRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731444760; x=1732049560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aTdOwZNBTcb2LQzKC0Do+9aYHX1AwZT62fazeLw4DY=;
        b=ryL2DWalVZShXW87ONvtV/5qlZNrDNGOe38h3p4WmxSeNqYbHm19qg1uS0WK0e4BeY
         6vInF4GdKgjmPy3uqp5YkJ8o/ngK/8Jk9lQrlOauIUkOadKg3qBo3L+Qz447fpWJ393w
         uitVyBXmZ6Xb2kRGgQDxknprpWGtHSQuLR9EJzgIvN7LXqNVcXw6XVu8bULlsURrpJ/y
         LZHd9zk3ATsATxYqzYV1CTtl7+3MmqI/ZUFX04g83VPZfaYrNXDhDhO8z4fgiVycFiUl
         pjR2cRNqsAN98UAwPe/ZknDZAeiSuXXyc2cS44oTtudWPryhRZjL0PWsMP9bfqpWILcs
         TE3w==
X-Forwarded-Encrypted: i=1; AJvYcCV4MLiNA9SHuuQYLnOQrqC6EDb9hL7z7i9SluyQYd2TDxPWlNCbf1vure2vBKUtXq/FSONPazh4terDhtY=@vger.kernel.org, AJvYcCWcnamgfkPQZRb2gf2DqUNt16Y3u54bdNFJzC7ekf7UaZkH+OnK8eGGUBtTxX5gNfPhXO7JnmeoxQtuhx+dqMO3FQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy28HUQCckK27ZtgysjDPNxYxW16ASqJQ8slKBZ4Kkx66CCzELh
	CSrUXF1mlI0oEiHQGhhg4c2maLEMVJtNIR8v14NZuw4WobB+hv8VOzOe1irQoyj41OGsN5LxpyP
	souVIAPMznQPHQBW1CApXnp59KEc=
X-Google-Smtp-Source: AGHT+IF7dzOX/zvcy0OGiIP17c32BwGtbUHj2hIdt0DWLi5dgQk78VIUEBg2g+QptCmHoAEM9VZpj6KlNoaKUI6Jly0=
X-Received: by 2002:a05:690c:9b10:b0:6d7:f32:735b with SMTP id
 00721157ae682-6eadde3dacamr166872777b3.27.1731444759030; Tue, 12 Nov 2024
 12:52:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108204137.2444151-1-howardchu95@gmail.com>
 <20241108204137.2444151-5-howardchu95@gmail.com> <CAP-5=fV8_DxYxKy4A71z0gb82u8W+8qGXvVDSEW2A1GOfSf=oA@mail.gmail.com>
In-Reply-To: <CAP-5=fV8_DxYxKy4A71z0gb82u8W+8qGXvVDSEW2A1GOfSf=oA@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 12 Nov 2024 12:52:29 -0800
Message-ID: <CAH0uvogqT9w7nY7gCyD_agXzTvfbGr1ywrBf-U2OPB2ZN9OqTQ@mail.gmail.com>
Subject: Re: [PATCH v7 04/10] perf record --off-cpu: Preparation of off-cpu
 BPF program
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, peterz@infradead.org, namhyung@kernel.org, 
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,


On Mon, Nov 11, 2024 at 9:47=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Nov 8, 2024 at 12:41=E2=80=AFPM Howard Chu <howardchu95@gmail.com=
> wrote:
> >
> > Set the perf_event map in BPF for dumping off-cpu samples.
> >
> > Set the offcpu_thresh to specify the threshold.
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/util/bpf_off_cpu.c          | 20 ++++++++++++++++++++
> >  tools/perf/util/bpf_skel/off_cpu.bpf.c |  2 ++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cp=
u.c
> > index 558c5e5c2dc3..cfe5b17393e9 100644
> > --- a/tools/perf/util/bpf_off_cpu.c
> > +++ b/tools/perf/util/bpf_off_cpu.c
> > @@ -13,6 +13,7 @@
> >  #include "util/cgroup.h"
> >  #include "util/strlist.h"
> >  #include <bpf/bpf.h>
> > +#include <internal/xyarray.h>
> >
> >  #include "bpf_skel/off_cpu.skel.h"
> >
> > @@ -73,6 +74,23 @@ static void off_cpu_start(void *arg)
> >                 bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
> >         }
> >
> > +       /* update BPF perf_event map */
> > +       evsel =3D evlist__find_evsel_by_str(evlist, OFFCPU_EVENT);
> > +       if (evsel =3D=3D NULL) {
> > +               pr_err("%s evsel not found\n", OFFCPU_EVENT);
> > +               return;
> > +       }
> > +
> > +       perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
> > +               err =3D bpf_map__update_elem(skel->maps.offcpu_output, =
&pcpu.cpu, sizeof(__u32),
> > +                                          xyarray__entry(evsel->core.f=
d, i, 0),
> > +                                          sizeof(__u32), BPF_ANY);
> > +               if (err) {
> > +                       pr_err("Failed to update perf event map for dir=
ect off-cpu dumping\n");
> > +                       return;
> > +               }
> > +       }
> > +
> >         skel->bss->enabled =3D 1;
> >  }
> >
> > @@ -261,6 +279,8 @@ int off_cpu_prepare(struct evlist *evlist, struct t=
arget *target,
> >                 }
> >         }
> >
> > +       skel->bss->offcpu_thresh =3D opts->off_cpu_thresh * 1000;
> > +
> >         err =3D off_cpu_bpf__attach(skel);
> >         if (err) {
> >                 pr_err("Failed to attach off-cpu BPF skeleton\n");
> > diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/b=
pf_skel/off_cpu.bpf.c
> > index c152116df72f..dc6acafb9353 100644
> > --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > @@ -97,6 +97,8 @@ const volatile bool uses_cgroup_v1 =3D false;
> >
> >  int perf_subsys_id =3D -1;
> >
> > +__u64 offcpu_thresh;
>
> nit: would be nice to include the unit in the variable name, ie
> offcpu_thresh_us.

I didn't see it yesterday sorry, but in BPF the unit should be
nanosecond, so I'll do offcpu_thresh_ns.

Thanks,
Howard

>
> Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks,
> Ian
>
> > +
> >  /*
> >   * Old kernel used to call it task_struct->state and now it's '__state=
'.
> >   * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
> > --
> > 2.43.0
> >
