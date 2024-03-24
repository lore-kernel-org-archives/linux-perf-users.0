Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34668469E
	for <linux-perf-users@vger.kernel.org>; Sun, 24 Mar 2024 04:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711252936; cv=none; b=rebji0xi/kWn851bjWpMWIctVXlDCwz2AtHZ9DDQeTv69vC/OzDUHlRR5/ZrorxHFweAGqSXFNn2NX1y0Zzjpq1YGPgEOPEpAMHWZN8uH/QQqwswvZrK00OhrXwoXlgF1nYKRll5Pgt0n8hqQfqoOeDttoQv0+Zrq3ouvvQz9uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711252936; c=relaxed/simple;
	bh=5OZcy0cvcWpGXzari92vyjneWj/13af01epaD5LDZ3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EACj17DCfutaKF0vpfoYX6JM2IqMsEit5/NByS3R4ilDqBvJIY6+9E1N9/U53AACs9/l6zUVezd438gAVVVui/ei1imKlYFR2l5m6bj2xKR19WCgk2s9fEEYYRByC3OwEzcknjKYl0lwzoO90LGOOESTqs3OD7roxPmjLH7m264=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tIQnOy39; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tIQnOy39"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dee917abd5so89385ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Mar 2024 21:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711252933; x=1711857733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FDuFqOuTc7gua+Z/Dt+h+8SW6PrKycoDzBI96oJTec=;
        b=tIQnOy396wUGj2lzd+3P8FFEKFRRKtpDGb7Ma9cP8+geupzcwJhJhLrX3Mly2CdYw9
         BXKRlYlbCPMyAKP/YiPwy0BGM6oo3reH7S8hd7XSzjdgM6/BnhIzl0YNOC6UkO2aNPNW
         txn/wjM+LYajXlJDoP2N6xs/A0FUkK4p9v19VVPh6ec5nzVpe4sm1mtGcV7jWgTezEj8
         81F46AwvqPJKVycl9bnIblypoYnYMpaOJKzfRzz6W/IjoHvwaww8vZqVnr9ycfFQgh8Y
         0XRu/YQqQsmXU0+AD2FIhAnSM/jL8rMigwXAB0jIa+HBZkBWivfu2/8IqNv9TDTpdWDb
         1G7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711252933; x=1711857733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FDuFqOuTc7gua+Z/Dt+h+8SW6PrKycoDzBI96oJTec=;
        b=DXCBgKH8UvctxJVTqUZUIMz9LVL+AhT9VJRZ3y4GGt7zoc7PVUdqCXvTmOHemQzdpG
         ITal7/I5/RE8A8d77S4VhhmfqmwPs5yR/xRNGiJrEn9HA4UybbVy+bAsid1PzBBcuycv
         ffDlOank+NxDEeE7fNoAED8LhyvLAslc09STHbHreGb5XGm2FRedn0Q3uj6ERpADMQri
         AhSwjhK8abvFQFzLo+XLE4OnHSdnTjHJDfKnap8r4lnMiQPeWa0J+EoKrDXOTX2xQzKh
         zRSE59/BG0HTx9S5F6Q93m3F8GqlWENxvMzMOsa9+wXCUc/eS6Sik9UmVCAoyfFjTXCN
         G7tA==
X-Forwarded-Encrypted: i=1; AJvYcCX8UdzJm/SpsIuGRGdhhRnNtYUDg+31SOaiV4nBGTZtLU8ViZZtLAeD2oYwxyeT1bG1KQIq+qYpwuWDuZrhud0GYWqqGVWR1Q7bLVPvmIK9tg==
X-Gm-Message-State: AOJu0Yyr0YryihFkQKB67eqxFKz6OzE/Nhd5uzPFHa1h4/fY+AhiUGOS
	mZ1ATOTfeZ5LMHeWUIJhhqmIv+beJr+0reTaqd4PWYJX5Tgl5WKMngmEeq0Hq14Nqq4AggNolOs
	tUZoShAj/L5sS1s5zp1jY01R5mpdBZvw5OYpX
X-Google-Smtp-Source: AGHT+IGpw6CBMCIKPJoL+FNoSt0LH9Pv1DCpGjkQRjLXoofQA7dcHtpiEELJCQ18HljSY7e6sgxLqKg2ERYdppEY+Nw=
X-Received: by 2002:a17:902:b218:b0:1e0:94a1:95b8 with SMTP id
 t24-20020a170902b21800b001e094a195b8mr316330plr.29.1711252932865; Sat, 23 Mar
 2024 21:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312234921.812685-1-weilin.wang@intel.com>
In-Reply-To: <20240312234921.812685-1-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 23 Mar 2024 21:01:59 -0700
Message-ID: <CAP-5=fUbbX2LVTvqTvcbw=GPgvibMB8V0mpEx8zUrgYkXRq80A@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/6] TPEBS counting mode support
To: weilin.wang@intel.com
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 4:49=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>

For the series, some nits noted on particular patches but otherwise:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Changes in v4:
> - Remove uncessary debug print and update code and comments for better
> readability and quality [Namhyung]
> - Update mtl metric json file with consistent TmaL1 and TopdownL1 metricg=
roup
>
> v3: https://lore.kernel.org/all/20240302001139.604829-1-weilin.wang@intel=
.com/
>
> Weilin Wang (6):
>   perf stat: Parse and find tpebs events when parsing metrics to prepare
>     for perf record sampling
>   perf stat: Fork and launch perf record when perf stat needs to get
>     retire latency value for a metric.
>   perf stat: Add retire latency values into the expr_parse_ctx to
>     prepare for final metric calculation
>   perf stat: Create another thread for sample data processing
>   perf stat: Add retire latency print functions to print out at the very
>     end of print out
>   perf vendor events intel: Add MTL metric json files
>
>  tools/perf/builtin-stat.c                     |  211 +-
>  .../arch/x86/meteorlake/metricgroups.json     |  127 +
>  .../arch/x86/meteorlake/mtl-metrics.json      | 2551 +++++++++++++++++
>  tools/perf/util/data.c                        |    4 +
>  tools/perf/util/data.h                        |    1 +
>  tools/perf/util/metricgroup.c                 |   88 +-
>  tools/perf/util/metricgroup.h                 |   23 +-
>  tools/perf/util/stat-display.c                |   65 +
>  tools/perf/util/stat-shadow.c                 |   19 +
>  tools/perf/util/stat.h                        |    4 +
>  10 files changed, 3074 insertions(+), 19 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/metricgroup=
s.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics=
.json
>
> --
> 2.43.0
>
