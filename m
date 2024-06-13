Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BD51411E1;
	Thu, 13 Jun 2024 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274409; cv=none; b=aAN36COMhAgOfq6ze3xCr2kmtZRHMqeCn9hDiSvfinm5mi9yOr9vFFPvTyp5Ayx7e3F9RrpMf0qKJS7HQF3XOjb30yMZBnc/2UMHZrchjTrN7xBBZFJA7kQcqnqjuu03k3/vOPS+DCUE6lF/9zgqbKQ1aB1qwZe2nPQ2ktX7L1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274409; c=relaxed/simple;
	bh=Sq96bddyN3uQbKrX2FL+o0E8D1f+IXdLxMXMd2DRuUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=He1I7B8LELVf1pn5sbkd8gdF9Vn6TqoDtRjSaSxJtNmld1E55eFKM4Zz9yYYZTgRF6XtSxspYo1Y0oNnntWpWG2iFCKtEsmnLktIJLlKj0sg5KqJLUsx92IUhdrAJqnLcpikPeiDNcY9M7aqdelbwlfBT6Wv7lykySbvex8Rjks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PA0RVrMT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PA0RVrMT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718274408; x=1749810408;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Sq96bddyN3uQbKrX2FL+o0E8D1f+IXdLxMXMd2DRuUU=;
  b=PA0RVrMTkOgG0CGKw18c12Ozum9DES7odnHPUWsQ4VhyoyXz36pCB0U5
   nXgc6srDgTKSqHoCqrt5JFU3gXKAQQGmLHjTd44/9vew5YtwYLj2zpOqX
   UAfuPbzJGwGJxqLqkxa5R/4Zn/M6rhyMdGBPcRVHkxGdFouE6qlaXzmBM
   u5zzwLybtHbrz3+tAiaRs3D24D6XwzQSZ5m848wEDYdXl2ugFHmofkeac
   5eohNHSL5nopSM7QHCupS+w4LuzxiRqE0Tcmueev9xedltiKNcHQ8M0Yb
   1q2NwNSd9hWFs7tNEX2k6dbiW0KGf4P1chEpfv97zyocrc+Qi+QNBcFHP
   Q==;
X-CSE-ConnectionGUID: a+RZUv2LQX2AEilByGqMvQ==
X-CSE-MsgGUID: IaMzSQr3S/2zDiGNhnjRGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="18865623"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="18865623"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 03:26:48 -0700
X-CSE-ConnectionGUID: PMeSFWF3RlC3GURBkJtjIg==
X-CSE-MsgGUID: WTVeKHLzTR647YZAzf3QJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="63277918"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 03:26:43 -0700
Message-ID: <6abf540f-5f11-4b2b-b8c1-69783a71277b@intel.com>
Date: Thu, 13 Jun 2024 13:26:39 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf: disasm: prefer symsrc_filename for filename
To: duchangbin <changbin.du@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "llvm@lists.linux.dev" <llvm@lists.linux.dev>
References: <20240613063510.348692-1-changbin.du@huawei.com>
 <20240613063510.348692-3-changbin.du@huawei.com>
 <395cfff7-9692-4123-96b6-353752007f46@intel.com>
 <39be46d6a5194b6390ed31be67689c6c@huawei.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <39be46d6a5194b6390ed31be67689c6c@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/06/24 12:43, duchangbin wrote:
> On Thu, Jun 13, 2024 at 11:15:28AM +0300, Adrian Hunter wrote:
>> On 13/06/24 09:35, Changbin Du wrote:
>>> If we already found a debugging version when loading symbols for that dso,
>>> then use the same file for disasm instead of looking up in buildid-cache.
>>
>> In the past, there have been cases where the debugging version has not
>> worked for reading object code.  I don't remember the details, but the
>> symbols and debugging information was OK while the object code was not.
>>
>> In general, using anything other than the file that was actually executed
>> for reading object code seems like a bad idea.
>>
> Is this a platform specific issue? AFAIK, the binary code in debugging and
> non-debugging version should be identical. 

"should be" != "guaranteed to be".  Simpler to avoid the issue and
stick with the file that was actually executed.  We already support
having separate symbol sources, so there should not really be a
problem.

