Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231E91D69E
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Aug 2024 02:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722999208; cv=none; b=P9n0bmasKYSBZ5aMypO82wq21FCUgEAi7+G2qD0ehsaONVYv4yLhQZ6EmRqZ8Rjj/Kf4DsD5FgtYwbFfkSm0R+/u4U41tDa3NFf+kfKcGs7I3Zc7t/EZmMgIUTsIfrvjlQjtK3VeqXD3E/8bwHJ3gfvn3hLTewfnxoVUvJvE5Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722999208; c=relaxed/simple;
	bh=3tce/TAHH87RLhVCEpiCgwJtXCrgjRZXTWtzU+6Eoes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBWd++3PBG63Ubhsf7do3WGvIGZYL0izvZxXqL8Xzn+VYrspom6jN9vQ2M+f7qxjo7w5Iuxo8Bm/I+9ohWpClnjsxP1QEoQbupBqW59wuFPO+xT+6JW7LF4MkRoLxtW9psxJqzmm+PU50Av03jyLk5aybCDQ2yX3z8K+Ib0blVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=FIAx7W1q; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FIAx7W1q"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f15790b472so16142421fa.0
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Aug 2024 19:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1722999203; x=1723604003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJzQZHB7Ukr9NmsGMen5odaDomAggP13XhrF2GZRDII=;
        b=FIAx7W1qnafgXPFHcMktZpD1LC5SvtnbzyEzNSAnMybia0BQ03XnBAXcZ5ct1ZHqFj
         BNnLxhIOhxMBleRQQmtOy3PUNKOXtPaYq3F3FJmm+OA+FEiHE7ozleUiI0I9MsY76dml
         h3LhoB3jkeWcJg9bpETPBnybc1qNwHEzYv2O/7vzM4DxJFNjLELtT5927k6DR1H1syuw
         tANvmMDe2F6AjxM9RhGPo5NAvRmtQK8SThtUDmi/CSujHkkavlf9HDyQwqH6o874LgVe
         xxDoq5MUIcA91GpmLWx1PfOd0gp2RZPXUCd7GLva8qCjjoGxgNhiI4SkF9czaYofurb1
         SLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722999203; x=1723604003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJzQZHB7Ukr9NmsGMen5odaDomAggP13XhrF2GZRDII=;
        b=UcyKDAaC2Igv5bH/QYxOGd4NfvRaDleMO/B9ekMtW1TyIWHHcOK/k+k3T08JJHFaGG
         8oNDS2iiI5SQATIrAWryfNDjNDK7uVZBu8lPgc681cWYjDFzm/gcYBUtF+urf517CJst
         4U6obmPdzydCZjIy07009uWnNCBeuBEXKYfmKLmm9VrM/+Okv7PMxCPPu4RfmAe9U/1F
         pdCjzp1j6/CgHSMVi0WLc82Da2Tfe2MFrXjO8G3/2BbqAvOWQreY4YcRlIMLCUIojFbR
         UEJrLmOglSELFqdtvFZ+fqLs4VEbXw8DJVv+F2by8A9w103oc5wjGwXhuA8r0tLmAEi9
         FrnA==
X-Forwarded-Encrypted: i=1; AJvYcCXWhBb3pGwKkaZ7wsJwNGpZ2MutI70y3umNs+LWcZubyKukuUvrdS2DJF/ZCzHS39qojav38Kb2wIDucsqaCusL0XGSjwz+R8zh2uvl9HtsdQ==
X-Gm-Message-State: AOJu0Yx8WwtgnH5kdR0Nj27XnVVaS+AhIX3o7mj5RohWOMP2xTV85/bY
	A5B75zq9/l+qDTK1BwaYhzDLjX5wddsYgOPgy57EzSUgge3/hC8Y+t75grFH7Nch4BsPxcalpdp
	6PCiFZGW8RlFO81sO0Rh/cp2E2OhUBN7+n8Mw0w==
X-Google-Smtp-Source: AGHT+IGxIqoR4c3Knf49Q6GqVbCDZKp3581QtHwiJBb2tEjnZCV4XUvmdK36VXrKp0Hd++qMYnNsJA/WDvAUq9Fin7A=
X-Received: by 2002:a2e:2416:0:b0:2f1:59ed:87b8 with SMTP id
 38308e7fff4ca-2f15aa84f4dmr113290341fa.3.1722999202908; Tue, 06 Aug 2024
 19:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719081651.24853-1-eric.lin@sifive.com> <2C7FF61F-2165-47D4-83A4-B0230D50844D@linux.vnet.ibm.com>
 <CAPqJEFrkurD9B9smy908Y-z-f6ckv+ZFJzo6ptwXmxD0ru5=CA@mail.gmail.com>
 <CAPqJEFqCXd1FWCgB0919r+J0XW7KVX_OWZNdocva-bxcscjTrw@mail.gmail.com>
 <BB8E0B26-4E5F-416F-B8D1-AC745F141383@linux.vnet.ibm.com> <ZrDzBrrBPBkSKLRC@x1>
 <CAPqJEFraOmS72dQQK2ou9EoxbCKZ8m_+DhQQfPmCy6wfxfQWzQ@mail.gmail.com>
 <CAP-5=fXSiqQT+-mztdrV=Y6p+iPhZnmY9uqL08KrEe3bSybJxw@mail.gmail.com> <CAPqJEFr78B_74PCsxxHdDZtdrJVUL6j6u4vauCaoTaR7Rr=Rrw@mail.gmail.com>
In-Reply-To: <CAPqJEFr78B_74PCsxxHdDZtdrJVUL6j6u4vauCaoTaR7Rr=Rrw@mail.gmail.com>
From: Eric Lin <eric.lin@sifive.com>
Date: Wed, 7 Aug 2024 10:53:11 +0800
Message-ID: <CAPqJEFrpb6T1p52BujbansA4KOFxKmeOT+e0Eg4rSmN3UQVxgg@mail.gmail.com>
Subject: Re: [PATCH] perf pmus: Fix duplicate events caused segfault
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, vincent.chen@sifive.com, 
	greentime.hu@sifive.com, Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 5:56=E2=80=AFPM Eric Lin <eric.lin@sifive.com> wrote=
:
>
>
> Hi Ian,
>
> On Tue, Aug 6, 2024 at 12:00=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Mon, Aug 5, 2024 at 8:29=E2=80=AFPM Eric Lin <eric.lin@sifive.com> w=
rote:
> > >
> > >
> > > Hi Arnaldo,
> > >
> > > On Mon, Aug 5, 2024 at 11:43=E2=80=AFPM Arnaldo Carvalho de Melo <acm=
e@kernel.org> wrote:
> > > >
> > > > On Mon, Aug 05, 2024 at 07:54:33PM +0530, Athira Rajeev wrote:
> > > > >
> > > > >
> > > > > > On 4 Aug 2024, at 8:36=E2=80=AFPM, Eric Lin <eric.lin@sifive.co=
m> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Sun, Jul 21, 2024 at 11:44=E2=80=AFPM Eric Lin <eric.lin@sif=
ive.com> wrote:
> > > > > >>
> > > > > >> Hi Athira,
> > > > > >>
> > > > > >> On Sat, Jul 20, 2024 at 4:35=E2=80=AFPM Athira Rajeev
> > > > > >> <atrajeev@linux.vnet.ibm.com> wrote:
> > > > > >>>
> > > > > >>>
> > > > > >>>
> > > > > >>>> On 19 Jul 2024, at 1:46=E2=80=AFPM, Eric Lin <eric.lin@sifiv=
e.com> wrote:
> > > > > >>>>
> > > > > >>>> Currently, if vendor JSON files have two duplicate event nam=
es,
> > > > > >>>> the "perf list" command will trigger a segfault.
> > > > > >>>>
> > > > > >>>> In commit e6ff1eed3584 ("perf pmu: Lazily add JSON events"),
> > > > > >>>> pmu_events_table__num_events() gets the number of JSON event=
s
> > > > > >>>> from table_pmu->num_entries, which includes duplicate events
> > > > > >>>> if there are duplicate event names in the JSON files.
> > > > > >>>
> > > > > >>> Hi Eric,
> > > > > >>>
> > > > > >>> Let us consider there are duplicate event names in the JSON f=
iles, say :
> > > > > >>>
> > > > > >>> metric.json with: EventName as pmu_cache_miss, EventCode as 0=
x1
> > > > > >>> cache.json with:  EventName as pmu_cache_miss, EventCode as 0=
x2
> > > > > >>>
> > > > > >>> If we fix the segfault and proceed, still =E2=80=9Cperf list=
=E2=80=9D will list only one entry for pmu_cache_miss with may be 0x1/0x2 a=
s event code ?
> > > > > >>> Can you check the result to confirm what =E2=80=9Cperf list=
=E2=80=9D will list in this case ? If it=E2=80=99s going to have only one e=
ntry in perf list, does it mean there are two event codes for pmu_cache_mis=
s and it can work with either of the event code ?
> > > > > >>>
> > > > > >>
> > > > > >> Sorry for the late reply.
> > > > > >> Yes, I've checked if there are duplicate pmu_cache_miss events=
 in the
> > > > > >> JSON files, the perf list will have only one entry in perf lis=
t.
> > > > > >>
> > > > > >>> If it happens to be a mistake in json file to have duplicate =
entry with different event code (ex: with some broken commit), I am thinkin=
g if the better fix is to keep only the valid entry in json file ?
> > > > > >>>
> > > > > >>
> > > > > >> Yes, I agree we should fix the duplicate events in vendor JSON=
 files.
> > > > > >>
> > > > > >> According to this code snippet [1], it seems the perf tool ori=
ginally
> > > > > >> allowed duplicate events to exist and it will skip the duplica=
te
> > > > > >> events not shown on the perf list.
> > > > > >> However, after this commit e6ff1eed3584 ("perf pmu: Lazily add=
 JSON
> > > > > >> events"),  if there are two duplicate events, it causes a segf=
ault.
> > > > > >>
> > > > > >> Can I ask, do you have any suggestions? Thanks.
> > > > > >>
> > > > > >> [1] https://github.com/torvalds/linux/blob/master/tools/perf/u=
til/pmus.c#L491
> > > > > >>
> > > > > >
> > > > > > Kindly ping.
> > > > > >
> > > > > > Can I ask, are there any more comments about this patch? Thanks=
.
> > > > > >
> > > > > Hi Eric,
> > > > >
> > > > > The functions there says alias and to skip duplicate alias. I am =
not sure if that is for events
> > > > >
> > > > > Namhyung, Ian, Arnaldo
> > > > > Any comments here ?
> > > >
> > > > So I was trying to reproduce the problem here before looking at the
> > > > patch, tried a simple:
> > > >
> > > > =E2=AC=A2[acme@toolbox perf-tools-next]$ git diff
> > > > diff --git a/tools/perf/pmu-events/arch/x86/rocketlake/cache.json b=
/tools/perf/pmu-events/arch/x86/rocketlake/cache.json
> > > > index 2e93b7835b41442b..167a41b0309b7cfc 100644
> > > > --- a/tools/perf/pmu-events/arch/x86/rocketlake/cache.json
> > > > +++ b/tools/perf/pmu-events/arch/x86/rocketlake/cache.json
> > > > @@ -1,4 +1,13 @@
> > > >  [
> > > > +    {
> > > > +        "BriefDescription": "Counts the number of cache lines repl=
aced in L1 data cache.",
> > > > +        "Counter": "0,1,2,3",
> > > > +        "EventCode": "0x51",
> > > > +        "EventName": "L1D.REPLACEMENT",
> > > > +        "PublicDescription": "Counts L1D data line replacements in=
cluding opportunistic replacements, and replacements that require stall-for=
-replace or block-for-replace.",
> > > > +        "SampleAfterValue": "100003",
> > > > +        "UMask": "0x1"
> > > > +    },
> > > >      {
> > > >          "BriefDescription": "Counts the number of cache lines repl=
aced in L1 data cache.",
> > > >          "Counter": "0,1,2,3",
> > > > =E2=AC=A2[acme@toolbox perf-tools-next]$ grep L1D.REPLACEMENT tools=
/perf/pmu-events/arch/x86/rocketlake/cache.json
> > > >         "EventName": "L1D.REPLACEMENT",
> > > >         "EventName": "L1D.REPLACEMENT",
> > > > =E2=AC=A2[acme@toolbox perf-tools-next]$
> > > >
> > > > I.e. duplicated that whole event definition:
> > > >
> > > > Did a make clean and a rebuild and:
> > > >
> > > > root@x1:/home/acme/git/pahole# perf list l1d.replacement
> > > >
> > > > List of pre-defined events (to be used in -e or -M):
> > > >
> > > >
> > > > cache:
> > > >   l1d.replacement
> > > >        [Counts the number of cache lines replaced in L1 data cache.=
 Unit: cpu_core]
> > > > root@x1:/home/acme/git/pahole# perf list > /dev/null
> > > > root@x1:/home/acme/git/pahole#
> > > >
> > > > No crash, can you provide instructions on how to reproduce the prob=
lem?
> > > >
> > > > I would like to use the experience to add a 'perf test' to show thi=
s
> > > > failing and then after the patch it passing that new test.
> > > >
> > >
> > > The segfault occurs when the vendor JSON files contain two events wit=
h duplicate names.
> > >
> > > I tried adding two duplicate events "L1D.REPLACEMENT" and "L1D_PEND_M=
ISS.FB_FULL"  and the issue can be reproduced on my laptop on the x86 platf=
orm.
> > >
> > > ericl@EricL-ThinkPadX1-TW 11:11 ~/linux_src/linux/tools/perf (master)
> > > git diff
> > > diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/cache.json b/to=
ols/perf/pmu-events/arch/x86/tigerlake/cache.json
> > > index f4144a1110be..71062a82699d 100644
> > > --- a/tools/perf/pmu-events/arch/x86/tigerlake/cache.json
> > > +++ b/tools/perf/pmu-events/arch/x86/tigerlake/cache.json
> > > @@ -8,6 +8,24 @@
> > >          "SampleAfterValue": "100003",
> > >          "UMask": "0x1"
> > >      },
> > > +    {
> > > +        "BriefDescription": "Counts the number of cache lines replac=
ed in L1 data cache.",
> > > +        "Counter": "0,1,2,3",
> > > +        "EventCode": "0x51",
> > > +        "EventName": "L1D.REPLACEMENT",
> > > +        "PublicDescription": "Counts L1D data line replacements incl=
uding opportunistic replacements, and replacements that require stall-for-r=
eplace or block-for-replace.",
> > > +        "SampleAfterValue": "100003",
> > > +        "UMask": "0x1"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Number of cycles a demand request has w=
aited due to L1D Fill Buffer (FB) unavailability.",
> > > +        "Counter": "0,1,2,3",
> > > +        "EventCode": "0x48",
> > > +        "EventName": "L1D_PEND_MISS.FB_FULL",
> > > +        "PublicDescription": "Counts number of cycles a demand reque=
st has waited due to L1D Fill Buffer (FB) unavailability. Demand requests i=
nclude cacheable/uncacheable demand load, store, lock or SW prefetch access=
es.",
> > > +        "SampleAfterValue": "1000003",
> > > +        "UMask": "0x2"
> > > +    },
> > >      {
> > >          "BriefDescription": "Number of cycles a demand request has w=
aited due to L1D Fill Buffer (FB) unavailability.",
> > >          "Counter": "0,1,2,3",
> > >
> > > ericl@EricL-ThinkPadX1-TW 11:11 ~/linux_src/linux/tools/perf (master)
> > > $ ./perf list
> > > Segmentation fault (core dumped)
> >
> > Hi Eric,
> >
> > the series we were asking you to test was:
> > https://lore.kernel.org/linux-perf-users/20240805194424.597244-1-iroger=
s@google.com/
> > It can be convenient to use the b4 tool to grab a set of patches. It
> > is also in the perf-tools-next tree:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/
> > in the tmp.perf-tools-next branch, so you could clone that.
> >
> > Having duplicate events doesn't make sense. When a sysfs event and
> > json event exist with the same name, the json events values override
> > those of the sysfs event:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/pmu.c?h=3Dtmp.perf-tools-next#n599
> > Two json events doesn't have a clear meaning and which would be found
> > would be dependent on a binary search. To avoid the problem the linked
> > to series forbids duplicate events in the json and adds a build test
> > building all architectures json. As this would break due to duplicate
> > events, as your patch shows, there are json fixes for RISC-V and ARM.
> >
>
> I tested the series and added duplicate events on the JSON files
>
> diff --git a/tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json b/to=
ols/perf/pmu-events/arch/riscv/sifive/u74/memory.json
> index be1a46312ac3..48f5aec4875a 100644
> --- a/tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
> +++ b/tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
> @@ -1,4 +1,9 @@
>  [
> +  {
> +    "EventName": "ICACHE_RETIRED",
> +    "EventCode": "0x0000102",
> +    "BriefDescription": "Instruction cache miss"
> +  },
>    {
>      "EventName": "ICACHE_RETIRED",
>      "EventCode": "0x0000102",
> @@ -29,4 +34,4 @@
>      "EventCode": "0x0002002",
>      "BriefDescription": "UTLB miss"
>    }
>
> When building the perf tool, it will show the build error as follows:
>
>
>   CC      tests/pmu-events.o
>   CC      util/cacheline.o
> Traceback (most recent call last):
>   File "pmu-events/jevents.py", line 1313, in <module>
>     main()
>   File "pmu-events/jevents.py", line 1304, in main
>     ftw(arch_path, [], process_one_file)
>   File "pmu-events/jevents.py", line 1245, in ftw
>     ftw(item.path, parents + [item.name], action)
>   File "pmu-events/jevents.py", line 1243, in ftw
>     action(parents, item)
>   File "pmu-events/jevents.py", line 646, in process_one_file
>     print_pending_events()
>   File "pmu-events/jevents.py", line 510, in print_pending_events
>     assert event.name !=3D last_name, f"Duplicate event: {last_pmu}/{last=
_name}/ in {_pending_events_tblname}"
> AssertionError: Duplicate event: default_core/icache_retired/ in pmu_even=
ts__sifive_u74
>   LD      arch/riscv/util/perf-util-in.o
> pmu-events/Build:35: recipe for target 'pmu-events/pmu-events.c' failed
> make[3]: *** [pmu-events/pmu-events.c] Error 1
> make[3]: *** Deleting file 'pmu-events/pmu-events.c'
> Makefile.perf:763: recipe for target 'pmu-events/pmu-events-in.o' failed
> make[2]: *** [pmu-events/pmu-events-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   CC      bench/futex-lock-pi.o
>
> I think the patch series can detect if the vendor JSON file has duplicate=
 events when building the perf tool. Thanks.
>
Hi Ian, Arnaldo

I tested the duplicate event with tmp.perf-tools-next branch from
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/

Thanks.

Tested-by: Eric Lin <eric.lin@sifive.com>

Best regards,
Eric Lin

>
> Best regards,
> Eric Lin
>
> > Thanks,
> > Ian
