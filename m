Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812576;
	b=1hZjp5f791r49Pnn6Ewvk5dgr7szkxZjnqQmdjL7BEXFmhTWfH1q/pzLRNchLClxM741
	 Dvne1QMFa0w7sccoUPSPG3887/44xc+aQQ/kuyBoFHfBLiYCytMGoI3zO5alLzjQ3P+6F
	 aDgT0BwX3wHKT4J+2TErVumLIysjg4ny0nX6SMcikyKsWHqirfH2IUY7pavdfd+DwLOX/
	 LDqeYbkAGmPzZUXFZJpG17KvaazWozyE5egq1VmQAVqHqV7c8PVIrDeF3Guk5fyAK7WsA
	 v7jAfJ6whh+A+OlF2idkLEjaIpp0rM6hwDj7rs1rX+OocHMNy7wcAmUUQ4BUpmC/aug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812576;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=G6piw17zsMhVcLRQ/Dg2jf3W7PAeTRazgMleX2m6GP0=;
	b=0/VMnI61MhrJzR2vHKD2rLm113BGW3sFbSllZhiuUUKyG2A0wdPwwtcoJ6o2uw6gyK+O
	 lz6WQSUP0w02iXMNHyWaN1lRZwsy4rQqlCFBn9nIoKDJH7Cw9i1FgRBULMUjYwD56Mb3P
	 70hr/J1IcRFCBephteALH1ldaYcN0iHIIKxsQWI8w799UMV/bW7ERSnbKtdLenYdEyMWC
	 vBw8PJYUjln3cpQ4hfX/us/Jz6LywfjGeGIu5yR8Flr0tamaENSFHT5I80UDWTkRIKhmy
	 9dunQoq9who972lpfTvnhbmfCEwe+YFUx5gyEhoWKVyFn0B6D7cbOUvL2oga2m0DB2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=miPBP8n3;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E47606A31B;
	Wed,  4 Nov 2026 17:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17E47606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=miPBP8n3
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43DC71BB0;
	Wed,  4 Nov 2026 09:16:11 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E47373F673;
	Wed,  4 Nov 2026 09:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793812574; bh=rjFG8+pH2b8+JHyFE8+L/4q0xjEFb4uHAwVsDh7Gt3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=miPBP8n3+SPHqDpdlN2QuS0mCHcF9FE1RQJKlaMe6Fdiuo0cmRfBncPjj2sgPisKT
	 B56FKi//xbM6bXATp4Per1c7DVpZgzKM9btoYd+4CJYD+dPVPdjWH+MwWwUXKshkhO
	 O/s/O2cJH2hWl3h7fj4ARASEO2wsUP/HXaLsZqxc=
Date: Wed, 4 Nov 2026 17:16:11 +0000
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
Subject: Re: [PATCH v3 10/18] perf auxtrace: Turn Intel BTS snapshot search
 into a generic one
Message-ID: <20261104171611.GN9176@e132581.arm.com>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-10-dbcb0c281b9b@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-10-dbcb0c281b9b@linaro.org>

On Mon, Nov 02, 2026 at 12:15:24PM +0000, James Clark wrote:
> Currently each auxtrace user has to implement both the snapshot search
> and the logic to fixup the 'head' and 'old' values after finding a wrap.
> IntelPT and BTS have the same fixup logic but different wrap searches.
> BTS and Arm SPE have the same search but SPE modifies head differently
> (although it probably shouldn’t), and Arm Coresight doesn't have a
> search at all, but later it will want the same search and fixup logic.
> 
> Add auxtrace_record__default_find_snapshot() as a generic
> find_snapshot() implementation that tracers can use without
> reimplementing it. It's based on intel_bts_find_snapshot() and the
> search includes the caching from it. Split the pointer fixup into
> auxtrace_record__snapshot_fixup() so that tracers with their own search,
> like Intel PT, can still share it.
> 
> No functional changes intended apart from changing the pr_debug3()s
> to print hex to match __auxtrace_mmap__read() and no longer leaking
> snapshot_refs when expanding the array length.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
