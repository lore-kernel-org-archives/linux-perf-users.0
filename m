Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BA013D531
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Dec 2024 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990474; cv=none; b=UBjx2PMO3/sgBvDljVzh/XcXHjqqZOdX8xu1NFtdnjC1v2Y3lT6QoC0IR+YrR2WC4tD3blyQL6lQBqcMlwTAqke6rpiElOgTG7As2UopuQo3QoGf00nYJGJyCzD4+EYOS34Re/UY/5DkwtFvZZZLaLrPBwtxAUlJVSYXUne0Sqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990474; c=relaxed/simple;
	bh=Dr+cz0+BDjHJiX3SZyGOwqdo6Z0WguMW6sZx5zWpjKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEd0+kCPG0nYfVhF74aDkMehF0UsZiDqVOfiTf+pJP1Ff28lYkEUoBGvUdtW/pUND+SdyN4RzPZmgvX5ozBmQXNQHEaQ5vqPptp/AuO0rrTvv64T0pQnPCy9jpIkKkSnHoSYsG9lYz8Equ/a0vw1jjA3d7MngHeSmSYqvdpcDRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NYlxKwrD; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NYlxKwrD"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a814c54742so89345ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Dec 2024 00:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733990472; x=1734595272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGnkR63xNQ6iE8HARxg6I3n9l9ITyeS7X74GP6uMkOE=;
        b=NYlxKwrDqUiN31srAv3oIEM/XcQzxpOUxoVZR92pmBmhR8xaRkN6JN0Hdf0GDtZwmg
         rD7UEmH5aMxWWKkGMydfU8tGKSAUDw8WXjEAP9sqxBejzqVKJhjjPMHWYK55nZMHxALJ
         C3LKZcM0jEKMRNZiIcL/kH9DGP6KTSPqdl8Aibdyye6VbmQjetT9dK5eu6EoEPJBiHbc
         2YtGTp2dxLYcAd189aNoTnftcsQVCfeuT9r2+v1zyBvdGqRePFnylckmrjOxEVhnYazr
         lXSoubLdABZWIxmwfhEWy3MzKP2SmRU9+4ZuhdOdkrulOuByA0AVVHw3scnLq8ln8rdd
         NZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990472; x=1734595272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGnkR63xNQ6iE8HARxg6I3n9l9ITyeS7X74GP6uMkOE=;
        b=mkjHGNgn2jOKZhxqHFzIFtAtE6MTLwJUULMLn2aumoo3fa92DgWl3oJX6FHMARoLjz
         C+q7vUwy1e9DC/yB9nBcIMxn23hv7IQnlTQ2Wr6QoLitvar4YJscTX+SMvpUCteGKqWy
         CUUoiK4JpkRh2ErrKwK/LcuEfyMH9Za8sSb+osfd271mKzA30AMPabDox5I1Pi9KEvzt
         vh2vxtNd/8ay/9VNdMttXpJiMoq3HAOP0CnfMdAJFidr6Mb1tktRb7gKS64HBeFQmhKZ
         q5mZedLtlfizI+anJaygSq5dCFGmSjsQCrR7ZhmQpVfq0SsheSyDxieA9EjIK/NDiC0b
         A0vw==
X-Forwarded-Encrypted: i=1; AJvYcCWZjeZd2dO5QKEioEfMowEghpg6mV1bJKqmQHgayE1DrjliBFTR90bBPBHQXSW2j7H972vfwa7jcSNPcixE9UkO@vger.kernel.org
X-Gm-Message-State: AOJu0YwjckJO3TuuDkBRZaMF6A1Djai0A4lOnNtJdeDrQcRFooGFvA8+
	9QGaNTB1ayoNJE8mk0k/GTivoARKnBta1x/V2p3VX77/KZq1p0RAXqscdh0v5yTLPkW5nFS6P1o
	HO3Hq483OahdaGAr6VNO2wMKH0tVmnVUV2shZ
X-Gm-Gg: ASbGncume6acNdOaSqgJaQs/DQvAV4c/nz+R6KEOx7VGHMi9f8I5NoLC6qpPBYyr7tx
	QMJ1DS/Jow21UPc8qDQ9dtoz7QEKOTxkw5vNXAj8=
X-Google-Smtp-Source: AGHT+IGF/N6gjFtzv8jA7XxepjmFMkaNJvoKiN88LE+17oqBT3BkCjJ8+HegVao/zGpFfBSWTcBPW5GovIVhbzxvru4=
X-Received: by 2002:a05:6e02:12e2:b0:3a7:5be0:5a06 with SMTP id
 e9e14a558f8ab-3acdb2e94a4mr1463205ab.29.1733990471902; Thu, 12 Dec 2024
 00:01:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112160048.951213-1-james.clark@linaro.org> <Z1iLqNmDyNH7fDpa@x1>
In-Reply-To: <Z1iLqNmDyNH7fDpa@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Dec 2024 00:01:00 -0800
Message-ID: <CAP-5=fUfPnkS0HS1dMx2uR-a4GPfk4E4nD85rUtRUbVcETtY9g@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] perf stat: Fix trailing comma when there is no
 metric unit
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org, tim.c.chen@linux.intel.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 10:42=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Nov 12, 2024 at 04:00:40PM +0000, James Clark wrote:
> > The first commit is failing on Arm and I think the fix should stop more
> > trailing comma issues which keep happening.
> >
> > The second one I just noticed when looking at it. I don't feel strongly
> > about it so not sure if we should do it or not, but seems like the empt=
y
> > metric-units exclusion from the JSON should be consistent if we're goin=
g
> > to have it at all.
> >
> > Changes since v2:
> >   * Do more documentation and tidyups around struct outstate
>
> Ian, have you had the chance of going over this series?

It looks good to me, I particularly appreciate the additional
comments/documentation. Tested with sanitizers.

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > Changes since v1:
> >   * Don't skip printing when the metric-unit string is empty but pass
> >     NULL instead of an empty string.
> >
> > James Clark (5):
> >   perf stat: Fix trailing comma when there is no metric unit
> >   perf stat: Also hide metric-units from JSON when event didn't run
> >   perf stat: Remove empty new_line_metric function
> >   perf stat: Document and simplify interval timestamps
> >   perf stat: Document and clarify outstate members
> >
> >  tools/perf/arch/x86/util/iostat.c             |   4 +
> >  .../tests/shell/lib/perf_json_output_lint.py  |  14 +-
> >  tools/perf/util/stat-display.c                | 242 ++++++++++--------
> >  tools/perf/util/stat-shadow.c                 |   5 +-
> >  4 files changed, 147 insertions(+), 118 deletions(-)
> >
> > --
> > 2.34.1
