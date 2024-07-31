Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D33182D8
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722457221; cv=none; b=fOa6KKhzntFA9YI1RntTUf8tkj5yR6C3lbQWFOricQBy4ND5Ue2VjeYCr63LY+WoGc3JdYU7BlIHpopqsnZjkrS4pclmOM0CC5OG2nVDlk0IZ9IzfVRWFmHgtVWA2ldGNouUjFuY03pDx5WvWYb1O6T71PhS5lV3R6XWqMPsEq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722457221; c=relaxed/simple;
	bh=2aiuv61kpXlZ+Kq1VOGf1QXgctN6J+8y82lmazM+Ab0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7+w2W5UsPvJyq2QfREZ3YnDtb9HEeb/fmWqzEmiAoqdLKac/XyWg17YxrD59hcHvbk171b5++Is2rpwmv3j16Qhtx7aAapBygRhItMOutgFaEuOK2Mglot8UJbYlaxXOv3x1agN+LveZ5yzsfxJg/BxQaY+4pw6qRUVgjzmSTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VBWRqU2P; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VBWRqU2P"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd657c9199so255365ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 13:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722457219; x=1723062019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=malZ2EoQLdWxUs/KXch6e9xeSrSPCikfYMF4yS/eV70=;
        b=VBWRqU2PGrlmWtDfwnzb5/UdxO2imN6r2hs/+eg6U9dWP6hfHj4N+bVTc5BLy4heyX
         RmxA01kJMncqaOpc+EbcjiWD0PUiHX27qQ/OUGEftLxojAHO/cPcrpzwdE+l3bTUUDwH
         c4SyzKGCQsi4f0VdWE/g2Q/aKWeu0MpjR8xcHWi486jiLGK3WbOGEuFtqocuDHMCne5E
         CgPuNvHCJvWo+TJcnLbB2p+lZohjhaaPd0JXibDaW7CAFIAeT1dV8e3YGijK6EfNEM0N
         GgLobQzflZOs4ip5PlaNkhM6b57tvBSiXZPIT7+B7Syc3QG4Xk2X3635EMPc/qBdaJUf
         IiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722457219; x=1723062019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=malZ2EoQLdWxUs/KXch6e9xeSrSPCikfYMF4yS/eV70=;
        b=E3UMCNY3HbAD8QaQGzZnqm2dhUAmgOUFRZh0vomka6hC+W4dRP0KrgKvjaTUvKLgbe
         vznQr9qLkKCT+FqQdr5cEufRLb3miF67Ck904KcfvQGQckWNKO7kOLd6ehN+tpL6Mw+Y
         Y13S89m0U3j5XTHy6dd65QUN6aBDCEQ4wuFSH2qR4R9MOcat2gOeilOxY/Pmxby9pfu/
         Adrzwr5W7fwSQuzWXg/FdZR/PebsG5KGoRZzihIOjBzx1fQuv8q5K1Sbe1+U2VLbMuln
         h4PeBYHMd6gtFbBYsKuGa1HvVu4gXBNO+cOA0NGB2GBI0LLGUiyzA4ZksxPL2UeKAm5U
         Xhiw==
X-Forwarded-Encrypted: i=1; AJvYcCVectZhaJ+ZrpoIUxH/Y7gUMCv2RjIsc0hP56dmEBZoSdSMHokrlKNqDIQnUsM34xKsPS2q591XtTgSmbCXJsbuNf2AEZXHJ3q7ZqdZB1pNZw==
X-Gm-Message-State: AOJu0YznvdIkrxq9CQHy59oR6a8EiwUllczPHR2IauDirvGDu6BNrQEc
	qDASqG4/s4cRDL6tUqqA4IJElz8vWnIcZ3rnRJYq6dNNLBaPpyQnszdGlmBMntY+2OOJtLTJ01+
	JEkl1N/o/T+hsgCglc/i/gLALFcLNk39q8/cX
X-Google-Smtp-Source: AGHT+IE0rH9FW364UxJBG0bFVTmvAYSBlq9OGq19o5QlQqjKh+sQqachxIPgLtLDfS4O+MEniegoo4G4/jHMYbR1lfA=
X-Received: by 2002:a17:902:e493:b0:1fe:d7da:cd22 with SMTP id
 d9443c01a7336-1ff426a0685mr4001915ad.29.1722457219021; Wed, 31 Jul 2024
 13:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730191744.3097329-1-irogers@google.com> <20240730191744.3097329-3-irogers@google.com>
 <Zqo5vVdrkhL5NHJK@x1> <CAP-5=fXyOfPya+TrKVaFhCK3rNY=AuLZLG67ith5YHf_XXVdNg@mail.gmail.com>
 <ZqpZWywTe2j3U9Pl@x1> <ZqpcRIzzBb5KC6Zb@x1> <CAP-5=fVm5FkLDOLk4cbD9K6VPZ088f3Yk3bG8LT79E_OLLN4Lw@mail.gmail.com>
 <ZqqIEckIXQEAd9xr@x1>
In-Reply-To: <ZqqIEckIXQEAd9xr@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 31 Jul 2024 13:20:06 -0700
Message-ID: <CAP-5=fV8S0z=Fn+aoq4SxatBeeJ5MEUL02km_6+enqWaaW2qQA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf jevents: Autogenerate empty-pmu-events.c
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, philip.li@intel.com, oliver.sang@intel.com, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:53=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Jul 31, 2024 at 08:58:43AM -0700, Ian Rogers wrote:
> > On Wed, Jul 31, 2024 at 8:46=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Wed, Jul 31, 2024 at 12:33:50PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > On Wed, Jul 31, 2024 at 07:08:18AM -0700, Ian Rogers wrote:
> > > > > On Wed, Jul 31, 2024 at 6:18=E2=80=AFAM Arnaldo Carvalho de Melo
> > > > > <acme@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, Jul 30, 2024 at 12:17:44PM -0700, Ian Rogers wrote:
> > > > > > > empty-pmu-events.c exists so that builds may occur without py=
thon
> > > > > > > being installed on a system. Manually updating empty-pmu-even=
ts.c to
> > > > > > > be in sync with jevents.py is a pain, let's use jevents.py to=
 generate
> > > > > > > empty-pmu-events.c.
> > > > > >
> > > > > > What am I missing here?
> > > > > >
> > > > > > If it exists so that we can build on a system without python ho=
w can we
> > > > > > use python to generate it?
> > > > > >
> > > > > > Now having python in the system is a requirement and thus we do=
n't need
> > > > > > empty-pmu-events.c anymore?
> > > > > >
> > > > > > Can you guys please clarify that?
> > > > >
> > > > > The requirement for python hasn't changed.
> > > > >
> > > > > Case 1: no python or NO_JEVENTS=3D1
> > > > > Build happens using empty-pmu-events.c that is checked in, no pyt=
hon
> > > > > is required.
> > > > >
> > > > > Case 2: python
> > > > > pmu-events.c is created by jevents.py (requiring python) and then=
 built.
> > > > > This change adds a step where the empty-pmu-events.c is created u=
sing
> > > > > jevents.py and that file is diffed against the checked in version=
.
> > > > > This stops the checked in empty-pmu-events.c diverging if changes=
 are
> > > > > made to jevents.py. If the diff causes the build to fail then you=
 just
> > > > > copy the diff empty-pmu-events.c over the checked in one.
> > > >
> > > > I'll try and add your explanation to the log message, thanks for
> > > > clarifying it!
> > >
> > > So, with it in place I'm now noticing:
> > >
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$ rm -rf /tmp/build/$(basename=
 $PWD)/ ; mkdir -p /tmp/build/$(basename $PWD)/
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$ alias m=3D'rm -rf ~/libexec/=
perf-core/ ; make -k CORESIGHT=3D1 O=3D/tmp/build/$(basename $PWD)/ -C tool=
s/perf install-bin && perf test python'
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$ m
> > > <SNIP>
> > >   GEN     /tmp/build/perf-tools-next/pmu-events/test-empty-pmu-events=
.c
> > >   MKDIR   /tmp/build/perf-tools-next/arch/x86/util/
> > >   CC      /tmp/build/perf-tools-next/util/annotate.o
> > >   CC      /tmp/build/perf-tools-next/arch/x86/util/tsc.o
> > >   CC      /tmp/build/perf-tools-next/arch/x86/tests/hybrid.o
> > >   CC      /tmp/build/perf-tools-next/util/block-info.o
> > >   CC      /tmp/build/perf-tools-next/arch/x86/tests/intel-pt-test.o
> > >   CC      /tmp/build/perf-tools-next/arch/x86/util/pmu.o
> > >   MKDIR   /tmp/build/perf-tools-next/ui/browsers/
> > >   CC      /tmp/build/perf-tools-next/ui/browsers/annotate.o
> > >   CC      /tmp/build/perf-tools-next/builtin-kallsyms.o
> > >   CC      /tmp/build/perf-tools-next/util/block-range.o
> > >   TEST    /tmp/build/perf-tools-next/pmu-events/empty-pmu-events.log
> > > --- pmu-events/empty-pmu-events.c       2024-07-31 12:44:14.355042296=
 -0300
> > > +++ /tmp/build/perf-tools-next/pmu-events/test-empty-pmu-events.c    =
   2024-07-31 12:45:35.048682785 -0300
> > > @@ -380,7 +380,7 @@
> > >                          continue;
> > >
> > >                  ret =3D pmu_events_table__for_each_event_pmu(table, =
table_pmu, fn, data);
> > > -                if (pmu || ret)
> > > +                if (ret)
> >
> > Right, you need to copy:
> >  /tmp/build/perf-tools-next/pmu-events/test-empty-pmu-events.c
> > to
> > tools/perf/pmu-events/empty-pmu-events.c
> > to fix this.
> >
> > This change has happened as you are testing with:
> > https://lore.kernel.org/lkml/20240716132951.1748662-1-kan.liang@linux.i=
ntel.com/
> > which isn't in the git repo yet (therefore, I can't make a patch set
> > on it). The change is WAI as it is telling you empty-pmu-events.c has
> > become stale and needs Kan's fix applying to it.
>
> ok, I'll remove Kan's patch, publish perf-tools-next and wait for the
> now normal flow of patches.

I can resend Kan's patch with the empty-pmu-events.c fix applied. I
don't see the changes in tmp.perf-tools-next so I can do it with
cherry picks.

Thanks,
Ian
