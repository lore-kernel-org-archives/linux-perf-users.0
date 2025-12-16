Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DAE2505A5
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 20:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765917894; cv=pass; b=MQfga/JkJpg4MtWHRex/auARfFO8vBE4T+UosXr6QokD0u81Ws6MuKzGmIYw66aHQqY55zyG6BNSxoPbUdf9xtmdWtLGNQFWoDpvuSxm28dTTc6XM1BICWH2p3Qrx3eXwiU9BLle8/VokyGTHoPbnwZ6MTDcCty0jlviaUJLnJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765917894; c=relaxed/simple;
	bh=Vcwhr+1azXtESmI1GGuqFIBS4x49F+nkIQygXYmlLu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJ9/13kGqCPCgH5VYNKc/WT6F+COPZE2RFFyHDPg0Y6XsrP57P+GI6EJ9UHu2EYOx3cGJNeL862EPT96KkfqVKdwXWBZR0hIPjCwU06/8Y+JS3SKEPEbhVgcseD7yEVwbW+kO/Lk+5kOsLeyoLHm98FYVfGB1jaTNm2j4/UrPVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EFdwyjYb; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFdwyjYb"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29f02651fccso41245ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 12:44:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765917892; cv=none;
        d=google.com; s=arc-20240605;
        b=Z4IyRsNxo9GgtQL3snsRVlnS+p83nOsRjh+xG5BiYbUA9qUsNmlK5LHe9+Q+LlTXEu
         nuBBmfAS7VwvoGYUD/ObKZUdkAM8pup3MvhQm1vPPlit+kdqXBKS/llpnefzlU9cYgJM
         fD9EoB5NiCQgF5APG5tpK7OjKSdbw4/cuBvCRDN14STq9/9/ls/+i+ZsvqKkjJD09AlL
         VRFwqzzQmYExP0CVjgu84llIAlgJMiTtGaRwsMGFLFZ7BandJt9s67Rth4HvGb6C8RcU
         eCsRn/ZkQ5gCYr5twpuFWBTP3FjUQgKmAGiSzdeEIkqeyhn/a4xcuwPvaMzw5AC3+QJJ
         197A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2LLx7o8qacULiY5CnsYaJ+nvNRuzxxG70dIx5GLh8eU=;
        fh=xH+UwEQllb5NbrOgxyPmrsfQf/xn/r4D7w3XModmVBE=;
        b=DHgS/0+ZHFaVpPvA0BpsPfTj0kJFskVPDUAwFqj+nyl+qFaQZuy3vx1IB4aJT0Zlof
         Nf/EKH0ew8dXMur+G/053/auTOSzfGST67mnmTcvN9m2Mytajr0qkoReKXiRzbm8kT65
         Scs0eZpXXlHNCf2PGtckk09smxzVOkFsP5ydTkT4m+wLLGulnd3VGfG4+QZAIw+qnjtP
         xxi0wwzGqwyDOECl/AqR1HGaEx5EXHgiPGWm5qE3CY1j5wwXyCcjQqmzwAf45z34elff
         vtz2rOMOAcpNr8cXWqr0nrKnvpWrFmo2VnZpSD6ckDbxwZAt0JkEao1vg44/Hhi5SU8a
         FwpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765917892; x=1766522692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LLx7o8qacULiY5CnsYaJ+nvNRuzxxG70dIx5GLh8eU=;
        b=EFdwyjYb1XbG4OMihfPzFiNQWs6diWIbDax4kHD+z86eV2bJUS/b4iFmjGu0FEftVi
         1Mqxy5Gos5WwymeoSqDdJOPOfUpTxefvQqs6FTggBCHSbzZfX6dDhSlBMVnw0nRMauw0
         9yXVeVX7Yv8xWpqTBeTub6zwRnvVmAPv+0joVMGMRkDrT6rskE+FMAOfPZMAkMrYtuuR
         /+zBkpGBc3u3ZVYcfwE29WKjmNBi+x2zuSRi7uZXjIZO4KfjASiieiWqxbc1CyxmlYAd
         3JMy3nXLmguCCGu7FJ2sHiCpwhREX+pJpw1w/Br/2/dA8S325i+itCxxvUYVZFKp5AmI
         Nkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765917892; x=1766522692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2LLx7o8qacULiY5CnsYaJ+nvNRuzxxG70dIx5GLh8eU=;
        b=oQW8BLF70pIzhst/9LyLykewvi2kCjrYiEfWQnbrYV7ssfoC0vscksCqYb1D4sWIWN
         IRuQZRdrMaHe/zuFbRx7WOGJ0fR50qQKGkJGBVma6sMH7l3OuSE3z2+TUw6pVU88kYts
         i4Q4rDvpoDQHGiFkvpz6wB32QZpQ11t3Y1qp/R4okS/v2PbFpRzkZxjKTVUP+FmSYGWM
         4FT00AiyR71TTEqt0CYC4oYIVdlqycI/cK4MBEJMKUFdTTsLDX0AN10Ede8miNpua4ZD
         FsVRDtDs4xQxJneWl+fhjoIvXPWMpnO/7DTMuab9cwSgAZjVq23WIS/FiEO6zNG1wdP2
         4+SA==
X-Forwarded-Encrypted: i=1; AJvYcCX9bop4llzsaCBor9MLh5Jy6lGhdRCCJxz0QdP4KIiiCGYXBr97BTPkDm/35aWhzi6hLsC3OvrgFQcvLUQ2AcNN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+WNDaUNGeKe+phPgQKhfeFRlrdN9ojyn4uJytnrNSKsi/pH2g
	xA8WVjoP6UsHSiruhbncrAl+4ByVLSiooTrzkE3FYAByabJLKIsCOfTQq2tVkprFv0AXUeeK77F
	SqzNjNf1YQLlavL2M3Lj7d80Roh5+BqhsGbwKkDnv
X-Gm-Gg: AY/fxX4NGGHCDGbN8RUJHMwfjqkWtaiEgjhHfKibDjA75pXc4EI6n6DLRZIz/w6bf/o
	WOw9f1d7anpr7QrAyMJbwna5x95r1L9XTVrPFCBtCot6OSk7d9tP2di4TqDCytMCBEBEr379Ghm
	hOVN/PZs0BH5L8I7I6oiWJSJqcm6XuLVT4W/+bgMdEP8e4QWwmh3u3uZjlXSNlsQ47IdwXuYpwe
	W5wmaonkrdFFEaCarK4hOZEgUbSPQZbIojJdv81oN+DmGcab4QG0dDsWhhUwNzF/GjKKM2DIbo5
	vK1YbUyViJEzpsAc4o73gkIe3Q==
X-Google-Smtp-Source: AGHT+IE6CjCFZBwbsdmegBB69hl7iVQBsVm/wpuAsXfRbt/LWg5fDNm8swZTLE0fwCiZj305lX7sT+/YotUXZ03uutM=
X-Received: by 2002:a17:903:46c5:b0:298:144f:b759 with SMTP id
 d9443c01a7336-2a15f32ceacmr409475ad.9.1765917891871; Tue, 16 Dec 2025
 12:44:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212-james-perf-config-bits-v3-0-aa36a4846776@linaro.org> <20251212-james-perf-config-bits-v3-5-aa36a4846776@linaro.org>
In-Reply-To: <20251212-james-perf-config-bits-v3-5-aa36a4846776@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Dec 2025 12:44:40 -0800
X-Gm-Features: AQt7F2rjA-Iq0O35uFlH-FSpbyzfTkG3lNU-Igxt37dlPKq959y9P2pH2UKNTRM
Message-ID: <CAP-5=fUbr56hFd7e7yt33-gnhEGGa72GLmShQ5bCHxQjFAbFCQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] perf evsel: Add a helper to get the value of a
 config field
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

On Fri, Dec 12, 2025 at 7:32=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> This will be used by aux PMUs to read an already written value for
> configuring their events and for also testing.
>
> Its helper pmu_format_unpack() does the opposite of the existing
> pmu_format_value() so rename that one to pmu_format_pack() so it's clear
> how they are related.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/evsel.h |  2 ++
>  tools/perf/util/pmu.c   | 77 ++++++++++++++++++++++++++++++++++++++++++-=
------
>  2 files changed, 68 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index a08130ff2e47a887b19f6c47bfa9f51e0c40d226..092904a61ec7afdc59253f9b7=
8a9fe8b7cb5bfa7 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -575,6 +575,8 @@ void evsel__uniquify_counter(struct evsel *counter);
>         ((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (s=
ize) - 1)))
>
>  u64 evsel__bitfield_swap_branch_flags(u64 value);
> +int evsel__get_config_val(struct perf_pmu *pmu, struct evsel *evsel,
> +                         const char *config_name, u64 *val);
>  void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evse=
l,
>                                 const char *config_name, u64 val);
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 514cba91f5d99b399d2d6a1e350971660c54a9fc..ef7358ad1fb955f29f2e68b3d=
0ce711754e4d67c 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -144,8 +144,8 @@ struct perf_pmu_format {
>  };
>
>  static int pmu_aliases_parse(struct perf_pmu *pmu);
> -static void pmu_format_value(unsigned long *format, __u64 value, __u64 *=
v,
> -                            bool zero);
> +static void pmu_format_pack(unsigned long *format, __u64 value, __u64 *v=
,
> +                           bool zero);
>  static struct perf_pmu_format *pmu_find_format(const struct list_head *f=
ormats,
>                                                const char *name);
>
> @@ -1377,6 +1377,61 @@ bool evsel__is_aux_event(const struct evsel *evsel=
)
>         return pmu && pmu->auxtrace;
>  }
>
> +/*
> + * Unpacks a raw config[n] value using the sparse bitfield that defines =
a
> + * format attr. For example "config1:1,6-7,44" defines a 4 bit value acr=
oss non
> + * contiguous bits and this function returns those 4 bits as a value.
> + */
> +static u64 pmu_format_unpack(u64 format, u64 config_val)
> +{
> +       int val_bit =3D 0;
> +       u64 res =3D 0;
> +       int fmt_bit;
> +
> +       for_each_set_bit(fmt_bit, &format, PERF_PMU_FORMAT_BITS) {
> +               if (test_bit(fmt_bit, &config_val))
> +                       res |=3D BIT_ULL(val_bit);
> +
> +               val_bit++;
> +       }
> +       return res;
> +}
> +
> +int evsel__get_config_val(struct perf_pmu *pmu, struct evsel *evsel,
> +                         const char *config_name, u64 *val)

nits:
This is an evsel__ function but the evsel is the 2nd argument not the first=
.
Why pass the PMU and not just read evsel->pmu (or better evsel__find_pmu) ?
Why not place this in evsel.c to match the header file declaration?
The evsel could be likely be const.

Thanks,
Ian

> +{
> +       struct perf_pmu_format *format =3D pmu_find_format(&pmu->format, =
config_name);
> +       u64 bits =3D perf_pmu__format_bits(pmu, config_name);
> +
> +       if (!format || !bits) {
> +               pr_err("Unknown/empty format name: %s\n", config_name);
> +               *val =3D 0;
> +               return -EINVAL;
> +       }
> +
> +       switch (format->value) {
> +       case PERF_PMU_FORMAT_VALUE_CONFIG:
> +               *val =3D pmu_format_unpack(bits, evsel->core.attr.config)=
;
> +               return 0;
> +       case PERF_PMU_FORMAT_VALUE_CONFIG1:
> +               *val =3D pmu_format_unpack(bits, evsel->core.attr.config1=
);
> +               return 0;
> +       case PERF_PMU_FORMAT_VALUE_CONFIG2:
> +               *val =3D pmu_format_unpack(bits, evsel->core.attr.config2=
);
> +               return 0;
> +       case PERF_PMU_FORMAT_VALUE_CONFIG3:
> +               *val =3D pmu_format_unpack(bits, evsel->core.attr.config3=
);
> +               return 0;
> +       case PERF_PMU_FORMAT_VALUE_CONFIG4:
> +               *val =3D pmu_format_unpack(bits, evsel->core.attr.config4=
);
> +               return 0;
> +       default:
> +               pr_err("Unknown format value: %d\n", format->value);
> +               *val =3D 0;
> +               return -EINVAL;
> +       }
> +}
> +
>  /*
>   * Set @config_name to @val as long as the user hasn't already set or cl=
eared it
>   * by passing a config term on the command line.
> @@ -1432,7 +1487,7 @@ void evsel__set_config_if_unset(struct perf_pmu *pm=
u, struct evsel *evsel,
>                 return;
>
>         /* Otherwise replace it */
> -       pmu_format_value(&bits, val, vp, /*zero=3D*/true);
> +       pmu_format_pack(&bits, val, vp, /*zero=3D*/true);
>  }
>
>  static struct perf_pmu_format *
> @@ -1477,8 +1532,8 @@ int perf_pmu__format_type(struct perf_pmu *pmu, con=
st char *name)
>   * Sets value based on the format definition (format parameter)
>   * and unformatted value (value parameter).
>   */
> -static void pmu_format_value(unsigned long *format, __u64 value, __u64 *=
v,
> -                            bool zero)
> +static void pmu_format_pack(unsigned long *format, __u64 value, __u64 *v=
,
> +                           bool zero)
>  {
>         unsigned long fbit, vbit;
>
> @@ -1595,23 +1650,23 @@ static int pmu_config_term(const struct perf_pmu =
*pmu,
>                 switch (term->type_term) {
>                 case PARSE_EVENTS__TERM_TYPE_CONFIG:
>                         assert(term->type_val =3D=3D PARSE_EVENTS__TERM_T=
YPE_NUM);
> -                       pmu_format_value(bits, term->val.num, &attr->conf=
ig, zero);
> +                       pmu_format_pack(bits, term->val.num, &attr->confi=
g, zero);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_CONFIG1:
>                         assert(term->type_val =3D=3D PARSE_EVENTS__TERM_T=
YPE_NUM);
> -                       pmu_format_value(bits, term->val.num, &attr->conf=
ig1, zero);
> +                       pmu_format_pack(bits, term->val.num, &attr->confi=
g1, zero);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_CONFIG2:
>                         assert(term->type_val =3D=3D PARSE_EVENTS__TERM_T=
YPE_NUM);
> -                       pmu_format_value(bits, term->val.num, &attr->conf=
ig2, zero);
> +                       pmu_format_pack(bits, term->val.num, &attr->confi=
g2, zero);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_CONFIG3:
>                         assert(term->type_val =3D=3D PARSE_EVENTS__TERM_T=
YPE_NUM);
> -                       pmu_format_value(bits, term->val.num, &attr->conf=
ig3, zero);
> +                       pmu_format_pack(bits, term->val.num, &attr->confi=
g3, zero);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_CONFIG4:
>                         assert(term->type_val =3D=3D PARSE_EVENTS__TERM_T=
YPE_NUM);
> -                       pmu_format_value(bits, term->val.num, &attr->conf=
ig4, zero);
> +                       pmu_format_pack(bits, term->val.num, &attr->confi=
g4, zero);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
>                         assert(term->type_val =3D=3D PARSE_EVENTS__TERM_T=
YPE_NUM);
> @@ -1749,7 +1804,7 @@ static int pmu_config_term(const struct perf_pmu *p=
mu,
>                  */
>         }
>
> -       pmu_format_value(format->bits, val, vp, zero);
> +       pmu_format_pack(format->bits, val, vp, zero);
>         return 0;
>  }
>
>
> --
> 2.34.1
>
