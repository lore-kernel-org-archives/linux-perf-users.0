Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDD87489
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 02:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730256343; cv=none; b=edfNhzKzzKiGnsuf/NaEBFAm0g1+uuNfc06XDFY4YPCqx4P7zxqXy21TsC4kY+Gl0rUKt1x9Vm73DIRWguhqPZ1lFo4tFuv2nPK4+BnGquonCK338q7HCXCuvRCT693ZwSixyVMzRzqLAdxwjhCPAOQHckUxfZ7S0tqmckNKASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730256343; c=relaxed/simple;
	bh=BN0fMx46VXTzuiutOEuMnPGnMLAB0k3T+4RsPuGzPs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2mGM2cyZaTR5l/+6a/5FZHbafSVjpcLInHkMFounSJSDrxVHDzCtqi+BNIkXtumhfzZg0CEMH+sP4FY9N7Fh1u2rubiWfqz6Jo7FiBG78fpE1054fh+oJ0X6S8uXFrKFDGx9y/o2xgBK9IC/Yqjc49hZDlKu3guyL8mJM3uKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FvcUKlLk; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvcUKlLk"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso108545ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 19:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730256340; x=1730861140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvvnEelLqLmapO0x0c3RWR/JLiOjk0uX66oljX30Htg=;
        b=FvcUKlLkM6LGiittVx7Rli3t416TkMnrVoVfV753sltNkzsCZjKqYziKR5owhLHMs9
         vKRTxyLoKrDLcR5I1wqlQ44f613vESiMvt6V6y9bPyDQmM0n9k2Vviyzq28WsWvTtxoB
         uo+s7IJ4lEap0pDH+vLve6YRweOtwJrlnqbL09l9zk5Rjwsq7g9Dp/c/h5y0r4S+GUha
         MkqR4Uo0U2QlhiWGORwvx6BQz5rqHOX/aESdcobMcDFyUwYMm0n+J4iSzn0J0nOhBHsg
         N/q6pKon/uGYTw1fs85FjCKAkmIHW4Y77EjiNNZ+d7dYgadcUmjfZnQnJiwVwzw5HGyp
         zf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730256340; x=1730861140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvvnEelLqLmapO0x0c3RWR/JLiOjk0uX66oljX30Htg=;
        b=hWPUvvoDWudXBSdf21VdSL2Q2NbzJVUWpbKT1J0wFhuxwG+4Le/IqmAQ7U3J16Bcui
         art41jV7Qszsjqoi9TZYcNs0ThI1f+R2x603jiJvAPoSORmvsL95CK528pHmfUEocyHk
         kEHJh5Z+W2C5sSD/zxkuAPUtKXblE9dh0fzThtme8SsgAjU8RvEAYOXGAZNoZiLz4JLG
         m5jXs1ml7+4KUHO/ZyFe9DmHxqNC7ODgZA0ZbNWu29v8CgAD2GiHiCYUHmTjdmAq8mR1
         Y7I11Fafg1eS1MGI9z/k5qwmtMn/HlQbqEqWjzG2Ez1Efwz8puyRTH4ln2cjdZo+WAwJ
         VwMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBRGUDpZ8of1rvhS1B+BZPNbEemlyaWTY0H5v/Uz1Iqen7aCfKNAI888cPmkq+vJKDqu734DjwQqX3HveT7g4m@vger.kernel.org
X-Gm-Message-State: AOJu0YzJUPN2xQhzELZEolbT81GGEGotRAFtRh/SY4fAT32ifQSDgEY2
	kW4/Kg4GJweWJq9tFYa2g0xHVgcMAbnl77JynZR0OS+kZz3GN6yv08M5fEUkjb4bqnJYBfHlNM+
	RajmdU0wKeoG4J302ook7WLR3HnJJmvVCHxYtedlgEFZ5TKrBwmAK
X-Gm-Gg: ASbGncsizMYjYBZgyu0a0LaLs/AzE1WfDqcZ78aBBSyMsQ5zp5zz5RJccElNw437QOp
	lTnWvPPT90j3+0+tN3xH7ueRnXb0DbWy2
X-Google-Smtp-Source: AGHT+IGJtjwJHAQsSLgiWc5Li3w18zYO/PzbZ+kAbilKcgZZ5rvAE4pC+0zbV7W/oHUrm0RGdQr3vvEFSZNivzhE3z8=
X-Received: by 2002:a05:6e02:1d1b:b0:3a3:f86f:2d1f with SMTP id
 e9e14a558f8ab-3a50b47f5e5mr6322215ab.23.1730256340327; Tue, 29 Oct 2024
 19:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025090307.59127-1-james.clark@linaro.org>
 <20241025090307.59127-3-james.clark@linaro.org> <ZyGA9cjrtbE_eWik@google.com>
In-Reply-To: <ZyGA9cjrtbE_eWik@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 29 Oct 2024 19:45:26 -0700
Message-ID: <CAP-5=fW=DfWK9qvrtxp7z+N7aELar2xMts_=twUjWbfEQ_9vHg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf stat: Also hide metric from JSON if units are an
 empty string
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	acme@kernel.org, tim.c.chen@linux.intel.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 5:42=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Fri, Oct 25, 2024 at 10:03:05AM +0100, James Clark wrote:
> > We decided to hide NULL metric units rather than showing it as "(null)"=
,
> > but on hybrid systems if the process doesn't hit a PMU you get an empty
> > string metric unit instead. To make it consistent also remove empty
> > strings.
> >
> > Note that metric-threshold is already hidden in this case without this
> > change.
> >
> > Where a process only runs on cpu_core and never hits cpu_atom:
> > Before:
> >  $ perf stat -j -- true
> >  ...
> >  {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_atom/b=
ranch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00, "metric-value" =
: "0.000000", "metric-unit" : ""}
> >  {"counter-value" : "6326.000000", "unit" : "", "event" : "cpu_core/bra=
nch-misses/", "event-runtime" : 293786, "pcnt-running" : 100.00, "metric-va=
lue" : "3.553394", "metric-unit" : "of all branches", "metric-threshold" : =
"good"}
> >  ...
>
> I guess you're talking about "metric-unit", not plain "unit", right?
> Then please update the subject line to reduce the config.
>
> Ian, can you please review?

It'd be nice to see the stack trace for when metric-unit is "" as I'm
not seeing the logic in stat-shadow.c. If we know the caller than it
seems logical the unit can be passed as NULL rather than "".

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > After:
> >  ...
> >  {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_atom/b=
ranch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00}
> >  {"counter-value" : "5778.000000", "unit" : "", "event" : "cpu_core/bra=
nch-misses/", "event-runtime" : 282240, "pcnt-running" : 100.00, "metric-va=
lue" : "3.226797", "metric-unit" : "of all branches", "metric-threshold" : =
"good"}
> >  ...
> >
> > Signed-off-by: James Clark <james.clark@linaro.org>
> > ---
> >  tools/perf/util/stat-display.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-disp=
lay.c
> > index a5d72f4a515c..9b7fd985a42a 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -506,7 +506,7 @@ static void print_metric_json(struct perf_stat_conf=
ig *config __maybe_unused,
> >       struct outstate *os =3D ctx;
> >       FILE *out =3D os->fh;
> >
> > -     if (unit) {
> > +     if (unit && strlen(unit)) {
> >               json_out(os, "\"metric-value\" : \"%f\", \"metric-unit\" =
: \"%s\"", val, unit);
> >               if (thresh !=3D METRIC_THRESHOLD_UNKNOWN) {
> >                       json_out(os, "\"metric-threshold\" : \"%s\"",
> > --
> > 2.34.1
> >
