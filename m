Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A857D382294;
	Thu, 12 Mar 2026 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773304859; cv=none; b=ej6Sn6iHq30FGigJ97dGhSMY0o8vjqW4UN1kAbgqmEFcNNuYq+KyEOx2bXuzq/OAS2mkTAPzJPNDWWWZAIMFU8FICVz1OboXY1ZnMlFejljRHECFv6uj3ARI/l6FSsOw+dLrqVQgqa9FVSl5qzPz2OHqUgr5Yc7oQ3V9aQ6aiwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773304859; c=relaxed/simple;
	bh=A2cHIYLNYVSCX32Oec4QV7PPnhOUTTqE8IoHzxfeeJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ng7nHcTRw7NPCnrCICu2tcm8AwEKFlrTKLvP/aRSgAPZc285sugNqsTKWre3u6rGzco2CW6CxfvGTjhlYgT3W2JyPvXquLxUhl1JNabV2P4MCt+XvWLRheYT6xuEKYy3EDEQz1QABHcmoythr/ZHvd702NMszm/rRX8A7Vcgojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rRcuYJyz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rRcuYJyz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=A2cHIYLNYVSCX32Oec4QV7PPnhOUTTqE8IoHzxfeeJo=; b=rRcuYJyzgL6+m08zn3hmQjb5Pq
	jgcZ42w8QDrt4ozle7gvCngDu05y09msrEtu0K1xymYV4IZD8Uw2bk8EkyfmE0l82QOlLKwoV31/V
	uceUN3+PUOD+w7c9H75sa9kiv41F6+QfKNMuMkAlleGpa6VJyerSyVyef+uw0+H0HPx1YxOVljJ63
	KGHLD5eOp68rzznaZOvHN8EIfX5bojAmDxF+u53R4f0GzA8BOnNc5DVUa2/JciVU9yQET0XYkXSCL
	l5cMkn54Q8UKeH+Jbmqmj3zmGFzKPzJSmVLKJaKj3GRdZrgFsVgU8PZTStKg1dIALS3lnjKpuNjNK
	a9yBtZcg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0bb8-0000000B3q8-3RSS;
	Thu, 12 Mar 2026 08:40:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 49134301185; Thu, 12 Mar 2026 09:40:50 +0100 (CET)
Date: Thu, 12 Mar 2026 09:40:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ian Rogers <irogers@google.com>
Cc: dapeng1.mi@intel.com, dapeng1.mi@linux.intel.com, acme@kernel.org,
	adrian.hunter@intel.com, ak@linux.intel.com,
	alexander.shishkin@linux.intel.com, eranian@google.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, namhyung@kernel.org, thomas.falcon@intel.com,
	xudong.hao@intel.com, zide.chen@intel.com
Subject: Re: [PATCH v1 2/2] perf/x86: Reduce is_hybrid calls and aid ellision
 of BUG_ON in hybrid_pmu
Message-ID: <20260312084050.GE606826@noisy.programming.kicks-ass.net>
References: <CAP-5=fUBy-vzdSB3xsuyU+AKd8o99R7DLgoyyJHxb6Shkfb-8w@mail.gmail.com>
 <20260312054810.1571020-1-irogers@google.com>
 <20260312054810.1571020-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312054810.1571020-2-irogers@google.com>

On Wed, Mar 11, 2026 at 10:48:10PM -0700, Ian Rogers wrote:
> Use the capabilities of the PMU rather than the global variable
> perf_is_hybrid to determine if a hybrid pmu has been passed to the
> main accessors. As the pmu capabilities check mirrors that in
> is_x86_pmu, the BUG_ON(!is_x86_pmu...) in hybrid_pmu can be elided as
> it is provably always false (with sufficient function inlining, common
> sub-expression elimination, etc.) in its most common uses.

perf_is_hybrid is not a variable, its a static_branch. You're adding a
runtime branch here, for no appreciable benefit.

And while (Intel) client seems flooded with this hybrid nonsense,
servers are still sane. Also AMD have uniform PMU across their regular
and compact cores and don't need this either.
