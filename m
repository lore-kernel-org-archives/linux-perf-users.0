Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC52EC146
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Oct 2023 05:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B399AD41;
	Thu, 19 Oct 2023 22:59:37 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-27db9fdec16so415131a91.2;
        Thu, 19 Oct 2023 22:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697781577; x=1698386377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QW6mQLWJHq+LWYoj7TKuXQ4crGYlNNS1CC7z5LwBXk=;
        b=MXU2UDaUYQBFyDXhnZddGiK6P/oYzprSYY0cu2RuYNUx2OTDSgjTFvLVWY59SZmIqn
         VzqEdJToMaHKUWjAapPd8uzPHHFSPYBFgsziWtHecf7YBGI90UuqOM86HHxHSk2T0PVK
         YpOqwjvcAv1ok/T4xSPi1QGhIFIFEgb4UF2KKP1sidSIGty491+hg7Gh+8+l2zNSWmPB
         fYUo8XXZvdhTLMNB4AIG8mbLhnhcGnX9pUDbqZspKoA6ZJPQjP6aH9rpkoAo1zxix8W+
         WlBtolNCxct3CIdim3TFaa2w2qjW+9LlmatZdZpGJPLUrenpzUQYKCpE5pVUDAmdE9Sd
         yvwA==
X-Gm-Message-State: AOJu0YxX/X9y2cENxmuHaeSTvQj79rjE+Rum43K7CkUZLcsMUrSZIqiU
	gAOmyLNkxwGtK1+GvtKm2q/dRY+uKGdbF8wsXWwyLaq+
X-Google-Smtp-Source: AGHT+IHRb8Satm905s+fXR/c4OKst8S/LE0P0ERSVLN5jX2GTCjD8MLNa9Fr20z5+3hJflEycocXuJTksjHsTyfMv+A=
X-Received: by 2002:a17:90a:19c5:b0:27c:eb7f:cd00 with SMTP id
 5-20020a17090a19c500b0027ceb7fcd00mr891990pjj.22.1697781577025; Thu, 19 Oct
 2023 22:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231013075945.698874-1-yangjihong1@huawei.com>
In-Reply-To: <20231013075945.698874-1-yangjihong1@huawei.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 19 Oct 2023 22:59:25 -0700
Message-ID: <CAM9d7cjQ_ZT2wdvFO8v2f8cN+GGH0nLOa=Fvzf4okAr8b27t_w@mail.gmail.com>
Subject: Re: [PATCH] perf data: Increase RLIMIT_NOFILE limit when open too
 many files in perf_data__create_dir()
To: Yang Jihong <yangjihong1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Oct 13, 2023 at 1:01=E2=80=AFAM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> If using parallel threads to collect data, perf record needs at least 6 f=
ds
> per CPU. (one for sys_perf_event_open, four for pipe msg and ack of the
> pipe, see record__thread_data_open_pipes(), and one for open perf.data.XX=
X)

Yep, probably one more for the dummy event.

> For an environment with more than 100 cores, if perf record uses both
> `-a` and `--threads` options, it is easy to exceed the upper limit of the
> file descriptor number, when we run out of them try to increase the limit=
s.
>
> Before:
>   $ ulimit -n
>   1024
>   $ lscpu | grep 'On-line CPU(s)'
>   On-line CPU(s) list:                0-159
>   $ perf record --threads -a sleep 1
>   Failed to create data directory: Too many open files
>
> After:
>   $ ulimit -n
>   1024
>   $ lscpu | grep 'On-line CPU(s)'
>   On-line CPU(s) list:                0-159
>   $ perf record --threads -a sleep 1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.394 MB perf.data (1576 samples) ]
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/util/data.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index fc16299c915f..098f9e3bb2e7 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -17,6 +17,7 @@
>  #include "util.h" // rm_rf_perf_data()
>  #include "debug.h"
>  #include "header.h"
> +#include "evsel.h"
>  #include <internal/lib.h>
>
>  static void close_dir(struct perf_data_file *files, int nr)
> @@ -35,6 +36,7 @@ void perf_data__close_dir(struct perf_data *data)
>
>  int perf_data__create_dir(struct perf_data *data, int nr)
>  {
> +       enum rlimit_action set_rlimit =3D NO_CHANGE;
>         struct perf_data_file *files =3D NULL;
>         int i, ret;
>
> @@ -54,11 +56,21 @@ int perf_data__create_dir(struct perf_data *data, int=
 nr)
>                         goto out_err;
>                 }
>
> +retry_open:
>                 ret =3D open(file->path, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|=
S_IWUSR);
>                 if (ret < 0) {
> +                       /*
> +                        * If using parallel threads to collect data,
> +                        * perf record needs at least 6 fds per CPU.
> +                        * When we run out of them try to increase the li=
mits.
> +                        */
> +                       if (errno =3D=3D EMFILE && evsel__increase_rlimit=
(&set_rlimit))

It seems weird that we have this helper with evsel prefix and
it does nothing with evsel.  But it's a separate concern, so

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> +                               goto retry_open;
> +
>                         ret =3D -errno;
>                         goto out_err;
>                 }
> +               set_rlimit =3D NO_CHANGE;
>
>                 file->fd =3D ret;
>         }
> --
> 2.34.1
>
