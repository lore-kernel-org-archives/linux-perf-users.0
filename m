Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189504;
	b=EbhBlmPqvIdYwYj6C+6Ii/07MUGAU/rTKmupdiYKX4iMF/yw0zhr/JqHMccOTSE23wTg
	 8IvxxUStBKAjGqo9Ya8xozAUo3rSwpCodgws2lM+EVBTnOFiKHWpm6A5Wpt7N+kCNWid1
	 1XxtbfJDtTVQK4TkL64epnvVXThhfC1qelMosEmpVaNoj27LgtELi/2qKMglbrBa6VSY0
	 8TyiCrXpDq82GZ3jV0K9CPvwFPzu9cNQjthJy+gwzDynenrZRBdUBpb2DomSgW9Kavu3v
	 im8o2zAq2+yIsgU7cNP49CQH3pUAGstnE1uM8h+MZQDjMRIBsZKS3Ak3PBt9c7Z395Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189504;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=6QLG5/YNSyunp66wi2G54jlWRh4d2MdsiZoJ8fG1Qag=;
	b=FVQZD3mZYvKApoLxuTSq5UQ8o50xKmfxlGBG3Guljg+cxYhmCmbYqUaK2r5xypv0rQ9J
	 A0r+e1QsHMKw7PqR4Sk0pemv68MIMJtYOcYjsBUm+sWM6v214FcZ3TIHY08NNBlQrtRiI
	 ESDmFHraPt2E8ffrYIkr8Wa3jkgmwdxOXrZGegEWVPfqzlvLSkA2MI7sjBELk1KHQd6Xl
	 +DQkgSU5DQFQxm8OmmhJ1XsJb4OAApXLpp0HVhU9qNMWKYua/RMk/3jN+g1PhTsqN2OFm
	 t8ZG/X8hqU6EotqoARCMOSwhFZ1keNw4ub+NiOn4yh1RIRbRvPaXpiRTGqgY3ICn78g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=F6Af7a+B;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF1B606A32C;
	Fri, 20 Nov 2026 15:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEF1B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=F6Af7a+B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6QLG5/YNSyunp66wi2G54jlWRh4d2MdsiZoJ8fG1Qag=; b=F6Af7a+BYs0BDmmODuoYtBR346
	yNguJtJ3FNvUxAMSuQsz4UxvtwlzqbSiXQ2ZgO00CyBHD+Yo+pBk5LkMsFn9m+Je/boSHzF/ZIORM
	VVoorovm+UbGa46YQYE/KGudPyp6GtJkS7rd/IUqrbSHNdzD5BdK2llbMcSvydLpyQI+oUy6GUJEx
	zODNr4VTXVDMSQTpl4Tfz+G395R972l3N7vIX5KRFCdcuqTLRgZc7XPImItDrsyj04msNAMzxopYC
	mmheqGmKe5ov3+LQzba3KcDrDK5TqV8wC1Y3OY2FjHvTTd06NMA5F28nubs1cnqkHeVsD5HqoD8V+
	WCB6N9YQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUQnK-00000007Bhw-1oBi;
	Fri, 20 Nov 2026 15:44:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 74CEC3008D6; Fri, 20 Nov 2026 16:44:57 +0100 (CET)
Date: Fri, 20 Nov 2026 16:44:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] perf/core: Prevent duplicate sigtrap task work
 enqueue
Message-ID: <20261120154457.GZ2668564@noisy.programming.kicks-ass.net>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>

On Thu, Nov 19, 2026 at 09:51:00AM +0000, Tengda Wu wrote:
> The sigtrap handling in __perf_event_overflow() checks
> event->pending_work before calling task_work_add(), but only sets
> pending_work after the task work has been queued.
> 
> This leaves a window where an NMI can interrupt task_work_add()
> and re-enter __perf_event_overflow() for the same event. Since
> pending_work is still zero, the nested invocation can enqueue
> the same pending_task again.
> 
> The re-entrant call path looks like this:
> 
>   __perf_event_overflow()
>     task_work_add()
>       kasan_record_aux_stack()
>         <NMI>
>           __perf_event_overflow()
>             task_work_add()

How? If an event is NMI driven, it will only ever cause an overflow from
NMI context.

If it is not, then the same event will not trigger from NMI.

Some key ingredient is missing here. Is this some software event that is
missing recursion checks?
