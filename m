Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38FF2B9A9;
	Mon, 11 Nov 2024 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348629; cv=none; b=b9p+KmrJDLUVirEiPdZM4ThXCbiG+PFyqdOZKVAF4ZpTt//OWty2R7WaZpjc0m2Qx9i7VArAmNnNl8SCMZTDcIarVCpfZNklMbLqsnJXMMBxOS2cfAXLuSVkUC1rW37sZiAxZhoSoG9nk7fxcExX/8W4w1iFLkcVkOa7ROLDsEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348629; c=relaxed/simple;
	bh=KVQbaVfnsvZbaShHbiM3dinKsf/mPrc06yjMtqn9jEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdnI6YRPKIMqE0zWR8WvRLhUfiQxsM6KJMtOPO9fZzIKLX4MdA3l9R2ijNrSIxzmiCHnAnI8vP6lt6wpYEk/kCg3GtlC2e9fnBlLppFdk1XaNyexCUsf7KXSiJVVHAVrZlMd8X1MONljVKketRPZZWQlW2Hqdz5C0Fv0EvELCOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zxt4CgIZ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zxt4CgIZ"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ea8419a57eso49569157b3.1;
        Mon, 11 Nov 2024 10:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731348627; x=1731953427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dr3t1x7HP1NO5f0yrodeNYm5JayGOZwIg+TjEcYTq4=;
        b=Zxt4CgIZai7eypGmYK8FyV0VZtq11k2GpOrGTyCpFJp+W2trWeCXQeJOv+SIyd4YR5
         MUpThXVTGAwcj6zFdoHz4p1zDJ1JG7KeQUzkcHTYHfTUV9ROgzWpBV+UHXVUmzpHDwQh
         NzehBskm+uPG5MtIaq1ip/KVVn2tL/p6iqwO5d13/icsF3qffgNchiRWd9neZ/1VuZbF
         nWHM6bpZ3sNEhAf8qH283cT6mG0KrQ12C7co7bbAbvpYClXgbX1eJ/evTxoi2mKVAyYW
         5qbi+mEvEuvR/HY25THQvR9GtWxdmyVUNWXDPWH3lJM1HbXWkIBmIoAMK9xZSgWszkGH
         uJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731348627; x=1731953427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dr3t1x7HP1NO5f0yrodeNYm5JayGOZwIg+TjEcYTq4=;
        b=N3AfkH8TTYVbI6NHmpBan+o4KIsG0TVuccLaOYeUvVLAkG3Y9uT6Q8pm65PP56QCzc
         EU2eVJYuAJqb9TDhEg5cG8HIluc3qxebKayRFWSA+ltBgtYP/Dpjo3dbS+k+g/chzA0N
         iqHxryajHaEDXKlEIPQhwZOKjvgrcaT4vAU5/MP5td+7YlhzaQz6HfCTcvZ/H1CVS+/Y
         +HiiZTRzyzHA8B2gydZ0MjGHuzAcFMbQK0bmtZARUSomt1egkdoEy5+jk5SNPTg5tGnW
         27hZPTszQl8PBoX66ft3czBkUqCWZghPLRgiu/uHxCtIlSqZ9m5Ck3ppvKVwi2aIlcd9
         UBOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNK08d+agj1/1+Ed65w7JQv7FvB7HCq7bhdeCydVFpkhfxltKSHRYql+hbnboukLM7PBkUWyEmiICK004=@vger.kernel.org, AJvYcCVfck1VnMS9h5bUATDk7yVltetDXAOUtuyDF1hScKjjsGEwiALJnUTKhuypoy7J4hviRLqtAvQ2o1m9cY2EAH8vAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVs6pW6IKcpyg7dPKzkehtOQsvWAhdqUBhCUZTUerbYCWGpbQ2
	sIpvanDfpGbv3bIY7W4nENG2m1dZjeKCuFIc/PMheh6cpyho6ujGwUfouD11IBTK5Z75FA+4QhM
	CSsOJCKb9oyfPxe+pfKh+IpvJqTU=
X-Google-Smtp-Source: AGHT+IF9O2x9ZNWM0IjG3Zn5hEu1pIfyV/KMjTZavD5IEBgatDz2fYO7iABluw3ldAxoUbKkOAl7k4LK/pTMneUhSNc=
X-Received: by 2002:a05:690c:620a:b0:6e3:420f:a2d1 with SMTP id
 00721157ae682-6eadddb0f82mr124102007b3.23.1731348626804; Mon, 11 Nov 2024
 10:10:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108204137.2444151-1-howardchu95@gmail.com>
 <20241108204137.2444151-4-howardchu95@gmail.com> <CAP-5=fW4pKRdmiQ5J4mdzVfXgKpnzHxHWooSktp5xsy68FQKaA@mail.gmail.com>
In-Reply-To: <CAP-5=fW4pKRdmiQ5J4mdzVfXgKpnzHxHWooSktp5xsy68FQKaA@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 11 Nov 2024 10:10:15 -0800
Message-ID: <CAH0uvog4RCPZEF3zwuvnj=dBqbvhC1hP08DVsJyP-DLPOzHtBg@mail.gmail.com>
Subject: Re: [PATCH v7 03/10] perf record --off-cpu: Parse off-cpu event
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, peterz@infradead.org, namhyung@kernel.org, 
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Nov 11, 2024 at 9:45=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Nov 8, 2024 at 12:41=E2=80=AFPM Howard Chu <howardchu95@gmail.com=
> wrote:
> >
> > Parse the off-cpu event using parse_event, as bpf-output.
> >
> > no-inherit is should be set to 1, here's the reason:
>
> nit: s/is should be/should be/

Interesting sed substitution format.

Good catch! I will fix that in a next commit, thanks!

>
> > We update the BPF perf_event map for direct off-cpu sample dumping (in
> > following patches), it executes as follows:
> >
> > bpf_map_update_value()
> >  bpf_fd_array_map_update_elem()
> >   perf_event_fd_array_get_ptr()
> >    perf_event_read_local()
> >
> > In perf_event_read_local(), there is:
> >
> > int perf_event_read_local(struct perf_event *event, u64 *value,
> >                           u64 *enabled, u64 *running)
> > {
> > ...
> >         /*
> >          * It must not be an event with inherit set, we cannot read
> >          * all child counters from atomic context.
> >          */
> >         if (event->attr.inherit) {
> >                 ret =3D -EOPNOTSUPP;
> >                 goto out;
> >         }
> >
> > Which means no-inherit has to be true for updating the BPF perf_event
> > map.
> >
> > Moreover, for bpf-output events, we primarily want a system-wide event
> > instead of a per-task event.
> >
> > The reason is that in BPF's bpf_perf_event_output(), BPF uses the CPU
> > index to retrieve the perf_event file descriptor it outputs to.
> >
> > Making a bpf-output event system-wide naturally satisfies this
> > requirement by mapping CPU appropriately.
> >
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/util/bpf_off_cpu.c | 33 +++++++++++----------------------
> >  1 file changed, 11 insertions(+), 22 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cp=
u.c
> > index a590a8ac1f9d..558c5e5c2dc3 100644
> > --- a/tools/perf/util/bpf_off_cpu.c
> > +++ b/tools/perf/util/bpf_off_cpu.c
> > @@ -38,32 +38,21 @@ union off_cpu_data {
> >
> >  static int off_cpu_config(struct evlist *evlist)
> >  {
> > +       char off_cpu_event[64];
> >         struct evsel *evsel;
> > -       struct perf_event_attr attr =3D {
> > -               .type   =3D PERF_TYPE_SOFTWARE,
> > -               .config =3D PERF_COUNT_SW_BPF_OUTPUT,
> > -               .size   =3D sizeof(attr), /* to capture ABI version */
> > -       };
> > -       char *evname =3D strdup(OFFCPU_EVENT);
> > -
> > -       if (evname =3D=3D NULL)
> > -               return -ENOMEM;
> >
> > -       evsel =3D evsel__new(&attr);
> > -       if (!evsel) {
> > -               free(evname);
> > -               return -ENOMEM;
> > +       scnprintf(off_cpu_event, sizeof(off_cpu_event), "bpf-output/no-=
inherit=3D1,name=3D%s/", OFFCPU_EVENT);
> > +       if (parse_event(evlist, off_cpu_event)) {
> > +               pr_err("Failed to open off-cpu event\n");
> > +               return -1;
>
> Woot, love this! Much happier to see parse_events being used than hand
> crafted attributes. This will help us keep things synchronized via
> event parsing.
>
> Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks,
> Ian
>
> >         }
> >
> > -       evsel->core.attr.freq =3D 1;
> > -       evsel->core.attr.sample_period =3D 1;
> > -       /* off-cpu analysis depends on stack trace */
> > -       evsel->core.attr.sample_type =3D PERF_SAMPLE_CALLCHAIN;
> > -
> > -       evlist__add(evlist, evsel);
> > -
> > -       free(evsel->name);
> > -       evsel->name =3D evname;
> > +       evlist__for_each_entry(evlist, evsel) {
> > +               if (evsel__is_offcpu_event(evsel)) {
> > +                       evsel->core.system_wide =3D true;
> > +                       break;
> > +               }
> > +       }
> >
> >         return 0;
> >  }
> > --
> > 2.43.0
> >

Thanks,
Howard
