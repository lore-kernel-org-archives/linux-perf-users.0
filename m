Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4CE446C00;
	Tue, 18 Aug 2026 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051099; cv=none; b=U10T5c8PowP7U2viqHkItpFmM9Ts2FWQIdqQQuqY9VooN4HH+O4DMBwLOo5EfEEmvO4a5wwKTEyzkZF0ljlq/lG/Wn35VJXms/9YHcTUoMvtQxP5Xe80lh44u8TQrR2pOg3/nuepJ0oC02TFGOmdDxrG3DG9cVZbGBB1L901rIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051099; c=relaxed/simple;
	bh=V8ozXke85QcC4BsoBiqOrhOzx3cKru052NYQPdFqNlE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igCeGjatbCpd5oGySyzW/hDFMig7tRS5dwUkEL4j4QXHuNvR5XSbXd3f3r98FaBnaSbq7yaFvaXVRrTdFl+Ioz9p6hbWKp1ixZZhSmcP+1QWk11NsZWX9mBelCXMbE8CCaUWWDxRe/rpIfVlLI62Slt5n8LTklDM5y+1cGce/TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hPRfr2D9Dz1b69Q;
	Tue, 18 Aug 2026 19:04:36 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hPRfp2wGnz1b69Q;
	Tue, 18 Aug 2026 19:04:34 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 6A714300D1E7;
	Tue, 18 Aug 2026 19:01:08 +0800 (CST)
Received: from hsj-2U-Workstation (172.19.24.226) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 18 Aug
 2026 19:04:33 +0800
Date: Tue, 18 Aug 2026 19:04:31 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: Peter Zijlstra <peterz@infradead.org>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, <mingo@redhat.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <zhongyuan@hygon.cn>,
	<fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <james.clark@linaro.org>,
	<tglx@kernel.org>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <liuqi@hygon.cn>, <lijing@hygon.cn>
Subject: Re: [RFC PATCH] perf/amd/ibs: Report physical address for IBS fetch
 samples
Message-ID: <aoQ8P8MN8XN4JQIo@hsj-2U-Workstation>
References: <20260817073323.2504767-1-huangsj@hygon.cn>
 <9a39e681-3184-4841-9e19-7fc40956e917@amd.com>
 <20260818080024.GB1247881@noisy.programming.kicks-ass.net>
 <638cf844-8422-4706-b028-60d8722ce487@amd.com>
 <20260818091913.GD1247881@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260818091913.GD1247881@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

On Tue, Aug 18, 2026 at 11:19:13AM +0200, Peter Zijlstra wrote:
> > >>
> > >> PERF_SAMPLE_PHYS_ADDR is meant to capture the _data_ physical address, which
> > >> IBS Fetch doesn't provide. So, repurposing semantics of PERF_SAMPLE_PHYS_ADDR
> > >> for IBS Fetch seems reasonable.
> > >>
> > >> Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> > > 
> > > Well, why confuse things?
> > > 
> > > As you say, PHYS_ADDR is for ADDR, which is the *data* address, and
> > > FETCH is an instruction address, which we find in IP, not DATA.
> > > 
> > > What would be the purpose of confusing things and making PHYS_ADDR
> > > relate to IP?
> > 
> > Agreed, that would create confusion.
> > 
> > Do you think we should introduce a new type PERF_SAMPLE_IP_PHYS_ADDR?
> > I didn't suggest it earlier because I thought it would be overkill.
> 
> Well, that all depends on how useful this data is. As is, I see very
> little words on the benefit of having this data.

I just use this patch to track a program's memory footprint, including
the front-end(Fetch samples) and back-end(Op samples) in NUMA server.

So I also think there is no need to add a PERF_SAMPLE_IP_PHYS_ADDR for this.

Thanks
Huang Shijie


> 
> In fact, I'm not really sure what PHYS_ADDR is good for, so clearly I'm
> missing a bit to begin with.
> 
> That is; if there is a very convincing argument to actually have this
> data, that might help justifying either accepting this 'hack' or perhaps
> introducing more fields.
> 

