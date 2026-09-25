Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6582E03E4;
	Fri, 25 Sep 2026 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342872; cv=none; b=ZkmX4/INoPIxOk54lqmrTXt5+do8gOM+Ctev8aZb+sW3+y6fQNrWmheWnoKBTrMTyzgMFrjbMY4foRBIH/CsuY/hVyzCb+xhAGocEUAuipwU1FiHsHSvs0A0moBNta1xtCFiYHiqRzV8HVtdOxwTbhEsbbxkPcv3cm9SlnqPk/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342872; c=relaxed/simple;
	bh=PIzAaC9JkZJowMrQb3gm2CiCOEJ2YXtuPoK4R3OParI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KT/zL7b9UJs+S33daA+ieFUhyuSmU+w4Fvc4z1hn7uQU6TtI/cGcBk/TUEe661q8HUqemNlAcnLI6fBfJaiBrBjXTL5DxQTkhr2aDcOHO6tM7G/86rgWq5WTT56CH/djYDyP2xHvM3g+5+FBzZc1ZHqqAQvju3Ei/O+ePwr66L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEjlwu5Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEjlwu5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1A41F000FF;
	Fri, 25 Sep 2026 13:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790342870;
	bh=Xsdg93i9heFX8fuBndTH1OVgKayNCX99LVf/8O28y00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GEjlwu5QC9FHvcqiPBLQLmVC5KtQ7DwKqcc9oFAZMcU8xUXCkIPAfkr0D53YNkxOi
	 svxXxiEWba8oGuU4ZhPt4lB3EviP3SgEo1WRRV+/iWKE5dBD19RYca12OMVOpuwaim
	 5QKNPqF0xdSuDO2dzfmUK8cdE8kg9kDJHsi3f1/cMEKqmYPLYmkNpjDtKiEBeP8YZi
	 0utbp2q+d1DEDeWPgi22i6a+d6tPDp8XZ8R25VOolpekgsQ2YG6tCvswEdnWMizhu6
	 f8odDV45QApJUVJPfNMuWOjlA1xU+lT1zRJAvcuT7MJ5F+DXF81smvfzfX/LgZON3g
	 rrjFPxJsAygXA==
Date: Fri, 25 Sep 2026 15:27:47 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/4] perf tests c2c: Add function view stdio coverage
Message-ID: <arZ200WZAtBYy5bb@x2>
References: <cover.1787283281.git.jiebin.sun@intel.com>
 <9bd7a313c9c1d71058e857c320c6d5c30cf4cbfa.1787283281.git.jiebin.sun@intel.com>
 <20260821055803.74B191F00A3A@smtp.kernel.org>
 <aqB8eNXwAvKoiMMR@x2>
 <20260909030156.1771188-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909030156.1771188-1-jiebin.sun@intel.com>

On Wed, Sep 09, 2026 at 11:01:52AM +0800, Jiebin Sun wrote:
> Hi Arnaldo,
> 
> Thanks for checking this.
> 
> Patch 2/4 covers this case:
> 
>   perf tests c2c: Report skip when the workload fails
> 
> It sets err=2 before returning when the workload fails, while patch 4 calls
> test_c2c_function_report() only when err remains 0.
> 
> I also verified this by forcing the workload command to fail. The script
> printed the skip message, did not run the function test, and exited with
> status 2, which the perf test harness treats as a skip.
> 
> So I don't think any change is needed here.

Thanks for checking, applied to perf-tools-next, for v7.4.

- Arnaldo
