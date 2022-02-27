Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5021C433F5
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Feb 2022 13:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiB0NVM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Feb 2022 08:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiB0NVM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Feb 2022 08:21:12 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAA46D4CC
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Feb 2022 05:20:35 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id bx9-20020a17090af48900b001bc64ee7d3cso9008915pjb.4
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Feb 2022 05:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eEz3Leq2u/W/C+1jbRePQ1kSHJwb+1+qvEjuj/ehSuA=;
        b=wjdw9ZdcHIC+9T5rjiGK0vRE7lu5K7AV99CFY8ovS93CTqbHL9xfz6AO+TukU7w9Pd
         H18N2jr3Q2o8Yf13Zfd2PrwBXMK7RRM0F2TToBUy7NjrU/6gqNghNmY+Cu+S4kNLiApb
         NAVK3OGBHpfAJwouCy9lHIbUfkQO6yMUiCOIpddjiJgXzwtJyD2VPOmdUVgFRYMtFaVH
         Nd5AK2hQaH/2oX9p+L3BMiHqmLR69dThYu0qypWQSJ/kogFHoZ4UWDb0jDGJeeMvO267
         YDFrhmVv3St4L74L2OeuWz8uad2j981DkpN7yNAIiL1vEvXIYjYCAlLSRSfh6bolaa1/
         GWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eEz3Leq2u/W/C+1jbRePQ1kSHJwb+1+qvEjuj/ehSuA=;
        b=Db3nvMZ0djUzdSWFzxvVC/nu23d43+SwysGPa6E8mxZ9kYl+E3IVoHuFFXd9vn24CT
         foraTN/AB2xmGq9RQLuQmyFXBhzx8Y+4JeZhhG6YZraO7vGr2e2sPU82+6woJQUuUHrd
         WSaBqDcta/s1XoRMN66oTe2SdJ8U9OkJ/Hs2SBobz18rthNOqkn8SXBihP2lOWY5U+Mc
         Cwf+tAqjLOVu55cf3ZGPu9Z7wcW4GfX45hBXAQk0vEjdK7S+6uE1oLbEtDX9W3TTRLjE
         s3dHsYqNDfOfZkJ932K5Zv7pJNpi180eTXOs6wpJkc0h6ROHTxZlcWSmtOO0pGMBOfx2
         Nkzw==
X-Gm-Message-State: AOAM531gu7YN+XhqdFYXQLRjXU+YTck2t6GIao51G9bxob9RRs8Zj7lF
        +NmRVpIUvSW3eXtjdqhvr2HvIA==
X-Google-Smtp-Source: ABdhPJyEHIQ8pREEDoGfnq9YgfGEEpmJI5qGuFyv/WDDBLW8midPhF54jJFsYqPNjXHwWj9/GRYpKg==
X-Received: by 2002:a17:90b:216:b0:1bc:5d68:e7aa with SMTP id fy22-20020a17090b021600b001bc5d68e7aamr12130330pjb.57.1645968034367;
        Sun, 27 Feb 2022 05:20:34 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([204.124.180.219])
        by smtp.gmail.com with ESMTPSA id mw7-20020a17090b4d0700b001b8baf6b6f5sm7790543pjb.50.2022.02.27.05.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 05:20:33 -0800 (PST)
Date:   Sun, 27 Feb 2022 21:20:19 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Ali Saidi <alisaidi@amazon.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, james.clark@arm.com,
        john.garry@huawei.com, jolsa@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH 2/2] perf arm-spe: Parse more SPE fields and store source
Message-ID: <20220227132019.GA107053@leoy-ThinkPad-X240s>
References: <b1b3697d-4a0a-d041-5cbd-e08fec9e658c@arm.com>
 <20220128210245.4628-1-alisaidi@amazon.com>
 <7eca7a1d-a5a2-2aab-b3cf-5d83cb8ccf4f@arm.com>
 <20220212041927.GA763461@leoy-ThinkPad-X240s>
 <9266bfb6-341c-1d9c-e96f-c9f856a5ffb6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9266bfb6-341c-1d9c-e96f-c9f856a5ffb6@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Feb 21, 2022 at 08:41:43PM +0000, German Gomez wrote:

[...]

> Some comments:
> 
> # ARM_SPE_OP_ATOMIC
> 
>   This might be a hack, but can we not represent it as both LD&SR as the
>   atomic op would combine both?
> 
>   data_src.mem_op = PERF_MEM_OP_LOAD | PERF_MEM_OP_STORE;

BTH, I don't understand well for this question, but let me explain a
bit:

We cannot use 'LOAD | STORE' to present the atomic operation.  Please
see Armv8 ARM section D10.2.7 Operation Type packet, it would give out
more details.  Atomic operation is an extra attribution for a load or
store operations, it could be an atomic load or store, or
load-acquire/store-release instructions, or
load-exclusive/store-exclusive instructions.

The function arm_spe_pkt_desc_op_type() in perf would also give more
info about atomic operations.

> # ARM_SPE_OP_EXCL (instructions ldxr/stxr)
> 
>   x86 doesn't seem to have similar instructions with similar semantics
>   (please correct me if I'm wrong). For this arch, PERF_MEM_LOCK_LOCK
>   probably suffices.
> 
>   PPC seems to have similar instructions to arm64 (lwarx/stwcx). I don't
>   know if they also have instructions with same semantics as x86.
> 
>   I think it makes sense to have a PERF_MEM_LOCK_EXCL. If not, reusing
>   PERF_MEM_LOCK_LOCK is the quicker alternative.

On Arm archs, I think OP_EXCL means Load-Exclusive and Store-Exclusive
instructions.  Different archs have different memory model and
different atomic instructions, e.g. on Armv7, we uses Load-Exclusive and
Store-Exclusive instructions for spinlock and on Armv8 we uses
Load-Acquire and Store-Release instructions for spinlock.

I have no any knowledge for x86 and PPC archs.  Seems to me, x86 uses
compare-and-swap instruction and PPC's lwarx/stwcx instructions "are
primitive, or simple, instructions used to perform a read-modify-write
operation to storage" [1].

So I personally think we can define PERF_MEM_LOCK_EXCL type for Arm
arches and fill into the field perf_mem_data_src::lock:

    data_src.lock = PERF_MEM_LOCK_EXCL;

... or we can consider to introduce a field perf_mem_data_src::atomic
and fill a new type PERF_MEM_ATOMIC_EXCL into this new field:

    data_src.atomic = PERF_MEM_ATOMIC_EXCL;

[1] https://www.ibm.com/docs/en/aix/7.2?topic=set-lwarx-load-word-reserve-indexed-instruction

> # ARM_SPE_OP_SVE_SG
> 
>   (I'm sorry if this is too far out of scope of the original patch. Let
>   me know if you would prefer to discuss it on a separate channel)
> 
>   On a separate note, I'm also looking at incorporating some of the SVE
>   bits in the perf samples.
>  
>   For this, do you think it makes sense to have two mem_* categories in
>   perf_mem_data_src:
> 
>   mem_vector (2 bits)
>     - simd
>     - other (SVE in arm64)

I think we can define below vector types:

    PERF_MEM_VECTOR_SIMD
    PERF_MEM_VECTOR_SVE

The tricky thing is "other"... Based on the description for "Operation
Type packet payload (Other)" in the Armv8 Arm, I think we even need to
add an extra operation type PERF_MEM_OP_OTHER and assign it to
data_src.mem_op field.

>   mem_src (1 bit)
>     - sparse (scatter/gather loads/stores in SVE, as well as simd)

How about the naming "mem_attr" for new field and define two
attributions:

    PERF_MEM_ATTR_SPARSE  -> Gather/Scatter operation
    PERF_MEM_ATTR_PRED    -> Predicated operation

Just remind, we cannot only approve within Arm related developers,
it's good to seek more wider review from other Arch developers when
you send new patch set.

Thanks,
Leo
