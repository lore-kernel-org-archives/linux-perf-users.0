Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474931E5B64
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Mar 2026 04:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774325976; cv=pass; b=kA05ANEhd8EsflRVb7nFi+1PmVFcdhcXSoC1utkRNvL+K/wb8Szd/ra5KC+eHXjoU3w07jhM5AfKi4J5FvHDNvFxPM5mE9k0J1EmglLStc8WinRcFmEo2MMCakvcj5J0tRrkKBsLiK/aTaXExPFRyFA9vQngyQ/t2ilvY6yRumA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774325976; c=relaxed/simple;
	bh=/O+MTcrM96xJgvVfk/hLD6xdrcgyM16IbCZDXn9fEvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1sB4hesSpnjKowrOZc6QsS0hlxODwGqRtTMvZ2F4ml3zD1uu+xj2Oi8T/yxqsx3YTj6OkjiqfMW7/FmLQz22Xj5JUdcFuZMU42O3RQb1KNt8SKbDnKfke+p2c2jW33e2FL6XV/JTgyZLjw2D9Om3DEDfR6j7Bhre/HoHEh9S9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kfHJYRPN; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kfHJYRPN"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-126ea4e9697so3967c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 21:19:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774325974; cv=none;
        d=google.com; s=arc-20240605;
        b=LDLAkdxN0oClBWI03TubKd1/o7nfAyMIzEW0XQ5MIDGdz50VHNyf+RRDHqrXXHyadu
         Uy9kUZis493LYBIcVXkCwdZ1aQ/tKPgfmjhVdkNMIIVXP7yAG/WB7epbZWkpyhWF2hlV
         mpXSDVVe83nxGo9DWUwKPPpuSs3tYko5iry5AqYF08/76EjcaEABInb5efDPSl1tv7dv
         nvMcNYUvtp6/32/10Xu6Ms7bDcq7Edh29ya2kYkywi/VzpvyLlzs6FxCoRAbE/jBMp/o
         5LHWzWJa40AmQAIRO7XDVHLFFDsVifpHe64i49bBoDszbS3WAyh+x7HrFAYkkLruoQhc
         XBcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NHP/cgwApiu7vjtrG8hPnSAFW3clok7WHUaTU0v68KU=;
        fh=KUGZshki2KaD25BttmIe/faNzgAvmKLocWTFQJCPVu0=;
        b=AXTxMecy9jqiiXtl4e8vHy8J6YC4KMecVLBYa0QdWtux5/z+QnHuiumtBBUGqidR+G
         MfADL0isEwsjiQ2Bjxa1FjBajSxoBPD0rZyPMTHECkpaEZn1lp6moYQZzqkYAL0A3Il3
         bTdXdQN7QWu2yfSW1zd+CJ7YhL6ah/es1xuZPuPbBN/eWtGAnaxn9VHr0JcKgnjwbs17
         JHxSJIOYYF1RZq6TzMCm7fe6gy/Q+URpa6YMLHp7wKTfX0303FhLt4XnwJ5UJuX4wiEs
         /8orxeuCo2KGWkgT+vKK+OMvKFLF68cwv48wyIO9H7rlH426rSg8q54PqS9WBNzNk+3P
         xjbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774325974; x=1774930774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHP/cgwApiu7vjtrG8hPnSAFW3clok7WHUaTU0v68KU=;
        b=kfHJYRPNWeQfAnjpng/M9VEf15wuhGp7muKsDM11KMqRK6pIgtK0Nh5UXe8zY7Nhcb
         pzE0fhSIxLqC842P8bvnAuFr5OO+4IPxNtmE0U1dmkX7IDqZfbh45lMOUq9TBsZYnEmL
         5y+B2wlSpLeKOa4MjWhAUKXYIMihZ32EBa4zlhDRhhWik29+ms/a3ApBjrmUCRxy3U5B
         DLWTBh5Fn7iR0PYCKsrVsMU72tpBXuJn6ilvcx9zamEOQgvbB/XP+YXlfHT3r07+YUOs
         sb/e6fLBfuWqYyU7ekAnw5EJyTb5tg6Ns1IOdj/yli15460RTVVDRjDDO8KFy1WS2keJ
         mTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774325974; x=1774930774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NHP/cgwApiu7vjtrG8hPnSAFW3clok7WHUaTU0v68KU=;
        b=FiZ1T1OqW3Xkd4GsKUxZaN94u5bchxTaBXDAjA+lciMw36UjeWsTqa1Ggqv8KZumNR
         t5u6UADvUhIjxjwRlI0CbiVRoD0AyfU48KRwnD4Y8VOy5EvLXg39OllDLn8s+nmbkpaE
         yZQSxK7AGf1fCJLt0QGXSYU98N7YoyY2Msgeg6mwl7dhNdDiTk3G0WUe7PDK53kwZ4bv
         vryRWj8+JpM3/JIJFKWS9f5J+hrOYI1J6eX132oOyouG/kFxXPqlC2MxsopKFy4T03tr
         1PapSeS5ZkJc1Mzo7XOGeEg2cRuMtWYZIy7CobIPqHPwcqUHRbleXxSZQ9+DEOr9kDUp
         MM8A==
X-Forwarded-Encrypted: i=1; AJvYcCVSkO1OofxZ/MZzZbnRGYL2721J3Yfdi103qmQqC1XRUYJ3l1Hl1rYhehAzGx16h/XyMKj8IlhtbJSiPuifQO6Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ykkEfz3AEMCUMyDBtlaSUjZ4m4APTcLMtJ+rw9BLyOFMu9Q4
	SV3Qbl6M0n/NaANVwQDEQbJRjTp4enJ20+oMwZIaJJ47VMTVAIFUycBtpuUt1UgACDyab8uvaEL
	Rh2o63fS4bTlFaFxRHOqv1qT9zrm7ZA6U1d1v+31J
X-Gm-Gg: ATEYQzzlPgxikqqSRLw1+wM0rGiVh0vpN7v6Jspsyf7J8K+7BMkRVykjz+fdzut2xZl
	yBsfGbkLM3Rg4/kD3EBrAb2l6OSokeSFrObY9lO9FvLecOd0m+hGv/5O3D4dHHbTQAT2cTKXuGt
	O/asTS+eGdqIyOLdXmUUv9X9qCT6eAtm73EjhtiCs2WTIoOEKRem3uyT52Utg2O9bQwwOoyTOmG
	CeSG4kNPb9ZotRkiCnzryDBPRTkJU901lkLUud2rTxUijNsPhC6RFvn/VMJNPPyqOVjDLqcKTtK
	HjKbV482
X-Received: by 2002:a05:7022:628e:b0:11a:44d1:533b with SMTP id
 a92af1059eb24-12a8e67af82mr80459c88.8.1774325973529; Mon, 23 Mar 2026
 21:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66d0366b-8690-4bde-aba4-1d51f278dfa1@linux.ibm.com>
 <abQq79_ajs8zFeEI@x1> <CAP-5=fWG0Q-xNGn_-_KGCopaNsWG5rUN3pYNLEh3K7+xE0OwVQ@mail.gmail.com>
 <abmt6FhLfWrzWGwU@x1> <abmyA5q9nXjagJIL@x1> <abm1nR-2xjOUBroD@x1>
 <CAP-5=fU76bLLgorJJ0CVXwTanaZTbjtV=EWA2evy8UjGE8Sw4Q@mail.gmail.com>
 <abnz0pxixB7L7-7R@x1> <CAP-5=fWmDYmyt5JGfVH77zjA6828Ocu7JP-B02=iifp+J_=9Tw@mail.gmail.com>
In-Reply-To: <CAP-5=fWmDYmyt5JGfVH77zjA6828Ocu7JP-B02=iifp+J_=9Tw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Mar 2026 21:19:21 -0700
X-Gm-Features: AQROBzBxLgTkWG_CnDsU5CZLM9-YOd1MVnraeRsWbCXSluZOpgtYNVo1Qco2s1g
Message-ID: <CAP-5=fVBNfJ8cABp+mWLJ+FjRWpxXLyrzr_H_pQTWd2ZZvgB_w@mail.gmail.com>
Subject: Re: perf stat issue with 7.0.0rc3
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	Jan Polensky <japo@linux.ibm.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 7:25=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Mar 17, 2026 at 5:37=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Tue, Mar 17, 2026 at 01:50:21PM -0700, Ian Rogers wrote:
> > > On Tue, Mar 17, 2026 at 1:12=E2=80=AFPM Arnaldo Carvalho de Melo <acm=
e@kernel.org> wrote:
> > > > On Tue, Mar 17, 2026 at 04:56:51PM -0300, Arnaldo Carvalho de Melo =
wrote:
> > > > > It is not trying PERF_COUNT_HW_STALLED_CYCLES_FRONTEND, is asking=
 for
> > > > > PERF_COUNT_HW_STALLED_CYCLES_BACKEND instead...
> >
> > > > If I instead ask just for stalled-cycles-frontend and
> > > > stalled-cycles-backend:
> >
> > > > root@number:~# strace -e perf_event_open perf stat -e stalled-cycle=
s-frontend,stalled-cycles-backend sleep 1
> >
> > > I think you intend for this to be system wide '-a'.
> >
> > > > perf_event_open({type=3DPERF_TYPE_RAW, size=3DPERF_ATTR_SIZE_VER9, =
config=3D0xa9, sample_period=3D0, sample_type=3DPERF_SAMPLE_IDENTIFIER, rea=
d_format=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING, d=
isabled=3D1, inherit=3D1, enable_on_exec=3D1, precise_ip=3D0 /* arbitrary s=
kid */, ...}, 250619, -1, -1, PERF_FLAG_FD_CLOEXEC) =3D 3
> > > > perf_event_open({type=3DPERF_TYPE_HARDWARE, size=3DPERF_ATTR_SIZE_V=
ER9, config=3DPERF_COUNT_HW_STALLED_CYCLES_BACKEND, sample_period=3D0, samp=
le_type=3DPERF_SAMPLE_IDENTIFIER, read_format=3DPERF_FORMAT_TOTAL_TIME_ENAB=
LED|PERF_FORMAT_TOTAL_TIME_RUNNING, disabled=3D1, inherit=3D1, enable_on_ex=
ec=3D1, precise_ip=3D0 /* arbitrary skid */, ...}, 250619, -1, -1, PERF_FLA=
G_FD_CLOEXEC) =3D -1 ENOENT (No such file or directory)
> > > > --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_pid=3D250=
619, si_uid=3D0, si_status=3D0, si_utime=3D0, si_stime=3D0} ---
> > > >
> > > >  Performance counter stats for 'sleep 1':
> > > >
> > > >            409,276      stalled-cycles-frontend
> > > >    <not supported>      stalled-cycles-backend
> > > >
> > > >        1.000428804 seconds time elapsed
> > > >
> > > >        0.000439000 seconds user
> > > >        0.000000000 seconds sys
> > > >
> > > >
> > > > --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DSI_USER, si_pid=3D250618=
, si_uid=3D0} ---
> > > > +++ exited with 0 +++
> > > > root@number:~#
> > > >
> > > > It used type=3DPERF_TYPE_RAW, config=3D0xa9 for  stalled-cycles-fro=
ntend but
> > > > type=3DPERF_TYPE_HARDWARE, config=3DPERF_COUNT_HW_STALLED_CYCLES_BA=
CKEND.
> > > >
> > > > =E2=AC=A2 [acme@toolbx perf-tools]$ git grep stalled-cycles-fronten=
d tools
> > > > tools/bpf/bpftool/link.c:       [PERF_COUNT_HW_STALLED_CYCLES_FRONT=
END] =3D "stalled-cycles-frontend",
> > > > tools/perf/builtin-stat.c:     3,856,436,920 stalled-cycles-fronten=
d   #   74.09% frontend cycles idle
> > > > tools/perf/pmu-events/arch/common/common/legacy-hardware.json:    "=
EventName": "stalled-cycles-frontend",
> > > > tools/perf/pmu-events/empty-pmu-events.c:/* offset=3D122795 */ "sta=
lled-cycles-frontend\000legacy hardware\000Stalled cycles during issue [Thi=
s event is an alias of idle-cycles-frontend]\000legacy-hardware-config=3D7\=
000\00000\000\000\000\000\000"
> > > > tools/perf/pmu-events/empty-pmu-events.c:/* offset=3D122945 */ "idl=
e-cycles-frontend\000legacy hardware\000Stalled cycles during issue [This e=
vent is an alias of stalled-cycles-frontend]\000legacy-hardware-config=3D7\=
000\00000\000\000\000\000\000"
> > > > tools/perf/pmu-events/empty-pmu-events.c:{ 122795 }, /* stalled-cyc=
les-frontend\000legacy hardware\000Stalled cycles during issue [This event =
is an alias of idle-cycles-frontend]\000legacy-hardware-config=3D7\000\0000=
0\000\000\000\000\000 */
> > > > tools/perf/tests/shell/stat+std_output.sh:event_name=3D(cpu-clock t=
ask-clock context-switches cpu-migrations page-faults stalled-cycles-fronte=
nd stalled-cycles-backend cycles instructions branches branch-misses)
> > > > tools/perf/util/evsel.c:        "stalled-cycles-frontend",
> > > > =E2=AC=A2 [acme@toolbx perf-tools]$
> > > >
> > > > This machine is:
> > > >
> > > > =E2=AC=A2 [acme@toolbx perf-tools]$ grep -m1 "model name" /proc/cpu=
info
> > > > model name      : AMD Ryzen 9 9950X3D 16-Core Processor
> > >
> > > Lots of missing legacy events on AMD. The problem is worse with -dd a=
nd -ddd.
> > >
> > > > =E2=AC=A2 [acme@toolbx perf-tools]
> > > >
> > > > And doesn't have PERF_COUNT_HW_STALLED_CYCLES_BACKEND, but has
> > > > PERF_COUNT_HW_STALLED_CYCLES_FRONTEND, that gets configured using
> > > > PERF_TYPE_RAW and 0xa9 because:
> > > >
> > > > root@number:~# cat /sys/devices/cpu/events/stalled-cycles-frontend
> > > > event=3D0xa9
> > > > root@number:~#
> > > >
> > > > But I couldn't so far explain why in the default case it is asking =
for
> > > > PERF_COUNT_HW_STALLED_CYCLES_BACKEND, when it should be asking for
> > > > PERF_COUNT_HW_STALLED_CYCLES_FRONTEND or PERF_TYPE_RAW+config=3D0xa=
9...
> >
> > So you mean that it goes on to try this:
> >
> >   {
> >         "BriefDescription": "Max front or backend stalls per instructio=
n",
> >         "MetricExpr": "max(stalled\\-cycles\\-frontend, stalled\\-cycle=
s\\-backend) / instructions",
> >         "MetricGroup": "Default",
> >         "MetricName": "stalled_cycles_per_instruction",
> >         "DefaultShowEvents": "1"
> >     },
> >
> > Yeah, it tries both:
> >
> > perf_event_open({type=3DPERF_TYPE_RAW, size=3DPERF_ATTR_SIZE_VER9, conf=
ig=3D0xa9, sample_period=3D0, sample_type=3DPERF_SAMPLE_IDENTIFIER, read_fo=
rmat=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_F=
ORMAT_ID|PERF_FORMAT_GROUP, inherit=3D1, precise_ip=3D0 /* arbitrary skid *=
/, ...}, 865157, -1, 14, PERF_FLAG_FD_CLOEXEC) =3D 15
> > perf_event_open({type=3DPERF_TYPE_RAW, size=3DPERF_ATTR_SIZE_VER9, conf=
ig=3D0x76, sample_period=3D0, sample_type=3DPERF_SAMPLE_IDENTIFIER, read_fo=
rmat=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_F=
ORMAT_ID|PERF_FORMAT_GROUP, disabled=3D1, inherit=3D1, enable_on_exec=3D1, =
precise_ip=3D0 /* arbitrary skid */, ...}, 865157, -1, -1, PERF_FLAG_FD_CLO=
EXEC) =3D 16
> > perf_event_open({type=3DPERF_TYPE_HARDWARE, size=3DPERF_ATTR_SIZE_VER9,=
 config=3DPERF_COUNT_HW_STALLED_CYCLES_BACKEND, sample_period=3D0, sample_t=
ype=3DPERF_SAMPLE_IDENTIFIER, read_format=3DPERF_FORMAT_TOTAL_TIME_ENABLED|=
PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, inherit=3D=
1, precise_ip=3D0 /* arbitrary skid */, ...}, 865157, -1, 16, PERF_FLAG_FD_=
CLOEXEC) =3D -1 ENOENT (No such file or directory)
>
> perf trace? The formatting on perf_event_open is better :-)
>
> > The RAW one is the equivalent to PERF_COUNT_HW_STALLED_CYCLES_FRONTEND,
> > I see now that I looked again at the 'strace perf stat sleep 1'
> >
> > But in the output it also says:
> >
> >      <not counted>      stalled-cycles-frontend          #      nan fro=
ntend_cycles_idle        (0.00%)
> >
> > And if I try just this one:
> >
> > root@number:~# strace -e perf_event_open perf stat -e stalled-cycles-fr=
ontend sleep 1
> > perf_event_open({type=3DPERF_TYPE_RAW, size=3DPERF_ATTR_SIZE_VER9, conf=
ig=3D0xa9, sample_period=3D0, sample_type=3DPERF_SAMPLE_IDENTIFIER, read_fo=
rmat=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING, disab=
led=3D1, inherit=3D1, enable_on_exec=3D1, precise_ip=3D0 /* arbitrary skid =
*/, ...}, 865273, -1, -1, PERF_FLAG_FD_CLOEXEC) =3D 3
> > --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_pid=3D865273,=
 si_uid=3D0, si_status=3D0, si_utime=3D0, si_stime=3D0} ---
> >
> >  Performance counter stats for 'sleep 1':
> >
> >            422,404      stalled-cycles-frontend
> >
> >        1.000432524 seconds time elapsed
> >
> >        0.000438000 seconds user
> >        0.000000000 seconds sys
> >
> >
> > --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DSI_USER, si_pid=3D865272, si=
_uid=3D0} ---
> > +++ exited with 0 +++
> > root@number:~#
> >
> > It works, so that line with stalled-cycles-frontend could have produced
> > the value, not '<not counted>', as this call succeeded:
> >
> > perf_event_open({type=3DPERF_TYPE_RAW, size=3DPERF_ATTR_SIZE_VER9, conf=
ig=3D0xa9, sample_period=3D0, sample_type=3DPERF_SAMPLE_IDENTIFIER, read_fo=
rmat=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_F=
ORMAT_ID|PERF_FORMAT_GROUP, inherit=3D1, precise_ip=3D0 /* arbitrary skid *=
/, ...}, 865157, -1, 14, PERF_FLAG_FD_CLOEXEC) =3D 15
> > perf_event_open({type=3DPERF_TYPE_RAW, size=3DPERF_ATTR_SIZE_VER9, conf=
ig=3D0x76, sample_period=3D0, sample_type=3DPERF_SAMPLE_IDENTIFIER, read_fo=
rmat=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_F=
ORMAT_ID|PERF_FORMAT_GROUP, disabled=3D1, inherit=3D1, enable_on_exec=3D1, =
precise_ip=3D0 /* arbitrary skid */, ...}, 865157, -1, -1, PERF_FLAG_FD_CLO=
EXEC) =3D 16
> >
> > Maybe the explanation is that it tries the metric, that uses both
> > frontend and backend, it fails at backend and then it discards the
> > frontend?
>
> The metric logic tries to be smart, creating groups of events and then
> sharing events between groups to avoid programming more events. I
> suspect the frontend and backend are in a group, maybe the backend is
> the leader. The backend fails to open, resulting in no group_fd and a
> broken group for both the metrics.
>
> > > So the default events/metrics are now in json:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-n=
ext.git/tree/tools/perf/pmu-events/arch/common/common/metrics.json?h=3Dperf=
-tools-next
> > > Relating to the stalls there are:
> > > ```
> > >     {
> > >         "BriefDescription": "Max front or backend stalls per instruct=
ion",
> > >         "MetricExpr": "max(stalled\\-cycles\\-frontend,
> > > stalled\\-cycles\\-backend) / instructions",
> > >         "MetricGroup": "Default",
> > >         "MetricName": "stalled_cycles_per_instruction",
> > >         "DefaultShowEvents": "1"
> > >     },
> >
> > root@number:~# strace -e perf_event_open perf stat -M stalled_cycles_pe=
r_instruction sleep 1
> > perf_event_open({type=3DPERF_TYPE_HARDWARE, size=3DPERF_ATTR_SIZE_VER9,=
 config=3DPERF_COUNT_HW_STALLED_CYCLES_BACKEND, sample_period=3D0, sample_t=
ype=3DPERF_SAMPLE_IDENTIFIER, read_format=3DPERF_FORMAT_TOTAL_TIME_ENABLED|=
PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, disabled=
=3D1, inherit=3D1, enable_on_exec=3D1, precise_ip=3D0 /* arbitrary skid */,=
 ...}, 865362, -1, -1, PERF_FLAG_FD_CLOEXEC) =3D -1 ENOENT (No such file or=
 directory)
> > Error:
> > No supported events found.
> > The stalled-cycles-backend event is not supported.
> > --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_KILLED, si_pid=3D865362,=
 si_uid=3D0, si_status=3DSIGTERM, si_utime=3D0, si_stime=3D0} ---
> > +++ exited with 1 +++
> > root@number:~#
> >
> > >     {
> > >         "BriefDescription": "Frontend stalls per cycle",
> > >         "MetricExpr": "stalled\\-cycles\\-frontend / cpu\\-cycles",
> > >         "MetricGroup": "Default",
> > >         "MetricName": "frontend_cycles_idle",
> > >         "MetricThreshold": "frontend_cycles_idle > 0.1",
> > >         "DefaultShowEvents": "1"
> > >     },
> >
> > root@number:~# strace -e perf_event_open perf stat -M frontend_cycles_i=
dle sleep 1
> > perf_event_open({type=3DPERF_TYPE_RAW, size=3DPERF_ATTR_SIZE_VER9, conf=
ig=3D0x76, sample_period=3D0, sample_type=3DPERF_SAMPLE_IDENTIFIER, read_fo=
rmat=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_F=
ORMAT_ID|PERF_FORMAT_GROUP, disabled=3D1, inherit=3D1, enable_on_exec=3D1, =
precise_ip=3D0 /* arbitrary skid */, ...}, 865414, -1, -1, PERF_FLAG_FD_CLO=
EXEC) =3D 3
> > perf_event_open({type=3DPERF_TYPE_RAW, size=3DPERF_ATTR_SIZE_VER9, conf=
ig=3D0xa9, sample_period=3D0, sample_type=3DPERF_SAMPLE_IDENTIFIER, read_fo=
rmat=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_F=
ORMAT_ID|PERF_FORMAT_GROUP, inherit=3D1, precise_ip=3D0 /* arbitrary skid *=
/, ...}, 865414, -1, 3, PERF_FLAG_FD_CLOEXEC) =3D 4
> > --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_pid=3D865414,=
 si_uid=3D0, si_status=3D0, si_utime=3D0, si_stime=3D0} ---
> >
> >  Performance counter stats for 'sleep 1':
> >
> >            881,022      cpu-cycles                       #     0.48 fro=
ntend_cycles_idle
> >            422,386      stalled-cycles-frontend
> >
> >        1.000468505 seconds time elapsed
> >
> >        0.000504000 seconds user
> >        0.000000000 seconds sys
> >
> >
> > --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DSI_USER, si_pid=3D865413, si=
_uid=3D0} ---
> > +++ exited with 0 +++
> > root@number:~#
> > >     {
> > >         "BriefDescription": "Backend stalls per cycle",
> > >         "MetricExpr": "stalled\\-cycles\\-backend / cpu\\-cycles",
> > >         "MetricGroup": "Default",
> > >         "MetricName": "backend_cycles_idle",
> > >         "MetricThreshold": "backend_cycles_idle > 0.2",
> > >         "DefaultShowEvents": "1"
> > >     },
> >
> > root@number:~# strace -e perf_event_open perf stat -M backend_cycles_id=
le sleep 1
> > perf_event_open({type=3DPERF_TYPE_RAW, size=3DPERF_ATTR_SIZE_VER9, conf=
ig=3D0x76, sample_period=3D0, sample_type=3DPERF_SAMPLE_IDENTIFIER, read_fo=
rmat=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_F=
ORMAT_ID|PERF_FORMAT_GROUP, disabled=3D1, inherit=3D1, enable_on_exec=3D1, =
precise_ip=3D0 /* arbitrary skid */, ...}, 865442, -1, -1, PERF_FLAG_FD_CLO=
EXEC) =3D 3
> > perf_event_open({type=3DPERF_TYPE_HARDWARE, size=3DPERF_ATTR_SIZE_VER9,=
 config=3DPERF_COUNT_HW_STALLED_CYCLES_BACKEND, sample_period=3D0, sample_t=
ype=3DPERF_SAMPLE_IDENTIFIER, read_format=3DPERF_FORMAT_TOTAL_TIME_ENABLED|=
PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, inherit=3D=
1, precise_ip=3D0 /* arbitrary skid */, ...}, 865442, -1, 3, PERF_FLAG_FD_C=
LOEXEC) =3D -1 ENOENT (No such file or directory)
> > --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_pid=3D865442,=
 si_uid=3D0, si_status=3D0, si_utime=3D0, si_stime=3D0} ---
> >
> >  Performance counter stats for 'sleep 1':
> >
> >      <not counted>      cpu-cycles                       #      nan bac=
kend_cycles_idle
> >    <not supported>      stalled-cycles-backend
> >
> >        1.000739264 seconds time elapsed
> >
> >        0.000675000 seconds user
> >        0.000000000 seconds sys
> >
> >
> > --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DSI_USER, si_pid=3D865441, si=
_uid=3D0} ---
> > +++ exited with 0 +++
> > root@number:~#
> >
> > > ```
> > > The stalled_cycles_per_instruction and backed_cycles_idle should fail
> > > as the stalled-cycles-backend event is missing. frontend_cycles_idle
> > > should work, I wonder if the 0 counts relate to trouble scheduling
> > > groups of events. I'll need more verbose output to understand. Perhap=
s
> > > for stalled_cycles_per_instruction, we should modify the metric to
> > > tolerate missing events:
> > >
> > > max(stalled\\-cycles\\-frontend if
> > > have_event(stalled\\-cycles\\-frontend) else 0,
> > > stalled\\-cycles\\-backend if have_event(stalled\\-cycles\\-backend)
> > > else 0) / instructions
> >
> > That have_event() part also have to be implemented, right?
>
> I mistyped, has_event not have_event :-)

I posted:
https://lore.kernel.org/lkml/20260319010103.834106-1-irogers@google.com/
that implements the has_event approach.

Thanks,
Ian

> Thanks,
> Ian
>
> > - Arnaldo
