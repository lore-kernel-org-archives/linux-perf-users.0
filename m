Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E231DE3D2
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Mar 2025 23:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741650050; cv=none; b=LXQRU9jSjuV/7MBkjCY40UdcaeFWRwv9wZFHa0kRBhy6cfBO/C3400E8/1aEfybae5uFgBEZicAJ49lpF7neo45+fa6tUw/whBV7zq08NJ+ExuTJOCMBon2PH0ZDzhia1BOt/Gl9OoaD+y+xeVd4OqfBvi4zS4DvXx4zztVVoz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741650050; c=relaxed/simple;
	bh=x40/ETGWHUSDRpQLwYAWfFBMNQ7ZHfZ0GBicDTi7eWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQDpcfHBpumd88nEHaIUMGXHlUpTVU6YAjJjNfrP2h3nUV8mp7Pjddb2iXbSzZO3E2/LwWqlv6gfjyeMxGXycgjM/GCzd5YZ1LTspDYX2c5ykPo9B2pva82rGLIhaedwMG/KQTzOoC+SLu4+rk+tZUi/ZNfPtWFtPGeSx+ryUMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qVS+DokJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qVS+DokJ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2240aad70f2so41615ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Mar 2025 16:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741650048; x=1742254848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3CJk04DNfcWCA8ao7G6n3tZ6Syq2WgT8HbIaJ/f+4g=;
        b=qVS+DokJDgw3j2+hn+/XSBFwjRCgFoj8tPMHaBbgb4yYAIoHhmjXheXjb3ME3F5BEB
         IaFk29mHYjjHIW3HJjHoCTE8EQ7qunmO83ZRioAzQW9BAVDpJHgXXiTNMIfLIMieS0ax
         uWtVf7F5xyCai9Rgk+l6w+nx5Zo9sUqFjSdb2v7jxmTpSRdUJf6zYSSOVEMnSS2mECc8
         +8NiLARwMnb8vxgq0iDaCZcznvrymmLJGHB+DR7hMDxKXHz7nmELxLoMZcrTq+x7YfPr
         EQXZZpGAyZ50qF6rCzcZ7WtulvHatHHWHW+H0Fg8nZBZR5jB7Exfykz8i/Yj3VBHJ3wb
         MlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741650048; x=1742254848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3CJk04DNfcWCA8ao7G6n3tZ6Syq2WgT8HbIaJ/f+4g=;
        b=F7dS4WzuZa/exrycglUST9GGzo7h0rPnOjfarDklyI1KAxHQ4Q31xxsZUTM7iS4jFB
         O/WQ5NNRN3D6BRmB/5t9HZpHn/tYHjRbmHOJ7YeTaXwIfmpXo6W9yWUkKwZAeIg3LxnA
         6vTWgDUj8j1qtnHPMF7uVtHlNovqakTFHZ9At6aAqNLlPNjgaeTX1IlUhrH93h6MyYoK
         nP5fIs/FzytIrTDkEQBDCfX4c1bJZQrkWDrT5arRL/RsGCdBvq6dbLLGs6WqeVf/Smos
         7t0Tq2PB6AabP+xpgY1LjZcDet8XFh55juZulWmD95CWboEHj0GxdmNyKRG8SGUCAz+d
         4NoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW8S16gYpei2CDj0/MfJq2C1BLh3xmOZ727lWhm6Vea2Jzx9/c4R6Wx8q7ROZi5SANv1gq23bbAJrPEZhZVFjD@vger.kernel.org
X-Gm-Message-State: AOJu0YwpP0q5QJqqTBl3XGMQFlxgj1fBaYg7kt5wJXD3INOdJLi7U6R9
	of1gVyEXeYvyikUgN72HU5BH2RBZbTTMoz+u7GTVNz63vk8ocx9ZkaVczcDedfAZaCeMFJe6RgL
	8tiYk78KrBDoufJPfWVVSjaeUZabD8iskWzzl
X-Gm-Gg: ASbGnctWaBYI0Pyu6mJViGLoRkadIUjY1bAvg7j3hc+mJDTwiipbrXgQPBS78sjhKzb
	IC25oGinBsb2bPX4bxGVi27RLn0Tr60RTTFzF7VbPDu4DQhq+vSvRD8xid7axaCQyWjm1y23PXk
	x1pTvpDUBMFeZX9UfoDiNY81QBoas=
X-Google-Smtp-Source: AGHT+IG8ZbJq9d3fOC2d1WzTRzoCvLclS0qrQU2tOiogJ4Ztx6P+CKCMeJ9Eq2d7KIOBSgUw60hfwsy3X1Gl0bCqIqI=
X-Received: by 2002:a17:902:dacc:b0:220:c905:68a2 with SMTP id
 d9443c01a7336-2254779cef4mr5526915ad.5.1741650047858; Mon, 10 Mar 2025
 16:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com> <20250228222308.626803-12-irogers@google.com>
 <Z89k6lWxRSBfCGvM@google.com>
In-Reply-To: <Z89k6lWxRSBfCGvM@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 10 Mar 2025 16:40:36 -0700
X-Gm-Features: AQ5f1Jqm0hhpEhKAQajzWvx41-veMYX8cdpwcxztn5nYV3jmEU6IdvOQfPYBejM
Message-ID: <CAP-5=fUV5yt4c-PrvTFqW6ehuudwkqdO7QuQpvbUBDm6aT6+dQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] perf python tracepoint: Switch to using parse_events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 3:17=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Feb 28, 2025 at 02:23:08PM -0800, Ian Rogers wrote:
> > Rather than manually configuring an evsel, switch to using
> > parse_events for greater commonality with the rest of the perf code.
> >
> > Reviewed-by: Howard Chu <howardchu95@gmail.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/python/tracepoint.py | 23 +++++++++++------------
> >  1 file changed, 11 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/perf/python/tracepoint.py b/tools/perf/python/tracep=
oint.py
> > index bba68a6d4515..38b2b6d11f64 100755
> > --- a/tools/perf/python/tracepoint.py
> > +++ b/tools/perf/python/tracepoint.py
> > @@ -5,24 +5,23 @@
> >
> >  import perf
> >
> > -class tracepoint(perf.evsel):
> > -    def __init__(self, sys, name):
> > -        config =3D perf.tracepoint(sys, name)
> > -        perf.evsel.__init__(self,
> > -                            type   =3D perf.TYPE_TRACEPOINT,
> > -                            config =3D config,
> > -                            freq =3D 0, sample_period =3D 1, wakeup_ev=
ents =3D 1,
> > -                            sample_type =3D perf.SAMPLE_PERIOD | perf.=
SAMPLE_TID | perf.SAMPLE_CPU | perf.SAMPLE_RAW | perf.SAMPLE_TIME)
> > -
> >  def main():
> > -    tp      =3D tracepoint("sched", "sched_switch")
> >      cpus    =3D perf.cpu_map()
> >      threads =3D perf.thread_map(-1)
> > +    evlist =3D perf.parse_events("sched:sched_switch", cpus, threads)
> > +    # Disable tracking of mmaps and similar that are unnecessary.
> > +    for ev in evlist:
> > +        ev.tracking =3D False
> > +    # Configure evsels with default record options.
> > +    evlist.config()
>
> I think the default option uses frequency of 4000 but tracepoints want
> to use period of 1.  Also I'm not sure if it sets the proper sample type
> bits namely PERF_SAMPLE_RAW.

I used trace to ensure they matched. Fwiw, the sample_period for a
tracepoint is set to 1 in evsel__newtp_idx:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/evsel.c?h=3Dperf-tools-next#n621
and the evsel__config won't overwrite an already set sample_period:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/evsel.c?h=3Dperf-tools-next#n1341

Thanks, Ian

> Thanks,
> Namhyung
>
>
> > +    # Simplify the sample_type and read_format of evsels
> > +    for ev in evlist:
> > +        ev.sample_type =3D ev.sample_type & ~perf.SAMPLE_IP
> > +        ev.read_format =3D 0
> >
> > -    evlist =3D perf.evlist(cpus, threads)
> > -    evlist.add(tp)
> >      evlist.open()
> >      evlist.mmap()
> > +    evlist.enable();
> >
> >      while True:
> >          evlist.poll(timeout =3D -1)
> > --
> > 2.48.1.711.g2feabab25a-goog
> >
