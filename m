Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01627C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 17:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF21F6101A
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 17:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242913AbhJGRIC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 13:08:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32116 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242941AbhJGRH7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 13:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633626365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lLoCTPVohlerSIUXI4ZWSTbwvNW2/UqoUz2lzzfT+/c=;
        b=gajAnZywjNMhqHIf0rgNn3V3RGlj/i4l0GxQLW5XxXpqd/Dg10nb6n747CR5jOSkSHi1Z5
        41G+Hj+7M17jiu3Fxi45Qv89dPU6HX4L+yqzDh78Hmb/GulyV5rg95bCsg6mXXd/USjX+H
        PEbCdmSCLibidO0yZVaP1sNeN/hULm4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571--huuPN7NMK2DYk79-RSSQg-1; Thu, 07 Oct 2021 13:06:01 -0400
X-MC-Unique: -huuPN7NMK2DYk79-RSSQg-1
Received: by mail-wr1-f72.google.com with SMTP id h11-20020adfa4cb000000b00160c791a550so5042530wrb.6
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Oct 2021 10:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lLoCTPVohlerSIUXI4ZWSTbwvNW2/UqoUz2lzzfT+/c=;
        b=wMdi6LTIrc6PDttHG/ql7wbfrhwd6vQdabjjkoSFJC0KRj4wvAmc9uQwkutWmXiIsO
         CtZinp2udvi2wNDdXbE5WwacT45vI8mbr7IqO5YLf4VQe1zDfDG6L8DGcTIw7sCDouSe
         0EIqKFsrcrrceg32bPFG9JCx5xaSbJ27RxLZX9lF6RgOTjtCpAa2TSBjVAxVU+DsQ4YO
         CKwDe7nxbIXJu6u9N7fDZmGXzShK4TI+EVkI4SmE05JT0xZtOzfrl5Eid+qU2O/dLQDb
         AIsGw9NxgRu4O5LrwgYUUB8O+aSocdOe0NoZZOyDfwuo+ZtXbEsFO8g6k3wfLoFXJBGF
         VZAA==
X-Gm-Message-State: AOAM533bwvGF71ZocUCTGRG9SBFEAKiaaaDDGt2HBaEQqsofJ1SVhBAC
        q8Mxv6jmcecqnfZ45aZWkZSz6PtxX511vPcsKoZ/s2QhAzXoyDgvjAItcAyBcT2womsOt/LP1ic
        UVUvuSOgtbMvTYlcBbwj7hyPj3N5pkQ==
X-Received: by 2002:a5d:6e8d:: with SMTP id k13mr7099398wrz.295.1633626360515;
        Thu, 07 Oct 2021 10:06:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOatek8T1Hz7EyxncFwUgGA7nSQhYqd/ri1ydtIqJlrxZ83BkQievmgi/bv7w+VVnMAx47Bg==
X-Received: by 2002:a5d:6e8d:: with SMTP id k13mr7099373wrz.295.1633626360300;
        Thu, 07 Oct 2021 10:06:00 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id v10sm215064wri.29.2021.10.07.10.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 10:06:00 -0700 (PDT)
Date:   Thu, 7 Oct 2021 19:05:58 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] libperf tests: Fix test_stat_cpu
Message-ID: <YV8o9nukzBTkWmlw@krava>
References: <20211006094817.477494-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211006094817.477494-1-nakamura.shun@fujitsu.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Oct 06, 2021 at 06:48:17PM +0900, Shunsuke Nakamura wrote:
> `cpu` of perf_evsel__read() must be specified the cpu index.
> perf_cpu_map__for_each_cpu is for iterating the cpu number (not index)
> and is not appropriate.
> So, if there is an offline CPU, the cpu number specified in the argument
> may point out of range because the cpu number and the cpu index are
> different.

nice catch

> 
> Fix test_stat_cpu.
> 
> Committer testing:
> 
>   # make tests -C tools/lib/perf/
>   make: Entering directory '/home/nakamura/kernel_src/linux-5.15-rc4_fix/tools/lib/perf'
>   running static:
>   - running tests/test-cpumap.c...OK
>   - running tests/test-threadmap.c...OK
>   - running tests/test-evlist.c...OK
>   - running tests/test-evsel.c...OK
>   running dynamic:
>   - running tests/test-cpumap.c...OK
>   - running tests/test-threadmap.c...OK
>   - running tests/test-evlist.c...OK
>   - running tests/test-evsel.c...OK
>   make: Leaving directory '/home/nakamura/kernel_src/linux-5.15-rc4_fix/tools/lib/perf'
> 
> 
> Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> ---
> Previous version at:
> https://lore.kernel.org/lkml/20211006080456.474273-1-nakamura.shun@fujitsu.com/
> 
> Changes in v2:
>  - Remove "2/2" from Patch Subject
> 
>  tools/lib/perf/tests/test-evlist.c | 6 +++---
>  tools/lib/perf/tests/test-evsel.c  | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
> index c67c83399170..47badd7eabf2 100644
> --- a/tools/lib/perf/tests/test-evlist.c
> +++ b/tools/lib/perf/tests/test-evlist.c
> @@ -40,7 +40,7 @@ static int test_stat_cpu(void)
>  		.type	= PERF_TYPE_SOFTWARE,
>  		.config	= PERF_COUNT_SW_TASK_CLOCK,
>  	};
> -	int err, cpu, tmp;
> +	int err, idx;
>  
>  	cpus = perf_cpu_map__new(NULL);
>  	__T("failed to create cpus", cpus);
> @@ -70,10 +70,10 @@ static int test_stat_cpu(void)
>  	perf_evlist__for_each_evsel(evlist, evsel) {
>  		cpus = perf_evsel__cpus(evsel);
>  
> -		perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
> +		for (idx = 0, idx < perf_cpu_map__nr(cpus); idx++) {

s/,/;/                      ^

tests/test-evlist.c: In function ‘test_stat_cpu’:
tests/test-evlist.c:73:52: error: expected ‘;’ before ‘)’ token
   73 |   for (idx = 0, idx < perf_cpu_map__nr(cpus); idx++) {
      |                                                    ^
      |                                                    ;


perf_cpu_map__for_each_cpu also returns the cpu index (tmp),
maybe we could use that instead?

thanks,
jirka

>  			struct perf_counts_values counts = { .val = 0 };
>  
> -			perf_evsel__read(evsel, cpu, 0, &counts);
> +			perf_evsel__read(evsel, idx, 0, &counts);
>  			__T("failed to read value for evsel", counts.val != 0);
>  		}
>  	}
> diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
> index 9abd4c0bf6db..33ae9334861a 100644
> --- a/tools/lib/perf/tests/test-evsel.c
> +++ b/tools/lib/perf/tests/test-evsel.c
> @@ -22,7 +22,7 @@ static int test_stat_cpu(void)
>  		.type	= PERF_TYPE_SOFTWARE,
>  		.config	= PERF_COUNT_SW_CPU_CLOCK,
>  	};
> -	int err, cpu, tmp;
> +	int err, idx;
>  
>  	cpus = perf_cpu_map__new(NULL);
>  	__T("failed to create cpus", cpus);
> @@ -33,10 +33,10 @@ static int test_stat_cpu(void)
>  	err = perf_evsel__open(evsel, cpus, NULL);
>  	__T("failed to open evsel", err == 0);
>  
> -	perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
> +	for (idx = 0; idx < perf_cpu_map__nr(cpus); idx++) {
>  		struct perf_counts_values counts = { .val = 0 };
>  
> -		perf_evsel__read(evsel, cpu, 0, &counts);
> +		perf_evsel__read(evsel, idx, 0, &counts);
>  		__T("failed to read value for evsel", counts.val != 0);
>  	}
>  
> -- 
> 2.25.1
> 

