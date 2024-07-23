Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA41534FB;
	Tue, 23 Jul 2024 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749202; cv=none; b=lIbm9WGkhuEhoUDHvP1S7OsJmoguRUbbFtCEnSFfgl/uIleltMHxpx3cJkJp8IQT+WazidMfFa6zLOnHLpklFW4j2y4XJwlIAySk5dYl440MiENnAatX/nyFDqz1qNx++Ak1zZ67TaoBy+q7ZRFTUxVrvU/pxHTQY2m7RtAIlHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749202; c=relaxed/simple;
	bh=ZQVQzf9r28aDpEKrXlhIlP8/jK54AYdOy4xRX9yrTEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5y2Mwfrjcj9KG+RAm5W8XKtjJpLIE1ls+9EP18jZoKLtOTUx8lJuuVZ2MpTYkVc++IBIXd2SI0/+amowCOJFSJehy93rf9siqZ1yNsJZrAMw9x2OzlcJJNB03Ta8+nYb9hRVuOcyiamFdJP93vEts/eNNXo0aNZDvZxXcX0heU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GiE/JttS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GiE/JttS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721749200; x=1753285200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZQVQzf9r28aDpEKrXlhIlP8/jK54AYdOy4xRX9yrTEs=;
  b=GiE/JttS2y1XwI4/NJqsxsWyLd36P/bUh/kft2Sw8CTvy5ETCirrZG0Y
   dHuWxh9F10OM6dyDRPCMxPynpXR8SHBeX21eXhJteUptbNj7JDS8NkwhI
   NaYhzc7OkmqCp1rAMle4YFRtbQFdEyKt2SXVIUm8lYr/mWjzRMYwa/RcT
   P16d5fIvdNlwmPcb2GqFZ9BSVA2mkxK+BV8KF/L5Mde4zZZv0jn+XHuvC
   mrX5ppnT6n7i979majfHwXMcQs/9FXXL3mPYtFhvJYkFAnFbwgykqFg4n
   7xqkRtfD56qZcPz//6laGZydtryf10e/CdK74JhubkcljfAkdAw40y82Y
   Q==;
X-CSE-ConnectionGUID: h0h7fkJ0SgCYzgLclyHmIA==
X-CSE-MsgGUID: 0HsghiIEQGilr2WGnDKgGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19509892"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="19509892"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 08:40:00 -0700
X-CSE-ConnectionGUID: 8ygkNfRXSu+8/LIfLnQktA==
X-CSE-MsgGUID: ks+GLq57QIaturWdhwmzQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="52876585"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 08:40:00 -0700
Date: Tue, 23 Jul 2024 08:39:58 -0700
From: Andi Kleen <ak@linux.intel.com>
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 2/2] perf script: Fix for `perf script +F metric` with
 leader sampling
Message-ID: <Zp_Ozo_Iyu1sgL9h@tassilo>
References: <20240720074552.1915993-1-irogers@google.com>
 <20240720074552.1915993-2-irogers@google.com>
 <8c8da262-a398-41cc-9721-4e72e6b7e5fd@linaro.org>
 <CAP-5=fWwjJuHpTJDMtxKYGDa9Sjo-kHk099vBTW8N-6_GtMfMw@mail.gmail.com>
 <945e58b5-5012-45a8-933a-c1a192fd006e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <945e58b5-5012-45a8-933a-c1a192fd006e@linaro.org>

> Yeah I suppose it's strictly better now without the segfault. Could you pull
> in the test and update it to add -a? At least then that behavior will be
> locked down and we can extend it later without -a.

Ian's patch really implements completely new functionality (supporting
metrics over multiple groups). It isn't a regression fix, but completely
redesigns the old "single group" feature.

> I also tested Andi's V5 and still got the segfault.

Yes the earlier versions worked, but they broke perf stat report.
I think the right short term fix is to use V3 or so, but with a
check that perf stat report isn't used.

Then perhaps the new functionality of multiple groups can be considered
over it.

-Andi
