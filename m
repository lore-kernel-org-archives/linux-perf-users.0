Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="abH9ikdM"
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA82010CE;
	Wed, 29 Nov 2023 02:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/OekEShUlQdJpo7AqAfaxY+vi6Bol0LFK9LTWBoiQ5M=; b=abH9ikdMp2xRajwn9eXjNI/KOg
	Lugjk+J03nV25J4wm8/VAsB0k9Bq9Fyvu9PUe/dU8oZDnvjoXoUwWhpvB13zqiK76ie8AqQKiaVIL
	QrnjLjqnMAWY3FzNnL64l9KwFK6OWKI+vhrQc6er/btaes0Iu1me2jWgNdBFBZRXvNKcv1K2FKHvp
	glxDq3LMgoZ4nyGu2fzvAm0rLTQO8QhMEKSXlXuYCLZvW5Oz0krdizLlmseM+UDtl4xK3+b5WVqbO
	S4u1awcHr6Xr6jeE9arGWFB1upo8yi8jXcEzY73+RqUSM9D3ueK6t/xnbtusOC+ScXoLotNS3cq7r
	hDCZWf8A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r8IAh-000Jk4-0K;
	Wed, 29 Nov 2023 10:52:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 01183300293; Wed, 29 Nov 2023 11:51:57 +0100 (CET)
Date: Wed, 29 Nov 2023 11:51:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
Message-ID: <20231129105157.GE30650@noisy.programming.kicks-ass.net>
References: <20231123121851.10826-1-adrian.hunter@intel.com>
 <20231123121851.10826-2-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123121851.10826-2-adrian.hunter@intel.com>

On Thu, Nov 23, 2023 at 02:18:49PM +0200, Adrian Hunter wrote:

> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 39c6a250dd1b..1232e70adfba 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -456,7 +456,8 @@ struct perf_event_attr {
>  				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
>  				remove_on_exec :  1, /* event is removed from task on exec */
>  				sigtrap        :  1, /* send synchronous SIGTRAP on event */
> -				__reserved_1   : 26;
> +				aux_start_paused :  1, /* start AUX area tracing paused */
> +				__reserved_1   : 25;
>  
>  	union {
>  		__u32		wakeup_events;	  /* wakeup every n events */
> @@ -507,7 +508,15 @@ struct perf_event_attr {
>  	__u16	sample_max_stack;
>  	__u16	__reserved_2;
>  	__u32	aux_sample_size;
> -	__u32	__reserved_3;
> +
> +	union {
> +		__u32	aux_output_cfg;
> +		struct {
> +			__u64	aux_pause      :  1, /* on overflow, pause AUX area tracing */
> +				aux_resume     :  1, /* on overflow, resume AUX area tracing */
> +				__reserved_3   : 30;
> +		};
> +	};
>  
>  	/*
>  	 * User provided data if sigtrap=1, passed back to user via

So since you're adding a aux_output_cfg word, could you not also put the
start_paused thing in there?
