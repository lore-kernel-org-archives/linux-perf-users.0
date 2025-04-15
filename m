Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656E71A3163;
	Tue, 15 Apr 2025 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724917; cv=none; b=bYe804QLD7t6TAj3L09gihnQpRifD1dyU6kuzK/ZMLp4UCqIW6Y0ylcQ+Q9nzmALSn1uW4G1Whn4N5p0GIeVAzslJkWspYE751jIG8V+4ZneW4CZr0lReAkeObycKKlxYVmZrXW+7m00DCfkYUPxcH2q9L7Ouc2QxA70GCjOu/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724917; c=relaxed/simple;
	bh=kgM1FwNjGq6qSmmgWtC2WdCn29M56dwgxDebCLwDY2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLbcdgOfNRR/3X5kiJQYGJPCH8GOjHrc3CM76acnWunsoR6itf8TqDwjbKIjuCllbYKzaWgZqVkWSknFQjk5nGqJdy5sIj/j8f3Lh4y66r5pJ7PELr4lY0vn9KiZNKLoW2R9piu9cwfH9DEeQqtzW9Whgr68zy8xzSzGt8roqBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YrO1vG1k; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YrO1vG1k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V665uomEftWMnY02o1tbsGyNrT4RxPy6B9Au5unyhCw=; b=YrO1vG1kO9sfz1s/fGywwDww2S
	i6eq7hqDFTv+oEjZ0QCQy9VcqV7PRL15903+yM/J/B1TVc5i9dtZHiNhB9dlqkt/1fql7sdxz2mE+
	+C4FI4curBsBH81QKfXSxKhYHK/8Ly4DiFOFcwMbSdXaDK0OZTQop4PSrjR0OjGw70xv2p9OfJI0g
	uyIFnaf+JwiihjVuk5FXBA+kQkpIfPCfpY9clZYmF8ITmYpHLYacaxdeRI68UepSiFOQdFAEgS02m
	krPTQDJZq3WTcZHV7omdoMcCXABtzY6BlQh/sQBbPSn31/DbKv0L27odDfeKlcMj/tK6k6tkyPnF4
	KkYbEyVw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4geM-00000009tyv-14ML;
	Tue, 15 Apr 2025 13:48:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CF140300619; Tue, 15 Apr 2025 15:48:29 +0200 (CEST)
Date: Tue, 15 Apr 2025 15:48:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v3 11/22] perf/x86/intel: Allocate arch-PEBS buffer and
 initialize PEBS_BASE MSR
Message-ID: <20250415134829.GB4031@noisy.programming.kicks-ass.net>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
 <20250415114428.341182-12-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415114428.341182-12-dapeng1.mi@linux.intel.com>

On Tue, Apr 15, 2025 at 11:44:17AM +0000, Dapeng Mi wrote:

> +void fini_arch_pebs_buf_on_cpu(int cpu)
> +{
> +	if (!x86_pmu.arch_pebs)
> +		return;
> +
> +	release_pebs_buffer(cpu);
> +	wrmsr_on_cpu(cpu, MSR_IA32_PEBS_BASE, 0, 0);
> +}

So first we free the pages, and then we tell the hardware to not write
into them again.

What could possibly go wrong :-)
