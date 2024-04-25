Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB3D156230
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Apr 2024 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714084906; cv=none; b=s5+RlYWHQ/j4Eb0slu6dxQGUqg6g4lGSw+kyo6YgTWErvFrftjy+G6BrVQPtlJJt9vBXaxUmcHBZOqoYuCy6f9cuBZGIveK3ypfd33qQ9SjM4n4FExHJuuOh3qbxipYy89L8pXtXn6GSPmET9WcEv2H+CJlOUR7o1eMI3gKyq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714084906; c=relaxed/simple;
	bh=oxGSOLNPdfHpQYTSm/hGakG/iwIzMGgaLkQImWnGLjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Dwhin9fWI3i6pYmH3N0D05AnxUJQmdnjAj+jSDgMugit83QkpPAIeldpFJYEpj6tRDMMnNPFS1JNf6zSYDm7TlpRivbPHqAtl++ujtC+gwUBxw9W+BfQEhmCxM0oD+waWSlmclMe8vp9+suOHQ382DZldqmy+YRGJElPbfJKv34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zqcNn8Wb; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zqcNn8Wb"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36b34effb04so18615ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Apr 2024 15:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714084904; x=1714689704; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72dpbNrttk8py6uXjyBWtA37O8ks8mKcpQBV78r/mRQ=;
        b=zqcNn8WbgapFYp7OIbXfY00lWEoDjKCVlbSWbb9/WuFhZRa0tN6H1/MkPM5c7MZYHH
         VAA+rUAt3PmkyfG8AqM0AwYX12C3XoE/2StZLpKPNHKi6mQKxN/hgADPyV1b5nAPm0R4
         kmPK2Q+c0gmby9u3pDfOT5ROzIdev7YWeAOIc4WdN6KbQu39vgxe2nvPsnhDr1O/XB0J
         M5Rd7619QLCSsXblAhx2X4WwTIBI7I8MXOHVSWr80BZK5vhV2C7c8Pf3A4RvbkpwXB4T
         2Y40GqBT3Q0gNCUZaWDprPPYCS1xVLV/ByST4oweDN8XJzxiYQ3Mw8bTpoCIAe0tQ+D2
         ggYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714084904; x=1714689704;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72dpbNrttk8py6uXjyBWtA37O8ks8mKcpQBV78r/mRQ=;
        b=V5lAxNm+3rrxhji2zPuIWM2StyJ6iy1hQkAUYo6CbyZZsjs7TAtjYcdH9J5ICzW2qr
         5LYE04dyt304nS2PTX0nPqEYSRqH5J0I8wotlGOHfXdDBib5adUsfDw85+xuAu6LKc/B
         oWAEvxd8BdnXlfFcEdzN4kvM0c0gGoEgvzj2vjY8y0tL17npUcwfEXFvNhjakGTW7Wzr
         yndntJVYBnT0g8G3QNyS/viS6cSaTVNieh2ul0P/lN5H1lgMmWsE2OCCIfV81NeQdtOY
         LUUtWUrPb+mQRUMU9va5y6otMHO94NQNtz8DAlZ/j3BxGC/RGtCvpSMxCY3opqFeClu8
         vp7w==
X-Forwarded-Encrypted: i=1; AJvYcCXudRBkDmj6hvqHlPx12TYAdwuuWgENm2bBgudIJp6luBHVRhMmjyWIpUwphnL0UnBMhFcukCoAFsTARau4m8igELXvj3FCn7W064EjecWr/w==
X-Gm-Message-State: AOJu0Yw2El0j3BmzZV6xPz2juXIKoygo2OmRdKa1npDgvXjqCfYvPmoc
	ZD5TB9XCwT3vo0dFVXLqrkwk1eT43GzjhJY44ykRrlXeRBauWCfzVTfh2c+QYhYDzuGUUhy8zKy
	WpkgAiTsIMNGf2m/kh8EufusE6nnTVNND/X5J
X-Google-Smtp-Source: AGHT+IHO5QqtzXcXeR2dvYokk9K4IIju2HkHxTqgaAiF7cgesnW2Bl6zjmMWkLdEddMASLs6OyUmdiVOsQlsZKcWDhc=
X-Received: by 2002:a05:6e02:dee:b0:36c:19db:c567 with SMTP id
 m14-20020a056e020dee00b0036c19dbc567mr60918ilj.26.1714084904313; Thu, 25 Apr
 2024 15:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425223406.471120-1-irogers@google.com>
In-Reply-To: <20240425223406.471120-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 25 Apr 2024 15:41:30 -0700
Message-ID: <CAP-5=fWryq6-W35ZyP4PAHJoJSA_7d2YV7zTG3vuL+WGa=_Mmw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/3] Retirement latency perf stat support
To: weilin.wang@intel.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Leo Yan <leo.yan@linux.dev>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Song Liu <song@kernel.org>, 
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 3:34=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Support 'R' as a retirement latency modifier on events. When present
> the evsel will fork perf record and perf report commands, parsing the
> perf report output as the count value. The intent is to do something
> similar to Weilin's series:
> https://lore.kernel.org/lkml/20240402214436.1409476-1-weilin.wang@intel.c=
om/
>
> While the 'R' and the retirement latency are Intel specific, in the
> future I can imagine more evsel like commands that require child
> processes. We can make the logic more generic at that point.
>
> The code is untested on hardware that supports retirement latency, and
> with metrics with retirement latency in them. The record is also of
> sleep and various things need tweaking but I think v1 is good enough
> for people to give input.
>
> The first patch stops opening a dummy event for tool events. I came
> across this while looking into the issue and we can likely just pick
> it first. I kept it in the series for cleanliness sake.
>
> The code has benefitted greatly from Weilin's work and Namhyung's
> great review input.

I forgot to mention this is based on the tmp.perf-tools-next branch
due to the recent parse events clean ups that have already landed
there:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/lo=
g/?h=3Dtmp.perf-tools-next

Thanks,
Ian

> Ian Rogers (3):
>   perf evsel: Don't open tool events
>   perf parse-events: Add a retirement latency modifier
>   perf evsel: Add retirement latency event support
>
>  tools/perf/util/evsel.c        | 186 ++++++++++++++++++++++++++++++++-
>  tools/perf/util/evsel.h        |   4 +
>  tools/perf/util/parse-events.c |   2 +
>  tools/perf/util/parse-events.h |   1 +
>  tools/perf/util/parse-events.l |   3 +-
>  5 files changed, 192 insertions(+), 4 deletions(-)
>
> --
> 2.44.0.769.g3c40516874-goog
>
