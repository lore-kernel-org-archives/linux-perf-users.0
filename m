Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B09719F13F;
	Fri, 12 Dec 2025 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553262; cv=none; b=mpGn/vY/pC+cWqYY3uUfdF797umR6Xl6zbCdnYp6jq5PXwEcF5Y7a9HDUHXXuMuQESmrBeiZLa62Wm/sZgC8bwHVxUmFA76U0XZEU7lBK5vPAlJnc9jsRIwJHHGLCA0ArMv3xzztZQiBoDfTaFOWVWdA72DErGhAPaU/d5/YRA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553262; c=relaxed/simple;
	bh=mBQqI1et7xpf/bGbZYuUSifqL9pKNSg4sQsEzFUrtiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WM+mGiW5T8eB1XFusVi8u6V2CsLsTdSvwQMt1XDZn4s1x1tjuGQ7WpPoyvzqEsAQ33sfJrCec5Q3RB80tWQexHHFPI/fZ5C9Aax6Kc2IaTmonN98H7tQp5evDhVxn98vF+EcUejfly5V4mKf+k/GfVqkS8LBf3FJvdnyqDNL4cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 396FB1063;
	Fri, 12 Dec 2025 07:27:33 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A2C73F73B;
	Fri, 12 Dec 2025 07:27:39 -0800 (PST)
Date: Fri, 12 Dec 2025 15:27:38 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tamas Petz <tamas.petz@arm.com>,
	Tamas Zsoldos <tamas.zsoldos@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 07/19] coresight: trbe: Refactor AUX flag setting
Message-ID: <20251212152738.GA181228@e132581.arm.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-7-7da32b076b28@arm.com>
 <a638f74f-94bc-4052-b8e1-e940aca2d4ce@linaro.org>
 <20251210154308.GZ724103@e132581.arm.com>
 <27417fd5-902e-4474-8d60-356a94ac9590@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27417fd5-902e-4474-8d60-356a94ac9590@linaro.org>

On Fri, Dec 12, 2025 at 04:50:52PM +0200, James Clark wrote:

[...]

> > The trace can be stopped on Fill mode (stop on wrap) or Stop on trigger, so
> > it is not (only) about buffer error.  In these cases, even though the trace
> > unit is stopped, the buffer may still have space available, tracing can be
> > directly re-enabled in interrupt handler, thus the COLLISION/PARTIAL flags
> > are better choices.
> 
> I suppose this is the bit that I don't understand. If there is space left
> then why is the stop hit at all?

For instance, the buffer becomes empty in the middle:

   +----------------------------+
   |$$$$$$$|            |$$$$$$$|
   +----------------------------+
   ` base  `wptr        `limit

In this case, the trace unit stops when it reaches the limit.
Meanwhile, the tool might have already read out the old trace data so
we will get some free space, thus no need to set TRUNCATED flag.
