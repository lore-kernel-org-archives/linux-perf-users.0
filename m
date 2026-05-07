Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39BB331A63;
	Thu,  7 May 2026 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141433; cv=none; b=bsgAPmkQjtwR63V5ElGCVBxzIHUttFuWA4lkFHFlSMf+j2Pv27SWIoI37GoMafIQny0p+/w3seZnHiXKs0tPeRDinrMrDfZPOdPK7PNrrqpVs9uHNPgu0NUK0okhEIvsRmtlWBtgsxFHapHcnYgETyGp9CLsVb/wQgXOjy1XjEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141433; c=relaxed/simple;
	bh=e5rksMSqIHqBjBbfvp63wF7CpbxkVjza1Ujamq1Ctig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKxBiPfOcDEi/UcH10T40ifsCYvMOkpd0shZ9fBkR4thX6tuQSauUeaTu+xEA19XXkX7CJjqn/mASYa88wUSW0k/5jlYXq4urlYNFyXy6UsrAnjT6idTUkd2RdzpnSzOzU1oDeV4k6Zow4HfP9YBZun6VftsXNDgqJhqRXZ/ce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ir9a+aQS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ir9a+aQS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rAaLZS67dYIlzvdtgWzP5jbZxEn3Jj0dh3pCM4gNADs=; b=Ir9a+aQSswzm9crBs5eK5+1wCn
	nHxIj0oB1cupnH6jGWVn5AsyZgkaZfaSwfDwCGclbJclkiHrTtJj9WFd1/Z6oM/sP536f1xKGczUm
	+HI0rrSzOe9YKZtFEZmQZlhc7nGFRB88SWVHI+T4UXIcBVEBBmbns3i+uOc4LREIHLPbPcSlITCk+
	kwHdiERm8opz09nyYiir2YdMOG98eb0CqjagcPPYK4wp32wxatLK4+LLu/uxFsXwa1WWAXIvGbaF7
	hdDA+SE6gChdyjtmr5mkZiCgP3NCLRhs4MMBUHVC8cwbih8hAj8nykoS/sDkNk/u5g/zSENtF1Fvo
	BgXyBWyw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKtoD-00000002Vb8-42Jq;
	Thu, 07 May 2026 08:10:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8A2C83008D6; Thu, 07 May 2026 10:10:12 +0200 (CEST)
Date: Thu, 7 May 2026 10:10:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH][next] perf/x86: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <20260507081012.GI3126523@noisy.programming.kicks-ass.net>
References: <afJcDg1I5ZU5ZkXf@kspp>
 <20260504083228.GQ3126523@noisy.programming.kicks-ass.net>
 <7aa0f09e-5d35-49e1-916b-7564d074df70@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aa0f09e-5d35-49e1-916b-7564d074df70@embeddedor.com>

On Mon, May 04, 2026 at 01:50:50PM -0600, Gustavo A. R. Silva wrote:
> >    https://lore.kernel.org/all/20240806113254.GG12673@noisy.programming.kicks-ass.net/
> 
> Feel free to apply it.

Bah, stupid warning :/

There really is no sane way to tell the compiler that the code is fine
and it should just STFU already? I mean, it is directly followed by an
array of the right type to fill that flex thing.

Anyway, I suppose this all very much relies on the structure not getting
randomized, so let me stick __no_randomize_layout on it at the very
least.

