Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABC01E898;
	Tue,  9 Jul 2024 05:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720501434; cv=none; b=onUJqLzc6+WrxqWwl0HDZhwAdolNqTV5URfOBMVo98j3Vg+vgVpp1fxljzoWfE1dV13DtVf934T3qDDHuFXq3pVrNqBeGdJc7DOqSOo44DzrksxLkWhnkEwqN1YmoLUoIbjU84Rcdz0HJYXrb6eN7eY4q/C6ZiphdJTeexzgSj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720501434; c=relaxed/simple;
	bh=LZsv8kTS/vJFF/W2dAApXKoP6jJcxx7NyjSkCs+oCqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axNOuKQIyd0N5TJpoTgttKk9Da/XMpecfbdaLhZ+ZZ1lpcIT6/K6NKMw3r5ISGY9JfvjIT12SkK/96vW4617dKVKipqeVzg9M/imc1cmdD+dfZHkrzd1D64yK3H05xlqJzWvLDfRvnL98suBiLA9wg87SE2J+F99WZblGZNOOxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-48fe7e1c6feso1270624137.3;
        Mon, 08 Jul 2024 22:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720501432; x=1721106232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvclU2KTAE+gN/Kh8ilmp6n+TmM9TqqSnwn6LH24FZE=;
        b=Gn1G0IZhNUTzQyZHZzUQKLVZRWwt6VCV72+GS5cP02GupzXsWGWBHHHIcN8uDhHl0t
         gbQGf3NrBM4ffXsQrYON8GmJJkLtGXsp1Yj7bEu5iVZgEkOeB/9u3rpuNUVmqyj5yx0A
         NZ1l+fJOpvWRueP4D66BYGKXgovqYX/Tqg91X9r+bIXgjBsGNRTWLJhFmL/eGXymAD+x
         6b6fCcx49v6Aw+34L86tpN9aXr43+XUcAslLGPmyGGa0CXJh3a88ZlZ9z+NMM6tyOxNk
         uftf79bplVbZynioEwZQgBoc2QjCSK1gX8iJSmuxoslyBKEXB4B6yY5e3YmbGxk6FyjP
         Ri9w==
X-Forwarded-Encrypted: i=1; AJvYcCVU2gHLnmrrJhXXayrdlIaST/NcjIkOQtLQVTZKpBIiz7IEs+W4F9K0cZTmEOhn/ysjbA6GWdZc4bmVMk9kJVmdOZ/JVND13ihEl+wI7GF/Q33xJsA4VXywZyOHLDfnbBOegvtV+0V9pPW6mSvf5w==
X-Gm-Message-State: AOJu0Yx6Iy6a6/Uu1joTI4hYd2xutsg1saFHve40fx+i+2PPKH06Ec6K
	OcBh7Pmzi2TBrd+b6yL4ZRP2h7vaFzgXVw8ckuNbw7ewUnEiP++7pAu+3/A3HzWWoqcF7Hh7dfi
	mxqIJRKy6mIN8x9JOwgbqv5iDoSc=
X-Google-Smtp-Source: AGHT+IGFZJ+GaBzkeTndqvKauB4rj/7vLmjR5oBm33e+GisHjCr/3pORPE3V63abR1s28uRMfaymHKFdDJWCcov22Z4=
X-Received: by 2002:a05:6102:41ac:b0:48f:ea3c:268b with SMTP id
 ada2fe7eead31-490321b91c4mr1474853137.17.1720501431854; Mon, 08 Jul 2024
 22:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706232956.304944-1-weilin.wang@intel.com>
 <20240706232956.304944-9-weilin.wang@intel.com> <CAM9d7chhVAG9wpWdQM4DRriM_kp9vjFj=_ak1+0qyO-sRdXs4w@mail.gmail.com>
 <CO6PR11MB563567A7804F50AD5AA1F708EEDB2@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB563567A7804F50AD5AA1F708EEDB2@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 8 Jul 2024 22:03:39 -0700
Message-ID: <CAM9d7cgrX=hL_Y16ZrPr6NOsd2ApOWdDP2bWDSNcK2yp4Skn3A@mail.gmail.com>
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

On Mon, Jul 8, 2024 at 9:58=E2=80=AFPM Wang, Weilin <weilin.wang@intel.com>=
 wrote:
>
>
>
> > -----Original Message-----
> > From: Namhyung Kim <namhyung@kernel.org>
> > Sent: Monday, July 8, 2024 9:44 PM
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
> > Hello Weilin,
> >
> > On Sat, Jul 6, 2024 at 4:30=E2=80=AFPM <weilin.wang@intel.com> wrote:
> > >
> > > From: Weilin Wang <weilin.wang@intel.com>
> > >
> > > Intel TPEBS sampling mode is supported through perf record. The count=
ing
> > mode
> > > code uses perf record to capture retire_latency value and use it in m=
etric
> > > calculation. This test checks the counting mode code.
> > >
> > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > > ---
> > >  .../perf/tests/shell/test_stat_intel_tpebs.sh  | 18 ++++++++++++++++=
++
> > >  1 file changed, 18 insertions(+)
> > >  create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > >
> > > diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > > new file mode 100755
> > > index 000000000000..fea8cb1b8367
> > > --- /dev/null
> > > +++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > > @@ -0,0 +1,18 @@
> > > +#!/bin/bash
> > > +# test Intel TPEBS counting mode
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +set -e
> > > +
> > > +# Use this event for testing because it should exist in all platform=
s
> > > +event=3Dcache-misses:R
> > > +
> > > +# Without this cmd option, default value or zero is returned
> > > +echo "Testing without --record-tpebs"
> > > +result=3D$(perf stat -e "$event" true 2>&1)
> > > +[[ "$result" =3D~ $event ]] || exit 1
> > > +
> > > +# In platforms that do not support TPEBS, it should execute without =
error.
> > > +echo "Testing with --record-tpebs"
> > > +result=3D$(perf stat -e "$event" --record-tpebs -a sleep 0.01 2>&1)
> >
> > It never finishes on my AMD machine.
> >
> Hi Namhyung,
>
> Do you see any message while it executes? Is the perf record forked succe=
ssfully
> but failed to return?

I don't know.. all I can get is like below:

$ sudo ./perf test tpebs -vv
121: test Intel TPEBS counting mode:
--- start ---
test child forked, pid 583475
Testing without --record-tpebs
Testing with --record-tpebs
^C
