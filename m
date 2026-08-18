Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8CC33D6ED;
	Tue, 18 Aug 2026 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044769; cv=none; b=tZ6EW6qFfPqnCZXmJC81QbZT5Uxn0GuPsxDSpRJFdm2KjhnBOKx7RsyeU/ef9OhtRtBOHV169tr0CbZIJLmZno6qNProOOvR+WdZz+wnqUyiIm1/zZHqJhj90Il57Kt58s4GHOfIeawUNz5elUdvsdBHYLeBGpfb7K+6YUiMhSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044769; c=relaxed/simple;
	bh=99yDin3EWuiA7L54gQ4pRS2WUzvp8xzYPqggpEBwqag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBVR15k82l8QakeWW4k3+Es9XCnHz6nU7J4TX7+6ocvdPAGAvytCZ5HzCyljv/cHx8GAjVg1X9A3Qc0/W4MZrgaHqs51RgQ+yrKHLHi+eSDQoC0SZHYEW+I2xpZGBuiNrKNehe1lVvbx6I8YJngNuDTyNIqZFW0wf65f/aqGDH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jya9yogC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jya9yogC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=llS6DjttMNi1iRn++vPUlIPBCpiZFLYLMFsaNeuy+t0=; b=Jya9yogCUE5zBPGbqPorPqfASf
	Qo9WXol0vvPjiZpJ2ZOkC5K2MqdbelDr0JPceTWBqqHQh6VItyTgmSD2dT+Ucsia67IsAJatxetyk
	nfprH/Wu+kdRuL3G6X93QwfGbDGbAAvafMMymxCn00aOCj65ma8ngbp5qU57UOiapFoLZihpfF6qG
	toHYBl0/07XmxWXmwYuyTDD5opHWc6JhX0nqcg9/2IqcFhK/Zd5W+AvEm+ijnNhM9YtJg2bNmV3Yl
	P37+GBz2dhyVU7UM1p8BuYaEGupdkYsyOeTyZMbgqlOxigyfpkc9bveS5+qc8XWwf8QFDJgZdPQIs
	6QDS8EJw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wwFyU-00000001VQM-3IXB;
	Tue, 18 Aug 2026 09:19:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8F1343006FA; Tue, 18 Aug 2026 11:19:13 +0200 (CEST)
Date: Tue, 18 Aug 2026 11:19:13 +0200
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
Message-ID: <20260818091913.GD1247881@noisy.programming.kicks-ass.net>
References: <20260817073323.2504767-1-huangsj@hygon.cn>
 <9a39e681-3184-4841-9e19-7fc40956e917@amd.com>
 <20260818080024.GB1247881@noisy.programming.kicks-ass.net>
 <638cf844-8422-4706-b028-60d8722ce487@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <638cf844-8422-4706-b028-60d8722ce487@amd.com>

On Tue, Aug 18, 2026 at 02:34:26PM +0530, Ravi Bangoria wrote:
> On 18-Aug-26 1:30 PM, Peter Zijlstra wrote:
> > On Tue, Aug 18, 2026 at 10:29:08AM +0530, Ravi Bangoria wrote:
> >> On 17-Aug-26 1:03 PM, Huang Shijie wrote:
> >>> The IBS Fetch sampling does not report the physical address of the
> >>> fetched instruction even when PERF_SAMPLE_PHYS_ADDR is requested,
> >>> while IBS Op sampling does.
> >>>
> >>> This patch reports physical address for IBS fetch samples which can be
> >>> used for profiling the running program.
> >>
> >> PERF_SAMPLE_PHYS_ADDR is meant to capture the _data_ physical address, which
> >> IBS Fetch doesn't provide. So, repurposing semantics of PERF_SAMPLE_PHYS_ADDR
> >> for IBS Fetch seems reasonable.
> >>
> >> Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> > 
> > Well, why confuse things?
> > 
> > As you say, PHYS_ADDR is for ADDR, which is the *data* address, and
> > FETCH is an instruction address, which we find in IP, not DATA.
> > 
> > What would be the purpose of confusing things and making PHYS_ADDR
> > relate to IP?
> 
> Agreed, that would create confusion.
> 
> Do you think we should introduce a new type PERF_SAMPLE_IP_PHYS_ADDR?
> I didn't suggest it earlier because I thought it would be overkill.

Well, that all depends on how useful this data is. As is, I see very
little words on the benefit of having this data.

In fact, I'm not really sure what PHYS_ADDR is good for, so clearly I'm
missing a bit to begin with.

That is; if there is a very convincing argument to actually have this
data, that might help justifying either accepting this 'hack' or perhaps
introducing more fields.
