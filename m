Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1454FC324
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015783; cv=pass; b=kL75antX+M2mliaFYbHT1vtQSFRMSlijyZIj0/8Gmb/ZQcCwJyuGRyfzvYJgINQSG70G+8VsVbg1Bwj/Av7BoijFVWXbGorC4zHinEiECmXmnbPkueJBZpl99eJk+Cfy4/5vIIvLjSH0mrvtZEZylpDFj1tC2mkzkDKKtIyYNAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015783; c=relaxed/simple;
	bh=5IMj8x9eRgcjqpyKwZG/YkXc/KumJsdOZYNSTZMIJ0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWNl4hoDiJCVknDV7Y0cLhQx1Rj+c9lSLiNT8uBJlDzMSZ18T7c/9QJNtRb29/ybE0+Wya25vxR7pwn3wt9luV+IsCXppHJ1OQ1kL8HNiWK7pf6mYNvSVN/CPDfK+JzSL1Zc1D+/QgJTNQhcvchkTgG2ePD71OPFpDa7NCnjwJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g6g/NmxZ; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g6g/NmxZ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-530e8c6fb80so31151cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 11:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790015781; cv=none;
        d=google.com; s=arc-20260327;
        b=KwUaNELbyOC7i6wqh9sHkQv4qHazRf7v3ox2jOWndCyiWue2j5L4ef5h2pCIqUfBUG
         51b0d6iM7B5IKOUbJVfYFP0RBxcHRiOI9YhpFnSx2zGZEts3AFxgZgfh7YOQPZlT1M2a
         OXqwUM17eETkeyc/uorFM1okTqR3059uTryQFkpUNXm7yHpeF+sEN12JpjdTRC+cJjWY
         SSFyXTk0cx72TptLModiLa6Mduinb0z2s24rnAvbCR5UtievVk1r9IWG9juHr//ZsmvR
         hnsY7NJB+f2sjxyxwkKduGjTPjHmwRQJNPFRasSJ+G4xFTLsRIBnYpnyYhAP6+7gKxXn
         paQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hkzGojJ4vehMF4KKmjoVCNEOrAfdvYhqr8q/GMHHrXo=;
        fh=c5AczGDOQUxh2XqCoXHndZYhUtefTu6M35WeJowCj9A=;
        b=TQomgbu8GRIE1mW1tDRRPkuCr0Qv8hBi4Ckf8WKDO+aZEX6B7vqXvQM58MqSRbFVcn
         KmdO25sQuaxggqWvt1hWZqst5NZPsTfAQLFdgp64MpSw7wO0CVdr8yxZc9daxQE2x+Wr
         ohgG44b9HJeIi3y7HMiZ0hemopiYrlCp0FubBTSAnR1EEvV7gEf67VxG9/nmEmc3OsnQ
         cNIXuhD2AQSzzM9E381L/FP0bKyKg061BST2Quam1HMRbHaZkHovrTosO6r6bGfgLrHm
         bctaot1OcQqLbOFTJSS6AT/F4ZKHWHW4trsWF3VdVXmfT4SFshm2p8o1p6bxTsk11KHe
         RT2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790015781; x=1790620581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hkzGojJ4vehMF4KKmjoVCNEOrAfdvYhqr8q/GMHHrXo=;
        b=g6g/NmxZnVbbxXCTDBtFClZLNsmeVsSTYG8zbjz2ufJat7d/6czp6ezGWd01i/6igk
         BI4BH1MdPj67xMYx4+xOPiwuUfoXfQkHVBxSs3Gx6OFuOaw/cNGzRRNR0sTzWtDMRGdL
         5PEqjzpalLt7r78HQT4e+RpL/QCCjdJK81QTh2pXG0Rt0kXpyWqPji7zGZXJnog0clr1
         lr8Thx7VnqF9TKi7A6r6lxKVp68rZAQpDg+pW1H4ZOKkJ0BGhQwIziV6kxFWNjCA49g/
         2VkY/OQ9xz487DARmxt5Dr070t2iUadYvcMq/damywjFOTPkKxZaneTahYaPxo1wsWIe
         ZNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015781; x=1790620581;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hkzGojJ4vehMF4KKmjoVCNEOrAfdvYhqr8q/GMHHrXo=;
        b=nZ1Y7nZTgPLZ5saH5TGaNPFGT0ulwIqf2Jf+DzrPQ77Qc+d86+24e5zfU4zZGlp0ap
         6EeG3DkpCHeBXZi6AOC8dI5eFKP8hXlUeszJAIQr1wqMJ4DHViiit+IEcYs3g+my5AZs
         mqOlr8GuJrs1mpAWq1GgNo6GWuwmhM8MKOWM4scXStThmrOHbNOSFs59i5OnqSFo3bVA
         FFIgSvpwxF2oaXujex5/m3s92Z3RwaHbLENXVP32+JJMa/5yLfCBWIYrEhmYGvJGKWCY
         rV1mzZgaLHNHmzvuIgCRabkNbgZSM3FW0Ad/oBZWqjO2ie1pCV5yCgiVSX7ZCzl2dhah
         Up0w==
X-Forwarded-Encrypted: i=1; AKwUvBzMmx0pKWu/Of6GPS5/izUTxCaYh92/vYEKiPUir2EgDJ0RIL8fRnjFfCC3sgkqD1Wneft+iqPd1L5VB/Ozb2h0@vger.kernel.org
X-Gm-Message-State: AFuF++n+7YSNj1zvCv19uln9JQrxxuTRzdW+msuAoapJ8Uu0/AGVKJjW
	+SrXb6KSTXCTXLTSbfcg5zF+SuhyusQv0zVyQDbswT7u6odsrzSBMQ67OnlH5jnKq2wqdST0m1N
	LDXda2IIhTPuWq+C64K72XQ+SaD8OwtTSRbAsbQ8Wzr57onmNerzp52Vv
X-Gm-Gg: AYBFou3MiYNgtichPJicVMqF13y3tBkccNiRwS7w9f5EGVKnn5U4wNPGJ3SYwQQZsoi
	fUeG+aMwTq+vdugpRCW8XoGh1lP/KuJVtrTWtD2p3fuRHc+SNVY249rP0BEaB8WNDYzwLWSpHN0
	UMyC+SL80i/Scf6NOoZPvUPjga9yX4v7dGPtkPCPkuhdsDK/Dd1G+XWlh2l85ANvamDqUcqn13f
	TTswc66WGipOm8S+Jzb/OvtUxwiFYAJUACSpMe9N3NZQf/ZPqEvX01ZIKauaHwhnJDZJEHge7RQ
	2Zcc+hD8JNfZSBYmYv6fjwwgNlIAR/SbeOB82b/t9Kqd/WekkQyOrUOxCOOXJxHV67YL2AmmEDP
	hLW4IFbCU
X-Received: by 2002:a05:622a:2290:b0:531:a85:69c1 with SMTP id
 d75a77b69052e-532dc3bde3bmr1415511cf.5.1790015780611; Mon, 21 Sep 2026
 11:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917125802.1198419-1-wutengda@huaweicloud.com>
In-Reply-To: <20260917125802.1198419-1-wutengda@huaweicloud.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 21 Sep 2026 11:36:08 -0700
X-Gm-Features: AcwNN1XL2P6NwaYXUdhKIHqVAwXxCkVy_W7OkIGEoUZLnBkLv48KQjUcMsGXLjE
Message-ID: <CAP-5=fVOdeA-cf1NRJxQ_YFeYKu3F1PJ3ykXR5Gtx7r0MtsUtA@mail.gmail.com>
Subject: Re: [PATCH] perf llvm: Fix memory leak of args->fileloc in symbol__disassemble_llvm()
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Namhyung Kim <namhyung@kernel.org>, james.clark@linaro.org, xueshuai@linux.alibaba.com, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev, 
	Li Huafei <lihuafei1@huawei.com>, Kim Phillips <kim.phillips@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Bill Wendling <morbo@google.com>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Zecheng Li <zli94@ncsu.edu>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 5:58=E2=80=AFAM Tengda Wu <wutengda@huaweicloud.com=
> wrote:
>
> In symbol__disassemble_llvm(), after calling llvm_addr2line(), if the
> subsequent disasm_line__new() fails, the code directly jumps to 'err'
> without freeing args->fileloc, leading to a memory leak.
>
> Fix this by explicitly calling free(args->fileloc) before jumping to
> the error handling path when disasm_line__new() fails.
>
> Fixes: 048856817888 ("perf annotate: LLVM-based disassembler")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/llvm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
> index a0deb742a733..dc66f6cc1db6 100644
> --- a/tools/perf/util/llvm.c
> +++ b/tools/perf/util/llvm.c
> @@ -254,8 +254,10 @@ int symbol__disassemble_llvm(const char *filename, s=
truct symbol *sym,
>                                (unsigned int *)&args->line_nr, false, NUL=
L);
>
>                 dl =3D disasm_line__new(args);
> -               if (dl =3D=3D NULL)
> +               if (dl =3D=3D NULL) {
> +                       free(args->fileloc);
>                         goto err;
> +               }
>
>                 annotation_line__add(&dl->al, &notes->src->source);
>
> --
> 2.34.1
>
