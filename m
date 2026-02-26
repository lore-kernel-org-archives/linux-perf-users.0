Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAB23876AD
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 03:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772077935; cv=pass; b=E4fbNLyufyGLKPjKr3ioYoM2nfJArb9WVB2qISPwzec/u6L3exI94Xn/2XKaJERAcE7GvO3Q6qRSXCLI1IP7LiGZgejC7oQhO85ddtbmoQjEI1eoQY1eRBvAn5Qv+9OoXZ+TqG9Qs33v0YX9tVVwpA78BIebXbAkVVWlWaGv23M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772077935; c=relaxed/simple;
	bh=MOrtvnv39EYkDW5H25RZ1LIqFMCJlCValVZj2WuOOIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjbZfARabqIduQdiTFU9Va9lcuMfFNXGZOb26jCtTIkO4OHslT1BcxCcH6zeX+V/aiXJXZiHfdftjlEG0x9V2GKillyUYL6URn1LSJ1/gcvSl7Kcf0OL83ZhqPhyentKSgbXX5BZt7FUn0FzY3vtFPs2nO4qNjvBa4NJI2GWiXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MS3JsIvE; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MS3JsIvE"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ada9e4ea32so34905ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 19:52:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772077934; cv=none;
        d=google.com; s=arc-20240605;
        b=W3WeVdi7y31RNRBq6DaXxKa9GEIViIzJi8HJmB0bhLcrxKqKzac9eZ2U7Wtmon8Ck+
         wBy0wCy37Z55BR7x8i5iQJM04czek1ZYLZeTi3i3VGSw3l5fogTwMbOVkfUWUmh/j3EJ
         Ci2P0h33GjvriGhEdk2ObXgd6yZBbJjARo6RsACftza70FZV5uVkU++/T76m+UOd4bZI
         pUEeW0DM/RNPT2t6hv84UWC35uU44G1ChDZlhqzlRooQZctcAX/Kt8v50ZulWwHmRVPO
         2k+uwuetOmWcqJQOiWbnrQXPF6UagAzswx7NgAvCe3x3aV3ybm6nM5AFZuSSnTHNcywm
         U0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sKzXWbIUCTILS3q94AaNCKAQNoHuCCVlSo+Gpd4Bt2o=;
        fh=mhbO3nZxMej1Nm0fM5taXZjdx/DDVrARALO7/xW+rWw=;
        b=F0zgWgnyc2A4t0unTwcbpxHHg+61zw9wrTuYSEmgUKRPLTbsHjZAIeONI+cweyu02m
         +u7s/Kl4F2DVoVD+EiJ0fWuJ/PjdULscK5qRBxToX2uhMPF22rVxP/4ozcA0scYjYwuw
         zj+zxz0w4r+fYqA/EFYpVIw1IAzo5TeJ5L+b/tVkZjVysb66wR4YR4/oGVfp51fVVzRB
         +1pWaGCxzb1AoiirSweR4C8ksWRHhcDvPNeL6aveKLyellVt15rlWqBL9xnAgUbQGPb1
         wvYy2rVRmzXNxP/db1OlfE7KhaErFdFVNxS0kZCmYUQVrGVu0ewSRZ5Sbc2arohxhHZj
         3FRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772077934; x=1772682734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKzXWbIUCTILS3q94AaNCKAQNoHuCCVlSo+Gpd4Bt2o=;
        b=MS3JsIvEGQRlTWqBUoBHq21YqZ1+8AHtfSLKnggKna0bdEAN8K138R6DhAGl8uHofQ
         4UMFd8AEzRJYM3V/V3wz2Ksce6jXQlN1hgfpFWfEQcxbepzDyKOwWUle5ZhIrWzB9Rp2
         Nii3J1uhPlO71NgFoQcRpIcWk4nI+mx+gzYrVGONlmx+nHoQEhPTd7VMb+yzqywexF0E
         GiP4ON41sLmsfpN+xpbj8iSq5QeNq5eg1wCEjb2vPOlOImL4WmrR6jcRlBMfHO8wVz16
         EJCzqmcPeOfTFBZs9L0jOcu5TPRc5SGgRwcSa9gEd6tSOhyFX9BUGe7SC7UGJySHt0mY
         kG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772077934; x=1772682734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sKzXWbIUCTILS3q94AaNCKAQNoHuCCVlSo+Gpd4Bt2o=;
        b=uLuiHwgrNL4/HuSzkdpcKm8tcLEeaBa4ySONfy3eDq/shANrcR/MI1WHWaRi8MqvSt
         iEY+iLpGBMREz3co7+tXxpTA5dB+rCIOsotNMVUIhL+UO1sA5YC/oxmZ2+e6cUK0Ynn9
         g1I44VUC7rHU7/ZMvOcdAVlYn+/D1rwzmw7aKUs/jvp2dqSrg02HPz+sVoP0GfV7ANb5
         t3mRqPAgSKwb8i4yg9hl+mHQ1fY93qxH4kTku3NXrOnfGZTXafKM0OOJiE1DFujF75Ld
         /WI2/4nwwz0aoHVcf86HP5Q9GpT8HfTLQcv+1jsu0PqoaZkGsyo8lzpsGOC5wcCiZNG7
         HaXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT0gpgGdua6XUdJvAkGIVkoUXdKI9rZBY4vPQ9b9PTjelvr+46/gHgHwL/8iZhFUSAMzB9q+ahl8Hgf3mLRbGd@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpr4WqVTTJTrrhewZvjnnVlPO21OH+FbfUTiHR2vBIixIGKsno
	jSt0gIC5WJ73dnQAm6wiq/eaTaYY4ahnmBzdaECGAzx2eLSLffJQS56URvvtHSe0Tv2Irhf81FY
	sIkNu3WgUR5Mt83TAkmSpUdq/49navplF9j2cdwzS
X-Gm-Gg: ATEYQzwl27EjSRhrR+2Fa2CR5cb7/7DbPkiZacSEfgSKKlDxe71K3uf2Kd8XfVf2axG
	TTD8PpYuCV6r3ngY0NMy4PTzMyoVbJ5sqekJie6SKL/V6WhSCAJxMZH3Slrh7mqfSD1y2R1cZB2
	SmJI1g8ARoF+IK4b7H4MJ+sJ06Bw3yEhpOUxQc/wYb8yYKnRMg10pta03DakKEPyZEfXlcvgiXH
	I20gu7jbuOsjMjdAJg0+d3Lplp4D6I42lWoEUBCRWu5Nq7JzoV5oDdOkESbG2532C/tUZaxdh5t
	+f/CkK5Szd/Nywqps6A=
X-Received: by 2002:a17:902:dad0:b0:2a7:9532:1a2b with SMTP id
 d9443c01a7336-2adf77c6b5fmr1286475ad.20.1772077933184; Wed, 25 Feb 2026
 19:52:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226014955.801293-1-namhyung@kernel.org>
In-Reply-To: <20260226014955.801293-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Feb 2026 19:52:00 -0800
X-Gm-Features: AaiRm53j5FHlNJCm4MBzoFo3mhgbBKOj976um_cZPW3P2x5-QnU5pt-2IuDa-LQ
Message-ID: <CAP-5=fXQ4ySGYuPXT5pLjpmuXHa7TjFEztLNM-Oa=zM9FqB+_g@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Handle task exit in BPF syscall summary
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 5:49=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Some system calls never return because it'd terminate the calling
> thread.  Let's hook the task exit path and update the duration of the
> last syscall.
>
> Before:
>   $ sudo perf trace -as --bpf-summary -- true |& grep exit
>   (nothing)
>
> After:
>   $ sudo perf trace -as --bpf-summary -- true |& grep exit
>      exit_group             1      0     0.004     0.004     0.004     0.=
004      0.00%
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/bpf_skel/syscall_summary.bpf.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/bpf_skel/syscall_summary.bpf.c b/tools/perf/=
util/bpf_skel/syscall_summary.bpf.c
> index 1bcd066a5199a476..4172f3c9fc483955 100644
> --- a/tools/perf/util/bpf_skel/syscall_summary.bpf.c
> +++ b/tools/perf/util/bpf_skel/syscall_summary.bpf.c
> @@ -118,13 +118,11 @@ int sys_enter(u64 *ctx)
>         return 0;
>  }
>
> -SEC("tp_btf/sys_exit")
> -int sys_exit(u64 *ctx)
> +static int do_exit(long ret)
>  {
>         int tid;
>         int key =3D 0;
>         u64 cgroup =3D 0;
> -       long ret =3D ctx[1]; /* return value of the syscall */
>         struct syscall_trace *st;
>         s64 delta;
>
> @@ -150,4 +148,18 @@ int sys_exit(u64 *ctx)
>         return 0;
>  }
>
> +SEC("tp_btf/sys_exit")
> +int sys_exit(u64 *ctx)
> +{
> +       long ret =3D ctx[1]; /* return value of the syscall */
> +
> +       return do_exit(ret);
> +}
> +
> +SEC("tp_btf/sched_process_exit")
> +int process_exit(u64 *ctx)
> +{
> +       return do_exit(0);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.53.0.414.gf7e9f6c205-goog
>
