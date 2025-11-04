Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED4B26E17A
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Nov 2025 05:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762233736; cv=none; b=RknyOmdAjdZvTFCO3z9hyJ9uUxihi3XD/8ZDxpfQpI6JLiswWFafF65PrhAJmSVmyhFQ4XPl244vbtq5IJQIvFI4Aet0mRBvuiDQIjpVd6C0z71oE0B3iH9/37O93Lb2ieGb5DB+MzgNOKzfxuJ357yyx95yl9uBusP4yeVHaf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762233736; c=relaxed/simple;
	bh=EQtEfaT8jWOsm7wKZ5f5ZTU1pGn7YcMN4yN1uRAnYDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsfsDksgiC4BsPEaocJxEb3X4+o0KYTLfZI+q1SQsKpOuvZHsZCdPXreVs1JcQSsmzJzt9XV7dXGoV/L6KGg0CYPLupcy5PulpOwCC6HagRgTx++BvqLMpLZK/0DBpGfo3Ld/Q5wsdS3g2GZcppQIQUobXTpBJaewT8cx2Pp97Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jG7xhEhR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jG7xhEhR"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27d67abd215so131085ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Nov 2025 21:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762233732; x=1762838532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iWuZp/u/mfWjJb+qRvHHS+nP6g5jcfye1Xv3bDfsrk=;
        b=jG7xhEhR2+mAwIk6InxPVa25XjeB5Ova0F/RsOP+yHlZuqPPqpsAER9N/MPyeL89ls
         +4KxOIBt0KBl7ySfPlMQf0LePKFkoClI/eFzIM/DtwIEBjA171OZAAeWgDCzzNsyS7pm
         vS7UOB3S8TxsnauTO12+aoSVF50d+r4sUSkxH3KbsRHeg9qIGhFhG/ETFjV3Gbe3gc5c
         2s6XI6xeNxORYWpGaTQPLhHZMdmTbtRQqt0d/eonHl1RxoOqPgLWrW4Mzu1kfkfObfQX
         DNEh0zIES3M+hzvS0atLtws3qlMnhF28dJFXSzMIzkixTm+cd+RcUzDmyIoV68CFbuFT
         5tMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762233732; x=1762838532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iWuZp/u/mfWjJb+qRvHHS+nP6g5jcfye1Xv3bDfsrk=;
        b=gQr86vWJtEvRsXEcrKpTDC9St0ySu4WZMidnQuC3tMWfPxT34ywJn3bP9uhfqmXk4r
         SbhDMkAS6YoIHp8rMvLP0EBVD8ne5Ba9ePjxhsh8I5yFCem6ASNt6I/x0R9l+hEgRnvO
         ngaMD6Vvm2KYYWqFVC6VCIA3JK9cmeG57GVuuMYBRakuH/EAiUKwHl9RAYMQ7E6ljxz+
         S7mI9MnkKcMKZlNaC2B6WHLXnRKcFU/rqyGehAIrOABLz3fGBNULyHNL0sXskx/tDWtN
         OyNmQ98kRbuxJIB/0xen61GbFL/U8g//BLXlHL8auxBUDFDf1EMCfqbyOHNwbBE0888o
         7Nuw==
X-Forwarded-Encrypted: i=1; AJvYcCVZfX5fl+NZaa33Ju4oFr7HLtw1Bx3bPDAxvUBhOxWP16wRF3ETDnXbdGGkOHGybfL5Pjx6OFvxySY0fAREKYFe@vger.kernel.org
X-Gm-Message-State: AOJu0YwHblDD5E04jFHUrviWOrrCyEL4TI25CdTIh4Pn2iG6zJOrmcVP
	mbotbYjXSp6KVsnzuwKFesqPK2CMajy40eQonnFIIXPnh7rMdMJk643FV51wfQ1zUsCaM8vO2V2
	3p2KpgH+lozGrFJJ1zBKLdqGgU7MHISPc8FTWCEuW
X-Gm-Gg: ASbGnctqZkH9cCzjznEHB/SA5/Y5CKevcPDjh5QUX4Nu2lQKNV6p/YpbogrdsgwZgQr
	xLhNMW/3fh9AjtKq64NpQPPeuPi5GIimfAaREmcsRyF0cGJdby481InHLbIhGsgo3DD3oJmx4lG
	T1tO/PwAXx9jbwsjHw+Zxc58EKqcB1hyyYUOehGOmFPOyD5P4uSEePlK5ETAFfs/WEP4v46zKbi
	9AGxDFEyBt63/IJNksN4oLHsL12O11ys9YYRIIJxBAx8AmX1IWumobwLInPWdvNGgAfnH0wu4KA
	odwnZg==
X-Google-Smtp-Source: AGHT+IHoO5B2Si9Uvj0pP5tXFzvTxPU2wofFdFmzQUxanzus5YC7y31dOXnSLrjqetrJGZPvwaPQwJ7jeWIjxbhbbx8=
X-Received: by 2002:a17:902:dac3:b0:295:1351:f63e with SMTP id
 d9443c01a7336-295fd8dc5femr3809625ad.10.1762233731612; Mon, 03 Nov 2025
 21:22:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029222638.816100-1-irogers@google.com> <20251029222638.816100-2-irogers@google.com>
 <aQl06yRnXvdBEkJ4@google.com>
In-Reply-To: <aQl06yRnXvdBEkJ4@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Nov 2025 21:22:00 -0800
X-Gm-Features: AWmQ_bmHLbtCHrzs1FpF4_OhpunwaomuhfoSJpPqL5oNe8-GhWH_bbT0vKCZFPY
Message-ID: <CAP-5=fWtixi8ykDp_BO1nz_yj_1wZfUUWrCVb+6WbVE7vON6Eg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf test: Add test that command line period
 overrides sysfs/json values
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 7:37=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, Oct 29, 2025 at 03:26:38PM -0700, Ian Rogers wrote:
> > The behavior of weak terms is subtle, add a test that they aren't
> > accidentally broken.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/record_weak_term.sh | 25 ++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/record_weak_term.sh
> >
> > diff --git a/tools/perf/tests/shell/record_weak_term.sh b/tools/perf/te=
sts/shell/record_weak_term.sh
> > new file mode 100755
> > index 000000000000..7b747b383796
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/record_weak_term.sh
> > @@ -0,0 +1,25 @@
> > +#!/bin/bash
> > +# record weak terms
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Test that command line options override weak terms from sysfs or inb=
uilt json.
> > +set -e
> > +
> > +shelldir=3D$(dirname "$0")
> > +# shellcheck source=3Dlib/setup_python.sh
> > +. "${shelldir}"/lib/setup_python.sh
> > +
> > +
> > +event=3D$(perf list --json | $PYTHON -c "import json,sys; next((print(=
e['EventName']) for e in json.load(sys.stdin) if e.get('Encoding') and 'per=
iod=3D' in e.get('Encoding')))")
>
> This line is too long

Is there a good way to split such a line?

> and needs some explanation like what's like the original text and what it=
 does.

I thought that was covered in the "if" below:

> > +if [[ "$?" !=3D "0" ]]
> > +then
> > +  echo "No sysfs/json events with inbuilt period."
> > +  exit 2
> > +fi

Thanks,
Ian

> > +
> > +if ! perf record -c 1000 -vv -e "$event" -o /dev/null true 2>&1 | \
> > +  grep -q -F '{ sample_period, sample_freq }   1000'
> > +then
> > +  echo "Unexpected verbose output and sample period"
> > +  exit 1
> > +fi
> > +exit 0
> > --
> > 2.51.1.851.g4ebd6896fd-goog
> >
