Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F011C4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Dec 2021 12:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352687AbhLXMnw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 24 Dec 2021 07:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhLXMnv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Dec 2021 07:43:51 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD02C061401
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Dec 2021 04:43:51 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id r5so7551584pgi.6
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Dec 2021 04:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jcyojBDrKMiGKWYkpKMq1sPGg6Fey7IgwpFT8eDRhwk=;
        b=awW/CA8C9FLMHxzp4xY1LyKf8G643ynreB4B/aSo4Sy+gIN87i/TaommbuzLkRALH9
         bAB5Gs4ztsqc/AxmDBz0j0DLpZ4XUdK25xz64krN9CXBR1iWDg6QteqauRmF9CuLkgWc
         x06SFbLiGPThAZRmOBgSgEdbt2l8fwcFyv8BtI/5bLNtHNZCJb1M1jJPDOofbDzYFjh3
         ibABM+UdZSBKmu/EfnYKa6fCH4CQevV5XljKbaovXDt8BxdUosr6e9LTuSKfKZ69XX40
         kFrQp/paXtMdZqaAayRuq7POEdFEi5kAD3J87h20V4C+meWz4NYiwT8q99xD2ba/NiFw
         5DOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jcyojBDrKMiGKWYkpKMq1sPGg6Fey7IgwpFT8eDRhwk=;
        b=IENj7SnrdOZNJkpp3FR+/NDqEsSPn6oNGKDkNgkTjuRs2yQCePOsXYcRDXjB03Qpm2
         wmh8QR5Vx69IcNDsdqrOICKYSW6lUyt8JYxeSMqoFPcLMt5BMvodSOwdxQYO3XSN2G+9
         uXA6aLqf+scpyLYgMwBKWdjMz5y8LsmD5G00PoUmZReAxssA81uYmRke8gYNVKxCEDCq
         Okf4WZyS4Jd/I0K0BDePh4oCF474RANqkwdUvV0GRFCwlBR7siaebXCLGy8N0LvFWri8
         diB8pio8wHsOOpe+EAdos8mGp+LGCi1oQgzKynywWwkZaqFVRsajFyV/B4D0WNdaODJt
         wCjw==
X-Gm-Message-State: AOAM532VOgpoPvdQcLKc9Ui+ytOTzWAaGZRsBsHaQ2ZNDwhvwIunbulb
        DAa0c+A9igLj1kp/72vYYXxkRg==
X-Google-Smtp-Source: ABdhPJx1Wq5P9eik4GFSq2xzNemm2xU3Z8MJOFl5Ze3joerM4rWzw2Ygn2uPOR0Ea+NKRqtD3joI3Q==
X-Received: by 2002:aa7:8153:0:b0:4a8:2c13:dab7 with SMTP id d19-20020aa78153000000b004a82c13dab7mr6476102pfn.51.1640349830919;
        Fri, 24 Dec 2021 04:43:50 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([116.206.103.242])
        by smtp.gmail.com with ESMTPSA id f20sm10034546pfe.166.2021.12.24.04.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 04:43:50 -0800 (PST)
Date:   Fri, 24 Dec 2021 20:43:43 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Clark <James.Clark@arm.com>
Subject: Re: [PATCH v1] perf synthetic-events: Return error if procfs isn't
 mounted for PID namespaces
Message-ID: <20211224124343.GA2495042@leoy-ThinkPad-X240s>
References: <20211224124014.2492751-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224124014.2492751-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

+ James, sorry for spamming.

On Fri, Dec 24, 2021 at 08:40:13PM +0800, Leo Yan wrote:
> For perf recording, it retrieves process info by iterating nodes in proc
> fs.  If we run perf in a non-root PID namespace with command:
> 
>   # unshare --fork --pid perf record -e cycles -a -- test_program
> 
> ... in this case, unshare command creates a child PID namespace and
> launches perf tool in it, but the issue is the proc fs is not mounted
> for the non-root PID namespace, this leads to the perf tool gathering
> process info from its parent PID namespace.
> 
> We can use below command to observe the process nodes under proc fs:
> 
>   # unshare --pid --fork ls /proc
> 1    137   1968  2128  3    342  48  62   78	     crypto	  kcore        net	      uptime
> 10   138   2	 2142  30   35	 49  63   8	     devices	  keys	       pagetypeinfo   version
> 11   139   20	 2143  304  36	 50  64   82	     device-tree  key-users    partitions     vmallocinfo
> 12   14    2011  22    305  37	 51  65   83	     diskstats	  kmsg	       self	      vmstat
> 128  140   2038  23    307  39	 52  656  84	     driver	  kpagecgroup  slabinfo       zoneinfo
> 129  15    2074  24    309  4	 53  67   9	     execdomains  kpagecount   softirqs
> 13   16    2094  241   31   40	 54  68   asound     fb		  kpageflags   stat
> 130  164   2096  242   310  41	 55  69   buddyinfo  filesystems  loadavg      swaps
> 131  17    2098  25    317  42	 56  70   bus	     fs		  locks        sys
> 132  175   21	 26    32   43	 57  71   cgroups    interrupts   meminfo      sysrq-trigger
> 133  179   2102  263   329  44	 58  75   cmdline    iomem	  misc	       sysvipc
> 134  1875  2103  27    330  45	 59  76   config.gz  ioports	  modules      thread-self
> 135  19    2117  29    333  46	 6   77   consoles   irq	  mounts       timer_list
> 136  1941  2121  298   34   47	 60  773  cpuinfo    kallsyms	  mtd	       tty
> 
> So it shows many existed tasks, since unshared command has not mounted
> the proc fs for the new created PID namespace, it still accesses the
> proc fs of the root PID namespace.  This leads to two prominent issues:
> 
> - Firstly, PID values are mismatched between thread info and samples.
>   The gathered thread info are coming from the proc fs of the root PID
>   namespace, but samples record its PID from the child PID namespace.
> 
> - The second issue is profiled program 'test_program' returns its forked
>   PID number from the child PID namespace, perf tool wrongly uses this
>   PID number to retrieve the process info via the proc fs of the root
>   PID namespace.
> 
> To avoid issues, we need to mount proc fs for the child PID namespace
> with the option '--mount-proc' when use unshare command:
> 
>   # unshare --fork --pid --mount-proc perf record -e cycles -a -- test_program
> 
> Conversely, when the proc fs of the root PID namespace is used by child
> namespace, perf tool can detect the multiple PID levels and
> nsinfo__is_in_root_namespace() returns false, this patch reports error
> for this case:
> 
>   # unshare --fork --pid perf record -e cycles -a -- test_program
>   Couldn't synthesize bpf events.
>   Perf runs in non-root PID namespace but it tries to gather process info from its parent PID namespace.
>   Please mount the proc file system properly, e.g. add the option '--mount-proc' for unshare command.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/synthetic-events.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 198982109f0f..cf7800347f77 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1784,6 +1784,25 @@ int __machine__synthesize_threads(struct machine *machine, struct perf_tool *too
>  				  perf_event__handler_t process, bool needs_mmap,
>  				  bool data_mmap, unsigned int nr_threads_synthesize)
>  {
> +	/*
> +	 * When perf runs in non-root PID namespace, and the namespace's proc FS
> +	 * is not mounted, nsinfo__is_in_root_namespace() returns false.
> +	 * In this case, the proc FS is coming for the parent namespace, thus
> +	 * perf tool will wrongly gather process info from its parent PID
> +	 * namespace.
> +	 *
> +	 * To avoid the confusion that the perf tool runs in a child PID
> +	 * namespace but it synthesizes thread info from its parent PID
> +	 * namespace, returns failure with warning.
> +	 */
> +	if (!nsinfo__is_in_root_namespace()) {
> +		pr_err("Perf runs in non-root PID namespace but it tries to ");
> +		pr_err("gather process info from its parent PID namespace.\n");
> +		pr_err("Please mount the proc file system properly, e.g. ");
> +		pr_err("add the option '--mount-proc' for unshare command.\n");
> +		return -EPERM;
> +	}
> +
>  	if (target__has_task(target))
>  		return perf_event__synthesize_thread_map(tool, threads, process, machine,
>  							 needs_mmap, data_mmap);
> -- 
> 2.25.1
> 
