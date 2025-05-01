Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F51518E050;
	Thu,  1 May 2025 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746130858; cv=none; b=c89qmt6/7UitgG9Q479HfYnQV+t3nXOmCTNUb4lqYrK8WYlZ2bUSO1tBoOKRKHfMluGi2C3bGpcXTbx4etC93Bxrt3/0gjBlmiCoz4Wl4SvRsZ0Y8ZBXU7J1cDjtj7bG84Fjh3TNgUFL56bpFIiJN2DHmA+YPa4uu1IITT3H2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746130858; c=relaxed/simple;
	bh=jg09SLQKpeYuh6n7heM5Myprmf3W4ZqI4xSoOgDqYuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFYqeZ4CctLVNXDCMsTjJ69jxIbiD8RpHxM7ws434aNdVuK29Sma9g2pMGtZt9HH8KDhDEC+5Yv7xBGTglZ+cAi212Mu2PibtP1B7KCPrwyOphcbCUG067hxgszdoUqa2VAOOOwO1CsDlMlHedt63WnS2j3kCIvJ275lEyPgmFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJZVB2xW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJZVB2xW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB382C4CEE3;
	Thu,  1 May 2025 20:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746130857;
	bh=jg09SLQKpeYuh6n7heM5Myprmf3W4ZqI4xSoOgDqYuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJZVB2xWwpvqAx54RlDXkSgYC48IDOYQASkO8Oz0Ygx4IOwLsYg9SJdNQ9c35rczd
	 NrTDGhcxeCKi0ghEntt2dHCtqCuVYS/S5iw1z5kGGQF6yXSiDAJASTmVWWfDQvMiV0
	 JXbA1tgrbo4LdyAY5nHZ0HExa6NnJczjZoBVxhhKLTR4KMpDZ50sVurf4K4LZH6+Ln
	 t/7KLquAQftb3w3aMG7n6uZ9q8Jyd2XBOF2MauaRKJulm4dIbgJLnIlDEX94MzsVUh
	 5oFdmc+mu9vKmqkbzWqjBBOesvYKo0xDDlLl6DaNF00PcAcfg0FYf7yqRnp8me8swN
	 JrhTRpwHJ9KeQ==
Date: Thu, 1 May 2025 13:20:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>,
	Blake Jones <blakejones@google.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Alexander Aring <aahringo@redhat.com>
Subject: Re: [PATCH v6 5/5] perf: Support deferred user callchains for per
 CPU events
Message-ID: <aBPXpyd8HM6JrDPg@google.com>
References: <20250501013202.997535180@goodmis.org>
 <20250501013506.751321323@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250501013506.751321323@goodmis.org>

On Wed, Apr 30, 2025 at 09:32:07PM -0400, Steven Rostedt wrote:
> @@ -13100,13 +13269,20 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>  		}
>  	}
>  
> +	/* Setup unwind deferring for per CPU events */
> +	if (event->attr.defer_callchain && !task) {
> +		err = perf_add_unwind_deferred(event);
> +		if (err)
> +			return ERR_PTR(err);
> +	}
> +
>  	err = security_perf_event_alloc(event);
>  	if (err)
>  		return ERR_PTR(err);

It seems perf_remove_unwind_deferred() is not called from
__free_event() - with double underscores.

Thanks,
Namhyung


>  
>  	if (event->attr.defer_callchain)
>  		init_task_work(&event->pending_unwind_work,
> -			       perf_event_callchain_deferred);
> +			       perf_event_deferred_task);
>  
>  	/* symmetric to unaccount_event() in _free_event() */
>  	account_event(event);
> -- 
> 2.47.2
> 
> 
