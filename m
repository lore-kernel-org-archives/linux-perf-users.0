Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CAD35949
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2026 04:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773636175; cv=pass; b=K9d6zhJNWOviWIwI3cYjLK3Ig/Mzg/+1TQN2baRgftDpBflK/KkBUFe/JR4OwFJei3FKqe96dkUavpmsPUW48NrnbQyc06RpRmE87us4ogH43s2JcTEULAz85JYYtLRPGdRmYD4o0zrN4XkbTy1/iR+ijd4OIOEPxbVG/y2lhn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773636175; c=relaxed/simple;
	bh=moO3NEKJcNQCfYg+SGOfaJ2jg+DKjxCPn0wBrNqwZ58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbJVyovt+G7V9xRfLSCMHx0+03wPodEJBXYQdfJUN0GE7B5TZR1nwZLJDEXYSRKMAiFZP7h8fwfHZ73xJjt+gD4ttTQEqnxhyQbIAtqO7nxY432PW9lccKRDb1XFImiYZ4c+Va28OHenjMD8TZ1NL+s4IZqDGpjcuxdfsBfr65Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0PbCyKf; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0PbCyKf"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89a07f66f4eso51055966d6.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Mar 2026 21:42:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773636172; cv=none;
        d=google.com; s=arc-20240605;
        b=ZWHAZQrNqzVH++J36b2s7fGMr9ZY2c3YoyvDGNAeTxl+V39AHzJWr80yYXdiOcUMmt
         Cf3lqx9cYcb9/KuEkERykjJ5/uCZfJUZdrLLhNcZp5wpU2X+/dVoNO0l/krOfOfpBrr+
         3mTACWDMpj25Pt10ESuidrzSdJw3c+fsT/bI45Mgkc0cwuG0ykyF8FnjJGrwrlm5U62y
         KbL90YeO9K3u+z2h3gK6m1Hx7ikKZAiYbNBIgUtzDxV7H/o2M9JuuMLZ/yewZZvy9BtJ
         Yq2DBKxao0pX6GCcNtJDphpUHD/jfF08e4Y3md1QOofKon1YO5X5bzwPgzgPOmt4yel9
         LAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6jw9qUZXePLlHIUoLFvt8FcNRA4TIoDnfeUmfgxWpVI=;
        fh=nIzK89pf858ygWu5L7lPcko2HK+uXpAr2jcb1Ev6RFc=;
        b=CkaVQfq+oeGHyD5sWo7/9LVeYX0C3SheIKWHV0ZE93lQ9NmwDTzDR737Jx9/54dkJZ
         OMAd6X79Fa55h1Hqt0v5IFKoTtffiEbHc72rNW0VHJUu8QmCklPLVlce6T+nDYHxq1p1
         5GWa1MQPdOPs/FiLEK0dl0FNXE2Lkx/+n63WliUm0JNlUw4qUlCFUBVEHOWCVZiJsRfv
         k1A3xk2g90+sf2J+VzshsXkLfNKYfP/6oWpDmhAEViK6OvUTflqm0khW0++hmGRCpwWf
         e9MMLAKnY2j6ALKYHna3N0ct2p5PP3f6iqB0TJSwKjsuv7YhkwePyKaQzArR59J6VO3G
         c7hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773636172; x=1774240972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jw9qUZXePLlHIUoLFvt8FcNRA4TIoDnfeUmfgxWpVI=;
        b=P0PbCyKf7E4zQcNhEnOLZmLUAU7OcTDITHzP0Ags/y0b6nmApY+8XPCnip7vKRJB6A
         tU9w26a+l7IuWMMvTvXqW5bctJvq+UrjxTooaJcoWEMWmmqIwKVmwD8icyX2TgfkR6zZ
         AQaXtibXZT+tr2U853n3Fu2HJRi+NdVi5jt97RdNMGixHn7TO4rAlQmd2w+9M/thyjw2
         4xGyIg1ByH09HJ2N+io7W+XLlXYZCdUcAqG6jYKJDYVHUeLHRdClt9IiL2N+rzVdbmdd
         +Q2sISFHdnjuz7uDXBN1k6tMamMbxaiPs3Os1B/fc3jsapG+ZjwHefCBgCadyE3/vDCS
         WLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773636172; x=1774240972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6jw9qUZXePLlHIUoLFvt8FcNRA4TIoDnfeUmfgxWpVI=;
        b=oMNwDhBnolaqepQ/JVabBQfKSP5PMJeigBmKwgwLgxpgw10XeD4ebEBBNv8NG0xNe/
         boKLwGbB1yDOvAt1XaZ/Rm4i5BPqHK4y94dbjXRpjrkXIVLaXkyAAo0QPF3WB7v83bs9
         nUvSBCs7+8OiOzNeqwA63p0Rwv4gCCCMgBut0P0eFjgOFxq+A3ooSav8RZzuzc5XMmqj
         kqwn5qpwz2I12vsjfQFDxTv01c6Pk+EFuHcUn6oQtTAt+lWrsM0uAhXTtEx88rgZ2nlZ
         nQmhx4TeBRt9A30I0oKsRrOctogjihDH5oDD9LgdAjZUlJ+0C+0L5bVgwfPd3I9sm7i8
         tJMA==
X-Forwarded-Encrypted: i=1; AJvYcCW99QgpWiRiOywhD2SR5k/B4gB1yX0yRFC0tOSONKPupdWmWKQ/ZS0v92GmaNws7Kzz5BZMla3zDae6BXOCSpAd@vger.kernel.org
X-Gm-Message-State: AOJu0YxmOT6ozGj2d92vHffQgr+hgTwACl6FyWqCubUBCteZb2yHteM0
	9SJ7r9w4l2kkcFXwnSWC/xfqHY1JwrPJ7o6VU+uJ/feVEomzHKYm3rT0DMdsBXuzWqQ+JWRhFu0
	zZ+C10QlYhTmeXbRLb4/nQwVzOFhF0+NEgp/H
X-Gm-Gg: ATEYQzynKtfiRh/JeQfHKT+qLkeepMbduseMmbFbbWXkwn71mwWq5NF1pnjEqZgrVW6
	d3sFS6Hi1Slk6e2xdptS+PyDPOCTLWUqAbSZiTBQ1KiYf3cqQWjL11ei1+lU8f3WGOiyfSqulPK
	HiuvCunf+6G2lBror2dJ/+W1wSzlYpg6/5BPX02WmardD+7nlJqBJ2HfLguzIzbYaSxIxFdbYhh
	D82M28Ql4pkcAgrivwOdv/PyzRgqomENCTi9Bq2fDeA90DwzHbxT5LdkFH4RkGOXFgUMMLQjtv5
	aXUrgBB9YAy20Sqh2IF+l5QD4sysqJ2p7D0=
X-Received: by 2002:a05:6214:1d26:b0:89a:9b1:a225 with SMTP id
 6a1803df08f44-89a81c7792amr183642976d6.12.1773636172158; Sun, 15 Mar 2026
 21:42:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC5umygtmi_rHUbayYn=EMFg=0ztZH1ot73KzsaHTy+yk-a=Qw@mail.gmail.com>
 <20260314013115.81177-1-sj@kernel.org>
In-Reply-To: <20260314013115.81177-1-sj@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Mon, 16 Mar 2026 13:42:40 +0900
X-Gm-Features: AaiRm52aVL41Ihh0TMOl6RWQlhFCRN5NXeeRMM6Kf5B-2W7Y5CWzrwtfJ4fWRa8
Message-ID: <CAC5umygTVeiki7xhWrVkscaqEZo4+RKaDpODyGgTSwGfLt1+pw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/6] mm/damon: introduce perf event based access check
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B43=E6=9C=8814=E6=97=A5(=E5=9C=9F) 10:31 SeongJae Park <sj@kerne=
l.org>:
>
> On Fri, 13 Mar 2026 16:35:55 +0900 Akinobu Mita <akinobu.mita@gmail.com> =
wrote:
>
> > 2026=E5=B9=B43=E6=9C=8811=E6=97=A5(=E6=B0=B4) 9:51 SeongJae Park <sj@ke=
rnel.org>:
> > >
> > > On Mon,  9 Mar 2026 10:00:03 +0900 Akinobu Mita <akinobu.mita@gmail.c=
om> wrote:
> > >
> > > > DAMON currently only provides PTE accessed-bit based access check, =
this
> > > > patch series adds a new perf event based access check.
> > > >
> > > > Since perf event-based access checks do not require modifying the P=
TE
> > > > accessed-bit for pages representing each damon region, it reduces t=
he
> > > > overhead of monitoring at a fixed granularity of the page size.
> > >
> > > Based on my understanding of this patch sereis that I was enlightened=
 from the
> > > conversation with you on the RFC v1 and kind comments from perf commu=
nity, I
> > > agree to the points of this patch series.  Extending DAMON with h/w f=
eatures
> > > like AMD IBS and Intel PEBS is what multiple people shown interests. =
 I believe
> > > it can benefit multiple users.
> > >
> > > I hope this work to be continued until it is landed on the mainline, =
and I will
> > > be happy to help.  Probably not exactly in the current shape, though.=
  I think
> > > this is still in an early stage.  And for the reason, I will comment =
on only
> > > high level things here, rather than diving deep into each patch.
> >
> > Thank you for your helpful comments.
> > I will continue to work on this project.
>
> Glad to hear that :)
>
> >
> > > > Furthermore, this patch series also includes a feature that allows =
you
> > > > to set a minimum region size for each target, enabling you to monit=
or
> > > > at any fixed size greater than the page size for each target.
> > >
> > > I'm not very sure if this is really required to be a part of this ser=
ies.  Can
> > > you further share more details about what is the benefit of this feea=
ture, and
> > > if it should be coupled with this patch series?  It would be great if=
 you can
> > > share some test results proving the arguments.
> > >
> > > If this is really beneficial but there is no reason to couple with th=
is series,
> > > I think merging this separately first or later could also be an optio=
n.
> >
> > Indeed, this patch can be submitted separately.
> >
> > The purpose of access monitoring with a fixed granularity greater than
> > the page size is to reduce overhead when the total size of the memory
> > region being tracked is large.
>
> This sounds bit strange to me, because DAMON's upper-bound monitoring ove=
rhead
> is proportional to the user-set maximum number of regions, not the total
> monitoring memory size.
>
> >
> > Also, we want to be able to track hugepage sizes for some targets, so a=
 minimum
> > region size setting is provided for each target.
> > For example, when memcached is started with the --enable-largepages opt=
ion,
> > it will attempt to use THP.
>
> This is again sounds not very completely easy to understand to me, since
> adaptive regions adjustment will converge to work in THP granularity in t=
he
> case.
>
> Maybe you want to monitor virtual addresses in fixed granularity, but use
> different granularity per target?  You could do the fixed granularity
> monitoring by setting the min_nr_regions and max_nr_regions same to the t=
otal
> size of monitoring memory divided by the desired granularity size.  But m=
aybe
> this is challenging for your use case, because you use 'vaddr', which
> dynamically changes the total monitoring memory size depending on the pro=
cess's
> memory mapping status?

Yes, the virtual addresses of multiple target processes are monitored
at a fixed size granularity, and only some processes are monitored
with a hugepage size, while other processes are monitored with a size
such as 64KB.

In my use case, I periodically detect the creation of new target
processes, so if I wanted to monitor all target processes at a single,
fixed granularity, I could obtain their total memory size and set
min_nr_regions and max_nr_regions to match that target fixed size
without introducing any new parameters.

> You can also do different granularity monitoring for different virtual ad=
dress
> space by using different DAMON contexts per the target process.  But I gu=
ess
> you're saying it is not a good user experience?

I've only evaluated it in one damon context so far, so I'll try to
see if it works in multiple contexts.

> If so, that makes more sense to me.  But, I think user-space helpers coul=
d help
> you overhauling the challenges.  I'm curious if you tried that, and found=
 it is
> really uncomfortable or too suboptimal.  If so, sharing the experience an=
d/or
> test results in more detail will be very helpful.  Maybe we can do this d=
iscuss
> in more detail on the separated patch, though.

Sounds good.

> >
> > > >
> > > > Using these features also requires modifications to damo, but these=
 are
> > > > not included in this patch series and are currently under developme=
nt in
> > > > the following branch:
> > > >
> > > > * https://github.com/mita/damo/tree/damo-perf-for-v3.1.8
> > >
> > > Sounds good.  No rush, but also feel free to send patches or PRs for =
this.  It
> > > is common to support DAMON features on DAMON user-space tool even bef=
ore the
> > > DAMON features are merged into the mainline.
> > >
> > > >
> > > > Any feedback or advice on the patch set would be greatly appreciate=
d.
> > > >
> > > > * v2
> > >
> > > Let's keep using "RFC" here.
> >
> > OK.
> >
> > > > - reintroduce damon_operations->cleanup()
> > > > - introduce struct damon_access_report
> > > > - use struct damon_access_report instead of introducing struct
> > > >   damon_perf_record
> > >
> > > Thank you for doing this.  I hope using not only the struct but the u=
nderlying
> > > infrastructure, though.  Let me comment this more detail below.
> > >
> > > > - remove maximum region size setting
> > > >
> > > > * v1
> > >
> > > Ditto.  Let's keep using "RFC".
> > >
> > > > - https://lore.kernel.org/damon/20260123021014.26915-1-akinobu.mita=
@gmail.com/T/
> > >
> > > Thank you for sharing the link.  This is helpful for me at reviewing.
> > >
> > > >
> > > > * TODO
> > > > - Currently, it is possible to unintentionally specify a perf_event
> > > >   that cannot obtain either PERF_SAMPLE_ADDR or PERF_SAMPLE_PHYS_AD=
DR
> > > > - Check if it works in a virtual environment using vPMU
> > >
> > > The above two TODOs make sense to me.
> > >
> > > I'd like to request below things as main TODOs.
> > >
> > > First, I hope the benefit of this change is described in more detail.=
  The
> > > current description mentions it is more lightweight since it doesn't =
need to
> > > update the accessed bit.  But, PMU-based monitoring should also have =
its own
> > > additional work.  It would be nice if you can describe what additiona=
l works
> > > for PMU-based monitoring induce, and why it is generally lower than t=
hat of
> > > access bit modification.
> > >
> > > Having a more clear motivation, or expected use case would be nice.  =
You don't
> > > neeed to share real details of your use case.  You can anonymize sens=
itive
> > > things if needed.  But giving a reasonable and realistic use case wil=
l be nice
> > > to understand where this can really be beneficial.
> > >
> > > Sharing a test results showing the benefit will also be very nice.  I=
t doesn't
> > > need to be huge real world test, but some reasonable amount of data t=
hat
> > > collected on a realistic test setup could be very helpful.
> >
> > All of the TODOs you suggested are useful.  I will try to share the tes=
t
> > results and comparisons with access bit based cases.
>
> Great, looking forward to!
>
> >
> > > Second, I hope this patch series to reuse the DAMON primitives extens=
ion
> > > infrastructure if possible, to reduce possible future duplications.  =
I'll add
> > > more details about this below.
> > >
> > > >
> > > > Akinobu Mita (6):
> > > >   mm/damon: reintroduce damon_operations->cleanup()
> > >
> > > Thank you for doing this :)
> > >
> > > >   mm/damon/core: introduce struct damon_access_report
> > >
> > > Again, thank you for doing this.  I understand this is an answer to m=
y previous
> > > question to the RFC v1 of this series.  I was asking if you considere=
d the
> > > infrastructure part of my page faults based DAMON extension series, a=
nd you
> > > borrowed the main data structure of the series here.  But, I hope us =
to reuse
> > > more of the code, since it is more generic from my point of view.
> >
> > The plan was to start by reusing structures and gradually make use of
> > infrastructure.  Now, I have a better understanding of your DAMON
> > extension series
> > and have no major concerns about migrating to it.
>
> Great.  Nonetheless, I expect you might find devils in the details while =
coding
> it.  Please bear in mind and don't hesitate at asking my help.  I tend to=
 be
> wrong a lot and learn from mistakes. :)

Thank you for your cooperation.

> >
> > > >   mm/damon/core: add common code for perf event based access check
> > >
> > > This patch is introducing a few of sysfs files under DAMON sysfs cont=
ext
> > > directory, namely 'perf_events/' and its underlying files.  The files=
 is for
> > > registering perf events for the access monitoring.  I don't dislike t=
he basic
> > > concept, but concerned if it is too specific for only perf events and=
 therefore
> > > cannot be easily extended in future.
> > >
> > > The faults-based DAMON extension patch series [1] implements files fo=
r similar
> > > but more general concept.  It defines a concept called sampling primi=
tives.  It
> > > is the low level primitives for access check.  It could be access bit=
 checking,
> > > page fault event, or something new, like perf events.  It adds
> > > monitoring_attrs/sample/primitives/ sysfs directory, which can be use=
d for
> > > selecting what primitives the user wants to use.  I think perf events=
 can be
> > > defined as another access check primitive, and the sysfs files can be=
 added
> > > under here.
> >
> > I agree.
> >
> > > I was also bit concerned at the fact that the filees are effectively =
exposing
> > > perf_event_attr struct.  That is, I was concerning about stability of=
 the
> > > struct.  I now see it is a part of linux user api, so I assume it is =
a stable
> > > api.  Could you please confirm this?  Also, adding more clarification=
 about
> > > that fact on the patch would be nice.
> >
> > Since `perf_event_attr` itself is an argument to the `perf_event_open()=
` system
> > call, I think future compatibility will be maintained, but I also have =
some
> > concerns about whether the interface provided by this patch is optimal.
> >
> > Also, as mentioned in the TODO section, there are currently almost no
> > restrictions on the PMUs that can be specified, so it is possible to re=
gister
> > PMUs that are completely useless for perf event-based access checks.
>
> I agree to this concern.
>
> > I have one idea under consideration, and I plan to address it when I se=
nd out
> > the next patch series.
>
> Sounds good, looking forward to the next version.
>
> >
> > > >   mm/damon/vaddr: support perf event based access check
> > > >   mm/damon/paddr: support perf event based access check
> > >
> > > My understanding of the above two patches is like below.
> > >
> > > 1. The perf event samples are added to a circular buffer whenever it =
is
> > >    generated.
> > > 2. At the end of each sampling interval, the ops reads each sample in=
 the
> > >    buffer, find a matching DAMON region for the sample, and updte the
> > >    'nr_accesses' of the region.
> > >
> > > For this, this patch series implements the circular buffer for storin=
g samples,
> > > and xarrays for finding the matching DAMON region for a given sample.
> > >
> > > The page fault based DAMON extension patch series is doing something =
similar.
> > > The first patch of the series implements the buffer for storing acces=
s samples.
> > > I think the perf event samples can be stored here.
> > >
> > > The seventh patch of the series implements the logic for finding the =
matching
> > > DAMON region for each of the samples in the samples buffer, and updat=
e the
> > > 'nr_accesses' of the DAMON region.
> > >
> > > Because the page fault based extension's infrastructure is quite gene=
ral for
> > > any future types of the primitives, I think it would be nice to reuse=
 it.
> > >
> > > The infrastructure is quite simple and not optimized for performance.=
  But
> > > optimizations can be made later.  I'm more interested in the long ter=
m
> > > maintenance of the interface.  And I think the page fault based exten=
sion's
> > > infrastructure is easier for long term maintenance.  Of course I migh=
t be
> > > biased.  Please let me know what you think.
> > >
> > > If it helps and if you don't mind, maybe I can try to implement this =
series on
> > > the page fault based infrastructure and share it as another RFC patch=
 series.
> >
> > I'm starting to get a vision of how to incorporate this as sampling pri=
mitives,
> > but if you try implementing it and share your results, it would be extr=
emely
> > helpful.
>
> Ok, I will try to make it in a dirty but fast way and share asap, probabl=
y
> within 2-3 weeks.

That's wonderful!
Please don't overexert yourself.

> >
> > > >   mm/damon: allow user to set min size of region
> > >
> > > As I mentioned abovely, I'm not sure if this is really need to be cou=
pled with
> > > this entire series.
> >
> > I'm happy with this patch, as it's much simpler than the last one for R=
FC v1.
> > Next time, I'll send them separately.
>
> Nice, looking forward to it!
>
>
> Thanks,
> SJ
>
> [...]
