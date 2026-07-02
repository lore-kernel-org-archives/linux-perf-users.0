Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E145234DCD6
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Jul 2026 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782981051; cv=none; b=WR5FYKDi9L91plyvUoNXBYsWl5BFs5cQUX99B351Gzhmm5rG6Lq2P0lG7kRKMQ24WmLRz6AQO2DuFDm6u1gXDZQNvueneoCHyr1LirI+jOUtPmwxJ9GQBFShGv28JfMA1jLEhVNTLrs8FIF5GlWeNfUAMAMlp4G33ALjM9pMLjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782981051; c=relaxed/simple;
	bh=53jutx2nIBzi+bUTAuyz0F7HM/xhqBvW1Nmp6N/44cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkZQHsSu5puBmoVD7m3t/dHxYCl780Amyei3ohTTx3E7yyIT2yVtrncN49rb/dtygiiddImT7NzVB1IKItF+vhuq5p+mms900VNaw7iv3bbTNYP4vOqe4Pfw9g+epmqPpRDR8CX7TPykRUtYeNwSQatLWBKStGZ8JaKP8T5RBaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l1TZHRdj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l1TZHRdj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E903C356E;
	Thu,  2 Jul 2026 01:30:44 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3CD33F905;
	Thu,  2 Jul 2026 01:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782981049; bh=53jutx2nIBzi+bUTAuyz0F7HM/xhqBvW1Nmp6N/44cA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l1TZHRdjkb+IHGGvGNcnY5wUsqIdpI8pryAhBDq70IaVbGy8A5eDX6bcZQQoMK9gr
	 UmcmKcgZjI/QayHK7oBUslWYa2ud8MnRTVnYwTE7BsQf2Bo0lTSiX9oP+8UAwG80u2
	 fS5wj6/3h0TTQWODYboLTB3QuTDe3kLL0SSxWpbA=
Date: Thu, 2 Jul 2026 09:30:46 +0100
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>,
	Paschalis Mpeis <paschalis.mpeis@arm.com>,
	Amir Ayupov <aaupov@fb.com>, linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	Leo Yan <leo.yan@linux.dev>
Subject: Re: [PATCH v10 0/9] perf cs-etm: Support thread stack and callchain
Message-ID: <20260702083046.GI1812158@e132581.arm.com>
References: <20260617-b4-arm_cs_callchain_support_v1-v10-0-e8b6e5d63db5@arm.com>
 <akMPoLNBbAEyNU64@google.com>
 <20260630082310.GE1812158@e132581.arm.com>
 <akRX7gwfDh01AD4-@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akRX7gwfDh01AD4-@google.com>

On Tue, Jun 30, 2026 at 04:57:34PM -0700, Namhyung Kim wrote:

[...]

> Hmm.. it's not applying anymore..  Please rebase.

Thanks for reminding. I'll rebase it and resend today.
