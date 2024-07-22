Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCAB54657
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665021; cv=none; b=J5CO8PDAaV6bqqXTq/ZDxgpPpP+iS1cBd49csyR0Swx/+ftiY9DyyhTT3oVdXZg8srHp5MT3WwViuHNN3s+5DCf2cjiv5b7ynr0KWYOjwVZYu6xxqsjPEMUXlmy++3p3ytutqpDo3jmleedKfHTecS89/z3im3+JcGExMTg058E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665021; c=relaxed/simple;
	bh=6Gsk81WeH6DvE4tX61P/Mt/obOnYGk14eTFU+HVGNKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0isnyRVihBO/i/uPUMVygxUuB4vrBWUNUHsaaWWonjMeWIEQVH678+Su8C1WAeKe9rb/XdP48GWRmxaOLs549gonLiqWYRbqMf7uH7BKSNeQew89uK6HJeK0DPA3G/FnX3wByy2CImDJ7/e/A1X/epsnTBsOOIGAXlJlsruC4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hk2guBwH; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hk2guBwH"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-398b599593eso413555ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 09:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721665018; x=1722269818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdGV+l8J2hM7fv/FlUa7Wq6WlLTG8Ht4/K+xLQQTCkg=;
        b=Hk2guBwHR4XlJFudCuvX8SRto4F+wjx0dvVkoxACA5iBbLc6RZL3UQt2/k+jypSWpr
         7R0Cp/XogiN5Tvp8OdMBoI8HWnPewhqpTMrOOEojiaI557INNFrK8p+iGsS0QHNS4ijD
         glHrFbyuJt81t8BcHlluw+bMjnb1ycslP7uO5VWQELBdKtF744j0G87IOZ8qGl+XKRuD
         AZ+XK35MWL0ppVRc6aewKGuq4W+15E8RrVqPA/SyNjKGYFotTmGLuRCopQSey2hKwywc
         ZlUDmD1f17Kfcvb6USsmniY4zq5L1KinZwMtKaYMZV7RqxcYvzYIpFgfJxtQNnww6hop
         D1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721665018; x=1722269818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdGV+l8J2hM7fv/FlUa7Wq6WlLTG8Ht4/K+xLQQTCkg=;
        b=doCxdA7/6V8lrcFR52u3u7fOUM+ZUV/zDsmE3ebh7Ms2La8nWA6ITcB8Whl5pqn6n8
         u0NR30s+YIGHueSQiLeKOsgWsRDK240s3EQVM8BE3CPhEJDNmJa504/8T0CDVeqSee0N
         N53Zzd8pLrtmqKYUDFR2GwBSGL2xtBUfXNh5sk8VG9pi1Khuz86bXheNkhRf38gLwc7n
         DOpF6k8Oe9/GjfWcECcJ8qflXSWuHT4R6kgbUpehdeZEdiPR10xSZNcG31xBHtm261Fw
         vt4GYyof5OyvlwgrOhynqiSzKcQbOAGdKvLZUrhC0yle1oHIAYmtYg3l96lAL4xHga5j
         Ct2A==
X-Forwarded-Encrypted: i=1; AJvYcCVKw5VzIxstbAFpO2vrCIkuxQjK8Zclqyj/cV+pwHF3X/MgatxHC09oQ75L5oMBAAYLL3xfNdLeuVyIkUI45ZvtZhuzNPiaSljNVg3D4+RtwQ==
X-Gm-Message-State: AOJu0YwcEx5nD6ty4KVYUBnSn6EqZ0nKTQ+byP3tx+Q5j+GUT3yZ8Zj+
	h3gQf+KH7SyNE7OfWI/9GJVj+GKxiepzQtAwYLTgK1ZB2jiZgwQw8VP0adC6KHDK1ChNusDJjvx
	gGw7KLYLp1r6ufkrLOUIhJgbK0kHCXRGloEhe
X-Google-Smtp-Source: AGHT+IHxK94eUMozfDDRBAENF9nSqWstRggS+pONhrh2+8iovrfLH3WBQq+S1YOxXE60n14f2c/4EOjXG42L3Vu3RtY=
X-Received: by 2002:a05:6e02:148e:b0:376:257b:a110 with SMTP id
 e9e14a558f8ab-39934707d23mr5712405ab.10.1721665017859; Mon, 22 Jul 2024
 09:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240721202113.380750-1-leo.yan@arm.com> <20240721202113.380750-2-leo.yan@arm.com>
In-Reply-To: <20240721202113.380750-2-leo.yan@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Jul 2024 09:16:46 -0700
Message-ID: <CAP-5=fXr62AWU_g=Lymf=8wO-9FF-eEEsoBEYHdqxxdD0qgbnQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] perf pmu: Directly use evsel's PMU pointer
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 21, 2024 at 1:21=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
>
> Rather than iterating the whole PMU list for finding the associated PMU
> device for an evsel, this commit optimizes to directly use evsel's 'pmu'
> pointer for accessing PMU device.

The code doesn't do that:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmus.c?h=3Dperf-tools-next#n698
```
struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
{
       struct perf_pmu *pmu =3D evsel->pmu;

       if (!pmu) {
               pmu =3D perf_pmus__find_by_type(evsel->core.attr.type);
               ((struct evsel *)evsel)->pmu =3D pmu;
       }
       return pmu;
}
```
That is, if the evsel->pmu is not NULL then just return it, otherwise
find the pmu using the type from the attribute. Any linear such should
happen at most once unless the pmu is NULL from event parsing or
perf_pmus__find_by_type.  The PMU may be NULL for legacy events and if
sysfs isn't mounted. If you are encountering that then maybe we need a
flag to say don't find the PMU for this evsel as it is known NULL.

Thanks,
Ian

> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 986166bc7c78..798cd5a2ebc4 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1199,7 +1199,7 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu=
 *pmu)
>
>  bool evsel__is_aux_event(const struct evsel *evsel)
>  {
> -       struct perf_pmu *pmu =3D evsel__find_pmu(evsel);
> +       struct perf_pmu *pmu =3D evsel->pmu;
>
>         return pmu && pmu->auxtrace;
>  }
> --
> 2.34.1
>
