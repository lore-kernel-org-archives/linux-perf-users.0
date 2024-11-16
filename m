Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7B417BA9;
	Sat, 16 Nov 2024 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731768188; cv=none; b=lKp++vvoDzJUpYQIhBCHFrmtMwy6zzRyKUMhQfRi98WPgFbB6AWq/vvBLzoAT7fBGPGwd2KsGiyRmausjvupHNKmXakTIwpZhNlBgl/MwU9lPVgTKL5Ew+lu2QJgSBPhHm+fsmYejLnD+w4XcJeAuTD3Iy53C7PyNdmIV00ob6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731768188; c=relaxed/simple;
	bh=e4C99wW2UPPIu5P1AuOTYlKstuvypUmsKgze6j6XC4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8lIz+gBSvECl4xKdrQGOAIic8uWV193a+dDvnbdNgvXKE25Mkdj1zJrBkOjL9a+OuApLvIKHY30RSk57PUCG4DRuGjdl92W42OUCDttcYucP0bZSh8Ih6ufYZY2a+Er1Us8IcdQmGJW8aZemcthdItDbJbXuYHVja49Xnl8718=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7FrMwOF; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7FrMwOF"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e38ebcc0abso31214077b3.2;
        Sat, 16 Nov 2024 06:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731768186; x=1732372986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnLlPzgn///5qxbj/KGMB5xH9xngFzG+evdzDcbKohA=;
        b=D7FrMwOF2oZ7D5kiVP70QGG503cuvka7riF4yL4DxCyT77bhFMgovO+2bO53uqauT8
         VjcZtbvF/K7wffxt347Nq+h5i8qAo8UMdLTkKW2AMjhdeaZDC8pqYfvsSaOg45g0quZj
         8it991d1PTwI9WAf9HfB+qqgBf3ucxr3Ey1IuDbDB91FpfVx0SzRvs2oEXlxP94NlFM5
         oCW7K5E/+jrSCw/gwuril6UUck1vPbEtV/1ZQ4teR9K3g9stODqs8Kk5Z7uI5MOzGidy
         0cx0Qm7aVO8iQXfU7ZBUOCiCnlz0xG7gB90rgw2QtsLvFauSADFwsU/NhBiVgEpEPqy+
         uB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731768186; x=1732372986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnLlPzgn///5qxbj/KGMB5xH9xngFzG+evdzDcbKohA=;
        b=n27NCGF3FCmlFnKcJ87K62iwqkTrf1OR+IDcyIrXgRpkI2R9KjizC8bFXvpxk0w5De
         zklSaubgUPz9JM9I9qqHUylMSGv5KsS1SfgjTLJ7nr3rYDoMTE5Ka1AFmtpSDwC8CyYB
         i/959ogpCWb7OEa4Q34UcTUb5pNS64ajxnEL1f5Hml3GMr30zdqaWMUK557XgEXAQosp
         ZYuToqA+VuqbyswQ2sGdQyqeV6kav2W/k1VjbMvn10zZ4sZkXTaXGmBLAeihLar0vddl
         4Kd/6g1jiNzS4q42SbfpORSZj5hH5xMW4mp79qnZWq3UJ3xEEqXwngGi3XF8Ptjh5C2Z
         ytgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyKrQ3vC2DkfXgF5GpSWuS3xbdohdvLUyS28aJPj4f91WSwlCcwKoQcEzZVDZ6MEm0hKGd+WSXsBN+zwpnBnpIbA==@vger.kernel.org, AJvYcCXmKFlNUytcJzpNek2Xe5Td4w3DQp3WbFa6RZSnUwrG5byTNzy+9W6LrOM17MX123lvqfmP5UlA/UfXNS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpOxn2e7wvD+l6LuY/dNAmHM6xTA98eIiI+JxcDzemKAayY9U4
	6XRMaeMt+2uoWB4EUenFTYY790xGmOVnjKmiRYY8lUJzH4P33Qq5Wzs58VkJeGcDgOsN8mizo+9
	kX9dKJq22cPHfUxs0+oZ43M4HSxM=
X-Google-Smtp-Source: AGHT+IFayL7Mi9sUU127LNWy/FJp1u0QIJU2u9qeMbGyKHhkzzXxgs27MkgyS1ksnzbLONf3G8fRaFdjFMT7T1TjCUY=
X-Received: by 2002:a05:690c:6302:b0:6ee:4e06:c5da with SMTP id
 00721157ae682-6ee55c29e43mr72245697b3.26.1731768184486; Sat, 16 Nov 2024
 06:43:04 -0800 (PST)
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
Date: Sat, 16 Nov 2024 06:42:53 -0800
Message-ID: <CAH0uvogjWTTJk_Qza11rOvwRyOwaBSkN4as==LF=kRnqOzA59Q@mail.gmail.com>
Subject: Re: [PATCH v7 00/10] perf record --off-cpu: Dump off-cpu samples directly
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, namhyung@kernel.org, irogers@google.com, 
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo,

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

Sure, I'll send patches to do that. :)

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
>
>
> - Arnaldo

Thanks,
Howard
