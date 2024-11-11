Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C18A1A0B15
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347256; cv=none; b=pFwhH29wmkG41lb0PpNu+qOUmz403BrP0QUzCg1GtzNj3a4vAxfR7ctVq9GD9MXBh6MjGOpGihSEaipGy8kzd1eQg+la9B33/SHbXowjKN9dEOsm+txUesYpmr2jq1j3eVmkwro4deRPCVjZF9BAxp2PFHyLp+eRRHUzwcju7cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347256; c=relaxed/simple;
	bh=LE4Pt9cDN+mPi0rq/vGTx+/1llTRbJQ8Uh5GS/cdGsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/yY9L8z0dPD7/AGR2UQhtLzqpXq3SbklMDZycKF6bxk+pCruxOxx4T0RpfaSsLYuTe6UG6wT9GqXBb+59Oq6gTL71HqqxeDqa+ch72ujQKd1GOpYXe+VaLWhPw6lw1NTVTDdheautHadeImGKDnYxVKfcoOEFGOVEbx8AffJYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0pj/pRGa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0pj/pRGa"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c87b0332cso965ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 09:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731347254; x=1731952054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0bhILX+QfiTRbLpbbX/P6GiCbt7or8G8zQuLrB55xU=;
        b=0pj/pRGazjIIL2Znyk1/gG2qTfLX69p+NsFcdW3d++Aofqpns8kbeHpC3AycfWVC1z
         T50nQew7dwMsmBb40oMGGWBsgnHW22RuAfze4DBp/KgkVDzFTZlFn5V5u7O+cYmURzgV
         4iSV5e8LknVYJ4mpdCJi5EicujD0VywVFfiS3Xocf3qQHOXd7AfazL5my/0XIJpiN/PI
         iHqJxckiNM/O+osV90cs7Tt59wxpwrBtbzeGgQ52vYxXM8ibKQnXCJ1HzY+81yqCbBMj
         dUhyj2m0WkSgVD6AmX7peuo3M9heFS+4agLlzUvfpRfjdzpN7D8+uxFN9FbtFOUN27XY
         asoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731347254; x=1731952054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0bhILX+QfiTRbLpbbX/P6GiCbt7or8G8zQuLrB55xU=;
        b=fOHuOuRSpM8+tMKpcbLq5eSoaRELS2pcnGmteWOprik4j2ZALMm5QXM8+I9x0gThMc
         caWBFUloKsnu6xxsKXtx2npcZhwv8/4jvo4dRKXe6ACm88RZgp+mOD6jCh55mxHV99Sv
         weEXGhOC3dSYv5UpRGoNJHyJKZLDVF7DnQCc3YSnWB/YAMgrg+5s/t+TKrdQ1ubxJ1Dj
         7+k+yYMhmLkGHr3Qazs4f/NkHQU8O4b5Oo7WZcp+D4XvLBccvsYZk2grjJt3Pd5dWnzF
         vKzfNFddBZP2LoQxnjldrSvPSHwbPdrg2CWh7mp1ugA6UHhajzBOKJLUGsVydQNpjOwC
         VdfA==
X-Forwarded-Encrypted: i=1; AJvYcCWUOBYufWrqJsTQOTRmcVDihk6LwblicSASf3VQUf3ggRfNBbGCgpRgEjhCYUmqFxbSX09YjMaIWHf1SpSosfK5@vger.kernel.org
X-Gm-Message-State: AOJu0YxGz6t7DaQy6F4oQB1H3xcxs+LoOmu+9sTcmKH6Dvap5YwiE/O+
	VOtnLwo5z43UU0fGV+4keK0pJNmLMBpXvOq0y90t2OB1qBsszs8P1Ef1HyI8ptSlHAjwFogXqHR
	t+3rIO72Ef8GBi+PawEbrBI7rirMMVy/x/8D0
X-Gm-Gg: ASbGncsA0ndVuLSRtPyCS28oEZkRkGHwwIVRCeczolvy85bkgR7Oy1l8FqY5IoASnnR
	vl+TaS1jvymT4QmYTD2H7swjkJ2gs0RWiLfXdx3TC7wa+cqMePMlqa/7EHXLjw7c=
X-Google-Smtp-Source: AGHT+IHg98IxDQvCtTAMTUm/W8qnUIEB9mqJCWc7RotJMAqFrSkHNFTD09B7/aSmRwi59/tkqCbTxEP1dnetucZd08I=
X-Received: by 2002:a17:902:d4cb:b0:20b:a6f5:2770 with SMTP id
 d9443c01a7336-2118dea0992mr4463185ad.6.1731347252304; Mon, 11 Nov 2024
 09:47:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108204137.2444151-1-howardchu95@gmail.com> <20241108204137.2444151-5-howardchu95@gmail.com>
In-Reply-To: <20241108204137.2444151-5-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 09:47:21 -0800
Message-ID: <CAP-5=fV8_DxYxKy4A71z0gb82u8W+8qGXvVDSEW2A1GOfSf=oA@mail.gmail.com>
Subject: Re: [PATCH v7 04/10] perf record --off-cpu: Preparation of off-cpu
 BPF program
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, peterz@infradead.org, namhyung@kernel.org, 
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:41=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Set the perf_event map in BPF for dumping off-cpu samples.
>
> Set the offcpu_thresh to specify the threshold.
>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/util/bpf_off_cpu.c          | 20 ++++++++++++++++++++
>  tools/perf/util/bpf_skel/off_cpu.bpf.c |  2 ++
>  2 files changed, 22 insertions(+)
>
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.=
c
> index 558c5e5c2dc3..cfe5b17393e9 100644
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
> @@ -73,6 +74,23 @@ static void off_cpu_start(void *arg)
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
> @@ -261,6 +279,8 @@ int off_cpu_prepare(struct evlist *evlist, struct tar=
get *target,
>                 }
>         }
>
> +       skel->bss->offcpu_thresh =3D opts->off_cpu_thresh * 1000;
> +
>         err =3D off_cpu_bpf__attach(skel);
>         if (err) {
>                 pr_err("Failed to attach off-cpu BPF skeleton\n");
> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf=
_skel/off_cpu.bpf.c
> index c152116df72f..dc6acafb9353 100644
> --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> @@ -97,6 +97,8 @@ const volatile bool uses_cgroup_v1 =3D false;
>
>  int perf_subsys_id =3D -1;
>
> +__u64 offcpu_thresh;

nit: would be nice to include the unit in the variable name, ie
offcpu_thresh_us.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> +
>  /*
>   * Old kernel used to call it task_struct->state and now it's '__state'.
>   * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
> --
> 2.43.0
>
