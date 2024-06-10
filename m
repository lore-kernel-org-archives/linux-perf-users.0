Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CDF8F6D
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Jun 2024 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718040812; cv=none; b=eC+i5AUC8ETPYctHen6DvK261d4lJEUq7OEsMb/vdNSvRQq/cCL4QDLhgQzaLYl/tRWNnueM7OnhoPLoOBHainKqfkEJIHre5rhrGSpATFbKuXj7Qa9XYAkNkM1+Q1J6nhMc/ORq7dgvflXELybeKxaE0u1QmRZpk9f4LSiLtXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718040812; c=relaxed/simple;
	bh=bdOYNNG233qRhz3XI+MlkfvaCLqk3IYfd5AUcptTRTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OW8Kq5OWy4L0L5gEqDTxfyRWBuhGxqh72cQkUicHl/R67SmtRuD5ZCy9tMgz+BqHmLMUIkoa53O/Athr1mwo7uQYzruEapWbkJZWuT3W6CAYfYoSLTHOiFLBejbprMRY6SpJe4of2ASorufDM3TBgchvbnp9oipGReX5v81wNcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yGaVnFKy; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yGaVnFKy"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-375acf90c58so10155ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jun 2024 10:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718040810; x=1718645610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdOYNNG233qRhz3XI+MlkfvaCLqk3IYfd5AUcptTRTM=;
        b=yGaVnFKyg9Rb3zjy0fAVI3x3N5HLyp6OASgZ7cUwUpLkbDNUz8OekH1qdUnh2C+WZg
         KLmVN05dSsp6ufDulXhbGh7+fhfMxFOuCN0vPHZXwdvU32MLqLUkZzaQIOnygQ06FUat
         vrhK37pMCb5BAN7G790lwJXNspVSzRyNyMfzWLI7F4d+EJRIvxUYkqJCWYg/f0DQl5/J
         SzCnACmXpk5+lhv6qdsSyazulC+fQgRyhcUhM4Ab5beORt/Qm2Ar11i9mPY49cYv82WF
         gtsFALksAAjsEzB4Si6bvRPY8N2OnC0UVOZsCrnl3+FHT+7tJ5GREW79MdYGdxuhZz5c
         cdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718040810; x=1718645610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdOYNNG233qRhz3XI+MlkfvaCLqk3IYfd5AUcptTRTM=;
        b=J/UuqWKof+pWod/OggYtI1ZHyU4/I1qnpqhkQcm10j6XKbxeZoScLOX3YLq+p01pZJ
         Dco7u5ZG6S3g+XBv1A/T95dCdYtvoH6/1uNGWLAJfw1TkSxX8LcD5EcSLMKDFpXCSaYh
         lfOC/xjC4LnIvBmZusYmDUJTnOa29RSz3M+IC5ayalu0CEVN5r2WUQyg75PEI0W4hHQ1
         HB8cngKXO0uwSNys8fC98FRWZFN50HRiLwJBeTAkZuVDo2JAK80pnBfjuF0BWendMK65
         frFBvOjDLaA3VB6NX6K/igGQ7y1Rp26qtPS1WcWbclLzigStRrqnExCxIiVRECDyqds5
         7PZw==
X-Forwarded-Encrypted: i=1; AJvYcCWmWlSq7v4KgR1QJ+LOFEeEC9rwhzknDIAKkmLkmx/vlK5xNtNcksbp02iaf+ywH4gRR5kdWejH6MvswwTP02ZOSwzZtdxUrhh0f/5E5LJseg==
X-Gm-Message-State: AOJu0YxixVtWp0rsS08T0oxRUagnp8W09oRg/n/NunFhTxgbMuZKhlyn
	IGPBWK+LidIYcrTKSe8IQqIr2MYHrEo2050M5UnbifXiwm9e8XLvEOrJKdavkID7T+xfOgVrAwf
	w+beliTWrfoGfK6cKhq8Q41cClXhxNqbpRaAF
X-Google-Smtp-Source: AGHT+IF4RQZ/xzq/w+dPDVh0tFYJbnw/GaaZTMKotm7PBgdv0bYpxjayBecUgCGMMMYygei/AwTVauljApyCg9dziQQ=
X-Received: by 2002:a05:6e02:3701:b0:374:8a2a:6557 with SMTP id
 e9e14a558f8ab-37594fc8d02mr5745345ab.25.1718040810130; Mon, 10 Jun 2024
 10:33:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607065343.695369-1-irogers@google.com> <23ee1734-7e65-4f11-aede-fea44ada3cc4@arm.com>
In-Reply-To: <23ee1734-7e65-4f11-aede-fea44ada3cc4@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 10 Jun 2024 10:33:18 -0700
Message-ID: <CAP-5=fUP69NJ+j6+9rUnp+UPBxcopJ=BOY-LeOjs8vYdt4soMA@mail.gmail.com>
Subject: Re: [PATCH v1] perf arm: Workaround ARM PMUs cpu maps having offline cpus
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yicong Yang <yangyicong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 6:30=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
[snip]
> I did a test for this patch, it works well for me.
>
> Tested-by: Leo Yan <leo.yan@arm.com>
>
> Just a nitpick and I think it is not an issue caused by this patch.
> After hotplug off one CPU and then if specify the CPU with option '-C',
> the 'perf stat' command still continues to run. This is inconsistent
> with the 'perf record' which exits with failures immediately.
>
> Maybe consider to send an extra patch to address this issue?

As you say, this doesn't relate to the problem fixed here. I don't
have a problem with the command line behavior change but I think my
getting shouted at budget is fairly well exhausted. How about we trade
issues, if the following get fixed:

Renaming of the cycles event in arm_dsu_pmu.c - I'd say this is a top
priority issue right now.
Fixing ARM hybrid default perf stat (it is crazy we can accept this
being broken), opening events on both BIG.little PMUs as done here:
https://lore.kernel.org/lkml/20240510053705.2462258-4-irogers@google.com/

I'll address this.

Thanks,
Ian
