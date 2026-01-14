Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F71139E194
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409540; cv=pass; b=XbuaZG8SPaLG8sE62CBA3UtMHI0W/yOT3bo9vL/AEYEO/P7iWMRt8yycO8JVbaCnHmcho5RJ+fGmFj3valFr/emAeksCHZYrjp+Kky+gsDY3aIdKG4y6bGyLa5HF3fUBsxSLw2YvsbX+ekkmgE7wO6kwvwc7ad1V9z9DbOuc1mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409540; c=relaxed/simple;
	bh=w1nuRTUUWewJm4juziXJDNHbIpuVikZMyuk9Obdvqi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4KEchHSJGl1l/SpERsCl/zpVTpeldABPPZwL0GM1ybkIJlbQs0SUdgM7sTY7zdg8C9wXNOywE7T45T6CWe5QqDVoBYBddZx2SkQw7GMhCtJmC6crxfCKqTb3HpEkxhSv8z2XR9vdNlhPza66Qk4xHvB6D4+JypKUuD6WhooyrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jhxyapSk; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jhxyapSk"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0d06cfa93so85925ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 08:52:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768409537; cv=none;
        d=google.com; s=arc-20240605;
        b=BYEI8pxuwZ6eWGOYXgU5oRsEKgs5svYKTGC6+s3e50ZQt5fW9KcPWrvkHv+nufXnb5
         cnjL0FUpOndO35hMIivEp3QEkRCdy00eKSt0ocke2ZZxUm9tE/xmIKVG5mQb7fNn6PmL
         c0VGMRJf62fU+PtTFnJQiV/JmMB8MeN2kMitvQ60DjpGugd9T1/VpacLG9ukE8LcX+t5
         lFvVmNP2K7rjhgYwUPRLnvyu5l24eMWY2ZTwxYkqzqKO2CtdjTQ2mPw6lcWASbeqbcJd
         zoQDA5HQ2Vu2kwbzLxrN1H8BdgHXkbMitpza2Rxqa/xWUTz70uAavDMWtV1hABaMo+Am
         rTLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OI1+23JWX8FsCJMhCllis4rPC5JKUcNnLtovuqpzj+8=;
        fh=wcp0rQie+m0SGqKfFfTeVke8Yum7JVontAlQbWWjcw0=;
        b=CqHjNps5MA9rYui8L//ZJ0MMlCfxet13csXZ0gymBudpkVMzIiGIkibveKAsf0IncR
         5iNhcni0v7tuWAp7XNxpAikkV9dediK3aIuWC00TofPlqneBLqzDlcE31/mI8++PO4ww
         3KIPvbZ0dLPYBgBoVRDq+Wze8nJRKJ8mR8iEq0jw09O7d/ynRbPkw1GPJrFi3FwdCnsC
         WaJVEHieQXCPxHDe1ucfLZLK8gf23Z5DZGXVB7c3YAxhRbQfVv76/IIkqfcI9UYBhdev
         mAuKj3DgBCNlD4Q8CyeHs3d429WfRMk8p293cWqGoXwmt+rGWZHwou9GxDtxsOvcYaWH
         IsnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768409537; x=1769014337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OI1+23JWX8FsCJMhCllis4rPC5JKUcNnLtovuqpzj+8=;
        b=jhxyapSkmf0L1LEt+2TCposTIodCpFmury5JYREJcwcxoUYLPv1KdjQOYf1gnA3bJD
         GYGev72PjAH4ah0Rorn5V9EwSuBc/fZ1Z7Djlz2kPT/0ly0D/4u4SLxouAe0K5xQ6EAF
         w68d9Q+rYBa27Io/1+KCK8sP+rZQA5siZEMa3KiPCUa4DF4Hlj5JHml9HRxFHe1Z0c1/
         nwb5yxyNd4IYWNFdJTb5fVbAzISqviZVuO4geZw0EgAmGd2bBokPqoXTja3H6mUY/k7D
         Tm2nzHohiIIIVf3Aa71FU0pkP83bHVM1sziuXng3WlbCkBZ+6YK3uCSXBdbdOLSsf2z+
         cv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768409537; x=1769014337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OI1+23JWX8FsCJMhCllis4rPC5JKUcNnLtovuqpzj+8=;
        b=W+hb6OpsR1DvY2k0eQctjuE2BFqpuVEDcX4+jF8LzhFroD+qW2yO6z+mbZUDKT6Nc2
         E0c68NEQTGi7qDPVnlkUJhUESN9o6qmPW8DCl6EK9VS3uoWh84lpVGRYVZTn37MEMRad
         IeIv2s4T7og1nlMraP/WXhp0k8jdUuPVAr1Y8SMotEwmCFJBTYna+psLa/n2MHkdBROU
         8MejnZwRzwyOUibPueypyXmTdRnUzkN4pwQa4OQLIayWkUYakY6QZtEy+YxICBoai2SC
         wvx4N8VRsVP0DhIPFZVwXATSyiiZhoLIboMcGWxnmrZjy+ek2en8IM++0bl7B2WwDube
         U+oQ==
X-Forwarded-Encrypted: i=1; AJvYcCU962Somcoqxac/PCJt9F6G1zDUJRpvbjTwU5xQDex4qcUNru1cwNJf0vVgkEkTfWFDlyr6H2kJ+DqZmO47vcvk@vger.kernel.org
X-Gm-Message-State: AOJu0YwhtIoM6ib+R5m36AjEAoJw0gmV4FGRqmyQQyQ3WByJ/wjMLefV
	IL8u1oVg8QC8PV3D9x8hvBJtyaeomtDDQuh+9MIwKkXDCCsbfZ/353oUO2LDVQAPcPqLTPYi8g8
	yPnHXb/8hoTP3W3HWexE487RaUf2F1fgLiInZk6kZ
X-Gm-Gg: AY/fxX7lWVi3+SkxTNGVIpPMGeWGBkqLfoyNqCt0KSfU4L/zk1tb+mQooLlYbfmTsam
	iH+eFbL6k7IpUh8SsSA5amdDt5CeM6jl0/4WCq/3v/bc3faCKLrgqiaLqZSvII2kbBLpbEaCMD5
	9st26ve7HDT+ZL2FGrIAWZlM7S4LeYoBozhKXLBb/QGx8MoQ1GMa+4uTiuf4RSBSiIvqp0LLJpo
	20KLOu+0uCEw1g0eV4XXjqRZ4hb97iqzpp4llv3XA6i+/JH9WWvc71Ky1dkneQ93OGSkFbeT4dK
	PT3ePgt/VFkKDoiwaH+qojMJEw==
X-Received: by 2002:a17:903:2b06:b0:297:dad6:fe58 with SMTP id
 d9443c01a7336-2a599977232mr3419075ad.0.1768409537092; Wed, 14 Jan 2026
 08:52:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-james-perf-config-bits-v5-0-0ef97aaf1ac0@linaro.org> <20260114-james-perf-config-bits-v5-3-0ef97aaf1ac0@linaro.org>
In-Reply-To: <20260114-james-perf-config-bits-v5-3-0ef97aaf1ac0@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Jan 2026 08:52:05 -0800
X-Gm-Features: AZwV_QiKCUV62tv-YCq7vPDV3_F8u4hrLGMT5SirXiVOr8SHGdpodOsJ0fMh5j8
Message-ID: <CAP-5=fUhHJOiWCKZVKNpRYMvM-6c=xAaqwwSz=bpZSk=X-QKeQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/14] perf evsel: Move evsel__* functions to evsel.c
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 7:57=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> At least one of these were put here to avoid a Python binding linking
> issue which is no longer present. Put them back in their correct
> location to avoid confusion about which file to add a new evsel__*
> function to later.
>
> Link: https://lore.kernel.org/all/ZEbAS2yx2fguW60w@kernel.org/
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/evsel.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/pmu.c   | 40 ----------------------------------------
>  2 files changed, 40 insertions(+), 40 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ec6552a6f667..21878e9bd029 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1314,6 +1314,35 @@ struct evsel_config_term *__evsel__get_config_term=
(struct evsel *evsel, enum evs
>         return found_term;
>  }
>
> +/*
> + * Set @config_name to @val as long as the user hasn't already set or cl=
eared it
> + * by passing a config term on the command line.
> + *
> + * @val is the value to put into the bits specified by @config_name rath=
er than
> + * the bit pattern. It is shifted into position by this function, so to =
set
> + * something to true, pass 1 for val rather than a pre shifted value.
> + */
> +#define field_prep(_mask, _val) (((_val) << (ffsll(_mask) - 1)) & (_mask=
))
> +void evsel__set_config_if_unset(struct evsel *evsel, const char *config_=
name,
> +                               u64 val)
> +{
> +       u64 user_bits =3D 0, bits;
> +       struct evsel_config_term *term =3D evsel__get_config_term(evsel, =
CFG_CHG);
> +
> +       if (term)
> +               user_bits =3D term->val.cfg_chg;
> +
> +       bits =3D perf_pmu__format_bits(evsel->pmu, config_name);
> +
> +       /* Do nothing if the user changed the value */
> +       if (bits & user_bits)
> +               return;
> +
> +       /* Otherwise replace it */
> +       evsel->core.attr.config &=3D ~bits;
> +       evsel->core.attr.config |=3D field_prep(bits, val);
> +}
> +
>  void __weak arch_evsel__set_sample_weight(struct evsel *evsel)
>  {
>         evsel__set_sample_bit(evsel, WEIGHT);
> @@ -4098,6 +4127,17 @@ void evsel__set_leader(struct evsel *evsel, struct=
 evsel *leader)
>         evsel->core.leader =3D &leader->core;
>  }
>
> +bool evsel__is_aux_event(const struct evsel *evsel)
> +{
> +       struct perf_pmu *pmu;
> +
> +       if (evsel->needs_auxtrace_mmap)
> +               return true;
> +
> +       pmu =3D evsel__find_pmu(evsel);
> +       return pmu && pmu->auxtrace;
> +}
> +
>  int evsel__source_count(const struct evsel *evsel)
>  {
>         struct evsel *pos;
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index e87c12946d71..e3a1f26213ec 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1362,46 +1362,6 @@ void perf_pmu__warn_invalid_formats(struct perf_pm=
u *pmu)
>         }
>  }
>
> -bool evsel__is_aux_event(const struct evsel *evsel)
> -{
> -       struct perf_pmu *pmu;
> -
> -       if (evsel->needs_auxtrace_mmap)
> -               return true;
> -
> -       pmu =3D evsel__find_pmu(evsel);
> -       return pmu && pmu->auxtrace;
> -}
> -
> -/*
> - * Set @config_name to @val as long as the user hasn't already set or cl=
eared it
> - * by passing a config term on the command line.
> - *
> - * @val is the value to put into the bits specified by @config_name rath=
er than
> - * the bit pattern. It is shifted into position by this function, so to =
set
> - * something to true, pass 1 for val rather than a pre shifted value.
> - */
> -#define field_prep(_mask, _val) (((_val) << (ffsll(_mask) - 1)) & (_mask=
))
> -void evsel__set_config_if_unset(struct evsel *evsel, const char *config_=
name,
> -                               u64 val)
> -{
> -       u64 user_bits =3D 0, bits;
> -       struct evsel_config_term *term =3D evsel__get_config_term(evsel, =
CFG_CHG);
> -
> -       if (term)
> -               user_bits =3D term->val.cfg_chg;
> -
> -       bits =3D perf_pmu__format_bits(evsel->pmu, config_name);
> -
> -       /* Do nothing if the user changed the value */
> -       if (bits & user_bits)
> -               return;
> -
> -       /* Otherwise replace it */
> -       evsel->core.attr.config &=3D ~bits;
> -       evsel->core.attr.config |=3D field_prep(bits, val);
> -}
> -
>  static struct perf_pmu_format *
>  pmu_find_format(const struct list_head *formats, const char *name)
>  {
>
> --
> 2.34.1
>
