Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04AB158853;
	Wed, 18 Dec 2024 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734529961; cv=none; b=QJPGc7xmsKQF4tKcQCXQt+JimZN7bBNbvGRnJzqRA4h4jRPTcix0IQOcIeg/GAOPBxWTmRE5UeTLbBP2INO8eUqkZr63STp0d6fsdJOQM5SfJbEcWTmDybmMEoOOVdrL2O+nJCuA1hfare2wZadvVCCOzVW2H2tZOuGMRHQvdtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734529961; c=relaxed/simple;
	bh=5k8GSeh/9XHj4Uff6BHUnOfAIMtgxmx9pbU27YpeDck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjZKx+IqmafifNOsZhqp7I/e7Uh2l4ARu5eXsIGvWxp+OmL1rMCKqOiQTtqCYMa+fSuxnbr+5dJtbe9Q/FRxtxzY+FhTR01O2DX+KEnKKPfdE0wlmNvEy7ElQxHf+iKwfBI+U92PDu5FoCedBESQngpBrN0oIjkBYSr3t/ZvCvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q4eSCJxv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q4eSCJxv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3YlC36XIysk6CChQu98vTnneje6y0QKfE1xplJqpSsE=; b=Q4eSCJxvUxXzbjhf2yDSJQWcgq
	Re7HMDN0P1dYfXYJSl+57jkck6CwVGoSSd+l2PFG2ND+fx9vUFNWyXuXze9vwcTaneQKMv7Pumg1c
	zq03FQBUin0MK4Obcm08P8gjJMk/NDt0RSIdQnmQ/L7ohJp8Fe8yBp54qxQj24yhPWNtsQrTXkKLe
	e9LOpuD3oILxFhU2Huq+gkG8ad7kVlL8Fx59zV77jmPS+4PCXadM1sotjdo3a1TJJJldg0EtPoPzs
	JGAyqWrJuzzuqN7fLRbf24eLHWnDkPNKKljtEHC+sqSvH76EsO/H6bcvBRN8M6LG3DcHSHx2509H2
	4ycR7PQg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNuTV-000000005FL-0na1;
	Wed, 18 Dec 2024 13:52:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 691513002A0; Wed, 18 Dec 2024 14:52:29 +0100 (CET)
Date: Wed, 18 Dec 2024 14:52:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: mingo@redhat.com, namhyung@kernel.org, acme@kernel.org,
	eranian@google.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	santosh.shukla@amd.com, ananth.narayan@amd.com,
	sandipan.das@amd.com
Subject: Re: [PATCH v3 08/10] perf/core: Introduce pmu->adjust_period()
 callback
Message-ID: <20241218135229.GE2354@noisy.programming.kicks-ass.net>
References: <20241210093449.1662-1-ravi.bangoria@amd.com>
 <20241210093449.1662-9-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210093449.1662-9-ravi.bangoria@amd.com>

On Tue, Dec 10, 2024 at 09:34:47AM +0000, Ravi Bangoria wrote:
> Many hardware PMUs have constraints about sample period. For ex, minimum
> supported sample period for IBS Op PMU is 0x90, the sample period must
> be multiple of 0x10 for IBS Fetch and IBS Op.
> 
> Add an optional callback adjust_period() to struct PMU to allow PMU
> specific drivers to adjust sample period calculated by generic code.
> This will ensure the sample_period value will always be valid and no
> additional code is required in PMU specific drivers to re-adjust the
> period.

And not a word about pmu::check_period() and x86_pmu::limit_period() :-(

Please explain why that can't be made to work nor adapted.
