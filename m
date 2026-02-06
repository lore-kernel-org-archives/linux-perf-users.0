Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5823093A7
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405568; cv=pass; b=nwUbRcaHMBv0Rgku1Q/5lUt7AYPm9HcNO9YHDQ5ARHh+LL5g8cgAdlmD+A57qusjPGPzBk491z8nA5NP5xJXZWF11IebdTbBLqlM7F6J2wDDY0JmZP5S8OGaMjZwtpig/E5UFkCiOTAiPLqOxMuNxZ+Ghmg+yySdCCLp2NjUhfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405568; c=relaxed/simple;
	bh=buZGbJoYjPlgi2GCw+7PUIMrhKwINqIof++nu/YdArY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRLvpPNkFKgY4AUQVLeuche7+WKAZ5xxaIJGQUZd09wbO2DNReLp16Ubu7wwpKLRy3nl8wYD0QMaS1LS8DWXKwAa8ojxYoBGrLrdFXclyo2Ht7aGr8AWiwrTDj67Bo23WWQVrX235XTAnLXncUZX6pCDNBNBip5FgI0O4W4I7As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=adwG3wtu; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="adwG3wtu"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a8e4ae61a0so9435ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 11:19:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770405568; cv=none;
        d=google.com; s=arc-20240605;
        b=avrH28hkU4gaKDp74C/gLnepgKJeGzL6wRQkHFVQ0qcQORszJvNoNa0XvW+vZbhCiz
         g1I73KbnjqqMZXyXlNPUELTGpbNoCkt+XTZhK0JQ3QaxGdU3or8H1A86FUxQJOaGIGzK
         COcwZ1fxA7pgib2ke4XixhXIsVb+FYKPlMCnbkvdfoF40YP0OtD0YeKCw25ycjX1QTBP
         EAdnGPuYwp+akvZkBTc/YLmPKdlIDBiDY0G+bvW5HES0b0s1WyScVQXVY4JFjqcrKYYW
         5QnXmPmKun4WVuYRudQ2LDUs7qCqKiplKcL1A5NKOqPRpvaEWLL6H/reyUhe07LLzrXq
         fRSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MxTdWU5tuu6+qfMN58qpU12Y3Qae5ELJshE5hcOlRos=;
        fh=l7efn5mLU+2OvAdSWwznmU8U10usUMML6eqTFfOpo3E=;
        b=eJymeP6ASy49gMOu5lqxOAQ4PYS1UuPZOxtCnPOhgPOh1tGImJAzFdv1OfFl8b0m6O
         wXNGsqUNgi1GdAMhHjUWY5Q89YAyF4CkhQ6tM1Lr1nDFqcMt/VMx8VBb2fL3mBZiltIk
         93s04pB84lBnHJkVgxPc9eyi2VHkExl6szMLC3Wy5YhAel8/ofPAqpvxOUp0CtAKwPE5
         KKLR/mNoPx7JNZyi/6dZO6ssoYGqMJFXbvUbQbB3AAEi8zfYNeDVO16U9HgJiN+395Nr
         Wt3yhYnjydhi/29OD08U1fCAvU0Bep2whkSC+HNctGMInLP4KpPgjeTuIfdd5leHtEy3
         zSaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770405568; x=1771010368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxTdWU5tuu6+qfMN58qpU12Y3Qae5ELJshE5hcOlRos=;
        b=adwG3wtuHQs1lPiooNaAGuzW6kQqks65sbQDNdjznJKwVC0bWSXDwp8/mw73rRaSdS
         Xh28bQiELWIkhoQ6CMmdQh0tys93QzY5tXXAAxfia+xORaZtJoh3od3SROSZHhYRsLJl
         4+2I55QFioEaV5V8h/h441bZL8JJDin76SRqDjEs5OOeFN9x0YyRwrmBJiQ2Cgwt0iya
         DOo/kE9Ly+AgNWcIL8yaCrVIwMPyGJ5/W8YJ6EN30Plu//zSaww6zhq1t8ztW/IQvRfV
         qzaT7aBPzhMFAN4me9/XHgRjLpe50tGmeGbJBzj2mesqz/wbjvKSNWAy5CTdAJH59Lf8
         +sNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770405568; x=1771010368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MxTdWU5tuu6+qfMN58qpU12Y3Qae5ELJshE5hcOlRos=;
        b=jvv4n81aCAyagPFB7TcqSdN+8qtt8UNQCb0Knxyj481bqCVyoj9y5oHFdQLJRDHjH+
         nwTMYmk77x0i5yrzyZEQxfA3EFwC/3UAtVmKyXZDpSiswpV/eNb5Gl0VaJAzzwg5A8SB
         qcXpJ9v9rE430wirgCIhkqKDkR9kUZd1MLyHxGl8oTZzM5uMZw+CQJc8ao2yjETnRuUT
         XiATNXUGIXhbpufjCkiwOs4nPuZdIVpQZoOGuUJ24G1N1bdrjZxhs8A5P9W31LR70E6l
         IROMv4a6mddnkdrCcvi3elJ4d4Jilv9W8UO9AwLVI/eHGq8Kf++CcaVT5wi1+PKaBwGJ
         2aRA==
X-Forwarded-Encrypted: i=1; AJvYcCX7SDto3R+XcfZ0cNhaH6xMsMbvg0elGy9WVkga3gzmD/QHlYrx44vSOAgwczBYl8yt1eiL+UkXCTxN0zI1CWCk@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl7Dq3Hcrk0cugoDU7dC8qKsF/3Z6F456n+kDVHTfWnEbydQcQ
	x4lMOXGPQqVxlbLgtUAupVtcmav46kOAc/JGYtL5wdIpaE3qf3oRQcjBK91gBd3Wb02nWM+Kg5a
	NU4XiAvPEAvegv+qsTAB7WNygbQIQ2ZrQ545ZBBat
X-Gm-Gg: AZuq6aIkl0ezmJIiqSZuzaAIwPhFRrDjnCJoARl5/fnuYX+EntqwFZwp1jvCRlWGiCR
	7LY4yqX1h8gS0XAG7vR7ran7FsRM0dn3ev7KTMaYXao37L0OuaLECsxuGfxEiLKB7J+hdGh8KPI
	EroQdE8s+bF3c/5UzUKp2V6Y2u+Lw34bjNBZIZlad4hJOobuYRVe+L4owYlbpAermE7KQwhCXAy
	Jc2rvzt0gMJFabxkDBKP9oZtpTABNgZDWIT1KZ8vCnKOGBZkwormwAkYQbLcPjH3CGQ7NFN
X-Received: by 2002:a17:902:ccce:b0:2a9:4bf2:7ede with SMTP id
 d9443c01a7336-2a962078ef3mr200615ad.13.1770405566938; Fri, 06 Feb 2026
 11:19:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206-perf_improve_log_for_open_event_failures-v1-1-366903bebcd7@arm.com>
In-Reply-To: <20260206-perf_improve_log_for_open_event_failures-v1-1-366903bebcd7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 6 Feb 2026 11:19:13 -0800
X-Gm-Features: AZwV_QgN7ZliPkBudJ1fqvtsqS0F_HB_r8O7_a6MwNFh58l7JWhlUZ0izclBsX0
Message-ID: <CAP-5=fUDex9Co5-_fkQD4a_fS_+Y5k_rewcPYR+gzxyg3YdAPQ@mail.gmail.com>
Subject: Re: [PATCH] perf record: Simplify open event error logs
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 8:29=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Instead of printing error messages for every event failure, this commit
> prints a log only when the first error occurs.
>
> Duplicate event names are a special case.  Print an explicit log message
> only when verbose logging is enabled.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Nack. I find the logic harder to read and "event name duplicated" ? We
silence the warning specifically on cycles for ARM due to Linus not
wanting the spam. It doesn't make sense to me that we may fail to open
>1 event for sampling, but still open 1 event.. but we only complain
about 1 of the events failing to open which is misleading.

I think this is motivated by not wanting to see >1 warning when there
is a permission issue, so let's special case EPERM and if we just show
1 warning for that then we must terminate perf record and not hide
other issues. Maybe is_event_name_duplicated can be called
is_special_case_keep_quiet.

Thanks,
Ian

> ---
>  tools/perf/builtin-record.c | 69 ++++++++++++++++++++++++++++-----------=
------
>  1 file changed, 43 insertions(+), 26 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index aa8dc3e18190dd7db1ed5e3c7673fde8d5785a26..9382ff57a822ad4ee53911165=
10941ce180a12d8 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1343,6 +1343,31 @@ static int record__mmap(struct record *rec)
>         return record__mmap_evlist(rec, rec->evlist);
>  }
>
> +static bool record__is_event_name_duplicated(struct evlist *evlist,
> +                                            struct evsel *pos)
> +{
> +#if defined(__aarch64__) || defined(__arm__)
> +       if (strstr(evsel__name(pos), "cycles")) {
> +               struct evsel *pos2;
> +
> +               /*
> +                * Unfortunately ARM has many events named
> +                * "cycles" on PMUs like the system-level (L3)
> +                * cache which don't support sampling. Only
> +                * display such failures to open when there is
> +                * only 1 cycles event or verbose is enabled.
> +                */
> +               evlist__for_each_entry(evlist, pos2) {
> +                       if (pos2 =3D=3D pos)
> +                               continue;
> +                       if (strstr(evsel__name(pos2), "cycles"))
> +                               return true;
> +               }
> +       }
> +#endif
> +       return false;
> +}
> +
>  static int record__open(struct record *rec)
>  {
>         char msg[BUFSIZ];
> @@ -1353,6 +1378,7 @@ static int record__open(struct record *rec)
>         int rc =3D 0;
>         bool skipped =3D false;
>         bool removed_tracking =3D false;
> +       bool report_once =3D true;
>
>         evlist__for_each_entry(evlist, pos) {
>                 if (removed_tracking) {
> @@ -1370,8 +1396,6 @@ static int record__open(struct record *rec)
>                 }
>  try_again:
>                 if (evsel__open(pos, pos->core.cpus, pos->core.threads) <=
 0) {
> -                       bool report_error =3D true;
> -
>                         if (evsel__fallback(pos, &opts->target, errno, ms=
g, sizeof(msg))) {
>                                 if (verbose > 0)
>                                         ui__warning("%s\n", msg);
> @@ -1383,36 +1407,29 @@ static int record__open(struct record *rec)
>                                 pos =3D evlist__reset_weak_group(evlist, =
pos, true);
>                                 goto try_again;
>                         }
> -#if defined(__aarch64__) || defined(__arm__)
> -                       if (strstr(evsel__name(pos), "cycles")) {
> -                               struct evsel *pos2;
> -                               /*
> -                                * Unfortunately ARM has many events name=
d
> -                                * "cycles" on PMUs like the system-level=
 (L3)
> -                                * cache which don't support sampling. On=
ly
> -                                * display such failures to open when the=
re is
> -                                * only 1 cycles event or verbose is enab=
led.
> -                                */
> -                               evlist__for_each_entry(evlist, pos2) {
> -                                       if (pos2 =3D=3D pos)
> -                                               continue;
> -                                       if (strstr(evsel__name(pos2), "cy=
cles")) {
> -                                               report_error =3D false;
> -                                               break;
> -                                       }
> -                               }
> +
> +                       if (pos->tracking)
> +                               removed_tracking =3D true;
> +                       pos->skippable =3D true;
> +                       skipped =3D true;
> +
> +                       if (record__is_event_name_duplicated(evlist, pos)=
) {
> +                               if (verbose > 0)
> +                                       ui__error("Skip to open event '%s=
' on PMU '%s' due to "
> +                                                 "the duplicated naming.=
\n",
> +                                                 evsel__name(pos), evsel=
__pmu_name(pos));
> +                               continue;
>                         }
> -#endif
> -                       if (report_error || verbose > 0) {
> +
> +                       if (verbose > 0 || report_once) {
>                                 evsel__open_strerror(pos, &opts->target, =
errno, msg, sizeof(msg));
>                                 ui__error("Failure to open event '%s' on =
PMU '%s' which will be "
>                                           "removed.\n%s\n",
>                                           evsel__name(pos), evsel__pmu_na=
me(pos), msg);
> +
> +                               if (report_once)
> +                                       report_once =3D false;
>                         }
> -                       if (pos->tracking)
> -                               removed_tracking =3D true;
> -                       pos->skippable =3D true;
> -                       skipped =3D true;
>                 }
>         }
>
>
> ---
> base-commit: 3d8b2baefecdd5e84a1c738bcfdb079aa536d997
> change-id: 20260204-perf_improve_log_for_open_event_failures-deda2c61b93d
>
> Best regards,
> --
> Leo Yan <leo.yan@arm.com>
>
