Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E706C3A5E6C;
	Tue, 18 Aug 2026 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787040044; cv=none; b=dlilhPjuDlgg/IIRLt/XbMqgQPuTAf0Lpa82SRcReyfrgiCmDCFA3AF7RxBWNDhCI/V3PHpmbASytBOAHdVNj9fKlkEbPhpRb7BOZ2l1oQNOnTfRNtb0EA+02UJqUKl7H6I9gsD4hxJzhMzfuT3KW9VozwIKJ2AN81dZsXe3Kho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787040044; c=relaxed/simple;
	bh=bNhcOYleVMlZgGMmx0UtnsfE0YlKBo9aaICjYe6oYdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YP2ky0gwrfzdSTHVJ4jgcfISth3f9TWSpL3Y4eRHcL/T3YOlHKhidx02Jc7gQYaVZ5XxsO7BRzyv/9N7PnIOBf2iWMjZzGyh+kXsYhpsIBuS1wEnz1iEYtIoWVIZTxbS4G17IlqTLXX06JSku7oMvnxLAT1Y4eemCGyD5bZIrHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DlZZCO//; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DlZZCO//"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dsyFL3eDygr2yHeDlA3UfdayfjhZfACnwMuhd25hXmA=; b=DlZZCO//XvZ8pPUoC9tVj4kOvz
	JaVEc8eWX/pVUAnUara3hD5XL4h/3YXTcjCAkAdPUHGf1orWjjl+hsUuBPuGvq5BFUUZUBZVaM0+6
	I6PV4q/cxMME1rt7k9pn9Twwu9dznFwUJaXyYwVUbvoSZusdMS8PTZbt2YC9076OmSriQ4PvyBCjh
	dipmNWw4UVp03MRhEfYGQxCF9NJtbLn/y3KaYFvJ9zt/Oh8Oz8VZxx0Shxqpy5oQKwKFh1ShZLpd8
	HOizSwqpFoHaz3ImvB0UF8Ac0/Cqyju7tt2nc+1xKkUaOLF7J9f/yyu/+a2LWbBRexVgNuWT87Req
	Fzd5sNmg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wwEkD-00000001S0E-2ghA;
	Tue, 18 Aug 2026 08:00:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 61D043006FA; Tue, 18 Aug 2026 10:00:24 +0200 (CEST)
Date: Tue, 18 Aug 2026 10:00:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Huang Shijie <huangsj@hygon.cn>, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, zhongyuan@hygon.cn, fangbaoshun@hygon.cn,
	yingzhiwei@hygon.cn, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, liuqi@hygon.cn, lijing@hygon.cn
Subject: Re: [RFC PATCH] perf/amd/ibs: Report physical address for IBS fetch
 samples
Message-ID: <20260818080024.GB1247881@noisy.programming.kicks-ass.net>
References: <20260817073323.2504767-1-huangsj@hygon.cn>
 <9a39e681-3184-4841-9e19-7fc40956e917@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a39e681-3184-4841-9e19-7fc40956e917@amd.com>

On Tue, Aug 18, 2026 at 10:29:08AM +0530, Ravi Bangoria wrote:
> On 17-Aug-26 1:03 PM, Huang Shijie wrote:
> > The IBS Fetch sampling does not report the physical address of the
> > fetched instruction even when PERF_SAMPLE_PHYS_ADDR is requested,
> > while IBS Op sampling does.
> > 
> > This patch reports physical address for IBS fetch samples which can be
> > used for profiling the running program.
> 
> PERF_SAMPLE_PHYS_ADDR is meant to capture the _data_ physical address, which
> IBS Fetch doesn't provide. So, repurposing semantics of PERF_SAMPLE_PHYS_ADDR
> for IBS Fetch seems reasonable.
> 
> Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>

Well, why confuse things?

As you say, PHYS_ADDR is for ADDR, which is the *data* address, and
FETCH is an instruction address, which we find in IP, not DATA.

What would be the purpose of confusing things and making PHYS_ADDR
relate to IP?
