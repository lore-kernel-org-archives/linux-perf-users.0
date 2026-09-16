Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B537EFF1;
	Wed, 16 Sep 2026 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563861; cv=none; b=RmSqJXHiFkXIWOoXlzeVqI+M+Le90DmGXFMLeSsX6EyGkcZd+BSTYwco91Jn/aj40wWwTdfDAA8mXbKnhWbU3Qxik/++mYyVoHJY7abstAc5WmqZpPF9Gp5c2Hg0FC7MMAuAc55/JtTgc0UXWOZOrYagEbm8E1A0fvOMtMJ3i4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563861; c=relaxed/simple;
	bh=JxdlR3kVKhq2bJ8HCdQL/LvdJweXM93pWxEHon35klY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn6veyI5ATPNzclEyu1xhMmEykNz7O6QZTn5DbX3ZC3mqpx6jZh5gjMtrjJjUsRpiaiQ4lSq/w+ZicCnQYs83Tis2+jZOL0D1X/ZMOatYUoAmLaqI+RWirV0Ei/w4S3EOi4QibpLsEZsRfZ8SXt4nSnbJnL66m1j16Ebpkb6aoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=byt5TRqX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="byt5TRqX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JxdlR3kVKhq2bJ8HCdQL/LvdJweXM93pWxEHon35klY=; b=byt5TRqXRE/IVQwmBDsSb2o2cV
	YFIG5uN/30coNyTf/d8Bc2vB5jMZqZRfKW5gTsXi18vCseggXWCJzc6ycIh5Gl04uB5u9Soqzms1V
	jBlF1M5l/b6h7EQXNfaX6nIp9jV3TtmepybTvwJTN+p+ma9OLGwO8l2GXOXsbyPd9MjJVjNQOgs/P
	aR4lPA/lpfm0yj31cHfAI0tl9Wj371A0JyqUtwkBc26CdgyeI0Otkrf3mPp8eYtFj1ClY+7fDAywA
	N8HK72a+VexK2pRnnHWgSNvI4iPDefS41Z3eUzJt0quqLk9+MdGyp+EA5GJxWz1Dq/N45u3MLIPOK
	MBLXftVw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x6pIx-00000007shC-1k1m;
	Wed, 16 Sep 2026 13:04:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E1316300328; Wed, 16 Sep 2026 15:04:01 +0200 (CEST)
Date: Wed, 16 Sep 2026 15:04:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, irogers@google.com,
	james.clark@linaro.org, jolsa@kernel.org, kai.huang@intel.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
	radu@rendec.net, seanjc@google.com, tglx@kernel.org, x86@kernel.org
Subject: Re: [PATCH v2] perf/x86/amd: Move NMI latency window to last-resort
 suppression
Message-ID: <20260916130401.GH776954@noisy.programming.kicks-ass.net>
References: <20260916093217.GH4121339@noisy.programming.kicks-ass.net>
 <20260916125016.2266596-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916125016.2266596-1-guanghuifeng@linux.alibaba.com>


Yes, lets not answer questions, lets just send a new version without
mention of what changed :-(
