Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA44211721
	for <linux-perf-users@vger.kernel.org>; Thu, 16 May 2024 05:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715835898; cv=none; b=Q7yjkK/exHjrhqCtnAInW+0jEnNtNJZyn5JHfk0R7RenPxHxg4NfxY3ifTkRDqd6+hClfDXV8qPq3CKGB/Jtw75h3Zj5XSoQDnlRjvGm3II6I1qp18571bpL7iIkyH+zV651cIrHEQlPnatw2U1EGu44BNzOa5PX2NHLNam2Qko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715835898; c=relaxed/simple;
	bh=KsZqB9Nc++1f2JW88Ah8LooOEDUxTd/rxuTVQxTapyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=UQGlEbmpJ8CETWVptiQZrhGsitr8WE+yJgQMNwrdb/azHzz81tUQiSCzQzMY9IMBiv6PnWg1s1Y7TQnUt1E9oSPRtqo1lnMGJeIj5kc5sAhGFPC5OqnZoBOSPVue7D4t+dnqq9du/dYAOYaCAhSVQoCorIvqdQQFu56GJaN7qlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0xJuJhfh; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0xJuJhfh"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43df9ac3ebcso2405161cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 May 2024 22:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715835895; x=1716440695; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQ2BUrI4nA4aMqiJQpw6TRcFQ7FyURr1y+deeKNa2KE=;
        b=0xJuJhfhO10M8YW1sfgMSZe9zjaPoYMLSCr0kyavNp9OxDnH55jRV8gq4OwVDTtzVV
         S7v5QKMTNqJetuu3g7WAFO459906V/VJ+6VTJQvtbH8GtJ1DstCu2voPddvpBk8iSA82
         xRt/zIIVFL3QHF3fRzovud6m+OUiravriNRCswoAI/9JcphQC4PrMKjbmouBagUeBhoE
         yMKovw5KXj8iM+3tw6jTy83lx/wKbiRNhg5qs2T0zxYsRIvz11LLEwA3n8V7Rod8btZE
         g3IhAz7uo+WwBZaZ5eUi6kVnSCKX7N/Ed/sPAyx9qBhVhbFrQDK9kBxGFCJWiO8T/x7G
         z4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715835895; x=1716440695;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQ2BUrI4nA4aMqiJQpw6TRcFQ7FyURr1y+deeKNa2KE=;
        b=h9P4T/jQA+WqtQq3GnqWnhsVx8rt2MgnSBAgAuWW7wGcbHPzvaqlMe8vZ6xM9UOsZx
         OlhXj0zl+FBgMqUUpfQnkARa3rBUHHuevAcLszsmohGE5QbKO19qzEOCfYWx+MzWUvQP
         aAsVamwzJJHmEEdauBJ8AHbCxFrQKb5Jh6sW1RroU2mbSNEKe8uevydRS8p17lzTcQG2
         97yzC2c0kYHxXmyEXFJATSjU7vFkAdBvBojKs1pkK3H0Lja5vjqgO9v4310Ajge+v2+Z
         tra0odO0h4CR6BaEEEQcW/aHioXn4HWFN0fxP9mZPBNj1CqW9ZI9J8tRs7uuVUB8sglU
         3T/g==
X-Forwarded-Encrypted: i=1; AJvYcCWKo57mnZSz083gTSMFY6Xt2c7e2C6EQiGoX2NDfOhF0slnn+Uu5zoecJCcGwOdnaPUHDkSntLs9DTqs7G+emFsQq/G9wjsQIJHzTB5tLm6HQ==
X-Gm-Message-State: AOJu0YyF/vZp6yu9p2NVdKe63eOkUXzCRpTxOllJYT2BLp6cLCnNGqkk
	EaX3c8hpp36Atoh9adwsrNnqg6TA12df9r/O6yD11SNwfpifg800IcRAEVWtmzH2qEw3krkVWGI
	eynByjydhK/zPKjfn3Bf7Znb9G+R1lmcBIkCO
X-Google-Smtp-Source: AGHT+IFdCOpo9CTmEBe6R3dl72AtUqLUZ+386ogOqBR9a8yxYG3hJ321sFlDlm2ZYE/FIMcMokrMttTHp1aGLlB7EwA=
X-Received: by 2002:a05:622a:7e0a:b0:43e:a94:c1c9 with SMTP id
 d75a77b69052e-43e0a94c28dmr12178511cf.20.1715835895129; Wed, 15 May 2024
 22:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516041948.3546553-1-irogers@google.com>
In-Reply-To: <20240516041948.3546553-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 15 May 2024 22:04:43 -0700
Message-ID: <CAP-5=fW8TA0KQOepQRuC_0mhyp6kHbPodh+6-uoVxsmC=09tTw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Use BPF filters for a "perf top -u" workaround
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 9:20=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Allow uid and gid to be terms in BPF filters by first breaking the
> connection between filter terms and PERF_SAMPLE_xx values. Calculate
> the uid and gid using the bpf_get_current_uid_gid helper, rather than
> from a value in the sample. Allow filters to be passed to perf top, this =
allows:
>
> $ perf top -e cycles:P --filter "uid =3D=3D $(id -u)"
>
> to work as a "perf top -u" workaround, as "perf top -u" usually fails
> due to processes/threads terminating between the /proc scan and the
> perf_event_open.

Fwiw, something I noticed playing around with this (my workload was
`perf test -w noploop 100000` as different users) is that old samples
appeared to linger around making terminated processes still appear in
the top list. My guess is that there aren't other samples showing up
and pushing the old sample events out of the ring buffers due to the
filter. This can look quite odd and I don't know if we have a way to
improve upon it, flush the ring buffers, histograms, etc. It appears
to be a latent `perf top` issue that you could encounter on other low
frequency events, but I thought I'd mention it anyway.

Thanks,
Ian

> Ian Rogers (3):
>   perf bpf filter: Give terms their own enum
>   perf bpf filter: Add uid and gid terms
>   perf top: Allow filters on events
>
>  tools/perf/Documentation/perf-record.txt     |  2 +-
>  tools/perf/Documentation/perf-top.txt        |  4 ++
>  tools/perf/builtin-top.c                     |  9 +++
>  tools/perf/util/bpf-filter.c                 | 55 ++++++++++++----
>  tools/perf/util/bpf-filter.h                 |  5 +-
>  tools/perf/util/bpf-filter.l                 | 66 +++++++++----------
>  tools/perf/util/bpf-filter.y                 |  7 +-
>  tools/perf/util/bpf_skel/sample-filter.h     | 27 +++++++-
>  tools/perf/util/bpf_skel/sample_filter.bpf.c | 67 +++++++++++++++-----
>  9 files changed, 172 insertions(+), 70 deletions(-)
>
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>
