Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADF934A3CC
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Feb 2026 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226167; cv=pass; b=uysesx/nVufECsb+IBAXcQn1kHSV5lex81cJeFOsNT69DZeBUsVCxycPFik/SU9ZcUx6S9Jqx9EVq89Yq4Btr7S5BX2D+SAp5EyRYzF/ccdVz/vvrPa+BxXxNtH/ZHo3xnm1kaKRQTeXeBzsZ5tYbBrUnMxGGe6JxeiyHEWV/jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226167; c=relaxed/simple;
	bh=tWYmYTcWswd/XvnjHCubVSy7BzBewmxGxu3MomoYBv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxI7vJ75LCfPJJfM08OZ/r/PwyHiLLPi+h+25EK0JaFlUaCaQhDwD4M5aKJHu3Ou/PAnx87V91xi13x4govA61Bi2mlRSqL3u0r3/RyzQV7//W1/qk5mpPg3ez5+A9XYRHb0sjKrkuKzyTVymBpavDsQRPh8kgMQtgYgCj2p9Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d5HIlS5j; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d5HIlS5j"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a8e4ae61a0so91965ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Feb 2026 09:29:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770226166; cv=none;
        d=google.com; s=arc-20240605;
        b=RDEYwKjKThePTLPTacbxG9lIiL24PyKsgsiZ1SJ1oD9KDsNfnsWcuxqOwulnfaCPkf
         uglEJ8XWSulWn8140b+fYPaHXjXtSbW1sL4MQtobCB/nAZ8LIXpIjOrvGduPW3wpubdc
         hAirKxtkhsktdxITYJ9z3Dcn9lxpKbtSBdbfmFUH3zEDrLu2uC1YB909nFeg18S0Ag6B
         ey0/fTSYENUew5r9GgP86yskqH43CL52n3PHUqou0KsWu+9ZOOrg0vzJntTIIZa8bYWm
         mzpuootlD7ewT+x0fy3Ss35XgxvbDA13IvMlLDkX06l48N+XBkgB9iB/JqduIBzcOksL
         WLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hKzl+8BoEgbOPdEMadrWfa/5++VNHD3qr9r089wys7o=;
        fh=g1Uz4s210yfCbMPmVcphUrJXzfBA1Y29FCZGntM5fno=;
        b=ZL0WDX66D0D3n1ymGRpyfikO8ZL1hdbwtCd6m3VnM2LvSZHPl8i+ZrI3un2lSYPvbL
         VYtzljEXr/3nb+E6FoygBsTWnObbVoU+XhjXbN8bQBU8IpCYWBaz2aAk8gM4C5jbKG/i
         o7q76AC6ziDtfoNvrLFPidYCM4jdv2Ekrll0EHyDTiGjYX8DTA89PkHGJkaASAnc1ulo
         S8UbCFUL5YFZkNWVqockR4BS3WNuQHbbhdptlrRg0ZAFGnIus+VWFfmqNdw3XJUxKQCp
         jZSUZR79Za8UQRDzfLGTiasoE4y/idTOKj07rwHLxtD92mIqlx0uJfQkMWFkYo8PM0z+
         dwjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770226166; x=1770830966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKzl+8BoEgbOPdEMadrWfa/5++VNHD3qr9r089wys7o=;
        b=d5HIlS5jhklyfCqAaIAG8GHl87s/L0tuMBSl406/xs723PGgpfOnSNgLOWnSIn2i8D
         MsYxEyfT4tIVj70wkuI80OqsU0SwvZa/QwqG54bM18pWfSZAy6TEQZaDBOUJJO2g9nxu
         taQJJkDM95cfVp2Trn9YqJbVolZLDTOBd9pzWWqCCr8zXTZ5by7KFzjMtg/ZEBPJLrSX
         505hzj3+CslhB5u/0vZsSr8jgM+B8QNeTRoq+iYV17d8xsaHTu1+kTUmOs3YZepZnmoX
         l8I61VGoCQtEC5DaPZBMb1pn4RefONiaEgvwRSz17cc3/QH0dGbVhVD4t2LopLshXNwn
         Zuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770226166; x=1770830966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hKzl+8BoEgbOPdEMadrWfa/5++VNHD3qr9r089wys7o=;
        b=K3XkoBKWD+xeWefXE5slOR41rbuC3QnaaBnamgLQoLsRslnEDCW5+Lvsz7v5DH7CJv
         Q2EdgKJJ+JVkjzurfEQ1St1ex7gn9DHlEMsTUPx/lR+64ra6R/18O0y4LFdgPXVMNnR3
         EQCsQVzpfY+mRdzpp66TYAF/hxdTZKWENgafBQmMHUuTlVQImVikrW+XnNTVkkh4bJBO
         Bf8s+eLjHHH/Wp+pB17zgKAtzBkvVdyYcbHcTnpe9dNrtUUwI6aUui1a2++tvLR+68tF
         sRPeXozr4Fe9b3FkIz4KOdGcH2s5kZOQXiuWVvWB26waCC84fMV8166SKo7MeROH9ghZ
         ugMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4PWo/w+pIDDnVPVewjcHfLfPP5EKiwTGOMcHhdDHxaDnKRR0Dcfj7yZ5GWz6NYnyQSQgTZbqKU2xzVtFYxvmb@vger.kernel.org
X-Gm-Message-State: AOJu0YwqTghGo+J467zLhA3YfAoEl7EMuBWHH+3JrwDYBWQN9voaxaM/
	uuLbGHXqHMQ0h+U00LZHy4zzHkD3+8HPJIMBZF0iTunRembJOvihxHzFr1zdtxkgHVDmrtF2jN6
	gMp826NcgTT093mm5ClVIwea17Wu5nsQyDB/QSYC1
X-Gm-Gg: AZuq6aIFpsmyc2oRMi485vgOhKmVcdCKQdAb2HyBKiBMiP8qpVJAzE8NqLqLfOScL6C
	rPqRUg6CLDpxXQFtG/aA/1Pb5eZ3I+bz6PShRPbSqWVvwj05aMEuuu8VfiqfDyVv5RmisieVbl9
	itQg5JuJEcnP0LwVtXXbzY6Qc/8WPNuPBcfOUn+DeS0xM8wW5eZz9EOxF87KWFBH6sBE7+Pjx+t
	Yu1UYQCaDadYsgWZwRwzCVomlIBgJMsL2Y75PkeoUqvzKPt/WEYaSpYvVQHaXVW46M67PC4/MEH
	OlK5BMn0CGYT1k0aloqjbqQElBfrBwx37w==
X-Received: by 2002:a17:903:244e:b0:295:5405:46be with SMTP id
 d9443c01a7336-2a93563abbamr2983285ad.1.1770226165613; Wed, 04 Feb 2026
 09:29:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204-perf_improve_log_for_open_event_failures-v1-1-150245792810@arm.com>
In-Reply-To: <20260204-perf_improve_log_for_open_event_failures-v1-1-150245792810@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Feb 2026 09:29:14 -0800
X-Gm-Features: AZwV_Qiv61xfFPLn_XYJMTWBS6cqtlDP3g8pr149VSbs_sRBQPC71Vlakv136RI
Message-ID: <CAP-5=fUQxuVK+6GObmqVdBmTLzu06FyNaLdLsW6tcgNv5=7gxw@mail.gmail.com>
Subject: Re: [PATCH] perf record: Make logs more readable for event open failures
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 6:26=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Since commit ee27476fa300 ("perf record: Skip don't fail for events that
> don't open"), if a user does not have permission to access a PMU event,
> perf reports:
>
>   perf record -e cs_etm// -C 3 -- ls
>   Error:
>   Failure to open event 'cs_etm//u' on PMU 'cs_etm' which will be removed=
.
>   No fallback found for 'cs_etm//u' for error 13
>   Error:
>   Failure to open event 'dummy:u' on PMU 'software' which will be removed=
.
>   No fallback found for 'dummy:u' for error 13
>   Error:
>   Failure to open any events for recording.
>
> The log is not very helpful, as no clear indication of what "error 13"
> means or how to address the issue.
>
> This commit restores evsel__open_strerror() to generate a readable error
> message and print it out:
>
>   perf record -e cs_etm// -C 3 -- ls
>   Error:
>   Failure to open event 'cs_etm//' on PMU 'cs_etm' which will be removed.
>   Access to performance monitoring and observability operations is limite=
d.
>   Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
>   access to performance monitoring and observability operations for proce=
sses
>   without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
>   More information can be found at 'Perf events and tool security' docume=
nt:
>   https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
>   perf_event_paranoid setting is 1:
>     -1: Allow use of (almost) all events by all users
>         Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
>   >=3D 0: Disallow raw and ftrace function tracepoint access
>   >=3D 1: Disallow CPU event access
>   >=3D 2: Disallow kernel profiling
>   To make the adjusted perf_event_paranoid setting permanent preserve it
>   in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid =3D <setting>)
>   Error:
>   Failure to open event 'dummy:u' on PMU 'software' which will be removed=
.
>   Access to performance monitoring and observability operations is limite=
d.
>   Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
>   access to performance monitoring and observability operations for proce=
sses
>   without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
>   More information can be found at 'Perf events and tool security' docume=
nt:
>   https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
>   perf_event_paranoid setting is 1:
>     -1: Allow use of (almost) all events by all users
>         Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
>   >=3D 0: Disallow raw and ftrace function tracepoint access
>   >=3D 1: Disallow CPU event access
>   >=3D 2: Disallow kernel profiling
>   To make the adjusted perf_event_paranoid setting permanent preserve it
>   in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid =3D <setting>)
>   Error:
>   Failure to open any events for recording.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Lgtm and sorry for making things worse - I believe it was motivated by
trying to avoid spammy warnings.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-record.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 2584d0d8bc820676da60bdf5f59d41371d85a93a..aa8dc3e18190dd7db1ed5e3c7=
673fde8d5785a26 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1404,6 +1404,7 @@ static int record__open(struct record *rec)
>                         }
>  #endif
>                         if (report_error || verbose > 0) {
> +                               evsel__open_strerror(pos, &opts->target, =
errno, msg, sizeof(msg));
>                                 ui__error("Failure to open event '%s' on =
PMU '%s' which will be "
>                                           "removed.\n%s\n",
>                                           evsel__name(pos), evsel__pmu_na=
me(pos), msg);
>
> ---
> base-commit: 5fd0a1df5d05ad066e5618ccdd3d0fa6cb686c27
> change-id: 20260204-perf_improve_log_for_open_event_failures-deda2c61b93d
>
> Best regards,
> --
> Leo Yan <leo.yan@arm.com>
>
