Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9133199FAC;
	Fri,  1 Aug 2025 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754069077; cv=none; b=HzXUjtUFDtMB0GIUHc9xoYCp2HXJ058Jygcdr3FJ5e9JmPElkzXwiA/kEDwDkwmS1t6td+holg/Q6c1OJDdP3Qzwk3jpoChdAp5s+alwFJVtAXM4+mdBPAom0tL1FKCczxSb94Nl2mOA9HwpeAm9hqY6nElzLTvnEQHcgrtDozs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754069077; c=relaxed/simple;
	bh=ecxWVcBCPStvfchBAMc+hlF5f3nRLwKF2HyInHfz+i8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R02SqElk+L0SMVS+Dqdgcl1AqXWavrweLGHcCUdCfebqVFxByKjRlWyGBtCi8kdcLY1c2mf48TErQMgxya34ReRR9mzYzhvbkBlPKNaC0SvYRtXRnh7KUPKBkvxADJBdLRPzYjmlrWNEIbvxiiD8Lhr7l0B0Ludl+aLTdMjSkAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxOPJEr0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxOPJEr0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691A8C4CEF7;
	Fri,  1 Aug 2025 17:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754069077;
	bh=ecxWVcBCPStvfchBAMc+hlF5f3nRLwKF2HyInHfz+i8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WxOPJEr0o8SJpdVtx/wesIv97ZeFDDL2OBRJMLdTCR+pkFrlHO7UdknX9uPkXXyvR
	 nqqvOmMW30ruA02pxLpQQba3KbJ4havP2Ztlxn5r0w1EMHPmf5EQZIP5RCGeL4gDTp
	 jKQxDC8P+MUllwMK8KC+fD7/xHy50zRBs1GNqUfhk/rqQPvb2OV1iZ7FUVLN6shgsK
	 +20JKEAYOMxdGNfwDLR3oFAphPqIajqtSMvZ9Iecurbc0+suEK5gSURCF5g/wRU5JQ
	 96PFQ6/Za3jO6szwpy4j/WG4UiyVIP6ba4Pi2XTJFoAct1WkLmtwc2PE5xMYX8EvMD
	 Su2PQGdfw8Ang==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20250731070330.57116-1-namhyung@kernel.org>
References: <20250731070330.57116-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf record: Cache build-ID of hit DSOs only
Message-Id: <175406907739.1475083.17263250122048351650.b4-ty@kernel.org>
Date: Fri, 01 Aug 2025 10:24:37 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 31 Jul 2025 00:03:30 -0700, Namhyung Kim wrote:
> It post-processes samples to find which DSO has samples.  Based on that
> info, it can save used DSOs in the build-ID cache directory.  But for
> some reason, it saves all DSOs without checking the hit mark.  Skipping
> unused DSOs can give some speedup especially with --buildid-mmap being
> default.
> 
> On my idle machine, `time perf record -a sleep 1` goes down from 3 sec
> to 1.5 sec with this change.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


