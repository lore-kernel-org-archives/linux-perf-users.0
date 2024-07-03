Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A811836EC
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jul 2024 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028133; cv=none; b=jENxJhQfQY2KzXICTz0B40C0KtoLf21hkeE1kgRckr95djclrjJi5Ru08EZO2WuKw1mtnwLGgmwilNOuvLVZz+5ivfTpG3Qf2Qg86ZzWEHWvZWiCuYNpBNavT4YMcyD6DEMEPd8nx5wHKIGiKMrTuiBNyGR38ehooSOUST9KO4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028133; c=relaxed/simple;
	bh=wJqbm0cbDl3OnGsiCx+j3UvhXYjJ+xSxrF8iQeOZADw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgizOZi5zTAnTHOSPHOJENDEhcw88QBcGMXmpwai/GmrgqxvT5ggVhc5PO/2V2G62yNrkh/DG76at3wCqoep0PhbSTtZLt6/0iDHntmM5EiSiDwRabAxuMrQAqdCFYhUH1hu9FT6XIPKIvziHVwsYVhzPOOTbUcg0+bneYHCkAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=Ew771wkM; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="Ew771wkM"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58b966b4166so2848174a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jul 2024 10:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1720028129; x=1720632929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=La/5eaYjg7H10Or0G7dRQblWRQsDom6PBTc29FvwiUA=;
        b=Ew771wkMq+bZe9z1mdKOOaCBmlghWM4YQ1pE7iwmJv6xNqWZA//bGGIsqKVXtqHijg
         A8KEDQrzybsV0tScp0gjMsEOuAhsn5da8O4YVxqMTh5odB1BV8Nh0eoa+2nPiBvYaew2
         AnxAL9um6v/FsGNM0QmEe5lN1eeZtLtQTTs6z0b+SNubM+CibLB4xgKEoPYWGNdlfx7v
         8o+X8rZqVYXTpw2wRTwBX1ei7mCrGMVcFwxLWPW8/PSqfz1osR2Vklgg4PKMUvP1MuXR
         u9p1EECek7zDD8GzEM8TqRz16NOhDY2BecPbKa26K31emH+4R4KjDn/PZeFEhFL9Ihts
         PKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720028129; x=1720632929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=La/5eaYjg7H10Or0G7dRQblWRQsDom6PBTc29FvwiUA=;
        b=BpskSyqF4k5Ukh1m/1/iAHjOhj4vtbvhbi/+x6ffjzJimgQeA0hl863hPqNjdj2czo
         TM4sluWnGw0j1H7a/dBs/b5QsZxxXMFIKlyxkKJafMkT0YATY65kKk5522gZOg1JBkP8
         ljhjH07wl+6P9dztVbrHiM4jrtdp0fDoGHcGNdECOkbdiSKG4XpMc0XZ8jmXnXl5GSAx
         f/wAUcu3hE204dY7zpAhdWZwtRHseNqYlV1kSexs2OXj2qkjoxWf6aWRnFZGilesqzUD
         xdePKxKXbrOaAHtJDqPwh8LYePZ6QxJIQJhS3iDIgvnsZ2YG2QzDW/ueva/EsPPG+Goj
         wOow==
X-Forwarded-Encrypted: i=1; AJvYcCUcdw1cymkfC9jc/vWDWd5P5bxo0CGqfo50y/ZziFOyDLrvadCnfOxvZSbxD5mj1BkRCRLxn3omdW0T2Penp5r8GsoATYvou1uboRHnCerk2w==
X-Gm-Message-State: AOJu0YyNziGTqKRCdaB0YdT8quL+/UbTpSYMpoMw/caNbtDNMD3eQy17
	ODoHkjaogB1lJKW5ygeU1eay05VQxocaRKJnIzytY0gnfxwEls9w+rjrIbP8eofPd517+lszkKd
	AtYzKmPx1jo2KYJ/09N2Fgn75ABhfZC2JXufNbA==
X-Google-Smtp-Source: AGHT+IFBjLDcJRjLamuVf5zi9ojzKBMa9/VQRJAc3OBE+azv+Z6WVHDWucZC0ZTibSml6j6VgCjcl6c8rGjZ4ILsUhM=
X-Received: by 2002:a05:6402:2345:b0:58d:10a0:36c0 with SMTP id
 4fb4d7f45d1cf-58d10a03b2cmr1425175a12.14.1720028129456; Wed, 03 Jul 2024
 10:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703172117.810918-1-irogers@google.com> <20240703172117.810918-2-irogers@google.com>
In-Reply-To: <20240703172117.810918-2-irogers@google.com>
From: Matt Fleming <matt@readmodwrite.com>
Date: Wed, 3 Jul 2024 18:35:18 +0100
Message-ID: <CAENh_SR=4axuur1=ibGnGre8vm7tHNeG0VT-f1UQS1mHCUb-Uw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf comm str: Avoid sort during insert
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Steinar Gunderson <sesse@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 6:21=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> The array is sorted, so just move the elements and insert in order.
>
> Reported-by: Matt Fleming <matt@readmodwrite.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/comm.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)

Thanks, this fixes the issue I had where perf-top would spend >40% of
its time sorting comm_strs.

Tested-by: Matt Fleming <matt@readmodwrite.com>
