Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F21C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 13:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7FEE61040
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 13:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242172AbhJHNLG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 09:11:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242088AbhJHNLE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Oct 2021 09:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633698549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mkeWK1ymkll3fv7JRhxHQKgb62ps++tnFdlpvzfnQY0=;
        b=iXpsqqizLDOpZ+aP6ijfflNq/K+aIFsXCWV+NRsXwgROkHBa9HscgZlZ7W05HYpO2WXYNV
        xNmrJS9kFJkpImuH30Jx3WuFvStwDvEqzQpKI7M6vUEOV1+r296Gw4hUXc3FXmnkTn+ZwV
        Bu+lw4fSPhmdGUQjLRDmUOjYC69+yiA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-8bdiEEWPMseouB-7Anbt9g-1; Fri, 08 Oct 2021 09:09:08 -0400
X-MC-Unique: 8bdiEEWPMseouB-7Anbt9g-1
Received: by mail-wr1-f71.google.com with SMTP id d13-20020adfa34d000000b00160aa1cc5f1so7280134wrb.14
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Oct 2021 06:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mkeWK1ymkll3fv7JRhxHQKgb62ps++tnFdlpvzfnQY0=;
        b=xds1u0HPeB26rn1zZB5ppi9PtiC5RDJmp1DRgCHS/i0Fyo/RPMbEIMB+DvNbwrR0Qv
         DIyei2McD2THovF+u84YsAr4ue3GCHemxfQ6x/ZS5F0Ippu8DLz29dX+acOdYW6fhHP5
         uR4uEwMM+mgfItPW1a1lSHNgV72MYM7OoYlQlsAPNCl0PBBKhnp4UoRCGtVv0OCobuMh
         ukPPSfUdXvhnpiMewn9WagU6CvQFg4w2Eo5YcbLxngkcveMlcjC4oK4LX2NmEa7sEsOq
         AIxFqaLmODPfEw8oIOma9AkQva8kFAttV8Gho6fc8FKfHUrJ5q092JoVZuBxdBRIDUeN
         JHTw==
X-Gm-Message-State: AOAM530loAv8AEH2vwVBJfs2dFyGpjwAbR/gGo454ODsUylKY5S/cJHJ
        tUcah5vf4WGw3dO5KSk3ci8Mbw/UHthwcoKEy284G0KPULhbsG/BuOD3NwjIna/C/EuyfNcMxAk
        PB/ZbiFHGs+b8hVUXfBDsaDPwUxTA9g==
X-Received: by 2002:a1c:35c7:: with SMTP id c190mr3413671wma.57.1633698546511;
        Fri, 08 Oct 2021 06:09:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6Irh/RgDB4eREIn5qEs9TrdRzyzO0wePSCvFXOLItst3Y02wjnCRA/4hUwEofgOFQ19FxaA==
X-Received: by 2002:a1c:35c7:: with SMTP id c190mr3413605wma.57.1633698545980;
        Fri, 08 Oct 2021 06:09:05 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id k8sm2631133wmr.32.2021.10.08.06.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 06:09:05 -0700 (PDT)
Date:   Fri, 8 Oct 2021 15:09:03 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] libperf test: Fix build error
Message-ID: <YWBC72+8/CaG7vB5@krava>
References: <20211006095703.477826-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006095703.477826-1-nakamura.shun@fujitsu.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Oct 06, 2021 at 06:57:03PM +0900, Shunsuke Nakamura wrote:
> In test_stat_user_read, following build error occurs except i386 and 
> x86_64 architectures:
> 
> tests/test-evsel.c:129:31: error: variable 'pc' set but not used [-Werror=unused-but-set-variable]
>   struct perf_event_mmap_page *pc;
> 
> Fix build error.
> 
> Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/lib/perf/tests/test-evsel.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
> index a184e4861627..9abd4c0bf6db 100644
> --- a/tools/lib/perf/tests/test-evsel.c
> +++ b/tools/lib/perf/tests/test-evsel.c
> @@ -148,6 +148,7 @@ static int test_stat_user_read(int event)
>  	__T("failed to mmap evsel", err == 0);
>  
>  	pc = perf_evsel__mmap_base(evsel, 0, 0);
> +	__T("failed to get mmapped address", pc);
>  
>  #if defined(__i386__) || defined(__x86_64__)
>  	__T("userspace counter access not supported", pc->cap_user_rdpmc);
> -- 
> 2.25.1
> 

