Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAB114D283
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Jun 2025 06:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748930929; cv=none; b=o/mhM1XmDHBS8gYqb+ejHpbsklksHfqxJ1mCVi850+Qfrg/le9/Amz9mKIor0AdLTWSKKRUmHSgW+Fq4GmEfoKXKaznAqhvcQXxqFWhH9y2TZMMwPIJRsL7y7+trOIGRTfuWyXFyiMcIM4C9kS1LiEf4sLMFpq6my7mY4wzpnrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748930929; c=relaxed/simple;
	bh=I+aXo4/DXd11acWkmn2NvLDwHBg1tBRnJlNrBxCoJyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4GgChPtoA7OaHZgsF1JXN5X0IxiMcNz1zn2Ue9Q1RE9eYuG63bBbR8g2S0Ncmcq3Tz4tMabiVmdC79nQSWK8ybC49E9nnr8XTpAyJtqv+kJSfw60rWYu61+u9xF6j1NqVAnBP57dj6YzFkJq59OdxbCsXQBEdRmtw9MXAWu4P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pvp6LdS6; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pvp6LdS6"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3dc8897f64cso143955ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Jun 2025 23:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748930926; x=1749535726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIZAwtaQwL7pHq02Z22RUsf6XXS9GeViRSX3mpAZ1NA=;
        b=Pvp6LdS67EmrZYfJwZkbmf5HgLmLCgnpXXfu/naiL4p4Ko7MrgoBk3qHpDT0+mMZSo
         ClFvEtAivtwnG/k2rHD+cGv9KJ+pepLVXfi0zbrMxH6rZasC1eS9agY0/WlbKPITw3vB
         sLajdyJwi2k7utplDoh9PBWLO49NGk1Yz8gTvYtrV9KfGvzMXKGIUD+3vNUsMLCaBd5h
         ZmoD4rUW0cScUDJNjs8WGyg/wbNU94ZhAK+C/zZOq0uwkomke7rNchodMPOl/14wqNxv
         p7YpG5Tt4wFM+cEeLsVOh28RPinHTU1dfKN+rFzjD1VR7zpfKrqwEtCb9+qisLpP/LzF
         RPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748930926; x=1749535726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIZAwtaQwL7pHq02Z22RUsf6XXS9GeViRSX3mpAZ1NA=;
        b=Tu7xloct49/UznJReCt08LypSVYgIr7XvTAfmCwGdnv0Sj4EqX4uTQpZNwPyM9G3Ir
         06Ne5IERzjtcm3MM6qYahI0nDKuy47Eni4ZxA55EWeqXA8en4aukoiYA+UkECK/z8y3z
         08LksMoREhuiwQXeMMxKbLbnuwlYvledDzH734TQuuw0V2WtlGV4FhBVA3Hx0hJn0A4N
         VLPsHpAtvmOv9n1GewKufGNBSK/qAjwYPKpKPrKjOTIOOzpfNBi9r5f3OBnDH05IwUGG
         xOAECmgzSE+U1XduHV2diViWhZHfBLfwRfz+fnhwVO9wQDKyIwyhpYJERYMIZGi5SPx0
         KpkA==
X-Forwarded-Encrypted: i=1; AJvYcCVPLfNTBhGsBCsHF2D43vYHHe+nMU+8eTcZHcQ5dNOoszGWBc9mjOk0jabVhEaqEG44EroPmoEfFNujy5XFKpP/@vger.kernel.org
X-Gm-Message-State: AOJu0Yzchn3v9OHcPSkXMNON7cGXuAVHnNfKfwbHOiDfmErgvLi3VRnH
	K3PG4clIZ669s8xFjGVtmTNfJUxDgqwfhBJ6yIVXD7MhHY5Lqgk9wFdrrzQYFDRupowq8IOYZko
	/fQXyNYVsWxFI9koT+M/HjQrkFVvTWvwyUtnCR4ki
X-Gm-Gg: ASbGncuuAyhW5iWuTELvdivt3v7n9g7deD198wuNGtwB/QLrGojPdJMuWLi2hj8JRa9
	JGJAlQlqXj+J4FZXy4aQR7WhwPVjAdwyl7naHnzm02Xee+Xh80KnnG01yVYLLshnH9BufkGaTxc
	oESoT2SQM+HekTBvBn8U8D6R0GHpnoQ0FrvXEdoX/zKsME
X-Google-Smtp-Source: AGHT+IG5Esdou/uheWLfkimtL/ivoJTMeS8QzIs7DFR4pKl909W9ZOIaB2D6el9kWGSDpY3JJzql6qNXyEoB7U2Av3w=
X-Received: by 2002:a05:6e02:1564:b0:3dd:a452:d0d7 with SMTP id
 e9e14a558f8ab-3ddb7817f43mr1649285ab.5.1748930926045; Mon, 02 Jun 2025
 23:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416045117.876775-1-irogers@google.com> <CAP-5=fU3VW1MjHMiaPG+JirLCCunMC6bEWpsJ3h0E7bTDkh9cA@mail.gmail.com>
 <aD54ptuIFHcKPkRQ@google.com>
In-Reply-To: <aD54ptuIFHcKPkRQ@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 2 Jun 2025 23:08:34 -0700
X-Gm-Features: AX0GCFuk1YXMm7ctf1TcSSrgam4pZBBwbOpB4C4z_x4kmS2s_dv_znGBzzVKuXs
Message-ID: <CAP-5=fWSfFa6ncV6JkKSN4ByQ9HR+2ff4+uzwpMO5n-GaNbwxQ@mail.gmail.com>
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

On Mon, Jun 2, 2025 at 9:23=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> On Tue, May 27, 2025 at 01:50:32PM -0700, Ian Rogers wrote:
> > On Tue, Apr 15, 2025 at 9:51=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > At the RISC-V summit the topic of avoiding event data being in the
> > > RISC-V PMU kernel driver came up. There is a preference for sysfs/JSO=
N
> > > events being the priority when no PMU is provided so that legacy
> > > events maybe supported via json. Originally Mark Rutland also
> > > expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
> > > M? processors, but James Clark more recently tested this and believes
> > > the driver issues there may not have existed or have been resolved. I=
n
> > > any case, it is inconsistent that with a PMU event names avoid legacy
> > > encodings, but when wildcarding PMUs (ie without a PMU with the event
> > > name) the legacy encodings have priority.
> > >
> > > The situation is further inconsistent as legacy events are case
> > > sensitive, so on Intel that provides a sysfs instructions event, the
> > > instructions event without a PMU and lowercase is legacy while with
> > > uppercase letters it matches with sysfs which is case insensitive. Ar=
e
> > > there legacy events with upper case letters? Yes there are, the cache
> > > ones mix case freely:
> > >
> > > L1-dcache|l1-d|l1d|L1-data|L1-icache|l1-i|l1i|L1-instruction|LLC|L2|d=
TLB|d-tlb|Data-TLB|iTLB|i-tlb|Instruction-TLB|branch|branches|bpu|btb|bpc|n=
ode
> > >
> > > meaning LLC that means L2 (which is wrong) both match as part of a
> > > legacy cache name but llc and l2 would only match sysfs/json
> > > events. The whole thing just points at the ridiculous nature of legac=
y
> > > events and why we'd want them to be preffered I don't know. Why shoul=
d
> > > case of a letter or having a PMU prefix impact the encoding in the
> > > perf_event_attr?
> > >
> > > The patch doing this work was reverted in a v6.10 release candidate
> > > as, even though the patch was posted for weeks and had been on
> > > linux-next for weeks without issue, Linus was in the habit of using
> > > explicit legacy events with unsupported precision options on his
> > > Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
> > > where ARM decided to call the events bus_cycles and cycles, the latte=
r
> > > being also a legacy event name. ARM haven't renamed the cycles event
> > > to a more consistent cpu_cycles and avoided the problem. With these
> > > changes the problematic event will now be skipped, a large warning
> > > produced, and perf record will continue for the other PMU events. Thi=
s
> > > solution was proposed by Arnaldo.
> > >
> > > v8: Change removing of failed to open events that are tracking so tha=
t
> > >     the tracking moves to the next event. Make software events able t=
o
> > >     specified with a PMU. Change the perf_api_probe to not load all
> > >     PMUs through scanning, specify a PMU when parsing events.
> > >
> > > v7: Expand cover letter, fix a missed core_ok check in the v6
> > >     rebase. Note, as with v6 there is an alternate series that
> > >     prioritizes legacy events but that is silly and I'd prefer we
> > >     didn't do it.
> > >
> > > v6: Rebase of v5 (dropping already merged patches):
> > >     https://lore.kernel.org/lkml/20250109222109.567031-1-irogers@goog=
le.com/
> > >     that unusually had an RFC posted for it:
> > >     https://lore.kernel.org/lkml/Z7Z5kv75BMML2A1q@google.com/
> > >     Note, this patch conflicts/contradicts:
> > >     https://lore.kernel.org/lkml/20250312211623.2495798-1-irogers@goo=
gle.com/
> > >     that I posted so that we could either consistently prioritize
> > >     sysfs/json (these patches) or legacy events (the other
> > >     patches). That lack of event printing and encoding inconsistency
> > >     is most prominent in the encoding of events like "instructions"
> > >     which on hybrid are reported as "cpu_core/instructions/" but
> > >     "instructions" before these patches gets a legacy encoding while
> > >     "cpu_core/instructions/" gets a sysfs/json encoding. These patche=
s
> > >     make "instructions" always get a sysfs/json encoding while the
> > >     alternate patches make it always get a legacy encoding.
> > >
> > > v5: Follow Namhyung's suggestion and ignore the case where command
> > >     line dummy events fail to open alongside other events that all
> > >     fail to open. Note, the Tested-by tags are left on the series as
> > >     v4 and v5 were changing an error case that doesn't occur in
> > >     testing but was manually tested by myself.
> > >
> > > v4: Rework the no events opening change from v3 to make it handle
> > >     multiple dummy events. Sadly an evlist isn't empty if it just
> > >     contains dummy events as the dummy event may be used with "perf
> > >     record -e dummy .." as a way to determine whether permission
> > >     issues exist. Other software events like cpu-clock would suffice
> > >     for this, but the using dummy genie has left the bottle.
> > >
> > >     Another problem is that we appear to have an excessive number of
> > >     dummy events added, for example, we can likely avoid a dummy even=
t
> > >     and add sideband data to the original event. For auxtrace more
> > >     dummy events may be opened too. Anyway, this has led to the
> > >     approach taken in patch 3 where the number of dummy parsed events
> > >     is computed. If the number of removed/failing-to-open non-dummy
> > >     events matches the number of non-dummy events then we want to
> > >     fail, but only if there are no parsed dummy events or if there wa=
s
> > >     one then it must have opened. The math here is hard to read, but
> > >     passes my manual testing.
> > >
> > > v3: Make no events opening for perf record a failure as suggested by
> > >     James Clark and Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>. Also,
> > >     rebase.
> > >
> > > v2: Rebase and add tested-by tags from James Clark, Leo Yan and Atish
> > >     Patra who have tested on RISC-V and ARM CPUs, including the
> > >     problem case from before.
> >
> > Ping. Thanks,
> > Ian
> >
> > > Ian Rogers (4):
> > >   perf record: Skip don't fail for events that don't open
> > >   perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
> > >     legacy"
> > >   perf parse-events: Allow software events to be terms
> > >   perf perf_api_probe: Avoid scanning all PMUs, try software PMU firs=
t
>
> Sorry for the delay.  But I think we wanted to move to this instead:
>
> https://lore.kernel.org/linux-perf-users/20250312211623.2495798-1-irogers=
@google.com/

Hi Namhyung,

The preference for sysfs/json over legacy was done as a bug fix and
because ARM (Mark Rutland) argued strongly that it was the most
sensible priority. Intel (Kan Liang) approved the change in priority.
RISC-V have wanted this behavior as it enables the migration of event
mappings from the driver to the tool. As the primary maintainer of the
event parsing and metric code I prefer the priority as legacy events
are weird, for example they aren't case insensitive in their naming.
For example, on Intel with legacy events as the priority cpu-cycles
would be a legacy event, but cpu-Cyles a sysfs one. On ARM cpu_cycles
would be a sysfs event, but cpu-cycles a legacy one. A minor character
difference and very different and imo surprising event encodings.

On your RFC thread Arnaldo and James said that legacy events somehow
enabled a form of drill down. As event parsing is mapping a name to a
perf_event_attr I completely don't see this as the mapping is opaque.

I strongly believe we need consistency. If `perf stat -e cycles .. `
prints cpu_core/cycles/ as the event name on a hybrid Intel, then
`perf stat -e cpu_core/cycles/ .. ` should have the same
perf_event_attr. Both patch series achieve this but this one does it
with consistency, and from what I see it, the support of 3 vendors.

Thanks,
Ian

> Thanks,
> Namhyung
>
> > >
> > >  tools/perf/builtin-record.c      | 63 +++++++++++++++++++---
> > >  tools/perf/util/parse-events.c   | 47 +++++++++++++----
> > >  tools/perf/util/parse-events.h   |  3 +-
> > >  tools/perf/util/parse-events.l   | 90 ++++++++++++++++++------------=
--
> > >  tools/perf/util/parse-events.y   | 85 ++++++++++++++++++++++--------
> > >  tools/perf/util/perf_api_probe.c | 27 +++++++---
> > >  tools/perf/util/pmu.c            |  9 ++--
> > >  7 files changed, 235 insertions(+), 89 deletions(-)
> > >
> > > --
> > > 2.49.0.777.g153de2bbd5-goog
> > >
