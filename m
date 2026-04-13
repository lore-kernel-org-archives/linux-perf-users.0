Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E833B3888;
	Mon, 13 Apr 2026 09:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073927; cv=none; b=g2pHz1/hTkV5FUj0V7UWm8dNJfZw0+f9zVinkd69dX9vundzsl4fmK3XugUIP47Nh9X7zVV7xt3eb3qWrVheYNRMcKK7y2qw/qgCBM72VnQ8bqvYEMpZsweQAGDUrsP/l7gASvKyZq631I/QXM+a+73YHsJ538WcN+Av/Iuf/0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073927; c=relaxed/simple;
	bh=JG9jZqoBzqnJwy6iOUhHxZ1WPwalVtEYtkB525yIRcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLweTn4txay2igey35GQUFbxVDPKW0wM+Bf4nmpjJ2m68Jsz7lppjB9/BxJdx8qWkfsdPf75k2DCGom35D1eBeWXcaDptBIQ/cHNfhp3ctsjm12FCFLMqa7bSQmKDq/7g6cs+y6JfeFFLHyb94iFXXQ8iIoHyqQZJXlbOjV/DP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hxiZD6cE; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hxiZD6cE"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA7241684;
	Mon, 13 Apr 2026 02:51:58 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE8B03F93E;
	Mon, 13 Apr 2026 02:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776073924; bh=JG9jZqoBzqnJwy6iOUhHxZ1WPwalVtEYtkB525yIRcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hxiZD6cEtMd+rnOziYfMFlmMO5AUT5tKQL1rmi+HS7I1jJ4jByZXvnMUBmd0scMWa
	 SnHuVM15fmW+vdAOUaifwSaKtILDYe1V8CklDjfYK+y8A8ibVmzycZYnYHN4867zr0
	 MVPahyfUqkNOXgN2GGTomb4R021uLcQ+CUeFGsPQ=
Date: Mon, 13 Apr 2026 10:52:01 +0100
From: Leo Yan <leo.yan@arm.com>
To: Jie Gan <jie.gan@oss.qualcomm.com>
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] perf arm_spe: Print remaining IMPDEF event numbers
Message-ID: <20260413095201.GB356832@e132581.arm.com>
References: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>
 <20260407-james-spe-impdef-decode-v2-6-55d3ef997c48@linaro.org>
 <3e7645cf-28cb-4021-89e6-e467e9555ff4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e7645cf-28cb-4021-89e6-e467e9555ff4@oss.qualcomm.com>

Hi Jie,

On Sat, Apr 11, 2026 at 09:08:18AM +0800, Jie Gan wrote:

[...]

> > +	/*
> > +	 * Print remaining IMPDEF bits that weren't printed above as raw
> > +	 * "IMPDEF:1,2,3,4" etc.
> > +	 */
> > +	if (payload) {
> > +		int i;
> > +
> > +		arm_spe_pkt_out_string(&err, &buf, &buf_len, " IMPDEF:");
> > +		for_each_set_bit(i, &payload, 64) {
> 
> for_each_set_bit(i, &payload, 64) passes &payload where payload is u64. The
> macro expands to find_next_bit(const unsigned long *addr, ...). On a 32-bit
> host unsigned long is 32 bits wide, so only the low 32 bits of payload would
> be scanned; bits 32–63 would be silently ignored.

I think this is incorrect.

Even though unsigned long / long is 32 bits on 32-bit CPU, this should
be handled by the BITS_PER_LONG macro.  The FIND_NEXT_BIT() macro can
fetch consecutive long values when the size > BITS_PER_LONG.

> While perf is almost
> always built on a 64-bit host today, the tools/ tree is explicitly portable
> and the compiler will emit a -Wpointer-arith / -Wincompatible-pointer-types
> warning on a 32-bit build.

I agree we should fix building issue on 32-bit target.

Thanks,
Leo
