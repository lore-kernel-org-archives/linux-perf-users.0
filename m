Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082D11187
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 00:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972673; cv=none; b=TwX2KZJnIsZsb59KfANHz2eJAFw+QNoX4gHIw2OCEFSMmK+thrYoEysk95IOOmzIUvrUPiXMHiv995rt385Bq8rloaazQYOpIbOVyYLlPZeFF1mM9joNaLUri+EHImVRCpLJdKEnQTg+lG6cBTMUvdWNNOOMABoQPPUxFU0UO/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972673; c=relaxed/simple;
	bh=SVBKQRaD+pc2oozHM9FJP56TA7JsjUqWU4fId+vRf54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYZgdeJ/rwRfdkLJO16LDTnY1t7Mq5eDcdINFZHbMl2woOY+uQSbRfKsogXic1hQkqYsZzTXxLrraYKzNjVabsQY0sY6R1z2VqJTWN28U4t1MFxyLxW8QlZYz7XVeiAaI9hPlFwe6X2thMv6rHMHBEmiMpYwGd0xC1kD9+1D2Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TscSiY19; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TscSiY19"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d44cb27ef4so80925ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 17:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745972671; x=1746577471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfnEQM+OI/9Zb5rBitTrywPeYSIe0JsG+EMavn2ZaPs=;
        b=TscSiY19XVQKMjJo6pzDRzIFQ6fZrHhqg1Xgpa0KEAohkhZQTr2L7ACSbImp9sn5JN
         pCzuD+k0qG3sXnBxZmUYBt2FVlMwQN66Nzy+iHJrnmk//rf5aZ0fgAX9YywWG37l4KRJ
         326RXuA1g1CrWU/7Zqfy0iDvDQ6+eeoV8nX8DYWmWLA8TldUZ9rnQM86rRiNpjtMJjeO
         EyM5zRBpMoz+zn6E7QjM5Nj0OIbLFM6FJhkbVJFd0B5JvT2VFrF/PVdKqmOMQl6Fgj1R
         sqfk6nNIYO6zgGZ6OXBt+jCElqHCH6rmbgYv46Ezqwzz+JCtxBHsuxyDZUL1nYGpMWJl
         fj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972671; x=1746577471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfnEQM+OI/9Zb5rBitTrywPeYSIe0JsG+EMavn2ZaPs=;
        b=XcdTPbW4upGBjZVEPB/Xs4N3hNdThiXa9H3DjxxoU/Dwdl2Snv4qJiiO7F3i2nLpd4
         uZpcd1cG07BNq+HnynAiE8vcITjV9SHYzZwhgSc1Fb7wPjOl6qZrngQmvPU1J/LlTxfm
         TSvx0kBfuXUsoXxkPvXo4GCnoFZkU9UbaTtVyU+cYoZx3lyYDIXMl1P9FgvMFZVG2VIG
         97PIwwLRGSy0Z7XGqhmSCoXwEso/P1DaKQ4DfU7vXQ4woGkT3odJ4lcvEKQ3rN+WlQQI
         A2Nxc3WC8gy0oUp4fZgfscurAxTHHrVTA2aYmG9yZ42UiRY/KvzKeCkfXWMQRxMga4gn
         FcVw==
X-Forwarded-Encrypted: i=1; AJvYcCUfy+IZB0AT+aserQzfQrDS8drVnQARdc5ZgXLyoq8EAg6jb+dKOSUIYpf05l5KfAvVQXh6Nqr6TLGIt5RIGJal@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb91j7xXul4iu72zOqKAPNX8icFeR+KHL8dw7QfvdA5lIm/GZv
	xHJwFE/727GbhMYXePtrn4BB7C8yS6XyuKnX9c/8rkfGcvqRIPnc6lnRiLJ3lTOFPQHkr9zv5AY
	kCuyJGt4qF8alh0DNX1HMcN0ckLPYB4MG3TOA
X-Gm-Gg: ASbGncu1HZH+VyAaAtgK8/M+T+qnfWg6WpS0F13Fr2iGYSrexGytP25fa22zmBxtx68
	4dOyGYR4SbqD9DKiO8wAgkPa78oIeGkLw9Ne3rb3P9aid0KxEw0x7I6dw5D6Oxf9LNMECjupfLs
	NsSepP+iESyMUbmlrlDdQEb0a8NemNYpXk8Q==
X-Google-Smtp-Source: AGHT+IFvMyC0i9SD2AIanZuarEXq/nVMiHDXfN1zanfzkQ1wYHtHOZeag/IQagtoWu0Y074s/SHzs/s1TZ4iy5ijQ1A=
X-Received: by 2002:a05:6e02:18c6:b0:3d4:6f05:dfde with SMTP id
 e9e14a558f8ab-3d96761218cmr1585405ab.22.1745972670925; Tue, 29 Apr 2025
 17:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402201549.4090305-1-irogers@google.com> <18c2fb33-2b3a-4ebe-ab26-8cebe0b6b94c@linux.intel.com>
In-Reply-To: <18c2fb33-2b3a-4ebe-ab26-8cebe0b6b94c@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 29 Apr 2025 17:24:19 -0700
X-Gm-Features: ATxdqUH3eXojgNt7cQNxNZcVbYdXqWfNpU3cNDaLVnlRGBaG315cXDbD7DXJitE
Message-ID: <CAP-5=fXDriX5ipdvierw5VMTBUp-Q+97Xi5peaTmabe=Gp1BMw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] NMI warning and debug improvements
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 1:33=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
> On 2025-04-02 4:15 p.m., Ian Rogers wrote:
> > The NMI warning wouldn't fire even if all the events were for one PMU
> > type. Remove a nearby, and no longer useful, mixed hardware event
> > group function. Improve the evlist to string function and dump it in
> > verbose mode after the reordered events warning.
> >
> > As commonly happens legacy events like instructions will be uniquified
> > to hybrid events like cpu_core/instructions/, even though the
> > encodings differ. To make this correct either:
> > https://lore.kernel.org/lkml/20250312211623.2495798-1-irogers@google.co=
m/
> > or:
> > https://lore.kernel.org/linux-perf-users/20250109222109.567031-1-iroger=
s@google.com/
> > needs merging.
> >
> > v3: Increase the verbose dump length from 1024 to 2048 as requested by
> >     Kan Liang.
> >
> > v2: Rename evlist__has_hybrid to evlist__has_hybrid_pmus and add a
> >     max_length parameter to evlist__format_evsels as suggested by Kan
> >     Liang.
> >
> > Ian Rogers (5):
> >   perf stat: Better hybrid support for the NMI watchdog warning
> >   perf stat: Remove print_mixed_hw_group_error
> >   perf evlist: Refactor evlist__scnprintf_evsels
> >   perf evlist: Add groups to evlist__format_evsels
> >   perf parse-events: Add debug dump of evlist if reordered
>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Ping. The v3 patch series (this series) is here:
https://lore.kernel.org/lkml/20250402201549.4090305-1-irogers@google.com/

Thanks,
Ian

> Thanks,
> Kan
>
> >
> >  tools/perf/builtin-record.c    |  9 ++++---
> >  tools/perf/util/evlist.c       | 34 ++++++++++++++++-------
> >  tools/perf/util/evlist.h       |  3 ++-
> >  tools/perf/util/parse-events.c | 16 ++++++++---
> >  tools/perf/util/stat-display.c | 49 +++++++++++-----------------------
> >  tools/perf/util/stat.h         |  1 -
> >  6 files changed, 60 insertions(+), 52 deletions(-)
> >
>
