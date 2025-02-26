Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750E24642D;
	Wed, 26 Feb 2025 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562569; cv=none; b=pbyXUn5a891sLTdWlVoKmMUquQ7/WqKwmmlNCzMs5ydUBczJQvxEG74kWpSRAUKmzndhgZi5PL9qokPlIXRPvTIy6p+e1WcPDBQn7djlI3onOFY1+gJ7vKCFsSkQgSKGTRY5juYKfZmuvnVh444G+GcvHm9+7ezwLDSMMiD+YpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562569; c=relaxed/simple;
	bh=vrrfDGbnQPr3XXlgo99RMkgN6EbWTxm5jy+9JDJXwUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dno6lh3NLS5zBME40D2ennVw9SvyPqXqToievFft0EbIFOK2LPX0LRYgAfnUJ5023yCwi+eEtRjQ3q0HrrEd1Ki4XOqYW1U1zbxhSg53cYmia9lMQS+0/iihUFJKAf3/IInQ8mzwoe9TCur5TeGsP/HUmECRtEiK4EtKNfx/h7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f5hn0E1L; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f5hn0E1L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=eOt9IXZWk7S0uBhZ1DAZhdxiyVmsfWbkgyJiwI2SnOg=; b=f5hn0E1LFU/9jdiild1d0Rx3QN
	cOgLkpwM31Pt2LirP746ydPOvqkvyvvzseASw8+XvRUbvbAo1SygipnOl5EINecytx9c4zp1gQRs+
	2zADBc/lWWCciFi5lVeiCkJCdh62T8Z1d9k9I1v29iWxMcRhgL3a784BPwqS2Kk/TyjyFS9orIX97
	7487tombFCttgXXWMdlhduAc+wY9Gs/9t6rv1Eea+FeLmET/j9beJWdVkDZGpn0aIb8l/jDku+2I/
	vkt8QqBh5RaQN/hANnyms/OA/FVDcvdGu+MkgAdxqt7R6MkC6qiyBojd2Awb9HAevlaYNzHbpu8NU
	6+GjWkJQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tnDpf-00000003ZBG-3euN;
	Wed, 26 Feb 2025 09:36:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BBA0F300677; Wed, 26 Feb 2025 10:35:58 +0100 (CET)
Date: Wed, 26 Feb 2025 10:35:58 +0100
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
Subject: Re: [Patch v2 10/24] perf/x86/intel: Process arch-PEBS records or
 record fragments
Message-ID: <20250226093558.GR11590@noisy.programming.kicks-ass.net>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-11-dapeng1.mi@linux.intel.com>
 <20250225103927.GJ11590@noisy.programming.kicks-ass.net>
 <20250225110012.GK31462@noisy.programming.kicks-ass.net>
 <c1450cf4-f367-4675-9f5e-90416a996af1@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1450cf4-f367-4675-9f5e-90416a996af1@linux.intel.com>

On Wed, Feb 26, 2025 at 01:20:37PM +0800, Mi, Dapeng wrote:

> > Also, should that workaround have been extended to also include
> > GLOBAL_STATUS_PERF_METRICS_OVF in that mask, or was that defect fixed
> > for every chip capable of metrics stuff?
> 
> hmm,  per my understanding, GLOBAL_STATUS_PERF_METRICS_OVF handling should
> only be skipped when fixed counter 3 or perf metrics are included in PEBS
> counter group. In this case, the slots and topdown metrics have been
> updated by PEBS handler. It should not be processed again.
> 
> @Kan Liang, is it correct?

Right, so the thing is, *any* PEBS event pending will clear METRICS_OVF
per:

                status &= x86_pmu.intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;

