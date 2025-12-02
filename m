Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619C32FD680
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 23:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716725; cv=none; b=sTRXkuYNvj43qyFu3MNmb3j6ovN5pz7GKAhZxLvOOlnZSiEUkNL9KWIad24gYfhU9A0XSf3zzKVKlsFhr0k+CLnDE3Adt32xwmXqttZx5RubR+wMbif1bB/ehPHY44dIPMP0P9nyqSjdlgiw5qfHaOK3nAB9Sxn1pOaNQpwFNes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716725; c=relaxed/simple;
	bh=P5NlyCEs4nkpKmRFeqviNgtXp1XPVZKxEE06+juiyqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIT5FntDzrT9yC6B9LHKX3kvJuEqMtjD+Xlma/tUz9Vp+qIcpyLT+DZZsetjzz9lW3rvDLrkMz5iP/NwGOJAhhSrwo1vzu7tB0xK6Qs0uuoC6L540bs5KuslLlTEoaYu+MIGMy1otM7E7zr006alB/Wd4frkTonX8toL182w0E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XrL8r2up; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XrL8r2up"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29852dafa7dso28315ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 15:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716724; x=1765321524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIdXhdTikCq6WHWbZVk3v4LT7xUHvtdZmBsuUFLcsS4=;
        b=XrL8r2upBI+nlqSPY+GLk2g1jIztq8FrkaheNhVK3nKPCZsdQPXIibIC1lkeEQk4h+
         HbhZohhFKeMh0Kc8jI8eewYWEBcuqgje+cKjKzPZqtDa8K8SRFUbZA4E2sA5RiUn4wrs
         f/gX+WrYI7mIl4YGvIZEMl6EkpAYFddSKvpUJ8RUa7KM/kMh6VgSP11uFMN6V28p4xK5
         lAnK+h6TxdpIs+AP7d+wQYm6s0w1fUxZ1TXPrF7/dZY7lVn2Uo0bK1dMvwkSrgn9p0HI
         3Bmr+BDEQSEK9J/1rwH3UqMzlCHFk9TzlKqRa7X//yC7DljFMYmfPlXYAHCK63j6PK6t
         115Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716724; x=1765321524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jIdXhdTikCq6WHWbZVk3v4LT7xUHvtdZmBsuUFLcsS4=;
        b=Sw8uZSebCeFy6ax8nfubpGemVChj/L2+aWMxcVrAuRLgFq2WjBk89pzifp+3LTppJc
         tVVz8HpBzd/fIoQCOq1stK+wAbKg67wLLEVMkAzupmA1jrRXRBF+UT5WQ3LIcmFSYb0L
         wHOT0IeB2+yS5muZ2bC/XKD7s6MQOStDywrthMjFjMvKR6VDkFmCrlFtp/CW7hQ9pwib
         O12otepOY8eP6VClBDSV1kQ92FQoNBpF6lNZq3kwUUg06lu6Tn/mpTKGBi45rgWCyln7
         tlTfnLPbCFypgI/gSdHBK40WNn+K3F1WUE4nBYjLIqUymv8J7cuaIIfa7uqoQBw1xIHx
         2LiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyPLimB0Y2CPoFej7uYXFOpvx229ofGuFK9/NwPwcKoAGfChw4tF1BJxfBO22RPPn7IgDh/KTRkt/C/dznR0l3@vger.kernel.org
X-Gm-Message-State: AOJu0YxmEvQWOKT5eLZXwwYvyB5Wo7rotsnAnHZZVStIevtLO2uCkFi1
	jZOrjQ1oGrmIU4RK6tFFICJmBgPCUSz+uDK1Qglt2gsZaR0vq7BYflZZlhQDqZogE0I3xbS08vQ
	7DwC+fJaLjSrub56x0VQuTn5njA6eJWTzWJON6Zf0
X-Gm-Gg: ASbGnctQ9eUGXeIgY6BlnAyLBd5VtZ9JnPhD4XXnYvazdjODndTjCskagLPZCeaSgc1
	0o15542d9Bk1+aG/MOzuYelGjkpNPlPPqH+ZZIwI92U2QGun/5OSBtRwV0XoT9vmxkzJtBeCPyO
	9s2NQ+PSw9VpmsGg/NXMNbAwOJjcFckgJwNVagzPHnPi5g+Swf4DTvhx1Opy5xO3n754dLtp2Jb
	5lFvrG8NlEsdCCwZZnQyelwc+E4iPlWA6W+X5bQd0+5AviZ/gixjiCVQlbMKr13XwdWe1LgiOkv
	5NR3P+EpbtmxYkF7Cja8yllm
X-Google-Smtp-Source: AGHT+IG4u5ciB137/hhS/tEQBtdCBMHuJhQXmr5K8oWbmWSMwLFADqMhLWjKY8YovXDmS8eZZ/bJo3UTV11CYcyr/Y0=
X-Received: by 2002:a17:902:d2c8:b0:295:3f35:a315 with SMTP id
 d9443c01a7336-29d67f35014mr371395ad.5.1764716723447; Tue, 02 Dec 2025
 15:05:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201231136.293248-1-irogers@google.com> <aS9dDvCWO9BdMmna@google.com>
In-Reply-To: <aS9dDvCWO9BdMmna@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Dec 2025 15:05:12 -0800
X-Gm-Features: AWmQ_bm57hcNZuNd-8cdNzCNwmIm3t4TFggwvUMpqsAZGMxg0KhLC7yVZJl_W4g
Message-ID: <CAP-5=fX8MgFXtYtxtYpDsVb5SHjxELPCRNcySJcNVEtC1pOieA@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Fix hybrid testing of event fallback test
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Zide Chen <zide.chen@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 1:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Mon, Dec 01, 2025 at 03:11:36PM -0800, Ian Rogers wrote:
> > The mem-loads-aux event exists on hybrid systems but the "cpu" PMU
> > does not. This causes an event parsing error which erroneously makes
> > the test look like it is failing. Avoid naming the PMU to avoid
> > this. Rather than cleaning up perf.data in the directory the test is
> > run, explicitly send the 'perf record' output to /dev/null and avoid
> > any cleanup scripts.
> >
> > Fixes: fc9c17b22352 ("perf test: Add a perf event fallback test")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  .../tests/shell/test_event_open_fallback.sh   | 19 ++-----------------
> >  1 file changed, 2 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/test_event_open_fallback.sh b/tools=
/perf/tests/shell/test_event_open_fallback.sh
> > index 9c411153c01b..9420a7557c13 100755
> > --- a/tools/perf/tests/shell/test_event_open_fallback.sh
> > +++ b/tools/perf/tests/shell/test_event_open_fallback.sh
> > @@ -6,24 +6,9 @@ skip_cnt=3D0
> >  ok_cnt=3D0
> >  err_cnt=3D0
> >
> > -cleanup()
> > -{
> > -     rm -f perf.data
> > -     rm -f perf.data.old
> > -     trap - EXIT TERM INT
> > -}
> > -
> > -trap_cleanup()
> > -{
> > -     cleanup
> > -     exit 1
> > -}
> > -
> > -trap trap_cleanup EXIT TERM INT
> > -
> >  perf_record()
> >  {
> > -     perf record "$@" -- true 1>/dev/null 2>&1
> > +     perf record -o /dev/null "$@" -- true 1>/dev/null 2>&1
> >  }
> >
> >  test_decrease_precise_ip()
> > @@ -49,7 +34,7 @@ test_decrease_precise_ip_complicated()
> >
> >       perf list pmu | grep -q 'mem-loads-aux' || return 2
> >
> > -     if ! perf_record -e '{cpu/mem-loads-aux/S,cpu/mem-loads/PS}'; the=
n
> > +     if ! perf_record -e '{mem-loads-aux:S,mem-loads:PS}'; then
>
> I think we need to either keep the trap handler or convert all perf
> record commands including this to use -o /dev/null.

So all the perf record commands use "-o /dev/null" as perf record is
always run using the "perf_record" function (ie the one updated here)
:-)

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >               return 1
> >       fi
> >       return 0
> > --
> > 2.52.0.158.g65b55ccf14-goog
> >
