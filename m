Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1880029;
	Fri, 31 May 2024 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717137667; cv=none; b=nv1I5yD3cSNxOA/Ix4McOmiclMKYsv8u70HJLKadqG+KmFlNFcbX8xIRvqocV3WV1c5ciuB0F+EFEzzuV8jH66s9MX0mlkJFgIuEa6ewwwFGzNGU4No4vmDJVRLqxqMztPwOuKxKV+qJOTy73IiL01/h5xtP9ZWgdItFYc1/uD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717137667; c=relaxed/simple;
	bh=/5AGhiPMoa8DA8+zCe5zB0MSwuL/3VLYSz1ac+hrezU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1y4ebeTRU23R1+rmHcLbL9upvcDH9GNJZGVa2H82VFdb1JUFfW1qxyfO1jNtt2a7V49uDjG9ffJ0W6I5ONfmmbeItLMOOBrG/e/9tLsKOo4E3pu2fqSmqymFgaZ3fzlY/l2nCpPXV+MlM94Q5na63/gZctparWviR8I4/2z4c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c195eb9af3so1253856a91.0;
        Thu, 30 May 2024 23:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717137665; x=1717742465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mu69OOs2tyNIzS9vQN8Sal9br//O/qQ7WPAbi99juhc=;
        b=UvIH/4geRpuftQrwg/Igm6Q+WjM47UD+muw5eun2Xo5zlSbAeCtvAQnpf8inCgbP2y
         CJGlyWUmpcIehNLmhgyzyVpn0rco3l7VczAhFu9lILLxqocVhP7OXjpFuB9Nyn4L6UgE
         FivYW6NH/MkIEKIglacm3GP2TAvn3aIiThThKF1cF1aASeccC8pgw3nm7weJS/3cNOwm
         spTAnqQF1X7VuW9H4A5oWtZDeJvs5TZFOI0ZjnyJPWvu7BUZW2VFu3BeW3KEL0AkezTs
         p9IqZpcoVOlP4pVvCqd0yLBL03NPM+oJSKyOfx4vALA84ZE26RPb/U4hhshbAVpWPrfg
         aa2w==
X-Forwarded-Encrypted: i=1; AJvYcCWTD+WxaqJod1XlXMG9y8LsqGRT0OSpb6rT9M2z1O/GO09LbShvkAque22fjOCeXZ3oBhhnVv8n6G+072o9ExA9lQfbVV0bxbPvWGL5hwSSTznSfqo7lCDI+HFAfAaIt9Hok9S02EuZSiID8EsTRA==
X-Gm-Message-State: AOJu0Yw+u6W4ydzNPcCftj56Qjtzb/bWBFUGD3YHqs5hHDOKTGUyb3ge
	imH/pFk/yWe5+6uXAk9UQLikoifxfJK467NrI/+Fjya9pOMy2wREV6C2H8rs/EvPTlICpz0Ulky
	JuiWVK8yQSrjKTMuKOCeL+Ht6MUdjAw==
X-Google-Smtp-Source: AGHT+IEe+YhiyZoms6cTBOquHOL4MEQEpIxUTDw0tM2ObcqeullQwzmFFiEuu/7si8pb3Y1JcnG22qLFVk31XiWGY6o=
X-Received: by 2002:a17:90a:8582:b0:2bd:e936:b28 with SMTP id
 98e67ed59e1d1-2c1dc583606mr932720a91.20.1717137665113; Thu, 30 May 2024
 23:41:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529064327.4080674-1-weilin.wang@intel.com> <20240529064327.4080674-4-weilin.wang@intel.com>
In-Reply-To: <20240529064327.4080674-4-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 30 May 2024 23:40:53 -0700
Message-ID: <CAM9d7cgSwZ3PU3H9VNvxQakocEZ_CQEqB9M1o3xTMdJ7F1sufQ@mail.gmail.com>
Subject: Re: [RFC PATCH v10 3/8] perf stat: Fork and launch perf record when
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

On Tue, May 28, 2024 at 11:43=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> When retire_latency value is used in a metric formula, evsel would fork a=
 perf
> record process with "-e" and "-W" options. Perf record will collect requi=
red
> retire_latency values in parallel while perf stat is collecting counting =
values.
>
> At the point of time that perf stat stops counting, evsel would stop perf=
 record
> by sending sigterm signal to perf record process. Sampled data will be pr=
ocess
> to get retire latency value.
>
> Another thread is required to synchronize between perf stat and perf reco=
rd
> when we pass data through pipe.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
[SNIP]
> +int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread)
> +{
> +       struct perf_counts_values *count;
> +       struct tpebs_retire_lat *t;
> +       bool found =3D false;
> +       __u64 val;
> +       int ret;
> +
> +       /* Non reitre_latency evsel should never enter this function. */
> +       if (!evsel__is_retire_lat(evsel))
> +               return -1;
> +
> +       ret =3D tpebs_stop();
> +       if (ret)
> +               return ret;
> +
> +       count =3D perf_counts(evsel->counts, cpu_map_idx, thread);
> +
> +       list_for_each_entry(t, &tpebs_results, nd) {
> +               if (!strcmp(t->tpebs_name, evsel->name) || !strcmp(t->tpe=
bs_name, evsel->metric_id)) {
> +                       found =3D true;
> +                       break;
> +               }
> +       }
> +
> +       /* Set ena and run to non-zero */
> +       count->ena =3D count->run =3D 1;
> +       count->lost =3D 0;
> +
> +       if (!found) {
> +               /*
> +                * Set default value or 0 when retire_latency for this ev=
ent is
> +                * not found from sampling data (enable_tpebs_recording n=
ot set
> +                * or 0 sample recorded).
> +                */
> +               val =3D 0;
> +               return 0;
> +       }
> +
> +       /*
> +        * Only set retire_latency value to the first CPU and thread.
> +        */
> +       if (cpu_map_idx =3D=3D 0 && thread =3D=3D 0) {
> +       /* Lost precision when casting from double to __u64. Any improvem=
ent? */

As I said before I think you can set t->val * 1000 and then
set the evsel->scale to 1e3 or 1e-3.

Thanks,
Namhyung


> +               val =3D t->val;
> +       } else
> +               val =3D 0;
> +
> +       count->val =3D val;
> +       return 0;
> +}
> +
