Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70533A901F
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 03:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779765950; cv=pass; b=Rl1u08AosAtQ+nwbOKO5saFgqtPVc89tUPRYEU3EBd8dgP1tickwVmdhAFdOlHl6t1ir5Kte2AGHO3LZbrghxdnVBxg09iRFbUTTgopD64m6wbwyTDuHv+M/zA1h3ohDMINZ7MjgGVZ/13U2o5Qh1hPG/wLt26RgZvb2FaOPCTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779765950; c=relaxed/simple;
	bh=9+t0PTDmXz3uGFh7g6kfWm0b54smP6oXM8ybWDfA3Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ToWRO6dXb/qhpUM7RlbDn3eyBsyAV2glVNe3xVgZKVabnG3A+08GHZC8VxceUcUobhygIAeccJKcg/S1VBRK5aAA19RlBkW7h14bDNjCnqKKeuIK/K/+X+bvCTihzZKs9FLiZknkQwAMxVD0rWsNsh5Ztmf5xpPJfw8G3eVeAYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D6x9r5tG; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6x9r5tG"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso195ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 20:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779765948; cv=none;
        d=google.com; s=arc-20240605;
        b=IEpqAeqsw3+04X3dj96dMAuQJYGKL1BzsVz9mlPpX1Nl9JMEMeQ6wOAppafgmUvdx8
         UXfZJCpifUwCWgN4OZY3NKLGHcN6COXl+rAb1rIdxoOSXdHcq/rXAtCDfA/svYvFnCLi
         mxwEGxwdf5fvJQcOelPt1XotXGwbAYdpfhvUz5cETvaEv2+2BcOcthqL6fBkFWMqZKvZ
         lhuzJx8Ndzjt+SoAnjf14vw2tDlNesxBpp0I34xT6otX/kt75olT/ohNtgHyFm+REthK
         4WKfiYNaUXCIfSqPRb1ihTCSi5utvTRQ3QSaqi8T8X62zw2XR10HWk5xfz5btFa0FxWV
         4toQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TnY5QSCxxW0i9su2GJWBJDqK4zBU/pea9Pn+MqhXD1g=;
        fh=KFKlQ78/vrw/axGaXZphGxtnL+sbdopQmUubSyFatjs=;
        b=GmkyjZPasB1jRoWplkKYEQ/f9b/hmKWVYuqDw/Ja+QaGusf5sfom8URWjDlQvqaPTb
         LyYM6mnFvvAZWXBiCjsKROXjEmNjlR8XngJDnKvTaN9LHpLg3MqIUXTr3cCThXmzJq6Y
         XAF4VjNzdg3L1g89gEPy3FtVBkkJwGHW3ZP6L2wCkT2Vu+57GiSOtZMTjT/f5WglkRTD
         Bg4s90ItvAFHQEuVjMVzlQDc6ZtGFWZ8304vr2GIFTGaYxUNjgP8rHtfR0ZtuXe5AFtb
         0wMWA3UzfxD8TIdLoVwmwNc0wfKVZmCuAxZcPNQdQ7Bck63ZNR+DjVQsgQaA/A5cPm0z
         zNPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779765948; x=1780370748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnY5QSCxxW0i9su2GJWBJDqK4zBU/pea9Pn+MqhXD1g=;
        b=D6x9r5tGRZLYBPGuMpTXCsTisZ/GEoaQXQO2Uhz5Yn6QcZJ8cUbsdzyCrSXXlts5CY
         45Z3EqQDslmDy7QYEQt5l6dd5TkPQranY0A+7hEoyNBOTOXCgXVoarjHo5vVMwLzl8H6
         37lxz2WL7gSe44vqd9WDZ7y2WtWhM1nQHsOxsYFnsHS1g7lioYh7LOS+f0s35jwBZM9o
         yf4KFqeBc8vIRv+1agkW3jD/7dYoukGkzAKZ4sXcb7mQMOgp0F6ZOaG7aP2zf+MwLWKR
         LuwybM6irQALZjUKDtPTy0zP7YTMFynu05Fee0DkW6pMQvJKKtDF01TXEgNYWb022xad
         EVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779765948; x=1780370748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TnY5QSCxxW0i9su2GJWBJDqK4zBU/pea9Pn+MqhXD1g=;
        b=c9TcjtXAsc0GsqWEbHXowpDevvT52CNxEjg3gWOn+cD077ZTKwY2n+1EoHaFGVcD1b
         tAzrICYfcmZ3It8ZOKbUmf583My7MEgzBYiQ6uuFKPMcVlGg3lEnCugzuMh1fJ8mcxKI
         KVVeOLgvkluVcj2mI6NOC5jMLPI0YLIbB14FcpIgAzHA4HqVnz5t0hsP6ORYOEXKNuZf
         3R8mD8GGeFfqe85xjAloge4oAtnUb6DNuY4YrDXriX5lUB7AbA2/yxLMNpZa0Kkip6C1
         YX2Vk8rnvJ+nKJqu2ErvsJ4E8h6coHO4ope+tXQpg/TjQ3h2WCJ24J6AHjXnct8ZjtvA
         /XHw==
X-Forwarded-Encrypted: i=1; AFNElJ9WUMtprV7leR+00qR8G25OTk0kJATS2kZ0f2pNkajoEC5aYL1tIrAq1Ni/t1NOImDwCnUCP/xAjiV9rmelwvZl@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh4KBmBYOnCWhtpOiko2UbnWi+UZfBRGBPR1B6G+4OSs/m5Xca
	kj0yX/Ar+m70RWLwa0Ix6/to051DOtDKTUwMcm7y1f8Hjv+vqvTvynsD6ykheaSodA+FjTbdRgA
	ODMBfw3Xph16CP4vVDc9IeJxDa2qJ83dVIX3DenLd
X-Gm-Gg: Acq92OHRCX9sWym0PG2RVaDWbxrX/vqvykSAAVw5ne1SDvmPTEyI6DacN4nSWrsFHPa
	nd19f4ZQXytGuaNWj/nX3ym+o3MQ55RWLOxPdMBtBwKu6k17ZnjJ36vYCNQRjc67Y7KTq2a+O3i
	tk6mBFrt3LvFWLzk2RMXXpcEkTfGmqJKAyzaXdkUTYg6+lJPci6hxa0Hf1RL0FjyeFpsheALW/Z
	KTBEU13t1u2s02B2VymveKX6FN1LSWqRv1G8WqaK24IyyknKNuDOSYjSFsuiDBiFK+q5dJ+N99d
	EPN88ftOKwUlOQIdEf8=
X-Received: by 2002:a17:902:cf0d:b0:2bd:18b2:a78 with SMTP id
 d9443c01a7336-2bebea09694mr4731665ad.14.1779765947335; Mon, 25 May 2026
 20:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fX=vEmTaz6mWgExmrgyYMJmSyOD+1sMCzf7JTk1SkA-zQ@mail.gmail.com>
 <ahTmJyLLZYOPpnKa@x1> <ahTnmDoG6i_7nO8-@x1> <ahTo9zn-NAw5fUb5@x1>
In-Reply-To: <ahTo9zn-NAw5fUb5@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 May 2026 20:25:36 -0700
X-Gm-Features: AVHnY4Kwj-yinJi7WWJVu2CS3eVvKPrShkdJ3SyF55-AtqcIwxn0oQwG76u4X6Y
Message-ID: <CAP-5=fXnecMfon9zE=YXsHQcu+iMW7MLL6fbrFpnBz0+=b5-qw@mail.gmail.com>
Subject: Re: Summary of perf-tools-next changes and patches sent to linux-perf-users
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 5:27=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, May 25, 2026 at 09:21:44PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, May 25, 2026 at 09:15:35PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > On Mon, May 25, 2026 at 04:35:51PM -0700, Ian Rogers wrote:
> > > > I've been working on a script [1] to summarize what's been sent to =
the
> > > > linux-perf-users mailing list (using nntp) and compare it to what's
> > > > merged into the perf-tools-next branch (using git). The idea is to
> > > > make it slightly easier to track down patches that might have been
> > > > missed. The script shows what has been merged and what's pending, w=
hat
> > > > Sashiko thinks, and whose turn it is to work on the patch (author,
> > > > reviewer or maintainer) using some naive tag analysis. The output i=
s
> > > > quite large, so rather than adding it below, I will send the last 4
> > > > weeks in separate e-mail replies to this message.
> > >
> > > I'm doing this locally as well, helps.
> >
> > For instance, from earlier today:
> >
> > $ cat /tmp/outstanding.txt
> >
> > Outstanding patches for perf-tools-next =E2=80=94 2026-05-25
> > (checked against next2/perf-tools-next)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >
> > Tier 2 =E2=80=94 Likely ready, needs closer look
> > -----------------------------------------
>
> I had alredy processed Tier 1 at this point so deleted it from the file
> :-)

That's cool! I haven't got a notion of tiering in mine, but I guess
the "Status : Maintainer work" is a match. I wonder if there's some
middle ground with the scripts and a weekly cron job could update the
list of current patch status. This could help bring people up to speed
on what's being sent to the list, whose turn it is to act, encourage
reviewers to review, maintainers to merge and authors to fix their
patch issues. It may also reduce the need to ping people about
patches.

I wonder if we can also go further. I have a change for Chris Mason's
kernel prompts where patch size is reviewed (smallest meaningful
change; don't mix refactoring, bug fixes and/or new features; don't
cross subsystems) - I just need to figure out stacked PRs on github
before sending it out. Similarly I have a strict header include prompt
that should help with musl builds. There are likely other bits of
feedback we can automate sending out. We can probably help people to
rebase changes against the tip of perf-tools-next automatically. It
should also be possible to automate handling Sashiko and other
feedback, so a cleaned up patch could be automatically sent as a reply
to the list.

Thanks,
Ian

> - Arnaldo
>
> > 1. perf stat: Fix uncore metric scaling across aggregation modes
> >    Author: Chun-Tse Shao <ctshao@google.com>
> >    Version: v3, 2 patches
> >    Reviews: Namhyung reviewed v1; no reviews on v3 yet
> >    Message-ID: <20260521201505.124690-1-ctshao@google.com>
> >
> > 2. perf python: Improvements and callchain support
> >    Author: Ian Rogers <irogers@google.com>
> >    Version: v9, 23 patches
> >    Message-ID: <20260522220435.2378363-1-irogers@google.com>
> >
> > 3. perf data ctf: Replace libbabeltrace with babeltrace2-ctf-writer
> >    Author: Michael Jeanson <mjeanson@efficios.com>
> >    Version: v1, 1 patch + Ian's 2-patch feature test
> >    Message-ID: <20260512194710.162215-1-mjeanson@efficios.com>
> >    Ian's follow-up: <20260512215621.468685-1-irogers@google.com>
> >
> > 4. perf test: Harness improvements
> >    Author: Ian Rogers <irogers@google.com>
> >    Version: v1, 14 patches
> >    Message-ID: <20260513230450.529380-1-irogers@google.com>
> >
> > Tier 3 =E2=80=94 Single patches, needs review
> > --------------------------------------
> >
> > 5. perf bench: Add --write-size option to sched pipe
> >    Author: Breno Leitao <leitao@debian.org>
> >    Version: v1, 1 patch
> >    Message-ID: <20260515-perf_bench_pipe-v1-1-3c5b805ba178@debian.org>
> >
> > 6. perf evsel: Fix error handling in tp_format lookup
> >    Author: Hongling Zeng <zenghongling@kylinos.cn>
> >    Version: v1, 1 patch
> >    Message-ID: <20260521025738.17867-1-zenghongling@kylinos.cn>
> >
> > 7. perf kvm stat: Update the exit reason mappings
> >    Author: Gautam Menghani <gautam@linux.ibm.com>
> >    Version: v1, 1 patch
> >    Reviews: Ian reviewed (needs v2 per feedback)
> >    Message-ID: <20260512120408.59332-1-gautam@linux.ibm.com>
> >
> > 8. perf build: Fix Python extension build with GCC 16 hardening
> >    Author: Jan Polensky <japo@linux.ibm.com>
> >    Version: v1, 1 patch
> >    Reviews: Thomas Richter Reviewed-by
> >    Message-ID: <20260520125637.105681-1-japo@linux.ibm.com>
> >
> > Already merged in next2/perf-tools-next
> > -----------------------------------------
> >
> > - perf tests: uncore/topdown event sorting (Ian, v8) =E2=80=94 9f116f4b=
811b
> > - perf build: parallel build cleanup (Ian, v7) =E2=80=94 85cc481af5ff +=
 5 more
> > - perf build: Update kernel headers (Namhyung, v3) =E2=80=94 aa13e4b120=
f9..5a433107fab6
> > - Fix SIGCHLD vs pause() race (Swapnil, v4) =E2=80=94 35c9fb22000f
> > - Fix kwork ASAN + libunwind test (Ian, v1) =E2=80=94 e898c505b0ee, fde=
c0a81cad5
> > - Fix cgroup metric with BPF counters (Ian, v4) =E2=80=94 65bd18199ad5,=
 bd2a5be1fe73
> > - tool_pmu enable/disable (Ian, v2) =E2=80=94 0b18bced5444
> > - libunwind multiple remote (Ian, v5) =E2=80=94 fdec0a81cad5
> > - tools/build: LLVM versioning (James, v2) =E2=80=94 98e68cb77823
> > - perf inject intel-PT LBR/brstack (Ian, v3) =E2=80=94 daac18e7c42c
> > - perf trace --show-cpu (Aaron, v4) =E2=80=94 e445b78ffb8d
> > - stat delay duration_time test (Ian) =E2=80=94 f83deb058025
