Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879779;
	b=nwFnL0Cj8WCoKyDI2v13wBqAtUnoEfAMfD40xnEqcb+CtDlg8N+OtbmtTvm109Z8Ef2n
	 u3rLTFwM2ZFTDvXA2Z3ToBtVMrVbC0RYqWfZUWPUiKEODGySBovM/K0e9MME1nUcR9kqu
	 2VSgUznMIzyPIXfhbKv2cszvA566dnnDKdSmH5E2+i42fhtmO56pskZkO9MkrmJwJGm9E
	 piZR1R7nlZzVtYp4sE0fn9qXgcv17Jud+q/3Udj9O98OJoN6gZZ1CDMiyN/cptnVQQOhq
	 0KK6E4/CKpBYdilNOB0l5C3n+VkaFaMG0FO5bPTbKjSTQ6qmmYNjIlNMLAFZL3cBfBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879779;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=EolUrwZQiSAM3PJ9+udGnUgOcc9Wxy4cF8sTcB/x8RU=;
	b=ZTfl6RenexlRewTnkvM5u1GFOWcl52Q3Wz2CbcRPuzbzTqIWDGMwshwxj31LwyooiJpO
	 I8fWFezUPl6umHztxd7U1O4yqaul4JZYyM3KoimnjbLb/KIUOa71YqLaRC9V/AEhJAC9y
	 m8/3B8M+UUS5M5A5Deoub4Ps2hUDk4PCKWuNGqoHAjkmeggMWB5Y292FokJl9jM9xpzHG
	 /vc9aVCwm8eAArD1n72KCmA+/9rKY0ynfpj6oce/+GppJx8ULkWhx5aw5vQycczmcshBO
	 8pIf1j0Ja5e+BUWfKqQxdyhBRGEcK1o20Hu2vmdG7z6/18oCRwGJsVN1SkVQqN/IVRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kvWm3ELs;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23D2606A31B;
	Thu,  5 Nov 2026 11:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F23D2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kvWm3ELs
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2818419F6;
	Thu,  5 Nov 2026 03:56:14 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9F0E3F628;
	Thu,  5 Nov 2026 03:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793879777; bh=uUU6WeGNbp8M9D1RIW4g77izG8IRnf63cU3yGo6J/dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kvWm3ELsUjqKVzgkvpVtDptptSL4Njbe3RH8DGaRRtTXzqka5gd1HBJYbMtiX/K3o
	 PztZdmeNuezuXoUYnyvcj/TbSJ0RGqeAR6gawSmV0f17+CDWwgfXKb5pgpc+7VObw3
	 S4c3wtZ9Xx3hjxqN4IYHBija3RB4SMUiBZ/xTr5Y=
Date: Thu, 5 Nov 2026 11:56:14 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org, John Garry <john.garry@linux.dev>
Subject: Re: [PATCH v4 19/19] perf test: cs-etm: Increase snapshot size
Message-ID: <20261105115614.GU9176@e132581.arm.com>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-19-7759e0ce2449@linaro.org>
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
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-19-7759e0ce2449@linaro.org>

On Thu, Nov 05, 2026 at 11:45:07AM +0000, James Clark wrote:
> AUX maps require at least two pages, so for machines with 64K pages,
> 128K is the minimum.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
