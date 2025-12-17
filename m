Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA17C19CD0A
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765997836; cv=pass; b=IQYj5uVIGJjwwsQ57IslvGNZDmtgDNTvbuq59+96IPlo4pBpaerzeLIdRvTRNF5vaM6jBLgP7NSm7ejHu4pGw7CI9VrWyHSjCk9RqxcQ5N+OZo9Od/kexuogBY9ARq8qXpJSIFjxqLuAo+7pGNjq1oMoUBu143DaJk1rF7R/ZBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765997836; c=relaxed/simple;
	bh=zmMteg9qnaZxEGIM7xF+591bPcUtEpToQcg/9vzLD+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FK2miDO59YCQLBW33GwRf111QgkZ9TC93EYXZ5R/Ve6VqILYaOIezz1pAbyRs3ES4eDGeruThm2A6TfusgLRwdMZFYx4JFlqXlVis6UPEsYj28fKNKBKPhFW+hKV9ZSeYJ6NHVUt/ouvIeGa3W4nzQdSLHnjtNQSNupIKV24imw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+Uq7blv; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+Uq7blv"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29e0753e5d8so17515ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 10:57:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765997834; cv=none;
        d=google.com; s=arc-20240605;
        b=cKsXNJuO+tfjoFny7ond3AnFLbq7c8G6w+LMGghbrrPmY5f8tgZdyZPIbikeOdOkgP
         kw+5cD+I2MPZeU8EDY50xJ5GeK5022JrGLyFQml3HOxGq72CJAwxrMjHnb8Nb3WmUq34
         YaGXONp3MAGrbiwRF3F7+TR7LFbHEByhZpg44IS9clBojPJzyuym2A0wH9rBWAAJ2rb6
         U5Vwsy0/wPaJKdANnY001JuT4pvD0J28JWLW+1/rR+bNFxHwhCfhXzFsLfHm9b7kvykM
         v74597BF2xtn2Xw2BGhj3Fbti5ePkaHzbt098IG1qL2Y8tMjYZN5PCh5W198govVuDPW
         Z9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/zsAjg2VljJvmZn01nm4O96LDJFMDLKiBHWNqVOrCUs=;
        fh=K7cSvgVIMW2AyG7zmXXRSsM5+ftxgrRF9MTWJXfAE6M=;
        b=CmnrRJh3+2B2GXQAPxFUTm52nx12a3SKQJRov3c1aech5+dnHHNmjDUXnaI70q5Mpo
         Z4vKzgiwFD/9cAFTGDydQhoh02TU6MzlFx/uK/Nsv105xyWd+RI7ZUos/oH0EaCZgqBC
         nM2G6OzCEtK19e8S4QgXQPofui8AgpECSks065wmykXCMpjH+oOeRgFxV9+/C5nL11zs
         ui75Cj4kmr+nEYO++YKwCqe4XH77Z4Lnpg1wnb5rhak2yTu1jL0PmqOtR35n/FRA5Z9+
         HzZSAuflvU8+wDc2RjVUZbcbscTyXWQAsq+6Ai6HS6ns2AOPMQkQlNhe1jxPtrskWwo3
         v7tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765997834; x=1766602634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zsAjg2VljJvmZn01nm4O96LDJFMDLKiBHWNqVOrCUs=;
        b=G+Uq7blv5et2jdaQahL95+96l0pWvB/bahxKKfDBYLovjvltXS6k5kblDY+gPArYNk
         vKdiQohlp24DnLYBchjd4ldPqz+XxQgGsihc/PxTlPN2VGudGiZQP2nyFTzTUqu5k+oG
         a+xX6TOUEszVb/aZQE4ZbUtX/oXm7puBQAoI7cDLTvkPFg+ihwweI23J3JW4VJWEfCNV
         O7FgmPiMNwIVm53vB37ygTNn6Anc/R0tl01pOiJFlCbPUgRfGxD/P0MbURKBH8ZBBP3q
         BMJwT8e0M9ln9b6kv3eMCYFst3GXSLcwK7FTEf0L6nHKnyZkm1z+BlbxODWYbxmnBiKG
         cQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765997834; x=1766602634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/zsAjg2VljJvmZn01nm4O96LDJFMDLKiBHWNqVOrCUs=;
        b=CLeZFoB2ikMPw9dpce3gIW1GCE9PIloWEa4Fz+kdyw7KBWlEKQAUy3n4QkJjLvjGEx
         wxUAH5P2e/91k3HI1wZz06nbNmDYf56FoUAUu0mpxATi1+IBLXU3NMBcB8oBknFTvqye
         pjshsTmMmHsP8wvN8BqvYzVK+1tC6qh3GhdenuoFSeIH1v0dHaNQLvHCvrqcubTUKwbM
         +AslmbOzwinB6NRVWVGFPDmV8OHCYovLhxuNuaHTTbIDot+oujyPeaH99p0cRUVnH7C7
         BA9h+uDE/DCennuhCXbsXvDBQpvKYQCK2RMWC6fyabZQlDbQgUeUmpQVPRSrx28jnavz
         79gw==
X-Forwarded-Encrypted: i=1; AJvYcCWXCqKmmMj0O/bZefCKnMe8jFDdoYfBC9qpH3UcwdSc5SMsDm7zHw/yaqSaCOdICGL5XztUjT6lNiVlf6ZLQ34F@vger.kernel.org
X-Gm-Message-State: AOJu0YwDGPHMNWPUjUyb5jcBUKCo/ip16VXrB5Xw5B+rK3as/FuPkFwf
	JfRu3drlguokICm96sj2/E8RzblPWvVI/DjIL9JYh89hB5vPGnHwrOS0t/0Br/OmJhormJAy8N5
	a7RcYEjVyRvzbVeRZAXfbp/B1Dzn3Kv5pJnU112Y5
X-Gm-Gg: AY/fxX5RUSSlfh1nHsbx7EFtT2LewfCMV+fsIWvBWbOVMj6Z8yKmzmUk18SxjdxMUjS
	d8yjNQLV5fjMn20CrwJBdT9Fc1vUOVXQ/mqpuuMzsEAQYmMkiSauhT/IaZqwGSJtfQFd6Hd7VP2
	Si9PA+DChmTAq+FZcNL3h1weh5gAgvg4FK/SxAXbSqvrDh2kwGEcJYNYqD4PsKyHfO5j7/24tho
	b+9yKLxlzHFOFh0x5kYOxbcmrOUsGthSn8Ww1yeMo4mAf5/6oCQafaN14R53AwYWNEi+9Y3x9//
	eJPzVBE=
X-Google-Smtp-Source: AGHT+IHGut4sKRqKJna/oIJmsW2mwPSNXnFDo2PyDc9wyD1ynldwy1wM6uKSVosJiIjtOYO3myyVBWL32jWsRoePCuU=
X-Received: by 2002:a17:902:cecc:b0:291:6488:5af5 with SMTP id
 d9443c01a7336-2a2d0ba6a3cmr193945ad.1.1765997833618; Wed, 17 Dec 2025
 10:57:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217183927.2259237-1-namhyung@kernel.org>
In-Reply-To: <20251217183927.2259237-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 17 Dec 2025 10:57:01 -0800
X-Gm-Features: AQt7F2o7r2utAXGoHgacZgZe_6YMLjsWIe2oVUX9Qml4fdmn39ZhPQiW1EMLpjg
Message-ID: <CAP-5=fXShAb9Ez-j64fY8c_XDpRUp33Z1Z75jS9=+UaTKa68HQ@mail.gmail.com>
Subject: Re: [PATCH] perf inject: Keep build-ID data if no option is used
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Gabriel Marin <gmx@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 10:39=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> The keep_feat() determines which header features will be kept or
> discarded.  Usually perf inject will add build-IDs based on -b, -B or
> other related options.  But it lose build-ID when none of those options
> are used.  This is meaningful only when --buildid-mmap is not used.
>
> The following example shows the impact of this change.
>
>   $ perf record --no-buildid-mmap true
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.037 MB perf.data (5 samples) ]
>
>   $ perf inject -i perf.data -o perf.data.inject
>
>   $ perf buildid-list -i perf.data
>   08cccc2a9388d5247ccb3e864f3063b975b0a15d /usr/lib/x86_64-linux-gnu/ld-l=
inux-x86-64.so.2
>   fd5c4d5673256cd6bda51725dba048dabb0f854e [kernel.kallsyms]
>   97a36ce1140071be5c36b147fa0bed173e05a602 [vdso]
>
>   $ perf buildid-list -i perf.data.inject
>   97a36ce1140071be5c36b147fa0bed173e05a602 [vdso]
>
> With this change, perf.data.inject would show the same list (of course,
> you need to run perf inject again).
>
> Reported-by: Gabriel Marin <gmx@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-inject.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index aa7be4fb5838fb99..6080afec537d2178 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2022,7 +2022,7 @@ static int save_section_info(struct perf_inject *in=
ject)
>         return perf_header__process_sections(header, fd, inject, save_sec=
tion_info_cb);
>  }
>
> -static bool keep_feat(int feat)
> +static bool keep_feat(struct perf_inject *inject, int feat)
>  {
>         switch (feat) {
>         /* Keep original information that describes the machine or softwa=
re */
> @@ -2050,6 +2050,7 @@ static bool keep_feat(int feat)
>                 return true;
>         /* Information that can be updated */
>         case HEADER_BUILD_ID:
> +               return inject->build_id_style =3D=3D BID_RWS__NONE;
>         case HEADER_CMDLINE:
>         case HEADER_EVENT_DESC:
>         case HEADER_BRANCH_STACK:
> @@ -2108,7 +2109,7 @@ static int feat_copy_cb(struct feat_copier *fc, int=
 feat, struct feat_writer *fw
>         int ret;
>
>         if (!inject->secs[feat].offset ||
> -           !keep_feat(feat))
> +           !keep_feat(inject, feat))
>                 return 0;
>
>         ret =3D feat_copy(inject, feat, fw);
> --
> 2.52.0.313.g674ac2bdf7-goog
>
