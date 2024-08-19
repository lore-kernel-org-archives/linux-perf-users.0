Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F13018E0E;
	Mon, 19 Aug 2024 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724098152; cv=none; b=u7aWAsEWeqvBALs0ewfZ1uoHqPZnIPMlfdA8PFzZPVfqaXjf9S04arUY2ETOBxBGsuELkIa87lnKXyXDjYoHSMsDiVpFWRSkJDtCtEuKZ7V9jwUE+I9er+NtVmZxRlUhc41JM559k9peucYgVU5shugZH1Kk7X927qK7FsN2q9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724098152; c=relaxed/simple;
	bh=+UPPJYag/m4h3wmsG4EdPH+sPAO3SON3ZYhz4rhN5xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3lCZB794O2UwDWdOhIvbRdKqy96+4QRhFaHl+PnEV/Yul/PDsaQhyImTvzu+DKBOrAkXK417U7FybXHE6suUW2YsdB3ls8mKOsjK6eLeGHaptG6/DpVJcZ77AkGAQBcXyFPGmZW8ka3EJAxrfbZvD9T1AetOLs/WF71ylM6Dzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so2750347a12.3;
        Mon, 19 Aug 2024 13:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724098149; x=1724702949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3EoyLPQq+YMxkoG+Mrd7tvdqc5Xz8xu+mvsPoiNt+c=;
        b=Pa66dK2hkbbJLesoSo0NFsNouBgXrHt57W5qYE/KHvslB2vUD9OyqAgrKmGZM0yGGq
         WDerhQbc2iBAFzNI9i/zSegInUh2IdX+wa4GHDpoznje7h1sNiqoLOvcwMdn4GcQKcPw
         CkwpVDTtTIxch3zwv7DtzlFMYciE4QdmaFGFRgSc0h17tdxovbiZ/GLZ/8eyp8atjk67
         R/DlB56o/udKSCqR3Q+lD0usDW+nmPNDjh+C0YTduEN8HFEGHK4d/oUYj/uu1PZ9rNXO
         S/M3k2ga5G6CAIUUdeP1IpolZjQjGTQwUHA8Iw2Y756rPl0EbcTt1JjaZTIKNoJlH9pX
         Cctg==
X-Forwarded-Encrypted: i=1; AJvYcCW4lJO2fUohOikwG13Mj3hmAXn2uR3ark1gNUfRgsI3DTG2nmvGHF7vhoHGFBfY/QdWcPvtfpFUogaYXBeR50IErDtSKQOXdLh90yN7sNZnkpz8TUsLPptjl2wHHpXmng6Qdgq877CGe/T2/R46hg==
X-Gm-Message-State: AOJu0Yz98Y0DpdU3xU/BS0yuqQIVafUPBKkIqIquJnZ1Hh7tDZVrb0AK
	H/FbqVXCyVxMYIJ9ZC+5qRyM/1BD1JlYMgSvlgXatzTJwG1/AO8XspflOS7MdUq3W5Y/PxiGjD2
	4+eVW7FjPwBaB/D2MDXRQ2Kpe/zo=
X-Google-Smtp-Source: AGHT+IGMSVmvo70wQIuDgstPMFXM7LIdsfv1xfTLoPIDqC3FOP/JlT2Y2h5SDccjQwGkt2btjQqhadgOuDlDH/6UQMI=
X-Received: by 2002:a17:90b:19c9:b0:2d3:c0b9:7c2a with SMTP id
 98e67ed59e1d1-2d3dfd8bef4mr10596245a91.20.1724098149035; Mon, 19 Aug 2024
 13:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819024720.2405244-1-yangjihong@bytedance.com>
In-Reply-To: <20240819024720.2405244-1-yangjihong@bytedance.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 19 Aug 2024 13:08:57 -0700
Message-ID: <CAM9d7cjvx2jozQNiSj+Anf1+hsyL7DT17XJWv8oDJUr_4Ud=hg@mail.gmail.com>
Subject: Re: [PATCH v2] perf sched timehist: Fixed timestamp error when unable
 to confirm event sched_in time
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	james.clark@arm.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Aug 18, 2024 at 7:47=E2=80=AFPM Yang Jihong <yangjihong@bytedance.c=
om> wrote:
>
> If sched_in event for current task is not recorded, sched_in timestamp
> will be set to end_time of time window interest, causing an error in
> timestamp show. In this case, we choose to ignore this event.
>
> Test scenario:
>   perf[1229608] does not record the first sched_in event, run time and sc=
h delay are both 0
>
>   # perf sched timehist
>   Samples of sched_switch event do not have callchains.
>              time    cpu  task name                       wait time  sch =
delay   run time
>                           [tid/pid]                          (msec)     (=
msec)     (msec)
>   --------------- ------  ------------------------------  ---------  ----=
-----  ---------
>    2090450.763231 [0000]  perf[1229608]                       0.000      =
0.000      0.000
>    2090450.763235 [0000]  migration/0[15]                     0.000      =
0.001      0.003
>    2090450.763263 [0001]  perf[1229608]                       0.000      =
0.000      0.000
>    2090450.763268 [0001]  migration/1[21]                     0.000      =
0.001      0.004
>    2090450.763302 [0002]  perf[1229608]                       0.000      =
0.000      0.000
>    2090450.763309 [0002]  migration/2[27]                     0.000      =
0.001      0.007
>    2090450.763338 [0003]  perf[1229608]                       0.000      =
0.000      0.000
>    2090450.763343 [0003]  migration/3[33]                     0.000      =
0.001      0.004
>
> Before:
>   arbitrarily specify a time window of interest, timestamp will be set to=
 an incorrect value
>
>   # perf sched timehist --time 100,200
>   Samples of sched_switch event do not have callchains.
>              time    cpu  task name                       wait time  sch =
delay   run time
>                           [tid/pid]                          (msec)     (=
msec)     (msec)
>   --------------- ------  ------------------------------  ---------  ----=
-----  ---------
>        200.000000 [0000]  perf[1229608]                       0.000      =
0.000      0.000
>        200.000000 [0001]  perf[1229608]                       0.000      =
0.000      0.000
>        200.000000 [0002]  perf[1229608]                       0.000      =
0.000      0.000
>        200.000000 [0003]  perf[1229608]                       0.000      =
0.000      0.000
>        200.000000 [0004]  perf[1229608]                       0.000      =
0.000      0.000
>        200.000000 [0005]  perf[1229608]                       0.000      =
0.000      0.000
>        200.000000 [0006]  perf[1229608]                       0.000      =
0.000      0.000
>        200.000000 [0007]  perf[1229608]                       0.000      =
0.000      0.000
>
>  After:
>
>   # perf sched timehist --time 100,200
>   Samples of sched_switch event do not have callchains.
>              time    cpu  task name                       wait time  sch =
delay   run time
>                           [tid/pid]                          (msec)     (=
msec)     (msec)
>   --------------- ------  ------------------------------  ---------  ----=
-----  ---------
>
> Fixes: 853b74071110 ("perf sched timehist: Add option to specify time win=
dow of interest")
> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>
> Changes since v1:
>  - Simplify conditional judgment. (suggested-by Namhyung)
>
>  tools/perf/builtin-sched.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 9c1276dc8ef6..1c386ebe4b98 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2683,9 +2683,12 @@ static int timehist_sched_change_event(const struc=
t perf_tool *tool,
>          * - previous sched event is out of window - we are done
>          * - sample time is beyond window user cares about - reset it
>          *   to close out stats for time window interest
> +        * - If tprev is 0, that is, sched_in event for current task is
> +        *   not recorded, cannot determine whether sched_in event is
> +        *   within time window interest - ignore it
>          */
>         if (ptime->end) {
> -               if (tprev > ptime->end)
> +               if (!tprev || tprev > ptime->end)
>                         goto out;
>
>                 if (t > ptime->end)
> --
> 2.25.1
>
