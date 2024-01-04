Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF4828DB0
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jan 2024 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="beTwPQu0"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e70d8273fso137e87.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jan 2024 09:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704391027; x=1704995827; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXgbTOAEkcnN9x3L3X6XAXMZYd9HjGggBKwplycVfKo=;
        b=beTwPQu0+yZwrolnWvg82uWAsq7JVTx4xH4jzBXcWxs/mDbhA4Er0shmZxvg/f2icS
         xbn5ssX6ATIgRbnutjMlPqRQ4xsDLoevnUBvwu9PVOEKklrh1erryX3hARHOJJyyifnb
         MkjKyRE0yWTRKKzsvEflngTcFy73I4iGJROB0ZbAZyS54uG9Y0dJxQKyHda1a2vJf8cU
         xW9FEoAyOW/UOmTYTU8kK2Dvc9mN6UVmPunJtGfA97aMcNOl1ObTRRYxUAwZZeMNtkNf
         ALjpe5jMzaIrH+stvH2JUNF8fAV/gbhxeLik/d90HLjBuN/i9ba7FMGjTG27KG6Q91sF
         4AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704391027; x=1704995827;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXgbTOAEkcnN9x3L3X6XAXMZYd9HjGggBKwplycVfKo=;
        b=tQdYOlo+yPLloyOCTXz5kF9Jfp8M5ygB+GA6h0GCHRa2Qv8wZGOq+gkd/yzt0qWPB6
         H4Rw4ogv66I8LgbQXdgGb1eTHbxZTY4LgTYAsb8uDjWkfrXKY8LkGMgo6/UlOr+jnfJ3
         Pl6FQkQmNvSd2pKHqQh0N7IAe3N+SdwAD8Qjuvm42mPqMlTzUJcJaPcB587l3fhGNgXa
         TVwBUFhPfKDITup/iu7BdIWii94t1HoLg3ES3hiUPR5w7xCMwxfVgaHlnIWAD6sW9XzS
         XLjUXMMA6/vKUmIndiZqHcQb7Y++goNg3CzgRPimjJfR0ik1IuRbFB44lkkGWEjw5QBf
         D0Pw==
X-Gm-Message-State: AOJu0YycJ4HjHbYe0aETX7+kdTL5TMDkNf8nczMz2T6hab1qXfyGHWH3
	aP2xQE6HEVB1Q7wgBlMmaV8ScgSiu2z2UUrn9wkDUF8E0Cjw
X-Google-Smtp-Source: AGHT+IH+Lnu96FD2lTLdKRXh6DZgpHN8V0gwgbqVDQNL0SDcqcWkwW8cYHQfF3F3nGFltzPNGRNZ9d8bzc9t2YQBYIs=
X-Received: by 2002:a05:6512:788:b0:50e:84b4:2bdc with SMTP id
 x8-20020a056512078800b0050e84b42bdcmr3551lfr.2.1704391027487; Thu, 04 Jan
 2024 09:57:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208000515.1693746-1-irogers@google.com> <CAP-5=fVQfqS6gu9Ua3Exijc_ZaBzrt2=1PMopgdoyC_6R_cnaQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVQfqS6gu9Ua3Exijc_ZaBzrt2=1PMopgdoyC_6R_cnaQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 Jan 2024 09:56:55 -0800
Message-ID: <CAP-5=fXqKjQ3Rn=N9sV-6Accce1qsMK19Hy3yGJE4s0OHy6XVQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] lib subcmd: Fix memory leak in uniq
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Chenyuan Mi <cymi20@fudan.edu.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 11:30=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Dec 7, 2023 at 4:05=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > uniq will write one command name over another causing the overwritten
> > string to be leaked. Fix by doing a pass that removes duplicates and a
> > second that removes the holes.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Ping for this series, no comments since sent.

Would be nice to land this set, especially for giving suggestions for
inbuilt commands:
https://lore.kernel.org/lkml/20231208000515.1693746-2-irogers@google.com/

Thanks,
Ian
