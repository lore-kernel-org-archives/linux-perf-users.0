Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3711DF258
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 22:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743545115; cv=none; b=CpCuuNNvvCNpfSLnfN6OjJ34h0RQHCmYZ3gndL/ZDjCqgf55jlT8frjCR0Myi4xtl9/hNJO7Jd5gt9I5cCY0UFnfjM5y2m0shlaLFDXD0L0i4xVyrP9+9rJFfdThXoWmskGTAw1rm3+NLeim1W/5UBP7+CbelUE/ZAgrIzUJjls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743545115; c=relaxed/simple;
	bh=HlGfv4iz54EHzctztjZOLKN1PODK/B4a3a8b77wJGvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mYRHq9ZcogkLURFP0poWH/7HfNftLCXy26ADmR+4inoSXq+T2arB6taKPTP+DmVT2eZWlojhA3izhfI8iWzyxvNNu0GfoeK1ulA6kO1nf0ECEt5zNN9UDmVPVnLJOG5oQrOEicuH3yk7wmLwU5uYRaGYJnQMhCy50FRWYUE3b50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z4mgXXJe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z4mgXXJe"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2263428c8baso25535ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 15:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743545113; x=1744149913; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qai9DMQZxsab9OWncJhs/lmdIQOyIQkiN593aFUVGd4=;
        b=Z4mgXXJeZ5tRradS8rNrR7KnMefeP0pSmfDlGFWgQGC+q+WVsN0QCgIRfpsnIGGsxA
         YZEbHGdh4BrSvcVjMuf0cQwD8JUZ1JnnXpCPnVEsBgLeFXkkmLvEfHMT1AqlMfu8I0CW
         JlvAypGhBNarNM509hA5xqQkIAoc36+VXV2prp4hZgD6sUpy69yoBbk1cXU0amlhoi0S
         5/VBYWjavbmm+XadowQdaNi2fPVtaf8dBWwvzvEx1tfcJv7t4rbytfmBXXnhzWD2luj7
         SU6BJUvxLNTU6W/2uvU/xp3uyO39RMdb9rjyH1NwjrLUmDJ6P3fs3bgcysjcrepQuKc0
         P2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743545113; x=1744149913;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qai9DMQZxsab9OWncJhs/lmdIQOyIQkiN593aFUVGd4=;
        b=wOgJ3hWWFRswhf7YjMVgmcvBpjY7JsF+wF4zx/DnxqJnbjNVmYlhe+cjgSRqe88yNo
         +fTRowmH0yU9wxKz0sMCm3DKh6wlhOK58KTCGgEt7N/pG4FEqMBPdD4hD6ymZmbMJaCT
         bJ7kLNMUJOmfK6jVv8/oCuHte3H4ABAAf/qVDqqRAjdz03kyVLXfbXMVMs2Ov56boHdd
         wgyXJuTbkB7eQqRkIi6e1gMoDYFwFp9ckHBvJCb9a5DXc2yWvyf2R4bXbZ7ZMmVB2wlu
         exT35L05IWSdDFwyLNdW5JIgRYiNk1kCi/bWU2qyqTf7A+/qpFBYVqvGYrLEClxjZ1qM
         Pn7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+Z1Cy2A4uedM1I+HzzK8473lX0SSyBja+aRYRTh7di+BahoGQNvVQXfqAlqpTUo5kZCXI9KOnYBjChhvi50ft@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Kei06bsgXW10/LhAzRdmSkf6dYfpfIIYxXHqu69SRJU9dDa+
	A4/+LLIYSyPPdmzrGv4N9Vb6TfC/EpIizMqD0/7CONY7zBc0lNMa6X+42LAu9VH9KT9d3Itb8/3
	kj4IsfqLv3WQPpDSb9152qjcNIA2tuBjTJcGX
X-Gm-Gg: ASbGncsVsAjPj8SnJ0BXDohAzBMrj8ucsJXjzhAMGWqfIpFgFZsEG4m1bfGJXeW3vd6
	ocgFnHFsTtSJEzp05Q58lJ9nb3PT3z1spVJhR4eLjKYjmeeTnxKX2VCvDqipEXgmH4CNURRKp2e
	Udax2e7Z7ntKtbdYbPRtFLAOM38n9NP1bA3tiTvDdmZS1qycg8XLBzJvnoQV8593ve
X-Google-Smtp-Source: AGHT+IFVQpufgbLLA6YECN41K61P1pEGrmuIBYIE15m3wWzbXyC5CFZGk1U9guX3blOCJkUvw+PNymy7JiuwXiX3vwY=
X-Received: by 2002:a17:903:2343:b0:216:201e:1b63 with SMTP id
 d9443c01a7336-2296bbaa3f4mr235505ad.11.1743545112407; Tue, 01 Apr 2025
 15:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318041442.321230-1-irogers@google.com>
In-Reply-To: <20250318041442.321230-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Apr 2025 15:05:01 -0700
X-Gm-Features: AQ5f1Jrm0n1hpopd8bYhxwuZIQuw9NdG27Q-sy1ltH8Ws2qq834WxY1YasF98-4
Message-ID: <CAP-5=fX6FubpJeROoXa10jV8RnAD0LKS1GaAcidLzbwZgOmQXg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] NMI warning and debug improvements
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 9:14=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> The NMI warning wouldn't fire even if all the events were for one PMU
> type. Remove a nearby, and no longer useful, mixed hardware event
> group function. Improve the evlist to string function and dump it in
> verbose mode after the reordered events warning.
>
> As commonly happens legacy events like instructions will be uniquified
> to hybrid events like cpu_core/instructions/, even though the
> encodings differ. To make this correct either:
> https://lore.kernel.org/lkml/20250312211623.2495798-1-irogers@google.com/
> or:
> https://lore.kernel.org/linux-perf-users/20250109222109.567031-1-irogers@=
google.com/
> needs merging.
>
> Ian Rogers (5):
>   perf stat: Better hybrid support for the NMI watchdog warning
>   perf stat: Remove print_mixed_hw_group_error
>   perf evlist: Refactor evlist__scnprintf_evsels
>   perf evlist: Add groups to evlist__format_evsels
>   perf parse-events: Add debug dump of evlist if reordered

Ping.

Thanks,
Ian

>  tools/perf/builtin-record.c    |  9 ++++---
>  tools/perf/util/evlist.c       | 32 +++++++++++++++---------
>  tools/perf/util/evlist.h       |  3 ++-
>  tools/perf/util/parse-events.c | 16 +++++++++---
>  tools/perf/util/stat-display.c | 45 ++++++++++------------------------
>  tools/perf/util/stat.h         |  1 -
>  6 files changed, 55 insertions(+), 51 deletions(-)
>
> --
> 2.49.0.rc1.451.g8f38331e32-goog
>
