Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4372AE96;
	Fri, 22 Nov 2024 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273986; cv=none; b=Zy3cj+s1hR4k/B/8dBDapkK+3Ug6fJZuKUHtZJw5Mr81M70g0HvcqYGqpjU9856XSEYyxR997Y5l7KwjbeVKh8aLweWgAxQATjKIFSjXwAAhFfDKw5NUZnyqxIHANYdGj9F8JZSSztDVuMfzGD2fZ/9jmJT4DysZtxJ7/VNdQ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273986; c=relaxed/simple;
	bh=mYAQbycdKMQ9ktwITh0mcP0YYpbh9OHY+sg5Bn42EBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7Ldng4us27nPegsbD8SMgKK0CinpwbWquUaLsK7mn4XiBNtm7nnYeeRdy1nwN0RCHtbX8HzPEnvoDcfo7y6tpBHjiFfbj4fhXbat/jqoDvRY1e4ynzD/RWfkpJm/t0b0Sd5cleRVpjToLFU2JsNvq8GYHz4ioLtiPU0wxuff+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k/SWiGTW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k/SWiGTW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mYAQbycdKMQ9ktwITh0mcP0YYpbh9OHY+sg5Bn42EBo=; b=k/SWiGTWsyfIR4rbDTCEvsTRxb
	0/xmDLXSBCGA6/Od05xPNIEt1wXeE1oIBOrAzbQQitOlojthovjef6HKoyeMZJ7bI4rdnyVLWMa6+
	TcwqvYpEx+NKIDTvJAyQyE/oluUAyYFedzVkm7ydmdxGnI9OH53ExMShRvCbwXfmhsUitS2YsAl+R
	xTlWtiKEv7dXCIR/CdPGQyFYwNw7+hCG3oAFkgx0l5jYihUrmzmJHiNJ/ZLQ95BRx3FcH50upNsTd
	1ZFjVujrjiXZ/asEzOmHn5Df0ylRx5zEQ7wFx3d/rFLOuPLgUw1QKDT1jmqqangNAT+7i981cNmKm
	69izqVmQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tERao-00000000hJI-0PrN;
	Fri, 22 Nov 2024 11:12:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B69C230066A; Fri, 22 Nov 2024 12:12:53 +0100 (CET)
Date: Fri, 22 Nov 2024 12:12:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, james.clark@arm.com, ravi.bangoria@amd.com,
	yu.c.chen@intel.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	rostedt@goodmis.org, vincent.guittot@linaro.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	gautham.shenoy@amd.com, kprateek.nayak@amd.com,
	juri.lelli@redhat.com, yangjihong@bytedance.com, void@manifault.com,
	tj@kernel.org, vineethr@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, santosh.shukla@amd.com,
	ananth.narayan@amd.com, sandipan.das@amd.com,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v2 1/6] sched/stats: Print domain name in /proc/schedstat
Message-ID: <20241122111253.GR24774@noisy.programming.kicks-ass.net>
References: <20241122084452.1064968-1-swapnil.sapkal@amd.com>
 <20241122084452.1064968-2-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122084452.1064968-2-swapnil.sapkal@amd.com>

On Fri, Nov 22, 2024 at 08:44:47AM +0000, Swapnil Sapkal wrote:

> schedstat version has not been updated since this change merely adds
> additional information to the domain name field and does not add a new
> field altogether.

So I don't care much either way, but if an existing tool is trying to
parse the domain number, it might now get confused by the extra
characters. I know of no such tool, just being pedantic.
