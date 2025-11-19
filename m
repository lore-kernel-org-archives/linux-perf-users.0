Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC262302166
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572012; cv=none; b=ecEFV5H2DLrc88czWaLQle/JNN8aa7xhiSpw30jMU1RBHJ80sF1iHwnK8olNYgjFzeTlCwrai+yuama1Huz6lzDcwkSH+/lnZrmKzAcu87dHkmG+4WkwNdCx9cix4Z/Xsze7ksXYyG2dl1camzBrFKiE+uk1phUlDy4lUOIGaD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572012; c=relaxed/simple;
	bh=ox/9vhvkrZ2YFHQ5ruc0dQSAeJdssTHSZ31fjIu4Xcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/1l9qLhWH7o9+H+s2FmWKfh4XyzElM/CvLiXX10pxUVdxUpYAAnXxLeBBKpOhKrGVa393CkAPqqSEIf78pYTMaTYtBRzRwVQiHkB3ghf3B5bsPcXJd8heQ2Gr0BK2sOM/GiuD8PAkshScqC2HiLRW6Spfhjxsi84HNcYQ0RwgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FHSrG6vj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FHSrG6vj"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29852dafa7dso226565ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 09:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763572010; x=1764176810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yb4agBV1NIebVk5UoYPPgBtf64ZcfvgpzIo5DZxYRek=;
        b=FHSrG6vjUXOKueDytJnxSVMPhz3GMOGCO7Wm670aXwEGNFNwiOb9tUwEaAc/AmQV+8
         VnH1e1JM31MEwg96mwTYD9rTjq26H5hIT2EqZQjVVEBWJ9fPpshp/DKleKunwGuccsfC
         PlBacXUYt1Uu0FtynNBSlxMkjYhqSVZld6n1opqfMw4yaRGcC1S/+j5A9E02htU6ngdk
         CFAfmzYxw4tWsG3W5b8qxoe90ZtxuVdtjYQODlpy47w1bMCFMcy3aKr0yXiAR4k1WXuJ
         lCCC3FUfvxTXFjffMrRrr6ZOIItrKl65lLW64V3bDU/eA2UE0zzIiyCP45GN9C+2F3GZ
         c4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763572010; x=1764176810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yb4agBV1NIebVk5UoYPPgBtf64ZcfvgpzIo5DZxYRek=;
        b=QdfwpxdUjypQleoGv2jyM6INX2TiqH5YblICbjI8WoCHESSFVofxcnQT5fvh+NDI/K
         k99mfrE5N4UTwdil+xIsJ7wHBFeGxGkCeCiDxgYz07tx/sjC4EooPXczsdu7/7Fze3rE
         XKUVcjxOnUvgjQbRda2NpReI47NyV3HeceFkvnQ5uq+TLGdriNQM3fdtKVIu4l7xLNUV
         2F3bXWKCrWolrxayxTjskngzRywD1dvHtkjCFd7LmMQ7Sp3Su3eKNyrzTOrHgf/5RU+r
         IN5n0fPOFen9GFIb40KI9p3bVpmHOLTtBphDycu75IJ/kCqCCIPQnpY8sOSTKlM45dxE
         2YAw==
X-Forwarded-Encrypted: i=1; AJvYcCVvqhqPPRURyjem4sYeeiebvSK3sksWHyMZtSCtvMiqfyjrNxysY4sbEqcb4Yk73cK/XQNZRsHPwZQOGb2TgkDB@vger.kernel.org
X-Gm-Message-State: AOJu0YzGnjKSAkK0Y2jLKzEp9kFT2mlM3Z5DHJ9ir0WeHychrOcr34lW
	PNhCefp1j9+LcILPChdvB/ZadYwaQONtvDgkkx1SUqoeyORYVbmLlCQzSkOjLPgUKK0OEIYcsB6
	ph79mzvADF8CoZTS4AXzmMHAFJQMlnn6VgPml8099
X-Gm-Gg: ASbGnctEZYN3YWmzLhqpst0Cx6HqBgwZkqgosuufegmRsT4dOcOLr4G5B0MMHvJMi80
	nMgHBW75suEn0oOBT2Mdq1QbW+ZvBvglJgvOuQjfOMP8WxUS/yJuchIEFChkh0wAlwfBmT4QKZz
	N5cnyb/EG9W7ePvNKXgXzRweHJv3JA6ltxlQpELZzMhRKHD2a/H3OD0oib0xXPhfHHnlHzW+sMu
	hdlHumA4FmGSa/dv6bFGFq5U59XfoWnBpecKo/75SCtLYuR/6yT00Y6N+FjpqVrfmH4xE8cl14H
	T5mQVCd3UQzZmU8m8NWIkNWtPQ==
X-Google-Smtp-Source: AGHT+IFtsjqgpzNXFDzfsquynuqMPN2tHdkQJCkKFdwf9l2tBGEYNOmEfbFv3qdaAf1E21kK8/Sptigpdb0cYU38x/I=
X-Received: by 2002:a17:902:c412:b0:295:3f35:a315 with SMTP id
 d9443c01a7336-29a05fa3a9emr3609065ad.5.1763572009638; Wed, 19 Nov 2025
 09:06:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119104751.51960-1-tmricht@linux.ibm.com>
In-Reply-To: <20251119104751.51960-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Nov 2025 09:06:38 -0800
X-Gm-Features: AWmQ_bnlTtiRRA4EUoZBXiBiTyKKT0KOdZndooc_2VtWxVEHzc1PetaKx5nqjrU
Message-ID: <CAP-5=fUcNNcuFEyreGa0dpqfJzZtkDdp4yJXgZR0+LN_Mj5RaQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] perf tests: Handle s390 metrics in perf all
 metrics test
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 2:48=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> This test case fails on s390 because some counters metrics
> are not available and the metric defined on them fail.
> Add s390x specific list of metrics to be skipped.
>
> Add an extra line to display which metric has been skipped.
> It is shown with the verbose option turned on.
>
> Also return "Ok" instead of "Skipped" when no errors
> have been detected, but some metric have been skipped.
> The seems more logical otherwise "Skipped" means all
> metric tests have been skipped instead of just a few.
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Thanks Thomas, I believe the intent with these metrics is they don't
fail but report unsupported for their counters. There's been some
discussion here:
https://lore.kernel.org/lkml/aRi9xnwdLh3Dir9f@google.com/
with Namhyung and James pointing out the issue on AMD and ARM, and me
being confused we Intel isn't failing similarly for events like itlb
accesses that Intel doesn't support. I'll try to find time to dig into
the issue.

Thanks,
Ian

> ---
>  tools/perf/tests/shell/stat_all_metrics.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/test=
s/shell/stat_all_metrics.sh
> index a7edf01b3943..b86b36a49228 100755
> --- a/tools/perf/tests/shell/stat_all_metrics.sh
> +++ b/tools/perf/tests/shell/stat_all_metrics.sh
> @@ -7,6 +7,10 @@ ParanoidAndNotRoot()
>    [ "$(id -u)" !=3D 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid=
)" -gt $1 ]
>  }
>
> +# Ignore metric which are not supported on s390x
> +[ "$(uname -m)" =3D "s390x" ] && ignore=3D"|branch_miss_rate|l1d_miss_ra=
te|llc_miss_rate|\
> +               dtlb_miss_rate|itlb_miss_rate|l1i_miss_rate|l1_prefetch_m=
iss_rate"
> +
>  test_prog=3D"sleep 0.01"
>  system_wide_flag=3D"-a"
>  if ParanoidAndNotRoot 0
> @@ -27,9 +31,10 @@ for m in $(perf list --raw-dump metrics); do
>    fi
>    if [[ "$result" =3D~ "Cannot resolve IDs for" || "$result" =3D~ "No su=
pported events found" ]]
>    then
> -    if [[ "$m" =3D=3D @(l1_prefetch_miss_rate|stalled_cycles_per_instruc=
tion) ]]
> +    if [[ "$m" =3D=3D @(l1_prefetch_miss_rate|stalled_cycles_per_instruc=
tion$ignore) ]]
>      then
>        # Default metrics that may use unsupported events.
> +      echo "Skipped metric $m"
>        continue
>      fi
>      echo "Metric contains missing events"
> @@ -106,4 +111,5 @@ for m in $(perf list --raw-dump metrics); do
>    err=3D1
>  done
>
> +[ "$err" -eq 2 ] && err=3D0
>  exit "$err"
> --
> 2.51.1
>
