Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F382E6CCB;
	Wed, 29 Oct 2025 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732718; cv=none; b=kMfLGn+oUWNVn1XkNeTfyoniE90OadMhnsjeR8LJO7uHzhNtOPHb4qOdLgBJfxcY4QJuWPIU/OfRHx0pbJg4VwAR+q2vNiy2gqyUX6SlQrk0umH5CbLwd3IYXSyjDkEDRHa89bj+p6++L67RJmLYLbQ6LL8nNte99IPJv9NL0QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732718; c=relaxed/simple;
	bh=CUUOdyc/khnhMaB/pO72Lo9pzWdd7f2cZa7Ceux+uPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrdABoMSUh5SlBuopQX/9KZHfAUO0AE9OwL8bKDBWAc93G2qZF126Y/JjAy+jY+8gk6kxQKAhPXlEBQ4GWWt1+b1da31Llhb9pULoZFeG/2BiC3VFMoPXgQOaz5pbR0dJla4n8Gx5QyUEbdNFyydr4giRQFW5wrDIKGey2i3SQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r5q0vX0A; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r5q0vX0A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QOFc5nggaPB8WHBRshnnKBHCTEMMmozxPcWhZmUgnVY=; b=r5q0vX0ASiswNLiQRVMZfzsQAW
	BbZmIE7A5pMxsPkzx19DGaXFTYJPzivHdkJmAqvydnFnIXXe5+bZT37d3CtAeUhYyWiJr6MKKgJL3
	EfaEFxeXT2E01Ki6vOMxbjtZvlA6m/Tqc+czq1S9LH26MiZ/LHvCuuiP6vXvMfOtjOUzy4cEvSYeA
	59zOxwV1BuOHoo91hpStae2M4WZmF4TgPb8+For7q784tcxixrmckLJH339LX3pguOCTLe/XSoZb6
	tVFlRlGJY2hkIB7vwdq/oFRHnijBOd/U7hCh/9cogRA5YIN4svQhsPXBGofj5epdwSV++dZN8peBe
	mUxikPHA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE39e-00000006zld-2nwT;
	Wed, 29 Oct 2025 10:11:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B0AA8300343; Wed, 29 Oct 2025 11:11:46 +0100 (CET)
Date: Wed, 29 Oct 2025 11:11:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH 1/2] perf/x86/intel: Add PMU support for WildcatLake
Message-ID: <20251029101146.GG3419281@noisy.programming.kicks-ass.net>
References: <20250908061639.938105-1-dapeng1.mi@linux.intel.com>
 <ef7801a3-d2c3-44da-b0da-d014bd7e3e8f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef7801a3-d2c3-44da-b0da-d014bd7e3e8f@linux.intel.com>

On Wed, Oct 29, 2025 at 05:58:38PM +0800, Mi, Dapeng wrote:
> 
> On 9/8/2025 2:16 PM, Dapeng Mi wrote:
> > WildcatLake is a variant of PantherLake and shares same PMU features,
> > so directly reuse Pantherlake's code to enable PMU features for
> > WildcatLake.
> >
> > Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > ---
> >  arch/x86/events/intel/core.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > index 28f5468a6ea3..fe65be0b9d9c 100644
> > --- a/arch/x86/events/intel/core.c
> > +++ b/arch/x86/events/intel/core.c
> > @@ -7596,6 +7596,7 @@ __init int intel_pmu_init(void)
> >  		break;
> >  
> >  	case INTEL_PANTHERLAKE_L:
> > +	case INTEL_WILDCATLAKE_L:
> >  		pr_cont("Pantherlake Hybrid events, ");
> >  		name = "pantherlake_hybrid";
> >  		goto lnl_common;
> >
> > base-commit: 16ed389227651330879e17bd83d43bd234006722
> 
> Hi Peter,
> 
> Wildcat Lake is a variant of Panther Lake, it shares same PMU capabilities
> with Panther Lake. Could you please review this small patch-set? If no
> issue, could you please merge this patch-set? Thanks.

Yes, sorry, got lost. Let me go queue them momentarily. Thanks!
