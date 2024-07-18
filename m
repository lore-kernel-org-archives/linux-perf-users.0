Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA407470
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309144; cv=none; b=XADuZkgS1LxCETPcGHF6cjbzUwEoQ9QIFOS19wHtiH3PBQsni0D9VGDqS/RhXCoJF1n1ZQ84wAjpZppd7bhwIO2QtLDDOjsV9qqc1xLzJ+IYvbjP87va4e6krRqeSqI3DrVCcUh82qXcUIUDh/p7B5uNp5rQn60OQfPLPih7ZHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309144; c=relaxed/simple;
	bh=7E9MLCxN2+UcJZmebDx3rYcx3CZhfBW8CLjhhNkWsL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iNdyD4uVRg2ilUnCZXYsCjUleMEVdZLTqqA+XZpPOE9gn2UL2CTB7dLaED+oqhBuwLzncX0ITBlc8w8z+JF8y6/69NFBjP75nRh9/RTDZZ0uEt8cyZBfKQe5GDE/W0qyTWNUhwuaK77Dpu6ZRw8319+LdLycAao5Zoc1cYewTkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h7reQk0R; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7reQk0R"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3da5eab691bso302585b6e.0
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721309140; x=1721913940; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6u33BE/Zx9BQXUadkdADDVxjMkkZVQKQkWWACwS8Fdk=;
        b=h7reQk0Ru2RJAtemnEAQq8DXkMknQEQP/rwztoxLBS1/KGBL/1+7v5OqMQNDMC01Vc
         8Ubl8hvAZADAWs6NmKWdS7GmVNv0que8d5V/IWZTHKkVq4FMF/IeQ8p1DZAi68ghjYye
         qqSPmsDzkFpWsDQdo4qZQ6Cew58++rY2kyeVivlf6Hhh0BOPbFPCAj6UumFkPjtafqS9
         j80Muk6tOiFrgcVu+OIhp5PW8hLuaWl2TJseagPPXcSqZh2d6PD42ANYji+J2N17BB1Z
         FfXNnwKYXJwApNwcnIPBiRkimx/xN/YSvr8XMs6SKjsbBWy3a/tgKzjshxT5jzmhgH8R
         CbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721309140; x=1721913940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6u33BE/Zx9BQXUadkdADDVxjMkkZVQKQkWWACwS8Fdk=;
        b=WZh0HPbALM2q9fCmAU9okuY1T+hOwuwGOZOSQPz92BKLpRWIn3Ukx1N4QTcsPPumFu
         O3VJs00eCl9MQ9OFAKKzNtA01SAU44elLziDCpdt3tYBREuzdVCF8vbp27A0MQf8FnHr
         sxJpPxCmIVBgkv5nVI6Do/7PiMGAwRZyRyQxrnwM4Lb72hRXvJieKoTm+adxSgpC/3Gn
         gqFLg0a06m18kROgimC6eAbI2jexR/v44SfdQg5BXy84fxk21+PI0PiTRtnKjMNjwXg1
         FoaYJ0M04TqrFjsQbWWQIsrj3UjNhjNBl/B0X3tU95RZ4f02h+kJzmWICXm1SJUiixQO
         qeeA==
X-Forwarded-Encrypted: i=1; AJvYcCWeAGa5fy7BeAymWqvySU3LKC/ZMofQamacpf7li8adqbrmqPQ1UI5yv0Sv3tajRUUKcc8hA+xG8yHlhWAUoZ9dCBSDDGUQ4mkhY+3YAefw1w==
X-Gm-Message-State: AOJu0Yy41MMRIeXWTRkrJ0k21d2WR9ODjBaT5jjEfp2NQsqYZmB/0BKd
	UXRKZqLgXVKyyNzuu3vvZidIyWkY5yRJ6zlWJgBeUeIEj9oYdgFNukmc9ZDnG8ThJqAL1/Fzo04
	pX7ZBHmKBBCz17xiDVVa2X/B1+zphDY4vy3w6MA==
X-Google-Smtp-Source: AGHT+IGKC/ZsbnFgt4JyjJAfnoT/3Lb+kggEiogigNqLWPbn73aOYqG3+3JwCEvetKDXFvcd02w9i8v9M948PkzRZ2g=
X-Received: by 2002:a05:6871:293:b0:254:a57e:1aed with SMTP id
 586e51a60fabf-260d907c717mr4383695fac.26.1721309140544; Thu, 18 Jul 2024
 06:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712102029.3697965-1-james.clark@linaro.org> <20240712102029.3697965-9-james.clark@linaro.org>
In-Reply-To: <20240712102029.3697965-9-james.clark@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 18 Jul 2024 14:25:29 +0100
Message-ID: <CAJ9a7ViLNtH+tHgxDTRQGO3m+kF-t8v_HB_-JuGiFwnS9UJZEQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/17] perf: cs-etm: Add runtime version check for OpenCSD
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, suzuki.poulose@arm.com, 
	gankulkarni@os.amperecomputing.com, leo.yan@linux.dev, 
	anshuman.khandual@arm.com, James Clark <james.clark@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 11:22, James Clark <james.clark@linaro.org> wrote:
>
> From: James Clark <james.clark@arm.com>
>
> OpenCSD is dynamically linked so although there is a build time check,
> at runtime the user might still have the wrong version. To avoid hard
> to debug errors, add a runtime version check.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/build/feature/test-libopencsd.c               |  4 ++--
>  tools/perf/Makefile.config                          |  2 +-
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c     | 13 +++++++++++++
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h     |  1 +
>  tools/perf/util/cs-etm-decoder/cs-etm-min-version.h | 13 +++++++++++++
>  tools/perf/util/cs-etm.c                            |  3 +++
>  6 files changed, 33 insertions(+), 3 deletions(-)
>  create mode 100644 tools/perf/util/cs-etm-decoder/cs-etm-min-version.h
>
> diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
> index 4cfcef9da3e4..d092a0c662f4 100644
> --- a/tools/build/feature/test-libopencsd.c
> +++ b/tools/build/feature/test-libopencsd.c
> @@ -1,12 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <opencsd/c_api/opencsd_c_api.h>
> +#include "cs-etm-decoder/cs-etm-min-version.h"
>
>  /*
>   * Check OpenCSD library version is sufficient to provide required features
>   */
> -#define OCSD_MIN_VER ((1 << 16) | (2 << 8) | (1))
>  #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
> -#error "OpenCSD >= 1.2.1 is required"
> +#error "OpenCSD minimum version (OCSD_MIN_VER) not met."
>  #endif
>
>  int main(void)
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 7f1e016a9253..2d21be42820e 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -141,7 +141,7 @@ endif
>  ifdef CSLIBS
>    LIBOPENCSD_LDFLAGS := -L$(CSLIBS)
>  endif
> -FEATURE_CHECK_CFLAGS-libopencsd := $(LIBOPENCSD_CFLAGS)
> +FEATURE_CHECK_CFLAGS-libopencsd := $(LIBOPENCSD_CFLAGS) -I$(src-perf)/util
>  FEATURE_CHECK_LDFLAGS-libopencsd := $(LIBOPENCSD_LDFLAGS) $(OPENCSDLIBS)
>
>  # for linking with debug library, run like:
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index b78ef0262135..5e1b4503aab1 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -16,6 +16,7 @@
>
>  #include "cs-etm.h"
>  #include "cs-etm-decoder.h"
> +#include "cs-etm-min-version.h"
>  #include "debug.h"
>  #include "intlist.h"
>
> @@ -835,3 +836,15 @@ const char *cs_etm_decoder__get_name(struct cs_etm_decoder *decoder)
>  {
>         return decoder->decoder_name;
>  }
> +
> +int cs_etm_decoder__check_ver(void)
> +{
> +       if (ocsd_get_version() < OCSD_MIN_VER) {
> +               pr_err("OpenCSD >= %d.%d.%d is required\n", OCSD_MIN_MAJOR,
> +                                                           OCSD_MIN_MINOR,
> +                                                           OCSD_MIN_PATCH);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> index 12c782fa6db2..2ec426ee16dc 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -107,5 +107,6 @@ int cs_etm_decoder__get_packet(struct cs_etm_packet_queue *packet_queue,
>
>  int cs_etm_decoder__reset(struct cs_etm_decoder *decoder);
>  const char *cs_etm_decoder__get_name(struct cs_etm_decoder *decoder);
> +int cs_etm_decoder__check_ver(void);
>
>  #endif /* INCLUDE__CS_ETM_DECODER_H__ */
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-min-version.h b/tools/perf/util/cs-etm-decoder/cs-etm-min-version.h
> new file mode 100644
> index 000000000000..c69597e9d0af
> --- /dev/null
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-min-version.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef INCLUDE__CS_ETM_MIN_VERSION_H__
> +#define INCLUDE__CS_ETM_MIN_VERSION_H__
> +
> +#define OCSD_MIN_MAJOR 1
> +#define OCSD_MIN_MINOR 2
> +#define OCSD_MIN_PATCH 1
> +
> +#define OCSD_MIN_VER ((OCSD_MIN_MAJOR << 16) | \
> +                     (OCSD_MIN_MINOR << 8) |  \
> +                     (OCSD_MIN_PATCH))
> +
> +#endif /* INCLUDE__CS_ETM_MIN_VERSION_H__ */
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 49fadf46f42b..2385d5ed5ea5 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -3369,6 +3369,9 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>         u64 *ptr = NULL;
>         u64 **metadata = NULL;
>
> +       if (cs_etm_decoder__check_ver())
> +               return -EINVAL;
> +
>         /* First the global part */
>         ptr = (u64 *) auxtrace_info->priv;
>         num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>
--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
