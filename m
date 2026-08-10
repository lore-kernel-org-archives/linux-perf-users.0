Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3EB3C4B89;
	Mon, 10 Aug 2026 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364712; cv=none; b=KtnhglH5gPnjQHhIK6qZ2roe0epbadxlrOAVJz2D4gb9CRAwSaDTeGClECz/qeCpRW+KntoL4McIC9KlfhyF1FGrXwvvvUWMn1ZcOjX6q9g8z+SJIF7jSKAMSk9VJXDUMudV6z1voEMiFkwrt+GKM1GlUnlyMosxuGyEmgCIGlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364712; c=relaxed/simple;
	bh=YhYt8kKeP1prvkFYN9IP9TNyzqL6Tiu60Aa4oujk0uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBYeBNKoaD8r/O0WDOBWxfWFPR+jR9SYYqCRdMNadofWpAEMt41GDwlnqHGlrWMe5dXRNCGjLZYOITLHjA1mn0vObfYnOXXTup1PteQjVBKeGHeL+Ai97tuNomWwY8RJ9eHURbrNExrfbxrlPDEBq3SItowdqVlzjelgRvpxWPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mgY0ss1g; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mgY0ss1g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786364710; x=1817900710;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YhYt8kKeP1prvkFYN9IP9TNyzqL6Tiu60Aa4oujk0uc=;
  b=mgY0ss1gbtIpnC56hDn2akgiPq7ZoZ2ARudXUcUx+dazJiUpzQgyZp03
   oLuXeuUF7hMdiU6u2hWPuR3i8lx5lqnAvb6rf7nnW8qaGR8kTYqeVz4Hz
   x+tlScGXfhnDsnPnoSjn9gm9YIH4+sZL12YR8xE8B+I4eLqigUpuwj7Ix
   P79P6fQg/4X2azjgylEg0mUGqrPGyrtQ0F8eQh8F4Z0eRox8izE+Z2A71
   Ww8TboZSL8DF0XAXc6nQeL2IUI9K5YqOn8RLG3xQGqu4f4ELoKEXnG0C+
   kaDWLTezAXaLKaV1bB9U125YEjQDUi0XV985YXyoKKu5Fw2gf1Zd12J+J
   g==;
X-CSE-ConnectionGUID: uPVta2qJRU2whevd+INWcg==
X-CSE-MsgGUID: G1WKn/RgTESCb7VMkrIwyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="97225889"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="97225889"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 05:25:10 -0700
X-CSE-ConnectionGUID: eT89tigzRPqj9o2Dvwbx0w==
X-CSE-MsgGUID: e8Z99cX3S92zFgbjU+mk3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="268185403"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 05:25:06 -0700
Message-ID: <568585e8-a438-430d-8760-34134cca788f@linux.intel.com>
Date: Mon, 10 Aug 2026 20:25:03 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 6/8] perf/x86/intel: Fix intel_cap handling on hybrid
 PMUs
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
 <20260717080342.1879573-7-dapeng1.mi@linux.intel.com>
 <20260810121842.GW776954@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260810121842.GW776954@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/10/2026 8:18 PM, Peter Zijlstra wrote:
> On Fri, Jul 17, 2026 at 04:03:40PM +0800, Dapeng Mi wrote:
>> +	/*
>> +	 * The Perf Metric (Bit 15) is always cleared on P-core of
>> +	 * RPL and MTL. Details can be found in RPL018 erratum.
>> +	 * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processor-specification-update/errata-details/
>> +	 */
> Typically intel.com URLs are unstable and not worth the effort of
> including anywhere. I'll strip this out, its probably easy enough to
> google the erratum number.

Sure. Thanks.


