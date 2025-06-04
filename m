Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2631215787
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Jun 2025 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749073257; cv=none; b=FreGcQgBRp2YFLadQIatDDCJORhw0UTObm4+Xi58pbOY4DLZF6lFh9iNdJxG8X70ZfXSxMgTmo/2zGdmf+XJ8jOYh2qyGu0zeKNfJlXBai7Iw2mp4SsQy+iMNVViYiRrx3sz6a61XhXbHem0mz+etFLeKJTA7CMLm/IyV+Psk6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749073257; c=relaxed/simple;
	bh=oqrUYVv3qgQI0Ysh+LEJFjUNJQcc3eTpdolkO9Kn1eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eoEPwhGlcAr/YzX/SsoXPBrVh9JVYX2h94roLtmdZihV+nTrUocjVPgkAq+CpYVjB7exm3BCpIXcu9HqhQ6fuzCiTnusSk0hjlzwI75nujBv0HOvsUIYFj9/b+b5eQqs2MgwyoTd2+Px7oJh7OhCwNrqXdAG0ueFfVt4r8+BBGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S7y83pew; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7y83pew"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3dc8897f64cso378085ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Jun 2025 14:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749073255; x=1749678055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvclTEksi3GgHu8WUWSi3n+8v/bvkKuy2TSmg6tbCrk=;
        b=S7y83pewAFCjM7tOJKYDcPq310xa1OPyYtVVn00/py0Bf6q7W9045VbNrULE2uGovb
         Evng5/o33KvUCtNP9uT7prgAt60wGQRvnfMkccjCnOQ4pgoTvnc5G89+nFbMh5AlrD0x
         vsvKdSjvb1u8n7SWUngYL0UxdEs9b/Hiraa+nChYxJHErWh3NXqK80IgQoHWbmB2yskP
         SUOl55jHOC6cFpbYxdfz3V1nqg2YwRiWA2GKrR25ZyqfhPM0sTjF4tsVuhwrLD2a1yyE
         kt0JOjUvhm8OUvmjrw8mmyXGXFxXLk7/WHDeER1M6htefKfaSjVuE63RvIG/7ZwduMqc
         Dlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749073255; x=1749678055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvclTEksi3GgHu8WUWSi3n+8v/bvkKuy2TSmg6tbCrk=;
        b=AkJbvsIfi3HT1jkfnsJIuZucFD0znQfdqbKV9pL9sZ4DDk9edkFxca0L+iPPBtV/4+
         zXb0IhWGUwYdj6r4lGAspu42UdWE4ahuVH2lPXhpH4slUOFzRgqT1/CKu0is2EXCmBx+
         F79u2OAFw6pY4BeM9Fm+5YApa+l5y3ynZ/KfyGsT2yGNgb3QFxO931MDqxV+1Uew0QGZ
         ireUC9zE79FVDmKAYIleP7KsxLdbx5kMGwb+VIdfdlqNEs5ib1omaANEzJcLXnYCOH73
         sA7aMFnwJqRsbWnkeM6fmIoM6cA3NjrCHtXgLlA3HmmETsiysKlzM9IiBH1+TbCPPCHG
         tFcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpBUcRFvqeNya1DhJuOBbTNOs/ruBXn5Dfp0B0GuN3hoB7OxY6ZmHByScs/8RjwX/xzjgizrEjGyPOPUj7pYbA@vger.kernel.org
X-Gm-Message-State: AOJu0YxoPoqAIdGw2+AmnPvBqNHpl/Ba9J6GLVkIkSdAEcqtny5xMkXk
	Agy9KeZi/NqXaHNj8EMQqxWstjrj93Y6OAhq8IF9PfrSers1NbGohaqqGJtw0yXbc+8CjqBwqdG
	WJUQdv/QQg9WmLSJzPKUCMRaK5XSox77ZTLgLkGmk
X-Gm-Gg: ASbGncuFblmBG8xZhSFf018/MUrAwnvgvUX+xTWDhIadeRMallN1+IwtT4APEqnnmz8
	qHZqSxId1F+DXipOQyO0450einBW/Mb5wq5DTCyTP5TQCHxqjAXz0jJHkBmaqMtj+39c2oAbfvj
	1jzoOgnIhrFD2TGlqte0j4cV50rVrcqu/PEjx25VmoZ1gD3kWpjGVthFUXXxgqjPPEZ+iGPy0=
X-Google-Smtp-Source: AGHT+IH8o3osuLITcUT4FadWV61co/5ng9l8F0HR665TEP743o1yV2v2mQAj2OBOGaXkx2j4rZSL3bfN/41VR4IOXM0=
X-Received: by 2002:a05:6e02:1b0c:b0:3dd:be13:58fe with SMTP id
 e9e14a558f8ab-3ddc74f9eccmr379675ab.1.1749073254195; Wed, 04 Jun 2025
 14:40:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416045117.876775-1-irogers@google.com> <CAP-5=fU3VW1MjHMiaPG+JirLCCunMC6bEWpsJ3h0E7bTDkh9cA@mail.gmail.com>
 <aD54ptuIFHcKPkRQ@google.com> <CAP-5=fWSfFa6ncV6JkKSN4ByQ9HR+2ff4+uzwpMO5n-GaNbwxQ@mail.gmail.com>
 <aD98NFhyTcEU_qim@google.com> <CAP-5=fW0LKk1UyJr=feQd6nbNZC-ZLtUde=qX=-c9nqvDoqu-A@mail.gmail.com>
 <aD-MdTsb40kIXSBE@google.com> <CAP-5=fUrQJR93UBN-rtGPqVHQsHmPcGzEmc9O2PKsQpuy+NY7w@mail.gmail.com>
 <aEC1vca_ghwQvFiY@google.com>
In-Reply-To: <aEC1vca_ghwQvFiY@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Jun 2025 14:40:41 -0700
X-Gm-Features: AX0GCFtN8xde3hGa_WX_QcOZLGEBovd-8qCo4dCtEm_ihvDUrVvom4wUvnjzLiw
Message-ID: <CAP-5=fWKZ8dBS-No3NiwCwcmirnRas+q2qOwVEczXUEG94K=mg@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Prefer sysfs/JSON events also when no PMU is provided
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 2:08=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Tue, Jun 03, 2025 at 05:26:37PM -0700, Ian Rogers wrote:
> > On Tue, Jun 3, 2025 at 4:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > On Tue, Jun 03, 2025 at 04:36:34PM -0700, Ian Rogers wrote:
> > > > On Tue, Jun 3, 2025 at 3:50=E2=80=AFPM Namhyung Kim <namhyung@kerne=
l.org> wrote:
> > > > >
> > > > > On Mon, Jun 02, 2025 at 11:08:34PM -0700, Ian Rogers wrote:
> > > > > > On Mon, Jun 2, 2025 at 9:23=E2=80=AFPM Namhyung Kim <namhyung@k=
ernel.org> wrote:
> > > > > > >
> > > > > > > Hi Ian,
> > > > > > >
> > > > > > > On Tue, May 27, 2025 at 01:50:32PM -0700, Ian Rogers wrote:
> > > > > > > > On Tue, Apr 15, 2025 at 9:51=E2=80=AFPM Ian Rogers <irogers=
@google.com> wrote:
> > > > > > > > >
> > > > > > > > > At the RISC-V summit the topic of avoiding event data bei=
ng in the
> > > > > > > > > RISC-V PMU kernel driver came up. There is a preference f=
or sysfs/JSON
> > > > > > > > > events being the priority when no PMU is provided so that=
 legacy
> > > > > > > > > events maybe supported via json. Originally Mark Rutland =
also
> > > > > > > > > expressed at LPC 2023 that doing this would resolve bugs =
on ARM Apple
> > > > > > > > > M? processors, but James Clark more recently tested this =
and believes
> > > > > > > > > the driver issues there may not have existed or have been=
 resolved. In
> > > > > > > > > any case, it is inconsistent that with a PMU event names =
avoid legacy
> > > > > > > > > encodings, but when wildcarding PMUs (ie without a PMU wi=
th the event
> > > > > > > > > name) the legacy encodings have priority.
> > > > > > > > >
> > > > > > > > > The situation is further inconsistent as legacy events ar=
e case
> > > > > > > > > sensitive, so on Intel that provides a sysfs instructions=
 event, the
> > > > > > > > > instructions event without a PMU and lowercase is legacy =
while with
> > > > > > > > > uppercase letters it matches with sysfs which is case ins=
ensitive. Are
> > > > > > > > > there legacy events with upper case letters? Yes there ar=
e, the cache
> > > > > > > > > ones mix case freely:
> > > > > > > > >
> > > > > > > > > L1-dcache|l1-d|l1d|L1-data|L1-icache|l1-i|l1i|L1-instruct=
ion|LLC|L2|dTLB|d-tlb|Data-TLB|iTLB|i-tlb|Instruction-TLB|branch|branches|b=
pu|btb|bpc|node
> > > > > > > > >
> > > > > > > > > meaning LLC that means L2 (which is wrong) both match as =
part of a
> > > > > > > > > legacy cache name but llc and l2 would only match sysfs/j=
son
> > > > > > > > > events. The whole thing just points at the ridiculous nat=
ure of legacy
> > > > > > > > > events and why we'd want them to be preffered I don't kno=
w. Why should
> > > > > > > > > case of a letter or having a PMU prefix impact the encodi=
ng in the
> > > > > > > > > perf_event_attr?
> > > > > > > > >
> > > > > > > > > The patch doing this work was reverted in a v6.10 release=
 candidate
> > > > > > > > > as, even though the patch was posted for weeks and had be=
en on
> > > > > > > > > linux-next for weeks without issue, Linus was in the habi=
t of using
> > > > > > > > > explicit legacy events with unsupported precision options=
 on his
> > > > > > > > > Neoverse-N1. This machine has SLC PMU events for bus and =
CPU cycles
> > > > > > > > > where ARM decided to call the events bus_cycles and cycle=
s, the latter
> > > > > > > > > being also a legacy event name. ARM haven't renamed the c=
ycles event
> > > > > > > > > to a more consistent cpu_cycles and avoided the problem. =
With these
> > > > > > > > > changes the problematic event will now be skipped, a larg=
e warning
> > > > > > > > > produced, and perf record will continue for the other PMU=
 events. This
> > > > > > > > > solution was proposed by Arnaldo.
> > > > > > > > >
> > > > > > > > > v8: Change removing of failed to open events that are tra=
cking so that
> > > > > > > > >     the tracking moves to the next event. Make software e=
vents able to
> > > > > > > > >     specified with a PMU. Change the perf_api_probe to no=
t load all
> > > > > > > > >     PMUs through scanning, specify a PMU when parsing eve=
nts.
> > > > > > > > >
> > > > > > > > > v7: Expand cover letter, fix a missed core_ok check in th=
e v6
> > > > > > > > >     rebase. Note, as with v6 there is an alternate series=
 that
> > > > > > > > >     prioritizes legacy events but that is silly and I'd p=
refer we
> > > > > > > > >     didn't do it.
> > > > > > > > >
> > > > > > > > > v6: Rebase of v5 (dropping already merged patches):
> > > > > > > > >     https://lore.kernel.org/lkml/20250109222109.567031-1-=
irogers@google.com/
> > > > > > > > >     that unusually had an RFC posted for it:
> > > > > > > > >     https://lore.kernel.org/lkml/Z7Z5kv75BMML2A1q@google.=
com/
> > > > > > > > >     Note, this patch conflicts/contradicts:
> > > > > > > > >     https://lore.kernel.org/lkml/20250312211623.2495798-1=
-irogers@google.com/
> > > > > > > > >     that I posted so that we could either consistently pr=
ioritize
> > > > > > > > >     sysfs/json (these patches) or legacy events (the othe=
r
> > > > > > > > >     patches). That lack of event printing and encoding in=
consistency
> > > > > > > > >     is most prominent in the encoding of events like "ins=
tructions"
> > > > > > > > >     which on hybrid are reported as "cpu_core/instruction=
s/" but
> > > > > > > > >     "instructions" before these patches gets a legacy enc=
oding while
> > > > > > > > >     "cpu_core/instructions/" gets a sysfs/json encoding. =
These patches
> > > > > > > > >     make "instructions" always get a sysfs/json encoding =
while the
> > > > > > > > >     alternate patches make it always get a legacy encodin=
g.
> > > > > > > > >
> > > > > > > > > v5: Follow Namhyung's suggestion and ignore the case wher=
e command
> > > > > > > > >     line dummy events fail to open alongside other events=
 that all
> > > > > > > > >     fail to open. Note, the Tested-by tags are left on th=
e series as
> > > > > > > > >     v4 and v5 were changing an error case that doesn't oc=
cur in
> > > > > > > > >     testing but was manually tested by myself.
> > > > > > > > >
> > > > > > > > > v4: Rework the no events opening change from v3 to make i=
t handle
> > > > > > > > >     multiple dummy events. Sadly an evlist isn't empty if=
 it just
> > > > > > > > >     contains dummy events as the dummy event may be used =
with "perf
> > > > > > > > >     record -e dummy .." as a way to determine whether per=
mission
> > > > > > > > >     issues exist. Other software events like cpu-clock wo=
uld suffice
> > > > > > > > >     for this, but the using dummy genie has left the bott=
le.
> > > > > > > > >
> > > > > > > > >     Another problem is that we appear to have an excessiv=
e number of
> > > > > > > > >     dummy events added, for example, we can likely avoid =
a dummy event
> > > > > > > > >     and add sideband data to the original event. For auxt=
race more
> > > > > > > > >     dummy events may be opened too. Anyway, this has led =
to the
> > > > > > > > >     approach taken in patch 3 where the number of dummy p=
arsed events
> > > > > > > > >     is computed. If the number of removed/failing-to-open=
 non-dummy
> > > > > > > > >     events matches the number of non-dummy events then we=
 want to
> > > > > > > > >     fail, but only if there are no parsed dummy events or=
 if there was
> > > > > > > > >     one then it must have opened. The math here is hard t=
o read, but
> > > > > > > > >     passes my manual testing.
> > > > > > > > >
> > > > > > > > > v3: Make no events opening for perf record a failure as s=
uggested by
> > > > > > > > >     James Clark and Aditya Bodkhe <Aditya.Bodkhe1@ibm.com=
>. Also,
> > > > > > > > >     rebase.
> > > > > > > > >
> > > > > > > > > v2: Rebase and add tested-by tags from James Clark, Leo Y=
an and Atish
> > > > > > > > >     Patra who have tested on RISC-V and ARM CPUs, includi=
ng the
> > > > > > > > >     problem case from before.
> > > > > > > >
> > > > > > > > Ping. Thanks,
> > > > > > > > Ian
> > > > > > > >
> > > > > > > > > Ian Rogers (4):
> > > > > > > > >   perf record: Skip don't fail for events that don't open
> > > > > > > > >   perf parse-events: Reapply "Prefer sysfs/JSON hardware =
events over
> > > > > > > > >     legacy"
> > > > > > > > >   perf parse-events: Allow software events to be terms
> > > > > > > > >   perf perf_api_probe: Avoid scanning all PMUs, try softw=
are PMU first
> > > > > > >
> > > > > > > Sorry for the delay.  But I think we wanted to move to this i=
nstead:
> > > > > > >
> > > > > > > https://lore.kernel.org/linux-perf-users/20250312211623.24957=
98-1-irogers@google.com/
> > > > > >
> > > > > > Hi Namhyung,
> > > > > >
> > > > > > The preference for sysfs/json over legacy was done as a bug fix=
 and
> > > > > > because ARM (Mark Rutland) argued strongly that it was the most
> > > > > > sensible priority. Intel (Kan Liang) approved the change in pri=
ority.
> > > > > > RISC-V have wanted this behavior as it enables the migration of=
 event
> > > > > > mappings from the driver to the tool. As the primary maintainer=
 of the
> > > > > > event parsing and metric code I prefer the priority as legacy e=
vents
> > > > > > are weird, for example they aren't case insensitive in their na=
ming.
> > > > > > For example, on Intel with legacy events as the priority cpu-cy=
cles
> > > > > > would be a legacy event, but cpu-Cyles a sysfs one. On ARM cpu_=
cycles
> > > > > > would be a sysfs event, but cpu-cycles a legacy one. A minor ch=
aracter
> > > > > > difference and very different and imo surprising event encoding=
s.
> > > > >
> > > > > Yeah, but it has worked like that for a long time.
> > > > >
> > > > > >
> > > > > > On your RFC thread Arnaldo and James said that legacy events so=
mehow
> > > > > > enabled a form of drill down. As event parsing is mapping a nam=
e to a
> > > > > > perf_event_attr I completely don't see this as the mapping is o=
paque.
> > > > >
> > > > > Is it opaque?  (I'd say it standard event rather than legacy even=
t.)  I
> > > > > think the mapping for the standard events are clearly defined.
> > > >
> > > > Which standard events? Going through them (abbreviated to avoid rep=
etition):
> > > >  - PERF_COUNT_HW_CPU_CYCLES, ok.
> > > >  - PERF_COUNT_HW_INSTRUCTIONS, well does that include speculatively
> > > > executed instructions or not?
> > > >  - ...
> > > >  - PERF_COUNT_HW_STALLED_CYCLES_FRONTEND, what does this count on a=
n
> > > > in order CPU?
> > > >  - ...
> > >
> > > I mean the mapping from event name to event encoding (PERF_COUNT_HW_.=
..).
> > > I think the internal event mapping is the driver's business.
> > >
> > > >
> > > > The hardware cache events are far worse as things like LLC mean the=
 L2
> > > > cache, however, it is far more typical for this to mean L3 these da=
ys.
> > > > Standard and clearly defined, sorry absolutely not. They are a
> > > > minefield of well intentioned event name components waiting to expl=
ode
> > > > when a vendor inadvertently creates a combination that happens to
> > > > match a combination perf thinks is significant.
> > >
> > > Again, it belongs to the driver.
> >
> > But we know there are broken drivers. That is why this started. The
> > Apple-M core PMU had broken mappings and was reliant on being treated
> > as an uncore PMU so that legacy encodings weren't used. By forcing the
> > use of legacy encodings you'd break new perf tools on v6.6 kernels on
> > Apple-M IIRC.
>
> Didn't they use sysfs events (i.e. '-e PMU/EVENT/' form) always?
>
> >
> > When an event is encoded in json it can have a description. The
> > description can identify what the exact behaviors wrt speculation,
> > what LLC means, etc. are. The legacy event names are a minefield and
> > ambiguous.
>
> Right, sometimes it's not 100% clear and descriptions would be nice.
>
> >
> > Why are they a minefield? We import metrics from sources like the TMA
> > spreadsheet:
> > https://github.com/intel/perfmon/blob/main/TMA_Metrics-full.csv
> > The events named in here are intended for use across a range of tools
> > like vtune and emon. When we import event names in the perf build we
> > assume they are case insensitive and match them by lower-casing them:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/pmu-events/jevents.py?h=3Dperf-tools-next#n326
> > Legacy cache events are made up of components:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/parse-events.l?h=3Dperf-tools-next#n258
> > ```
> > lc_type (L1-dcache|l1-d|l1d|L1-data|L1-icache|l1-i|l1i|L1-instruction|L=
LC|L2|dTLB|d-tlb|Data-TLB|iTLB|i-tlb|Instruction-TLB|branch|branches|bpu|bt=
b|bpc|node)
> > lc_op_result (load|loads|read|store|stores|write|prefetch|prefetches|sp=
eculative-read|speculative-load|refs|Reference|ops|access|misses|miss)
> > ```
>
> Oh, looks like it's too permissive.  Do we have speculative-load in the
> standard cache events?
>
>
> > If legacy events have the priority then an event that accidentally
> > combines these components can switch from using the event json that
> > comes with the metric to using a legacy event that has a different
> > behavior. It may also result in parse errors.
> >
> > We are avoiding stepping on mines by luck currently and the approach
> > of using legacy first is essentially error prone. (It also breaks
> > Apple-M and is the opposite of what RISC-V have requested)
>
> Hmm.. ok.  I feel like cache events should have lower priority at least.
> If it's all about metrics, maybe we can add something like a new parse
> option like parse_evens_option_args.prefer_json to have different
> priority settings and use it for metrics?

There are only 10 legacy non-cache events, but after cycles the
meaning is ambiguous and likely often just not implemented. Saying the
meaning is known because of the driver, I'm not aware of any driver
giving descriptions.

For a flag, the issue is that we prefer json when there is a PMU but
not when it is wildcarded. So when is the flag used or not?

My eventual hope is that we can standardize on sysfs encoding. So we
translate json to sysfs, then compress the files/directories and
access them built into the perf tool this way. Then, as with say
addr2line or objdump, we have a priority list like:
"sysfs(/sys),sysfs(inbuilt),legacy". Then we could allow
"sysfs(/home/ian/myevents),sysfs(/sys),sysfs(inbuilt),legacy" so users
can manually add events and metrics. A priority list for the behavior
today would be something like
"legacy(no-pmu),sysfs(/sys),sysfs(inbuilt),legacy(with-pmu)". If we
have hardware cache events at a low priority may it is
"legacy(no-pmu+type_hardware),sysfs(/sys),sysfs(inbuilt),legacy(with-pmu+ty=
pe_hw_cache)"
what this series is trying to achieve is just
"sysfs(/sys),sysfs(inbuilt),legacy" and the alternate series is
"legacy,sysfs(/sys),sysfs(inbuilt)".

On x86 events are 70% of the binary size but just compressing the json
shows that this could be halved.

Making the lookup use a list and user supplied directories may allow
us to write tests that create a hybrid looking sysfs to test on
non-hybrid, etc.

> >
> > > >
> > > > There was a similar attempt for raw events where you can go r123 fo=
r
> > > > the hex 123 event config, it was missed that rEAD is a valid hex ra=
w
> > > > event as well as a useful event name. The event parsing now has a l=
ot
> > > > of special handling to avoid exploding on this - and yes the priori=
ty
> > > > is that sysfs/json has priority over the raw event encoding.
> > >
> > > Agreed, the raw encoding can be a problem and it makes sense the sysf=
s/
> > > JSON has the priority.
> > >
> > > >
> > > > > >
> > > > > > I strongly believe we need consistency. If `perf stat -e cycles=
 .. `
> > > > > > prints cpu_core/cycles/ as the event name on a hybrid Intel, th=
en
> > > > > > `perf stat -e cpu_core/cycles/ .. ` should have the same
> > > > > > perf_event_attr. Both patch series achieve this but this one do=
es it
> > > > > > with consistency, and from what I see it, the support of 3 vend=
ors.
> > > > >
> > > > > Right, it's not consistent.  Maybe we need a different uniq event=
 name
> > > > > for extended (standard) events.  How about "cycles(cpu_core)"?  I=
 guess
> > > > > we don't want to add a space between the PMU and event names to a=
void
> > > > > potential user impact when they parse the output.
> > > >
> > > > We could and it would very likely break tooling. The intent is that
> > > > cpu-cycles matches cpu_core/cpu-cycles/ and cpu_atom/cpu-cycles/ an=
d
> > > > they are expected to all be the same event. Currently with the PMU
> > > > they are sysfs encoded but without a PMU they are legacy encoded bu=
t
> > > > printed (uniquified) as if they were with a PMU and sysfs encoded.
> > > > This is misleading.
> > >
> > > Hmm.. I don't know what's the correct way to handle this.  Can we
> > > change it not to use extended standard events and to convert to sysfs
> > > events then?
> >
> > Tbh, I think a lot of this is coming down to 1 event, cycles. It is
> > the only unambiguous legacy event. If we make cycles only mean core
> > PMU cycles (ie cpu_core, cpu_atom on hybrid, cpu on non-hybrid) then I
> > think this is matching what you are expecting to happen. I mean we
> > only match cycles as legacy first and everything else is sysfs/json
> > first and legacy last. I think other legacy events cpu-cycles aren't
> > special and don't get legacy first treatment. Having just 1 special
> > legacy only event cycles is a lot less offensive to me than having say
> > branch-prefetch-read also be legacy. We accept cycles is a minefield
> > and special, but it is unique in this.
>
> Well.. I think cycles is an alias to cpu-cycles so they are the same.
> So it's not about special casing 'cycles'.  Any PMU may add conflicting
> event names to sysfs (which is discouraging though).

So it has been standard for Intel to have a cpu-cycles sysfs event:
```
$ cat /sys/bus/event_source/devices/cpu/events/cpu-cycles
event=3D0x3c
```
I'm only aware of ARM using cycles as an event name and they also use
cpu_cycles, I wish they'd pick a lane (preferably not the one that
conflicts with a legacy event name).
I'm not particularly keen on having cycles not be wildcard (other than
for core PMUs) and meaning the legacy encoding. The issue is that the
legacy encoding will break broken PMUs like on older Apple-M linux,
and what to do in the RISC-V case?
I can understand not wanting to change what users see and I think that
may be the only expedient way to do it. I don't think anyone cares
about the cpu-cycles event name and on Intel it seems they'd prefer
the sysfs encoding, hence advertising the event.

Thanks,
Ian

> Thanks,
> Namhyung
>
