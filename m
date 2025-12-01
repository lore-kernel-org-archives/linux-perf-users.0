Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465EC3358BC
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607944; cv=none; b=a/toICz5umIjQqvj/47SihYjRg/O5W5ChXNnIdGZlBxEocPz6xevkIISHdg0KTs9gybfagvRQmaLpNP6eCvwa37bbRv5uCOF5R++4uuQqfk05VpEYP9pgRwBgZvVP6jzUP7/abqiIAeN1Unb8rd69nr/LV83SdmcyUVecmaFVtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607944; c=relaxed/simple;
	bh=p4KJZ5LySGo2hhKdYumKzsdV/qEqXcHMd3wBU2l8g+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orHpxswFYOFZ8OT4K+HwO42B7uCfDO7gQDfPehSXJ9RoQp4WiMuLnww4NHyJGFSDsGxMi/fT6flEh3bJzPaMTwiCgvuJF0RIXPTJxBt0AhHS6B1fhOStjKxe/CIqQqlhXgD0/qMmzu8KQ3f3dyIYvHylGv4rdHOm5gR2lnSSTLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VIeEYE3O; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VIeEYE3O"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297e13bf404so770715ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 08:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764607941; x=1765212741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/o/nv7y0LjApKDBKhCc72C4VJcwZE3Ev3xtc9sLgWo=;
        b=VIeEYE3OkNRu4KdoB0ZIbyfnz0qKEtxokj+dQ0UtMvCvmFZbPWziXn86Db0csFqMg+
         bFuMD0fAWu9LSlApCvn9jEjTp/J/DXsgYtbZp1f2mMdaTBo/HtlMnK0Lf67GEMCbjrwS
         uTrUtuZtgWQS+sApNllPCLRm0zBTNEmOnP5cG/aeUlMYQds3lph+lRAkPaovnFWHz+GW
         7u9AEjLc0v6sxsmIZG8V+MDCbBmrzO/aNptKP9P3CH11cQKwOza2x5FgbbrcphT5L9go
         6WR/SRF6Xri/Hx2CvcQ/j2NHo9zQtJKHd2+JzPAnoYm5X8OhHE6z/Y7AE7sT7ELZ4nl2
         xCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764607941; x=1765212741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D/o/nv7y0LjApKDBKhCc72C4VJcwZE3Ev3xtc9sLgWo=;
        b=ZiYHwl0P6kW48m1Gte3Q1kD12tElVw3Oo/a/L1+CmaWI42am9TTnig34HAbe+/5+y8
         MFQenuV29J+Uos2eOiJASyx8V31S2PknjKCcQxS4Js1KodNySLtgs7+Uv1X74i+yHecU
         nscak89l8Ou8FdkHxIGQLOGxtRykJNuZYn5otlFOn7bU3aUpZNru5iB2FIGW3PGeTDJJ
         W+K8eVcCCLwHi5i41DGhE6N6u/URPTpLSDZ9yjuy7r0NDwyokySevWueE/bDGFLkGvlx
         y7Yno6l9dXbGNaSSy9gOFVFzzuD3v10SchlJK0i2PWGi1VxFL8SrZOOPoJNn8FlAl0GF
         sR3A==
X-Gm-Message-State: AOJu0YxedbxRvi2zHrwk0+SG03rTh9o821waLdEi1qIkhu12v9T9C/4r
	XF5HYMH7dA7CtpFsq2daWz7pRAyGt9q5iilSq5BGemgwY7A3mhPF/48r+zj7Va2HXylS6CKWgFO
	1Ru5A25eOAUHV3GPdZmGtJovVoxrX29w7EORtHaYX
X-Gm-Gg: ASbGncsfyI165rQawMWgWeTRyydXMm5luQiC8SX3JlpCNJeNaBeSB+yMXJQHfPWpgDe
	y8CEeUPNL8cZvQDp3L4lNn6IutfYdHg0NmpUEjj0VIpHdrf4XG9WcJa2W+lDNfnowTqnp2O1B1w
	xpQDctkVbT3bYFG3kCQnzY9hFfNzUYnTesgrNGuc7c8Cj7/a+hKblrFxpzLyX5NShX4Z7yLk44r
	EDUOrNJ/CqOQVE2vCkqnd7E8ueNE2sp+NkOh/61ZBNM0Ej3UvIaHebty/hdiQYV6CUDPZvE/jmP
	ozUeE1gIapKMHpo8djZnA1T+qA==
X-Google-Smtp-Source: AGHT+IEq48loOeuNmp5Aj/iZX79Tc916M186zhJh5nUyd2peoxhPgX1SGkkdLCOrlsp5Jg4LDiTKYAoWUiCFQivZjjE=
X-Received: by 2002:a17:903:1cb:b0:298:144f:b759 with SMTP id
 d9443c01a7336-29bca38ec67mr6312885ad.9.1764607940975; Mon, 01 Dec 2025
 08:52:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aSwt7yzFjVJCEmVp@gmail.com>
In-Reply-To: <aSwt7yzFjVJCEmVp@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 1 Dec 2025 08:52:08 -0800
X-Gm-Features: AWmQ_bndj_SO0cgpGX3LSqH-ifye3AmpdhBN55FvNFgexX44y-uC60YzoFH5jyg
Message-ID: <CAP-5=fXK8HORZaFUxydEatLV1xXQTcLLBnEMeveJYDHDQPkf_w@mail.gmail.com>
Subject: Re: [PATCH] Fix (well, work around) perf stat --null segfault
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 3:43=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
> JFYI:
>
>   starship:~> perf stat --null ls
>   Segmentation fault (core dumped)
>
>   Program received signal SIGSEGV, Segmentation fault.
>   0x000055555563596e in __perf_cpu_map__nr (cpus=3D<error reading variabl=
e: Cannot access memory at address 0x0>) at cpumap.c:257
>   257           return RC_CHK_ACCESS(cpus)->nr;
>   (gdb) bt
>   #0  0x000055555563596e in __perf_cpu_map__nr (cpus=3D<error reading var=
iable: Cannot access memory at address 0x0>) at cpumap.c:257
>   #1  perf_cpu_map__max (map=3D0x0) at cpumap.c:372
>   #2  0x00005555555cc249 in perf_stat_init_aggr_mode ()
>   #3  0x00005555555d1963 in cmd_stat ()
>   #4  0x0000555555631bb2 in run_builtin ()
>   #5  0x0000555555631e9e in handle_internal_command ()
>   #6  0x00005555555ab183 in main ()
>   (gdb)
>
>   (gdb) print cpus
>   Cannot access memory at address 0x0
>   (gdb) bt
>   #0  0x000055555563596e in __perf_cpu_map__nr (cpus=3D<error reading var=
iable: Cannot access memory at address 0x0>) at cpumap.c:257
>   #1  perf_cpu_map__max (map=3D0x0) at cpumap.c:372
>   #2  0x00005555555cc249 in perf_stat_init_aggr_mode ()
>   #3  0x00005555555d1963 in cmd_stat ()
>   #4  0x0000555555631bb2 in run_builtin ()
>   #5  0x0000555555631e9e in handle_internal_command ()
>   #6  0x00005555555ab183 in main ()
>   (gdb)
>
> For some build(?) reason I cannot set breakpoints
> inside builtin-stat.c:
>
>   (gdb) b builtin-stat.c:1545
>   No source file named builtin-stat.c.
>
> ... and didn't investigate any further.
>
> System has 128 CPUs.
>
> It's been broken for some time:
>
>   starship:~/tip> git bisect bad
>   ced4c249569ab25c32b0d36e2ebdb19c74394bdf is the first bad commit
>   commit ced4c249569ab25c32b0d36e2ebdb19c74394bdf (HEAD)
>   Author: Ian Rogers <irogers@google.com>
>   Date:   Fri Jul 18 20:05:05 2025 -0700
>
>     perf stat: Don't size aggregation ids from user_requested_cpus
>
>     As evsels may have additional CPU terms, the user_requested_cpus may
>     not reflect all the CPUs requested. Use evlist->all_cpus to size the
>     array as that reflects all the CPUs potentially needed by the evlist.
>
>     Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
>     Signed-off-by: Ian Rogers <irogers@google.com>
>     Tested-by: James Clark <james.clark@linaro.org>
>     Link: https://lore.kernel.org/r/20250719030517.1990983-4-irogers@goog=
le.com
>     Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
>
> The bug is the assumption that
> evsel_list->core.all_cpus exists at this stage.
>
> The attached patch works this around like the old
> version, but there's more things wrong with this code:
>
> BTW., I couldn't even find where all_cpus pointer gets
> allocated. It gets zalloc()-ed to NULL, and cleared
> back to NULL in two places:
>
>   lib/perf/evlist.c:    evlist->all_cpus =3D NULL;
>   lib/perf/evlist.c:    evlist->all_cpus =3D NULL;
>
> But where does it get allocated? perf_cpu_map__nr()
> hides it in most cases that ->cpus_all is always NULL:
>
>   int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
>   {
>         return cpus ? __perf_cpu_map__nr(cpus) : 1;
>   }
>
> Which in general is a code robustness red flag, for
> something this fundamental I doubt there should be any
> conditionality to this pointer. Allowing cpus pointers
> to be NULL and hiding it in the helpers hid a real bug
> for months.
>
> So this code looks like a bit of a trainwreck. ;-)

Agreed on the trainwreck :-) So NULL is a valid CPU map value. It
means no CPUs, but magically no CPUs can also be converted in the code
to become the "any" CPU value of -1. So iterating the perf_cpu_map of
NULL will yield a single CPU of -1 :-( This behavior existed before my
time working on the code, I've tried to make the expectation in the
using code clearer, does the user want the magic "any" CPU behavior?
"any" CPU is distinct from every/all CPUs which would be something
like CPUs 0-127, and then does "all" include online and offline CPUs?
This is something that's been discussed and I think things can be
better, I'd rather the code was explicit whenever terms like "all",
"online" and "any" were being used - it is very easy to confuse "all"
and "any". I've been trying to adjust the code and make it more
sensible with changes like:
https://lore.kernel.org/all/20240202234057.2085863-1-irogers@google.com/
but I agree with you that things are a mess here. At least we
shouldn't be leaking memory (due to the reference count checking) and
we shouldn't confuse indices and CPU numbers (due to the introduction
of a wrapper type), problems that were pervasive and broke things like
uncore counters frequently before.

Fwiw, part of me thinks we should change the perf_cpu_map to be a
cpu_set_t, the "any" case could be an additional boolean in the
struct. Perhaps we can just auto change "all" to "any" as is somewhat
done here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/lib/perf/evlist.c?h=3Dperf-tools-next#n92
Then perf_cpu_map can be a cpu_set_t and I think life will be clearer.

Fwiw, even on the kernel side this is borked as I tried to explain in
this RFC with 0 follow ups:
https://lore.kernel.org/lkml/20250716223924.825772-1-irogers@google.com/
Imagine the case of an event opened with 1 CPU and a TID. The filter
will mean the counter only counts on the 1 CPU but the enabled and
running time will mean the counter will be scaled (on your system) 128
times!
All of this matters when you consider different events opened in the
same evlist and there being combined perf_cpu_maps like the evlist's
all_cpus value.

> In addition to fixing the bug, it might also make sense
> to add a testcase for 'perf stat --null'? (which is a
> better, more accurate 'time' utility)

Yup. A good place would be:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/stat.sh?h=3Dperf-tools-next

> As an additional report and side note, I still get this
> bogus message during a build on standard Ubuntu:
>
>  Makefile.config:1151: No openjdk development package found, please insta=
ll JDK package, e.g. openjdk-8-jdk, java-latest-openjdk-devel
>
> The suggested "e.g. openjdk-8-jdk" package *is*
> installed:
>
>  starship:~/tip> dpkg -l | grep openjdk
>  ii  openjdk-11-jre:amd64                                        11.0.29+=
7-1ubuntu1~25.10                            amd64        OpenJDK Java runti=
me, using Hotspot JIT
>  ii  openjdk-11-jre-headless:amd64                               11.0.29+=
7-1ubuntu1~25.10                            amd64        OpenJDK Java runti=
me, using Hotspot JIT (headless)
>  ii  openjdk-17-jre:amd64                                        17.0.17+=
10-1~25.10                                  amd64        OpenJDK Java runti=
me, using Hotspot JIT
>  ii  openjdk-17-jre-headless:amd64                               17.0.17+=
10-1~25.10                                  amd64        OpenJDK Java runti=
me, using Hotspot JIT (headless)
>  ii  openjdk-21-jre:amd64                                        21.0.9+1=
0-1~25.10                                   amd64        OpenJDK Java runti=
me, using Hotspot JIT
>  ii  openjdk-21-jre-headless:amd64                               21.0.9+1=
0-1~25.10                                   amd64        OpenJDK Java runti=
me, using Hotspot JIT (headless)
>  ii  openjdk-8-jdk:amd64                                         8u472-ga=
-1~25.10                                    amd64        OpenJDK Developmen=
t Kit (JDK)
>  ii  openjdk-8-jdk-headless:amd64                                8u472-ga=
-1~25.10                                    amd64        OpenJDK Developmen=
t Kit (JDK) (headless)
>  ii  openjdk-8-jre:amd64                                         8u472-ga=
-1~25.10                                    amd64        OpenJDK Java runti=
me, using Hotspot JIT
>  ii  openjdk-8-jre-headless:amd64                                8u472-ga=
-1~25.10                                    amd64        OpenJDK Java runti=
me, using Hotspot JIT (headless)

I'll let someone else worry about this for now.

> Thanks,
>
>         Ingo
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>
>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
>
>  tools/perf/builtin-stat.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 7006f848f87a..973b72218df7 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1542,7 +1542,10 @@ static int perf_stat_init_aggr_mode(void)
>          * taking the highest cpu number to be the size of
>          * the aggregation translate cpumap.
>          */
> -       nr =3D perf_cpu_map__max(evsel_list->core.all_cpus).cpu + 1;
> +       if (evsel_list->core.all_cpus)
> +               nr =3D perf_cpu_map__max(evsel_list->core.all_cpus).cpu +=
 1;
> +       else
> +               nr =3D 0;

So I think the better fix is to make max handle a NULL perf_cpu_map.
That will yield "any" CPU of -1 ( :-( ) and then the -1 + 1 will give
an empty aggregation map.

I'll write this up, add the test and see if I can spot similar issues
wrt NULL in the vicinity in the perf_cpu_map code.

Thanks,
Ian

>         stat_config.cpus_aggr_map =3D cpu_aggr_map__empty_new(nr);
>         return stat_config.cpus_aggr_map ? 0 : -ENOMEM;
>  }
