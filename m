Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB551B0F18
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Nov 2024 05:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730784973; cv=none; b=bq2vRl2C9W18M0YzoS/mdmiRkw7mIrnsMPxv+DnSD90ic21hhJQfkmr41gn7j3Ny2HgAhxj85xez0u3GmHr0O8XBe9R0GEAr+JKDtL/RxcnUTXHUQ0+l/sH4LVDVeIao9d4gWjd4c2CcN3TNStvOfXKQM8C/itv7TrBUk5DnakA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730784973; c=relaxed/simple;
	bh=7z9yHy3i3NUkPoqHbhSmBzTngDJ/OtHBHeOPuOtBWfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkSe0sS5+StiLDjrAVf2LfYzmOXwRGGJkQTQ2LOs3umtezE2TY9KglMg1j5xd8xT3j1cc2voewSZz8VmJfiKLE6SYNbYiIgj9TZ7fvnBWPUtwsHO5yUbjcquJXm5T6cP4+Yv4aJun9NFp+br5yx/+/YF5Yelp/dtBuPrQ6TQLOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OKDHbWIA; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OKDHbWIA"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a6c3bdbebcso152285ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2024 21:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730784971; x=1731389771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNSFaFJwvVfOVEo0X1S6A+LBXmbYg521VtI6VYdAuZ0=;
        b=OKDHbWIANdaD6RxdH7/zpsWYOxHQHscoFZs5vhzf0ZrfvxQfNk1IGrJqw2Wk0r5duz
         N/1u9/fxAuZyKbEq5Otd6O6jOsFjchn0P+s/PX++UX/qNT2hsZ/RkR/vsrPyMZHFmWYw
         XD8SKLwoI1dboxoJUWiEn+AEj7/Of2zbaLdvLt6DzNVApwuHsP7Y0iHVPnuvzqCtlXhR
         PKsk+Q18/XjnhJ34pCuhNkqQih6J8o04YaxZw+4J/7pooP/Q6wG08f5JH+LM/Nl6Hcn+
         3pLYKEgXTw1V5O/liCFKVa7BH4bVHqKK7mUi/MfOB2HLS+4PTIL8M4z/WrfuMu+/8UDk
         VzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730784971; x=1731389771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNSFaFJwvVfOVEo0X1S6A+LBXmbYg521VtI6VYdAuZ0=;
        b=QFi+2xvfkmyNe+E7Y3gyaeY3jfibXSbelwg2gk+RY5+7mO6mpWLToaY31eMX4wj34s
         wdOYwntaFeFDImYWekXZgIoX+7CmTqp7tJNbOIfZ8RMJRVaEjaCDhuiQjxz6TjTYZIXP
         HFWeRPZR3Zm9akMo2LhEV6CxObUS55H3K4Fcmf0JDXl8UOfG7kWnGHLkxtOLxAeLLzqB
         22H+dlP9grR150ubsOo9/tdDX+fyJ2mTXBmS5jL7Ls6NbunGxeSZ6B053c0URxkppmBG
         4a0wkaeQM1LNK6u+yvdKb4j5xqxUYyI2mLvuGMHNoca9I+FGM48zNxtM0gZCwHzygBMP
         94ZA==
X-Gm-Message-State: AOJu0Yy9kDyu+9EcNwC0lT+m28/+VilRUrK3MXjhHHHRDUgCMGUjg0zl
	ssnB22DdUEqLXeJbzsbZcHi5/00in1OGUawzijTufuqHoHwhKvHKUly2+ODAv3ySHpN9XWOnIX5
	ucO5TYPgn1nLZMXTLou6nx2QXlohhTQm7mTC2
X-Gm-Gg: ASbGnctw8NyOe3LFtmipJSJKgMN6bRvuFIW12t7+a2tlcUfuw+TSXm2YiTbE0Mzmjim
	nLfwvDrmBRQHXXKoQxrd4zwNdvfiMJlRl
X-Google-Smtp-Source: AGHT+IGmaULqokzt1HTA4nM35nJDyXIBRmsZflaF2PjI6BZHG4xLEFkCqeyZKcquRxBTyidznYW+LIwBteTLYjfc42A=
X-Received: by 2002:a05:6e02:152e:b0:3a6:abc2:73a9 with SMTP id
 e9e14a558f8ab-3a6dba4d7b7mr1322165ab.25.1730784971249; Mon, 04 Nov 2024
 21:36:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105052409.7783-1-haiyuewa@163.com>
In-Reply-To: <20241105052409.7783-1-haiyuewa@163.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Nov 2024 21:35:59 -0800
Message-ID: <CAP-5=fX1OV4+amaEeMfFJUeh0Bpdyp2K1KuNPU3diD0AAXBcVQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf tools: Add the empty-pmu-events build to .gitignore
To: Haiyue Wang <haiyuewa@163.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 9:25=E2=80=AFPM Haiyue Wang <haiyuewa@163.com> wrote=
:
>
> The commit 0fe881f10ceb ("perf jevents: Autogenerate empty-pmu-events.c")
> build will generate two files, add them to .gitignore:
>
>         tools/perf/pmu-events/empty-pmu-events.log
>         tools/perf/pmu-events/test-empty-pmu-events.c
>
> Signed-off-by: Haiyue Wang <haiyuewa@163.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
> index f5b81d439387..51713b655f62 100644
> --- a/tools/perf/.gitignore
> +++ b/tools/perf/.gitignore
> @@ -39,6 +39,8 @@ trace/beauty/generated/
>  pmu-events/pmu-events.c
>  pmu-events/jevents
>  pmu-events/metric_test.log
> +pmu-events/empty-pmu-events.log
> +pmu-events/test-empty-pmu-events.c
>  tests/shell/*.shellcheck_log
>  tests/shell/coresight/*.shellcheck_log
>  tests/shell/lib/*.shellcheck_log
> --
> 2.47.0
>
