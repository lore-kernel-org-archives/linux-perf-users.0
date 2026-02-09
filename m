Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86570324B1D
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 23:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770678650; cv=pass; b=JYqRhJFMOzhsMRn6SkT6lFv8onmwJ72h16op4gIllAaStAdrWcjMYBQh+Sg6rX4RWiuojWZNcFMAmMG5nrHbFdmj5Evx/xQqp8+SfWW/khwo9ExsZtClMFo8AgbDRNJfsqZFWdmZGFmxQYhWZHoUM6n7Q5DFB43SsGxbr/cHBuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770678650; c=relaxed/simple;
	bh=bmzkjImzm3pLisa/pkk9oLWTiheVi3AZEPqis0zopHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TknQtjuBn+sW058LnRI8pCKomLggZ8xkd7YlgXmp94xWap9hsLB+aqrPyd8qbO4DznUSwVzWnEGtRDWV9cKVLGouV0KVen8nxzmDaMVjJ94TIy/bCSSeJCwFmRZxW2ir8twpb6qIXE52ZALlrYZRF/UzFiAPOePDdW5yhIBiRBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ug8yFs8z; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ug8yFs8z"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aad8123335so14905ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 15:10:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770678648; cv=none;
        d=google.com; s=arc-20240605;
        b=Q1hCuBHEah50zs+GIpxCm7zdlCnRZoLunV7qH0xDvjxU7LPUx6XLVbzE6MlrJIxSnU
         ie22O+QEPcEwP22DhM1TTWAWDfGYy5+iBV4QJJJbWFUpEsZgdJGcm1X40MHceyX8Hkop
         mQyP8Ji/bJ79jPniPPixjCrDnAtwFjzJ6a6rm/2zVqKAWjlmp0ArrBjOzFHkHbhvg1PM
         Y8gAF5pAUEK/n8+db/Hmpr1d3jQ2Ai+bOJYRAxV8GZKcikDIJqD47NctEmPMeozuSydj
         knJIyVst6tU7xlM5bDNcWm9f+F9cZCTr99yhnXcJSEGHD8gg5NaX1Nf3/gZ8VKSAO7dk
         Wq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bij18CszkpfwqsgQB87yfzBXxL8pB3K2t0j3obIGt04=;
        fh=tZc8No9wDFPg56ZaW7XfcLazEN0WF0JbyhKVEl97kew=;
        b=Zn8KTykWITTxrt8cB/0XW13Tk0Vsynlb8qQEdiKlv9cMxyX6kCpt9fds1cU1wWlY3x
         CIOs0ArjXHooy+gaAKDTaIgNpdFPzMmY1iNCN7lfAWEW5hN0mWFyC7XRr2pNp7NBCWFy
         7S3gghj4IYNm4PCatZnIQq3hMoMlEm1vh59j9NbD/wDdb0vhVU5rhuRJlXQ3baZBhuBG
         udSED4Nz/SS+4dDsL7t43mPH91tYcCTnCM8uzDOkO0EDT33QbDORjX4JR7jXq1YtMRov
         PZ8xsl3lncTdxcjUSSl/XYo3RO3LdfXpCw9zzi+DJ73E1kFxfacNoGiDZ0XzAWZBnUKK
         Emgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770678648; x=1771283448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bij18CszkpfwqsgQB87yfzBXxL8pB3K2t0j3obIGt04=;
        b=Ug8yFs8z0YlsAHbgum6fJvQmfVpKDhA6yuV6k0HaUe7EP3aPEtmZlYWOUpLtvufY1a
         yfYbE9wihG0cvetfN+fWot98PShoEcK/BvJk8mKpc+lV34kNkSe5XHQTn7QJjLSBaX4E
         O09dq4H5lpqTdgf9UZhC8oNUWXq4bMapwhPFOHVljsVX58b/K0Igbe/gaBMGJ+layp2a
         n9C18ctMjpXYeYBIPY9Yrj9ptkKKKj59ASj4TUjcOEi30bCmOHhzTYYZWyTx2I6d27VB
         qZHe85FY8ugiKrr+zMTjBCuu6OZNZmChxUraLVowUxgM2lg2Z8Rs6plNeUnMI4Hq2XRr
         4Jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770678648; x=1771283448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bij18CszkpfwqsgQB87yfzBXxL8pB3K2t0j3obIGt04=;
        b=jtkPhFvG1QrZT9dk1mOZ+6oAx/XadheywGEsPH6TsY6KknUPZqjU9lXm0t3ARMXTLC
         9oD0efIbIKjqyj6T984ExgjWnT37qYTxIVfoWhc8IYiSzm4A2fXN3gDK4lWkK03nUNss
         Y3ntGCGCgF6ydgT8GBII7A5lFFs2uShVzTadvIY2Eeu3ibvJyp4oYJAmt453BWlRv2Av
         NsEghiMGzj6kFawp2r2RSyYfvy1z/gYQS6i8HAv84ddka9PZm7Uddm5BV4cYHkO184+D
         J1vrIXrz1K4Z7hwG1itZXRLsn7vRynQRO+2Cz44lbHh4+vEtzu9ddbVDVFFlnF+kw2Sy
         wYow==
X-Forwarded-Encrypted: i=1; AJvYcCXslCPgtgeOf/H+WgCQoYCi8GZxuR2qfcoz7T97k+W74agNfB2hqveNpnPjAn2Si6rcMDsnGMqbaLaTyCYSmO1Q@vger.kernel.org
X-Gm-Message-State: AOJu0YyxLC/yR4va2lZfiNMiKmb3heaoTn3267P5+Vbi0gnIOE9+4eOl
	k5+N3X5NIryzX3/hyv/jEBcuRlA0J0lAx/Yabq82LLj70Zbiz2V3uyeU0UNzgoYcrOq/AAqAYf3
	E/uxl8EHET4DHHJJyFFOFxN1aywfITkoTeMSEplAq
X-Gm-Gg: AZuq6aIFVRPEXnMfVI+yqv4b9428eFXnAjOT7+vMQwGiU6HCGSZUSxdO/KzN40M+Goy
	1L3U1QnpTbUsNQGrODu7t8iDDLfk93UDEOHgZBjfhQLsUBw5rn1ve1lfCSsjQjbdp9B4+QcCFlH
	yvnonxRBX6mmHtef1RQV9SOt6V0f0bDIBudEbXY8eIqW6ldkc9D70P16iVWA4QLzzs68MzZUINe
	vkb2E5iJ3Y425a/g+CsfI5xx1YvlZV4bM+SO5Pwf4kudlLxMKR7hZnWnH75TcdkvliTPNRdT7Ad
	hW2/R8gC0LU8CjvO4DQVcA7Rfg+HZFohMJ5k
X-Received: by 2002:a17:903:3510:b0:2a7:5652:50b2 with SMTP id
 d9443c01a7336-2ab100b1a6amr407625ad.9.1770678647491; Mon, 09 Feb 2026
 15:10:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aYZnkYqWXnKpHd3h@x1> <20260206222509.982489-1-irogers@google.com> <20260206222509.982489-2-irogers@google.com>
In-Reply-To: <20260206222509.982489-2-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Feb 2026 15:10:36 -0800
X-Gm-Features: AZwV_Qh4ha3I8xiqkrms6frmo8dIFQ_WDt6TJAPS93rJsSm_98a3pZ7cM36EiRs
Message-ID: <CAP-5=fWNygdxXtiuZyoKcWU7cJ5K9Ad8dZ1ABXC+qkBrsfqZYg@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] Revert "perf tool_pmu: More accurately set the
 cpus for tool events"
To: acme@kernel.org
Cc: adrian.hunter@intel.com, ak@linux.intel.com, 
	alexander.shishkin@linux.intel.com, andres@anarazel.de, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, namhyung@kernel.org, 
	peterz@infradead.org, thomas.falcon@intel.com, tmricht@linux.ibm.com, 
	yang.lee@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 2:25=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> This reverts commit d8d8a0b3603a9a8fa207cf9e4f292e81dc5d1008.
>
> The setting of a user CPU map can cause an empty intersection when
> combined with CPU 0 and the event removed. This later triggers a segv
> in the stat-shadow logic. Let's put back a full online CPU map for now
> by reverting this patch.
>
> Reported-by: Andres Freund <andres@anarazel.de>
> Closes: https://lore.kernel.org/linux-perf-users/cgja46br2smmznxs7kbeabs6=
zgv3b4olfqgh2fdp5mxk2yom4v@w6jjgov6hdi6/
> Signed-off-by: Ian Rogers <irogers@google.com>

The additional stat test coverage in:
https://lore.kernel.org/lkml/aYUO0_ccQG2AnZ3V@x1/
has been merged, but without this revert the test is segfaulting.

Thanks,
Ian

> ---
>  tools/perf/util/parse-events.c |  9 ++-------
>  tools/perf/util/tool_pmu.c     | 19 -------------------
>  tools/perf/util/tool_pmu.h     |  1 -
>  3 files changed, 2 insertions(+), 27 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index d4647ded340f..f631bf7a919f 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -30,7 +30,6 @@
>  #include "util/event.h"
>  #include "util/bpf-filter.h"
>  #include "util/stat.h"
> -#include "util/tool_pmu.h"
>  #include "util/util.h"
>  #include "tracepoint.h"
>  #include <api/fs/tracing_path.h>
> @@ -230,12 +229,8 @@ __add_event(struct list_head *list, int *idx,
>         if (pmu) {
>                 is_pmu_core =3D pmu->is_core;
>                 pmu_cpus =3D perf_cpu_map__get(pmu->cpus);
> -               if (perf_cpu_map__is_empty(pmu_cpus)) {
> -                       if (perf_pmu__is_tool(pmu))
> -                               pmu_cpus =3D tool_pmu__cpus(attr);
> -                       else
> -                               pmu_cpus =3D cpu_map__online();
> -               }
> +               if (perf_cpu_map__is_empty(pmu_cpus))
> +                       pmu_cpus =3D cpu_map__online();
>         } else {
>                 is_pmu_core =3D (attr->type =3D=3D PERF_TYPE_HARDWARE ||
>                                attr->type =3D=3D PERF_TYPE_HW_CACHE);
> diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
> index 37c4eae0bef1..6a9df3dc0e07 100644
> --- a/tools/perf/util/tool_pmu.c
> +++ b/tools/perf/util/tool_pmu.c
> @@ -2,7 +2,6 @@
>  #include "cgroup.h"
>  #include "counts.h"
>  #include "cputopo.h"
> -#include "debug.h"
>  #include "evsel.h"
>  #include "pmu.h"
>  #include "print-events.h"
> @@ -14,7 +13,6 @@
>  #include <api/fs/fs.h>
>  #include <api/io.h>
>  #include <internal/threadmap.h>
> -#include <perf/cpumap.h>
>  #include <perf/threadmap.h>
>  #include <fcntl.h>
>  #include <strings.h>
> @@ -111,23 +109,6 @@ const char *evsel__tool_pmu_event_name(const struct =
evsel *evsel)
>         return tool_pmu__event_to_str(evsel->core.attr.config);
>  }
>
> -struct perf_cpu_map *tool_pmu__cpus(struct perf_event_attr *attr)
> -{
> -       static struct perf_cpu_map *cpu0_map;
> -       enum tool_pmu_event event =3D (enum tool_pmu_event)attr->config;
> -
> -       if (event <=3D TOOL_PMU__EVENT_NONE || event >=3D TOOL_PMU__EVENT=
_MAX) {
> -               pr_err("Invalid tool PMU event config %llx\n", attr->conf=
ig);
> -               return NULL;
> -       }
> -       if (event =3D=3D TOOL_PMU__EVENT_USER_TIME || event =3D=3D TOOL_P=
MU__EVENT_SYSTEM_TIME)
> -               return cpu_map__online();
> -
> -       if (!cpu0_map)
> -               cpu0_map =3D perf_cpu_map__new_int(0);
> -       return perf_cpu_map__get(cpu0_map);
> -}
> -
>  static bool read_until_char(struct io *io, char e)
>  {
>         int c;
> diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
> index ea343d1983d3..f1714001bc1d 100644
> --- a/tools/perf/util/tool_pmu.h
> +++ b/tools/perf/util/tool_pmu.h
> @@ -46,7 +46,6 @@ bool tool_pmu__read_event(enum tool_pmu_event ev,
>  u64 tool_pmu__cpu_slots_per_cycle(void);
>
>  bool perf_pmu__is_tool(const struct perf_pmu *pmu);
> -struct perf_cpu_map *tool_pmu__cpus(struct perf_event_attr *attr);
>
>  bool evsel__is_tool(const struct evsel *evsel);
>  enum tool_pmu_event evsel__tool_event(const struct evsel *evsel);
> --
> 2.53.0.rc2.204.g2597b5adb4-goog
>
