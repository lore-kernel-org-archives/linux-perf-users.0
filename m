Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F073CF02E
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168355; cv=pass; b=O97AfPoqkK8SJT1AhxA5j/j5O6KX6Z6pBvc35K2IqjeNUfhuSa8WWERfLPkb+C7ex9a285hbCkT2t2V15AALJPSxJVq5rxww6SQx+GIdMvOmdfCA+cJ8IRLLD5KrN2pBjW50hwrApN82NSYQHg583yj2s4C80Xp+ohrrxnkG+j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168355; c=relaxed/simple;
	bh=r6JO2RTY6bLBWVscng5EnRE+P1RZ0WHC86otoDn3kqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYfMjSSbOrMX6EA8TjlBmQvt/z2ECI1Nq7EBK1sEqjcPYZ/D4tnm85yF1IdGP5UkD13qugD4aZXYMVlbgN5JMr6hXo4eAn1gIbgl2zCCmdASJYpMxm90Ms3JrejVa+HZqzquICOIbVY9v6+8//R79ltd3ROr/uK3PYbj5s5OryU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IYj75ccK; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IYj75ccK"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso92275ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 07 May 2026 08:39:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778168353; cv=none;
        d=google.com; s=arc-20240605;
        b=Eh0eHZMbeBK2FgU45rFK0hgiKV5XMU8+C7cqU5lo6GpxApttqEX8wiFCLpssomyPDT
         g2XVI/MJMYWCUgTnR3FbhPiHs1QPdXEWonaWr2vqOKOYtcDkaGzAg9U03ZrzU8oNYsBs
         00/OBRVfhZxnxlYgYYsH0v83pwTAzbdP/WDsrJsBYzmWLhz4JctA5mgJem49jkc7CVBW
         +cMuUpumAljgtFSElq+YX8eTJUQcVFdhvltEhsLhB14I4JCxCo1vP5iSF62VGUu8jBpm
         o62qK3Q9TGDpgWvJtlJqHtaGOYY8KFjqz9JTc2bZua9WCXN4ZI3VIkMTfHM03MSw/j9A
         SQ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gTYDekqrRUKGwMcBjdQn1nmLxpQn+Cw3upH2qbMNVlQ=;
        fh=SlNGZqA3kgefCizOB/0DNcqG2z7DJcgTW13UGcoifEw=;
        b=e1TQy9x2x0LXbleuFEpCxbwxr1pyWK2WviijNx8kvHlqnnEHMsopm8bt57BIapPKfl
         QDjElx7dphFUAg7n78kZGv63U7jI2dhy+HFIied6+NoZzcVIqV9M4XYCarEk1cKSa2zc
         /ixp7LaagXkpzjjwnTw698jpXz3FZOmIDyVTbjyDr9rp2ydruggLL5S3D0zIbEN8UsCR
         g8VbN9i5NfZ25pZjWBeSySf5UBKf/ZOHi2bb7lAsU+0WKXRokV0sWX1dj+uJgn9jPk3w
         a3VTGgc2E55vzohXfVeDCdfUfTq7mL3a2KzoJCpcTHV69uJ4Y7kEoYwr1CGfjWNxblYd
         96vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778168353; x=1778773153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTYDekqrRUKGwMcBjdQn1nmLxpQn+Cw3upH2qbMNVlQ=;
        b=IYj75ccKslFLpet+jL4o/SQbTkyl593Y8Y7b6xB+30Bb1a86N6GIfyjR9TviO9bq+Y
         ZZJHPpCgpSfcSG9QMTBuYY/PNUmaCRF+artTPttUclSE3xl/ieINYiUeEkkgu7wyfrMu
         erDukY75BfU7r9jjqFNAQXgsvEl1VqHyyJwHJwgmIiGdLOAqXRgnXyd1dPg2ksz9X64+
         Q4AvuU4Q7J35iu+Nkb8DiRYTpUHvDWcGLAUD9v0YkDh0mE3pdaCPbMNNgz0ZpSa31bM9
         lfWUT0aypRi9zW9XurLjSDxuyBG6keucRzgwLtFczlVwUDNEGsI9K9CYk2ETDx87ct24
         dIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778168353; x=1778773153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gTYDekqrRUKGwMcBjdQn1nmLxpQn+Cw3upH2qbMNVlQ=;
        b=UA/+Vl1/M+5M2OaCDHnZRZkYyPc2aMfZ33Uuhn9KIAqo/dpNC3Z39Xu9CnhgxuMUD3
         K0YKCrDpCaNHIzKkSluul7Zsv4/29vsVtkovG+VdoZP99yT85cqHBj4w8w6KU8otBpey
         CUt0zl7refsvdZ+B3gYsKRH0o3+HESUUBf8dx+KovP1A44DwYJzXod2PSGXJqziecceB
         Bi3qCKfnuRjhuqjug2zObOdDjoXheVJuHYCw/DIv4oZX5aNiKI1fdN9PO2yKoEsEVNlT
         EzNxKxQX+qe36i4L1aBKu5SDF7OpSYna2QXJcA1dtoz+OgTyE+3Z9WN1urpzVK61Xxhd
         fARw==
X-Forwarded-Encrypted: i=1; AFNElJ+JLLYzGRCC6QQaXPyZ9gr0CNX7GV8rjKI0uPGCecFbCbMnZ/ApeiQahebS58DKTFPwvBlc4xtrcXpDp22/roPn@vger.kernel.org
X-Gm-Message-State: AOJu0YymNWM1Ng9a5UCQNP/inqaqp0ddH+LJ1X/4pSy+wC8Ytbfr2EVp
	wdU22dXPvYaonBuuSO00s75NgL6L7w8cM4pqXJcM/U2TeIpEFlIZFh6VSsc9VEiA0KXKkAQSFb+
	S4PtBAmqvgCkSXlZWYMMVHVYw2I3XTyIW6oHiIi0SgYFhmbHrHLbe+NAx
X-Gm-Gg: AeBDievWv5mgq0nenBE+Mcwj35KoI3uBA+g8tQx+bRZcWA2KxzB45kOjBoA03gy4ucl
	OcBW1DImOlAf7Bq/RT3yuIwdgsMaQRbk1rrNPhL6L1DsynJKLdu6vPuHlyk1AWGg8uXB2t93l0x
	rytmLZ9Fhuy203Hp8xUClq3qZTBUfJtl16rh7XsqLVz2O/v7ibRBOMz1MekNyNL3yZa441KjOMN
	LG3Qp1WWVJXHsryr7p+L3sSQZeasWF2Wf8/2qE7hRKDLVqDV/oXwjJtV7kT+6V3Jsw5AIIzh9ix
	7cH9v1xNaTpMEBheu6MzdTb/ajosNNvXA6wOiaXVUedUWOtBjPAJnF1KVwo=
X-Received: by 2002:a17:903:1b63:b0:2a7:6c4e:5914 with SMTP id
 d9443c01a7336-2bab602610emr4140185ad.6.1778168352129; Thu, 07 May 2026
 08:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507063737.3542950-1-wangyushan12@huawei.com> <20260507063737.3542950-5-wangyushan12@huawei.com>
In-Reply-To: <20260507063737.3542950-5-wangyushan12@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 7 May 2026 08:39:01 -0700
X-Gm-Features: AVHnY4JkF3wXUtyPgEEQCuM_Et67c3otP3W1Tw-K0ZP-yh5Rc7qin9Nk03qhBV8
Message-ID: <CAP-5=fUVf-6Xcd+xQBm9FbwbWsUff0PYuH54mrBkLeVyU2cj8Q@mail.gmail.com>
Subject: Re: [RFT PATCH v2 4/7] perf-x86: iostat: Change iostat_prefix() to static
To: Yushan Wang <wangyushan12@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@arm.com, 
	john.g.garry@oracle.com, will@kernel.org, mike.leach@arm.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, jic23@kernel.org, leo.yan@linux.dev, 
	robin.murphy@arm.com, linuxarm@huawei.com, hejunhao3@huawei.com, 
	prime.zeng@hisilicon.com, fanghao11@huawei.com, wangzhou1@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 11:37=E2=80=AFPM Yushan Wang <wangyushan12@huawei.co=
m> wrote:
>
> Change iostat_prefix() to static function, since it is not used outside.
>
> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/util/iostat.c     |  7 ------
>  tools/perf/util/iostat.h     |  2 --
>  tools/perf/util/x86-iostat.c | 44 ++++++++++++++++++------------------
>  3 files changed, 22 insertions(+), 31 deletions(-)
>
> diff --git a/tools/perf/util/iostat.c b/tools/perf/util/iostat.c
> index b770bd473af7..a68ab100780d 100644
> --- a/tools/perf/util/iostat.c
> +++ b/tools/perf/util/iostat.c
> @@ -37,13 +37,6 @@ __weak void iostat_print_metric(struct perf_stat_confi=
g *config __maybe_unused,
>  {
>  }
>
> -__weak void iostat_prefix(struct evlist *evlist __maybe_unused,
> -                         struct perf_stat_config *config __maybe_unused,
> -                         char *prefix __maybe_unused,
> -                         struct timespec *ts __maybe_unused)
> -{
> -}
> -
>  __weak void iostat_print_counters(struct evlist *evlist __maybe_unused,
>                                   struct perf_stat_config *config __maybe=
_unused,
>                                   struct timespec *ts __maybe_unused,

This change doesn't remove the weak symbols, but they should go. We
should use the ELF machine to determine which architecture version to
use.

Thanks,
Ian

> diff --git a/tools/perf/util/iostat.h b/tools/perf/util/iostat.h
> index a4e7299c5c2f..820930a096d9 100644
> --- a/tools/perf/util/iostat.h
> +++ b/tools/perf/util/iostat.h
> @@ -35,8 +35,6 @@ int iostat_parse(const struct option *opt, const char *=
str,
>                  int unset __maybe_unused);
>  void iostat_list(struct evlist *evlist, struct perf_stat_config *config)=
;
>  void iostat_release(struct evlist *evlist);
> -void iostat_prefix(struct evlist *evlist, struct perf_stat_config *confi=
g,
> -                  char *prefix, struct timespec *ts);
>  void iostat_print_header_prefix(struct perf_stat_config *config);
>  void iostat_print_metric(struct perf_stat_config *config, struct evsel *=
evsel,
>                          struct perf_stat_output_ctx *out);
> diff --git a/tools/perf/util/x86-iostat.c b/tools/perf/util/x86-iostat.c
> index 7442a2cd87ed..f8d4c9718594 100644
> --- a/tools/perf/util/x86-iostat.c
> +++ b/tools/perf/util/x86-iostat.c
> @@ -332,6 +332,28 @@ static int iostat_event_group(struct evlist *evl,
>         return ret;
>  }
>
> +static void iostat_prefix(struct evlist *evlist,
> +                         struct perf_stat_config *config,
> +                         char *prefix, struct timespec *ts)
> +{
> +       struct iio_root_port *rp =3D evlist->selected->priv;
> +
> +       if (rp) {
> +               /*
> +                * TODO: This is the incorrect format in JSON mode.
> +                *       See prepare_timestamp()
> +                */
> +               if (ts)
> +                       sprintf(prefix, "%6lu.%09lu%s%04x:%02x%s",
> +                               ts->tv_sec, ts->tv_nsec,
> +                               config->csv_sep, rp->domain, rp->bus,
> +                               config->csv_sep);
> +               else
> +                       sprintf(prefix, "%04x:%02x%s", rp->domain, rp->bu=
s,
> +                               config->csv_sep);
> +       }
> +}
> +
>  int iostat_prepare(struct evlist *evlist, struct perf_stat_config *confi=
g)
>  {
>         if (evlist->core.nr_entries > 0) {
> @@ -396,28 +418,6 @@ void iostat_release(struct evlist *evlist)
>         }
>  }
>
> -void iostat_prefix(struct evlist *evlist,
> -                  struct perf_stat_config *config,
> -                  char *prefix, struct timespec *ts)
> -{
> -       struct iio_root_port *rp =3D evlist->selected->priv;
> -
> -       if (rp) {
> -               /*
> -                * TODO: This is the incorrect format in JSON mode.
> -                *       See prepare_timestamp()
> -                */
> -               if (ts)
> -                       sprintf(prefix, "%6lu.%09lu%s%04x:%02x%s",
> -                               ts->tv_sec, ts->tv_nsec,
> -                               config->csv_sep, rp->domain, rp->bus,
> -                               config->csv_sep);
> -               else
> -                       sprintf(prefix, "%04x:%02x%s", rp->domain, rp->bu=
s,
> -                               config->csv_sep);
> -       }
> -}
> -
>  void iostat_print_header_prefix(struct perf_stat_config *config)
>  {
>         if (config->csv_output)
> --
> 2.33.0
>
