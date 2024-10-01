Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9871CCEC4
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805198; cv=none; b=THEy4FVqx+8kKWwP1BmWhwKnvaqKchSGGN9xDeosmRoAxAL5DIG7hvksDHoRN7PLZMveEGFnUlBiFT0c7/mCNst1zpFH4aVbthGITXEQlyMe2AdLfIKSaPagccn7ERaZXaJgOr6AfBATFTJ7M6eweueB0WWloleGPwPAeOymXoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805198; c=relaxed/simple;
	bh=HvfV771p9SpNflU09QJhrpVjpuEOOILdsvGW+K/26kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KRBq2SqHbBQOtf9+BgtxPD25rrI7+DFOFvQ+Nn+hcIibpJLnW+m6gsfTz41NcCtHqmYO4QB8WuTX18Hbmdu4xoaLFi+Pv7cY44w1y2kLVI1m9HFz8330ihSKMyocwoSQVnCbwNZM4LdrnEJxXdcmVmn2Wf6JPtCkRK3qANUE9uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bffRVUGn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bffRVUGn"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b061b7299so15205ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 10:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727805194; x=1728409994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zNZIvgOTzPRRkE0xHkf+iIBsdvuygvhCHoCihiVvDQ=;
        b=bffRVUGnu9XBnmebnFujBoEqHbZHp4rNsGllaCKwrw2FlzVtncUYJCehHtKb1h1bmQ
         C4lcUXvT6pJVJOVcMazH7Wud1hFpocscz5kk2FueMTpfKBogGyL6Y88yKtV0p58swNE7
         6SBs+pVV0OfueZvw+Eu6xdCQAiebyVw6wgPq7q6Fv6mBmBnDdKhdN4WZMGZ/XalH95jM
         VvdeT/bCmLh/nOl+uJHkeFS5gp6Z+0Gii23hJ+JxzVcIQmD3eYGFERYOR2PW6CPMDYgZ
         bdtJPlFkCEhPYpBtHo+T12rVJ60IkQ8wGPrtvGO59f9EhCbtAo5mwffvDSb+3exxILv7
         8Zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727805194; x=1728409994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zNZIvgOTzPRRkE0xHkf+iIBsdvuygvhCHoCihiVvDQ=;
        b=MstckGvhGbwiaHm1YfMBJeUQ5SNJW/70kC/p1JPqq83Vw1tm3dFp9aSLG/HhR/IeqN
         cjZnhZnoeTFngBMSd5kXLwGV12OpW9mgp4xqaZlEzRLWz+P7rqjh9C/VJP1h1aivixRN
         PR2aGVi3ZhcasE2ol23eQX9dwfZYOmwRq2KsSAA3aEGpRapLSlygk4YtmQbQX+fFgbgS
         lJeILGqkcXykhg6W4BcwtNLzjaKp3Ma+D0VGp1IQzsJAd3a+YCsp/GH/h6RP/DiGKQd0
         rYrGgJo6wLgzIjwh/v062NjNOHCXmsKfgPYqlzPkP+StGi8m5bat1ZpZX2igvnp9a2T0
         jfTw==
X-Forwarded-Encrypted: i=1; AJvYcCXOaaWypNyP/D07p5yJpulVgv9m5aoBx2SWA4Swo33FvTV+onM27Q7fD/Jk8mRcxCI8mghfUZe7MEnyI6o9Ckq1@vger.kernel.org
X-Gm-Message-State: AOJu0YzrHWvQCxTsNJABpvMufPnV3e3ombETOpKvXvhw78adsOqrwrie
	mo1Tf+W1eFP3yHKN0vhkBplan9r8zO8B5pyEGdX8lEzeT/PqjhAcbH1TdKnfN0XnF+wrGd/RIQP
	ozmbUijjDa9YZ3B8uk8Ss62xPg5cJUL/Vy6IZ
X-Google-Smtp-Source: AGHT+IEkBrCYCuLdrIIq5ZQzTMx0neZL5kEzphJLAuy0GHHfBFt/UZkxMJN5P8NSMU4spMfr408T8O+Ak8Z6ZiprWMU=
X-Received: by 2002:a17:902:ecce:b0:205:8ceb:79a7 with SMTP id
 d9443c01a7336-20bc6fc62b2mr20725ad.23.1727805194079; Tue, 01 Oct 2024
 10:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001002027.1272889-1-namhyung@kernel.org> <20241001002027.1272889-6-namhyung@kernel.org>
In-Reply-To: <20241001002027.1272889-6-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Oct 2024 10:53:02 -0700
Message-ID: <CAP-5=fVrptOSOK+sBo0rHR1QWQ0i1WigMaFRy=So-HATKr=R9A@mail.gmail.com>
Subject: Re: [PATCH 5/8] perf tools: Detect missing kernel features properly
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>, 
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 5:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The evsel__detect_missing_features() is to check if the attributes of
> the evsel is supported or not.  But it checks the attribute based on the
> given evsel, it might miss something if the attr doesn't have the bit or
> give incorrect results if the event is special.
>
> Also it maintains the order of the feature that was added to the kernel
> which means it can assume older features should be supported once it
> detects the current feature is working.  To minimized the confusion and
> to accurately check the kernel features, I think it's better to use a
> software event and go through all the features at once.
>
> Also make the function static since it's only used in evsel.c.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/evsel.c | 345 +++++++++++++++++++++++++++++-----------
>  tools/perf/util/evsel.h |   1 -
>  2 files changed, 249 insertions(+), 97 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index f202d28147d62a44..32e30c293d0c6198 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -20,6 +20,7 @@
>  #include <linux/zalloc.h>
>  #include <sys/ioctl.h>
>  #include <sys/resource.h>
> +#include <sys/syscall.h>
>  #include <sys/types.h>
>  #include <dirent.h>
>  #include <stdlib.h>
> @@ -2150,120 +2151,272 @@ int evsel__prepare_open(struct evsel *evsel, st=
ruct perf_cpu_map *cpus,
>         return err;
>  }
>
> -bool evsel__detect_missing_features(struct evsel *evsel)
> +static bool has_attr_feature(struct perf_event_attr *attr, unsigned long=
 flags)
>  {
> +       int fd =3D syscall(SYS_perf_event_open, attr, /*pid=3D*/0, /*cpu=
=3D*/-1,
> +                        /*group_fd=3D*/-1, flags);
> +       close(fd);
> +
> +       if (fd < 0) {
> +               attr->exclude_kernel =3D 1;
> +
> +               fd =3D syscall(SYS_perf_event_open, attr, /*pid=3D*/0, /*=
cpu=3D*/-1,
> +                            /*group_fd=3D*/-1, flags);
> +               close(fd);
> +       }
> +
> +       if (fd < 0) {
> +               attr->exclude_hv =3D 1;
> +
> +               fd =3D syscall(SYS_perf_event_open, attr, /*pid=3D*/0, /*=
cpu=3D*/-1,
> +                            /*group_fd=3D*/-1, flags);
> +               close(fd);
> +       }
> +
> +       if (fd < 0) {
> +               attr->exclude_guest =3D 1;
> +
> +               fd =3D syscall(SYS_perf_event_open, attr, /*pid=3D*/0, /*=
cpu=3D*/-1,
> +                            /*group_fd=3D*/-1, flags);
> +               close(fd);
> +       }
> +
> +       attr->exclude_kernel =3D 0;
> +       attr->exclude_guest =3D 0;
> +       attr->exclude_hv =3D 0;
> +
> +       return fd >=3D 0;
> +}
> +
> +static void evsel__detect_missing_brstack_features(struct evsel *evsel)

In the future could other PMU specific unsupported features be added
not just brstack? Perhaps evsel__detect_missing_pmu_features would
better capture that.

> +{
> +       static bool detection_done =3D false;
> +       struct perf_event_attr attr =3D {
> +               .type =3D evsel->core.attr.type,
> +               .config =3D evsel->core.attr.config,
> +               .disabled =3D 1,
> +               .sample_type =3D PERF_SAMPLE_BRANCH_STACK,
> +               .sample_period =3D 1000,
> +       };
> +       int old_errno;
> +
> +       if (detection_done)
> +               return;
> +
> +       old_errno =3D errno;
> +
>         /*
>          * Must probe features in the order they were added to the
> -        * perf_event_attr interface.
> +        * perf_event_attr interface.  These are PMU specific limitation
> +        * so we can detect with the given hardware event and stop on the
> +        * first one succeeded.
>          */
> -       if (!perf_missing_features.branch_counters &&
> -           (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COU=
NTERS)) {
> -               perf_missing_features.branch_counters =3D true;
> -               pr_debug2("switching off branch counters support\n");
> -               return true;
> -       } else if (!perf_missing_features.read_lost &&
> -           (evsel->core.attr.read_format & PERF_FORMAT_LOST)) {
> -               perf_missing_features.read_lost =3D true;
> -               pr_debug2("switching off PERF_FORMAT_LOST support\n");
> +
> +       /* Please add new feature detection here. */
> +
> +       attr.branch_sample_type =3D PERF_SAMPLE_BRANCH_COUNTERS;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.branch_counters =3D true;

It feels like these global variables should be part of the PMU state.
There is already perf_pmu.missing_features.

Thanks,
Ian

> +       pr_debug2("switching off branch counters support\n");
> +
> +       attr.branch_sample_type =3D PERF_SAMPLE_BRANCH_HW_INDEX;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.branch_hw_idx =3D true;
> +       pr_debug2("switching off branch HW index support\n");
> +
> +       attr.branch_sample_type =3D PERF_SAMPLE_BRANCH_NO_CYCLES | PERF_S=
AMPLE_BRANCH_NO_FLAGS;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.lbr_flags =3D true;
> +       pr_debug2_peo("switching off branch sample type no (cycles/flags)=
\n");
> +
> +found:
> +       detection_done =3D true;
> +       errno =3D old_errno;
> +}
> +
> +static bool evsel__detect_missing_features(struct evsel *evsel)
> +{
> +       static bool detection_done =3D false;
> +       struct perf_event_attr attr =3D {
> +               .type =3D PERF_TYPE_SOFTWARE,
> +               .config =3D PERF_COUNT_SW_TASK_CLOCK,
> +               .disabled =3D 1,
> +       };
> +       int old_errno;
> +
> +       if (evsel__has_br_stack(evsel))
> +               evsel__detect_missing_brstack_features(evsel);
> +
> +       if (detection_done)
> +               goto check;
> +
> +       old_errno =3D errno;
> +
> +       /*
> +        * Must probe features in the order they were added to the
> +        * perf_event_attr interface.  These are kernel core limitation
> +        * not PMU-specific so we can detect with a software event and
> +        * stop on the first one succeeded.
> +        */
> +
> +       /* Please add new feature detection here. */
> +
> +       attr.read_format =3D PERF_FORMAT_LOST;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.read_lost =3D true;
> +       pr_debug2("switching off PERF_FORMAT_LOST support\n");
> +       attr.read_format =3D 0;
> +
> +       attr.sample_type =3D PERF_SAMPLE_WEIGHT_STRUCT;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.weight_struct =3D true;
> +       pr_debug2("switching off weight struct support\n");
> +       attr.sample_type =3D 0;
> +
> +       attr.sample_type =3D PERF_SAMPLE_CODE_PAGE_SIZE;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.code_page_size =3D true;
> +       pr_debug2_peo("Kernel has no PERF_SAMPLE_CODE_PAGE_SIZE support\n=
");
> +       attr.sample_type =3D 0;
> +
> +       attr.sample_type =3D PERF_SAMPLE_DATA_PAGE_SIZE;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.data_page_size =3D true;
> +       pr_debug2_peo("Kernel has no PERF_SAMPLE_DATA_PAGE_SIZE support\n=
");
> +       attr.sample_type =3D 0;
> +
> +       attr.cgroup =3D 1;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.cgroup =3D true;
> +       pr_debug2_peo("Kernel has no cgroup sampling support\n");
> +       attr.cgroup =3D 0;
> +
> +       attr.aux_output =3D 1;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.aux_output =3D true;
> +       pr_debug2_peo("Kernel has no attr.aux_output support\n");
> +       attr.aux_output =3D 0;
> +
> +       attr.bpf_event =3D 1;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.bpf =3D true;
> +       pr_debug2_peo("switching off bpf_event\n");
> +       attr.bpf_event =3D 0;
> +
> +       attr.ksymbol =3D 1;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.ksymbol =3D true;
> +       pr_debug2_peo("switching off ksymbol\n");
> +       attr.ksymbol =3D 0;
> +
> +       attr.write_backward =3D 1;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.write_backward =3D true;
> +       pr_debug2_peo("switching off write_backward\n");
> +       attr.write_backward =3D 0;
> +
> +       attr.use_clockid =3D 1;
> +       attr.clockid =3D CLOCK_MONOTONIC;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.clockid =3D true;
> +       pr_debug2_peo("switching off clockid\n");
> +       attr.use_clockid =3D 0;
> +       attr.clockid =3D 0;
> +
> +       if (has_attr_feature(&attr, /*flags=3D*/PERF_FLAG_FD_CLOEXEC))
> +               goto found;
> +       perf_missing_features.cloexec =3D true;
> +       pr_debug2_peo("switching off cloexec flag\n");
> +
> +       attr.mmap2 =3D 1;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.mmap2 =3D true;
> +       pr_debug2_peo("switching off mmap2\n");
> +       attr.mmap2 =3D 0;
> +
> +       /* set this unconditionally? */
> +       perf_missing_features.sample_id_all =3D true;
> +       pr_debug2_peo("switching off sample_id_all\n");
> +
> +       attr.inherit =3D 1;
> +       attr.read_format =3D PERF_FORMAT_GROUP;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.group_read =3D true;
> +       pr_debug2_peo("switching off group read\n");
> +       attr.inherit =3D 0;
> +       attr.read_format =3D 0;
> +
> +found:
> +       detection_done =3D true;
> +       errno =3D old_errno;
> +
> +check:
> +       if ((evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COU=
NTERS) &&
> +           perf_missing_features.branch_counters)
>                 return true;
> -       } else if (!perf_missing_features.weight_struct &&
> -           (evsel->core.attr.sample_type & PERF_SAMPLE_WEIGHT_STRUCT)) {
> -               perf_missing_features.weight_struct =3D true;
> -               pr_debug2("switching off weight struct support\n");
> +
> +       if ((evsel->core.attr.read_format & PERF_FORMAT_LOST) &&
> +           perf_missing_features.read_lost)
>                 return true;
> -       } else if (!perf_missing_features.code_page_size &&
> -           (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)) =
{
> -               perf_missing_features.code_page_size =3D true;
> -               pr_debug2_peo("Kernel has no PERF_SAMPLE_CODE_PAGE_SIZE s=
upport, bailing out\n");
> -               return false;
> -       } else if (!perf_missing_features.data_page_size &&
> -           (evsel->core.attr.sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)) =
{
> -               perf_missing_features.data_page_size =3D true;
> -               pr_debug2_peo("Kernel has no PERF_SAMPLE_DATA_PAGE_SIZE s=
upport, bailing out\n");
> -               return false;
> -       } else if (!perf_missing_features.cgroup && evsel->core.attr.cgro=
up) {
> -               perf_missing_features.cgroup =3D true;
> -               pr_debug2_peo("Kernel has no cgroup sampling support, bai=
ling out\n");
> -               return false;
> -       } else if (!perf_missing_features.branch_hw_idx &&
> -           (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_=
INDEX)) {
> -               perf_missing_features.branch_hw_idx =3D true;
> -               pr_debug2("switching off branch HW index support\n");
> +
> +       if ((evsel->core.attr.sample_type & PERF_SAMPLE_WEIGHT_STRUCT) &&
> +           perf_missing_features.weight_struct)
>                 return true;
> -       } else if (!perf_missing_features.aux_output && evsel->core.attr.=
aux_output) {
> -               perf_missing_features.aux_output =3D true;
> -               pr_debug2_peo("Kernel has no attr.aux_output support, bai=
ling out\n");
> -               return false;
> -       } else if (!perf_missing_features.bpf && evsel->core.attr.bpf_eve=
nt) {
> -               perf_missing_features.bpf =3D true;
> -               pr_debug2_peo("switching off bpf_event\n");
> +
> +       if (evsel->core.attr.use_clockid && evsel->core.attr.clockid !=3D=
 CLOCK_MONOTONIC &&
> +           !perf_missing_features.clockid) {
> +               perf_missing_features.clockid_wrong =3D true;
>                 return true;
> -       } else if (!perf_missing_features.ksymbol && evsel->core.attr.ksy=
mbol) {
> -               perf_missing_features.ksymbol =3D true;
> -               pr_debug2_peo("switching off ksymbol\n");
> +       }
> +
> +       if (evsel->core.attr.use_clockid && perf_missing_features.clockid=
)
>                 return true;
> -       } else if (!perf_missing_features.write_backward && evsel->core.a=
ttr.write_backward) {
> -               perf_missing_features.write_backward =3D true;
> -               pr_debug2_peo("switching off write_backward\n");
> -               return false;
> -       } else if (!perf_missing_features.clockid_wrong && evsel->core.at=
tr.use_clockid) {
> -               perf_missing_features.clockid_wrong =3D true;
> -               pr_debug2_peo("switching off clockid\n");
> +
> +       if ((evsel->open_flags & PERF_FLAG_FD_CLOEXEC) &&
> +           perf_missing_features.cloexec)
>                 return true;
> -       } else if (!perf_missing_features.clockid && evsel->core.attr.use=
_clockid) {
> -               perf_missing_features.clockid =3D true;
> -               pr_debug2_peo("switching off use_clockid\n");
> +
> +       if (evsel->core.attr.mmap2 && perf_missing_features.mmap2)
>                 return true;
> -       } else if (!perf_missing_features.cloexec && (evsel->open_flags &=
 PERF_FLAG_FD_CLOEXEC)) {
> -               perf_missing_features.cloexec =3D true;
> -               pr_debug2_peo("switching off cloexec flag\n");
> +
> +       if ((evsel->core.attr.branch_sample_type & (PERF_SAMPLE_BRANCH_NO=
_FLAGS |
> +                                                   PERF_SAMPLE_BRANCH_NO=
_CYCLES)) &&
> +           perf_missing_features.lbr_flags)
>                 return true;
> -       } else if (!perf_missing_features.mmap2 && evsel->core.attr.mmap2=
) {
> -               perf_missing_features.mmap2 =3D true;
> -               pr_debug2_peo("switching off mmap2\n");
> +
> +       if (evsel->core.attr.inherit && (evsel->core.attr.read_format & P=
ERF_FORMAT_GROUP) &&
> +           perf_missing_features.group_read)
>                 return true;
> -       } else if (evsel->core.attr.exclude_guest || evsel->core.attr.exc=
lude_host) {
> -               if (evsel->pmu =3D=3D NULL)
> -                       evsel->pmu =3D evsel__find_pmu(evsel);
> -
> -               if (evsel->pmu)
> -                       evsel->pmu->missing_features.exclude_guest =3D tr=
ue;
> -               else {
> -                       /* we cannot find PMU, disable attrs now */
> -                       evsel->core.attr.exclude_host =3D false;
> -                       evsel->core.attr.exclude_guest =3D false;
> -               }
>
> -               if (evsel->exclude_GH) {
> -                       pr_debug2_peo("PMU has no exclude_host/guest supp=
ort, bailing out\n");
> -                       return false;
> -               }
> -               if (!perf_missing_features.exclude_guest) {
> -                       perf_missing_features.exclude_guest =3D true;
> -                       pr_debug2_peo("switching off exclude_guest, exclu=
de_host\n");
> -               }
> +       if (evsel->core.attr.ksymbol && perf_missing_features.ksymbol)
>                 return true;
> -       } else if (!perf_missing_features.sample_id_all) {
> -               perf_missing_features.sample_id_all =3D true;
> -               pr_debug2_peo("switching off sample_id_all\n");
> +
> +       if (evsel->core.attr.bpf_event && perf_missing_features.bpf)
>                 return true;
> -       } else if (!perf_missing_features.lbr_flags &&
> -                       (evsel->core.attr.branch_sample_type &
> -                        (PERF_SAMPLE_BRANCH_NO_CYCLES |
> -                         PERF_SAMPLE_BRANCH_NO_FLAGS))) {
> -               perf_missing_features.lbr_flags =3D true;
> -               pr_debug2_peo("switching off branch sample type no (cycle=
s/flags)\n");
> +
> +       if ((evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_=
INDEX) &&
> +           perf_missing_features.branch_hw_idx)
>                 return true;
> -       } else if (!perf_missing_features.group_read &&
> -                   evsel->core.attr.inherit &&
> -                  (evsel->core.attr.read_format & PERF_FORMAT_GROUP) &&
> -                  evsel__is_group_leader(evsel)) {
> -               perf_missing_features.group_read =3D true;
> -               pr_debug2_peo("switching off group read\n");
> +
> +       if (evsel->core.attr.sample_id_all && perf_missing_features.sampl=
e_id_all)
>                 return true;
> -       } else {
> -               return false;
> -       }
> +
> +       return false;
>  }
>
>  static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpu=
s,
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 3e751ea769ac4d3a..ea3140cd91c589fd 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -368,7 +368,6 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_=
map *cpus,
>  void evsel__close(struct evsel *evsel);
>  int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
>                 struct perf_thread_map *threads);
> -bool evsel__detect_missing_features(struct evsel *evsel);
>
>  bool evsel__precise_ip_fallback(struct evsel *evsel);
>
> --
> 2.46.1.824.gd892dcdcdd-goog
>
