Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rppBubB+"
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E939AAD
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Dec 2023 16:02:50 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50d11bd3144so1439e87.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Dec 2023 16:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702339369; x=1702944169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCwQNpqZrXvaI88937wdWL6JeEYRSB0xftnhNA8w9QY=;
        b=rppBubB+vlXIEBJ/2FSZ6guPqgsw/qF/wohWUFDkAFMDRVvam5Y5CDyY9n6H6LaC+K
         gln4lgDa5S1vPDVtb+FBTGK1xEfceR6v2TkgEOtxFmsRvz+bjQfOTvXzdfe/s/3fJqVt
         nBTjuX4Q03GD8gimwR3flcox1Ckm2Eiqdh7RBtchmFlRZTizHprOrf/VmXWCbxzAgpXj
         y0skzmS4Hh2NhQm5DuYS7FtFDqwRCIcfiEoRNgjvKvdqgXKh8CqyqieZdyex8m4zF8Yr
         F7jv0B6WzJIduZU7smQbz56gxFGD/XbcjSTz2hTrdO+X7ceWTzBTO02ZASSgwv8NGJxh
         rKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702339369; x=1702944169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCwQNpqZrXvaI88937wdWL6JeEYRSB0xftnhNA8w9QY=;
        b=YBpMfUXyVRR+BRLC1LX79sP0wsFYNgwY+R3CVpyUDW3ReCnH5wQcFGTlB/WWjigUT4
         L9/mQdEBr7W+YPouAdKBTbvjLm3KtBRcAHKQN7/ZM80nQUooXUF9PI+Z/jSIumgSGFSr
         Gn+VDR8eHyffHBbK4JGrT8530OukU7iBR2N89ydeUha1BpE8T+zK02DH1owgoCXKFDnG
         P8PO3yxxBxgs0xFv0xoCdZOe+42AlLhQLRlqJPZ/Z9fC8QnesjRto/PyqcdAawxpSqjd
         Zh92T+zTExoZNqBDp2583wB28j9gHs8oARTGrUusGPSAl3KTO+5lfTSD5N707PJtclxb
         VNTA==
X-Gm-Message-State: AOJu0Yx7uw+J5R9ZIPJWn1vE0azsQ4mCldCYy2XgxCXNw1s38PenfJKQ
	PnP5XHayJpU4XIKD3EdVA4waSAwuKjigO8cdHyn/6g==
X-Google-Smtp-Source: AGHT+IEFPi/YPXkyOUwUvNngrnFwm/fy1efsJXMtqz89IJ4IFpU1HMqaGwOahPUhLCrAmspv2/LYPzyvqtjpieaeNbY=
X-Received: by 2002:a05:6512:539:b0:50c:e19:b658 with SMTP id
 o25-20020a056512053900b0050c0e19b658mr220203lfc.1.1702339368975; Mon, 11 Dec
 2023 16:02:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
In-Reply-To: <20231208210855.407580-1-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Dec 2023 16:02:37 -0800
Message-ID: <CAP-5=fWmy7+iNRpMAZ_So0ki8oOD_4RSn9Mx+gGroWZH6_7Sdw@mail.gmail.com>
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, maz@kernel.org, 
	marcan@marcan.st, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 1:09=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> perf top errors out on a hybrid machine
>  $perf top
>
>  Error:
>  The cycles:P event is not supported.
>
> The user_requested_cpus may contain CPUs that are invalid for a hybrid
> PMU. It causes perf_event_open to fail.
>
> The commit ef91871c960e ("perf evlist: Propagate user CPU maps
> intersecting core PMU maps") already intersect the requested CPU map
> with the CPU map of the PMU. Use the evsel's cpus to replace
> user_requested_cpus.
>
> The evlist's threads is also propagated to evsel's threads in
> __perf_evlist__propagate_maps(). Replace it as well.
>
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/linux-perf-users/ZXNnDrGKXbEELMXV@kernel.=
org/
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Sorry I missed top doing the evlist__create_maps calls:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/builtin-top.c?h=3Dperf-tools-next#n1761
so it is right that the only divergence from record:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/builtin-record.c?h=3Dperf-tools-next#n1362
and stat:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/stat.c?h=3Dperf-tools-next#n797
So this is the right fix I believe.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-top.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index ea8c7eca5eee..cce9350177e2 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1027,8 +1027,8 @@ static int perf_top__start_counters(struct perf_top=
 *top)
>
>         evlist__for_each_entry(evlist, counter) {
>  try_again:
> -               if (evsel__open(counter, top->evlist->core.user_requested=
_cpus,
> -                                    top->evlist->core.threads) < 0) {
> +               if (evsel__open(counter, counter->core.cpus,
> +                               counter->core.threads) < 0) {
>
>                         /*
>                          * Specially handle overwrite fall back.
> --
> 2.35.1
>
