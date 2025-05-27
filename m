Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EA419F43A
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748378029; cv=none; b=ORaPlx4XC1QLS0wN83j+mL1e1jD5+ZEUSz6BTCN91YGlL72+DMs4MIbgadDOZOtWb1MzJIHP4lHe9mwOWSvy5rW6Lnhf9ESo7EqBsycE2+jWRGbaJEePrXBeBFKHM+aEfvRxh+q7rpAtvyG8OILKTVlN19C/yjcem3rXF8WVCFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748378029; c=relaxed/simple;
	bh=DjtB8BRpaDcJZqUnxCsmRkSL3YrC18x5DJNTYGMvAhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3Zyo3WMHq2gkrFq0/CXUVyqNqWm52sLLz5tigTrgh9kjZzArRBI8IT4zlBYx5NzOKiSeNhm5DuzDY6YKCSmE69iW5Zk1OWSd4+dzEEIiWXZxrrcGen+6CcljsVnDPLmdMv10uIpcx8g1o1kTDuLUIqLbSe8WX/pA7+hkgrHdbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j0RQUW43; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j0RQUW43"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3dd745f8839so39815ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 13:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748378027; x=1748982827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vMM0EfVdDxW43a+3ih4QwmwFQMtKuGgo1WFCc3wMKY=;
        b=j0RQUW43ESZFahMBtCvM59fV6ryepuWVZAwk29kRQkYmp89GKgi7c2x+Rp7pLP2Wu1
         6njdb8pKqD5VY8sj0oHFwmB0qPvfu+kHxv19vw8Cl6xSuLv/AX5EjwbxYJ7DNQJZmhH+
         b4qTF2+YNi5+rMOIpd92qJ/VMLyY19G1wbXx9fN+8QQ2zsuy6aAytG/lBzgai0Dj3ZNa
         Gu9GSJgi6le3ViI0WsS+ouZHQdjhh4oCjGtl8Sgsa5IWwiU/jEhRShwtzZ2mhmgQB/DY
         qanCg7U3Mar6Xd7tYHYtB84kZWfDmiSPY7nSo3/iReuso1k5NOFz/P81pUUo8w6VRDkr
         T5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748378027; x=1748982827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vMM0EfVdDxW43a+3ih4QwmwFQMtKuGgo1WFCc3wMKY=;
        b=gQLKvD6fTnQEWYUx0XzXFWQdKWIUnAQFFxgfQxsgg3j93VH7pU6H7qFglAJFrrDr9L
         H2OwGdxanLT+NfMtxKw7pYsMDMcIpVCjo091vyatuYcrBlv/0NtK/kPtR4V73Se1k8FA
         KhxKrS9Zp1sEGMUqJBf45X0m9BetcR3xLbJ6wLlW2CgmbnlGORKIY9kZ+TPNgzWVv3LV
         yc127aYJ8D4daLGFmektgnruigkf4EzD26gAKoYFT5XVgoHALFWOd6M76CrodipLsPM2
         XLo2uqEcEOOB9hWw/RNC7y7OVc76v+s+Fi6tRZmK4V5LgZiylnU94cZ2+ssO5DZSGBLV
         Xl7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUg7tYH6UgaN8vwo/rbn2zhkSiXS3yR+XRQeTCSvHsWQtPWIk8zzAXlM3Anrvxwn6sY8fucJc8kIrEHnuod/Sjf@vger.kernel.org
X-Gm-Message-State: AOJu0Yza2eSRDHh6KbRH6WMqzq3qSo82IRf+lKgtz6d6aXt5tl6lYpTm
	OLyj4dpQgWlrTzNuUEdlZv1UpPWQnpTMqrbxhLGXfNAkd1KJ5BSWDQLhoEnNxDPfVrG5tBx6JYo
	8M0yCT8+6uKsiKp86eP3myh6n4Y/IxUyTlnr/jA8s
X-Gm-Gg: ASbGncsaaIIV1ossVJuLsRFvVirZZ5jPjeVAMf78majITDcV5jyRkmXq/3BNOFhLrj1
	PfAQv7jCBcrIKGxyzQkZtdLldfKtqH9unKA7hMm8MggMyn1Fy6g7Sgyfxv2qpnAlRAG/myANvaI
	iWZonj3Vrd5fJcIpVjSx/7NbE/9vroB1JIxeY45BgDibguGYEFThrDin/qtNWxTNdtvvDFqHCp
X-Google-Smtp-Source: AGHT+IFVysUrX9/RWGVD8jifme4FsJobwQ5MaMQpoCCukjVl5luhg+u6mLupYV+mhQR95neYD0HRetp3woSgDEpO6ag=
X-Received: by 2002:a05:6e02:1c26:b0:3dc:8116:44a8 with SMTP id
 e9e14a558f8ab-3dd88fc27f3mr702425ab.26.1748378027062; Tue, 27 May 2025
 13:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402211301.4153441-1-irogers@google.com> <Z_Af-KAKuOlqALH6@google.com>
In-Reply-To: <Z_Af-KAKuOlqALH6@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 May 2025 13:33:35 -0700
X-Gm-Features: AX0GCFutG5SackukbvsjFVPBuPGu8DTDm9ChuUzENA6lOgs8-Mu_3g5DN2PAm10
Message-ID: <CAP-5=fUiWm9kq2fhT-9+8LOmC2Yen9Mw2P8yPLTJH+nk83nmmA@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmu: Avoid segv for missing name/alias_name in wildcarding
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 11:07=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Apr 02, 2025 at 02:13:01PM -0700, Ian Rogers wrote:
> > The pmu name or alias_name fields may be NULL and should be skipped if
> > so. This is done in all loops of perf_pmu___name_match except the
> > final wildcard loop which was an oversight.
> >
> > Fixes: c786468a3585 ("perf pmu: Rename name matching for no suffix or w=
ildcard variants")
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Ping.

Thanks,
Ian

> Thanks,
> Namhyung
>
> > ---
> >  tools/perf/util/pmu.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 31f1e617eb20..d27bdf421c19 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -2060,7 +2060,9 @@ static bool perf_pmu___name_match(const struct pe=
rf_pmu *pmu, const char *to_mat
> >       }
> >       for (size_t i =3D 0; i < ARRAY_SIZE(names); i++) {
> >               const char *name =3D names[i];
> > -
> > +
> > +             if (!name)
> > +                     continue;
> >               if (wildcard && perf_pmu__match_wildcard_uncore(name, to_=
match))
> >                       return true;
> >               if (!wildcard && perf_pmu__match_ignoring_suffix_uncore(n=
ame, to_match))
> > --
> > 2.49.0.504.g3bcea36a83-goog
> >
