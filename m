Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF14B16BE32
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Aug 2024 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887319; cv=none; b=iQc2XAIG3vgIdIUI6lMp4Gv0YrO4nqsTajXsgtBtuP9O3t1sIt2rwtxwEjkaExrAUc3CHEQwqMad2EGTnWE4mdJax8aVf7WYTSlXgbELXNHxMCfTFLDbfQyShAagNp5BqE5rDEptTYzcSbXvPjl0AV9I81DgNDqlXTYmO/yJHPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887319; c=relaxed/simple;
	bh=Dr57dJtQ38Gbe8CPMfmBqTXW8AJCnClRmVh6ulllSQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cd6X2mWGHyJPD8YG9yH1N69p8icwjsp/pqwYmwSd8BX8O/qJnFQDXeDgRGL1detzQrUGqs6JgdhKUm6piBRKrn1IUNK6aXFQGKTQsgr6q86RuTbRMuTlv5X9gXKfRoISN21JpgVj4YriK2TsgPLljysHGC2YvsVKnt9TPXSuUIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nv5r0B+l; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nv5r0B+l"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39a16fab332so34145ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Aug 2024 12:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722887316; x=1723492116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hvhgLue4AXt3dLDPL8T2PtC1iyTJfy9ADyuT3yI42s=;
        b=nv5r0B+lIn66In6KvS1s/xks991mWvHTS1gdhHl0unEGW+i+cV3/NsJnjpdZ106THl
         q/OywDeq2PpXzIrhzJuq1O2mu0PBGth+AC6bub6ipTB5Fs2+TkxgpIw/NKFUaqjZyeVM
         fYRfQ5e3qK5w+a3vEw5LpY64QLQ0vK1kXZMHhRujUgYZg/Qa9zCuJgoO3to4zs/gKO/3
         rYfu+uX5iL5J8p1hq+aCJLgjuEIEHDQl7XH1uxhlNdN4t4PQyzUU1dgEjZEYLuklDqXk
         hTrJVsCZXX9/YgXqkmw7m+c/CK68W/VjVbdGxtV2bIVTNCaU+NCO+n3n8SlomwaEzE8e
         1JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887316; x=1723492116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hvhgLue4AXt3dLDPL8T2PtC1iyTJfy9ADyuT3yI42s=;
        b=SucerM4jlmHqbpHu9Kveb4hIBC+DONrTJD6p7M6CybjPm6GbwqpuXCywdg+L5bW854
         jw838hhrJtSX38sUh7oI+2Bzs4HlLVrq8o4e8lm/l6TEKBncY5hAhh0m9ukGfJEPMqXR
         CkScIOBwKFLtvWPw1gwaEySHs1xkAfbKdVGdIsqz9gr5nhnS52diJGYmgOTsnWBiE2YB
         hIh7w4/NC3DVzOcaWfaq25IHwA6UJc0m3I0xHTKGZvAjtAqvjcWBesLdFWw5WObctoUW
         QelLD90SNhaKZ7ZFYz+vIrh/weB623g5WwGqBauFScxZS5LFZaDQzIUYy3lZ07t/khCg
         NrGg==
X-Forwarded-Encrypted: i=1; AJvYcCVb/en0XCPTjzt690N56V60HLAEoNl+3gAyCh4uh0rPEBuitWPROfxeyfC8EV8puMQzPPsC0PVPNSFw060XHXJbW+6AFYhHCUc/OA3kFf2N/g==
X-Gm-Message-State: AOJu0Yxm5Km34IldSnRAhTDNnOPV/74uYKZIvxbwyznxlNhrblwzk7NR
	nQQtHxb6x0pqREoRa/zLNr3pUMonaClLCaI0M/gJa0LSGzMPf7surAZzFufl2uIJp0uzRAx7lu8
	Jq5ktzM91lXRsoDGeI9LAstX6lTL3mPOB8kYF
X-Google-Smtp-Source: AGHT+IFn5+kKCxI/nl9AkTKa63lL7L4m2qmQ/sMNbcWxnI5E+FUJZwcXcZyyOHTL0R7C+tAVQk3Ac2006YgtQuZNbuI=
X-Received: by 2002:a92:ab12:0:b0:381:24d7:7cc6 with SMTP id
 e9e14a558f8ab-39b487a3dfamr429695ab.3.1722887315679; Mon, 05 Aug 2024
 12:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719081651.24853-1-eric.lin@sifive.com> <2C7FF61F-2165-47D4-83A4-B0230D50844D@linux.vnet.ibm.com>
 <CAPqJEFrkurD9B9smy908Y-z-f6ckv+ZFJzo6ptwXmxD0ru5=CA@mail.gmail.com>
 <CAPqJEFqCXd1FWCgB0919r+J0XW7KVX_OWZNdocva-bxcscjTrw@mail.gmail.com>
 <BB8E0B26-4E5F-416F-B8D1-AC745F141383@linux.vnet.ibm.com> <CAP-5=fVttTnWV7KpiaxNjyiDXt9Uf5zZEm4v5V4mGXMyRr6nSg@mail.gmail.com>
In-Reply-To: <CAP-5=fVttTnWV7KpiaxNjyiDXt9Uf5zZEm4v5V4mGXMyRr6nSg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 5 Aug 2024 12:48:23 -0700
Message-ID: <CAP-5=fU13UYkXZVOcJP+xiRLhDDRycJn=P1wnJi4KnB9KGdpkQ@mail.gmail.com>
Subject: Re: [PATCH] perf pmus: Fix duplicate events caused segfault
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Eric Lin <eric.lin@sifive.com>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, vincent.chen@sifive.com, 
	greentime.hu@sifive.com, Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 10:02=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Aug 5, 2024 at 7:24=E2=80=AFAM Athira Rajeev
> <atrajeev@linux.vnet.ibm.com> wrote:
> >
> >
> >
> > > On 4 Aug 2024, at 8:36=E2=80=AFPM, Eric Lin <eric.lin@sifive.com> wro=
te:
> > >
> > > Hi,
> > >
> > > On Sun, Jul 21, 2024 at 11:44=E2=80=AFPM Eric Lin <eric.lin@sifive.co=
m> wrote:
> > >>
> > >> Hi Athira,
> > >>
> > >> On Sat, Jul 20, 2024 at 4:35=E2=80=AFPM Athira Rajeev
> > >> <atrajeev@linux.vnet.ibm.com> wrote:
> > >>>
> > >>>
> > >>>
> > >>>> On 19 Jul 2024, at 1:46=E2=80=AFPM, Eric Lin <eric.lin@sifive.com>=
 wrote:
> > >>>>
> > >>>> Currently, if vendor JSON files have two duplicate event names,
> > >>>> the "perf list" command will trigger a segfault.
> > >>>>
> > >>>> In commit e6ff1eed3584 ("perf pmu: Lazily add JSON events"),
> > >>>> pmu_events_table__num_events() gets the number of JSON events
> > >>>> from table_pmu->num_entries, which includes duplicate events
> > >>>> if there are duplicate event names in the JSON files.
> > >>>
> > >>> Hi Eric,
> > >>>
> > >>> Let us consider there are duplicate event names in the JSON files, =
say :
> > >>>
> > >>> metric.json with: EventName as pmu_cache_miss, EventCode as 0x1
> > >>> cache.json with:  EventName as pmu_cache_miss, EventCode as 0x2
> > >>>
> > >>> If we fix the segfault and proceed, still =E2=80=9Cperf list=E2=80=
=9D will list only one entry for pmu_cache_miss with may be 0x1/0x2 as even=
t code ?
> > >>> Can you check the result to confirm what =E2=80=9Cperf list=E2=80=
=9D will list in this case ? If it=E2=80=99s going to have only one entry i=
n perf list, does it mean there are two event codes for pmu_cache_miss and =
it can work with either of the event code ?
> > >>>
> > >>
> > >> Sorry for the late reply.
> > >> Yes, I've checked if there are duplicate pmu_cache_miss events in th=
e
> > >> JSON files, the perf list will have only one entry in perf list.
> > >>
> > >>> If it happens to be a mistake in json file to have duplicate entry =
with different event code (ex: with some broken commit), I am thinking if t=
he better fix is to keep only the valid entry in json file ?
> > >>>
> > >>
> > >> Yes, I agree we should fix the duplicate events in vendor JSON files=
.
> > >>
> > >> According to this code snippet [1], it seems the perf tool originall=
y
> > >> allowed duplicate events to exist and it will skip the duplicate
> > >> events not shown on the perf list.
> > >> However, after this commit e6ff1eed3584 ("perf pmu: Lazily add JSON
> > >> events"),  if there are two duplicate events, it causes a segfault.
> > >>
> > >> Can I ask, do you have any suggestions? Thanks.
> > >>
> > >> [1] https://github.com/torvalds/linux/blob/master/tools/perf/util/pm=
us.c#L491
> > >>
> > >
> > > Kindly ping.
> > >
> > > Can I ask, are there any more comments about this patch? Thanks.
> > >
> > Hi Eric,
> >
> > The functions there says alias and to skip duplicate alias. I am not su=
re if that is for events
>
> Fwiw, I'm trying to get rid of the term alias it should mean event.
> For some reason the code always referred to events as aliases as
> exemplified by:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/perf/util/pmu.c?h=3Dtmp.perf-tools-next#n55
> But it is possible to have an "alias" (different) name for a PMU and
> I'm sure for other things too. So the term alias is ambiguous and
> these things are events, so let's just call them events to be most
> intention revealing.
>
> > Namhyung, Ian, Arnaldo
> > Any comments here ?
>
> I'll take a look.

The problematic events all come from copy pasting ArchStdEvent. It
feels better to have an invariant that events appear once so I sent
out a series to clean this up:
https://lore.kernel.org/linux-perf-users/20240805194424.597244-1-irogers@go=
ogle.com/
If you could test and add a tested-by tag that'd be great!

Thanks,
Ian
