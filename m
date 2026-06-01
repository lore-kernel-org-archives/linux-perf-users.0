Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C53346AFB
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 11:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780311792; cv=none; b=MEHfe+QfIPxSJ804dbm6juXHWCCq73HeaO+8XNwtDdsNvJa//bv83o5/c5d+epD/AjJMX2+DfvnuxpiZ2S/CuMwdJPsFK9YZl17iG+oMfJv1ZF+m9t6ii//1cnoG3136jshYWkkz2Zw1pHMkdquRpwaLQwwEtFUIVSQbFAOTfzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780311792; c=relaxed/simple;
	bh=Gn/MPnQncWjyVKr1C8mFGSS5/tSH4yD2SL94sLUzlG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohR3VMiPIpM61dtZOoiu7ivrF66yPA+YuyfpF/D/hy/XkPdJjEtoYADaNgi045E6dY/9/2QXJeapmSb+9xcfABvutWNAiuNs81QRDl+LswtGXr+Oe/AtbjFeYcJVw5bIa6ftLrFvaqshF/EL6YYOUZHK0WqADggaFmSgehL0Bm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fhKvFbbV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fhKvFbbV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E75391E7D;
	Mon,  1 Jun 2026 04:03:05 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78C693F632;
	Mon,  1 Jun 2026 04:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780311790; bh=Gn/MPnQncWjyVKr1C8mFGSS5/tSH4yD2SL94sLUzlG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhKvFbbVn3oyAQ1xfG8opZ7YgHS/Fi4eQfWZZUiQwELi8O1NmWx6DhTEPkEAARcyM
	 7+oDtUKwTJ+Du1Rj9JKoM6Q0qoFK69fSnCn5VgflkkWfJhOv5rA/r16N6WbFvgdSYV
	 stoJeMjLB9zOxHjaCvzy2IexjtP+A/b1C3xf+H84=
Date: Mon, 1 Jun 2026 12:03:08 +0100
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>,
	Paschalis Mpeis <paschalis.mpeis@arm.com>,
	Amir Ayupov <aaupov@fb.com>, linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	Leo Yan <leo.yan@linux.dev>
Subject: Re: [PATCH v6 0/8] perf cs-etm: Support thread stack and callchain
Message-ID: <20260601110308.GN101133@e132581.arm.com>
References: <20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com>
 <ahmpSnDTJ14_BNiv@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahmpSnDTJ14_BNiv@x1>

Hi Arnaldo,

On Fri, May 29, 2026 at 11:57:14AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, May 26, 2026 at 05:59:36PM +0100, Leo Yan wrote:
> > This series adds thread-stack and synthesized callchain support for Arm
> > CoreSight, which comes from older series [1] but heavily rewritten.
> 
> Hi Leo,
> 
> 	Please add what changed from v5, v4, etc.

Will do. I am waiting a bit for James' workload test series, I might
rebase on it and send a new version.

Thanks,
Leo
