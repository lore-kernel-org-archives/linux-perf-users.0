Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CF7218D9C;
	Tue, 12 Nov 2024 20:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441803; cv=none; b=ETZZolwQVjZSkywRvBuhv+7MM1ieTSGNGorp/R0hg4DEya1YllAeODVLupiiYwqvsPjIf/YftAUsAyJ1KPwePOin+A5SpskH1McPDdaM9OZHPdkj3cDB56yZoJuZr5bsYdx+ysIz+f1lKgAUu00NGneCWFkuU3T82EXrC4GzAoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441803; c=relaxed/simple;
	bh=+dL5joqQEoOQyTgA9I9iIGbUujcLDHu/Vy8nb3QV2rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnyKLXD9fkqFiiBav2gAHUW2gNF32BVlZ1W3JxuizYzS8OYomHsaX7gYr9JWqdgbXwh9B9/Yer3mHihvNT7JRE12ORFT4wb2hP132y2yLB0FC2frRipatWrCyfjclfuO9mggKevvC36f/DB1gbACfo6NxCke5CwkSyA/odDYgjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JG/IVoBC; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG/IVoBC"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ecaa45af7bso10309897b3.3;
        Tue, 12 Nov 2024 12:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731441799; x=1732046599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2ikG77xsibCQ/i00CuU3i59fJjIm4fHdwxhmh9JpFE=;
        b=JG/IVoBCVJEPZ+niXizHfk4sEHDM6YRTGtYMOGvu6x+vu0KYHKxmlBbKtV2aev5mYn
         LKDjyJVJ5eq6Am7JPwXrM1/1C4626VuF3o46Pe5KTltin+c/AkrF1mfZf/xfERWSzHip
         AVOMxL16zwkKyq9V8V5NzX1PyChgid350zF6uKncFL9oF0jj4OJk9m2R8UAr89AYqtZO
         N5J+5Jk2jxQmo9QLvAmfJEniywbO7TXVUHXLzz5BktSnWXunG7LCPAhGogAaCQ6TAxGI
         bLIS6d+RSCqRA+RDQOXkZy7WLTzj9okvOC+uM/hWzK+yqDpwgYL6gDA1xuXxImeEnImz
         LMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731441799; x=1732046599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2ikG77xsibCQ/i00CuU3i59fJjIm4fHdwxhmh9JpFE=;
        b=URtZCMLl0wfZL0SjyY80vZDmu9NR4C6OwP0O65KnmCmbMGqiDnwBCka4O9CnGoullJ
         lLhxhsC1kv3TyarrAAvnayBml0y+dtpRlRqWTUQDXzjNhsH3XEu2mOmnEZ1BlG5IRnHM
         sX/3gDbReSxpZtmLkSipPamPRF1CTIqXfSC3+f+kKhgWQoKGzHU7Q8y//Gyyvd5N49fd
         wURt73+iWJUjs4IcQMdOvMD5nLRsuHIX9lsN9RF3hy80HvWWypP94XF+P85C5KuKE7V7
         b7cRRlWO/rPIRc71EEkD48l1oNxEZDOA+pvOcDmfmlHoXMcsfn7Ppt7PfhkqDx5zTF5L
         49hA==
X-Forwarded-Encrypted: i=1; AJvYcCWt1N7FTS101uGMucC9k7CHg7PCr/6c1afNo0/FP85rd4EhQiGkzo5qAhBLVzH9YPId755ojqpoT574iRc=@vger.kernel.org, AJvYcCX6sgEMtHis08ZIaAvTtZJe2dp7oSIxD8yRthJtycZU07BF79nQarVTaD/Y3cGFzTFphVoHTM5idU1aCQ5mxWhv+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxX6QGPhry1fJgU5Lc4VVPoa6qDdd0irJOLffvTrQufRCYhgx5m
	bIPARD2w6REbsU4UIMKKHJ27kIU7GCdRt4facMLYeIA3RKntE1aYCrdQO8Wk0ZsKpFSQ+KyAGof
	B7oDrX959W+vUAWcriIWzuRB66NE=
X-Google-Smtp-Source: AGHT+IFc8p1sQzQ/Ynvtbaa7paWVhq2n5YAsoNjc2mUXJLZALuvjAlL/qgTlYAYyg81M4XdFP774TwnOqIjQp1Oz2qM=
X-Received: by 2002:a05:690c:7083:b0:6ea:7bbe:56ef with SMTP id
 00721157ae682-6ecb32cd97amr3676767b3.16.1731441799584; Tue, 12 Nov 2024
 12:03:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108204137.2444151-1-howardchu95@gmail.com>
 <ZzOg3Xlq2jsG85XQ@x1> <ZzOpvzN-OTLZPyFh@x1> <ZzOy2KjyuMD9AJ3G@x1>
In-Reply-To: <ZzOy2KjyuMD9AJ3G@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 12 Nov 2024 12:03:09 -0800
Message-ID: <CAH0uvojpYb17k6=PeJ6bz9cj2RSYyiDccgm1jnYRGmx4Hw4C=Q@mail.gmail.com>
Subject: Re: [PATCH v7 00/10] perf record --off-cpu: Dump off-cpu samples directly
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, namhyung@kernel.org, irogers@google.com, 
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Nov 12, 2024 at 11:56=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Nov 12, 2024 at 04:17:19PM -0300, Arnaldo Carvalho de Melo wrote:
> > I squashed the patch below and I'm trying to apply the other patches to=
 do some
> > minimal testing on the feature itself, but the organization of the
> > patches needs some work.
>
> > +++ b/tools/perf/util/bpf_off_cpu.c
> > @@ -61,6 +61,9 @@ static int off_cpu_config(struct evlist *evlist)
> >  static void off_cpu_start(void *arg)
> >  {
> >       struct evlist *evlist =3D arg;
> > +     struct evsel *evsel;
> > +     struct perf_cpu pcpu;
> > +     int i;
> >
> >       /* update task filter for the given workload */
> >       if (skel->rodata->has_task && skel->rodata->uses_tgid &&
> > @@ -82,6 +85,8 @@ static void off_cpu_start(void *arg)
> >       }
> >
> >       perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
> > +             int err;
> > +
> >               err =3D bpf_map__update_elem(skel->maps.offcpu_output, &p=
cpu.cpu, sizeof(__u32),
> >                                          xyarray__entry(evsel->core.fd,=
 i, 0),
> >                                          sizeof(__u32), BPF_ANY);
>
> This is not enough, as it in the end tries to use that
> skel->maps.offcpu_output that is only introduced at a later patch, it
> seems, not checked yet, but explains the error below:
>
>   LD      /tmp/build/perf-tools-next/perf-test-in.o
>   AR      /tmp/build/perf-tools-next/libperf-test.a
>   CC      /tmp/build/perf-tools-next/util/parse-events.o
> util/bpf_off_cpu.c: In function =E2=80=98off_cpu_start=E2=80=99:
> util/bpf_off_cpu.c:90:54: error: =E2=80=98struct <anonymous>=E2=80=99 has=
 no member named =E2=80=98offcpu_output=E2=80=99
>    90 |                 err =3D bpf_map__update_elem(skel->maps.offcpu_ou=
tput, &pcpu.cpu, sizeof(__u32),
>       |                                                      ^
> make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:1=
06: /tmp/build/perf-tools-next/util/bpf_off_cpu.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:1=
58: util] Error 2
> make[2]: *** [Makefile.perf:789: /tmp/build/perf-tools-next/perf-util-in.=
o] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   CC      /tmp/build/perf-tools-next/pmu-events/pmu-events.o
>   LD      /tmp/build/perf-tools-next/pmu-events/pmu-events-in.o
> make[1]: *** [Makefile.perf:292: sub-make] Error 2
> make: *** [Makefile:119: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> =E2=AC=A2 [acme@toolbox perf-tools-next]$
>
>
> Ok, at the end of the series it builds, and the 'perf test' entry
> introduced in this series passes:
>
> root@x1:~# perf test off
> 121: perf record offcpu profiling tests                              : Ok
> root@x1:~# perf test -v off
> 121: perf record offcpu profiling tests                              : Ok
> root@x1:~# perf test -vv off
> 121: perf record offcpu profiling tests:
> --- start ---
> test child forked, pid 1303134
> Checking off-cpu privilege
> Basic off-cpu test
> Basic off-cpu test [Success]
> Child task off-cpu test
> Child task off-cpu test [Success]
> Direct off-cpu test
> Direct off-cpu test [Success]
> ---- end(0) ----
> 121: perf record offcpu profiling tests                              : Ok
> root@x1:~#
>
> But the only examples I could find so far for this feature were on the
> 'perf test' at the end of this series.
>
> I think we need to have some examples in the 'perf-record' man page
> showing how to use it, explaining the whole process, etc.
>
> I'll continue testing it and trying to move things around so that it
> gets bisectable and testable step by step, documenting the whole
> process as I go, probably tomorrow.
>
> The series with my fixes is at:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git =
perf-off-cpu77918
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
log/?h=3Dperf-off-cpu

Thank you, I'll use that as the base of v8 :), adding Ian's suggestions.

>
>
> - Arnaldo

Thanks,
Howard
