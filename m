Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C214F799D;
	Fri,  4 Sep 2026 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540194; cv=none; b=LY8kf6vWxLE13G9lKV5bjSiGsrHtTWW1JzxPqn/chW3uhFJVCRGrZtE9VFFywCZ0TURD99Ud9XaQIOqBZHyeANYLH7pHLCJaGWdVwDWEXHmXijAUtucyc/eMTefdsieJelJbxBTuWFdpl4zRJMGE747WIf7CfL6sxe4rIJpv5Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540194; c=relaxed/simple;
	bh=NWFUWnZ6K0kaIQa0lax2jcCLiQ0kC63Ncs4dMPYXg+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLb6+LApWjXXTCbqY2JPnkfLmDNuKhqTdprevJMkIYuBRluefIW83iGqq8Wjx4KtjIreX+62XlYLrglqbSE9lCR+1bJxH7fK0owSQJLOioWQKEptM+vZuWMwx6L7TWSPXwM2+7wS8rd0f0gPPw1HOfZCqRlM3qtoiSWm42k1Slk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VFflIllV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VFflIllV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 880DE152B;
	Fri,  4 Sep 2026 09:43:08 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF7133F673;
	Fri,  4 Sep 2026 09:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788540192; bh=NWFUWnZ6K0kaIQa0lax2jcCLiQ0kC63Ncs4dMPYXg+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VFflIllVWWur8MgIIluCe6ArvirPpjzkKINBQNHG7JxWalWtZCuY9WZf8T0x5ByKB
	 UEZnP63o6FocTm7tPHu+57zl0eT/Xudy2HWrhCOr3+/DBT+Z+zABlFvt5sgNffMQRH
	 w5+V2CaAWMSEwlx1dY+1esEhTntE0+4r1P5Zg1qE=
Date: Fri, 4 Sep 2026 17:43:09 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] perf: cs-etm: Don't add global v0 HW_IDs to
 unformatted queues
Message-ID: <20260904164309.GZ8904@e132581.arm.com>
References: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
 <20260821-james-cs-hw_id-output-failure-v1-1-9d532ddabcc3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-james-cs-hw_id-output-failure-v1-1-9d532ddabcc3@linaro.org>

On Fri, Aug 21, 2026 at 10:50:29AM +0100, James Clark wrote:
> In the case of mixed formatted and unformatted trace with v0 HW_IDs, or
> no HW_IDs at all resulting in the cs_etm__map_trace_ids_metadata()
> fallback, formatted queues will write their HW_IDs to unformatted
> queues.

I understand a session can support multiple sinks, but I don't expect
to mix up formatted and unformatted trace (see sinks_compatible()).

For the mentioned fallback, I am also struggling to establish a case.
Even AUX_OUTPUT_HW_ID records are absent randomly, I don't think this
impacts the queue's format initalization, no?
