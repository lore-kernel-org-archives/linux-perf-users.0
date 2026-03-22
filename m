Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDAD366570
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Mar 2026 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774196865; cv=pass; b=TM79j4q+ejhpJIe7Y96rNasP/6+/S+8DMUQjmU3LRfSf0UEbwN8+t1ZpRBVLkrct0y/LwwDQXHhfaQdA7265rHj/WbDQQfpCpS/YPeI7fhO2Hmbrb2vVvmV0lSlteFBTAj+zVAVMc+Hh3Ds5ElWNjqYGQZy/ekgcH5NAH3uuS4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774196865; c=relaxed/simple;
	bh=qxvQyNsEyKU6jyVHzZb2Sp8JInBatrOkjq7R5m04qvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXVS7BKt/r224kXXEY+iV0OkdHAJ+rbJVCBRWk1m+uMIZg1TvI8VseYVGsZn6LOltb6I/S8xTDucWY7YAaG85VxJk3ye1luImeOJIMyHXfvZOJhdO4K6s9KqWhPK5qVnEdu+vvgvkPE1mxaA6c7U85J+GYeyLFXDpxVbToBZynw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J/4jtruW; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J/4jtruW"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so114875ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Mar 2026 09:27:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774196863; cv=none;
        d=google.com; s=arc-20240605;
        b=cXZCwxrgbPkee5hCiNqZ9b0IJlELr0lrtBUdXyY+3fy7aV+AKXVhiVMHWCGfxdgGn6
         +5ChL0QKaW0Tw933UJzHqiuXifBiAXwUSnj64kYajbs3LqKZEfTEifs4PLhCrWGvtwwH
         cxGoJpnBS7phxpK8O6uh744ZtWosRltsziM+y7YiJvp6QSnr1D/SnjaL7/39MpkeVQKZ
         rWZkrFSc1kziLbHPSKdoQkJA+UWRyRdvtoidnRUTh7SDvuRiEsqLw3OWXw4zveuprgCy
         ZuiPCWMQcJGvxXaQGafissVp6m3MvCs73oMylLNwHafA47ZTSN2qHK+/CR3GQpf/XdvZ
         AKug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ox0aZ7hqFXlQ7nQJdVJurmhOEpPvw9mD6+zWBsG+fDc=;
        fh=sdz0HkRnpck/xK93NoUYGP4ItJDr7C8m1qHI5Vg/ri0=;
        b=TtqE0mFkvQnlwT1XYr9PPlrukMEQEtYrCqtkBtOEKSc5aq02nfamVrvIeSczjmv9tH
         omVod6naDxMlprWeTXvRnHbXLG2y4+D48ewAjlrPJrEA/gReGQ43HbV3QCUjQHXWpn9n
         e3QrJmhWZK0aiHebFdJgg7eefESpBIhnr4Y4H/mOXMDBa1TQCgvRLpxOVA5Kns81dpB3
         Ii8rd45kLoFs50yOSqKJYTlrrz8Zl0W93MlUfkmzFnsJXccUsbcgVewxJ+imJ8PUkH2M
         WYjE+ALpX1VjYnnr6omHpkkzOk3RhVk+vYbZ7Fw90xw2k+LKpwgHjqnHA8AlTwUS/7UD
         T4FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774196863; x=1774801663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ox0aZ7hqFXlQ7nQJdVJurmhOEpPvw9mD6+zWBsG+fDc=;
        b=J/4jtruWUQ6hcuFrWEW8juNY52+/S4TNE7GCgfnP1RLudc3JHBDTgstYlNkUKaWG5+
         tzeszJRWTgmUKNyDjRFeRnb2LDVxlYtuAu1wfqucDERdMNbR2PbvBsPYDk0xuiLYHDP9
         Bq6EXY/hyssNb+onutnW/yJZ7g44S2BLa3kMyvo0lUBRoPEsTmNTLnUcmIiF6RJBByq/
         KXUCBaAfI/8QNK+F6J715ImsnJaLhlewo8718bmFNwyOUkjAWcV1jK3NGwnNULanyWLY
         nthIsrKv13t/EZZsolJjlEf9sin2U6N/ZeHHUcwfE7qcwmX/XcCxuSPEs/QwBLJvqQVZ
         D+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774196863; x=1774801663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ox0aZ7hqFXlQ7nQJdVJurmhOEpPvw9mD6+zWBsG+fDc=;
        b=JiqpQ1jrnwU+4Yk7fL/jJyoTLjViYsICgAg46DHH6mZLm1mSsh1AWUmT9DBAdFfZxM
         C9aGCTUQGz6hs98IEYP4ESegmfdR/lIwZFRW4k6cufXPGdL1+Zhjju4nZoe1cEi9EjLs
         JEtWM3S9iTGDKQJM+77ebGBZ5W282k1JOthOEVxZKmSqfvZkChi5SElhnL4Im6lRiC5C
         w22B88AT1epLCeBR8el7taGEOOlDcZEP1BTAHhvVU5dW5GeQZkRNuGSiRg9pZuO43PbH
         5xoLaDiYEgf3FK5q6lG76erknXoBzNVnXu1GYHT8sYtzdpMTaPE6B/lAiAbIESDzgLxA
         lraA==
X-Gm-Message-State: AOJu0Yxj9jN80HDFOmXEkQyQ/CvmhTMfaZpNMk2o/hScgpOz+q77rdx5
	bM6JQcdR0Rr5LdqCaWQ6ZKWpQNGOCK+1h6/Tq64e04kwcyIQi69PeSMfMOSuZbgGqnseQA+onyD
	uXGE8xSOuwEds2k8qlWtlljJysuYOAC/oXIuvZxLG
X-Gm-Gg: ATEYQzwBSns/DIW853CxzLkGaWgS5f+gUSeveyGD0QgnQra/yy1ZdAUMTNIY7KMkvqh
	AZyzXoQeZwYfyMTmv4ozrPhD/oCbH+whmN8mJ9ZCkxeBJELtxWdOwaqw5HxeO3LwRNmtDatAGWM
	U59K9WyK99/tm2W5DdxblLFjAKR050kzFNr9yRqJjlp7Ape84zZz9jN0PtUbHugNS/T5CDxyni6
	pwp3vnaw90MBCa0tn62nsG9hIPv5hpzPUVSHenDgX+bNtB/O5sRuU4fjgrv44D0dXKpVEPwDzqS
	6Wup9psW
X-Received: by 2002:a17:902:d2c6:b0:2ad:6f9b:7817 with SMTP id
 d9443c01a7336-2b08b46ad45mr2924285ad.22.1774196862017; Sun, 22 Mar 2026
 09:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322153155.205405-1-nigro.fra@gmail.com>
In-Reply-To: <20260322153155.205405-1-nigro.fra@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 22 Mar 2026 09:27:30 -0700
X-Gm-Features: AaiRm52x7WiSQnPDdpFYD8WFxuq_p6KayBzo0YoZsUBba2NxCGD43TPDaspkLxI
Message-ID: <CAP-5=fUWFjPEvr5B_B4yp9W-MA+MozPGF5bBwaQSc99nop8aTA@mail.gmail.com>
Subject: Re: [PATCH] perf metricgroup: Fix Default metric group lookup for
 non-Intel CPUs
To: Francesco Nigro <nigro.fra@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acme@kernel.org, kan.liang@linux.intel.com, namhyung@kernel.org, 
	peterz@infradead.org, mingo@redhat.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 8:32=E2=80=AFAM Francesco Nigro <nigro.fra@gmail.co=
m> wrote:
>
> metricgroup__has_metric_or_groups() only searches the CPU-specific
> metrics table returned by pmu_metrics_table__find(). The "Default"
> metric group (used by 'perf stat' when no events are specified) is
> defined in the common/arch-independent metrics table, not in
> CPU-specific tables.
>
> For AMD CPUs (e.g. Zen4), the CPU-specific metrics table contains
> metrics for groups like PipelineL1, l2_cache, etc., but not "Default".
> This causes bare 'perf stat <command>' to fail with "No supported
> events found" because add_default_events() never adds any events.
>
> Other code paths like metricgroup__for_each_metric() (used by
> 'perf list' and 'perf stat -M Default') correctly search both the
> CPU-specific table and the common/default table via
> pmu_metrics_table__default(), which is why 'perf stat -M Default'
> works while bare 'perf stat' does not.
>
> Fix metricgroup__has_metric_or_groups() to also search the default
> metrics table as a fallback, consistent with
> metricgroup__for_each_metric().
>
> Tested on AMD Ryzen 9 7950X (Zen4, family 25h) with kernel 6.18.13
> and perf built from 6.19.8 source.
>
> Before the fix:
>   $ perf stat true
>   Error: No supported events found.
>
> After the fix:
>   $ perf stat true
>   Performance counter stats for 'true':
>     0      context-switches        #  0.0 cs/sec
>    55      page-faults             #  ...
>     0.22 msec task-clock           #  0.0 CPUs utilized
>
> Fixes: b0a9e8f81fc4 ("perf stat,jevents: Introduce Default tags for the d=
efault mode")
> Signed-off-by: Francesco Nigro <nigro.fra@gmail.com>

Sorry for the issue. I believe this is already fixed but there are
issues getting it into Linus' tree:
https://lore.kernel.org/lkml/20260207004956.610458-1-irogers@google.com/

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index a21f2d4969c5..670b650f86fe 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1606,9 +1606,15 @@ bool metricgroup__has_metric_or_groups(const char =
*pmu, const char *metric_or_gr
>                 .metric_or_groups =3D metric_or_groups,
>         };
>
> -       return pmu_metrics_table__for_each_metric(table,
> -                                                 metricgroup__has_metric=
_or_groups_callback,
> -                                                 &data)
> +       if (pmu_metrics_table__for_each_metric(table,
> +                                              metricgroup__has_metric_or=
_groups_callback,
> +                                              &data))
> +               return true;
> +
> +       table =3D pmu_metrics_table__default();
> +       return table && pmu_metrics_table__for_each_metric(table,
> +                                                          metricgroup__h=
as_metric_or_groups_callback,
> +                                                          &data)
>                 ? true : false;
>  }
>
> --
> 2.53.0
>
