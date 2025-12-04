Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F000B3002D2
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 16:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764866088; cv=none; b=W0nPeQ9nDr79hw7GWtzt1UUNE0Y5vANt/fWZ1m2SWlRNZAY9ECzk7JN2BP++cIM4UaNeXMghj8/5OWjOZ4pI3G4mWkVWPR1e9xDDK3TZwKq0zCobvYbJuCeRMJViVhJ5PLwQGkj36WePpbeya4THWYFn/FQD0nfsgkJdrJ4O1SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764866088; c=relaxed/simple;
	bh=HSVJVX/n268EMZnqAI5ikXT9w5SX5tC7rH+iuc7+ZPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWLnyXRiZbA2slfA24FPyEd/2m+vzCXx5ID9n6Z5CT4hXxrsrdd3U/kJbsTOo2jXsqTDCuV7QCjxTE2rTKw4GwELq9vKoJCvFRXlt2bJvYzDyILIRKWh2KuvnnMvTLnI2x09M5QOTVUMvqwQBff96C5LHYsgg+Cl9V9mwF3Gc6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OBI55Ncv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OBI55Ncv"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2980343d9d1so184495ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Dec 2025 08:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764866086; x=1765470886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AcWJJyzETe4w2GNBYWS5hvj8HkwhBapQTLITheouq0=;
        b=OBI55NcvOmUr5u3VM9s2c3Q4wptMFofen0Da6o2IOiOyF6h+GsZRzEAS4MfuWxWUD9
         7ILWWhQGbCedE9mlHM3wVyYZEMiYwEd2AfkM1pNryK2A9suBu4dAjkBldn8taMH8vJ1h
         4yocYQKr21i1tlEqATMvXQq5M9X9LmvyAT0YikoP+2/DxjFtPbvyqbEcX06fonMcHybK
         mndW5x8GEmq0HG61OR4OlYkfwkT8x2xc9QrNzeIw/8ylVAKmC+LiaWiWJWSJ6m326iM1
         G0s5o6CkzPsoKTtIHV9AmureHSDJCW+KxbrL0KGWIpE+E9jYsZhvCPNRUxveYIICEXOA
         fQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764866086; x=1765470886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/AcWJJyzETe4w2GNBYWS5hvj8HkwhBapQTLITheouq0=;
        b=KZGXJzGVV0VWvS9T710jBD6YXjFP1aGnu0zbl1vMugm7CRKB8mWbzK4tt5MAvWL9yh
         rIIUUZbYE/P8Ka97ST5KyEV4jR6S7+wozmGDBIVwAY/TAXMF8NIX6T4PFKCe4npVjcLE
         6RWvhB/O87m6hAQmPysMdPbaoa6HaZfQXY+dtf52AY+JtczQBB4eD0Zp7UMN02fr5vWE
         J6lB82/vyYXWZSy81ep0urTzgiVG9HoSQtLdpo+FBsWmgeY++z4azvJE8c4HIfKfwkyd
         XvmvH8y7xUKpEnKsKGVfpUrqlDeg8RG2mJLTi5ezaHfwb87J62kyc9JTCoPVdc7NOrQr
         OikQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyUu1BV45kW/wayvgMLUd32vfZO8FanIrErcHzo7KhQ6NwwrRqGCj237/rfDkiK4ebe0ZizryhA6W07flSOv3c@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqii3DM+SgDn4B58a8i7DkR8uES4h7G78SNTnOigmXA94tDxnT
	lgOdMwvDFX1jhpiRaOr3hKQml2JDSDGaokV+SEwUnJJkJUkN3D/nxmlEFrcATN5BmCB65ghPMkW
	442ZMfLOW/xZI1wU2yVCW7cbRJNoBKKkRmDDMHYXE
X-Gm-Gg: ASbGncvR/EaIxeoIZkTke8FducquTFJM0Mrx2Ocnb88C/VFkaMM68HAiDK7RmnhGUZR
	s96o7xXOw5z7L2AqJAc9mPbtDIAz2NxlsUl360H+6Vp1xE78BM8IXbuVzhFsOoAIsRiJ/t/KrBL
	k8XOsUtjeGou/DtnR22gwB1e4VT6aJpch0YfqV6SiRwhIuWYr6ZjuV9EA62NxWLBHRJ5UojOvB0
	rP9692j8GpmS/Z7Hxx/0REm0nuH+BA3KRmJGx2M4gGxBRicgDOHDnR6eBb8/nYBXvzKuNHSRjU7
	zpXjWxyNX7NPvabaCRfCN/gfNg==
X-Google-Smtp-Source: AGHT+IH3mVSrU0OnafrXh+uURgCaYj76UpWY1SsK1ThMzIcTKcLwxghzniPfUirNRjKmcxHkQZnbrRuapkSTHnwusLk=
X-Received: by 2002:a17:902:d2c6:b0:290:dd42:eb5f with SMTP id
 d9443c01a7336-29dbe9004bamr807655ad.12.1764866085880; Thu, 04 Dec 2025
 08:34:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204-james-parse-events-test-v1-0-e6f922ca395e@linaro.org> <20251204-james-parse-events-test-v1-1-e6f922ca395e@linaro.org>
In-Reply-To: <20251204-james-parse-events-test-v1-1-e6f922ca395e@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 Dec 2025 08:34:34 -0800
X-Gm-Features: AWmQ_bknUP6fLVPziSbdGpYR0oxKzgBNo8t6gY9AEMWkZTY8dgNc40lg2MF2q9A
Message-ID: <CAP-5=fUJM5GYjSQafR+c_u19PF4_SS=1zFq0nGUHC3=XYYQ+VQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf tools: Always uniquify event names
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 1:11=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> evlist__uniquify_evsel_names() only gets called in __parse_events() if
> verbose is > 0. This means that the auto added "slots" events stay as
> "slots" rather than being expanded to "cpu_core/slots/" unless Perf is
> run in verbose mode. This is invisible to users when running Perf stat
> because evlist__print_counters() always calls it regardless of verbose
> mode before displaying.
>
> The only thing this seems to affect is the test "Parsing of all PMU
> events from sysfs" which fails when not run in verbose mode.
> test__checkevent_pmu_events() always expects event names to be prefixed
> with the pmu name, but this only happens for "slots" events after
> evlist__uniquify_evsel_names() is called.
>
> One fix could be to relax the test to accept the non prefixed name in
> normal mode. But seeing as Perf stat uniquifies unconditionally, make
> parse_events() do the same.
>
> This fixes the following test failure:
>
>   $ perf test "Parsing of all PMU events from sysfs"
>   5.2: Parsing of all PMU events from sysfs                    : FAILED!
>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

I wonder if we should just always uniquify event names. It could be a
thing that is changing as more and more PMUs are available. I'm
reminded that we used to uniquify sometimes with "<event> [<pmu>]"
prior to commit 057f8bfc6f70 ("perf stat: Uniquify event name
improvements").

Thanks,
Ian

> ---
>  tools/perf/util/parse-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 17c1c36a7bf9..50e88c9d3d46 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2217,12 +2217,12 @@ int __parse_events(struct evlist *evlist, const c=
har *str, const char *pmu_filte
>         evlist__splice_list_tail(evlist, &parse_state.list);
>
>         if (ret2 && warn_if_reordered && !parse_state.wild_card_pmus) {
> +               evlist__uniquify_evsel_names(evlist, &stat_config);
>                 pr_warning("WARNING: events were regrouped to match PMUs\=
n");
>
>                 if (verbose > 0) {
>                         struct strbuf sb =3D STRBUF_INIT;
>
> -                       evlist__uniquify_evsel_names(evlist, &stat_config=
);
>                         evlist__format_evsels(evlist, &sb, 2048);
>                         pr_debug("evlist after sorting/fixing: '%s'\n", s=
b.buf);
>                         strbuf_release(&sb);
>
> --
> 2.34.1
>
