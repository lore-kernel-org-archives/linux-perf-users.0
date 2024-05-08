Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79F61332B5
	for <linux-perf-users@vger.kernel.org>; Wed,  8 May 2024 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715204666; cv=none; b=Eb8lQbmf83SNjolHdUUm7Tn9AA4F2j0ibLUcdbxUndx1DrQJFMIThfACfeTeCz7GKR4wHADQJXMWoEl5gYsSZ9vUY78iqH5CUWlA0FvGQpojNF4MvZYvLwIhNrtGrTA7M5ioxNWPLerzk68fpHl1A3Pb3Loq34fEErrf0D9TEWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715204666; c=relaxed/simple;
	bh=+GqhfbCWo1/rL5WMUZWC0dKWAFYfQARQY4h2Wx1maBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVfVl0mRTd7/S0+TXeo0tNTaAeOH2kLu2mQV7ZfnVGjtwMX3xnk4YJ5akJ/PCeYBs/tigyavGZ8K9Ic8wDqO1tA7D4b8FuV1fFHA5kLZv2Usvfb4eBA4xGOjq4LF+6+70uo1DiDnRL38lvY9U83T44edIkUXnK2u8trFtSGzlIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p7LissJW; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p7LissJW"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43d361a2124so121531cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715204660; x=1715809460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNz33LRukOuC2TAVQ91flMmJhD+luZs+qYkSeJGKPFs=;
        b=p7LissJW2l94uE6++IZCGBm5cIuf+2Bq4sm0wKUNlGmpgkbqmhxNs1ljG+MUK2nAH8
         /AtMnTiZ8GdU5CI4QFdNG1mCvk4zgPWtf7qqr4h+hEJUOjR0Arx/ZSATLskniHad657Y
         cbSZyTwuSt0lZu5cBMu/Kda8R/a5NjZsVbJ8R+gl8SkYv1+xGg0opaOJI2QL4TU6lmjk
         GCcewSBdfESwyJAOP1gUiUBpe7AS29Eicf49WWeFDIdlmN62DaZ+RHpk2ywWiP6YsHMn
         h1aWkI+GFhAeivGgkg/ZvZsIElSd8UyzzunHiZ6i5AkUHWgs4MpfkjS4O4Lg8YoLFAXi
         pwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715204660; x=1715809460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNz33LRukOuC2TAVQ91flMmJhD+luZs+qYkSeJGKPFs=;
        b=A0KQEfYEeYBKBwTysc1Ncf55W5HxIBLRji/HFVZ8R90dLLGjSjFUxOwTngn4YoDlwl
         P30bOCTOEZbNvSlrK6nQ8pYOPThUQwfyCeoKJVXDUG2kVkqUnTwEbX90idFTJ25E/Mg6
         rzsqn1AiOCahoXgJITJgrlTmNBmfBhhxo3/9UISHD+ais3nzZEZAQRp4+UYppDg7ceix
         MuRJqf+U5PdqP3sLu6tafck6SrS0u3rHMenhD3/VsvSktqMvA7TAIS2vD9qPjhZP7dOa
         pJaG/B+Q78tBGoYym9mYcdCUJ+XIxyaZWnNIbHmmXiRQJgTU5NiiqD4EBNBVJRrS6tR7
         QdsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgj3uqg+PrJg8fWK5zRFZ203MKYkMY4xEtfq0i8ntxii/XGNN2g+7vyxkIhUGLI4Muu4aVYM8zyqtuXGjW7oSME+ZR6N7mpdHltjNJoQWrIg==
X-Gm-Message-State: AOJu0YwXtEv0PP3OcB05t9Xf5btsS7seX737i8ZXuxQUqV342Th6lfr6
	HUghKQ5AXXsf4Kj0LPGh7+EZopYOPYDMFI1IAYAAaZ3VO24/0U1fHhYRdN2IEwoBV9QgLg5UhMa
	Wqbh6bEaCAH2R3M1YHJstPg50IKrkZR2pdZI3
X-Google-Smtp-Source: AGHT+IG4V8Ro6H7VLFiSiWMxVSXvKP2tZ5kz1hDy9s6imtx4QHxTmnCi3+YTDPOrrDiAYIGEDIZLIhogA0rDgA99sXo=
X-Received: by 2002:ac8:6f1b:0:b0:43c:de95:6258 with SMTP id
 d75a77b69052e-43defba092bmr1278391cf.18.1715204659725; Wed, 08 May 2024
 14:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505-perf_digit-v2-0-6ece307fdaad@codewreck.org> <20240505-perf_digit-v2-3-6ece307fdaad@codewreck.org>
In-Reply-To: <20240505-perf_digit-v2-3-6ece307fdaad@codewreck.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 14:44:08 -0700
Message-ID: <CAP-5=fWUm9X1_Yj_sqHQqCqfSpcrXsDggJRO+GN2jo=km-0bBQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] perf parse: Allow names to start with digits
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 4:14=E2=80=AFAM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Tracepoints can start with digits, although we don't have many of these:
>
> $ rg -g '*.h' '\bTRACE_EVENT\([0-9]'
> net/mac802154/trace.h
> 53:TRACE_EVENT(802154_drv_return_int,
> ...
>
> net/ieee802154/trace.h
> 66:TRACE_EVENT(802154_rdev_add_virtual_intf,
> ...
>
> include/trace/events/9p.h
> 124:TRACE_EVENT(9p_client_req,
> ...
>
> Just allow names to start with digits too so e.g. perf trace -e '9p:*'
> works
>
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/parse-events.c | 5 +++++
>  tools/perf/util/parse-events.l  | 4 ++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-eve=
nts.c
> index ef056e8740fe..6cf055dd5c09 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -2280,6 +2280,11 @@ static const struct evlist_test test__events[] =3D=
 {
>                 .check =3D test__checkevent_breakpoint_2_events,
>                 /* 3 */
>         },
> +       {
> +               .name =3D "9p:9p_client_req",
> +               .check =3D test__checkevent_tracepoint,
> +               /* 4 */
> +       },
>  };
>
>  static const struct evlist_test test__events_pmu[] =3D {
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-event=
s.l
> index e86c45675e1d..c36f8dbf593a 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -158,8 +158,8 @@ event               [^,{}/]+
>  num_dec                [0-9]+
>  num_hex                0x[a-fA-F0-9]{1,16}
>  num_raw_hex    [a-fA-F0-9]{1,16}
> -name           [a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!\-]*
> -name_tag       [\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=3D]*[\']
> +name           [a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]!\-]*
> +name_tag       [\'][a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=3D]*[\']
>  name_minus     [a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
>  drv_cfg_term   [a-zA-Z0-9_\.]+(=3D[a-zA-Z0-9_*?\.:]+)?
>  /*
>
> --
> 2.44.0
>
