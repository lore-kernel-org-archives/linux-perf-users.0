Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FE61E6DC7
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731966049; cv=none; b=aGUkVbfLfp07X92fyuh35I1uUcM63rnlhQ65BqSlL0R/ns9QGp1s9CETtdg1H+Ta30Z7xrrm+djaEdd2QBVNiEgRy2ymWlxZbcgNn7bywmLnytaYzJh0TDVI+vBsJmdPktWZQ1et3T8+nj3e5Kq+dkvNg2k9nkE4B0UJkKKuXiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731966049; c=relaxed/simple;
	bh=uKQsA83kSgwK4/juegq8cCGGDs9/o6uUKKfdmmcJQOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eh8O/cjGaOO1zZTW6xmp5AmQvWqo5WUvnjX/e1F3puKvh35P0VOUBvxKX+AtrNr6GJIE7UU7VejC32XbYqptGA0jdaDjontpcIm3FvhJmSACp3aTFjZIAhDl5Kz9QH98tcErg9IMQc/lLQInbjaXclKWnEmJx0yZPj/YvtYcDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ctLvCD4f; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ctLvCD4f"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a762686909so12005ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 13:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731966047; x=1732570847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QU0awsUw/UyfDM+Dhq/IzLTs77JmeAVE6zIoR24Kf6w=;
        b=ctLvCD4fuLgKjYoPVYaGeb6xsTwDu/DfusVeY6tkMHJ9i/LSldbjtD9c4wEoZLpVZt
         U/wBgbqkeCGqlR8bMJYePNb2MngLUsZs0PGcom2O2tKzocgE3umh9UZZwUM5D1XrCo/w
         3b3nmXGTIXGQOMYk3kP+hWDcT8PBGue55mwK0oMJ0ERcPiJEeSmpaGc1Gu3onxxsY34D
         myEM68zN14rGGhrw2CQbhS9daSp1CQd5ogXaac9DiWLzruyTFbO56tTSh7lO5tAudPhy
         ew0iPlDjLSGXEvSU+DudPt3Qv1QcMraFvyRp2B88NaaTfyMjDd8v7MSsCa8UVZKJONVx
         mpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731966047; x=1732570847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QU0awsUw/UyfDM+Dhq/IzLTs77JmeAVE6zIoR24Kf6w=;
        b=NXWq4ZJtUrHj/mACyEUsLYRB/AHEgPNwsaN74KBqHKlzGRUXz5DDbQYFMNaCWvVEDY
         3y794RHipVSX8FtChnTg3uwq9uHN0YVdMvpBN3m/R9qcuj3TTxL6UZg3LwLBuHJHVLQo
         anmlXbTiBdd7rXqmEFPueR1OZ3OKf8rTHn/3yjxDvmicKKM11JFxsldolj0Cm/be5Zl2
         DtPVceMEBrydEDlRcYIb/8u3inCRUOv/QEdCZRkGr/pC/YJx6iukz9DLU38S5a/2h/sb
         8T79VT1xS4MtIjMAIJJMjr4D7prknEpRbZHn8zsv6PtfJXNwkFihLXhCLW606+C+e2H8
         vrZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX42GYPKPnbv89ZE/p3WHiljKtpE4G4ZGrJj6J+FnVZ2gHlOOT3nxeReopPCsyJN8J+oh4YoHJZEnjiupUZXeCR@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ45OzBNU+vDTgTXzOQQLhWT8FXUXYdAXQr73HOfkXCTobCzK9
	OWUcdlcQaqn4IkdOcRWQgNdSHVLDNTdsNPbJ4sV8LiN/Oqlj+XkZdx3GcHKVKNYdUAZFK7G0Hlm
	u0tCiHbVLvhRAQ+WlFXfjBiejumbLourOsrUS
X-Gm-Gg: ASbGnctEAP2Xxjxi6X2NSSDSx3dLG7nZQ/vmcqJtuXhcogiq44lr2waxsxXRKMrbf7m
	eg+7xL08cCjpJFZDWG/W7KSnNbvGSm0PCHv2hRzonS1ciB2QQBXjIVpW33CqRt54=
X-Google-Smtp-Source: AGHT+IHn3SrOOCpPRDtbTI2eYLydyCCBMji04n8NVH3VQH3T3pP3+euC56uxwPIPNnGClZnw+pmt8kcUdBwY7OmlG24=
X-Received: by 2002:a05:6e02:2193:b0:3a6:ae08:f593 with SMTP id
 e9e14a558f8ab-3a778624858mr781075ab.3.1731966045713; Mon, 18 Nov 2024
 13:40:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118184145.8829-1-david.alvarez@bsc.es>
In-Reply-To: <20241118184145.8829-1-david.alvarez@bsc.es>
From: Ian Rogers <irogers@google.com>
Date: Mon, 18 Nov 2024 13:40:34 -0800
Message-ID: <CAP-5=fWf86BFpjvkUZ328o267afdsoXzZ3VgKwCF8gJUWntEKg@mail.gmail.com>
Subject: Re: [PATCH] perf: use C LC_NUMERIC locale for json output in perf stat
To: David Alvarez <david.alvarez@bsc.es>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 10:45=E2=80=AFAM David Alvarez <david.alvarez@bsc.e=
s> wrote:
>
> When using perf stat, the tool will use the system locale to format
> decimal values. This is incorrect for json output, since the user locale
> may lead to incorrect json formatting (which requires a dot as decimal
> separator). The following example is perf's output under a ca_ES.UTF-8
> locale:
>
> {"interval" : 1.005100134, "counter-value" : "0,486755", "unit" : "Joules=
", "event" : "power/energy-pkg/", "event-runtime" : 100240331, "pcnt-runnin=
g" : 100,00, "metric-value" : "0,000000", "metric-unit" : "(null)"}
>
> Solve this issue by setting the LC_NUMERIC locale to "C" when enabling
> json output (after parsing arguments).
>
> Signed-off-by: David Alvarez <david.alvarez@bsc.es>

Thanks for the report but ugh, this is broken everywhere. For example,
for CSV output the printf format is created here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/stat-shadow.c#n199
Before being used:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/stat-display.c#n417
On BSD there is a locale specific printf with printf_l, but it looks
to be missing with glibc and no doubt missing on all the obscure libcs
the maintainers test with. Given this I think this is the right fix
but wonder, should we just set the locale globally and not for json
output?

We could also change tests like:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/shell/stat+json_output.sh
to test both with the default and locales like ca_ES.UTF-8 (export
LC_NUMERIC=3D...). We could test other forms of output like CSV
similarly:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/shell/stat+csv_output.sh

Thanks,
Ian

> ---
>  tools/perf/builtin-stat.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 689a3d43c258..b9ebb06b254d 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2840,6 +2840,15 @@ int cmd_stat(int argc, const char **argv)
>         if (evlist__alloc_stats(&stat_config, evsel_list, interval))
>                 goto out;
>
> +       /*
> +        * For JSON output, we cannot use the user's numeric
> +        * locale since decimal separators must be dots.
> +        * Set the locale to "C" instead now that we've already parsed
> +        * all of the arguments using the user's locale.
> +        */
> +       if (stat_config.json_output)
> +               setlocale(LC_NUMERIC, "C");
> +
>         /*
>          * Set sample_type to PERF_SAMPLE_IDENTIFIER, which should be har=
mless
>          * while avoiding that older tools show confusing messages.
> --
> 2.47.0
>
