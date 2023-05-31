Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8609AC7EE23
	for <linux-perf-users@archiver.kernel.org>; Wed, 31 May 2023 14:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237103AbjEaOO2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 31 May 2023 10:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237600AbjEaOOM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 31 May 2023 10:14:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B7A12B
        for <linux-perf-users@vger.kernel.org>; Wed, 31 May 2023 07:11:39 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-97000a039b2so1016970066b.2
        for <linux-perf-users@vger.kernel.org>; Wed, 31 May 2023 07:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1685542228; x=1688134228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zbb0XlzY1V6un7ssRQbevCYzvMDnOinL05UrfKmM4xc=;
        b=OH9ZQuCCOLFEB+BZP1BnCGvHzBQQjqX0rMKp+E6eT1IHlEjxfNphkidlD5G/iWGUkz
         rvauuaLl+QhfJYZtQxefcYZrXrwjxikdy/AuS685Y2y3YDyDhp/sgD+WTTx/TnPV+VYk
         la6J99KIEBYjixVoGdnYGAsJh2YZgoifIPZ2uvqrQo85F8fepovwWKAzHz7r5VrSqxEr
         ROsvmbHDHe0HIQiub6JRj9K/ZTUXHKF0DP8o/eQnuOtPw3qv3wEAakeddEr0i35fCQ3j
         Ga/mirizFSSHUA/qZEiy6f9ySB9F5E4MLgr5P4GCFyj+pBbm9DcgJNlXwbEM5WeGJEAl
         N0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542228; x=1688134228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zbb0XlzY1V6un7ssRQbevCYzvMDnOinL05UrfKmM4xc=;
        b=danl2YH/V6MpKiPEXCDTslHihz5HxO7/n7b9zJkhcQkiGcjGBMvOZGc8m55YEPgQ6a
         x/1z8zhVyDp0ouDnF8KKrz5tkuJCmLfLeDPWkdwrSJOqV1z8qPcJu26mz8FwGIirLtNa
         wnyAK6vXIHDVTX4BDOn0JZYw9vMbBSFjT3qMQP0SNJQ34kRjG0GkEF7bnn6cDJdLYQ0X
         Fg2hz/UPI5ERPdCaU1b6CfOVDny9z/BkxkQg35/6UtMVGEup2RPv6iyxoHm4cpXKbWqi
         uNdDRlYVKpysstnYJLpKdXdBgSeSr2/zNS+aZQzw7Io/sGF/16BiS9EJuEubm8JMCfFo
         /TuQ==
X-Gm-Message-State: AC+VfDwsolchygmsMAeUDeZpzRSv7tX52mjFmNyo3N4fBiTEahend72T
        Pc3MkvEVnL5IM2hc4W20DgeNcIMQ8P4L3s4192M=
X-Google-Smtp-Source: ACHHUZ65HnfYl06bZQf8YF6kP/w87wKf4hufmXMk6i3aLTcwxJQjR5kyaJJ5JQgRjhi7bOY5IOdgjg==
X-Received: by 2002:adf:e848:0:b0:2f0:2d92:9c81 with SMTP id d8-20020adfe848000000b002f02d929c81mr4030977wrn.19.1685541248998;
        Wed, 31 May 2023 06:54:08 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id i16-20020a05600011d000b0030aefa3a957sm7021247wrx.28.2023.05.31.06.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 06:54:08 -0700 (PDT)
Date:   Wed, 31 May 2023 15:54:07 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/10] perf: Fix wrong comment about default event_idx
Message-ID: <20230531-5678beb107af4b9805cbb611@orel>
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-2-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512085321.13259-2-alexghiti@rivosinc.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, May 12, 2023 at 10:53:12AM +0200, Alexandre Ghiti wrote:
> event_idx default implementation returns 0, not idx + 1.

The comment was correct until commit c719f56092ad ("perf: Fix and clean
up initialization of pmu::event_idx"). I'm not sure that warrants a fixes
tag, but maybe a reference in the commit message.

> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  include/linux/perf_event.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d5628a7b5eaa..56fe43b20966 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -442,7 +442,8 @@ struct pmu {
>  
>  	/*
>  	 * Will return the value for perf_event_mmap_page::index for this event,
> -	 * if no implementation is provided it will default to: event->hw.idx + 1.
> +	 * if no implementation is provided it will default to 0 (see
> +	 * perf_event_idx_default).
>  	 */
>  	int (*event_idx)		(struct perf_event *event); /*optional */
>  
> -- 
> 2.37.2
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
