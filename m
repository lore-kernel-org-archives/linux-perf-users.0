Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DCE21A92F
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Jul 2025 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752095309; cv=none; b=u3Db6lKja8cRv+6Ufr/nLwmZnLZtu5bodialXu3XM0olc9Im3sdQ544ad96/QeWnG7GcIHFTaCwjIQjjM5qt7Y0d44kZYCOzyImVFgDzYEPm4mEQMkF61UpF7xLUD0QBEZgNFVfxjVlLZO7HtnJIFMBYwsZ+wrDj2LdNVT9lOEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752095309; c=relaxed/simple;
	bh=y2wXxMQF6d3k4vp+pey/vuvx54s2OwWXTIMqdzyX87I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JU2Y677wHic7noaE52eeadXK+ZmqvWjAo7YUDOtQw/6dnqo6g0kWkWj/Tol5G/AhPd3mW/WO2MM5rjuAvmQRYzuVlNz1H8kGK7sJGoovat+Wz2ZRaw+WqzdXMUFUoHeZIOo3DDpxiutBIlfuU0WIrtzqZt7cGmhFHn9Ydus6uyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EpegsM1t; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EpegsM1t"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-886b2fdba07so178352241.1
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jul 2025 14:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752095307; x=1752700107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2wXxMQF6d3k4vp+pey/vuvx54s2OwWXTIMqdzyX87I=;
        b=EpegsM1tJ9Sxuppd0N7nEcOClE62jaJVVTAdJ35RGbVkTX3kMGA4ExFV5ifYdt4WUq
         aQnK3Fm2BJtQnuOKifBJ+ndSfk8u1ANKA7WHDsBzZhVw8PrdhktIEdWBJiCBQbQrtSV4
         gFIGoVC19JbrNBDsi5hxKFFBhyLBaLUlB4NErcP6fw2FlMXWYB/aZubhqkskhyg8tW/o
         BaR4cFAD4D90gWX33iOlt4U2z75R1JBqOdOMUNgZoJoWz5SL2yelb/UsqtX3JSA8Brwy
         +hjzsDfjV6W9e2C5uS8/xzI4gtKdGyX+ZD7g5Ig0WlkjGKr0N2BOXfRsFN07yWvbZonC
         rz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752095307; x=1752700107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2wXxMQF6d3k4vp+pey/vuvx54s2OwWXTIMqdzyX87I=;
        b=RdM7zDsh2WRE/y7BJZv01GaQr++Oz2aqAYuhUjymxhNWA2cav561gd7udpsYTYEP20
         oWb4M4vWUAxMWWUcKruaXUEPv1Q8jC8eWlGtlIdpPtUAvHtRH8OXr8jdjWYlrYt1fTpZ
         0u1ES1hhRaAAT1FsOpmIn+nhstw87kuku4/nISsMOF5XN7RWRZYwaqmJX0VoXy7mfeRe
         c3pxA7pKKPbcXiFGT3/ZZ3UogVqPrU72bmGtwcaL050RGHn0F5De/FmhmwxL4++uOjY4
         QoP1aNE8yH422VfFRRJ5Y/bk4JxMKeb3dYlj7Ln1mW5KD+FKKeUnNcgbSTz0wvTqmxw4
         j4IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCtb5mkaMZWJR71pyrABRCxywH1zvekJHETixL6dSJJysTyJr28eDcgeJG2rt96ZVzv46cks18Q1L8RmKWdjgm@vger.kernel.org
X-Gm-Message-State: AOJu0YzAGMljGaHnUOG2NuDCTbEklnoN1kRvzs4PzGC57Iqq84pcd28/
	336UTQ5sH1sljGvwzdEmr5L2lssmZG+N1TSbX4a6WrhnNZaVO/7HLAWzqXDsQuWlsVVgTz8TkSN
	sW3RhFM0DZ6X1ueJ8XUY9gIxOoU4oZStIk2LMEPSn
X-Gm-Gg: ASbGncvAvfHRXHMz6hEpdMSnIji3Dz1V3ui3No5I0oYL7l+6mBI5q5aOCIsD0MWio0q
	ny7/ni55AxSFBwqy4tLIOtuuPdUSsYEyMqwVHyykQ9emCtLTq4Q9cHGeVyC8kNgzRlh08XXGbGJ
	dCP9peQRAg85e7PLDYNsFng+OxRZDieTRCmkpUHet9SiQw3KS0xEo7HziqYB7Nck+bZR6Wg8/n
X-Google-Smtp-Source: AGHT+IGdh8eN3h8HscGvSa6bfWmnnHbDwGqF3PtjSKvTxi2yQaiUYm6rNI3VTgW1g2j5SJyRzIJjOT1h1JH55zPabDE=
X-Received: by 2002:a05:6102:50a1:b0:4e5:59ce:4717 with SMTP id
 ada2fe7eead31-4f62df178aamr186458137.9.1752095306773; Wed, 09 Jul 2025
 14:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605233934.1881839-1-blakejones@google.com>
 <20250605233934.1881839-5-blakejones@google.com> <CAP-5=fVX_Qohsf=f=-fR8mYsTq4zitURit2=4BYyD5HPJHOT7Q@mail.gmail.com>
In-Reply-To: <CAP-5=fVX_Qohsf=f=-fR8mYsTq4zitURit2=4BYyD5HPJHOT7Q@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Wed, 9 Jul 2025 14:08:15 -0700
X-Gm-Features: Ac12FXxXtr8XizMgnbtY6unx5cS16grFsxMMxrKhZdDg1-CAlIRC0HFgaVUWbWw
Message-ID: <CAP_z_Cjuh9HJvcnsARaX-QUwDMbRPMDr9AtxbBxYUR_BTSzwCg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf: add test for PERF_RECORD_BPF_METADATA collection
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 2:02=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
> > +++ b/tools/perf/tests/shell/test_bpf_metadata.sh
> > @@ -0,0 +1,76 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
>
> The 2nd line in a shell test script is taken to be the name of the test, =
so
> ```
> $ perf test list 108
> 108: SPDX-License-Identifier: GPL-2.0
> ```
>
> > +#
> > +# BPF metadata collection test.
>
> This should be on line 2 instead.

Oof, that sure wasn't on my radar. Should I do a followup patch, or is
it not worth bothering?
