Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862F2155314;
	Thu, 15 Aug 2024 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723761894; cv=none; b=cwqudw1sXX7KXqrvfkmr2uqPuEC3kIUhZF51iyaC2Eehxmst2C9bTXQHiJaER3ILEITOh8aJh+PJIgl8dFz785xZZ9gBkaOADRn+uJ7HDKC0+OpSv3sEiVY7549eI9S537hvRxp/TPb3OGy7Eq/gDpgI/4Hbvkwk4P+tjPjYIzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723761894; c=relaxed/simple;
	bh=qkYGMFqPQuKI3g5yvw3VsNeFCwrBDk6bgsSaPFQsnps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lq28Y9kmIDxVB6De56EcO3YL38BLNNxSMcr50ABcas9Qdh6dBGPGsTRgvHKB/ojRqlz4sUZ+ExrnOiobzGFMQFUNhlUNn1HyqJMohqo7fdyykFbnSW7y6j78J69fUnAwschZY3foae8ytf7z03ioQIfi2Ool9BfI8oBPDPxeurU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so872066a12.3;
        Thu, 15 Aug 2024 15:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723761892; x=1724366692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmncF1jhdBEnDZjbmCr4nruq8dsXgg90IMyxWFpb25I=;
        b=FsHcsJsGwwcy191GRGMpOQZ2ZE1pveFOW1MLhXGPNCHvw0XBQsbelPVqVJNrl4qOSX
         O9CNfkyjfI+B2V9OGySyCFCsrostZeVzHdK6OZ5UV6w1mTf2KBMMlBNJ+Hp09mAILdk8
         ot+dWZyWlMVjIhn73gtr7SYEIPnEFdbfuctaU0f1ekNucu3oKnMp1YUCXr0i6yFrJHmY
         QiAKR7vlgKGXlGQdbp+bSvMj9Ipb7Ftmj/B2EoorCkRlO/h4kozLOIvPAc2pRVG6R5QR
         aajgae+agfNLRdAW11Kgx0thUU+mY5vRn2ohbXgdPIJZzC1TCCdc4qz9LnlSUUlQp4a8
         clWw==
X-Forwarded-Encrypted: i=1; AJvYcCWyTeuiAAtupPxQvft7soo4GP4HG4cudO47tVgEb8PqmAfZlmJYAPFBf3jkVlzmrGyoPW9AbuGklG/YfbAebxG5mbWObyOhGigzhuAEGdN0XRmSbqTE0SIbJJMTEZoj7kOcoIOHDQiKJG5pVgBoCw==
X-Gm-Message-State: AOJu0Ywp+Tq/XxmAT9zy3pIc/wiaJRGJ7R0PAr/BClegpb6LZ1xSLzaI
	Degq28ISRogQ4Pd5KHoCj9Vr864YOnrihcZxL5JrmgX/OBtR0E0Cc34Zrd1TWZ5xKEfl2ewRilx
	EEO6lufGuEmzxgiaqVaDPG2py+vQ=
X-Google-Smtp-Source: AGHT+IF6atLDPCwVfGWCELFiOjqrj/abs9HEFzhYVfGZMvo+MFpsR7nkmr/rybEiy9hQphN9sndDMRc9gDUIZURw/Cc=
X-Received: by 2002:a17:90a:f483:b0:2c9:8105:483 with SMTP id
 98e67ed59e1d1-2d3dfc6ada6mr1307221a91.14.1723761891499; Thu, 15 Aug 2024
 15:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814141942.2513194-1-kan.liang@linux.intel.com>
In-Reply-To: <20240814141942.2513194-1-kan.liang@linux.intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 15 Aug 2024 15:44:40 -0700
Message-ID: <CAM9d7ciPg_1DJ+gJxqU2O0nwX_L9-2+K+NkObq64e12_6vDA_g@mail.gmail.com>
Subject: Re: [PATCH] perf report: Support --total-cycles --group in the tui mode
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org, 
	mingo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kan,

On Wed, Aug 14, 2024 at 7:19=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> With the --total-cycles, the --group is only supported in the stdio
> mode, but not supported in the tui mode. The output is inconsistent
> with different modes.
>
> if symbol_conf.event_group is applied, always output the event group
> information together in tui mode as well.
>
> $perf record -e "{cycles,instructions}",cache-misses -b sleep 1
> $perf report --total-cycles --group --tui
>
> Before the patch,
>
> Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                 =
        [Pro
>           6.45%            2.0K        0.57%         667    [dl-cacheinfo=
.h:164 -> dl
>           5.62%            1.7K        0.74%         871            [dl-c=
ache.c:230 -
>           5.21%            1.6K        1.37%        1.6K          [setup-=
vdso.h:37 ->
>           4.92%            1.5K        0.09%         109            [dl-c=
ache.c:367 -
>
> Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                 =
        [Pro
>           5.62%            1.7K        2.76%         871            [dl-c=
ache.c:230 -
>           4.92%            1.5K        0.35%         109            [dl-c=
ache.c:367 -
>           1.12%             346        0.55%         173
>           0.87%             270        0.43%         135                 =
   [rtld.c:5
>           0.64%             197        0.03%           8      [dl-tunable=
s.c:305 -> d
>           0.60%             185        0.01%           3      [dl-tunable=
s.c:305 -> d
>
> Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                 =
        [Pro
>           5.90%            1.8K        1.28%        1.8K                 =
 [strtod.c:8
>           5.70%            1.8K        1.24%        1.8K            [strt=
od_l.c:681 -
>           5.68%            1.8K        1.24%        1.8K            [strt=
od_l.c:508 -
>           5.48%            1.7K        1.19%        1.7K          [strtod=
_l.c:1175 ->
>           5.21%            1.6K        1.13%        1.6K          [setup-=
vdso.h:37 ->
>
> With the patch,
>
> Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                 =
        [Pro
>           6.45%            2.0K        0.57%         667    [dl-cacheinfo=
.h:164 -> dl
>           5.62%            1.7K        0.74%         871            [dl-c=
ache.c:230 -
>           5.21%            1.6K        1.37%        1.6K          [setup-=
vdso.h:37 ->
>           4.92%            1.5K        0.09%         109            [dl-c=
ache.c:367 -

Hmm.. it seems the output just removed the second one.
I guess it should combine the first and second output somehow.

Thanks,
Namhyung

>
> Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                 =
        [Pro
>           5.90%            1.8K        1.28%        1.8K                 =
 [strtod.c:8
>           5.70%            1.8K        1.24%        1.8K            [strt=
od_l.c:681 -
>           5.68%            1.8K        1.24%        1.8K            [strt=
od_l.c:508 -
>           5.48%            1.7K        1.19%        1.7K          [strtod=
_l.c:1175 ->
>           5.21%            1.6K        1.13%        1.6K          [setup-=
vdso.h:37 ->
>
> Fixes: 7fa46cbf20d3 ("perf report: Sort by sampled cycles percent per blo=
ck for tui")
> Closes: https://lore.kernel.org/lkml/ZrupfUSZwem-hCZm@x1/
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/builtin-report.c    |  6 +++++-
>  tools/perf/ui/browsers/hists.c | 12 ++++++++++--
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 1643113616f4..574342fb7269 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -541,7 +541,11 @@ static int evlist__tui_block_hists_browse(struct evl=
ist *evlist, struct report *
>         int i =3D 0, ret;
>
>         evlist__for_each_entry(evlist, pos) {
> -               ret =3D report__browse_block_hists(&rep->block_reports[i+=
+].hist,
> +               i++;
> +               if (symbol_conf.event_group && !evsel__is_group_leader(po=
s))
> +                       continue;
> +
> +               ret =3D report__browse_block_hists(&rep->block_reports[i =
- 1].hist,
>                                                  rep->min_percent, pos,
>                                                  &rep->session->header.en=
v);
>                 if (ret !=3D 0)
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index 49ba82bf3391..22af1a6e29d6 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -3665,11 +3665,19 @@ single_entry: {
>  static int block_hists_browser__title(struct hist_browser *browser, char=
 *bf,
>                                       size_t size)
>  {
> -       struct hists *hists =3D evsel__hists(browser->block_evsel);
> -       const char *evname =3D evsel__name(browser->block_evsel);
> +       struct evsel *evsel =3D browser->block_evsel;
> +       struct hists *hists =3D evsel__hists(evsel);
>         unsigned long nr_samples =3D hists->stats.nr_samples;
> +       const char *evname;
> +       char buf[512];
>         int ret;
>
> +       if (evsel__is_group_event(evsel)) {
> +               evsel__group_desc(evsel, buf, sizeof(buf));
> +               evname =3D buf;
> +       } else
> +               evname =3D evsel__name(evsel);
> +
>         ret =3D scnprintf(bf, size, "# Samples: %lu", nr_samples);
>         if (evname)
>                 scnprintf(bf + ret, size -  ret, " of event '%s'", evname=
);
> --
> 2.38.1
>
