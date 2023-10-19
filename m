Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5D7168BE
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Oct 2023 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qbmetv/n"
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F795A3
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Oct 2023 04:52:38 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5b5354da665so2762817a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Oct 2023 04:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697716358; x=1698321158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=22LmJCxRhqy3YPjbMbUNcX4eco2+QIS+2sFMQqk3YxU=;
        b=qbmetv/nlvVlX2pUDW1dGsCrZ0mEugwH7/JZCKnki90PP1NmSLoGDxecXEzBix48oY
         G1/3tVrGeQHtLbN2mVbtLaN1W/doPJBkbhh+PEnd5xx8rK1UiWrODADxq/6gyBQwCKzx
         cfSAsvkuOflMloQu00OTo80x55XKcoBdsV2a1grU4kCM9xQdqaNuNB90A45bMjxM/xwO
         8PCB0MhmtC9EM77+ReWN8w2CuXyGQHUrzZ3ZoL7ceAZ2zN1yAoL0qDC0+S+INaOEUnnQ
         blJRXdEAge6ytN3iGCe68OiT0G9pAAJzVuHB41FrBxIIqN7NJODq94jrzMv4AyCibapy
         KHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697716358; x=1698321158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22LmJCxRhqy3YPjbMbUNcX4eco2+QIS+2sFMQqk3YxU=;
        b=CckULJim0HgX2FLd1uV74rqNPiC6Gx+Ni7iMa1ngw3c9R2JneUXBzGRYim+iOJmXII
         4fu58CXidlLLclK1GklE1STQDKVR2f/JW248dQcsj3l0GpGtCQbth8T7xd7alBupboJt
         x2tqLGtoq8TS2QsRIKQzY7SclwnWf+EmZSfZRH4X1Xzrx9sUMfZwrYTdxI640iYe4USZ
         lB3oQvft/2erQYm0LmttGvBeNbI2SL54049ncP/x2eJIBx7pLiyQ9jIDcwPp2QbjuwnD
         wQowBuNxKreQdCb69liXu0HYpXJ+czdlqhyf1RJtt0T5R3rEpGJHpF6zH+J1sRGoC0ZT
         Zxbg==
X-Gm-Message-State: AOJu0YygTc8yFfpszDwH4Tbc6wpBtfqqs4nejo11/25dyr8FVwG4hFFq
	ylzP+Jndqz36lJxWjk9VZ802WQ==
X-Google-Smtp-Source: AGHT+IHft1phUMs9Gc6nqNrQmOuiezb5GfIAZFWSGXY7BLWpfgUU9DEclWYxdQT3NXW8vUEZmsEGsQ==
X-Received: by 2002:a17:90b:1e06:b0:27d:3260:9142 with SMTP id pg6-20020a17090b1e0600b0027d32609142mr1732419pjb.45.1697716357854;
        Thu, 19 Oct 2023 04:52:37 -0700 (PDT)
Received: from leoy-huanghe.lan ([98.98.49.160])
        by smtp.gmail.com with ESMTPSA id c91-20020a17090a496400b0027dc483be23sm1595781pjh.26.2023.10.19.04.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 04:52:37 -0700 (PDT)
Date: Thu, 19 Oct 2023 19:52:31 +0800
From: Leo Yan <leo.yan@linaro.org>
To: James Clark <james.clark@arm.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v1 1/2] perf auxtrace: Add 'T' itrace option for
 timestamp trace
Message-ID: <20231019115231.GF105208@leoy-huanghe.lan>
References: <20231014074513.1668000-1-leo.yan@linaro.org>
 <20231014074513.1668000-2-leo.yan@linaro.org>
 <1bef7744-78ef-f673-a33b-6f8fb00e033b@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bef7744-78ef-f673-a33b-6f8fb00e033b@arm.com>

On Thu, Oct 19, 2023 at 11:31:16AM +0100, James Clark wrote:

[...]

> > --- a/tools/perf/Documentation/itrace.txt
> > +++ b/tools/perf/Documentation/itrace.txt
> > @@ -25,6 +25,7 @@
> >  		q	quicker (less detailed) decoding
> >  		A	approximate IPC
> >  		Z	prefer to ignore timestamps (so-called "timeless" decoding)
> > +		T	use the timestamp trace as kernel time
> >  
> 
> Maybe "Treat hardware timestamps as kernel time (trace and CPU time use
> same clock source)" would be clearer.

Agreed.

> And another point, although this isn't really related to this patch, but
> why do we have the single letter arguments for itrace? It seems like it
> massively restricts the available options and makes the command lines
> hard to read because they don't have long forms. Why not just have them
> as normal arguments?

TBH, I tried a bit for adding a normal argument, but I found it's not
nature like itrace option for passing the normal argument into the
decoder.  And if we add a normal argument, we need to consider adding
into perf commands for 'perf report', 'perf script', etc; itrace options
can be shared by perf output commands.

I understand an advantage of using normal argument is the 'perf report'
command (e.g. perf report --aux-trace-kernel-time) doesn't need to
specify any extra itrace option.

If anyone still has concern for adding itrace optiona and prefer to add
normal argument, I am happy to rework for adding normal argument.

> If it's a backwards compatibility thing, would there be any objection to
> adding this new option as a normal one rather than an itrace one?

backward compatibility would not a problem - we add a new feature and
at meantime we don't break anything.

> >  	The default is all events i.e. the same as --itrace=iybxwpe,
> >  	except for perf script where it is --itrace=ce
> > diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> > index a0368202a746..f528c4364d23 100644
> > --- a/tools/perf/util/auxtrace.c
> > +++ b/tools/perf/util/auxtrace.c
> > @@ -1638,6 +1638,9 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
> >  		case 'Z':
> >  			synth_opts->timeless_decoding = true;
> >  			break;
> > +		case 'T':
> > +			synth_opts->use_timestamp = true;
> > +			break;
> >  		case ' ':
> >  		case ',':
> >  			break;
> > diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> > index 29eb82dff574..55702215a82d 100644
> > --- a/tools/perf/util/auxtrace.h
> > +++ b/tools/perf/util/auxtrace.h
> > @@ -99,6 +99,7 @@ enum itrace_period_type {
> >   * @remote_access: whether to synthesize remote access events
> >   * @mem: whether to synthesize memory events
> >   * @timeless_decoding: prefer "timeless" decoding i.e. ignore timestamps
> > + * @use_timestamp: use the timestamp trace as kernel time
> >   * @vm_time_correlation: perform VM Time Correlation
> >   * @vm_tm_corr_dry_run: VM Time Correlation dry-run
> >   * @vm_tm_corr_args:  VM Time Correlation implementation-specific arguments
> > @@ -146,6 +147,7 @@ struct itrace_synth_opts {
> >  	bool			remote_access;
> >  	bool			mem;
> >  	bool			timeless_decoding;
> > +	bool			use_timestamp;
> 
> And then this one could be like "hw_time_is_kernel_time", but I'm
> stuggling to think of something shorter. Maybe your one is fine along
> with the comment.

It's fine for me to rename as "hw_time_is_kernel_time" for more
readable.  Will do in next spin.

Thanks,
Leo
