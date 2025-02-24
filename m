Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B559A469D
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Feb 2025 21:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432887; cv=none; b=aEnVhii97uX8oCemILwodEBclsGG4ZxSwy1vzYyR9wLzW8C/yGtBKLCaiywFUvRqT3rFKmlHhDLcU1bYwKHOkp4cV4EGNbPEr8Vn8zPX4KtBACFn61J6BdKNcBFofWG0xMeOa26yX/4IpHF4E0PBRwOlc2XUbLr98E6fGzHXxKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432887; c=relaxed/simple;
	bh=USLyXsURBeXakktGgHLRyNMX7pul3PIBls8bVbd7wDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBexWtfHCYeCgo/7vnwac7ttsuKY8AJYDG+UnCLLEGadpA6ZgUyjayli8dAs/Ki21yvIJvEtHfqaKyQSCRtphmjQ82EkUqOORUv+3layy1eUbsZwZAPr7PNB8+pwjTir3rE+f5nIK/RMVeNPr1klOq55cn9wfYhgFqPwwo+kQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnKtCZif; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnKtCZif"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220e0575f5bso50405ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Feb 2025 13:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740432885; x=1741037685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9su8PHKEPkF3T5ao4+5SnLvoyBnWsJwgTlzhqLlsy7I=;
        b=wnKtCZif/BxuTgiM87iaHkTheK3IjcFI37YRD6QB1ltBhhTdGxhx6dFjKBoRgPrxja
         4KJYmoQ4q2RnRps3Yjl1mOXahaaqL0HccCb9JLaj+4RywXwSwPuto+7V7qMYbRr2KDNG
         PRYPgXVAuEPN6A87lOBPk43/xBUzSMrnInvJOJmIBc2B+PCROTOOFAHKhMIsZk9b+Vf/
         SyAxnJCLEGDvIyaPTpPtJDv/61zqixO8/9/AEchfyhEBrgx5KkxOfSVQ9tgCLslZWSP7
         tI/Ws5c1O7maUnvmL5HRdsINlPDmHI/480mqqcNC/Zadmy77kqDvfj2o7Y0WFd6mhqO5
         qCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740432885; x=1741037685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9su8PHKEPkF3T5ao4+5SnLvoyBnWsJwgTlzhqLlsy7I=;
        b=KrS7jF6T7WsEf2Bl9KNwLCUwPPVeo+aPIImGH07mx9sO/kiQLOlIh7niHojTvWxsiS
         Z9cBbQYn/PUIM2tIwLWR9/4VpnQ+xiTBxVhK6HsAMWwKeynOY+XINFjsY7d6eLoTyZPC
         vpmLpr9GKzSbdTJeaTRcXtH/fHvMemztKMFEWfyuXIVkWCvthuef+FfPDdk2DtVxhaqB
         MSs/o0VmrG52soUchvN+kElByCofVMfr+HNhFw7kDostDCx6HO3YlGg1U9JcrC4yqcoK
         Wv9sTEWu1NxuQBD+aRn6TNVVAIW1HkP2ZI3CJbbBbIMJfSbqzyNBw0G/LHplRFNZ3v/A
         4fWg==
X-Forwarded-Encrypted: i=1; AJvYcCXetaj+Mbn2/hTuf6FBqM4i5bBA9HSPqEBrWeDa9dZXGhldNexHAXBgfj1QVO2x1v5EfbE0v3PbkO830bbaMxXp@vger.kernel.org
X-Gm-Message-State: AOJu0YwvyWhl/p2isNItEkjm9HP9Ccv0jmf10dARr+YJ6fN4wbcLkBgL
	hnqx1CXLjnIH33ADzMCEeL2P5I2xIMBEuY0QUkJO7g5kjRWpd/5/OnYdJyNm0HJ4n+hUzMOy4+4
	fMXKflMNS2gTCITJ277mGz5Sh/3hVozBTGkx/
X-Gm-Gg: ASbGncupvYEDhsfvGfwXkorI5TNRbOPEY4m9WpLhH8UIYKRYeziktAbM1KhZ7YEEKso
	zhPbUKnaoPKD5cqz5203+f+A19VwmtZ+TSb50QUlKLGeH6e5SyujlyMbryu3XZdXZJKp4727rRw
	zSyGybt5GRSRdDvaIuqpKF2g1UzUx07diMOrU=
X-Google-Smtp-Source: AGHT+IFwp3aDY1xdKOGIvNzmNzrE+EbC7dhnuNvWbEqrnN0gDbxK7QEI4q9unX3KH2yI0y+SPV0okonhdvPx7sZ3Bzg=
X-Received: by 2002:a17:902:db11:b0:216:4d90:47af with SMTP id
 d9443c01a7336-22307aad240mr1020335ad.29.1740432884571; Mon, 24 Feb 2025
 13:34:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z7Z5kv75BMML2A1q@google.com> <CAP-5=fVbti6efu6uA9a5os6xhnTuJ0egyesZsy0dmkiScwYFqQ@mail.gmail.com>
 <Z7yJ0Vpub6JeQyYo@x1> <CAP-5=fXSgpZaAgickZSWgjt-2iTWK7FFZc65_HG3QhrTg1mtBw@mail.gmail.com>
 <Z7zVzKbQIdB6-bFn@x1>
In-Reply-To: <Z7zVzKbQIdB6-bFn@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Feb 2025 13:34:33 -0800
X-Gm-Features: AWEUYZnHJNclQdrWA_kOnPPjWgKKj8hpkivAtF4Q7CYh9TMEeUXvd9VshD-qvSA
Message-ID: <CAP-5=fU3YSCiHygnOt6MN7i2mJBOwm202tXSefBHaPR3JmptkA@mail.gmail.com>
Subject: Re: [RFC] perf tools: About encodings of legacy event names
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 12:25=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Feb 24, 2025 at 09:36:16AM -0800, Ian Rogers wrote:
> > On Mon, Feb 24, 2025 at 7:01=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Wed, Feb 19, 2025 at 10:37:33PM -0800, Ian Rogers wrote:
> > > > On Wed, Feb 19, 2025 at 4:38=E2=80=AFPM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > > Ian and I have been discussing the behaviors of event encodings a=
nd it's
> > > > > hard to find a point so far that we can agree on.  So I'd like to=
 hear
> > > > > your opinion to resolve this.  If you happen to have some time, y=
ou can
> > > > > follow the thread here:
> > >
> > > > > https://lore.kernel.org/linux-perf-users/20250109222109.567031-5-=
irogers@google.com/#r
> > >
> > > > > Basically there are some events that were defined in the perf ABI=
.
> > >
> > > > >   PERF_COUNT_HW_CPU_CYCLES, PERF_COUNT_HW_INSTRUCTIONS, ...
> > >
> > > > > So perf tools use those (legacy) encodings with the matching name=
s like
> > > > > "cycles" (or "cpu-cycles"), "instructions", etc.
> > >
> > > > > On the another hand, it has wildcard matching for event names in =
PMUs so
> > > > > that users can conveniently use events without specifying PMU nam=
es.
> > > > > For example, "event1" would expand to "pmuX/event1/", "pmuY/event=
1/", etc
> > > > > as long as the PMUs have the event in sysfs or JSON.
> > >
> > > > > And there are platforms where "cycles" event is defined in a (cor=
e) PMU
> > > > > (like "blah/cycles") and the event has a different behavior than =
the
> > > > > legacy encoding.  Then it has to choose which encoding is better =
for the
> > > > > given name.  But it's a general issue for the legacy event names.
> > >
> > > So we pick the "legacy" one, as always, and the one that is in a PMU
> > > needs to have its pmu name specified, no?
> > >
> > > > >   Q. what should it do with "cycles"?
> > > > >   -----------------------------------
> > > > >   1. just use the legacy encoding (PERF_COUNT_HW_CPU_CYCLES).
> > >
> > > Right
> > >
> > > > >   2. expand to (possibly multiple) PMU events (like "cpu/cycles/"=
) and
> > > > >      use the encoding defined there.
> > >
> > > Nope
> > >
> > > > > I think the #1 is the current behavior.  The upside is it's simpl=
e and
> > > > > intuitive.  But it's different than other names and can make conf=
usion.
> > > > > Users should use the full name ("cpu/cycles/") if they need sysfs=
 one.
> > >
> > > Right
> > >
> > > > So the code keeps changing, for example, the removal of BPF events.=
 I
> > >
> > > Humm, this seems like a different discussion.
> > >
> > > > think the important change and the thing that has brought us here i=
s
> > > > the addition of what Intel call hybrid and ARM call BIG.little. ARM
> > >
> > > Right, the support for hybrid systems brought lots of problems, most
> > > people didn't have access to such systems and thus couldn't test
> > > patches, so the attempt was to keep the existing code working as it h=
ad
> > > been while allowing for the support for the new hybrid systems.
> > >
> > > As more people get access to hybrid systems we started noticing probl=
ems
> > > and working on fixing it, you did a lot of work in this area, highly
> > > appreciated.
> > >
> > > > have got architectural events and so the same event encoding on BIG
> > > > and little cores. On x86 the e-core (atom) and p-cores have differe=
nt
> > > > event encodings. In the original hybrid work, pushed on for the lau=
nch
> > > > of Alderlake and reviewed by Jiri and Arnaldo with no involvement f=
rom
> > > > me, Intel wanted the event names to work transparently. So a cycles
> > >
> > > Without access to such systems, yes, see above.
> > >
> > > > event would be gathered on the e-core and p-core with a command lin=
e
> > > > option to merge the legacy event cycles on both cores. To be specif=
ic
> > > > the expected behavior of:
> > > > $ perf (stat|record) -e cycles ...
> > > > would be as if:
> > > > $ perf (stat|record) -e cpu_atom/cycles/,cpu_core/cycles/ ...
> > >
> > > Yes, and if somebody wants to profile in just one of those core types=
,
> > > just specify the "cpu_atom" or "cpu_core" to have it fully specified.
> > >
> > > > An unfortunate thing in the hybrid code was that it was hardcoded t=
o
> > > > PMU names of cpu_atom and cpu_core, but what to do for metrics? The
> > >
> > > Yeah, metrics IIRC came before hybrid systems.
> > >
> > > > original proposal was that metrics would have a PMU name and all na=
mes
> > > > would be relative to that, but what about uncore events? What about
> > > > metrics that refer to other metrics? A decision was made to not to
> > > > have PMUs implicitly in metrics and the events in the metric would
> > > > match those given to perf's -e command line. This also greatly
> > > > simplifies testing events when creating a metric.
> > >
> > > > I set about rewriting the hybrid code not to use hard coded PMU nam=
es
> > > > but to discover core PMUs at runtime. This was to make the metric a=
nd
> > > > event parsing code as generic as possible, but this had an unintend=
ed
> > > > consequence. ARM's core PMU had previously not been seen as handlin=
g
> > > > legacy events like cycles, and appeared as an uncore PMU. When ther=
e
> > >
> > > > are both legacy and sysfs/json events then previously the legacy
> > > > events had priority. This broke events like cycles on Apple M
> > > > processors where the legacy events were broken and the sysfs ones n=
ot.
> > > > Yes this is a driver bug, but everybody told me a change in behavio=
r
> > > > of the tool was needed to fix it, that fix was to make sysfs/json
> > > > events have priority over legacy events. I prioritized fixing event
> > > > parsing when a PMU was specified but given "cycles" means
> > > > "cpu_atom/cycles/ and cpu_core/cycles/" for hybrid, why would the
> > > > prioritization be different without a PMU specified?
> > >
> > > > I knew of this tech debt and separately RISC-V was also interested =
to
> > > > have sysfs/json be the priority so that the legacy to config encodi=
ng
> > > > could exist more in the perf tool than the PMU driver. I'm a SIG
> > >
> > > I saw them saying that supporting PERF_TYPE_HARDWARE counters was ok =
as
> > > they didn't want to break the perf tooling workflow, no?
> >
> > No. The request has always been that they don't want the PMU driver to
> > do the PERF_TYPE_HARDWARE/PERF_COUNT_HW_* to PMU/config=3D??? mapping
> > given the diversity of hardware and to keep the PMU driver simple.
> > Here is Atish's feedback:
> > https://lore.kernel.org/lkml/CAHBxVyH1q5CRW3emWTZu1oLZEfTWWVRH6B0OVggFx=
t-0NRzvwQ@mail.gmail.com/
> > """
> > If the overriding legacy with JSON is available, each future vendor
> > may just provide the json file instead of modifying the driver.
> > """
>
> So, making users to figure out what is the best event to use for some
> specific processor was one of the major reasons for perf to come about,
> otherwise we would still be stuck with oprofile.

Tbh, I think OProfile's major issue was a lack of active development.
There were arguments that perf was going to be more integrated into
the kernel, but there are no arch events, for example, in
arch/arm64/events. Perf provided new energy for something started as a
student project, it was and is good for having done that.

> While it is clear that picking some "most important event and ratios of
> events" is super difficult, that was one of the ideas that made perf to
> come about.
>
> I wasn=C2=B4t the architect of this, Ingo and Thomas were, with Peter the=
n
> tryhing to make the kernel part sane.
>
> I just tried to follow those principles while not getting in the way of
> people wanting to have a common ground for observability in Linux.
>
> Having all these JSON tables was in place was a major concession to that
> original vision.
>
> Changing things as we go, with all these changes in the hardware
> landscape, some fleeting, some reinforced, is super difficult and leads
> to all this pain in trying to provide a sane experience to people using
> these tools.
>
> I don't think we can have it super consistent.
>
> It is super useful as is, or at least that what people say.
>
> So we need to keep on improving it while not telling people used to its
> workflows that they should re-learn the tool because at some point a
> decision was not properly made.

So yes, but no. If you are used to perf on a pentium core 2 and then
move to a hybrid alderlake system there has to be some notion of what
cycles means on each core type. We had to change the tool to support
this. ARM dealt with this long before Intel hybrid ever did, but they
did so with no legacy event support just sysfs/json. Of course the
wildcard behavior means that all the PMUs that supply an event will
have it selected and people have been happy with this a long time.
We used to have BPF events but no longer. It seemed like a fruitful
thing, it became obsolete and was removed.
We have legacy encodings where LLC means L2:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/evsel.c?h=3Dperf-tools-next#n801
Fine at the time, now seems silly. LLC seems like a reasonable PMU
name, but event parsing will trip over it in the clumsy way it does
with raw events and "read" (raw event of 0xEAD). Event parsing used to
broken for events like "llc-llc" now you can have that as an event
now.

Anyway, I dislike that you are arguing that I am trying to tell people
to change their way of using the tool, it implies the patch series
breaks something. If you feel this then you should provide an example.
Yes Linus had a problem with the cycles event on Neoverse and now
that, as you suggested, is lowered to be a warning. The original patch
landed for weeks on linux-next without complaint. I am not asking
people to "re-lean the tool", I am trying to fix things and make order
out of something less than that.

> > Because of the pain in landing the reverted patch then RISC-V has had
> > to work with perf's behavior as it is, they need to ship products. I
>
> you can present it like that, or you can say that they wanted the API to
> be different but since it wasn't like they liked they had to comply.
>
> Differently phrased he finally understood the value of the current API,
> maybe.

So Atish spoke to us at LPC 2023:
https://lpc.events/event/17/
Mark Rutland also spoke to me at that time explaining how unhappy he
was that ARM Apple-M was broken. I combined both issues in our
discussions.
Atish has also spoken to Namhyung and myself face-to-face during the
RISC-V conference.
These issues were discussed verbally before I wrote patches, before
Atish made assumptions, and I think we both believe the proposals were
and are reasonable.

So let me completely disagree with your rephrasing. It is rude to
imply that Atish and myself somehow are trying to push an agenda of
changing and breaking an API. What has always been done is an attempt
at pragmatism, such as cleaning up the hard coded issues with the
original hybrid support, fixing Apple-M, ..

> > think things would have been simpler in their driver and the wider
> > ecosystem if this hadn't been forced to happen.
>
> > > > vice-chair for RISC-V and hope to push things forward for RISC-V wh=
en
> > > > I can. Given that ARM had originally required the prioritization,
> > > > Intel signed off on this (with a huge number of Intel test
> > > > expectations updated as a consequence), RISC-V desiring consistency=
 I
> > > > thought there was a pretty broad consensus to move forward with hav=
ing
> > > > the same prioritization of legacy and sysfs/json events for event
> > > > names without PMUs as those with it.
> > >
> > > > In doing this change I made:
> > > > $ perf (stat|record) -e cycles ...
> > > > behave like:
> > > > $ perf (stat|record) -e */cycles/ ...
> > > > This is the behavior with sysfs/json events (ie not legacy). For ex=
ample:
> > > > $ perf (stat|record) -e inst_retired.any ...
> > > > in the event parsing code behaves like:
> > > > $ perf (stat|record) -e */inst_retired.any/ ...
> > > > That is every PMU advertising the event inst_retired.any (in the sy=
sfs
> > > > events directory or in json) will have it opened by the tool.
> > >
> > > > My intent was that "cycles" behaving like "*/cycles/" was that it
> > > > would match the change already done for hybrid of "cycles" behaving
> > > > like "cpu_atom/cycles/,cpu_core/cycles/". However, this change caus=
ed
> > > > an issue on ARM Neoverse that Linus couldn't tolerate and so revert=
ed
> > > > the change. Specifically ARM Neoverse's L3 cache PMU advertises a
> > > > "cycles" event and such an event will fail to open with perf record=
.
> > >
> > > > Specifying the PMU with the event avoids the wild card behavior and
> > > > fixes the issue but it was put over strongly that "cycles" without =
a
> > > > PMU should only ever mean CPU cycles. This missed hybrid/BIG.little
> > > > type systems, but one could imagine in that case CPU means all core
> > > > PMUs.
> > >
> > > > As with not wanting hybrid PMU names hard coded, I dislike special
> > > > cases for events. Not least as there are an exciting plethora of
> > >
> > > Ok, but the desire for consistency clashes with how things have been =
for
> > > a long time, tools expect, scripts, etc, so we seem to need the speci=
al
> > > case for what has been called in these threads "legacy events".
>
> > There is only one known issue of a problem for 1 event on 1 ARM model.
> > If ARM renamed the event this wouldn't be an issue. The patch series
> > works for this event but warns about it if you try to use it with perf
> > record.
>
> Well, maybe just the event name shouldn't be what determines if it
> should be used in some cases? Maybe some other characteristic should be
> probed for in each case?

Do you want to explain this? We have events, without a PMU all events
wildcard on every PMU. This is existing and long standing behavior.
Uncore PMUs rely on it. Core PMUs with say a json event like
inst_retired.any rely on it.
You want a magic list of events that only work on core PMUs? Fine,
what is it? I hate the idea as why does cpu_cycles mean something
different than cpu-cycles, but if that is the only way to land the
series then let's do it. You had been arguing for lowering the failure
to just being a warning and not doing this. I do not understand where
you stand. My stance is hopefully clear with the patch series. If you
and Namhyung are worried that Linus seeing a warning message is a
blocker the easiest fix is to rename 1 ARM uncore event. We could hide
warnings and move them to verbose, imo that's gross. We can have a
magic list of events, similarly imo gross but at least it unblocks
this.

> Have to stop here, not enough bandwidth.

Thanks for making some time on this,
Ian
