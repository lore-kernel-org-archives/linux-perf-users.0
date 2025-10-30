Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E61135BDC1
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839873; cv=none; b=t8yGlhhBUuO9qCO1gwQuVVMY+8/H20FWh8BvGi7T1YWO1cNHj+rUG2RsOQVFaDPk62w9XGTlnByuVXCGm2B/WRE7fo0Dk+akjMJQnjLKOPcaOJgjO6bB98RJt23N+pA69FzoCR4RoMT4XfS/BsRQ6v5933V58Nk051cSiptEFOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839873; c=relaxed/simple;
	bh=ji9ytn1OmAslkLJv9kaCLqBRbNX5FmwHhxe0w7DsQxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjDyo5jvjweAkq5SRbMr4ifgguBDampktPZi78Kg1wtYOq5RXcaFQA3aZYFmZPtkWC4SJ86IaMB6buj8BCmJtk5RtJnLlpEIJRuOqWghG7bRQC7HksTGmVveCe6f6mDxg5f/CCJbKShDCvBnUXdjngoeFhCsGHxjNuBalvnwvOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=39DUyMGj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="39DUyMGj"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290da96b37fso212265ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761839871; x=1762444671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMds9d0sMAjabVnJZZV6ncZToWmQ1aXhR+69YdY52f0=;
        b=39DUyMGjbak495ffLn4XV4kErrh8GeCedvaaLKi/iTlNEWy4pLOWHRTEI+ZAJ5ThZh
         ao+Kr9QGU1U/2MkJ6muDATKf29J3K89v1wxo6W5Gb069UuJ1IiHIGWDqMcBh1criD1mq
         Wo1rKM2ttTn2+7zMtnTvOIhgfJAs/3EKKPUn7nTtqX5/0/s/dbZ1+5y/0YUO36+APo/Z
         gpJw5yjXuNLsqFFwbqseS4CpuW/I3/ZaHH8gtGKLntYaSFWWUPtV2UrvOxHwB4IPhA7x
         /HSQ6otSXmYAivSfzlGvGSMTgcN8EMqfaq1evbKKowQIXjCbWtcOIW50kkd3K/3KaHSY
         e1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839871; x=1762444671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMds9d0sMAjabVnJZZV6ncZToWmQ1aXhR+69YdY52f0=;
        b=wk1P0KWD82Z7w910kPZVZRBotAD2BBtnSDB0lB1UOzF/K9K0Ibz19BLwiHoXwi9jZF
         0c5b39/mVpGa6skcV0N8EeCK5zSz6E4Vo1qhc9aUxYPL0yb2LWG214F7vqk5esoc5ESQ
         IVCmnn2SFR4MgAtp1tg2UXSQ3aPzFyhvFiRmRaM+DNfZWv4uV+1Re2Pa6QXub9v5OLB+
         D2obSnwl0HENwf/YB8/bXaXPPBI8SSZ+9McqYLxzQ5M2PTvEQj3ladMVPWer5UFskSA2
         LQdbF0ZHolqwVg48lJAgGtCKhVJSVdIEqYcc+L+GEpaYpcs+GstEYgBw3TvFcmjRjgDV
         EqDQ==
X-Gm-Message-State: AOJu0YzX7guE5i8rNk/rCDMoqDix9/shNVU+KiL6dspViCezvEVIyr/V
	iG592QysEXJ13GD38hhh9AipIlXxSz8jCUWLWsyFi8T8Wb8+cHH8D9RDRKOnJ6YgX1myTOjbyKe
	HfD2Vf14EcttBNnpzPF3TDSipzSSobfxxKG26Qsp+
X-Gm-Gg: ASbGncuDuWcTuLN9jlejViVb9KOzPtvVUye1FQtvFesNob9PUIAcME72sGIGXFx5WtI
	G2LSoeSf7eozi+IslWQgZ5IGSWjfqcSjyFTaIAqN64RfXPMokboXzeiKa697YNOpVSYYmeYvDOz
	E/fnJFtjk5ukfsjuViTCRud3c4DZMy/EvRoTtxLT4Yfk34hi9Vnje23tgyfKHbgHL2GzRVZ9aP1
	mZ615XwawhIr1WUgS4oNEbvKTAAaIEniRo7PtE4OQ3e6vKIcGXYjDfUNstgybPgXTsFEN/8rxMp
	rnqu9AEnb378vkdyMhvzAkExSw==
X-Google-Smtp-Source: AGHT+IEzSLe65JNx1MgYtsAsopPK0EfMwhr1yvpBsd8ooeI9a2lTzHS3vxfGOWT1xlV8dk7Qf8MQ7Q+DtD1T+irQFCY=
X-Received: by 2002:a17:902:ea0b:b0:266:b8a2:f5d8 with SMTP id
 d9443c01a7336-294ee44e6fcmr5735855ad.14.1761839870754; Thu, 30 Oct 2025
 08:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <09943f4f-516c-4b93-877c-e4a64ed61d38@linux.ibm.com>
 <79195870-7223-4aeb-beb4-a7d8f1895caa@linux.ibm.com> <CAP-5=fXi=EDU7-tdNLwTKbCHR80_p3=TAe0qF0oE-tXbx35znw@mail.gmail.com>
 <13800bed-1256-4414-ac8b-e99439c748ec@linux.ibm.com> <3b86c7e0-5b3e-468c-8077-7efa3959d221@linux.ibm.com>
 <02841ee0-d0b2-48a8-b523-7bcc561ad64f@linux.ibm.com>
In-Reply-To: <02841ee0-d0b2-48a8-b523-7bcc561ad64f@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 30 Oct 2025 08:57:38 -0700
X-Gm-Features: AWmQ_bkKkyK-bkRvwhTHK34fyf8leWOHX4QkamVYjbtsirTDYLnt2thj3bz2dV8
Message-ID: <CAP-5=fUKaX0b5b3QYarL9qUK4Z=u0zpKnB9XVm-_bOKap7sJag@mail.gmail.com>
Subject: Re: [linux-next] perf report runtime extremely long
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Jan Polensky <japo@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 7:27=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> On 10/30/25 14:25, Thomas Richter wrote:
> > On 10/30/25 09:59, Thomas Richter wrote:
> > This is the first bad commit.... (I actually tested it :-(, obviously w=
ithout -D option )
> >
> > commit 0012e0fa221bf9cc54aa6a0e94d848653dc781bb (HEAD)
> > Author: Ian Rogers <irogers@google.com>
> > Date:   Sun Oct 5 11:24:16 2025 -0700
> >
> >     perf jevents: Add legacy-hardware and legacy-cache json
> >
> >     The legacy-hardware.json is added containing hardware events simila=
rly
> >     to the software.json file. A difference is that for the software PM=
U
> >     the name is known and matches sysfs. In the legacy-hardware.json no
> >     Unit/PMU is specified for the events meaning default_core is used a=
nd
> >     the events will appear for all core PMUs.
> >     ......
> >
> > What puzzles me is that the above patch does not change anything in
> > util/s390-sample-raw.c which handles s390 specific sample interpretatio=
n.
> >
> > Maybe that patch affects perf_pmus__find()?
> > Not sure how to proceed.
> >
> > Thanks a lot
>
> Ian,
>
> the issue is within function perf_pmu__for_each_event().
> Without calling this function the output is as fast as before.
> (Well a bit faster, because I replaced this call by strdup("hardcoded-nam=
e");)
>
> I have looked at this code, but I did not understand a thing....
> Strange, perf_pmu__for_each_event() did not change in this commit,
> but the behavior changed a lot.
>
> What we need for s390 is some way of faster event name lookup,
> the PMU is known, its "cpum_cf". Is there no easy way to
> find the events on this PMU (given the event number).
>
> Maybe a some sort of table, because this lookup is done
> millions of times on a large file with samples including raw data
>
> Ideas?

Thanks Thomas!

The bisect and the behavior make sense now. Previously the legacy
events weren't part of perf_pmu__for_each_event and now with the
legacy-hardware.json they are. The events were parsed by matching
explicitly in the parse-events.l lex parser, but for lots of reasons
the json is better. Anyway, there is common functionality for
reversing a perf_event_attr.config to an event name in
perf_pmu__name_from_config:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/pmu.h?h=3Dperf-tools-next#n306
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/pmu.c?h=3Dperf-tools-next#n2728

The normal case for a PMU is that we want to see if it has an event by
name, so we have a hashmap from name to the "alias" information (I
don't really like the name "alias", it is information about an event
we want to encode):
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/pmu.c?h=3Dperf-tools-next#n58

The use-case for perf_pmu__name_from_config is generally debug output,
so there isn't a fast path config to name lookup. Is config to name
lookup sufficient in s390-sample-raw.c? I notice that the code is
matching the "event=3D" part of the encoding, which is a sub-part of the
config (and may actually be a value in config2 or config3).

I wonder if it would be easier to add a cache of matched names in
s390-sample-raw.c? So a global/static hashmap in that C file with a
key of set and nr as per get_counter_name (it seems the PMU can be
implied to always only be the core PMU) and a value of a strdup-ed
counter name.

Let me know what you think and I can send you a patch if you like.

Thanks,
Ian
