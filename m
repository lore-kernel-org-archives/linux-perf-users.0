Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793114490;
	b=SSw1giQOqzvqYB2oA3LWYKaK37asPeyZm1NeK92yifAmOZNG3vHfPWehxzQ1g4/wtf+S
	 VPt8o0KKkwUP9A/HZdQ298nW1i94EQWLW+GC+hvWtdGyEp90QvKffJI+qpptPDTBuDMrO
	 j4csI4AMu1Ehlw89ShuX+BzxqToVMHZoXrAlVJSsat5Bwi6Vhb371rKwdQVlBVSzpkD4E
	 rd65qGPjO6fMqXeWplpbfjhJUBRCxZgcbknUysGyqBS7bfI9n/R1tpsZQivk7peH8+mcH
	 x0y9e+OOoyhzi8p7hoGQ/W7nOEzcItBJw4ah0Z/auHpiZqh0UJ4sNJr9Hvqw4RwiA1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NxM/SdWC3JhodFrjdCzECkyQ1tsAfroiL6zHs8mPuAM=;
	b=zxCDNSh+4cab6913pIcJmTnaoYnGA0IMNqui6ksWLtyeUvq/qj3rkFwXjK6DvRWVgGBv
	 V5Qn3wXUIHWnIrnEBf0Jjf0enC3oaktVuAzCEZ+/VVVsNMjI335Eg7+OCuCQryb9xvVCS
	 qVe5pOk9ol9CzfPclEod2+xwXt8R2bLqbBxGZgdf8z/dngBjZAQe1gzzIotWV0FJBSv0P
	 XnkzTPx42oVqpkPx02ac7OKPqkTgmLa7bpTOlWT6lmRa1waJuKw/BSHbUvA38y/lYPvz4
	 elaJztvTpeYNBt0jZ++YrAmBCOlBUeroxYj25rvfO7tceaOU8qU8fOeIKP5rK+Nrhfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VxSejD1G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39B4606A325
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 15:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F39B4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VxSejD1G
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-535f598d126so264701cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 08:21:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793114489; cv=none;
        d=google.com; s=arc-20260327;
        b=QT8jo+6SZ38Nuy18wfcNZ1jlhMPh1dhidBiCvN+jzBPTQ9QMxl4AR4wKiem6e4xZ8B
         PLAqDebA7O2l0vByi7S2gHAYvQyqmZERuUUYVTSHV/DrMPJcrzby64NyvXk36a5wBqmw
         1DTeAosilHE5JWcEkuCLGOWl9q7WOfuhdbaZ/MXINnPL6euajcqvV2UWdEROxHLDGDUQ
         K5scZxgGW563ymh4R7NowsJDJ8ppGJje6mwS8I7ROu6yGS5CpCVYeu6IUJieyucDIhed
         Nwccj47rHJvMCthBl2xFkD8O5Wg7d6rnOs/vm7FApumQHnocU83YhTM8slWehJ02KdA2
         ABig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NxM/SdWC3JhodFrjdCzECkyQ1tsAfroiL6zHs8mPuAM=;
        fh=KZywdn87yi3do73kR+iCEh8UTo0su6SK6LAcGY/34qs=;
        b=E/4jkofS5R8VJ9xpiLmfN8XMAMdRsol/+/Iq9Qf0q6YW5aqKiCagAnIes92bVTnuTx
         O4+zS9L2UdNRdxJCY+ab+QMa6Z9L2PfNCTu34x7WpwBlRPZY3+kwkEGow2p86UAWOgn1
         2Al9dPC/eBemJf26r1AEZ1+dM2JI1jHG0c72PpaCmuM1BqEqWk31/3Dzmubj2WAMTV1m
         nGM9m5EPuHPUN4SPwSv7yqC7GyJGQ+wJUlaioSMvaJ3swWFoAgV7tBggAq3ffBf5jI59
         VW+a6I8hiFwKygZqm4+mysimE5di7YJRTd9bZBjBUv2Kvz8SCtim7yR1PWTNZORrDYLv
         9+dQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793114489; x=1793719289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NxM/SdWC3JhodFrjdCzECkyQ1tsAfroiL6zHs8mPuAM=;
        b=VxSejD1GY4Qc2u3eW5yvsiYM9LBwpqsts/mjdAkJVQ/2lULtq9froTo4Cgq7uu5dHv
         DHWfY55AT8HWvd4LKYMeOsmwEfRUboaavssASngFTT5BRbMV57W7++Suo0neLAwmTQKA
         FUagRvaiXngimTt6jzyu2ETpXw9JB1GL/lXc4ZRsqGlzvsxoSFRfG2jmnX5CRNOuzuVx
         +3fsQgjP80RTEKK3IXzsQypHyhKt1ckPLS+duuV4Jeu8IuSIAXeNx8hPlvIc0/9bwYtf
         RueBJIYhFbqJGbx2cbiM7nQiJsCcEKd1Zvutt/C0qoKHtvmUhUKUhl/7jB8sfTsTx0SS
         dLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793114489; x=1793719289;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NxM/SdWC3JhodFrjdCzECkyQ1tsAfroiL6zHs8mPuAM=;
        b=ge6LMzSiten6xoH43hoJkrrKm0nGLS+06bnm3DCzr6hGIdENjKvQJiM0u/ElU3cl+4
         QPIQ4GWEWEjzxpGTAC3Imw2mutr4nDrpVgJJiADObJ50FZPc3yb4KjX2BVUVbZkVcVx/
         3qSR83ckBdcVOuobYrGdKiEpOFd2+HRtWe4Hsd4gfyPpA6RJKUqykw8Rj3QV2nO0oO2b
         r5RbjzIEH7md8kT/0Wq4PJ+U77KNLeeLXSu6JuoS8F6dKLfFgLjvGKwJ90SqI6pyr221
         NRjQO0oUOvTC3q5Srx4PvBRXSEbMMi2t2XEV2+az4tRGG8ota8FkdGr3BX7n/tWHkwTl
         WLog==
X-Forwarded-Encrypted: i=1; AKwUvBy8m07R6hAp4NRH05MFHjykMWi0sQ4bHB661JIombXURBL5KH6BSAm6AQ2/0cSELzSLfQnPT6pmd0Jgp0wmeoMw@vger.kernel.org
X-Gm-Message-State: AFq9FYL1gtMnBhmXD66Q1jZW3k6OcXKC6RLbOnlYbhJZQ8ztOWm7lWqg
	e8HCMCAR2DWin1IlqKzM9OeqcE/QgnpVuIKWGsfMjSTGSwUiGZbey3AGMbKJCI+wSg2GxDOexW+
	VU5FtZwsIBl029NxhKKFOOQ59Jt1kVetF85uYqErS
X-Gm-Gg: AYBFou0IOYZqvauBPPqSww463VHVxMcHTP8W4AyN0LEMaUSDBo8yhc8E05MVqRBqews
	HhK/2G7klda+KOxpm9i/Lbtd9LJS1uu/1p54AfiruondMTA0bR8Km7K1NXh4citfdxi7Zur9f1P
	SW+Oqhj6+XzzIoBa86C+o6rJZBuo8+o1dC47+dalCInjKzxjgPFlatm7fZLPS124W2GKeSd+3iH
	Dqk8694YbRH3v6fDCVdvyH+a4SdXpEcLEjHH10OGa1DrAkfKVLUUekEYUXDFhSOOV2ZwrwapOQI
	Yr6r2pWH7xlWQr4SWaBToUMmu36ny9l5tZFWl8jFpNyMFbsOD3dVAkdCuqss7AAEWR0qSRRVdl6
	O0wuLRyw1JTklqwP0IZ/6dcI23/QZHhY0vc9fOKZ8HNJXeOrnXYT9auuhUm8RkynoxUo=
X-Received: by 2002:a05:622a:4087:b0:535:8515:b4e5 with SMTP id
 d75a77b69052e-53e55c28435mr21394481cf.6.1793114488268; Tue, 27 Oct 2026
 08:21:28 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <202610271154.69RBsOlq045164@mse-fl2.zte.com.cn>
In-Reply-To: <202610271154.69RBsOlq045164@mse-fl2.zte.com.cn>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Oct 2026 08:21:16 -0700
X-Gm-Features: AclHuK-Woavtv1Cz-seB3sJDtW9u6Dt6v2zVol6SMqMjeJi6wKjBOrgCgGvWdGE
Message-ID: <CAP-5=fUbpxz9HQV+BRd62Yk+mQ5Bq-G3XvcK8ea3W8E3BqM6jg@mail.gmail.com>
Subject: Re: [PATCH] perf machine: Fix NULL deref in thread__resolve_callchain_sample()
To: lv.yating@zte.com.cn
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liu.qingtao2@zte.com.cn, he.yilin@zte.com.cn, zhang.cheng35@zte.com.cn, 
	ye.zhihao1@zte.com.cn, shen.lin1@zte.com.cn, dai.hualiang@zte.com.cn, 
	stable@vger.kernel.org, hu.shengming@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:54=E2=80=AFAM <lv.yating@zte.com.cn> wrote:
>
> From: lvyating <lv.yating@zte.com.cn>
>
> When recording with -j stack, resolve_lbr_callchain_sample() can
> dereference a NULL 'chain' pointer while resolving the branch
> stack.
>
> $ perf record -j stack -e branches:u uname
> perf: Segmentation fault
>
> Fix it by checking 'chain' for NULL before dereferencing it.
>
> Fixes: 29be60c93d2d ("perf build-id: Mark DSO in sample callchains")
> Signed-off-by: lvyating <lv.yating@zte.com.cn>
> Cc: stable@vger.kernel.org

Tested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>

I wonder - this failure points to a lack of test coverage. For LBR the
main coverage comes from:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/record_lbr.sh?h=3Dperf-tools-next
Could you help expand the tests to avoid regressions?

Thanks,
Ian

> ---
>  tools/perf/util/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index f86b3b7df742..10a88c070814 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2858,7 +2858,7 @@ static int thread__resolve_callchain_sample(struct =
thread *thread,
>         if (chain)
>                 chain_nr =3D chain->nr;
>
> -       if (evsel__has_branch_callstack(evsel)) {
> +       if (chain && evsel__has_branch_callstack(evsel)) {
>                 struct perf_env *env =3D evsel__env(evsel);
>
>                 err =3D resolve_lbr_callchain_sample(thread, cursor, samp=
le, parent,
> --
> 2.27.0
