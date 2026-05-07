Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C42343D504
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168850; cv=pass; b=o7clPCLJ3ODJyRU7NORxXmGKtjH4wm5aLBRdqWMX/lQpZQJuXkVrgQtEsOWp0fjXH/jQCReqrykE2FcKWuIuDHoz6hSaSXpPEGR+7a+ayQj0+fPvvYZqL49+gEWZm0CFq8rWeBB2kN9WaH6ZCl7dI93WB81GAC8BkiYZ1rG5DkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168850; c=relaxed/simple;
	bh=KSxNjO1GNRKJgUcGwTC5GrtdIJZfhur8GoYWsiBtRM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sK/eTut+42YghaWWg0Jcu9M2GNDu6kLr7R4Cb4mRmhPSIuyp9Z9yLUBVPVsMIN//jLCF7tstDU0u++2lsaOL2oyWWI68wEsUiU5JgmUdntvVqFPHeLAdmNpSlOPkYrQxPSZRNc3PUUxbtzJO+cUW9kWbKAv47mi2cYgCo/iYihQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s32HDSaP; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s32HDSaP"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso93575ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 07 May 2026 08:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778168848; cv=none;
        d=google.com; s=arc-20240605;
        b=A8awVVDZ2WJ1OV7/bn6QWn671k32hum1NFoAJU0qcKNuJyJcGBlQfPMQM/emex3RX2
         X+xzpAOh37b5Jw8VJtqI1NbDzNZmzs4vHHvfw4vlrhogvM5tx2isADRnWqQgYMe4w5+0
         7P1dL/d7EFE3el8L9gJSjvZ2P7y+7ZOiGeusHwkpmEbeLrcjZWoCVHu1hQ4nfFUQt0yq
         gWZhkx2PEBgGo2lqNb76gmGP1l3Aho2wHkz9hhl0Wlij6K51tU7hS1yefjuTp5Ak+Moh
         N61DrBH3Z23usD24aho16Znb5xpOq4c2W7SyT8wJc/7yPQEuN1jGv+jdrVwj1eqBo3ns
         KTww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cstzvmusnMqk3stu6mxbLSST0VF6CjbcqqN/wNdQUKA=;
        fh=bxtRERtmvwBVwnYnL4u1Fj2Dq2lLdKFWBTmbuEj8hxs=;
        b=PRgqBAkJW1KsRg3d4b41JWw9KwUs8YwlshEaWwK22JygJ5E2pkWdjgXgu1nYR77Om7
         jkeJOv0saCj+pCH0z1ojSGTBPBLSb18tsWDOXB+RzU4DRO11vJTQe0m8hPv/nSZV9TLP
         Lxk7ybAAEcrMTRGb+L2nLn3cW5eFjuOo/vtfyYILQ1pvjvfXBUw4hWd+fMGcYPYKSLT6
         ZI631Bc/Je2soGgw61K/tknsmOpPeCMVRalWRFilqo+QECmP1+yaOyhMqJWws/YMgf/K
         7W0pCV5kYYHhI941dqKb0fs1gtjMhJaLEEeex6h9HntPR7ymciZg8f6MuFJBzVov+xIs
         X+EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778168848; x=1778773648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cstzvmusnMqk3stu6mxbLSST0VF6CjbcqqN/wNdQUKA=;
        b=s32HDSaPV8pXxzhWBaimvhjSA80SeGHU87Il3Onz25wPdrjah10owclq/cthHcpoiI
         e0yPloY5suPtQl5KwiHFWvqNa0SHLLqOrSHJcj/x5YyYCdkhqcxtlc5KNblkkW2fDnc/
         jnC6kGMV4Nt98pGSGjm4xCnRIvgJeUthcTTAXw1kUTW3nJGfWQbWiryvsvaCKqhiuJCO
         YDB0YONNHGWSGIOysRkr8oJ4uJu7xXMHbLJMtmwGKjF4rbp+pIS3CwF1kgL1J0G/3ySs
         Zviq/C4WoQ+C0Uq1HPEEYygzfaq6BKiJD1h0nw4yeWkbwZYJYT0YCVp+3PxaIJIBRwv+
         U9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778168848; x=1778773648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cstzvmusnMqk3stu6mxbLSST0VF6CjbcqqN/wNdQUKA=;
        b=Dnlaq+MTpTleN/gs9SRzCUf4pQfeocsp8Q4G0NRRUQjREewuzz6SmUVjBj9txuN0vn
         LQd4/pzbJb9K4fPmBIrAEE1fIHmEsq+DUG0pZBBYJcQ34U+paJeO/0/4XuHefK0k6PoC
         PRCY5ZvtB4QPO/xJSeOmHXmMaDuCGAeQybTFb4uzYI2cPaV040HskImywuQDRiz1f+ay
         h2lA/QXMe51LEWGRFBE49TOAyQDV7vd3VbJLi5UxCGhasEINp5OorB/r63VAKkt7EQVZ
         l/G5VYoLwe2JTAt2I96cS3fb+vOY0wCj3fh1o9/jQGxGwQgv6Uqd/wwPL5QCIxnQtUXp
         UyZA==
X-Forwarded-Encrypted: i=1; AFNElJ8kGS4nMAshZMfi+H37catDNyrbaAeNhgMdb/mkofBXR+hp/wSa4kmi8+Q7ZUwm1ZCxyEOUyrcSnXVmzdWpWvmZ@vger.kernel.org
X-Gm-Message-State: AOJu0YziP8DCNHAPvbEPU9DnnPcvtl6Wx/A+718D28+HyjgCSGo4NFUe
	fMACLyJM1hjU12epFlqmzy7mCXV35Lp2duaKd3K5c7yMkgKh3bGu1wS/x6eFpe0+d1aeR99wcyo
	U+LbU8o5rTYxtxNtY0Hh3hP8xxwpKC6XA6INIoW+6
X-Gm-Gg: Acq92OHFMbIPo1QR/qJwGmz9qj/BraApnWGbvHK7BoFZiwV7eCbkmM48Pu8BLLywQqj
	f3BQb5nff4u9IPHjXWT8XxK/G3BJ8yMEGHfYkV7oRlmDxSPwlYtIDDUIo4W4RD5HYOsVS0mbvHR
	ulDc4sRN0CcXBZgnhNwnwNPaKOOVFglO50VTI0fprP2Ly8pAnS/axPgrYes8ihnNzBFyI9Fu2bn
	/LkI3z7B5OLgg3y7/Nn1TCMCzQs8o2vVGFVNdHQjqdfYMZUarIfMP25QKIxv0w3d40+9+qcz/GZ
	mjQMXaMv9CfPkBz25joYKMSRGgUV0/9wqhTScHJXZn1cnmlkrOOeR9hPxuo=
X-Received: by 2002:a17:902:d485:b0:2b4:60e6:44bc with SMTP id
 d9443c01a7336-2bae5af396cmr300555ad.13.1778168846966; Thu, 07 May 2026
 08:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507063737.3542950-1-wangyushan12@huawei.com> <20260507063737.3542950-6-wangyushan12@huawei.com>
In-Reply-To: <20260507063737.3542950-6-wangyushan12@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 7 May 2026 08:47:15 -0700
X-Gm-Features: AVHnY4IjsZKEkVdxEDddMGq32jUzgwPhqH7KOndqDYmspIKxL9sECLoyqSryYt0
Message-ID: <CAP-5=fW592tmsKW8WqMPodWzq2JKO5G4nHDy7LKo8PCD2RMZ1Q@mail.gmail.com>
Subject: Re: [RFT PATCH v2 5/7] perf-iostat: Extend iostat interface to
 support different iostat PMUs
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
> From: Shiju Jose <shiju.jose@huawei.com>
>
> Currently, platform-specific iostat code for PMUs is implemented as a
> common iostat callback interface and linked during build. This approach
> limits support for iostat across different implementations of PMU of the
> same architecture.
>
> To address this, extend common iostat interface to provide support for
> different PMUs by allowing each PMU to register itself and receive
> callbacks to its PMU-specific functions through the unified iostat
> framework.
>
> Signed-off-by: Shiju Jose  <shiju.jose@huawei.com>
> Co-developed-by: Yushan Wang <wangyushan12@huawei.com>
> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
> ---
>  tools/perf/util/iostat.c | 88 ++++++++++++++++++++++++++++++----------
>  tools/perf/util/iostat.h | 38 ++++++++++++++++-
>  2 files changed, 102 insertions(+), 24 deletions(-)
>
> diff --git a/tools/perf/util/iostat.c b/tools/perf/util/iostat.c
> index a68ab100780d..90607d1cf3fa 100644
> --- a/tools/perf/util/iostat.c
> +++ b/tools/perf/util/iostat.c
> @@ -1,47 +1,91 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "util/iostat.h"
> -#include "util/debug.h"
> +
> +/*
> + * Below iostat_* function calls are scattered through out perf stat pro=
cess,
> + * allowing multiple iostat PMUs and iterated them in following function=
s may
> + * violate calling conventions or cause incorrect display.
> + *
> + * Default to register the first PMU device that matches any of the spec=
ified
> + * iostat pmu name wildcards.
> + */
> +static struct iostat_pmu *iostat_pmu;

Could there be more than set of printing functions?

>  enum iostat_mode_t iostat_mode =3D IOSTAT_NONE;
>
> -__weak int iostat_prepare(struct evlist *evlist __maybe_unused,
> -                         struct perf_stat_config *config __maybe_unused)
> +__weak int iostat_prepare(struct evlist *evlist, struct perf_stat_config=
 *config)

Eww.. weak.

> +{
> +       if (!iostat_pmu)
> +               return -1;
> +
> +       return iostat_pmu->prepare(evlist, config);
> +}
> +
> +__weak int iostat_parse(const struct option *opt, const char *str, int u=
nset)
>  {
> -       return -1;
> +       if (!iostat_pmu)
> +               return -1;
> +
> +       return iostat_pmu->parse(opt, str, unset);
>  }
>
> -__weak int iostat_parse(const struct option *opt __maybe_unused,
> -                        const char *str __maybe_unused,
> -                        int unset __maybe_unused)
> +__weak void iostat_list(struct evlist *evlist, struct perf_stat_config *=
config)
>  {
> -       pr_err("iostat mode is not supported on current platform\n");
> -       return -1;
> +       iostat_pmu->list(evlist, config);
>  }
>
> -__weak void iostat_list(struct evlist *evlist __maybe_unused,
> -                      struct perf_stat_config *config __maybe_unused)
> +__weak void iostat_release(struct evlist *evlist)
>  {
> +       iostat_pmu->release(evlist);
>  }
>
> -__weak void iostat_release(struct evlist *evlist __maybe_unused)
> +__weak void iostat_print_header_prefix(struct perf_stat_config *config)
>  {
> +       iostat_pmu->print_header_prefix(config);
>  }
>
> -__weak void iostat_print_header_prefix(struct perf_stat_config *config _=
_maybe_unused)
> +__weak void iostat_print_metric(struct perf_stat_config *config,
> +                               struct evsel *evsel,
> +                               struct perf_stat_output_ctx *out)
>  {
> +       iostat_pmu->print_metric(config, evsel, out);
>  }
>
> -__weak void iostat_print_metric(struct perf_stat_config *config __maybe_=
unused,
> -                               struct evsel *evsel __maybe_unused,
> -                               struct perf_stat_output_ctx *out __maybe_=
unused)
> +__weak void iostat_print_counters(struct evlist *evlist,
> +                                 struct perf_stat_config *config,
> +                                 struct timespec *ts, char *prefix,
> +                                 iostat_print_counter_t print_cnt_cb,
> +                                 void *arg)
>  {
> +       iostat_pmu->print_counters(evlist, config, ts, prefix,
> +                                  print_cnt_cb, arg);
> +}
> +
> +void register_iostat_pmu(struct iostat_pmu *pmu)
> +{
> +       if (!pmu || !pmu->match)
> +               return;
> +
> +       if (iostat_pmu || !pmu->match(pmu))
> +               return;
> +
> +       iostat_pmu =3D pmu;
> +}
> +
> +static void unregister_iostat_pmu(void)
> +{
> +       if (!iostat_pmu)
> +               return;
> +
> +       /*
> +        * Release function of iostat_pmu is called on the exit of cmd_st=
at, we
> +        * don't need to call release function here.
> +        */
> +       iostat_pmu =3D NULL;
>  }
>
> -__weak void iostat_print_counters(struct evlist *evlist __maybe_unused,
> -                                 struct perf_stat_config *config __maybe=
_unused,
> -                                 struct timespec *ts __maybe_unused,
> -                                 char *prefix __maybe_unused,
> -                                 iostat_print_counter_t print_cnt_cb __m=
aybe_unused,
> -                                 void *arg __maybe_unused)
> +__attribute__((destructor))

I don't believe using this attribute is standard in either perf or the kern=
el.

> +static void iostat_exit(void)
>  {
> +       unregister_iostat_pmu();
>  }
> diff --git a/tools/perf/util/iostat.h b/tools/perf/util/iostat.h
> index 820930a096d9..5cc8963c6122 100644
> --- a/tools/perf/util/iostat.h
> +++ b/tools/perf/util/iostat.h
> @@ -10,6 +10,7 @@
>  #ifndef _IOSTAT_H
>  #define _IOSTAT_H
>
> +#include <stdbool.h>
>  #include <subcmd/parse-options.h>
>  #include "util/stat.h"
>  #include "util/parse-events.h"
> @@ -31,8 +32,7 @@ extern enum iostat_mode_t iostat_mode;
>  typedef void (*iostat_print_counter_t)(struct perf_stat_config *, struct=
 evsel *, void *);
>
>  int iostat_prepare(struct evlist *evlist, struct perf_stat_config *confi=
g);
> -int iostat_parse(const struct option *opt, const char *str,
> -                int unset __maybe_unused);
> +int iostat_parse(const struct option *opt, const char *str, int unset);
>  void iostat_list(struct evlist *evlist, struct perf_stat_config *config)=
;
>  void iostat_release(struct evlist *evlist);
>  void iostat_print_header_prefix(struct perf_stat_config *config);
> @@ -42,4 +42,38 @@ void iostat_print_counters(struct evlist *evlist,
>                            struct perf_stat_config *config, struct timesp=
ec *ts,
>                            char *prefix, iostat_print_counter_t print_cnt=
_cb, void *arg);
>
> +/**
> + * struct iostat_pmu - Callbacks for an iostat-capable PMU backend.
> + * @pmu_name_wildcard: Glob pattern to identify the PMU (e.g. "uncore_ii=
o*").
> + * @match: Detect whether matching PMUs exist on this system.
> + * @prepare: Set up events and config for iostat collection.
> + * @parse: Parse the --iostat option argument.
> + * @list: Display available iostat PMU instances.
> + * @print_header_prefix: Print the column header prefix.
> + * @print_metric: Format and print one metric value.
> + * @print_counters:  Iterate over counters and print per-port results.
> + * @release: Clean up PMU-specific resources.
> + */
> +struct iostat_pmu {

I wonder if iostat_pmu is the best name here, perhaps
iostat_callbacks? It would be nice not to overload the term PMU in the
code with regular PMUs and the iostat PMUs.

Thanks,
Ian

> +       const char *pmu_name_wildcard;
> +       bool (*match)(struct iostat_pmu *iostat_pmu);
> +       int (*prepare)(struct evlist *evlist, struct perf_stat_config *co=
nfig);
> +       int (*parse)(const struct option *opt, const char *str, int unset=
);
> +       void (*list)(struct evlist *evlist, struct perf_stat_config *conf=
ig);
> +       void (*print_header_prefix)(struct perf_stat_config *config);
> +       void (*print_metric)(struct perf_stat_config *config, struct evse=
l *evsel,
> +                            struct perf_stat_output_ctx *out);
> +       void (*print_counters)(struct evlist *evlist,
> +                              struct perf_stat_config *config, struct ti=
mespec *ts,
> +                              char *prefix, iostat_print_counter_t print=
_cnt_cb, void *arg);
> +       void (*release)(struct evlist *evlist __maybe_unused);
> +};
> +
> +/*
> + * Register an iostat PMU handler. Called from __attribute__((constructo=
r))
> + * functions in each backend's translation unit.
> + *
> + * Only the first matched backend is activated.
> + */
> +void register_iostat_pmu(struct iostat_pmu *iostat_pmu);
>  #endif /* _IOSTAT_H */
> --
> 2.33.0
>
