Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8375A148838;
	Mon, 27 Jan 2025 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737993080; cv=none; b=KyHrynpxj/ik5IcCfmOBHsJa2Z8RElSS9lSI9oSfsLsSfKROpk2y/Pzmp/rxiD1bj57hDpYiyS+o91XWdSeSB5uNpZdy/e8lIRAjO+PUs7PgqdDK4rCOYTLCsNO/u7crottIPTr1LM6G9EaLyHjTgSEMyHWkDVdJ6ErFEP8CwY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737993080; c=relaxed/simple;
	bh=JnwVG8HtlJ0EhdKrUf7piX6aex0TOzdobRkJCWtD7bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kb9J805+LEJQZUGrt+xt2ejcfc0Zfl9QmO3PX2CH91PApUBWhNjH4OkGEqkDgb+YP0e4+Ubzk4lWWGMv8lWPSRG4FPMmiKYSGcKybxdZ4A3lghjl0bDRh2XYYJHa0BhiY6sOt0FMC+gf3qFcOsMQuc/4QrpVFQUB/yJIgujUmQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=csBQ+3K1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="csBQ+3K1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Po4qIZq0ieETpInc4lQhkQyrHct9W283jEO0VP99gws=; b=csBQ+3K1entUkaWntaMZhbDsDB
	9RrP5GyfspaqaKRr5TM0IZuPFJgBF5zdWM7NmcBTHvq6gnhdSx+9+5XCAjp5BtFurWKC8Yhr6g+mC
	Nl2Btnrq0X+FNLrxkmrNUJMZ27ewhrA9jp3s7dPzn3rqlEkn5ctVqroQYTa9vcF4G8uvpFPuwT9+l
	n64qw/FwigGVmcfno0x9AflkIWE/951tG8suVjrKdekQQf+9XIHWAGKSubLY35UCP7uoJw1t3V/qQ
	lLbX9Jj6+ttKE5qKPRJqC15G7RDB9r7IJJ8YLCJ82GjfA6jqtf5FhGuEeRhBp9x+fZs9TG4mgmpj6
	tsF9D4CQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcROH-0000000EisY-0Isi;
	Mon, 27 Jan 2025 15:51:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1CE9E3004DE; Mon, 27 Jan 2025 16:51:08 +0100 (CET)
Date: Mon, 27 Jan 2025 16:51:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH V10 4/4] perf/x86/intel: Support PEBS counters
 snapshotting
Message-ID: <20250127155107.GI16742@noisy.programming.kicks-ass.net>
References: <20250121152303.3128733-1-kan.liang@linux.intel.com>
 <20250121152303.3128733-4-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121152303.3128733-4-kan.liang@linux.intel.com>

On Tue, Jan 21, 2025 at 07:23:03AM -0800, kan.liang@linux.intel.com wrote:

> @@ -471,6 +477,15 @@ struct pebs_xmm {
>  
>  #define IBS_CPUID_FEATURES		0x8000001b
>  
> +struct pebs_cntr_header {
> +	u32 cntr;
> +	u32 fixed;
> +	u32 metrics;
> +	u32 reserved;
> +};
> +
> +#define INTEL_CNTR_METRICS		0x3

I've moved this up a little, so that all the adaptive pebs crud is
together.

Other than that, I've picked up these patches and will merge the lot
past -rc1.
