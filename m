Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76F141981;
	Fri, 17 May 2024 21:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715982202; cv=none; b=A+bmXojuvDdj+jimSiQjYgzETBUY5Z1XkqcBMEkEeeeAmmkgFRyIndbeX6aZ3Uu7xkt/L2NpbJ0RvV4n0JZjFRIqBsQt2WZkwUuMnwV0sqjFY/O/3Nlu9KAo8yy4Uv2c/EPePd5krMTB5dw7Qi52HHkXu3IN/aBGSjUcKWy+nDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715982202; c=relaxed/simple;
	bh=TOQR4C7aJOSef0guoBb210jKTjOGMJ9RgirLaoUIQwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czATfmRl9a/pCEr3VfUbNxA+LxKoM5dtIKbuNX/hLdZ/PHJ7TdFyygy4c1xtoYyJ4C76vEKX4LWydoereW261vcF92QWTcjMzdWapAAIWA1G6rMt5G39Zx/W7FDLAia0+/7XyMAGmMxSpOo9NaB2cm/A4bzoWbq39N5buObfJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ec4dc64c6cso21410845ad.0;
        Fri, 17 May 2024 14:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715982200; x=1716587000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDCtfy/Bp0EaDflNWvcEH2uJMngajJPoBsVPh87Br9Q=;
        b=HzQvNswhF1bv6klLwyhfaLWgirrAMQiQauH3egU3WLlj3DfNLYd4x01k6zihV6rekp
         24dDhKbF9TmPxOH0K0wEC316cHeXNd9FKtyqTGpa3m4/8MVAQWNVyDVwxxluBrOzWDkS
         +RwQs2FFOeSrpJ1Lcu4eIi3VoOJynknfr5QGIubrjnbG62/cpARdMcted1HghMn8jXvr
         p//YoYbzuSGVn9paVXrnv46JvbHZePglb9O6Djb9h2k+7RzdYKFz1NgVRHC2yb7XKeMD
         68aNAUf9gT1H9cPvlm1M+GK4gU5g1irOiOLZRd0/8hs/EHtwq4MZnHofKNwcjU6E7F4P
         nxzw==
X-Forwarded-Encrypted: i=1; AJvYcCUeAejqh+zZaGa0y3ObhKt/69Xsg5VMEZLF8AgX2J8Y8A/+oMsTaTf57ahCuocNMxnvPlUyIFq0Yw03dmVycJvA/94eGkClCd8l5x5HatoYxoCtVuRqRzFedROqIJMM/ueYdWe6PIPOGUpKnUKq7Q==
X-Gm-Message-State: AOJu0YyQl1dVmsyfuwbpzOcSmvMcl/C+VfTvKMv7N3zN/XrsPBnPfN+F
	Ky+s12jJFEU1O25vuyWM8yTv7M60wguJgOyxpri2PAKCH3K3v1aAEnVmcP//wBWbTHhNwWUBoCt
	iCMTtBBxfZwdPAAHXZb3dM53NVSk=
X-Google-Smtp-Source: AGHT+IFQzzj4MbTJHZyEjTtikdclQUIr7f3DIllHHceH0poyK3GrBfzAJAsMWeu441s5luETSgaxE9psrCVaiUTHS2U=
X-Received: by 2002:a17:903:1d2:b0:1eb:2ee2:43bd with SMTP id
 d9443c01a7336-1ef43d0acc1mr286452235ad.7.1715982200271; Fri, 17 May 2024
 14:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515054443.2824147-1-weilin.wang@intel.com> <20240515054443.2824147-4-weilin.wang@intel.com>
In-Reply-To: <20240515054443.2824147-4-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 17 May 2024 14:43:08 -0700
Message-ID: <CAM9d7cghtG-9rwy5Yg-oJDETO-J5OUzPt6=xMCwacKqfwo+sZA@mail.gmail.com>
Subject: Re: [RFC PATCH v8 3/7] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 10:44=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> When retire_latency value is used in a metric formula, perf stat would fo=
rk a
> perf record process with "-e" and "-W" options. Perf record will collect
> required retire_latency values in parallel while perf stat is collecting
> counting values.
>
> At the point of time that perf stat stops counting, it would send sigterm=
 signal
> to perf record process and receiving sampling data back from perf record =
from a
> pipe. Perf stat will then process the received data to get retire latency=
 data
> and calculate metric result.
>
> Another thread is required to synchronize between perf stat and perf reco=
rd
> when we pass data through pipe.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> ---
[SNIP]
> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.=
c
> new file mode 100644
> index 000000000000..4b7a98794fae
> --- /dev/null
> +++ b/tools/perf/util/intel-tpebs.c
> @@ -0,0 +1,285 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * intel_pt.c: Intel Processor Trace support
> + * Copyright (c) 2013-2015, Intel Corporation.

This needs some updates. :)


> + */
> +
> +
> +#include <sys/param.h>
> +#include <subcmd/run-command.h>
> +#include <thread.h>
> +#include "intel-tpebs.h"
> +#include <linux/list.h>
> +#include <linux/zalloc.h>
> +#include <linux/err.h>
> +#include "sample.h"
> +#include "debug.h"
> +#include "evlist.h"
> +#include "evsel.h"
> +#include "session.h"
> +#include "tool.h"
> +#include "metricgroup.h"
> +#include <sys/stat.h>
> +#include <sys/file.h>
> +
> +
> +
> +#define PERF_DATA              "-"
> +#define CONTROL                        "/tmp/control"
> +#define ACK                    "/tmp/ack"
> +pthread_t reader_thread;
> +struct child_process *cmd;
> +struct perf_stat_config *stat_config;

static ?

> +
> +static int get_perf_record_args(const char **record_argv)
> +{
> +       int i =3D 0;
> +       struct tpebs_retire_lat *e;
> +
> +       pr_debug("Prepare perf record for retire_latency\n");
> +
> +       record_argv[i++] =3D "perf";
> +       record_argv[i++] =3D "record";
> +       record_argv[i++] =3D "-W";
> +       record_argv[i++] =3D "--synth=3Dno";

Unfortunately this still synthesizes MMAP records for the kernel
and modules.  As we don't care about them and just want to
minimize the overhead at the beginning, we can add
"--tail-synthesize" too.


> +       record_argv[i++] =3D "--control=3Dfifo:/tmp/control,/tmp/ack";

This hard-coded path won't work well when more than one users
want to run the perf command at the same time.

Thanks,
Namhyung

> +
> +       if (stat_config->user_requested_cpu_list) {
> +               record_argv[i++] =3D "-C";
> +               record_argv[i++] =3D stat_config->user_requested_cpu_list=
;
> +       }
> +
> +       if (stat_config->system_wide)
> +               record_argv[i++] =3D "-a";
> +
> +       if (!stat_config->system_wide && !stat_config->user_requested_cpu=
_list) {
> +               pr_err("Require -a or -C option to run sampling.\n");
> +               return -ECANCELED;
> +       }
> +
> +       list_for_each_entry(e, &stat_config->tpebs_results, nd) {
> +               record_argv[i++] =3D "-e";
> +               record_argv[i++] =3D e->name;
> +       }
> +
> +       record_argv[i++] =3D "-o";
> +       record_argv[i++] =3D PERF_DATA;
> +
> +       return 0;
> +}
> +
>
