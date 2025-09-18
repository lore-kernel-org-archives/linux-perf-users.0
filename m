Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A901F4181
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758231535; cv=none; b=efLeWDrVxfFnDcdxFFvHB4+BVqe0jYaGh5+pbYHswuupXWMVNoDjPLkuj9sfAFBgCH5ECqMUVd1u5yGvVHZYZ9CKeenRsZr/tqLkdrbkrjmTn1U536Ex1Bi8vsCyFsrfOw0druiV/BXcVtySuL6UjIxOGf15LShT9gN+uhgfyx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758231535; c=relaxed/simple;
	bh=mlY7FRbhytNYlxp/A30rSpN7iz0DKtsNb8dUg54WZYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CKSXoSU3Gik7OjkS13znCqGQpUYozA/ml7Yc5KHrI3svn6iDRfGZdLstlnlK//pm7I5gW4eitM1VflvJ0m7sP/A//k2I3TVYNg/ixgdRi8cB5AbEuJ0Ab2irrU1zx1sECYjyy0yl0sp9OtfvoQNjAf9kcsZIpNBfS/c+w9ksz9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v078hUY9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v078hUY9"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2681645b7b6so24045ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 14:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758231533; x=1758836333; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uvt9I2KpXbXrhZ6LPBcVnobYbaFag8C7jpCt8sntWwQ=;
        b=v078hUY9duiEa8FFeoA1RRjhG+6sf1HZ2Jt7zw0bvx31GJaQrxyzwdRV1CEif1XVHS
         MgU+tKd86qazkSuxQiNHppnb8gTVtvrFAtRjdqN1TDRuUe4waKaO49hXIJlq1lPr/yRF
         KepV2jW04rK8m1MIRd/WM+vcRW/AODPAzK7YS+LTROoAMaRM9TtdLoD1Unghj3KNcB5S
         XATMRhtIhbmwQ0D3cGraBwd+VTdHTXVj8HKl1MNRHmFxXEtabevcJP3+MKYqJ8mDUkL1
         YdxC+DZRYrDXLsU0w2r0IhQfc0NfpjD+udPz+HJW8KiECpRAzlIO2LK299TjhREJgkc5
         3a9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758231533; x=1758836333;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uvt9I2KpXbXrhZ6LPBcVnobYbaFag8C7jpCt8sntWwQ=;
        b=OuyTTVGK3zLzoRXq1cxMo+LnvkT2hs0gVKBSkSKtKNBDoAcF32HooiqSXAfyF0CXnK
         baHOckNeRabO4fo4WeVcJqZQLvpyFC0goPhVyDrlLUxZJs+kk357dN+jqTAOLoQN2fvp
         ecpgicl8/rgpRiBbLT3jaKegM6f4fwPpWmJtg08rypo12XHt8T6DeppdNsUFdAWB/NlV
         m0O93TatCH1DuQHiEfrfYVF9NvyxpdHhJRlQS+HWeAJ+I1drrsFyVJevKgiiA93Z2UqF
         Anf1lgUAKNB3O4GWBph6ZHnS7JlYFQAxAJDaVMYnrP3bAPlWH862qoe1oOlwnGFNLEkD
         5+2w==
X-Forwarded-Encrypted: i=1; AJvYcCX5N+6rvOt2hjwK5F90nm1EVqW12QF2CxP/2iP5QbbyMxXW3MwpYFWWMNeagl6545jSwVyYE/UBqw1dXxnCyV/Y@vger.kernel.org
X-Gm-Message-State: AOJu0YyFPwTwHYlCnUiTY0Reb/vyzzXXufTVok7wuzTH8tWll/u18Lls
	2ol0wNTaRt7GkE8ti2Wf8xU/GPg3RYZ2Pp/05w4/WaTjonLvD4G0lcjxxU8iMIXzZM2UHVpg2Or
	R+ASZaBxAiMHywK2CO34/NMntagKbkK43gw6hiXAc
X-Gm-Gg: ASbGnctNMwzeKUcjbSfDoq7ACKrJSdI4g/UY48wnmDLgWjAEl4BrxlgUTcvKj43y53C
	toH6T2ubRYSsqN1KjTvS/6yBVV7sPy6qJauwpQkH8MivgNzrMFefH165PftJ4LK00apN+LloyYN
	MjumqJarUyg+aMxMQSfrm+WvjLfSeOWwzuNxeVG/0a2DG1AIfNDJEqZdrRVaysxVv8YDfMbXIOJ
	+DUqAXCZ7o3KiJTgmOVKo4z5Tq6WEkr/FufrqTrpI0CEKLccz3QnpuBRnkcMnWWTppP+KsafQ==
X-Google-Smtp-Source: AGHT+IEaM4g2Y8nKc/gcP9AcbrDAw1aDgaCeO1MRm5LbJRIzEkkSSQzEpma1EJld9tYPD/d5gUX67e9HULwVBWwB//U=
X-Received: by 2002:a17:902:e5cb:b0:24b:1741:1a4c with SMTP id
 d9443c01a7336-26800b2b62cmr12430905ad.0.1758231532766; Thu, 18 Sep 2025
 14:38:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830053549.1966520-1-irogers@google.com>
In-Reply-To: <20250830053549.1966520-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 18 Sep 2025 14:38:39 -0700
X-Gm-Features: AS18NWCtNfjGCSBOwnkEpIjtbpn08E3tdUXPQtKV_R7nWrrdnAAsLsdiNocA4uU
Message-ID: <CAP-5=fUiSVg5QYBHKT2nM1JyaEqZ-mn2_YrTo+P92_GrwHTxgQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf bpf-filter: Fix opts declaration on older libbpfs
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Hao Ge <gehao@kylinos.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 10:35=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Building perf with LIBBPF_DYNAMIC (ie not the default static linking
> of libbpf with perf) is breaking as the libbpf isn't version 1.7 or
> newer, where dont_enable is added to bpf_perf_event_opts. To avoid
> this breakage add a compile time version check and don't declare the
> variable when not present.
>
> Fixes: 5e2ac8e8571d ("perf bpf-filter: Enable events manually")
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  tools/perf/util/bpf-filter.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index a0b11f35395f..92308c38fbb5 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
> @@ -443,6 +443,10 @@ static int create_idx_hash(struct evsel *evsel, stru=
ct perf_bpf_filter_entry *en
>         return -1;
>  }
>
> +#define LIBBPF_CURRENT_VERSION_GEQ(major, minor)                       \
> +       (LIBBPF_MAJOR_VERSION > (major) ||                              \
> +        (LIBBPF_MAJOR_VERSION =3D=3D (major) && LIBBPF_MINOR_VERSION >=
=3D (minor)))
> +
>  int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
>  {
>         int i, x, y, fd, ret;
> @@ -451,8 +455,12 @@ int perf_bpf_filter__prepare(struct evsel *evsel, st=
ruct target *target)
>         struct bpf_link *link;
>         struct perf_bpf_filter_entry *entry;
>         bool needs_idx_hash =3D !target__has_cpu(target);
> +#if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
>         DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts,
>                             .dont_enable =3D true);
> +#else
> +       DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
> +#endif
>
>         entry =3D calloc(MAX_FILTERS, sizeof(*entry));
>         if (entry =3D=3D NULL)
> --
> 2.51.0.318.gd7df087d1a-goog
>
