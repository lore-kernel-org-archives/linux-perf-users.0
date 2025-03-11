Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EFF221F11;
	Tue, 11 Mar 2025 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692938; cv=none; b=Ewtq861pK1oTu121rRX/wvEgBBJBUoWL4hSTCMx9zbgJ0Qa5wEDVvWdA/K9lsLEAo3MOaQrtnAz9+WJGZD0yKcq0Fks4LVxv/WI02+791mKIT2+0rUkVTXDrJwZJOPYiRPoD+lq42NmX5yHwLwCNZTqmVanmX5RBDSsq64cZQz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692938; c=relaxed/simple;
	bh=N8NL/qaRq4a+Nf+VD9g9xmrsZpw1DnhUqY03RO5WZA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlxSh7tZOBoX5f/ElaJyEoDXFNV2CeXLdSQtyBmkMbYaPo3NHBYnnzOKcTvKVc2KSsWXQm0N8aARS+sj/luUTeWPrpraeCcKXEbY3Zqgf8GvxnGdt6CBkyX9DYTfIZJtknIGw444u5m1zeUndxQQJexNSJYSjGZi8IM7ei6NeDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xbb8eFP8; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xbb8eFP8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=fRHIjCyQ/PiBBvxdoAc2u4R5/Wp/k6YbQ2LIfCHzQ6U=; b=Xbb8eFP8WKMU6pPMHzrwRD3zcz
	1YInEF1jdvWWpQpk7wfSujd4RLlLu4i26vK5cCW61YjrlYPc0YgFHSUczx1Yy741YZ7ELzUpp9MnZ
	+2RPzVN7s9wDQMYEypiHXSGmbyGzH7/ZBCDtPNGEktjX4LlrCT/9mo6Kh8NbXJ3shpY+m+Pb2U7J7
	DopRK4fBm2JZCEqy00xvCEOthBO/fowl3DHQzYAQCdCZnwAaVFon6nL0ofqjDH35XNmNTrrf7Q9pv
	qTk5bqjjp0B5/yRihUltc424AuwQoQd3BCznH/a5s7bdrs68BpujxOFMX7E8Cm3xDaPfU82bCU7SN
	gK99Q09Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trxtS-000000028WB-2LuY;
	Tue, 11 Mar 2025 11:35:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 252CE3002C7; Tue, 11 Mar 2025 12:35:30 +0100 (CET)
Date: Tue, 11 Mar 2025 12:35:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mark.barnett@arm.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, ben.gainey@arm.com, deepak.surti@arm.com,
	ak@linux.intel.com, will@kernel.org, james.clark@arm.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/5] perf: Allow adding fixed random jitter to the
 alternate sampling period
Message-ID: <20250311113530.GA9968@noisy.programming.kicks-ass.net>
References: <20250307202247.648633-1-mark.barnett@arm.com>
 <20250307202247.648633-4-mark.barnett@arm.com>
 <20250311113128.GD19424@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250311113128.GD19424@noisy.programming.kicks-ass.net>

On Tue, Mar 11, 2025 at 12:31:29PM +0100, Peter Zijlstra wrote:
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index b87a5ac42ce2..e5a93edf3b5f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8,6 +8,7 @@
>   *  Copyright  ©  2009 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
>   */
>  
> +#include "linux/random.h"
>  #include <linux/fs.h>
>  #include <linux/mm.h>
>  #include <linux/cpu.h>

Argh, this is neovim trying to be 'helpful'. If anybody reading this
knows how to make it stop adding headers, please let me know, its
driving me nuts.
