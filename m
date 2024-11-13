Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6832716FF5F
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731517420; cv=none; b=bSS0hajpvCq7kIrwxd875SXk08mPOD/cyw/FswIuzeMIRvMwhlUSkMoDdm8dY6+QT/pgIoKoUbq41sWI8n9i0z2P9H2uVl+9Hc4g8YUY5imD30JO4usmYnQyw57oqZM5Y5fakgbMpTTLLyDHsH8d0QbmfjPdxRQ4lVVZsEbuQLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731517420; c=relaxed/simple;
	bh=OlzrsPB5XUVoPdY5ssfM2l467Cry902eTgjhS9HpyC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoVDAa9WfQqE6lxBnGP4HQ4JN8h5FSC/c6CnaNcgYsh11lRsREYvjM0Dd+YCuhg0Z5T7xKZm0bjT5dTgsjwuWKMFylq2vvOQAt03NJ4Zu6/2DoY3TblSe2YU881k9PbNgnG0lh5tB2ydKdDlEtg41+lEj4x4bUHrQv3tv77Bhf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kTxSIWbY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kTxSIWbY"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ca03687fdso212105ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 09:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731517419; x=1732122219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3wYcPiFXtftpRGxF/6Zf/umDLx3ClZ8Ekl/dsjeYmQ=;
        b=kTxSIWbY5ozNhZ8YLwoG7jV0TF5Fak1IPI5T8ROcfLcqf4F5jGjlUAw41R+a+25sUu
         hcoxOq+BV1o4+i2alpgLjBeY9E+UrCfmfEvuQFQlxFDlcAV5iAxdDDtk3AfiJgsnUkAJ
         1viiYzN0g80nhIKtlHcAO4SHoOzJ+jeT626eCaqNVPWAQ3ZUZmxSW+z2dlfGH/hpMCt1
         vCz8p2yFv/XLrrTW9rm/i+piIOH0DkNktkT1j1BjPsfsYKvPY+FM8aOAz3v1D0Uo/MLn
         VL5cOOQUwyDNvs2xEMCc/H4lxh4+Kedp9JH/ataVFWdPjVJmJPQDKTNqZhhsqw5xpFaz
         0eRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731517419; x=1732122219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3wYcPiFXtftpRGxF/6Zf/umDLx3ClZ8Ekl/dsjeYmQ=;
        b=oljG3I0Q5EW+1/45ORjfjMRkhej9iqxP0mk3b8ljoo32wav/JgaoHxTpsGjormEnY3
         dUzCpNHyHXsIjEOlAwetY2avYP4FVXQTu0H7VpqLJhrozCAf+d0nJwLVSgVQHHkuab3U
         norz+95qTn4OunnKMA/cMxC9G1Nr/ZlDN5qoN+lTKM7xKyagbxYTD4Em8jYd9jz2NJ+j
         152HPa+zFKu7jp4YLIoVdjlh3OTjH2ViweAIrx003NE9SRcWdxCflyLFvSBihtpjI34/
         wiI2uE9jjPNY4iP8hvKtwoXXOdtQBijvKNEtWGWx+zNSu8tMzT+J6yKmIEoX1AQyH5gI
         CwsA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ4jXnSN+taxB4JuqWcXCHnsl0t6WF7hGGbzfqStnv0Egh22+pcH8lNiVJfvi6lDzqIwU8MSwogMde/M/JF2Ml@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0NPMvSpwks13Bzhq5POy1Z2EhCzZ8UtUkZi8VjkrH4biTo3xc
	7DuwItMJlBeXp9qmILUZIAOKCtgUhCTSDtUo+cU3o6QtVfUGMHIu2fgaLyLFyYM9DxPhgRAhCkL
	Z7nup2549BZDYjetM/dRIV/ejTaQdEArCzZ5t
X-Gm-Gg: ASbGnctMO1+40e30dUakoldqA4VjkHRkXBHs/b9+GIvYbe3+kskaZA7zp7aIHNr/Cud
	ARsAYpgpiXj9yxQULzgvzessqkPjf8SDXiZsrE/42o4b2W2Yl6Noj6mppF+X8Fg==
X-Google-Smtp-Source: AGHT+IHZ1dDlMsr6QQHILrv6ztAYxxRD5ko2gvdn7UqEsuvtnR6ku5j9xZxhm6G/igNtDYCuWusICqVWF7QhmfutHNQ=
X-Received: by 2002:a17:903:2449:b0:20b:81bb:4a81 with SMTP id
 d9443c01a7336-211b70725d1mr2524865ad.7.1731517417070; Wed, 13 Nov 2024
 09:03:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113002818.3578645-1-howardchu95@gmail.com> <20241113002818.3578645-5-howardchu95@gmail.com>
In-Reply-To: <20241113002818.3578645-5-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 Nov 2024 09:03:25 -0800
Message-ID: <CAP-5=fXPCgXyp3w478M9UrqVmneg1mvsabSJb55R+-xPYaUFuw@mail.gmail.com>
Subject: Re: [PATCH v8 04/10] perf record --off-cpu: Preparation of off-cpu
 BPF program
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, peterz@infradead.org, namhyung@kernel.org, 
	mingo@redhat.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Mark Rutland <mark.rutland@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 4:28=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Set the perf_event map in BPF for dumping off-cpu samples.
>
> Set the offcpu_thresh to specify the threshold.
>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20241108204137.2444151-5-howardchu95@gmai=
l.com
> [ Added some missing iteration variables to off_cpu_config() and fixed up
>   a manually edited patch hunk line boundary line ]
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/bpf_off_cpu.c          | 25 +++++++++++++++++++++++++
>  tools/perf/util/bpf_skel/off_cpu.bpf.c | 11 +++++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.=
c
> index 558c5e5c2dc3..61729a65b529 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -13,6 +13,7 @@
>  #include "util/cgroup.h"
>  #include "util/strlist.h"
>  #include <bpf/bpf.h>
> +#include <internal/xyarray.h>
>
>  #include "bpf_skel/off_cpu.skel.h"
>
> @@ -60,6 +61,9 @@ static int off_cpu_config(struct evlist *evlist)
>  static void off_cpu_start(void *arg)
>  {
>         struct evlist *evlist =3D arg;
> +       struct evsel *evsel;
> +       struct perf_cpu pcpu;
> +       int i;
>
>         /* update task filter for the given workload */
>         if (skel->rodata->has_task && skel->rodata->uses_tgid &&
> @@ -73,6 +77,25 @@ static void off_cpu_start(void *arg)
>                 bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
>         }
>
> +       /* update BPF perf_event map */
> +       evsel =3D evlist__find_evsel_by_str(evlist, OFFCPU_EVENT);
> +       if (evsel =3D=3D NULL) {
> +               pr_err("%s evsel not found\n", OFFCPU_EVENT);
> +               return;
> +       }
> +
> +       perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
> +               int err;
> +
> +               err =3D bpf_map__update_elem(skel->maps.offcpu_output, &p=
cpu.cpu, sizeof(__u32),
> +                                          xyarray__entry(evsel->core.fd,=
 i, 0),
> +                                          sizeof(__u32), BPF_ANY);
> +               if (err) {
> +                       pr_err("Failed to update perf event map for direc=
t off-cpu dumping\n");
> +                       return;
> +               }
> +       }
> +
>         skel->bss->enabled =3D 1;
>  }
>
> @@ -261,6 +284,8 @@ int off_cpu_prepare(struct evlist *evlist, struct tar=
get *target,
>                 }
>         }
>
> +       skel->bss->offcpu_thresh_ns =3D opts->off_cpu_thresh_us * 1000;

Thanks for the suffixes, readability++.

Ian

> +
>         err =3D off_cpu_bpf__attach(skel);
>         if (err) {
>                 pr_err("Failed to attach off-cpu BPF skeleton\n");
> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf=
_skel/off_cpu.bpf.c
> index c152116df72f..c87132e01eb3 100644
> --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> @@ -18,6 +18,8 @@
>  #define MAX_STACKS   32
>  #define MAX_ENTRIES  102400
>
> +#define MAX_CPUS  4096
> +
>  struct tstamp_data {
>         __u32 stack_id;
>         __u32 state;
> @@ -39,6 +41,13 @@ struct {
>         __uint(max_entries, MAX_ENTRIES);
>  } stacks SEC(".maps");
>
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> +       __uint(key_size, sizeof(__u32));
> +       __uint(value_size, sizeof(__u32));
> +       __uint(max_entries, MAX_CPUS);
> +} offcpu_output SEC(".maps");
> +
>  struct {
>         __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
>         __uint(map_flags, BPF_F_NO_PREALLOC);
> @@ -97,6 +106,8 @@ const volatile bool uses_cgroup_v1 =3D false;
>
>  int perf_subsys_id =3D -1;
>
> +__u64 offcpu_thresh_ns;
> +
>  /*
>   * Old kernel used to call it task_struct->state and now it's '__state'.
>   * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
> --
> 2.43.0
>
