Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352620;
	b=awNIUxMJhfzowIxaLDY9Dyy2aoR6hUF26dkjzsbMwStXf3y7fS/VSeZKk9Bwgg9/ecsr
	 6v2HxkeCd6+WCmtYgz7RZ4bKFlU/MPsQt0pItB9Ccv3ZPDKhvfVxjHYkxd8A/4tPB+knT
	 uzeywKF0gesWimGbTCPQPWRu+kv8yX2WEeSbYMbioaWYDMVEExzxgE60zSkKJ5JrzVVMh
	 IaIjGcvhXgQwCC122Zks5b79y1FD2dhW8C5h9/qt/AzUO5UYFgjPw5mc0yRmuK6Sck9NN
	 aeLxh7HE8zuz/cpold+X2ZzH1d+Y6iCMiti+p1Z4xVQxKrK2Aqs1zY3xv1xn3KzB/+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352620;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=iHCN2Ghkn6TNzamyqwkzKubIIg2CrJLoUEljP3EOIRY=;
	b=WVOncx2MGQDp7XoZbb7poLewebyDplMazJ0PZZVjYT/X0HSn/PvCW/rt7vEzw2efkQ3l
	 YfpLq5Mfco3TFlgHKPoM9Gr56DnEPZmM8wiBPEWVVvqEs4zwPKd+3kaws17sPgsILMHdl
	 6VEfijTUZfOtdcAsIHf3gF/sF7moCgccWZODAbbFtkPpcwVp1lM4aE4pArUb5ra+lCScX
	 tOHur7FplG4Io5TVuBXSCHiZgExILbYp6s5jHrnumkBGbvvgZB1COu93Uk9XozoJXLHIb
	 kw/kf1QbPEP1BxCcQ+NVuAVP1MUfswzxt4g+gmovSHngN+y7SGxEKnizw44qHyQwoGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=INVyZoPI;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3332E606A322;
	Fri, 30 Oct 2026 09:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3332E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=INVyZoPI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iHCN2Ghkn6TNzamyqwkzKubIIg2CrJLoUEljP3EOIRY=; b=INVyZoPINRKB5eckC6/bbZQaZ7
	jbrGGpj+GvdE5dp3TUwfZ+ePeBgH+aXozdCRn5Qgn/lL2FI4ZtHxWsQOlb0hzE4G28SZytj7WPw1x
	eio35IVHVuliSgVJH/f2lZZlt7Yga/4eQH/z9BcfVjJtTKOdvMLKW1XBLzSp8mh3gceP09jztXxIS
	wUMpunwRClHfdPYD2+ZYWi6lqfMahpbzRN2p9EJy7obNWc1vZYUJ9LjOr5H5R5WqzqUmQJCtfhC8S
	ZAFCJjCIW7JmOIYdb5xgDqo5looADIpcH9aIwn5qpIY9Pnyrim0TYow30qLT4Nl8rEniv/uAt4Aa+
	4N8U0Zcw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMiw9-00000004Zgj-3TDE;
	Fri, 30 Oct 2026 09:30:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6014E300329; Fri, 30 Oct 2026 10:30:13 +0100 (CET)
Date: Fri, 30 Oct 2026 10:30:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v5 13/18] perf/x86/intel: Refresh LBR stack for non-PEBS
 LBR events if needed
Message-ID: <20261030093013.GM2668804@noisy.programming.kicks-ass.net>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-14-dapeng1.mi@linux.intel.com>
 <20261029110046.GO1779021@noisy.programming.kicks-ass.net>
 <16441880-1831-4741-ac90-02e5f662435d@linux.intel.com>
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
In-Reply-To: <16441880-1831-4741-ac90-02e5f662435d@linux.intel.com>

On Fri, Oct 30, 2026 at 09:54:02AM +0800, Mi, Dapeng wrote:

> >> @@ -4012,8 +4023,14 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
> >>  
> >>  		perf_sample_data_init(&data, 0, last_period);
> >>  
> >> -		if (has_branch_stack(event))
> >> +		if (has_branch_stack(event)) {
> >> +			if (lbr_need_update) {
> >> +				intel_pmu_lbr_read(&cpuc->lbr_stack,
> >> +					cpuc->lbr_entries, cpuc->lbr_counters);
> >> +				lbr_need_update = false;
> >> +			}
> >>  			intel_pmu_lbr_save_brstack(&data, cpuc, event);
> >> +		}
> >>  
> >>  		x86_pmu_clear_perf_regs(regs);
> >>  		x86_pmu_update_perf_regs(event, &data, regs, false);

> > Or... you move intel_pmu_lbr_read() from handle_irq() into pmi_common()
> > after we done the PEBS things?
> 
> Yes, I ever tried to do that, but I found it would break the PEBS LBR
> sampling on the platforms prior to ICE LAKE. The PEBS doesn't support
> snapshot LBR stack on these old platforms, so PMI handler has to snapshot
> the LBR stack before draining the PEBS buffer.

Argh; we have so many variations :-(

Still, re-reading those MSRs seems wasteful, esp. if most modern chips
will be affected.

Can't we have a toggle between early and late LBR read or something?
