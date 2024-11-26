Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DBB1DC046;
	Tue, 26 Nov 2024 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732643788; cv=none; b=YmDCf6wasc5IDGqsxghEfgBZx6KibTswT4JgMmPhDcUcINCKvtNPbjnLTYEY5WK5mf/ZKbKxDVwT1kwQiENc1vih7P/EnrkemvZZ1UJhfvCHHr0l4NfGDWU2U/8s/cbYdd39o79cubHprQwMvJ59anE2ui14NULOM4f82+GPLME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732643788; c=relaxed/simple;
	bh=b2EMFKYbCQrL3zVfpm5cObA15cEJOuCZKP2zA64gpdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qIl85d2cxPSMYjDphFHL38c3sI4BTBC9HL0xs4yrLNoW+JyRCF5jpguESh/un5ZRmXu2nLCBxU7ycMKi9uPW/Nf/z/CKtwgwlQiIvtpdkqtjlD/8lzmusifH1KcO+a5GjEtQZNWi5rotbdRz5I7aW3XfMkzlF/dGoxyeop1gBHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NsjMCTZw; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NsjMCTZw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732643787; x=1764179787;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b2EMFKYbCQrL3zVfpm5cObA15cEJOuCZKP2zA64gpdo=;
  b=NsjMCTZwLbIPbisznIzhY49n1XjDP6eNtUDFtiYsKlSbLyKsk/hLQ/kT
   lfGg0n6tTBWp0hozzQx2oC3UzOtD46sQy2r7m6+Ujem2ycy5Owgs4H1c1
   18/Ltlzm5rWNUMupufqbAUvVGn+Jib+qVVc945HUqU8d63n2Lj5EFfxYU
   R3KZ9+8uYSjM32iaQBriMcvd0aw/X/s+2LT/g7yEGzkwtF8YmdwKiYkhm
   rGldFmjLDhqAn5eyGZvSrafglga1Nd4Gketf0lasQTvC1o79aXr4dR9uJ
   RFD9PWqCD78vKjNsvoOd+MH0PKEm/ZX8Q84Wt/nU4G2sA/HacpEFUIYPD
   A==;
X-CSE-ConnectionGUID: YzoqKSaSSd2biRXskXqs/w==
X-CSE-MsgGUID: ZQFzZG+zSLa78Hu4tntzxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="36746238"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="36746238"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 09:56:24 -0800
X-CSE-ConnectionGUID: 4bgwMG+zTxe7MRZj0TGgVQ==
X-CSE-MsgGUID: vMtMr6fuQEisSPZw7JAX+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="95762381"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 09:56:20 -0800
Message-ID: <bb2821b7-4440-4ecc-925e-4d78ba60fef8@intel.com>
Date: Tue, 26 Nov 2024 19:56:12 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V15 0/7] perf/core: Add ability for an event to "pause" or
 "resume" AUX area tracing
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
 Leo Yan <leo.yan@arm.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20241114101711.34987-1-adrian.hunter@intel.com>
 <9bb112f8-0af1-4517-a4b8-bd2edacce07c@intel.com> <Z0YChjympWOZeu1e@x1>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Z0YChjympWOZeu1e@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/24 19:16, Arnaldo Carvalho de Melo wrote:
> On Tue, Nov 26, 2024 at 02:59:02PM +0200, Adrian Hunter wrote:
>> On 14/11/24 12:17, Adrian Hunter wrote:
>>> Hi
>>>
>>> Note for V15:
>>> 	Same as V14 but without kernel patches because they have been
>>> 	applied, and updated "missing_features" patch for the new way
>>> 	of detecting missing features.
>>
>> Still apply
> 
> So the kernel part is in, I'll go over this after getting a machine with
> a kernel with those features so that I can test it all together.

To be clear, this is just a software feature, so any machine
with Intel PT will do. Kernel can be from mainline tree or tip.

