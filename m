Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612689;
	b=hNvqm1JavYlou5M3Xpp9JUPj5eb4Lmd4971zXB9lipMJGCs/iiftqQNccfdFNIhAeH/Z
	 h44igNY59hdzEefyd554yCn/l9APFG9z7cdPYsBvXGrx7kN8fQJntrfIwPBeuZdBnO05R
	 KNTKpa6IV8LexagbIoNtySCMhLvlrTSHhtu2IX+TP+Tzrq805eMuOvgGtnAoHSqZvgZJB
	 ZBa//IdgPkzjWsC4t4AY1Cy+a3/YHi6qNj0paBHR+sqSqs9J7A07Z25Pkh43jTf5lOzuJ
	 J4aNYMQErk5iXv28d8+O33OmyZ7b8X3e/icdeoJpw20+7MZdkNjki7LQZQ1oTvGpWug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612689;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=xBXsBRhD1j5TvqTbFEE8hpWV7kwgnehOiL5fSy8bkrM=;
	b=rvPFd1foMlbtJS759Ttt175LWEI3NxpFd51qx1tOEPpQkAMcw9xXBi8IlRWnntbMlWTb
	 WSQU5EmsIdW49rM7fl2qMCGsU6rVKrnArrJ+WU1QTlADRRO0DWiZU21NVQgpKRr23XzAa
	 us/1vcnjl8r7mayO1XssxHuZKCFGGBljYQdODKIgKGGFTnY8x+5HzBxksOauzh5ZoKOR9
	 yh/BEA6+I9Rx2bc1MaeUkzdqOexNBw3RmPdD3fPPqdj7DP3lZqYq2bu/hHMPb/1MgIuhb
	 +xl4udKLQ9nUqw05DP/4p6xuH3AdpT6J97Hv8IeO2nBKIaWW9REiR+HmduwWDgsFN+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=N6IXX+OV;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA314606A33B;
	Wed, 25 Nov 2026 13:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA314606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=N6IXX+OV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xBXsBRhD1j5TvqTbFEE8hpWV7kwgnehOiL5fSy8bkrM=; b=N6IXX+OVbg9xNoqRNL9faZ3Pzb
	AO1ZVpGgtUGuwmVwnIOghJEBgMdaSh5zxb7I+fHd/LKn0skNYOBFq8BODfxyq7vBqkxoXd5DClU77
	YYyDf6es6vwC+M7DB4GMDNQaPnpHugyqrnrDux9vDslnwePFkI73bMeaP9APnW0CzXIxOQ7XD+FUR
	f11Djo56WIhpUw8XsLWuKOhGWRAnH86SZeM4o9az9RAESmvhrWUTtzgohIJY0g/axyi1iLvOE+9Kh
	Y8CedNiNIRtAbmIKNFuNorSbMWP3K8x296MGE6KR4krcN0rNJIm6134ElYa2UlP7hVkLc9zRz4UVb
	zQd7kbSQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWCsm-0000000EVzF-47dO;
	Wed, 25 Nov 2026 13:17:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DF793300446; Wed, 25 Nov 2026 14:17:55 +0100 (CET)
Date: Wed, 25 Nov 2026 14:17:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>,
	"Steinar H . Gunderson" <sesse@google.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/19] perf/uapi: Factor perf_build_id out into its
 own top-level struct
Message-ID: <20261125131755.GA2668804@noisy.programming.kicks-ass.net>
References: <20261125005108.1020003-1-irogers@google.com>
 <20261125005108.1020003-3-irogers@google.com>
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
In-Reply-To: <20261125005108.1020003-3-irogers@google.com>

On Tue, Nov 24, 2026 at 04:50:51PM -0800, Ian Rogers wrote:
> Document struct perf_build_id as a top-level structure in the perf_event
> UAPI comment and add it to the PERF_RECORD_MMAP2 union comment so future
> sample types can reference struct perf_build_id directly.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  include/uapi/linux/perf_event.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index c49fc76292f7..deb7c42d109b 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -1099,6 +1099,18 @@ enum perf_event_type {
>  	 */
>  	PERF_RECORD_SAMPLE			= 9,
>  
> +	/*
> +	 * Build IDs may be present in a number of events. They have a
> +	 * consistent encoding of:
> +	 *
> +	 * struct perf_build_id {
> +	 *	u8		size;
> +	 *	u8		__reserved_1;
> +	 *	u16		__reserved_2;
> +	 *	u8		data[20];
> +	 * };
> +	 */
> +
>  	/*
>  	 * The MMAP2 records are an augmented version of MMAP, they add
>  	 * maj, min, ino numbers to be used to uniquely identify each mapping
> @@ -1123,6 +1135,7 @@ enum perf_event_type {
>  	 *			u16		__reserved_2;
>  	 *			u8		build_id[20];
>  	 *		};
> +	 *		struct perf_build_id	bid;

Why not remove the anonymous version?

>  	 *	};
>  	 *	u32				prot, flags;
>  	 *	char				filename[];
> -- 
> 2.56.1.831.g720f3f5937-goog
> 
