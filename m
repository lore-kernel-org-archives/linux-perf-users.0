Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94784192B63;
	Sat, 16 Nov 2024 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731751923; cv=none; b=pLeX1j0OEzEaCS7Od8cLjsWd37Vqdv8Vu3Pn/L8bG68w2Wx9XabtmLzqVJmQtL995Em7XcRu2+4qI3huxW0MhHgWwOVSCRE29wyOyTIzHFwr+VvEfxLCsJfS1gRH1cuhVucIAPXd+Z0w9MTLqA3AmhZ6WkIqOH20oq466ndiOlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731751923; c=relaxed/simple;
	bh=5NKoX1o0+N+/87VF8PmZzAC1PldZcWcs54nPzNqOAnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ly863/BrUsXjSVRC2UvELGAXIhIHAUb0sF0ZAoqBoVx+YNEcaUweIvWBvNK4I8z9vR/lHBRzHV3JsONWXL9mPlaDqnRODTkXbFG6oeh9rqeOeIqG57JZ9T+zKZ2xFlA9TUonP0wucXsIPU21k9xULoSknRr9e30JJWfJpwHvTI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CpqO4G34; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CpqO4G34"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SSeK63EQi6IbOUli0DOSPjyqpwmt00Th1sEf4Dz5Ib0=; b=CpqO4G34QEHNpBwGT6gEtuUszl
	joeh8lYMf2jgD9+15bAV8kB8WSeJ9KPlKr8z69m6xeXog6nTY9MMc1bh4XZ+G2DfZ7cqaocAxyMzo
	185zIWXvLWwQqfmbRkPxu1ibZ4d45gDFc+1tg5c5k/XoNGzJUP+2j0Vq7E4r6U4opellpOO1t5pvZ
	0lokNhdO3vY6ZAHwOslsgc1pqGml2L71mlpU9B7oDOljPPAtdFLihLLrrvQuDVramDeNPB7xqb6qZ
	mBGR70yyAVrPeHw5lsv1l920QZ3QYVpx1qFeS/JVbAkM9izCNxhk2c0pY5tgWEgKcZeg/F+QRVw1J
	MWFCmYoA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tCFmQ-000000000h9-3MsU;
	Sat, 16 Nov 2024 10:11:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4002B300472; Sat, 16 Nov 2024 11:11:50 +0100 (CET)
Date: Sat, 16 Nov 2024 11:11:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ragavendra <ragavendra.bn@gmail.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel: Cast u64 variable
Message-ID: <20241116101150.GO22801@noisy.programming.kicks-ass.net>
References: <20241115225829.112361-2-ragavendra.bn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115225829.112361-2-ragavendra.bn@gmail.com>

On Fri, Nov 15, 2024 at 02:58:30PM -0800, Ragavendra wrote:
> Casting (1 >> bit) to u64 before it is compared with pebs_status variable.

I don't think this does what you want it to.

> Fixes: 21509084f999 perf/x86/intel: Handle multiple records in the PEBS buffer
> Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
> ---
>  arch/x86/events/intel/ds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index fa5ea65de0d0..9ea147565dc2 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2072,7 +2072,7 @@ get_next_pebs_record_by_bit(void *base, void *top, int bit)
>  			/* clear non-PEBS bit and re-check */
>  			pebs_status = status & cpuc->pebs_enabled;
>  			pebs_status &= PEBS_COUNTER_MASK;
> -			if (pebs_status == (1 << bit))
> +			if (pebs_status == (u64) (1 << bit))
>  				return at;
>  		}
>  	}
> -- 
> 2.46.1
> 
