Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374731A55E
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 05:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784265735; cv=pass; b=FMUgsCKB1vOV68IJo1lpSKehkItEFvtiy7gQKTkjwYFKTj5OsrBUlCQ80Mkw57WgLQFTOtFL9qPvs/HGW1BzzlHs5TMfjV/lhbWxSjiKsESQub4lmjhT06VmfCQElDmb9RIwBdyZqrTzYX5DuLiugjbocOkhNvlz/Cdggq/A/mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784265735; c=relaxed/simple;
	bh=ql8Be34VW2lo6TAOHvlGm6gv/Xk6Ff0bBYwoq0BUzNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBCmmoLQs9NbkJLvoH+gEgFZl6ECXKYuq3N0+TokjKp02ySOaG7tP9fooiB7fFy1xOqXsRwc7elb9T+jz0MY7uYoxewt678xUg5IvahVVcAi39sqerg5pAGsBc3AIwklc7xDCAhnd8ylVX42lHg96mt5dBCoXOPb9M0f8m8vuJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dhOJpVZ2; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dhOJpVZ2"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cab97c86bdso114635ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 22:22:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784265733; cv=none;
        d=google.com; s=arc-20260327;
        b=d/2q3qvcEYaR+84eUijkTYvTE9BgiQOEsmobmML8TixHEcAwdOxlJyTIBXeJ/FMrFv
         GRoQynkM092HhH1EUzXgNJceIkL6ix06wU2X/+ZgYG+g+JVeinZfm8U1sXfC1kRA9j0d
         nCPtLTGRgmbh7FDdqn/e6osJkOSg4TMkWdiiHml8sFWcFSN93qoNB8a0ed27VTUOmgb5
         admLXE3mzeb8S6zRH1VP57fclttuE83M/2nzWCcfwVyGhe/b4NQWd2lzbn38R/9NkH8A
         swWeGFDgEwJDdQDJBVeWrrrlqMXE7rvoS6l+CjIz7ooz7wkV3MHxYzgrsExrif3Fok3Z
         X1Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5pZ1X8ux5WB0nx1HhS+tblVXutyhqnjCn1/MS9Oeld4=;
        fh=tZB+RwFzdkSFhj3GRtH/qPSNTe/Go2Zh1W2C9FRmF/c=;
        b=WmdfkxuACHPY3zH279ZobSkrbOa6PR2jumBH247W2knunFvyD3z9f8hrjRq1X9J214
         Px6bQThmUQRD+UrMCgfFrcGEuBeQsS0X95I0z3TcFr5KEiu91qb42QH0x2hiZlJGuZlj
         v9tZ5h75JywBeVdqKArsFtkw/f6XCRW90ilOb3fY5oRAlBDkhLzcHTtFMfHlMOka163q
         KwyHV6YMpzK9z7OwvlBIffcrFsAz3tOhHByL5BnNHEHqCCdwll9QTZ8n688MsfYNPZzR
         EpjiSp0xnLG2Rx8zWGyLzNu6gJKU5VNUDn1bsh4ZHQzYl7Bfd/4Xv2v4D8OLyWHJ+jdV
         Kj8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784265733; x=1784870533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5pZ1X8ux5WB0nx1HhS+tblVXutyhqnjCn1/MS9Oeld4=;
        b=dhOJpVZ2Lj0NLATBaUlI/AgPIzI7FwbZd8wuvRs/3w6GkfSdbmR+JhMVhnIEOKewNm
         pZ7lPjK9nMDVLIBrs5A+a4J1bNi3sMDWJiSsmpYDOPNIOjDJZyLAvgKgLTmx3IPj0vHr
         fIkN8q30+B/lZjlCC+41aQiKIp0r8nVDNEfmnP51db9RU0/BgbAb1MUaDyALstIz0cpE
         qGPNCSdEaJ+fWC1BZtP6r/ie4THfHA046xGxy9AHbrv7gLKizAYMx3m0MVyR6Thb8Hi5
         vBnFTYXF34exaRI2m6KZXjwjZD+KZRki9G3jaJ9nYsrrQQqZiJcVR6PUpEDe9exbjmJT
         NKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784265733; x=1784870533;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5pZ1X8ux5WB0nx1HhS+tblVXutyhqnjCn1/MS9Oeld4=;
        b=MFXzqBCnD2l+y+dylWQrBp3wSOh+s4lVZDwLsprw8ZzXCMnVSp3R4nVZh4KVSe898X
         ZDpjxHDjZwLIl93bfeo2L405p+Lahp3xB3otmJGXdY6KEP0gn0dVDaRH1Kt3WiR9fQbF
         Om8acQS5MBWISIIz8G/EB0M27P070vtAVDMi8UWRRym3+RECDdta0USiYF/B4tvKbws7
         JtyLnpT9GE+a3wC43CZQUy/rVbpxmMghhK7AhbEqBX7K270orckHJ3hfXt6EIK6MGHGv
         FKwpi2rExd4nPExlEQ7pvz184NfnTQPTY85areuIeoFK9ffClueUc4GUZ14zgbm4HQb3
         BG9A==
X-Forwarded-Encrypted: i=1; AHgh+RqNVf8f93s++SPfhUvkFlfevNTcR57unoNdjdtRWSqDE1QgfAfF6RW8iMeiywV7BUwzBWjWtHBtVVUefGBaFXS2@vger.kernel.org
X-Gm-Message-State: AOJu0YxDO6BHcQJlrRhqw1EgbLD9Bamr59QMLe4K1YR4nvX17Qzu+oBs
	3Stzs+ToY674F12aMs2cHlyNWN858udF2YNHFCnT5YK1Rc1SYjtfMEADGMOJk1joCQfr9AJHHu7
	eO5YnXyt2UfDdJeWcpKFCACIyKzypkd2n5hfBb9qs
X-Gm-Gg: AfdE7cn12s019Xn+TevCA8+iLBq1YsENrch66OOMEQE8IvLIODuV8rf9AtCj76+H7VO
	foPUUmqlFNUhVXosnaU2k/LRGc7fjoAgOYIoPJTNKq0OtGo3e0eb9lsnRnAImN+Wa16huDpS834
	ER1uCsoEyHrOPxj7E7G0EORseRuNZuEqbryU+PUs637nRJJ2jP9a3zxmPwqhIBF+r0kyA8VLqQD
	zS+0WwkIPNy8luJy07L2TdeyGCghKarWXWkosfpPzLoDSreYNfqrn6I/hG+2Y4=
X-Received: by 2002:a17:903:4095:b0:2ca:e513:17a6 with SMTP id
 d9443c01a7336-2cf32439f52mr1040355ad.15.1784265732973; Thu, 16 Jul 2026
 22:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717023134.272578-1-atomlin@atomlin.com>
In-Reply-To: <20260717023134.272578-1-atomlin@atomlin.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 16 Jul 2026 22:22:01 -0700
X-Gm-Features: AUfX_mzaVekEQXII3rZlnpu-5Vd3RAcPyodWCt3WPei_1B44EdNS2zNunGbk_A0
Message-ID: <CAP-5=fVcpOPKoqRzYS0i0XzP8KwOhUFEwzuXtM3FbByBGTvO7Q@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Add --hide-zero-events option to suppress
 zero-count events
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 7:31=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
>
> When monitoring a large number of events (e.g., with wildcards such as
> --event 'syscalls:sys_enter_*'), many matched events will return a count
> of zero. This clutters the output, making it difficult to spot the
> active events.
>
> Add a new option --hide-zero-events to suppress printing events that
> have a count of zero.
>
> To prevent formatting and diagnostic issues, the zero-skipping logic
> implements the following rules:
>
>     1. In metric-only mode (i.e., --metric-only), columns must remain
>        aligned in the output grid. We evaluate config->metric_only first
>        to avoid skipping zero-valued columns, preventing values from
>        shifting left and aligning under incorrect headers
>
>     2. For explicitly requested events, we ensure they are not silently
>        hidden if they are unsupported. We only hide a zero-count event
>        if counter->supported is true, ensuring that unsupported explicit
>        events still report "<not supported>"
>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

I think this makes sense but perhaps the Python interface makes more
sense for what you're doing. For example, the ilist app shows all
events and metrics:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/python/ilist.py?h=3Dperf-tools-next

Perhaps we could also add some tests for better coverage:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/stat.sh?h=3Dperf-tools-next

Other than that:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-stat.txt | 3 +++
>  tools/perf/builtin-stat.c              | 2 ++
>  tools/perf/util/stat-display.c         | 3 +++
>  tools/perf/util/stat.h                 | 1 +
>  4 files changed, 9 insertions(+)
>
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Document=
ation/perf-stat.txt
> index b72a29c9223c..f334aabdc809 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -162,6 +162,9 @@ null run - Don't start any counters.
>  This can be useful to measure just elapsed wall-clock time - or to asses=
s the
>  raw overhead of perf stat itself, without running any counters.
>
> +--hide-zero-events::
> +Do not show events with a zero count.
> +
>  -v::
>  --verbose::
>          be more verbose (show counter open errors, etc)
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a04466ea3b0a..8d340c2ae76c 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2493,6 +2493,8 @@ int cmd_stat(int argc, const char **argv)
>                         "display details about each run (only with -r opt=
ion)"),
>                 OPT_BOOLEAN('n', "null", &stat_config.null_run,
>                         "null run - dont start any counters"),
> +               OPT_BOOLEAN(0, "hide-zero-events", &stat_config.hide_zero=
,
> +                       "Do not show events with a zero count"),
>                 OPT_INCR('d', "detailed", &detailed_run,
>                         "detailed run - start a lot of events"),
>                 OPT_BOOLEAN('S', "sync", &sync_run,
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 0a5750bb59fa..1579e3e2c445 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -907,6 +907,9 @@ static bool should_skip_zero_counter(struct perf_stat=
_config *config,
>         /* Metric only counts won't be displayed but the metric wants to =
be computed. */
>         if (config->metric_only)
>                 return false;
> +
> +       if (config->hide_zero && counter->supported)
> +               return true;
>         /*
>          * Skip value 0 when enabling --per-thread globally,
>          * otherwise it will have too many 0 output.
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 4bced233d2fc..e3598037a6aa 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -69,6 +69,7 @@ struct perf_stat_config {
>         bool                     interval_clear;
>         bool                     metric_only;
>         bool                     null_run;
> +       bool                     hide_zero;
>         bool                     ru_display;
>         bool                     big_num;
>         bool                     hybrid_merge;
> --
> 2.54.0
>
