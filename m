Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE2A1F4738
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302750; cv=none; b=nZcz5u+e7P7SqHza3glZuWPCsgTeQ7HnvWdgSxXJaGNPRT9WL6nZnjcvFLj8EfHuIF+Jn2l9lvQ6HEavHhBX3cw+564Krm+VwQcQ6Pvg8au4w3YQw2mGYO3+8GH2y0WcqrUOuj549AuBYc8gsaK0HmHQUKEl/TZoIocex01wNDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302750; c=relaxed/simple;
	bh=G2jmoUbZWmeucgcA5V400Itpx6H5+Q9/pVo3PqRvsIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqBN5RQzmNt9ZuzqswqJpmd1iZc2/kUuRTh4k4AHEgW8KLkL3aW3D+I3ak22I9RQKuBJTO815dUH8DDtTSHZdg1gEG2g9Uzv1Jlvl3D/9mh4gmSJVMTjfuUkOCmI0grVhjuc1pZenY+uiGWP/oWdhqrlywWWAtU6jed/XBAlKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ouD0ZFgW; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ouD0ZFgW"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so271675ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 08:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730302747; x=1730907547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66zbflDx6zqJBO5nUu4XlW0w7XH1NmLpzk/AkOmTTzg=;
        b=ouD0ZFgWJrrArKDJ+ENf6DfKJgnGCvA1tdU5cfxin1Z7Cr10BhOomqwJAYIXLznRbF
         lOEy/p9rTCwQF8e1POY9KuL86yKoROy8f6HYYjpQcDPEDDOU1s56b5rxvOUqazd48/VQ
         wKbUMwiD2uX52EmFjz//j1UNSGpBLkOmjD3nf8GwgGxvkGtWwffEdl50+LiZGCZLtGT1
         gsVMa8yCaBSgrZORNE/IvN6TAImx3qTJLSkYiEjyMrh3cChVyhfqTfb+XZSg+MEw4TDv
         NbfNx3aQQNE8UZOvPrPj/xkPeWyxuc+QrkSfnXVA09TyhqC3lWDVS/xzvSZhxpvo498H
         JCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730302747; x=1730907547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66zbflDx6zqJBO5nUu4XlW0w7XH1NmLpzk/AkOmTTzg=;
        b=iZcjRuqexRoPjRpABaRP+cAjv4Ba4n6/3hyo1QZOJ88XMgnBipa0T7YJXUhShPkLP8
         B0Mptwu45yxdifsFYt8tCVTQhkwGs0TIYG2MPOk1bhEKZaD9sL9NrHtPfj+m8ehFWh1U
         8Racmjq6Y6Qv+oPVO7x14KhqCL0bJeypA/muvG23ekvdGMmuoHudQe3kYnqSVZjyYRdj
         FpRSRmOqWGHIZjwKAfpHE77YRyAWrEdJivyb/qy7Ar62SFpvLSLQb0aY4EuYqjBnwLWh
         9wjxq+xXLSKdFLEhQ1Kv/JQ3UFwmbV+tM8PEjWklGr8QbNKXR85fLLjHtXi17A+VOnjk
         9vSA==
X-Forwarded-Encrypted: i=1; AJvYcCV9FVyqc061JZbdcWbH6oGcKaD76oetJuMockHAgbgin10cCEckwvm2q3V2lXCuBA3XVfo8+zgMCcu5kU+/bfdT@vger.kernel.org
X-Gm-Message-State: AOJu0YwpPUyjSfiIf1Nm5HyXZrsEXjf6hkFUVErv4scBgZgFdD0pSbId
	XBSBTo8ld+SOZTKDEcMBPVsrtcdW+7Im9I/1BbIDdyI2TUDrOSt0Oor+6Mv7MGg/fvjSOsvypmF
	3u+bBdIhgJTY9NArFjdMkvhiGRWWrH/GZIEXX
X-Gm-Gg: ASbGnctcuGG53kbdhvqmMWbcOgqy6zUjS8tC7ME2GfIARlf44XRNjDx602Hkg8OwRmP
	EuRCXIzclrlOIfK8G8MyHNGpk8XCu4LJrwobSCrT0AYvCphDg0uSui3hqaR6Hp2sh
X-Google-Smtp-Source: AGHT+IERGcd665gPU5pcuGcGkzWNZoCAuE/ytmNq8trw7X7OcueUsdQLotRDk3jolftkSsp1HOEHIrleWV51tJpgKy4=
X-Received: by 2002:a92:ca45:0:b0:3a3:a639:a591 with SMTP id
 e9e14a558f8ab-3a509bf11dbmr9250295ab.8.1730302746965; Wed, 30 Oct 2024
 08:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025090307.59127-1-james.clark@linaro.org>
 <20241025090307.59127-3-james.clark@linaro.org> <ZyGA9cjrtbE_eWik@google.com>
 <CAP-5=fW=DfWK9qvrtxp7z+N7aELar2xMts_=twUjWbfEQ_9vHg@mail.gmail.com> <1ab9d5be-b31b-4f76-9ccd-001603a55e53@linaro.org>
In-Reply-To: <1ab9d5be-b31b-4f76-9ccd-001603a55e53@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 30 Oct 2024 08:38:53 -0700
Message-ID: <CAP-5=fW9fy3PEicYgmhqQFUJmJaFs_LiponqYwEJGc7u7KQcxA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf stat: Also hide metric from JSON if units are an
 empty string
To: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, acme@kernel.org, 
	tim.c.chen@linux.intel.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 2:36=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 30/10/2024 2:45 am, Ian Rogers wrote:
> > On Tue, Oct 29, 2024 at 5:42=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> >>
> >> Hello,
> >>
> >> On Fri, Oct 25, 2024 at 10:03:05AM +0100, James Clark wrote:
> >>> We decided to hide NULL metric units rather than showing it as "(null=
)",
> >>> but on hybrid systems if the process doesn't hit a PMU you get an emp=
ty
> >>> string metric unit instead. To make it consistent also remove empty
> >>> strings.
> >>>
> >>> Note that metric-threshold is already hidden in this case without thi=
s
> >>> change.
> >>>
> >>> Where a process only runs on cpu_core and never hits cpu_atom:
> >>> Before:
> >>>   $ perf stat -j -- true
> >>>   ...
> >>>   {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_ato=
m/branch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00, "metric-valu=
e" : "0.000000", "metric-unit" : ""}
> >>>   {"counter-value" : "6326.000000", "unit" : "", "event" : "cpu_core/=
branch-misses/", "event-runtime" : 293786, "pcnt-running" : 100.00, "metric=
-value" : "3.553394", "metric-unit" : "of all branches", "metric-threshold"=
 : "good"}
> >>>   ...
> >>
> >> I guess you're talking about "metric-unit", not plain "unit", right?
> >> Then please update the subject line to reduce the config.
> >>
>
> Yep I'll update it.
>
> >> Ian, can you please review?
> >
> > It'd be nice to see the stack trace for when metric-unit is "" as I'm
> > not seeing the logic in stat-shadow.c. If we know the caller than it
> > seems logical the unit can be passed as NULL rather than "".
> >
> > Thanks,
> > Ian
> >
>
>
> Here's the stack:
>
> print_metric_json() (stat-display.c:516)
> printout() (stat-display.c:912)
> print_counter_aggrdata() (stat-display.c:1110)
> print_counter() (stat-display.c:1224)
> evlist__print_counters() (stat-display.c:1734)
> print_counters() (builtin-stat.c:1016)
> cmd_stat() (builtin-stat.c:2872)
> run_builtin() (perf/perf.c:351)
> handle_internal_command() (perf.c:404)
> run_argv() (perf.c:448)
> main() (perf.c:560)
>
> The empty string is from printout():
>
>    pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=3D*/NULL, /*unit=3D*=
/"",
>       /*val=3D*/0);
>
> Changing it to NULL seems to work, so is probably a bit neater. I can do
> that if you think that makes sense?
>
> There's another one for --metric-only that I didn't run into, but it
> could also make sense to change:
>
>    if (config->metric_only) {
>      pm(config, os, METRIC_THRESHOLD_UNKNOWN, "", "", 0);

Yeah, it looks like all the callers should be passing NULL. I feel
more comfortable doing this than ignoring the empty string which is
something a json metric may accidentally do. Could you send a patch?

Thanks,
Ian

> >> Thanks,
> >> Namhyung
> >>
> >>>
> >>> After:
> >>>   ...
> >>>   {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_ato=
m/branch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00}
> >>>   {"counter-value" : "5778.000000", "unit" : "", "event" : "cpu_core/=
branch-misses/", "event-runtime" : 282240, "pcnt-running" : 100.00, "metric=
-value" : "3.226797", "metric-unit" : "of all branches", "metric-threshold"=
 : "good"}
> >>>   ...
> >>>
> >>> Signed-off-by: James Clark <james.clark@linaro.org>
> >>> ---
> >>>   tools/perf/util/stat-display.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-di=
splay.c
> >>> index a5d72f4a515c..9b7fd985a42a 100644
> >>> --- a/tools/perf/util/stat-display.c
> >>> +++ b/tools/perf/util/stat-display.c
> >>> @@ -506,7 +506,7 @@ static void print_metric_json(struct perf_stat_co=
nfig *config __maybe_unused,
> >>>        struct outstate *os =3D ctx;
> >>>        FILE *out =3D os->fh;
> >>>
> >>> -     if (unit) {
> >>> +     if (unit && strlen(unit)) {
> >>>                json_out(os, "\"metric-value\" : \"%f\", \"metric-unit=
\" : \"%s\"", val, unit);
> >>>                if (thresh !=3D METRIC_THRESHOLD_UNKNOWN) {
> >>>                        json_out(os, "\"metric-threshold\" : \"%s\"",
> >>> --
> >>> 2.34.1
> >>>
>
