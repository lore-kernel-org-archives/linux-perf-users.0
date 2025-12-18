Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E6A2BF00B;
	Thu, 18 Dec 2025 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766048167; cv=none; b=rPXp2M8RITPdsAd/EFSvW83hsAIwL6x51PM8c3qRkhf7m60NqWBl2w9G8gN4OjqY9AM+K949f63w7c23V5BeruDhKJLlapUw4aQt7BMrmcOmYsMbnjlMM1/ypAXQ2FfVBHfoFrAuZZdKNIeQ9J8COcQqFumdLkbJetPP6nmsvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766048167; c=relaxed/simple;
	bh=SxOQgZ1k9Cr23X3log9Nvhnwmo/YyJ+sueBqFTvS6Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7oy1Fp0Uahi8b8LMGRbCoEKV6zroRVYNCSlNicBvVysHaEanQWYb2S9xhyczs2j29SjrTB/cCus/G81MsGIQL4P3YTLAhtj7Zqgw7d5ktcpELiApFg+pEi801zK3BEzVImhB6HNFd3B8QlKuD5trVN0pOJNzxtvWThKmyxouPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wRwq677u; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wRwq677u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rrwrZ4vkJnL1Lb2ReLKU8bzseWZJSIGCBpiIBWl5iGI=; b=wRwq677uia8k1otUhh3GYbhHjv
	q1NN1iV33XkVxSSiPmQLQa5cYcopi9sbSJbZ6oUMkivNIjOXaXzSM0IkIhwAH/OBR3jF4hStgQxgJ
	OCV65qo/izT04Kcd0WJbMqCFTgZQyU443oHggbqvA0VU7isIz4FdWTJPB0zuMb3UPjc9yQjqWx9bM
	KV5buip3lOapEbrP7DfLnVjZS2jsEukrFQPdJxDWFyyLfV7YIW0w5XxfovzQKOdb4GVoqzFYNR3zi
	UhBDz4HsZCmXNsG4DK8GYoG71yKTN7NZ9stA9LhSCSOgkdnM0+mD2zaQ+x+tN1gwJigA0zYRRjrjj
	QTeNVEMg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW9nc-00000005sf4-1EEq;
	Thu, 18 Dec 2025 08:55:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D995C30056B; Thu, 18 Dec 2025 09:55:51 +0100 (CET)
Date: Thu, 18 Dec 2025 09:55:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf/x86/uncore: clean up const mismatch
Message-ID: <20251218085551.GK3707891@noisy.programming.kicks-ass.net>
References: <2025121741-headstand-stratus-f5eb@gregkh>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025121741-headstand-stratus-f5eb@gregkh>

On Wed, Dec 17, 2025 at 01:42:41PM +0100, Greg Kroah-Hartman wrote:
> In some cmp functions, a const pointer is cast out to a non-const
> pointer by using container_of() which is not correct.  Fix this up by
> properly marking the pointers as const, which preserves the correct
> type of the pointer passed into the functions.

How did you find this? My builds do not complain and all that.
