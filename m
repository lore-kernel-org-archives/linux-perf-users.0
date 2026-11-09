Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794248890;
	b=VYpF9FXWrF1woWhaDu+AW1lwY+vdRGKXstPxg1mLOJ7wMvQZDAmkRB4Ndwy5tB/NSoQu
	 UNDpJidfMbdPY8OETvo4FjlWb58KyxLhBl+1++2sU0eMBDYrhZjk95KUc2CA6wbxy8eC7
	 EMMpv5DG1w0kMJs/nvIsqaL0lz95zKo/uG1bbAWSuPp4cK+TshZ+XT4fk6zizKQ8kuwOC
	 OHU5E+KUlsC3aM0HJzAMN3rjLyMT62+eerMsn4CujUe1Q+eBvpfF3ilyAUUrmLg2v3hvx
	 Y5MJWylC1I8xXciKyzOm05iReP3nUUqpUKodw3XMJkGsASihSFDqL/siPYFgVsp3aqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248890;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=onbhuscWzyLZqd/joE4aKkaohJkFteguQkplQKwQm9g=;
	b=SKxs8HJSfoBSZWFA8L6B3hxtv3MlHUvhnqy6HJMXGJPFNx/0fVYh7ivEOC64TE4gu2Fw
	 DbGekpQsK1/lHFedsxsoWMoBFR7rJGYrpejQ4I5/jLEipviSiMI4BenU65FYHr9zrbWN0
	 v+JdMnMQghkNfIgzqdFjOjnRBlr09EDxcwUsoo092n0OzwGbD5XHzaQjlZpXfC/AMnHUW
	 /QAoF0imDpeBgSofdnLIDwH2A2dZEpQ8n53E/WctEvaR0uuqRyUI3jEzjdAhfR9fYMtpL
	 G/FT/aubzay+Mwz3qwdCzCggU2BJuwClUgvgvs4dxG0yD4UXMDZovLnRycB2cJBqehQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HC56rNG0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8C660A2610
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 18:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B8C660A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HC56rNG0
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-150ef97e790so691c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 10:28:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794248890; cv=none;
        d=google.com; s=arc-20260327;
        b=QOhpPBUXiOqGetpisdMCl7U5bJXYH/6ponlleUJx+3pj3b70gS5NNjpLu4ches+ret
         YLr9V7y5suWK+Qf1x7bW0coLsTtKm3oudDyO/yw9Y1SxRALOxynK87pKwsVwFc/dp00D
         Of1cpbd4UqG0DC2RPl/glH2Vkz7PW1GIq8Arf+3B0C6CmjxqLDsNc2xS4OiXi4f+Y4Xv
         UD16TS1O7FeAFgDYio5sOUijnaQ+ZqmIdJ2wiy9Q9m5XtWhEeV+2b9h4IaBM1GAU1ahq
         YzCk/zRS04NUmNytwoVPNKgRdyoRwBU47v/Pf/ZgCU8UNinHoN7jXkuuFQQMphMEQY0R
         AvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=onbhuscWzyLZqd/joE4aKkaohJkFteguQkplQKwQm9g=;
        fh=7U/+/IcD2+rLxkYr/0f9zclbQvzW/OANa1YKma2z1AA=;
        b=mAJQSyPEikEoi85w3nUrAP6inTN/iwSLZay1/D1ISknr7PDb00gONupPDEyzMyzw3K
         sgG3YCku6wQHiCmkI5jxlJIycFE8g+mnLXMZhZVBbBt1edMqgOPKzENOloC1QIZfSWN3
         LnE5NZZ0wJhyb3smDyMrpqjsJKNCAdcz/Ip80kAezK036O2vbOcWuD0IpNj5QeLHN3gX
         XKaqZPMi+VggnPfZhNYBZ5oiH/LHQa1+ERCMLMlPBIOFGLu78iwKGU34Nol3Advb3rRE
         Qwn0Ykoie+e8GLIHqdMzGMYMVBO+bOC60TYkdeAAnJVUGaAs6gHn7xE3fhKh+z90kNYF
         dUgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248890; x=1794853690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=onbhuscWzyLZqd/joE4aKkaohJkFteguQkplQKwQm9g=;
        b=HC56rNG0LL6TDT+or5MkU4uYBFSWuSIltO5eLP2xyvsrMzLPZD0udMKvBHSlch/eJB
         WSP274lU3aoQI6OO+Y1B4jsPffKN9ADfP26GKAAxeHpQ04w3f1CD1kgm3nJSu1RcD5JT
         2Pj/UjFbIz01nBfiA691bVY4qKi1qHNnx6GdCgl4QPV41MfOunMQ2uutDXGj7y9YfqHH
         /jzkVsgorBGEWHgpP6ZkkxK5lvWsR3MSSjW+RljpqclFja2l0jwITLR7U+pMiDGWin21
         1p4veRO51qM+KEc6mJE3FILFOYPbgtjJyT8h//Ef8kHLRlt4egYNQDEqoROMXt7OtVJ3
         Tzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248890; x=1794853690;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=onbhuscWzyLZqd/joE4aKkaohJkFteguQkplQKwQm9g=;
        b=Q2A0I1p+94Lc4IxzxkThdNqENLfoYQ3PrS4oXkQ1mKxY+Xc9rfmVyAsHVaDFco7xUP
         rz8Nou/M5FQGKm2LjtL5rxATm7Sc6Oq3u516J1FYwrqbDE9NXUnPPKWzjm0h2OYcdfTa
         hvCE2ePRWywqAbiN9OPMOB2o0SqbN9WdXcquBQMs0vhRfGmh85XPAlHxJQYbHc2oOFVM
         AXnhAdO+Z5myrJMQezrdN/Y0yndhpHrwSgWOs3RvjWCNBlZBqzTgw/Hnw8KDLJWuJY53
         1s/QLlSBDEEp8Go1q9BzY9TIcfn3bRYCQRA8XWPeVkPxh0w+hMT7ghoPqB7qVn4fOole
         Avag==
X-Forwarded-Encrypted: i=1; AL+hErF27/jzNwrbzV/MgVTEbAA589jiHkVxaq1YLoTvrlBejrdHvtnFJDF8Sc79pPJgGTECXGO6v3ajkGMCcmJzsd6h@vger.kernel.org
X-Gm-Message-State: APuU4Z9TGbIkfqllchphexAnlexSOyV26bnjW0FjH6mnOWcqBW+myTP7
	3rPuZEhORUt4xjwc0R2v9RzwZWwndhmm89gvTRCJVliKCi2tlfDiC1zGSprZG0vfABUJiwB+jzh
	YSwBsNrWZ+Vs6RamYAe1obqhNkcuHTV9g85JWcyZV
X-Gm-Gg: AYBFou3GjMmE7VIoUgZRzKSNpsg3/MNRGo5p/cXdcKK+erNICZy45R3XhoqtbOYdm8T
	DcyYS+GAcceT6JILX+hojISHAeIeYMm+S4d6K81unTsQ4VADkp7xi7h57V8PyV9X9qFIwuZcanu
	6w36q8opC5HUUgx/NoscvJPY+83FdS+GKB/iCrHJUcDOWbVwstgbzrjLEq4Rc8M0JPOKgmmyPJ+
	gXvrswDHGeoNXD9vkGxeWf1d5zoTqebwJEvnc/oljvNRnaaW30Vgzq144rWX22+0k+IZ5HfUbI3
	th2VxfhyaXiKzpFNS3fNFfIxjGHSofQ8jAbZorjTuOMgB0b1oNr2eAiroUY7rNEsi504Be9N9p+
	1Xlwl/tzpWHUHi9p5KCHkX496XqRcx8JoFns2/PK8uzHJGhPEbr0egyD+rA0AgnllQ/o=
X-Received: by 2002:a05:7022:7f05:b0:175:e9e6:65b4 with SMTP id
 a92af1059eb24-1b3b669eb9fmr17579c88.12.1794248888546; Mon, 09 Nov 2026
 10:28:08 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018074528.974953-1-lalitmaganti@gmail.com> <CAG2KctqPvou3A_EGiov9yZJrCWMmoEX-k4-Or-RGj_Cxdtc7Fg@mail.gmail.com>
In-Reply-To: <CAG2KctqPvou3A_EGiov9yZJrCWMmoEX-k4-Or-RGj_Cxdtc7Fg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Nov 2026 10:27:56 -0800
X-Gm-Features: AclHuK8pbA3eUUSFeQWBjdS2pws91SjahYa1K85SfJKzJtfTuVy9iTlcIK_4fmo
Message-ID: <CAP-5=fX6aqHuaV5c+Kfk5iY7SWgXKu+kWX+ReQ4agqkHg89tUA@mail.gmail.com>
Subject: Re: [PATCH] perf python: Accept events larger than union perf_event
To: Samuel Wu <wusamuel@google.com>
Cc: Lalit Maganti <lalitmaganti@gmail.com>, acme@kernel.org, namhyung@kernel.org, 
	james.clark@linaro.org, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 9:58=E2=80=AFAM Samuel Wu <wusamuel@google.com> wrot=
e:
>
> On Sun, Oct 18, 2026 at 12:45=E2=80=AFAM Lalit Maganti <lalitmaganti@gmai=
l.com> wrote:
> >
> > Samples recorded with --call-graph dwarf carry a copy of the user stack
> > and are larger than union perf_event, so session.process_events()
> > fails on the first one:
> >
> >   $ perf record --call-graph dwarf -- ./workload
> >   $ python3 tools/perf/python/stackcollapse.py
> >   ...
> >   TypeError: Unexpected event size: 4168 < 8424
> >
> > This makes all the standalone scripts unusable on such recordings.
> >
> > pyrf_event__new() rejects events larger than union perf_event, which
> > guarded the copy into the union that pyrf_event used to embed. Since
> > commit 2c672ffdad4b ("perf python: Lazily copy events and samples from
> > process_events") the event is borrowed, or copied to a buffer of
> > header.size bytes when a callback keeps it, so nothing depends on the
> > event fitting in the union any more. Remove the check.
> >
> > With this, stackcollapse.py and flamegraph.py process a DWARF recording
> > of a two-thread workload, with the same per-symbol sample counts as
> > perf script, also when the callback keeps the events after returning.
> >
> > Assisted-by: LLM
> > Signed-off-by: Lalit Maganti <lalitmaganti@gmail.com>

Probably worth having:

Fixes: 2c672ffdad4b ("perf python: Lazily copy events and samples from
process_events")

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > ---
> >  tools/perf/util/python.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index 60dbe2dad5eb..8b4b2f3d0926 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> > @@ -1792,11 +1792,6 @@ static PyObject *pyrf_event__new(const union per=
f_event *event, struct evsel *ev
> >                                     event->header.size, event->header.t=
ype);
> >         }
> >
> > -       if (event->header.size > sizeof(union perf_event)) {
> > -               return PyErr_Format(PyExc_TypeError, "Unexpected event =
size: %zu < %u",
> > -                                   sizeof(union perf_event), event->he=
ader.size);
> > -       }
> > -
> >         pevent =3D PyObject_New(struct pyrf_event, pyrf_event__type[eve=
nt->header.type]);
> >         if (pevent =3D=3D NULL)
> >                 return PyErr_NoMemory();
> >
> > base-commit: 1c90f0a3c8a1c4e38f9edd97af9e20848805a7fb
> > --
> > 2.56.0
> >
>
> Reviewed-by: Samuel Wu <wusamuel@google.com>
