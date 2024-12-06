Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1296ECF
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Dec 2024 04:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733459279; cv=none; b=G3kI4cRqJg+MSWZmNUuPPsgbfYYX4erCbh8wzUqYxVtEcBap102f6Qsz6hGRoNcGFb8IJvWrlVRalj7UD6Y2wJcuDvbGISiliuTxvnSkk8KLQWwBpqsh+VsuYsU3R0kgeuA4wnjPywen7g3XVwDDlEET7mecnzr6Wz+cTFC16oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733459279; c=relaxed/simple;
	bh=3k6Oc5FnFR/eW2ImmZ9Hl7zvpSjV1UtVQ1ntYtqXBUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FohEMKFkdp8feIscEkhWz8XGlKY2auWURGEvjCfLrwWY2BZLgvyam6xDgVLorfAQ8Hz2+fnvorRQTe2rAZpZmIJYdWshSf22MmbxLHZ/qfSIpocQ0pZAXm9FTKkZFMIzbi3cshU6VjC4IFS/TeSTz5wg9aktAWj1Al4Zp5KWbOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=17shW8Tl; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="17shW8Tl"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso50755ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Dec 2024 20:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733459277; x=1734064077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K94sqNNQGu1n5mRcV3yW0ipuJfinFO6kahK8zCx8uPU=;
        b=17shW8TlmNqoe2hj+ky61Phe+hanM2ruozqS7sdXvHIe6k9CvLDP/z0evQNXSx71GR
         iyYPX9cZS6RWv4G8GSaicAJ5AqdDmHL2m+FoN/gi1m10la6+KehvBAx3C9tKaCLSXWzD
         WfwIHcoTyHPZ/kJORvICyG3oT+NjkScf2SrW+LEL1BBKAaBi+rnZ+PkX5XD9B5mEqJzA
         3Ksz72Rt/AiAtys+wsd/jLNlr8c/JnjCdA+RtCvg7Szau7YQrmLHw4vBdGENVk2rjTNa
         xXNnyuYt9hF10z9qxPhdkmIiORgiQOMyMG1r+eE0iOgMvRrftoorMSNAm1MK5ovt2kfK
         Me1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733459277; x=1734064077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K94sqNNQGu1n5mRcV3yW0ipuJfinFO6kahK8zCx8uPU=;
        b=L3fYdnDplZfF5dpavgDn4HXXdDpf9gn1SJkYoyIRGa3PxvhWeGhHOGK5mgsXJYnPft
         4hKlIw808ybjCl1X2mrIFFXkFyWVCUmNm1DSX/OuGB62ssyt+xg+QnD1IHyDoT6pCRNS
         MuWN42RkbehTm2B8UhUAKxBxdsaCPquGVk1TW3qIgliIvfu8+XMroThXrX/B3qGgSKqG
         DhKpxr2lFtWFvCu+MrsWfyCGGHVAZqcwDQgGl1vfohVkSKrhGptXJpBy3rEwUu5ehiVA
         jgrEptK6g+/90obbDcK6JOnNCyEiWGjxR1s07kbp4o8FmJtGSGQQH0G6UbMQdWUxCiQm
         rgrA==
X-Forwarded-Encrypted: i=1; AJvYcCVd3TwM6uquTKuTGektCe20q4doJuNXIHVRS7geg2DSLv/MunJE/9xmt9e7AK6k4Z2W72E4HCKzZSJhWh+g00Ma@vger.kernel.org
X-Gm-Message-State: AOJu0YzAZT2C3s5amwLUwWhqf3f1LaeqL7LrvlDJB+GJbveuj0bX9ot9
	eliP6tRT66VYugVDiAQND0enSVmaii2ZvtH0jRb3ek/iP6uMb4HsIpC9Za4O+tOzKZCN4SZPYMv
	kugHJ49Wr3K/AUjW8UJu4kSIcyAI0kNRfyCuM
X-Gm-Gg: ASbGnctiw7ewWb4b/MyWIgiGhtdUxffWzzNsjqbFZTngXTE8oHfza53ewausxb1m4ag
	16duXrwAh+J0OIZknaJ+Cyds4+22IoDys
X-Google-Smtp-Source: AGHT+IEUysvxIKxnOpDK6+RkAno6VytnrnDCCtKcWOqAWxmmrjUHE5m/yHUlyuk+Ny6CjqC3wGU6nT+/nWI2wOsPkUg=
X-Received: by 2002:a05:6e02:3a13:b0:3a7:9ec6:2cff with SMTP id
 e9e14a558f8ab-3a813bef45cmr1093555ab.25.1733459276716; Thu, 05 Dec 2024
 20:27:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205210444.84894-1-kyle.meyer@hpe.com>
In-Reply-To: <20241205210444.84894-1-kyle.meyer@hpe.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 5 Dec 2024 20:27:45 -0800
Message-ID: <CAP-5=fVQnXM2c7dH=kfDu4AzN2mQs5G1zXZoopTs7Dco+bHi+A@mail.gmail.com>
Subject: Re: [PATCH v2] perf: Increase MAX_NR_CPUS to 4096
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 1:07=E2=80=AFPM Kyle Meyer <kyle.meyer@hpe.com> wrot=
e:
>
> Systems have surpassed 2048 CPUs. Increase MAX_NR_CPUS to 4096.
>
> Bitmaps declared with MAX_NR_CPUS bits will increase from 256B to 512B,
> cpus_runtime will increase from 81960B to 163880B, and max_entries will
> increase from 8192B to 16384B.
>
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>
> v1 -> v2:
>   * Increase MAX_NR_CPUS in tools/perf/util/bpf_skel/kwork_top.bpf.c, as
>     suggested by Ian Rogers.
>   * https://lore.kernel.org/all/20241205165118.153148-1-kyle.meyer@hpe.co=
m/
>
>  tools/lib/perf/include/internal/cpumap.h | 2 +-
>  tools/perf/perf.h                        | 2 +-
>  tools/perf/util/bpf_skel/kwork_top.bpf.c | 4 +++-
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/in=
clude/internal/cpumap.h
> index 49649eb51ce4..3cf28522004e 100644
> --- a/tools/lib/perf/include/internal/cpumap.h
> +++ b/tools/lib/perf/include/internal/cpumap.h
> @@ -22,7 +22,7 @@ DECLARE_RC_STRUCT(perf_cpu_map) {
>  };
>
>  #ifndef MAX_NR_CPUS
> -#define MAX_NR_CPUS    2048
> +#define MAX_NR_CPUS    4096
>  #endif
>
>  struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus);
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index c004dd4e65a3..3cb40965549f 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -3,7 +3,7 @@
>  #define _PERF_PERF_H
>
>  #ifndef MAX_NR_CPUS
> -#define MAX_NR_CPUS                    2048
> +#define MAX_NR_CPUS                    4096
>  #endif
>
>  enum perf_affinity {
> diff --git a/tools/perf/util/bpf_skel/kwork_top.bpf.c b/tools/perf/util/b=
pf_skel/kwork_top.bpf.c
> index 594da91965a2..73e32e063030 100644
> --- a/tools/perf/util/bpf_skel/kwork_top.bpf.c
> +++ b/tools/perf/util/bpf_skel/kwork_top.bpf.c
> @@ -18,7 +18,9 @@ enum kwork_class_type {
>  };
>
>  #define MAX_ENTRIES     102400
> -#define MAX_NR_CPUS     2048
> +#ifndef MAX_NR_CPUS
> +#define MAX_NR_CPUS     4096
> +#endif
>  #define PF_KTHREAD      0x00200000
>  #define MAX_COMMAND_LEN 16
>
> --
> 2.35.3
>
