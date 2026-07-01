Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91253A544B
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782932113; cv=pass; b=kT/M9/eaXivdYQj0H5Ciys7zlxvGKmHrtR5kQK6G4JpqXGmd+F8XNWA0Nhli8dheBOt5Qn7c7RwHWQVYXATMr0GWK1JJvFJHXdNvBIgLOmxX2lUr7YnCg8uEOwf/CH6EfZcm3I5mtGXJq4EI1bhf2lQrQIvmCbkw6AqqEcr/Ihk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782932113; c=relaxed/simple;
	bh=8buDy9oFy7HqwiHwNvC/IY1j1EOpHRqlqLYOv6/jg5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZneoxT613/Ng/NIDQrUJQGq5TExmNWKT2rBa8EG7L/CfQvR9aENSuAPqMDcG62BAXeZ/XSTJll4pBbrz9V3IE7qZ3rEUTqoktU1lvMDVxJuLsDpXEkV6ny+5Rrv1fBHCpAQDdIB13DVW4L8/HcwMGTOMpNHEx6XgQpHoh8TOXik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bzatAeQU; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bzatAeQU"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c81db32393so99335ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Jul 2026 11:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782932110; cv=none;
        d=google.com; s=arc-20260327;
        b=jnUoZoqQZpUghUiArXERs0DWYboeFUEl8+/x8nZSUT/yRf38ijYMtlOLNlcTyGJdXI
         Lr26EXqj6id6XYPaYwutTTq0w6oUiFernnnF8Mf7GMwtIif4hrJ93YEmzDHwD1hQRCcO
         3QiN9siwn3yuJsHs/2P0OqHmVzJTbQSCtHoz0B8G7Z+LeShf91V7D5S4GMWDaEXep4yj
         T5k1AaqbsJNfp4jlR65DGg5sXqLbywH6SuJBC1gHvW6BXecyUFGQp+XkldDJ+IIwXb+7
         b5ibQP48Lz4sVlLwRdil78+Tjc2zsfyuZtmo1357n+0USB/lYtQ9YvCOPa1Pe0P9O08H
         T4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0KVQLfMeEV5+XrO62oTopJy7auZvfc7K1ZIzGuRBDo0=;
        fh=ymScSjB0hoPA4aNjufLKTJ623Sg942Txre2RRv/ACKw=;
        b=lx2ueHBNqAIbnsYiD6ypbnHDKohp1E7Ay96p7jtB6IOWzQRZPHjcS3lmaM0ZvPdNJo
         eSRTB8FM/Ca4VGX7dllINmP98HySkBi2CXIqB0uO5FsGiYWDCiiQfNcKMIAl3KtBBAI8
         FXR6nVKjEAhBfH0By7DfgvlUqdTbJrq+gbXO7AMyAZiLA/hU2bDitcIWheWIdVDdM+xZ
         qR3iapOjeyxz7tYZKkaSu3iMncw84NuV0lYxcelryC8K94q7X5EfboJRTFMPOiO8lPni
         bUwe6o0KlBKjhNI8ZK5biDqB7uTNiWxyj12VxDMSr8C0Ff9j7S0zoTCjtAvbmjcUF6T1
         3caQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782932110; x=1783536910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0KVQLfMeEV5+XrO62oTopJy7auZvfc7K1ZIzGuRBDo0=;
        b=bzatAeQU/RLXAy2qMom5Gv04X8bnpCQey2vyYnFWSXbaM5KwXAkcXNVjsCQVyZCero
         2QJ2IJ2XUjMSGpWnCauT2O8xcd9Q/cFhghMIeSlosiNQfJ1G0OH0l1uJs+t7Zv8V4CJj
         mf8N4NYJVHuDJ2rMh6jb2vuoCTC53PED0fiUl7v+fLMVR8QMFgwegf8ZxB6HpwvIsLW9
         Qh42q35SbiiC1f0+6WuKMfIDSsip8UzJuTyoadFN+wP669UU3cIW+df1H9SvXvmBDKui
         9gs6ntk4d2FAUfddyl1AXgQC+FXEuQXEPKV6+y89lpZ1ZSeHZD8lVilllPb/NOmCvJAN
         q5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782932110; x=1783536910;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0KVQLfMeEV5+XrO62oTopJy7auZvfc7K1ZIzGuRBDo0=;
        b=M/AmZ44UXNeA7Aw2SiWlIiMqejWsdYwzPhaCieMHGZCEhfwRasOVmNvFgXURANLrV6
         tRuibq5JJHjEFx53fCjYlD9Rs5RKP/LcoO9fc41urALPrwXNl3srB2ZW/3cb/nLXE2zf
         PjDskHdFxaCPRoDV6zBIzQ9QsaEef32fiH3wbNP2gWYYcrUM+x1EsF55yGJdQ3l/5Ur+
         gYk+jc/6QQzRA5LrU3yBB5Mv4M/HEVmYWYXVm3Och4xHelEdAQHKE4gV6iyuqn1nZDXq
         zMs0WLT05wR0EAZjv98sKJnFlziBw2p+jMVZ8/yPGm7S/rouHFj3LVo9ehP8aUWBzleq
         2gsQ==
X-Forwarded-Encrypted: i=1; AHgh+RruM61aBHrW7qEhaR1gPtxzRg4PQ27FUp9DH8A+shSNGf7mwQ6JbDImXCRJkicHLiDzlGHJacelVn/QvRG4rGRQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwYa+qQRmH/lOyniIeUgw0RmHx4ZgRI+4Ebm9/JKgyJ0H3PsguS
	/e3tL76BSji04gS6WffMTZA26JnfUV3avcDblj6D8dk5XpBasXYUOxcdEIrKRce24t12kP4NYLJ
	gNh3nquR+My6SthzAeHbvZwHFBrxkBsJaz0hn2ebi
X-Gm-Gg: AfdE7ck1G4OrXL3qdZuZPMSXYFQAAGmun1AgxIWLIkk96gt0O+7CsnOgJGzGcATU2+k
	evngdDEiHPq4vYfBER/STOULDDJ1FiwDBCl56nV4KJa2g7OPRej9LBhLdo/H5TQ6t0FD3tbEPLy
	1XYHHMbUn6Jssoe+9gKoEV0w6qZ64hLW7HK6mpMxVMNxHTESOHCzd72hVF/ozMYmCM2/KCG541Q
	SNdUp1TKBAvKwpOdZ2WPSwOmwelwzYnCY0BLcynqsRMTqbGQWUFBAClNA6u72XRpo/rsFo+Xg==
X-Received: by 2002:a17:903:2411:b0:2c9:cb98:f4cf with SMTP id
 d9443c01a7336-2ca702dee37mr3196675ad.14.1782932109302; Wed, 01 Jul 2026
 11:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701062321.517351-1-omosnace@redhat.com> <20260701064301.GH48970@noisy.programming.kicks-ass.net>
 <43dd9d9f-2348-43c0-8af5-77ef260c64a3@amd.com>
In-Reply-To: <43dd9d9f-2348-43c0-8af5-77ef260c64a3@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Jul 2026 11:54:57 -0700
X-Gm-Features: AVVi8CdPAA2Awq9Kv3THzlusc-_st-D6y-Dp_4NP8MgglOFbQydRDtJegutCxds
Message-ID: <CAP-5=fWDjNUPgzoFMQkHZV_5t175_L9JTjU-k7=5LWD2TCoQjA@mail.gmail.com>
Subject: Re: [PATCH v2] perf test amd ibs: avoid using executable heap
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 9:59=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.com=
> wrote:
>
> Hi Peter, Ondrej,
>
> >> permission under SELinux (things like JIT or regex compilation need it
> >> as well). mmap() with MAP_ANONYMOUS will give us a zeroed mapping that
> >> begins on a page boundary, so the result is equivalent to the original
> >> code even without a memset() or the page-alignment dance.
> >
> > I would argue that having RWX is a problem, you really want RW->RO->RX
> > transitions, so even with mmap() you want to combine with mprotect().
>
> My original intent for using RWX was to generate sufficient Icache miss
> samples for the IBS Fetch unit by overwriting the code prior to execution=
.
> I am wondering whether it would be possible to achieve the same result
> by using CLFLUSH with RX permissions. Something like below (build tested
> only).

(Minor 2 cents) To make the code more canonical JIT code it should
probably use memory protection keys for permissions.

Thanks,
Ian

> --- a/tools/perf/arch/x86/tests/amd-ibs-period.c
> +++ b/tools/perf/arch/x86/tests/amd-ibs-period.c
> @@ -25,6 +25,7 @@ static int page_size;
>  #define PERF_MMAP_TOTAL_PAGES   (PERF_MMAP_DATA_PAGES + 1)
>  #define PERF_MMAP_TOTAL_SIZE    (PERF_MMAP_TOTAL_PAGES * page_size)
>
> +#define mb()                   asm volatile("mfence":::"memory")
>  #define rmb()                   asm volatile("lfence":::"memory")
>
>  enum {
> @@ -41,10 +42,16 @@ struct perf_pmu *fetch_pmu;
>  struct perf_pmu *op_pmu;
>  unsigned int perf_event_max_sample_rate;
>
> +static inline void clflush(const volatile void *p)
> +{
> +       asm volatile("clflush (%0)" :: "r"(p) : "memory");
> +}
> +
>  /* Dummy workload to generate IBS samples. */
>  static int dummy_workload_1(unsigned long count)
>  {
> -       int (*func)(void);
> +       int (*func1)(void);
> +       int (*func2)(void);
>         int ret =3D 0;
>         char *p;
>         char insn1[] =3D {
> @@ -59,33 +66,42 @@ static int dummy_workload_1(unsigned long count)
>                 0xcc, /* int 3 */
>         };
>
> -       p =3D calloc(2, page_size);
> -       if (!p) {
> -               printf("malloc() failed. %m");
> +
> +       p =3D mmap(NULL, page_size, PROT_READ | PROT_WRITE,
> +                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +       if (p =3D=3D MAP_FAILED) {
> +               printf("mmap() failed. %m");
>                 return 1;
>         }
>
> -       func =3D (void *)((unsigned long)(p + page_size - 1) & ~(page_siz=
e - 1));
> +       memcpy(p, insn1, sizeof(insn1));
> +       memcpy(p + 128, insn2, sizeof(insn2));
>
> -       ret =3D mprotect(func, page_size, PROT_READ | PROT_WRITE | PROT_E=
XEC);
> +       ret =3D mprotect(p, page_size, PROT_READ | PROT_EXEC);
>         if (ret) {
>                 printf("mprotect() failed. %m");
>                 goto out;
>         }
>
> +       func1 =3D (void *)(p);
> +       func2 =3D (void *)(p + 128);
> +
>         if (count < 100000)
>                 count =3D 100000;
>         else if (count > 10000000)
>                 count =3D 10000000;
>         while (count--) {
> -               memcpy((void *)func, insn1, sizeof(insn1));
> -               if (func() !=3D 1) {
> +               clflush(func1);
> +               mb();
> +               if (func1() !=3D 1) {
>                         pr_debug("ERROR insn1\n");
>                         ret =3D -1;
>                         goto out;
>                 }
> -               memcpy((void *)func, insn2, sizeof(insn2));
> -               if (func() !=3D 2) {
> +
> +               clflush(func2);
> +               mb();
> +               if (func2() !=3D 2) {
>                         pr_debug("ERROR insn2\n");
>                         ret =3D -1;
>                         goto out;
> @@ -93,7 +109,7 @@ static int dummy_workload_1(unsigned long count)
>         }
>
>  out:
> -       free(p);
> +       munmap(p, page_size);
>         return ret;
>  }
>
> ---
>
> Thanks,
> Ravi
