Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0CF1411C5;
	Fri, 17 May 2024 21:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715981303; cv=none; b=CCeI+WSx6HZkkr33OPgwG11Fd0lsI8Q26TXezakvNDcTtCGiBwfZgj/IQ9YAm6uRnX0q2JpO+L/n2fowepxMo6ofIhNBq8xELJI/15i7zDP3ItbTWRN5O3a5Jy+u7glRAxJJv4by8McAi1r4pTTNWMiinGyzYLfcwnftVv9yWhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715981303; c=relaxed/simple;
	bh=2/1Z6La3GNXkf3zPRo98vJce5KtxCGxzXJSBIYIU8to=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teojMCZlWOH+nr+Tey2Dx9ITqhraf4f333Rkzp8toAMQ3oA9+uQY8asTYu4+BMWH/EkJr7BTG4+AwPlqsJHeTVroaAaFyfUxXXj4kPmrtkqTVqhFHbxpv2zR/m+TGdw3CCjIfC+4LYGaNfOF9gEgmdV4v8XfFW155tWcuX5gdew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-65be7c29cb1so475796a12.0;
        Fri, 17 May 2024 14:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715981300; x=1716586100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRzy4hL4fyShMQGv5CBrSOTOZvBLaIJhDWW4SFAhiug=;
        b=e1EOijwCLMuNeq4pyA3gRlpXBufX5fMn71FTl+PH2Ch7Tz1aj7cT5x9jb85MZmzDt2
         lf8L9SV0n5et2vx7mPB26JPwX7EfAX7YE5Ds5Vco8pZDI/ndv112GIqK0TjQIVVN+GKf
         xlMFcq2PYzeJ7ES7Qu8pWkVvCORi2B62xRxVjLsa/C5WVxG6dPq31qPLRP4l7C+PEK+V
         AowyiAwzZ0l7UnfwE8CVFWjjjRr/UxjKtkfVPs1hjnQZLZEYZxnzptCxaKtyrdQdTL01
         FZ3xRcABahgPqD4vb2wHocbQLePWVAvqpBDudU1MaJT1TeVr1Z9+jhLOFnA6FcTgf69U
         EKZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW980GRx9yDyzIxS3SacaM8FMBVhRAPlhB2FvMJMARtJTdLGkxP/BFazChsQ0GpQr7XTAWSTMg7EXznr/CyFRXAb8Uqorj7GkevB6c1Jj5Jt8tjx80pLkK2ZiHMfXQRRto504Sfa7H/6opYmSszLQ==
X-Gm-Message-State: AOJu0YzvSibVgwNbjw9utd65h9UX72iJxIKU9h8BbR5YR4G7h9llCwbm
	tBPVCHWMhD+/B7+y8FCfPQrHkV7fptI9ZgRDVWs1RhA0pTNbAaDT6XL6tW9IP0uJbevrINcuRYv
	MECLo1qCtKVr5CJFiYBEaRmyGSHI=
X-Google-Smtp-Source: AGHT+IEah9LeDDgNXL7VUOsZL8Rq1J0nZ6ecDOuiJAgKzrzpDRqWSsAKf3MWXfjRY/OuLICbWQmaa5eb1vZdRsvyIe0=
X-Received: by 2002:a17:90a:b388:b0:2b9:fc72:547e with SMTP id
 98e67ed59e1d1-2bd603e3232mr392834a91.18.1715981300510; Fri, 17 May 2024
 14:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515054443.2824147-1-weilin.wang@intel.com>
 <20240515054443.2824147-2-weilin.wang@intel.com> <CAP-5=fVJmJ0MapzadOcBfQj69FKhaFA9YtonMy4W7kUfDSXS9Q@mail.gmail.com>
 <CO6PR11MB5635F7C3C6928C2F3E5D732FEEED2@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB5635F7C3C6928C2F3E5D732FEEED2@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 17 May 2024 14:28:09 -0700
Message-ID: <CAM9d7cj5kc3RVpn9uffojkHuBb6Ui4HeRWB9WC6CKPSJhJtf0A@mail.gmail.com>
Subject: Re: [RFC PATCH v8 1/7] perf Document: Add TPEBS to Documents
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb" <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, May 16, 2024 at 10:37=E2=80=AFAM Wang, Weilin <weilin.wang@intel.co=
m> wrote:
>
>
>
> > -----Original Message-----
> > From: Ian Rogers <irogers@google.com>
> > Sent: Thursday, May 16, 2024 9:11 AM
> > To: Wang, Weilin <weilin.wang@intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>; Arnaldo Carvalho de Melo
> > <acme@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> > <mingo@redhat.com>; Alexander Shishkin
> > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; Hun=
ter,
> > Adrian <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.com>=
;
> > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylor,=
 Perry
> > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>; Bigge=
rs,
> > Caleb <caleb.biggers@intel.com>
> > Subject: Re: [RFC PATCH v8 1/7] perf Document: Add TPEBS to Documents
> >
> > On Tue, May 14, 2024 at 10:44=E2=80=AFPM <weilin.wang@intel.com> wrote:
> > >
> > > From: Weilin Wang <weilin.wang@intel.com>
> > >
> > > TPEBS is a new feature in next generation of Intel PMU. It will be us=
ed in new
> > > TMA releases. Adding related introduction to documents while adding n=
ew
> > code to
> > > support it in perf stat.
> > >
> > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > > ---
> > >  tools/perf/Documentation/perf-list.txt |  1 +
> > >  tools/perf/Documentation/topdown.txt   | 18 ++++++++++++++++++
> > >  2 files changed, 19 insertions(+)
> > >
> > > diff --git a/tools/perf/Documentation/perf-list.txt
> > b/tools/perf/Documentation/perf-list.txt
> > > index 6bf2468f59d3..dea005410ec0 100644
> > > --- a/tools/perf/Documentation/perf-list.txt
> > > +++ b/tools/perf/Documentation/perf-list.txt
> > > @@ -72,6 +72,7 @@ counted. The following modifiers exist:
> > >   W - group is weak and will fallback to non-group if not schedulable=
,
> > >   e - group or event are exclusive and do not share the PMU
> > >   b - use BPF aggregration (see perf stat --bpf-counters)
> > > + R - retire latency value of the event
> > >
> > >  The 'p' modifier can be used for specifying how precise the instruct=
ion
> > >  address should be. The 'p' modifier can be specified multiple times:
> > > diff --git a/tools/perf/Documentation/topdown.txt
> > b/tools/perf/Documentation/topdown.txt
> > > index ae0aee86844f..e6c4424e8bf2 100644
> > > --- a/tools/perf/Documentation/topdown.txt
> > > +++ b/tools/perf/Documentation/topdown.txt
> > > @@ -325,6 +325,24 @@ other four level 2 metrics by subtracting
> > corresponding metrics as below.
> > >      Fetch_Bandwidth =3D Frontend_Bound - Fetch_Latency
> > >      Core_Bound =3D Backend_Bound - Memory_Bound
> > >
> > > +TPEBS in TopDown
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +TPEBS is one of the features provided by the next generation of Inte=
l PMU.
> > The
> >
> > As this documentation will live a while "next generation" could become
> > ambiguous. I think it would be better to mention core ultra or some
> > other term to more specifically describe which PMUs have TPEBS.
>
> Hi Ian,
>
> Yes, you are right, I will update it.

Also I'd be nice if you can tell what 'T' means in TPEBS. :)

> >
> > > +TPEBS feature adds a 16 bit retire latency field in the Basic Info g=
roup of the
> > > +PEBS record. It records the Core cycles since the retirement of the =
previous
> > > +instruction to the retirement of current instruction. Please refer t=
o Section
> > > +8.4.1 of "Intel=C2=AE Architecture Instruction Set Extensions Progra=
mming
> > Reference"
> > > +for more details about this feature.
> >
> > Perhaps capture that this is placed in the perf event sample in the
> > weights section as TPEBS isn't exposed except within the kernel PMU
> > driver.
> >
> > > +
> > > +In the most recent release of TMA, the metrics begin to use event
> > retire_latency
> > > +values in some of the metrics=E2=80=99 formulas on processors that s=
upport TPEBS
> > feature.
> > > +For previous generations that do not support TPEBS, the values are s=
tatic
> > and
> > > +predefined per processor family by the hardware architects. Due to t=
he
> > diversity
> > > +of workloads in execution environments, retire latency values measur=
ed at
> > real
> > > +time are more accurate. Therefore, new TMA metrics that use TPEBS wi=
ll
> > provide
> > > +more accurate performance analysis results.
> >
> > Do you want to capture what the value will be when there hasn't been a
> > sample? This corner case could be considered broken in the new
> > approach.
>
>
> When there is no sample, we should expect it to be 0 or use default value=
. I will
> add this information here. I don=E2=80=99t think this is broken from the =
approach's perspective.
> We do need to add code to return this value when there is no sample.

More importantly, I think the documentation should say that the
retire_latency is in PEBS which means it needs samples in the
precise events.  So it would run perf record in the background
for events with retire_latency even if users just want to see the
value of counters or metric in perf stat.

Thanks,
Namhyung
