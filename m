Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20FF2D5950;
	Tue, 24 Mar 2026 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361473; cv=none; b=bfNHPv+MweqJEaa48o/tbON6Jbc5caYyPlAycfMAs7yKrwASVuSj0SjCGxiCh5g9FjBFw2ZeQYknTbz+OQyitddu3dwQyLB9EjWLsSHVTPNPtaSEFfUQXpMHJ0feEE+0CxTu7lai7RDhLy7StN38xFG6P09vUS+Y1qYUoYIY3Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361473; c=relaxed/simple;
	bh=Y3sNoYWIj73JRndD3CMspGqfg9ytNZF735DoB3CazPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5LZgZHvSUGtBJHb7A+K7gzhtnuSrnEb7mZXW2xwhb+AJhGCo2UJ6yKIXhGzt75KnauePdoQqFGpW0XwZdhgpsUhWBV6Ey5tQqJBDaJS4nHWFmaJJURiUoPLxVZ3vfN1Yk95zw6OPTxlxPUBJOwp/m/RgRzPmtN3MT9cbrYMknQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BZAE9aRX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BZAE9aRX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=H7n+QrXXSaIaAxwOyaWDEXy9usylHrhcJhyke33iXW8=; b=BZAE9aRXGVm1nxFrNzQDh1IVq6
	WzLau0Bjd7ODJFGTz7YiqNoAZEpR5NyIh4jA77knPM8XHNVRKz58anWQooReIAVCHrPm8MIJkT0Sz
	imRS3bZdkvkYLhP3deufoAq94932jdYpyJcRsnW8rwgonu0MKl1kQi5LkltYWB3HWcgItfKO2EVEU
	QTNHuZUNpXW5nCwXEXBAJUXlRJ8YH+RvMKUibXs4Hpy8lslEcWrz4XSyD9GVIrSWgdlqbcCbI8g3g
	FyDcLCkXGdriLr6oybeyVWjMUXBkYRBHa1AkugVgBO+WEVEi5NTBt1mFjhUjJ4mvUlrnEs5sPLiGx
	tgxE4JmA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w52TE-00000004FJc-3BHr;
	Tue, 24 Mar 2026 14:11:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 35B123002D8; Tue, 24 Mar 2026 15:10:59 +0100 (CET)
Date: Tue, 24 Mar 2026 15:10:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, tglx@kernel.org,
	bp@alien8.de, dave.hansen@linux.intel.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	hpa@zytor.com, x86@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v2] perf/x86/intel/p4: Fix unused variable warning in
 p4_pmu_init()
Message-ID: <20260324141059.GG3738010@noisy.programming.kicks-ass.net>
References: <20260319152210.210854-1-aldocontelk@gmail.com>
 <20260320112302.281549-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260320112302.281549-1-aldocontelk@gmail.com>

On Fri, Mar 20, 2026 at 12:23:02PM +0100, Aldo Conte wrote:
> Build the kernel with make W=1 generates the following warning:
> 
>   arch/x86/events/intel/p4.c: In function ‘p4_pmu_init’:
>   arch/x86/events/intel/p4.c:1370:27: error: variable ‘high’ set but not used [-Werror=unused-but-set-variable]
>    1370 |         unsigned int low, high;
>         |                           ^~~~
> 
> This happens because, although both variables are declared and
> initialized by rdmsr, only `low` is used in the subsequent if statement.
> 
> This patch uses the rdmsrq() macro instead of the rdmsr() macro.
> The rdmsrq() macro avoids the use of high and low variables
> because it reads the msr value in a single u64 variable.
> Also, replace (1 << 7) with the proper macro.
> 
> Running `make W=1` again resolves the error.
> I was unable to test the patch because
> i do not have the hardware.
> 
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
> ---
> v2: 
>  - Use of rdmsrq() instead of rdmsr() to read the full 64-bit MSR
>    in one single read avoiding the use of high and low.
>  - Replace (1 << 7) with the MSR_IA32_MISC_ENABLE_EMON
>  - Remove pr_cont() with MSR printout added in the previous patch
> 
> v1: https://lore.kernel.org/all/20260319152210.210854-1-aldocontelk@gmail.com/
>  arch/x86/events/intel/p4.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

In general I figure people using W=1 can keep the pieces, but the split
msr interface is a relic, so yeah, lets clean this up.

Thanks!
