Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26E532D7F9
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 22:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330797; cv=pass; b=aDGknnH9OzfL8Y+faioujvqN/BsAjuA/TdwINLMHzvGWt2m7mpxVv27zz/XnDG0wzpB0ap2sMnsO4Twk4tDziibJbReYBVuif+RohYQNR+WZg3ggefmH+7q8llpVYNKoTYXpZRNabA0xmgrEWPDifiLSl1cTwhiaotoXLcobnQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330797; c=relaxed/simple;
	bh=+W5Y5zRKmMMEEh8aSzxXq1r1mJP4AHUyv83xWVI9DX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoHSjKpclsRx5lB8ttAdYdLHgesiMXsEe9KtcqXUnx5AdqtPFEnP3pPNDkTb8DHKxA9w9cBxwDsIWkp+Ciu4smFM13mQ5uTa1IkEuPgeDgiQcrxjlhulo/XNzbkogmI71Bv1QvML+Ig+Q4NCL3bvD1Av/5J6mjl7iotAGcVs2Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OmsKgUSj; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OmsKgUSj"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a8e4ae61a0so9425ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 14:33:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770330796; cv=none;
        d=google.com; s=arc-20240605;
        b=EdfeHq4EO0fPTLJudD6u4Q7pn/3rxeVOi9jCiqc++VpxlCCZW4+SZrpGdDueAeu9jT
         XejoYUU9UYNN/hXzUTPmVwtBVteNUShUSiTEOO5AwQ2zAYJaG1tpG0aWkHBUFQdbCCyj
         VoAqEdMXj/nc7w6Y39BOBooAD2aPhZPG7vtZKAjdtYZwAf2uQjBvZr4w4BuGuFdkT6FJ
         8g3bV3EzhtdeTYdiNiJCoRFkYviJScMgcN9P2bzXaMmtjqpYi8CRFk6k5no08pG/Qsed
         AVaCtquqMpG1gqPmahyAr+3os1HcPxd6A6vODncsCDsQXwkJiIxQqWbMUV3teARQvG/B
         Gx5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3dz3/nmRLaHc2IL5fuRDuo3xgE5pwCscIMM1M8efXYQ=;
        fh=hIEHx9yWjsZNytp/01T0hMMbFlrzV/QpS1HIP5VSY0Q=;
        b=MbotwBPcIjTRSEfjYZmuDMaIzaETblDTHXcOO9wZeXIV/siNv71IENnqK/+YZwoo1H
         Uu5PNsi5+tT5yX7oHGlyzdwTQg3xcvutfI2rWqRIHY9i4GJzjfQZTqsCht6DlvhnAnA2
         OOeu7pbcC0aeulgrcS82FPoeY/ABZc7HqGmaoN84CqN/2hmqMC06/9fUKXU9NJpebgO3
         dCRXrJkfhr0RNbKLBhR65dKM0l02+jK/FdnO8Tvgjc7a5oL3yCQp/z3OOPks9+YfxY1O
         rlbzrmNT56bp46xYGwrS05qMVgv5HcGrJ3VJ118mi6FyO+HpQaEYTZ1BG15Bjc6mEkcE
         z0Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770330796; x=1770935596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dz3/nmRLaHc2IL5fuRDuo3xgE5pwCscIMM1M8efXYQ=;
        b=OmsKgUSjrHrPUBYg9uPIsoL5cPmXzwwPEqEvJSJ84OY5duHFXDih5vvi0k2OMM0cTW
         fGgPd5A9el48pVUaItm0NZJnjjW1oHUbqTxo/WPkVbt7kIUgDlAA7bk05L4tPrAEW6pL
         m1Y28z3/i77uUu2I3qjwtLLSW5mBinpDDkx5mU6k1amRvgSvE667RHbTwJwu99D1QhAm
         LFZrMU414uGRD5dMFN3HSR1dPPb+pU2iwPunDY3fgrWb5WxnHStn1nKXwYv7cw5dR7Pg
         uRofdjb89lEvMUv8IOC2J545NStDl2YAvIo7OECxhLhnrME3GsedIY2+pltE5IDEhn5h
         MLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330796; x=1770935596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3dz3/nmRLaHc2IL5fuRDuo3xgE5pwCscIMM1M8efXYQ=;
        b=nZ7uazpbWKQhyz52iGEI/j4y0gEy3QSwu1Bh/o+ZyfvROPA29ZrFq0EPtoOjwTIywU
         FgnkwJNvmHRVZwrjn91eVGKnoWVUJLDC6+RXGAza30kYZNLw1c85S5k9AwMl8ym2YIAp
         /SVsHjTjXqcnVdbuQOUCm9q0cIoPE25+F4sBFlEFCeLKCYFRr+1KSp45NOPCHl5lMlWd
         HHxWpmZ44g2asIJ16+U8z2shAdEi/S7CXl9BT8F+USfFrOI2obr17bvgmV2QjPjWm9Fr
         pzJDz4c1ui8iOmUthdSUNItc/v7GSUdPzx5iZCNTdHhB0Dh/SUZCmn6+v0D7m4GRK/Q4
         IZAw==
X-Forwarded-Encrypted: i=1; AJvYcCU642tOs9lZzqZxNKLgdCYwGujo35e+N/pdSRDPWvuw9z59w3PSsV1ONlfH0XIAS/nHteWIm76W3rrhElGCgrVz@vger.kernel.org
X-Gm-Message-State: AOJu0YxShTt6cAPxJuu5xsusaFAllOk6k9BhZWmhQPW+W4A58o0LkiBN
	jrfPWQsk2qsSnJh5bhECKh7kXrnRgHyuH9f8lEokKMZoQaRImVtnr3F/C8oqKgHt7dQX1WMfi9m
	v4O75sHSVjbwMharoDW51Tsvo3YygPgBdL7jqnGjC
X-Gm-Gg: AZuq6aL9i2zHDVeMS5bfVH3hhYXRpXu0RkAZhmHcEc50Ko5+yhiNOSJBD8CN3H0LbfZ
	8bRfynNIyNkFq/lBGTdh8C90wzvZotOsfNzZnUk0j800Z/8pQ6FHTp6l8HcvZ/9xAsLPAEBj1f+
	rINugmg3v/JZ2WrOq8AXrLHQJiojqZuyqZgYkD+yg8Q7j2C7Ea5sBWLsoNLKkIwyArT4nbDElPg
	wI2MdDoreXeb1c29LKktgF8mJBByVJAWIDgjO1LPsqzgQkOzZ6+zB9L9SpMAyFQzQ/Y3lmiZSAP
	Cb2a9dJxd138dwJ8icf1zlYKTw==
X-Received: by 2002:a17:903:28e:b0:2a8:fe50:2933 with SMTP id
 d9443c01a7336-2a951db7fcamr1148395ad.0.1770330795971; Thu, 05 Feb 2026
 14:33:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204-perf_improve_log_for_open_event_failures-v1-1-150245792810@arm.com>
 <CAP-5=fUQxuVK+6GObmqVdBmTLzu06FyNaLdLsW6tcgNv5=7gxw@mail.gmail.com> <aYUOowQ_CZf3BDKo@x1>
In-Reply-To: <aYUOowQ_CZf3BDKo@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 5 Feb 2026 14:33:04 -0800
X-Gm-Features: AZwV_QjjcIvkpEsnmUfw1m5fh88LgzWabqbdeCam-5Ovtm3c-RbR1pd--5TYlPw
Message-ID: <CAP-5=fUObi2ZoY60VF-WMD0=4=EB4e5s7SUAQyf3zoNA1my6Og@mail.gmail.com>
Subject: Re: [PATCH] perf record: Make logs more readable for event open failures
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 1:42=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Wed, Feb 04, 2026 at 09:29:14AM -0800, Ian Rogers wrote:
> > On Wed, Feb 4, 2026 at 6:26=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
> > >
> > > Since commit ee27476fa300 ("perf record: Skip don't fail for events t=
hat
> > > don't open"), if a user does not have permission to access a PMU even=
t,
> > > perf reports:
> > >
> > >   perf record -e cs_etm// -C 3 -- ls
> > >   Error:
> > >   Failure to open event 'cs_etm//u' on PMU 'cs_etm' which will be rem=
oved.
> > >   No fallback found for 'cs_etm//u' for error 13
> > >   Error:
> > >   Failure to open event 'dummy:u' on PMU 'software' which will be rem=
oved.
> > >   No fallback found for 'dummy:u' for error 13
> > >   Error:
> > >   Failure to open any events for recording.
> > >
> > > The log is not very helpful, as no clear indication of what "error 13=
"
> > > means or how to address the issue.
> > >
> > > This commit restores evsel__open_strerror() to generate a readable er=
ror
> > > message and print it out:
>
> I'm applying this one, maybe we can at least suppress the one for dummy
> when it is auto added?

IIRC it was left in as "perf record -e dummy" can be a way of just
tracking sideband data and you'd want errors opening dummy to be
warned upon in that case.

Thanks,
Ian

> - Arnaldo
>
> > >   perf record -e cs_etm// -C 3 -- ls
> > >   Error:
> > >   Failure to open event 'cs_etm//' on PMU 'cs_etm' which will be remo=
ved.
> > >   Access to performance monitoring and observability operations is li=
mited.
> > >   Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to =
open
> > >   access to performance monitoring and observability operations for p=
rocesses
> > >   without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capabili=
ty.
> > >   More information can be found at 'Perf events and tool security' do=
cument:
> > >   https://www.kernel.org/doc/html/latest/admin-guide/perf-security.ht=
ml
> > >   perf_event_paranoid setting is 1:
> > >     -1: Allow use of (almost) all events by all users
> > >         Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_=
LOCK
> > >   >=3D 0: Disallow raw and ftrace function tracepoint access
> > >   >=3D 1: Disallow CPU event access
> > >   >=3D 2: Disallow kernel profiling
> > >   To make the adjusted perf_event_paranoid setting permanent preserve=
 it
> > >   in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid =3D <setting>)
> > >   Error:
> > >   Failure to open event 'dummy:u' on PMU 'software' which will be rem=
oved.
> > >   Access to performance monitoring and observability operations is li=
mited.
> > >   Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to =
open
> > >   access to performance monitoring and observability operations for p=
rocesses
> > >   without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capabili=
ty.
> > >   More information can be found at 'Perf events and tool security' do=
cument:
> > >   https://www.kernel.org/doc/html/latest/admin-guide/perf-security.ht=
ml
> > >   perf_event_paranoid setting is 1:
> > >     -1: Allow use of (almost) all events by all users
> > >         Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_=
LOCK
> > >   >=3D 0: Disallow raw and ftrace function tracepoint access
> > >   >=3D 1: Disallow CPU event access
> > >   >=3D 2: Disallow kernel profiling
> > >   To make the adjusted perf_event_paranoid setting permanent preserve=
 it
> > >   in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid =3D <setting>)
> > >   Error:
> > >   Failure to open any events for recording.
> > >
> > > Signed-off-by: Leo Yan <leo.yan@arm.com>
> >
> > Lgtm and sorry for making things worse - I believe it was motivated by
> > trying to avoid spammy warnings.
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > Thanks,
> > Ian
> >
> > > ---
> > >  tools/perf/builtin-record.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.=
c
> > > index 2584d0d8bc820676da60bdf5f59d41371d85a93a..aa8dc3e18190dd7db1ed5=
e3c7673fde8d5785a26 100644
> > > --- a/tools/perf/builtin-record.c
> > > +++ b/tools/perf/builtin-record.c
> > > @@ -1404,6 +1404,7 @@ static int record__open(struct record *rec)
> > >                         }
> > >  #endif
> > >                         if (report_error || verbose > 0) {
> > > +                               evsel__open_strerror(pos, &opts->targ=
et, errno, msg, sizeof(msg));
> > >                                 ui__error("Failure to open event '%s'=
 on PMU '%s' which will be "
> > >                                           "removed.\n%s\n",
> > >                                           evsel__name(pos), evsel__pm=
u_name(pos), msg);
> > >
> > > ---
> > > base-commit: 5fd0a1df5d05ad066e5618ccdd3d0fa6cb686c27
> > > change-id: 20260204-perf_improve_log_for_open_event_failures-deda2c61=
b93d
> > >
> > > Best regards,
> > > --
> > > Leo Yan <leo.yan@arm.com>
> > >
