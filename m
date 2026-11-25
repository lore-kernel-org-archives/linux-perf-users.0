Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795583573;
	b=S5TCbz8fefkqcQq0Skb/M2vO95Z3493JqDBMxwNcwyltZqyYWK/nXVaAEOVAXcV+LDsU
	 bGE2m/r7MTPbsJWp1HbxXDwqVXt8z5AptzG4izpKbAJvPVVjrM8LyuUqg2sQAxoCHdSF6
	 wGDZU2RePjTYP7qhcF3jjZCBMY/XlfpVJUXbjltY0U8LY4nH5A3DGlccWg4yqC/MWDY0Y
	 QWU7adPw/BBIOid2VDLY5Apzj0mRkOanMe0g4m9UsKFauVK2LAEn7AZ9MXpDUSRttJ3Zf
	 P4I6OT0fbLyQUn3zekXeiSpeHttsBct7pEGQSdK5eqR6LEE5C3+zDgFuAzK8wZ3WFag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795583573;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=rfwf34HIxiOtN9LZiUCjhKlH6eVj1PwaBvuDGB/T58o=;
	b=csz8hMvx/w2tMVLKX4equT2gfwHw7PpseMvN4KBL1kberjxSYljslXjD9vu2jIpJPogg
	 0wNrYSPgks1BQz25QSGiS2nsDyIfZzZpVXWj842JCzCc+Up3EyYHAwz9VA9tQuXIwbCyU
	 WAenHTnK2jY2sljcveiJRW6GN2JEzXf8+xSzt2ai4prsjKGr2F6cMWqDox/y74Nyl6Dfn
	 d9PtAxGgOU+shZ1cPAvFybk3LqONkaViTLJclsRbQYaBVrMGE5KIrzFWbjrrUOeHLigGq
	 25FrIrk6IpTj6MOAwyR58U/QMu+5dSejhpK6hSOvm1zD1VecOkAmss80F2aU+8qXM4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p+tx0w77;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D53606A31E
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 05:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94D53606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p+tx0w77
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-55c7445cf85so1053311cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 21:12:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795583571; cv=none;
        d=google.com; s=arc-20260327;
        b=CXhXTyM+QtzrHjQgh8qiXSqtIWgs7UzwYXZD/wNpm3+IQk98mqVWRwLu+Sw0GCcxLv
         pSp0NY/E02vpDX6ma7i0NUQZxQ0X7bYJELXwV86zmX5Di4W1JH6n9ngL2ZcnOaaKRI5Q
         MFqQ/4SopJ5RPoaghPao7jln4SqEAkHz0qZTCYo6uX0pEdnpema3kAso5uEJ67xPWCgf
         11BGIaQDHVfF0z/wnw5Mb01OJB1TUSiugrnDtpg/dCpDyPDB8AIPetFXLPmLzKTAOqcN
         DslgzyOc1XSlS+nD69fYFK/EqUwteyWDiMCsBxTXu9FVZgrqTCEIQ+W4RNQ/RODZv3BI
         7yYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rfwf34HIxiOtN9LZiUCjhKlH6eVj1PwaBvuDGB/T58o=;
        fh=nqATmclcuKAo6itQ7W6adKkfqXKLVeFXJjB774JASKo=;
        b=ZkpT0uw98/al8cNujBfPdnT0r5Lwbmbu7PiXNBAxg9XAp6GMTSsmB7ozmmC7D77/Hq
         PnyGiIZe+MHu1OE858XR6AfO1lGQkIDr201iPPnlIwDMcz6GFXIPrdFNKe+dJyHCrKZD
         XO7W6fv6KtAGGFfD98zpfftvyXZQgib/7cDxmPAI+V6lADceae9/56m51CSO8/PdIYzG
         Vz4N1mKGewaU4TS1a248L1mAWsyvFHmGkUI81nuxU6niY+fPeYUM9U0YHkkVeKchQesl
         1qHcqKXrsPZ2FNlzX9R1CN1PcV5L1UHDvPZdxvv4zAUML/Re9erfXgx/aucmjcws42an
         MnVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795583571; x=1796188371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rfwf34HIxiOtN9LZiUCjhKlH6eVj1PwaBvuDGB/T58o=;
        b=p+tx0w77Inb4Rk5FkuItfpJFsURCDdOL35a1RN3fkbesELLiT9IKdOCQn3uVWoadPt
         hl37uqIlzid/VsAFyPrd5vHft9Jbzg97dUQ1TUPVWEmrg5kZmsxDT5sMod+v+X7BXxvp
         ZszXOqYIhR5zKIeEXeWOnQPbiHxiLnc+13TesfY8ULjdzTHtJsE0Gpni0VTr8CMLZbvC
         GVmOSmLOhcLIW70b55dlBD+1jHyZCxU4PrMCeNnV+Mi86yS5eReMz9xmddipwu+uO5cT
         KZJ8FbrglbdAmO/9xyBqU3lE09iyN8SfcHz6UeV0is1l1aqaDPM7VLRAepg3M2ssSX7d
         GpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795583571; x=1796188371;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rfwf34HIxiOtN9LZiUCjhKlH6eVj1PwaBvuDGB/T58o=;
        b=T9NksyUqzSXs22tkBUwanYQL7I4V/BNXgeN6z9Mqim1+ZAD5j4rB1Hucih3tU6Wvtw
         eBJpxORK5P8nAzSMEG6OKuy98XNOc3uiR1Ow1FLwHdURyIoU0/G+TCQ6+b4MWE+cuyln
         Lnckff3Vs3uVewV+EbppJD/rNaFy70gCWkM8uzjAgUwTvIAxd6WH9gjnWUAeRCf907Pl
         pA9kZ4DySVO+DTkadQwlJ7PUAKUjyY4AeFBa9l8ZomTc5StVz8gBEorcq9x6G0o4wtCz
         zrYSsqXpNm+skFOxtEdY07f0sN10KOJoWyC7+WLzf5RL7yjk5efb3bMxYTmTVHyo399z
         hljw==
X-Gm-Message-State: APuU4Z+njSw4D/fmyzCRP5+nuv3BAAILSh/jCzbO0W2toLVL63K6Kz5p
	4ABmeyWYCiXrSHJFsmyhbm/nxTQnxHgQHsDx6rFZb3qCAm9aXYuainrR/l6JjvzgsWNXaM4HkJR
	hAeXnxIj3FZu+XjvJDk/sjnyplmwFnUWMwHOFizFc
X-Gm-Gg: AZFdTZe25b6jjfdd4g9mfHNexHYcBtlh2g0YLaXiRueAgKCVJ0RCSVuKCR4vtJGTrNR
	DwHuvwYgVtrvThg+1pUBrBK6oX+EooFV4yJnKUXbRHkG1/6PdmWjPRZYMyaGUiVvNGHMhWaLqyt
	aRl8gef+F4ji+WnUuzvbEvf17OKva7s0CGWo4DKfPmcjnRpguUO7XVAvZOQ9wBWMaKf99EiaaER
	MXGDqC3rrIz0ldpDo4xgJxW/SFuQn+1xRiNvrhPs2uHdgDu9sPD0KiouwMEE7pvsrI2QTooNkwV
	9/+iUY0BoXstHu1rARTgl6DhY5UMH1g5gx7K7feiZCQag9XBzONFKplAbz7a6reAC4zhlkyUD37
	hIaA2lGQKpXa1XOSJK+M+SFW+uH9hzq0MBgsT
X-Received: by 2002:a05:622a:4d0a:b0:535:9aa3:5ebb with SMTP id
 d75a77b69052e-55d88ff9c21mr70231651cf.8.1795583570833; Tue, 24 Nov 2026
 21:12:50 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <aSwt7yzFjVJCEmVp@gmail.com> <CAP-5=fXK8HORZaFUxydEatLV1xXQTcLLBnEMeveJYDHDQPkf_w@mail.gmail.com>
 <aS3WXn4nz9GE87bM@gmail.com> <CAP-5=fX6NFb_n8i5Pj5Dk2u+PGuHwxsoo4B7UbkPH_1+MhEYLg@mail.gmail.com>
In-Reply-To: <CAP-5=fX6NFb_n8i5Pj5Dk2u+PGuHwxsoo4B7UbkPH_1+MhEYLg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Nov 2026 21:12:39 -0800
X-Gm-Features: Aa3M54pMXwQWSACcK0YCwSgF8YXTiL1oMUPyf1A4vPk30_Tkt_1wYXetrMjmTLE
Message-ID: <CAP-5=fUMR_jbxYCLFy81OfttXMASOP-TMp+hd7S3KThVLK8-GA@mail.gmail.com>
Subject: Re: [PATCH] Fix (well, work around) perf stat --null segfault
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 3:33=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Mon, Dec 1, 2025 at 9:54=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wro=
te:
> >
> >
> > * Ian Rogers <irogers@google.com> wrote:
> >
> > > Agreed on the trainwreck :-) So NULL is a valid CPU map value. It
> > > means no CPUs, but magically no CPUs can also be converted in the cod=
e
> > > to become the "any" CPU value of -1. So iterating the perf_cpu_map of
> > > NULL will yield a single CPU of -1 :-( This behavior existed before m=
y
> > > time working on the code, I've tried to make the expectation in the
> > > using code clearer, does the user want the magic "any" CPU behavior?
> > > "any" CPU is distinct from every/all CPUs which would be something
> > > like CPUs 0-127, and then does "all" include online and offline CPUs?
> > > This is something that's been discussed and I think things can be
> > > better, I'd rather the code was explicit whenever terms like "all",
> > > "online" and "any" were being used - it is very easy to confuse "all"
> > > and "any". I've been trying to adjust the code and make it more
> > > sensible with changes like:
> > > https://lore.kernel.org/all/20240202234057.2085863-1-irogers@google.c=
om/
> > > but I agree with you that things are a mess here. At least we
> > > shouldn't be leaking memory (due to the reference count checking) and
> > > we shouldn't confuse indices and CPU numbers (due to the introduction
> > > of a wrapper type), problems that were pervasive and broke things lik=
e
> > > uncore counters frequently before.
> > >
> > > Fwiw, part of me thinks we should change the perf_cpu_map to be a
> > > cpu_set_t, the "any" case could be an additional boolean in the
> > > struct. Perhaps we can just auto change "all" to "any" as is somewhat
> > > done here:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-n=
ext.git/tree/tools/lib/perf/evlist.c?h=3Dperf-tools-next#n92
> > > Then perf_cpu_map can be a cpu_set_t and I think life will be clearer=
.
> >
> > Yeah, so when I looked at the data structure a few
> > minutes ago:
> >
> >         /**
> >          * A sized, reference counted, sorted array of integers represe=
nting CPU
> >          * numbers. This is commonly used to capture which CPUs a PMU i=
s associated
> >          * with. The indices into the cpumap are frequently used as the=
y avoid having
> >          * gaps if CPU numbers were used. For events associated with a =
pid, rather than
> >          * a CPU, a single dummy map with an entry of -1 is used.
> >          */
> >         DECLARE_RC_STRUCT(perf_cpu_map) {
> >                 refcount_t      refcnt;
> >                 /** Length of the map array. */
> >                 int             nr;
> >                 /** The CPU values. */
> >                 struct perf_cpu map[];
> >         };
> >
> >
> > My first thought was "Why isn't this a bitmask?". :-)
> >
> > The thing is, even with 8192 CPUs, the mask size is 1K.
> > That's still not catastrophic compared to the nightmare
> > of managing a [8192] array...
> >
> > And I would keep such core data structures as simple as
> > possible: a single continuous bitmask. No sparse
> > support, no NULL tricks. Just an always-present
> > bitmask, and maybe an any/all modifier flag if the ABIs
> > strongly suggest so.
> >
> > The closer a data structure is to the core concepts of
> > a tool, the more important its robust KISS properties
> > are - at almost any runtime cost. </handwaving> :)
>
> Agreed. Some more things I can think of:
>
> - the perf vs libperf separation is kind of redundant. The API of
> libperf isn't good enough (no event parsing), nor stable and because
> the license is GPLv2 doesn't benefit external users. It is a chore
> making changes in two places and I think we should just focus on
> making the python API the extension point.
>
> - the /sys/bus/event_source/devices/<pmu>/cpumask aren't consistent in
> whether there are hot plugged CPUs in there. Kan cleaned this up but
> only as far as Intel PMUs:
> https://lore.kernel.org/all/20240802151643.1691631-1-kan.liang@linux.inte=
l.com/
>
> - ARM PMUs ignore hot plugging leading to a scary intersect:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/arch/arm/util/pmu.c?h=3Dperf-tools-next#n42
>
> But we did manage to make event encoding/displaying consistent with:
> https://lore.kernel.org/lkml/20251005182430.2791371-1-irogers@google.com/
> something I will no doubt get emails about in this v6.19 merge window :-)
>
> > > Fwiw, even on the kernel side this is borked as I tried to explain in
> > > this RFC with 0 follow ups:
> > > https://lore.kernel.org/lkml/20250716223924.825772-1-irogers@google.c=
om/
> >
> > So that's a neat patch and kudos on the ASCII graphics. :-)
> >
> > I'd suggest a re-send.
>
> Agreed. I think it needs a refresh, I'll try to find the time.

Following up here: I've refreshed, tested, and sent out a non-RFC v2
along with `perf test` coverage in:
https://lore.kernel.org/linux-perf-users/80d983c5713537f5743b69e9b35ced1177=
e4732e.1795582691.git.irogers@google.com/

Thanks,
Ian

> > > Imagine the case of an event opened with 1 CPU and a TID. The filter
> > > will mean the counter only counts on the 1 CPU but the enabled and
> > > running time will mean the counter will be scaled (on your system) 12=
8
> > > times!
> > > All of this matters when you consider different events opened in the
> > > same evlist and there being combined perf_cpu_maps like the evlist's
> > > all_cpus value.
> >
> > > > -       nr =3D perf_cpu_map__max(evsel_list->core.all_cpus).cpu + 1=
;
> > > > +       if (evsel_list->core.all_cpus)
> > > > +               nr =3D perf_cpu_map__max(evsel_list->core.all_cpus)=
.cpu + 1;
> > > > +       else
> > > > +               nr =3D 0;
> > >
> > > So I think the better fix is to make max handle a NULL perf_cpu_map.
> > > That will yield "any" CPU of -1 ( :-( ) and then the -1 + 1 will give
> > > an empty aggregation map.
> > >
> > > I'll write this up, add the test and see if I can spot similar issues
> > > wrt NULL in the vicinity in the perf_cpu_map code.
> >
> > Thank you! In the short run I'd prefer whichever fix
> > can restore perf stat --null functionality the fastest. ;-)
>
> Done in the series:
> https://lore.kernel.org/lkml/20251201230904.290733-1-irogers@google.com/
>
> Thanks,
> Ian
>
> > Thanks,
> >
> >         Ingo
