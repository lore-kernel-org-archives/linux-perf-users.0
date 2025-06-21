Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FD6433B1;
	Sat, 21 Jun 2025 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750498050; cv=none; b=M7YETrfvfxMvlcBNjx4yiCEkyPuTl55NcFlp4+9R3TpJanGb5uCxRLnLm3TxlLT556B6DCsDyqcbolxmAVp0Papa7DRHA2UIC9g3DP13w0oZpemC3bi4wDljyB9kfT/t/ZqcBC5jsS9wsCPtGKz4gaQx6/+HU9ZU71V/9T9X3c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750498050; c=relaxed/simple;
	bh=rsZ4iq0NBsSGew7NtqE1YWF6kFco4qQQ29i8FGnFZg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tc/RsZTNPN0ijdukdrAKlTYb7D8k5EMNWLXrxYuUisHRjvoMIFkHQerg5wT8Yue3h24JWtm7bCg+FtyzKuGY5ASNy9T8Oo1YY63ZEz6CmesQ2gyDroQcHLQatYSGk9fa3SeNM+3s89JNKwX3LcIbEhCsaQGEVcEsSCerm66Tl4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B1BcQJSn; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B1BcQJSn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zk5J05vGv86LW0R0C8DpwBqRnY3hN47VIgx3GpO7ReY=; b=B1BcQJSnQwp846DEDmNlE+uBZ+
	f9xCqV7kLpLPQbIRCXXwMebK0KHOT3rgRu3JLIOxbo/vjCyr763xx48V/d63zmpPbb501SxZT/sbH
	KjnyKzs6aDhjKRetHT2UtgTYEqYYcNf+Oa8Q1CW5ZG28WsAt8IHurVHvKe0c7AK8/aNgCaZGqr/7/
	qU4FfpLReSnx8qL0XyXnJ8O49lvvM6rb/LdCJLQ188is4zH2rTKP83Jdw1sqxCiCCyIOYwEWsWcdT
	iE0ZD9EHFcPnerJ44OVhqDcc3Q8IMJa2SvZz9KBYAp7H7OgkSWuzYbJwNHTw7HXghYSe3xulSh8gI
	PrYLYO5A==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSuVM-00000004t5W-0O0m;
	Sat, 21 Jun 2025 09:27:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BC6D23087E7; Sat, 21 Jun 2025 11:27:18 +0200 (CEST)
Date: Sat, 21 Jun 2025 11:27:18 +0200
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
Subject: Re: [Patch v4 09/13] perf/x86/intel: Setup PEBS data configuration
 and enable legacy groups
Message-ID: <20250621092718.GU1613376@noisy.programming.kicks-ass.net>
References: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
 <20250620103909.1586595-10-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620103909.1586595-10-dapeng1.mi@linux.intel.com>

On Fri, Jun 20, 2025 at 10:39:05AM +0000, Dapeng Mi wrote:
> Different with legacy PEBS, arch-PEBS provides per-counter PEBS data
> configuration by programing MSR IA32_PMC_GPx/FXx_CFG_C MSRs.
> 
> This patch obtains PEBS data configuration from event attribute and then
> writes the PEBS data configuration to MSR IA32_PMC_GPx/FXx_CFG_C and
> enable corresponding PEBS groups.
> 
> Please notice this patach only enables XMM SIMD regs sampling for

What's a patach? :-)
