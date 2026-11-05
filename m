Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877188;
	b=sMdX8l1anCuG6xB+337EK51LKuQOIFSrOJHC4Kgle6tkh5prOesTmK3L6DVzULBUO4Yr
	 PcLKRUW7JBF7FQDxyogAisIcZ9+hqy5z7IItAXPgC6auH9l3zLwrqc5XbGaj/Fe0AMcno
	 4ZZL4W1RRbh7zrMNCGbp9qF458S0lfcGmqfC/7ZSmGl0AvEPRfMQN0PR2Yx18Miw20EoA
	 AnUUqdOHsMUh4i2axzlnDkd9Gkc4KftwcPgsuZsa36LJVPGJRiCujilCHqz4X5eHfuAA2
	 XEwgtWJbAc0angw3G7UNpRCJJoKCYUXRROCKtNFLWHQJnPPiDXr2WHRxOowaRH6Kr6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877188;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=DM9fur9Zv5zH7RI1/42R6r+3o1Ortpoy8/XNYeh5vJc=;
	b=a2vX8/UBEVFU7QGWgGB1Wi+gAtNKtS7Sc7UoyNsZa7Je9uDKJPMthKBR+y0sUy5xVUfG
	 moZk7+6z/Pp2V1pI16f7mlCHZQphdJsC5gFHZRzE3eM7w8mgvzGq8qbILVv1uqBeKjlPv
	 GCzgKTQ9Y0RIj/lRHUQBpcjHqv8cVU+nn8RAfK15Drfy5Hljoju7qCgEk9Z2EUDoSFiRC
	 1+gK/p3LejmWZwmQ32C/kOF72QQLszEDo4iGIH0YsGvr2z7tVpaWrKKL3XaUTNm6N8ul0
	 QEqSyphNXRt5lB1CoCA8gFVvqQEOYc4P3d39z7yhEXzyJcoEWep+wULq7T4296HiDcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=V+jgQ1o6;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF02D606A33D;
	Thu,  5 Nov 2026 11:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF02D606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=V+jgQ1o6
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE8611516;
	Thu,  5 Nov 2026 03:13:03 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A7243F628;
	Thu,  5 Nov 2026 03:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793877186; bh=S2sqvTjfx8DGmgxaoJVxoR16YG+a/yyGSmirgRu/mPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+jgQ1o6rOJsH5h1kJJMpX+53SW6m9/go/2GVlN4GgatFFDIEhpHiyb8esc3hhP0t
	 ynb1RIr5pbUIHwnZn+kUgoHBKZAisrDjrsgm8DDY9sBJJlLyqzDsWhI9iapyg5CfxS
	 meG9maBDgnIYRbtPRi00vWSgzWx/wyP95Ccp7nEE=
Date: Thu, 5 Nov 2026 11:13:04 +0000
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
Subject: Re: [PATCH v3 17/18] perf test: cs-etm: Add test for per-thread mode
Message-ID: <20261105111304.GR9176@e132581.arm.com>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-17-dbcb0c281b9b@linaro.org>
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
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-17-dbcb0c281b9b@linaro.org>

On Mon, Nov 02, 2026 at 12:15:31PM +0000, James Clark wrote:
> Test that per-thread mode works when the process migrates across CPUs
> and that the decode happens in the correct order.
> 
> A TODO is left in for when support for decoding in order with Perf
> records is added.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
