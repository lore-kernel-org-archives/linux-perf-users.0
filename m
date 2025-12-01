Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160DC192B75
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 23:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764632017; cv=none; b=aQaTmkxRqE1puBfwV3ZmJQqKY3cnlCUdCb2Y+nguRuRbVhYtcSS5hRzma0GcLh4XfH7Z5B9NX1202jvY734qGm/CGn8yo8y0OHRv723LHtVctmT/1Qy08snWHMQY8rJAYIkcTn1zReXWXKgB4bdcGdOdGd+KW/R8oRtvjv0qljw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764632017; c=relaxed/simple;
	bh=mqEmSWIayMgrBHVxTSJ+aILcYCD7UFsfnFcJEZE+4bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e40bFbTgd3wwy5bpkSlQPLxlOggGYSixeYDGTbXpij61fPAKHEVmSuIHJpYivIzYm/2CktdzOX4in0s0WlS0cXQOP67CqeuNTbYmKy2bT//27QavHM82twNrQyEaHbxuvk138hirrsRdMmvL43b+Jp/3lKYDxzZTSvs4ME77jOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pkG4zIoF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pkG4zIoF"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2980343d9d1so829285ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 15:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764632015; x=1765236815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KU+Xhsb0wVLfae+h6Tff84XzrZeWfQsHJXytg0YbSkQ=;
        b=pkG4zIoFhePjvyaAsI7vu7eYaWWEgOCyWU4gxd4wpo9ISIYKz649Md//o0TZ8/1m44
         cExg8wJxJWrR/GZSKfNohyi0doniNU4KKljd2vpyjtf+5hyItBTT/Wi5DYlg4+H+aABf
         gRZVfvhbIiF1i1cCo10apXznyQQjNZANAVnwzjkqs2KIXgstWaW6JDVRYD6/PMwkHq/G
         8hCitrlYDcQOonFqbj4pUH5rSjJv8L+30LV9khcOOgNkO8cVFX7BipF7wZXxm6hggEaA
         bdRBCVbe3GL0eXCdW5Qs/LMSfgXihyotfVprHdRy+1qJTPorCsWWXeZr8KjbtXDQI+U8
         Icqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764632015; x=1765236815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KU+Xhsb0wVLfae+h6Tff84XzrZeWfQsHJXytg0YbSkQ=;
        b=dfEa5WfXyfU/tYUQ91GBljqE5kxi7glCGcxNwXzqKmhFFnqLbEcH+ztYxaioV1/vbS
         7owKLvpp+FTt21jojjYzNcMTzM3jOHITAsHp14Hb/Wq+29IteyxAj/jcUOcMcAaymk5F
         x9jd7kHgz5g5yciuwpUOpKfTZlLUwWMxKZK/c06HVrdEAxwfHiQvZz2nvgy2+7Vct0Bq
         HL/0W49Fbgv5sj7T8M2rW/OX1tSbBOfYnK9eIODbHZc2WwdYP/bUMn3u+U1H+r2k0cC0
         Jzuf94Jv75T/wHSnyPBlq0ly+a6g17/aZWW4NVlQIrJ7lF2p4L7dLkOhseWwJiYuEyrH
         Siew==
X-Gm-Message-State: AOJu0Yzh8lEPt0E9yKAKoWLxu4ycJiJPIfDBo4RWj6LWIy8mQMfkbecr
	mwG3mMt3HOVCk5SJRvCqGHwsWWHowlYKCMmO6CpnqjYPuYvnRciuoLlR3fCQ2yAb8l/A45OdmSM
	/Oh+wdzjEsJG5GqH7V9chTS4vm3BkeGfSuo+PUJdo
X-Gm-Gg: ASbGncsGelVZlEg6Gvo9BLrVEnWL0h4f2Hm3xwZ3FGbbbLcyByRxc+BRDfZkiYCC8VV
	1GzxPMTAL3tWUXS9xdbPs9mbkET253AUijiArjQ28ADTOdXEENk0r3rNu/Nqq2/wfFk1+Xwy0Iv
	olq2+pQN08hUUTQJSl1pK7AFVvQJc4PMP4sb0w8NQEoZKMQkHz1tC7Q+N0Ef8nXcsz80IPu+TVj
	7YQJVqjnn3LyKCgozJAe1i8sggijzZXKyUU7mcraNd1UjcwmVlfqOW81nQqEhYpUd51A6unwEnK
	XMv6ZjjeA149m4B0ZycajW7v4Q==
X-Google-Smtp-Source: AGHT+IHBOdhxjPt23CmqXvN+ReHT/c8bI6cFxqfE6eJLINAxpcHRG1O0ScvEhXFl+auLNtkKYMFtA6TiEe6pPgvCzOU=
X-Received: by 2002:a17:902:d4c8:b0:294:e585:1f39 with SMTP id
 d9443c01a7336-29d5a4989eemr397955ad.14.1764632014896; Mon, 01 Dec 2025
 15:33:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aSwt7yzFjVJCEmVp@gmail.com> <CAP-5=fXK8HORZaFUxydEatLV1xXQTcLLBnEMeveJYDHDQPkf_w@mail.gmail.com>
 <aS3WXn4nz9GE87bM@gmail.com>
In-Reply-To: <aS3WXn4nz9GE87bM@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 1 Dec 2025 15:33:23 -0800
X-Gm-Features: AWmQ_bl_0AmW3dgVWpJS7NRUa5sTSiX78e2w2bZspNk_NoThxxw-K6eZdXBYILM
Message-ID: <CAP-5=fX6NFb_n8i5Pj5Dk2u+PGuHwxsoo4B7UbkPH_1+MhEYLg@mail.gmail.com>
Subject: Re: [PATCH] Fix (well, work around) perf stat --null segfault
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 9:54=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * Ian Rogers <irogers@google.com> wrote:
>
> > Agreed on the trainwreck :-) So NULL is a valid CPU map value. It
> > means no CPUs, but magically no CPUs can also be converted in the code
> > to become the "any" CPU value of -1. So iterating the perf_cpu_map of
> > NULL will yield a single CPU of -1 :-( This behavior existed before my
> > time working on the code, I've tried to make the expectation in the
> > using code clearer, does the user want the magic "any" CPU behavior?
> > "any" CPU is distinct from every/all CPUs which would be something
> > like CPUs 0-127, and then does "all" include online and offline CPUs?
> > This is something that's been discussed and I think things can be
> > better, I'd rather the code was explicit whenever terms like "all",
> > "online" and "any" were being used - it is very easy to confuse "all"
> > and "any". I've been trying to adjust the code and make it more
> > sensible with changes like:
> > https://lore.kernel.org/all/20240202234057.2085863-1-irogers@google.com=
/
> > but I agree with you that things are a mess here. At least we
> > shouldn't be leaking memory (due to the reference count checking) and
> > we shouldn't confuse indices and CPU numbers (due to the introduction
> > of a wrapper type), problems that were pervasive and broke things like
> > uncore counters frequently before.
> >
> > Fwiw, part of me thinks we should change the perf_cpu_map to be a
> > cpu_set_t, the "any" case could be an additional boolean in the
> > struct. Perhaps we can just auto change "all" to "any" as is somewhat
> > done here:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/lib/perf/evlist.c?h=3Dperf-tools-next#n92
> > Then perf_cpu_map can be a cpu_set_t and I think life will be clearer.
>
> Yeah, so when I looked at the data structure a few
> minutes ago:
>
>         /**
>          * A sized, reference counted, sorted array of integers represent=
ing CPU
>          * numbers. This is commonly used to capture which CPUs a PMU is =
associated
>          * with. The indices into the cpumap are frequently used as they =
avoid having
>          * gaps if CPU numbers were used. For events associated with a pi=
d, rather than
>          * a CPU, a single dummy map with an entry of -1 is used.
>          */
>         DECLARE_RC_STRUCT(perf_cpu_map) {
>                 refcount_t      refcnt;
>                 /** Length of the map array. */
>                 int             nr;
>                 /** The CPU values. */
>                 struct perf_cpu map[];
>         };
>
>
> My first thought was "Why isn't this a bitmask?". :-)
>
> The thing is, even with 8192 CPUs, the mask size is 1K.
> That's still not catastrophic compared to the nightmare
> of managing a [8192] array...
>
> And I would keep such core data structures as simple as
> possible: a single continuous bitmask. No sparse
> support, no NULL tricks. Just an always-present
> bitmask, and maybe an any/all modifier flag if the ABIs
> strongly suggest so.
>
> The closer a data structure is to the core concepts of
> a tool, the more important its robust KISS properties
> are - at almost any runtime cost. </handwaving> :)

Agreed. Some more things I can think of:

- the perf vs libperf separation is kind of redundant. The API of
libperf isn't good enough (no event parsing), nor stable and because
the license is GPLv2 doesn't benefit external users. It is a chore
making changes in two places and I think we should just focus on
making the python API the extension point.

- the /sys/bus/event_source/devices/<pmu>/cpumask aren't consistent in
whether there are hot plugged CPUs in there. Kan cleaned this up but
only as far as Intel PMUs:
https://lore.kernel.org/all/20240802151643.1691631-1-kan.liang@linux.intel.=
com/

- ARM PMUs ignore hot plugging leading to a scary intersect:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/arch/arm/util/pmu.c?h=3Dperf-tools-next#n42

But we did manage to make event encoding/displaying consistent with:
https://lore.kernel.org/lkml/20251005182430.2791371-1-irogers@google.com/
something I will no doubt get emails about in this v6.19 merge window :-)

> > Fwiw, even on the kernel side this is borked as I tried to explain in
> > this RFC with 0 follow ups:
> > https://lore.kernel.org/lkml/20250716223924.825772-1-irogers@google.com=
/
>
> So that's a neat patch and kudos on the ASCII graphics. :-)
>
> I'd suggest a re-send.

Agreed. I think it needs a refresh, I'll try to find the time.

> > Imagine the case of an event opened with 1 CPU and a TID. The filter
> > will mean the counter only counts on the 1 CPU but the enabled and
> > running time will mean the counter will be scaled (on your system) 128
> > times!
> > All of this matters when you consider different events opened in the
> > same evlist and there being combined perf_cpu_maps like the evlist's
> > all_cpus value.
>
> > > -       nr =3D perf_cpu_map__max(evsel_list->core.all_cpus).cpu + 1;
> > > +       if (evsel_list->core.all_cpus)
> > > +               nr =3D perf_cpu_map__max(evsel_list->core.all_cpus).c=
pu + 1;
> > > +       else
> > > +               nr =3D 0;
> >
> > So I think the better fix is to make max handle a NULL perf_cpu_map.
> > That will yield "any" CPU of -1 ( :-( ) and then the -1 + 1 will give
> > an empty aggregation map.
> >
> > I'll write this up, add the test and see if I can spot similar issues
> > wrt NULL in the vicinity in the perf_cpu_map code.
>
> Thank you! In the short run I'd prefer whichever fix
> can restore perf stat --null functionality the fastest. ;-)

Done in the series:
https://lore.kernel.org/lkml/20251201230904.290733-1-irogers@google.com/

Thanks,
Ian

> Thanks,
>
>         Ingo
