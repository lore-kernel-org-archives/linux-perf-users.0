Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16431094E;
	Fri, 12 Jul 2024 03:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720755382; cv=none; b=dorrfQhdOu36ZCxmktQVCybeG2a+PmJ3TT06NO5rsiTW2GLlLjxcL6/K2ixH7ClZ5UbOPcqFta6hpIgU51JyWjVLBV6n4/u1KN0hVbXBgG/H801olcimhF2GyK7jeGYGKhnxAYPomsjWwgjXiB5YMMC1Tnvq8qxqy6EjoPgIZmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720755382; c=relaxed/simple;
	bh=BTJ2cZncawS4tqR8I2MTnQpwo+tkcqaRSSX+MM2U64w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HC7w2exHhFkfO0jEibKn4TeaXZ8nlsB147U0u+t91k0dM3uLZi09bIwZ+BOwnfKXaxwTWJmj/9zXbJ0QhWw5rK0TpmwK+C9IeqpRWiPH7XXhanXXMVV7kxTKs9R4HohG0BfUqdUY+5TIFhQbgkjaTyOBVaO8orOg1/7hstnpL5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-75fe9e62048so1020406a12.0;
        Thu, 11 Jul 2024 20:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720755380; x=1721360180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLgTqSjRR6bZolbavREdZi3jC/l5jD46pdlsf/aPCyw=;
        b=jT7f3e6ewrwzuwZWBLqNU4LZSBAnHUcfFx5luKrOpjDcbBffiNG8vXWQZlLWBid2V+
         yW8sRIX/f/B9J1FgndfQRxqwgaBngHAeZAA2pp0SLV8zZloC4el5EjgUQDog/e7VlrfS
         MCCKZ1v3tUpVLB4536DIb221gK/HLSNuxnS6C4nC3QRCSfHZNkV94e7GDwqE/wYnAyil
         vLziIvsuz7JaScdPMNxnI7nWbuFSdeI6wlt2vSDIXWaFoXnzpZrwQQid392F2aHh89Aj
         YKdg/CbmYi9pFLR0s1G1siBvwNoyNj9+qH4Sv4lofa+y6EncLoDybWCxMm366h8bF0Q+
         Xz0g==
X-Forwarded-Encrypted: i=1; AJvYcCUg9njNTq/0V/Llo9d4SHXWKSW68zcb6FscCR7c+a4oxy52sCZBOJhoHi7i7GixG7FD3lFa1t5XnpTeEX/bDrZFgSxWytgeQzRLCB1/IzdIfO19OULSm87DFmAdpMH6MpPhnl60ds759x71qkrGzw==
X-Gm-Message-State: AOJu0YyjmAmFNLdHoYmUuKABojsfbz/6TLnO/XNEKJG8UBzQxbtFovtU
	HeqkdPHpSyUSeGk2ZGXoA5Npkf5IaRlPR8nnvMUyKwaLGR8t9eHsu3LLGMWBY3eiTKqhWcMXEYz
	OmpfjgBQRpaJLOb7BRIgRswn3Efo=
X-Google-Smtp-Source: AGHT+IHGRMUwgH3mYziYbxIXHOosb/n6iJ/naP+S7UMSV5A5ozAIQE9lrrGbXIB3/vBFxRuapdX+jLcuBGQdDgggXZY=
X-Received: by 2002:a05:6a20:7484:b0:1c2:8d0a:8e9d with SMTP id
 adf61e73a8af0-1c29820b872mr12042363637.7.1720755380020; Thu, 11 Jul 2024
 20:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706232956.304944-1-weilin.wang@intel.com>
 <20240706232956.304944-9-weilin.wang@intel.com> <CAM9d7chhVAG9wpWdQM4DRriM_kp9vjFj=_ak1+0qyO-sRdXs4w@mail.gmail.com>
 <CO6PR11MB563567A7804F50AD5AA1F708EEDB2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cgrX=hL_Y16ZrPr6NOsd2ApOWdDP2bWDSNcK2yp4Skn3A@mail.gmail.com>
 <CO6PR11MB5635F6A59A405ED9CB63B8B0EEDB2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <ZpBSbjF3QP81_637@google.com> <CO6PR11MB563585C578FD91FD762946A7EEA52@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB563585C578FD91FD762946A7EEA52@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 11 Jul 2024 20:36:08 -0700
Message-ID: <CAM9d7cgU4XNTo0-jvOTyHkZ+st1xtozCXkAvoFKC3ifKHZq=vQ@mail.gmail.com>
Subject: Re: [RFC PATCH v16 8/8] perf test: Add test for Intel TPEBS counting mode
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

On Thu, Jul 11, 2024 at 3:05=E2=80=AFPM Wang, Weilin <weilin.wang@intel.com=
> wrote:
>
>
>
> > -----Original Message-----
> > From: Namhyung Kim <namhyung@kernel.org>
> > Sent: Thursday, July 11, 2024 2:45 PM
> > To: Wang, Weilin <weilin.wang@intel.com>
> > Cc: Ian Rogers <irogers@google.com>; Arnaldo Carvalho de Melo
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
> > Subject: Re: [RFC PATCH v16 8/8] perf test: Add test for Intel TPEBS co=
unting
> > mode
> >
> > Hello,
> >
> > On Tue, Jul 09, 2024 at 06:23:51AM +0000, Wang, Weilin wrote:
> > > > On Mon, Jul 8, 2024 at 9:58=E2=80=AFPM Wang, Weilin <weilin.wang@in=
tel.com>
> > > > wrote:
> > > > >
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Namhyung Kim <namhyung@kernel.org>
> > > > > > Sent: Monday, July 8, 2024 9:44 PM
> > > > > > To: Wang, Weilin <weilin.wang@intel.com>
> > > > > > Cc: Ian Rogers <irogers@google.com>; Arnaldo Carvalho de Melo
> > > > > > <acme@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Ingo
> > Molnar
> > > > > > <mingo@redhat.com>; Alexander Shishkin
> > > > > > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.o=
rg>;
> > Hunter,
> > > > > > Adrian <adrian.hunter@intel.com>; Kan Liang
> > <kan.liang@linux.intel.com>;
> > > > > > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org;=
 Taylor,
> > > > Perry
> > > > > > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com=
>;
> > > > Biggers,
> > > > > > Caleb <caleb.biggers@intel.com>
> > > > > > Subject: Re: [RFC PATCH v16 8/8] perf test: Add test for Intel =
TPEBS
> > > > counting
> > > > > > mode
> > > > > >
> > > > > > Hello Weilin,
> > > > > >
> > > > > > On Sat, Jul 6, 2024 at 4:30=E2=80=AFPM <weilin.wang@intel.com> =
wrote:
> > > > > > >
> > > > > > > From: Weilin Wang <weilin.wang@intel.com>
> > > > > > >
> > > > > > > Intel TPEBS sampling mode is supported through perf record. T=
he
> > > > counting
> > > > > > mode
> > > > > > > code uses perf record to capture retire_latency value and use=
 it in
> > metric
> > > > > > > calculation. This test checks the counting mode code.
> > > > > > >
> > > > > > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > > > > > > ---
> > > > > > >  .../perf/tests/shell/test_stat_intel_tpebs.sh  | 18
> > > > ++++++++++++++++++
> > > > > > >  1 file changed, 18 insertions(+)
> > > > > > >  create mode 100755 tools/perf/tests/shell/test_stat_intel_tp=
ebs.sh
> > > > > > >
> > > > > > > diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > > > > > b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > > > > > > new file mode 100755
> > > > > > > index 000000000000..fea8cb1b8367
> > > > > > > --- /dev/null
> > > > > > > +++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > > > > > > @@ -0,0 +1,18 @@
> > > > > > > +#!/bin/bash
> > > > > > > +# test Intel TPEBS counting mode
> > > > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > > > +
> > > > > > > +set -e
> > > > > > > +
> > > > > > > +# Use this event for testing because it should exist in all =
platforms
> > > > > > > +event=3Dcache-misses:R
> > > > > > > +
> > > > > > > +# Without this cmd option, default value or zero is returned
> > > > > > > +echo "Testing without --record-tpebs"
> > > > > > > +result=3D$(perf stat -e "$event" true 2>&1)
> > > > > > > +[[ "$result" =3D~ $event ]] || exit 1
> > > > > > > +
> > > > > > > +# In platforms that do not support TPEBS, it should execute =
without
> > > > error.
> > > > > > > +echo "Testing with --record-tpebs"
> > > > > > > +result=3D$(perf stat -e "$event" --record-tpebs -a sleep 0.0=
1 2>&1)
> > > > > >
> > > > > > It never finishes on my AMD machine.
> > > > > >
> > > > > Hi Namhyung,
> > > > >
> > > > > Do you see any message while it executes? Is the perf record fork=
ed
> > > > successfully
> > > > > but failed to return?
> > > >
> > > > I don't know.. all I can get is like below:
> > > >
> > > > $ sudo ./perf test tpebs -vv
> > > > 121: test Intel TPEBS counting mode:
> > > > --- start ---
> > > > test child forked, pid 583475
> > > > Testing without --record-tpebs
> > > > Testing with --record-tpebs
> > > > ^C
> > >
> > > I think the problem is that the forked "perf record" encountered erro=
r, which
> > > caused the control fifo failed to send a "ACK" back and the PIPE hang=
ed.
> > >
> > > Could you please try out the diff below and see if the test would fin=
ish?
> > >
> > > As for the "perf record" error, I think it might because of the fake
> > > event(cache-misses:R) cannot be supported in AMD. Could you please te=
st
> > run
> > > a "perf stat -e cache-misses:R --record-tpebs true" and see if it com=
plains
> > about
> > > the event?
> >
> > So I tried the below patch and it worked.
> >
> >   $ ./perf test -v tpebs
> >   121: test Intel TPEBS counting mode:
> >   --- start ---
> >   test child forked, pid 2190174
> >   Testing without --record-tpebs
> >   Testing with --record-tpebs
> >   ---- end(-1) ----
> >   121: test Intel TPEBS counting mode                                  =
: FAILED!
> >
> > It would be better if it can skip rather than fail on
> > non-supported machines.
> >
>
> Yes, I could add a check to only run the test on Intel platform.

Please do so.

>
> > Also I saw this message when I run the command manually.
> >
> >   $ ./perf stat -e cache-misses:R --record-tpebs -v true
> >   Control descriptor is not initialized
> >   Retire_latency of event cache-misses:R is required
> >   Prepare perf record for retire_latency
> >   Error:
> >   The cache-misses:pu event is not supported.
> >   incompatible file format
> >   incompatible file format (rerun with -v to learn more)
> >   failed: did not received an ack
> >   cache-misses:R: 0 1 1
> >
> >    Performance counter stats for 'true':
> >
> >                    0      cache-misses:R
> >
> >          0.000004939 seconds time elapsed
> >
> >          0.000000000 seconds user
> >          0.000000000 seconds sys
> >
> > I'm not sure why it showed the incompatible file format message.
> >
>
> The output matches with my expectation. I think the incompatible file for=
mat
> message is from the session open step of the sample reader thread.
>
> Because AMD CPU does not support cache-misses:p in "perf record", the con=
trol
> fifo does not receive a "ACK" message back from "perf record". Therefore,=
 the
> ack_fd PIPE hanged and the test never ends.
>
> However, the sample reader thread opens the session in parallel. Because =
the
> "perf record" is not successfully started, the sample data PIPE is not re=
ady and we
> get this incompatible file format error.

It'd be great if we can suppress the message.

>
> > >
> > > diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tp=
ebs.c
> > > index a0585a6571b5..5b8e104f36f1 100644
> > > --- a/tools/perf/util/intel-tpebs.c
> > > +++ b/tools/perf/util/intel-tpebs.c
> > > @@ -263,6 +263,7 @@ int tpebs_start(struct evlist *evsel_list)
> > >         }
> > >
> > >         if (tpebs_event_size > 0) {
> > > +               struct pollfd pollfd =3D { .events =3D POLLIN, };
> > >                 int control_fd[2], ack_fd[2], len;
> > >                 char ack_buf[8];
> > >
> > > @@ -297,6 +298,19 @@ int tpebs_start(struct evlist *evsel_list)
> > >                         goto out;
> > >                 }
> > >
> > > +               /* wait for an ack */
> > > +               pollfd.fd =3D ack_fd[0];
> > > +
> > > +               if (!poll(&pollfd, 1, 2000)) {
> >
> > Is it 2 seconds?  Any specific reason for the value?
> > At least we need a comment to explain the value (or just saying it's a
> > random one).
>
> It's important to have this poll. But the time is random. Please let me k=
now if you have
> any suggestions on the value. Otherwise, I could add a comment  saying th=
is is a random
> value.

I don't have a better idea, a comment would be ok.

> >
> >
> > > +                       pr_err("failed: perf record ack timeout\n");

Can you please prefix the message with "tpebs:"?

> > > +                       goto out;
> > > +               }
> > > +
> > > +               if (!(pollfd.revents & POLLIN)) {
> > > +                       pr_err("failed: did not received an ack\n");

Ditto.

Thanks,
Namhyung


> > > +                       goto out;
> > > +               }
> > > +
> > >                 ret =3D read(ack_fd[0], ack_buf, sizeof(ack_buf));
> > >                 if (ret > 0)
> > >                         ret =3D strcmp(ack_buf, "ack\n");
> > >
> > > Thanks,
> > > Weilin
