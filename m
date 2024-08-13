Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8EE1A38C9
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723571315; cv=none; b=rIqDGKDu1bXY2IdvCMRupJYT2oz7PC7GVFe/yjNYcr91lrRwBmjBmsRLbAMDzacThVGGHMaZ7OgoeCe4Eem7ROEgGJo8zDT3Y2zGx+yTohBlykJqpV34dH4V3QDRNrN11VQqWk7L5wwJAc1oLSzLF03FCSZt3FE916fwdQEtf7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723571315; c=relaxed/simple;
	bh=7LTLpYvjxQO11++OTdeohDmTJftGaAwdMumORa2jNLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMQcqREemWiJteZA8DGmvcb3zDxRDPE2ZAL9zj0xb7ZTt5C5aN0fCG/UafUZMK0YcJwq/LVw/BG99M4141MQ+aO+miM4HV1zzl7GTawem1oJupBAKOvrf4dEdBLfqCI8P7af4V36rcGeUrJAL+ggE2dDZLaHawT0FwrYeMayM5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wf3xHxJs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wf3xHxJs"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-200aa53d6d2so7185ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 10:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723571313; x=1724176113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NE8JsUcsraKesVbSocaVMLwvHpivijJ1sGLGErbbsc=;
        b=Wf3xHxJs6QX6Ubun9sqVX1AWgL7vd/OOtI4zbll91PNiXhbfFg7INnmBJNAAv0fmMY
         Rz+2GoLpfyo8tJimxppbH6mJCYrrGJPoglbBmZ9CA6WvrvUXZ2oYRMdXskrUR8ECt2/n
         t7bjJ+eRRLNuHNY7ccAGytWVwP9qpxYSHlHD3fp8fLcNwZWDLkV6Cf9KP9d7t1Q5JV6P
         idTwscLQn/q7JOYvFEIyk7BUoXp062sFk0IcvxvIhJwXlWJo/5vDWnvp3deWcXwfPP9P
         qyUqRm8lLk6d5rrctGngM2xWokVGzuFB8Bmzg+hR5+OFurZJezu9BsUjduNTZBOr0UFo
         xS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723571313; x=1724176113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NE8JsUcsraKesVbSocaVMLwvHpivijJ1sGLGErbbsc=;
        b=QfMWeCwGv/FCfLg3FiyefEBkUCbzZhV9MFZo8laOVph3FDqiPdVm2YLpvsHS9G9FP+
         EtZPD9Yug6+Kxs2aEjYXOHtuLBTPGD+nDR/Cl9lcqMNX+ay0iyCAT2C89eikrGyhZzrw
         7HOISvsUaEq1I7dgBF06kCuRKQ4ocTegVl9iKqHZZsmnvGYNKzineFQmUSpjl09/Ab7a
         p9HCbqlIzEomHJWs87DMCaZpMmyW5R9+5yKUd1WrujqGXpWHlKd7byRAEioOifqWwiTz
         fBp3+e6XNetl0EDRXSGN5uFNg361bUq9NW1ui0IzOWl2PxWd7H3Euf6dIWOBv5sOve97
         MkFg==
X-Forwarded-Encrypted: i=1; AJvYcCUQQJO6mdNJwfi2CYy3wJutpXJd8uzhfiToH9xlc12e0z3BD/9IY4rabbulhEKFsfNKEaNpcfFwGquyDl+ICwLCijm+Z5lCNlU3njIlfq9Ikg==
X-Gm-Message-State: AOJu0YwBbZUW75DxS7k8j/SjSNqLBke7isrnUheyOJWi/iepHxRx7j+2
	F+uD6BI3eAIVRbdCEng2XekBYtZBIXDTacPOOlhOJVDpOtXK8HQcrVlwG3ukofH8avNBXmJcVQz
	jNhfUMa5HqFI3yw3STY/dvSYgLttezAMF0ab4
X-Google-Smtp-Source: AGHT+IEQ7WRa8hiVTDi2B/1owhtvp7Q0Vk46CLVAx1AV9uhYirZ55gn2RQrTqp3vUQryyI6P68rCdklLShDKPFQ8AQs=
X-Received: by 2002:a17:903:484:b0:1fb:1a7:a64f with SMTP id
 d9443c01a7336-201d747b284mr27875ad.20.1723571312988; Tue, 13 Aug 2024
 10:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720062102.444578-1-weilin.wang@intel.com>
 <20240720062102.444578-9-weilin.wang@intel.com> <Zrq11fq_F9vImsQh@x1>
 <Zrq2IoAgopw1NbbA@x1> <CO6PR11MB5635B87159218287A4E8108CEE862@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB5635B87159218287A4E8108CEE862@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Aug 2024 10:48:21 -0700
Message-ID: <CAP-5=fX9pLRig7qJ+6Wk1g9ysDUDDKXMbo4s1GYvz28iAPs1iA@mail.gmail.com>
Subject: Re: [RFC PATCH v18 8/8] perf test: Add test for Intel TPEBS counting mode
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb" <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 10:18=E2=80=AFAM Wang, Weilin <weilin.wang@intel.co=
m> wrote:
>
>
>
> > -----Original Message-----
> > From: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Sent: Monday, August 12, 2024 6:26 PM
> > To: Wang, Weilin <weilin.wang@intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>; Ian Rogers
> > <irogers@google.com>; Peter Zijlstra <peterz@infradead.org>; Ingo Molna=
r
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
> > Subject: Re: [RFC PATCH v18 8/8] perf test: Add test for Intel TPEBS co=
unting
> > mode
> >
> > On Mon, Aug 12, 2024 at 10:24:40PM -0300, Arnaldo Carvalho de Melo
> > wrote:
> > > On Sat, Jul 20, 2024 at 02:21:01AM -0400, weilin.wang@intel.com wrote=
:
> > > > From: Weilin Wang <weilin.wang@intel.com>
> > > >
> > > > Intel TPEBS sampling mode is supported through perf record. The cou=
nting
> > mode
> > > > code uses perf record to capture retire_latency value and use it in=
 metric
> > > > calculation. This test checks the counting mode code on Intel platf=
orms.
> > >
> > > root@x1:~# perf test -vvvvv 123
> > > 123: test Intel TPEBS counting mode:
> > > --- start ---
> > > test child forked, pid 2600160
> > > Testing without --record-tpebs
> > > Testing with --record-tpebs
> > > ---- end(-1) ----
> > > 123: test Intel TPEBS counting mode                                  =
: FAILED!
> > > root@x1:~# grep -m1 "model name" /proc/cpuinfo
> > > model name  : 13th Gen Intel(R) Core(TM) i7-1365U
> > > root@x1:~#
> > >
> > > What am I missing?
> > >
> > > The current codebase is in tmp.perf-tools-next
> >
> > acme@x1:~/git/perf-tools-next$ uname -a
> > Linux x1 6.8.11-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Sun May 26
> > 20:05:41 UTC 2024 x86_64 GNU/Linux
> >
>
> Hi Arnaldo,
> I just checkout the code and tested it. The failure is caused by a seg fa=
ult on a
> perf_tool struct that is not initialized correctly. I think this is relat=
ed to the patches
> on struct perf_tool in this branch that applied right before the tpebs pa=
tches.
>
> I was able to fix the seg fault by adding the perf_tool__fill_defaults() =
back. Since
> Ian updated the code to replace this function, I think I need some advice=
 on how
> to use the new code to initialize perf_tool correctly here. Should I call=
 the
> perf_tool__init()?

Yep. If you've added or refactored a tool struct the intent now is
that you call perf_tool__init then override the functions you want to
override. I don't mind to rebase those changes over your changes,
Arnaldo if you want to drop those changes.

Thanks,
Ian

>
>
> Thanks,
> Weilin
>
>
> > > - Arnaldo
> > >
> > > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > > > ---
> > > >  .../perf/tests/shell/test_stat_intel_tpebs.sh | 19 +++++++++++++++=
++++
> > > >  1 file changed, 19 insertions(+)
> > > >  create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > > >
> > > > diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > > > new file mode 100755
> > > > index 000000000000..c60b29add980
> > > > --- /dev/null
> > > > +++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > > > @@ -0,0 +1,19 @@
> > > > +#!/bin/bash
> > > > +# test Intel TPEBS counting mode
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +set -e
> > > > +grep -q GenuineIntel /proc/cpuinfo || { echo Skipping non-Intel; e=
xit 2; }
> > > > +
> > > > +# Use this event for testing because it should exist in all platfo=
rms
> > > > +event=3Dcache-misses:R
> > > > +
> > > > +# Without this cmd option, default value or zero is returned
> > > > +echo "Testing without --record-tpebs"
> > > > +result=3D$(perf stat -e "$event" true 2>&1)
> > > > +[[ "$result" =3D~ $event ]] || exit 1
> > > > +
> > > > +# In platforms that do not support TPEBS, it should execute withou=
t error.
> > > > +echo "Testing with --record-tpebs"
> > > > +result=3D$(perf stat -e "$event" --record-tpebs -a sleep 0.01 2>&1=
)
> > > > +[[ "$result" =3D~ "perf record" && "$result" =3D~ $event ]] || exi=
t 1
> > > > --
> > > > 2.43.0
> > > >
