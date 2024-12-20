Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E150482CD;
	Fri, 20 Dec 2024 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734723378; cv=none; b=lhI2F3g+o4GTyv/TRM3axVbIo28aFM+P/lZopR8vAEbPMoATknsuWSU2v2LjS1cvb17/N6y1WIRmbg9ryOVb4UnJRIqeVPjhoc37lWA/IUcML6xNUO7xWBZtNUHqzRkDa8Yy3cLN3UeF9NAm0jK8BeW5tUqcDfy1rfB70b+arIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734723378; c=relaxed/simple;
	bh=6jTJd9J16ZjQkqne3jRNNL0bVsInVxBnf0unHWuxKbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ilul0IMiP2+hYUgRNv91u9gB69znB1BajSHQGhEiBZwpU4H4o/8S82Quu3ZJ6Nd9d8GJ7+eK2AAXEdRiWHlC0r7TRtjkDU2xpYZlnjwcFZIc7lL4xJqviPBfP1hx5TLk45lkVZfL9r4fTizgSh6UlOrV1AsmaJcgEixdMFHsh20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JskPITrt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JskPITrt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734723376; x=1766259376;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6jTJd9J16ZjQkqne3jRNNL0bVsInVxBnf0unHWuxKbg=;
  b=JskPITrtTXhVOOuaEi2my/t2g1Ij3lZzGmgrEc301+jacyMgeOaR5hNQ
   KDRtKeVc9jZOL4znLTxRV0NoT7NgH4Q5hz8KRNnTGv/o574RmO/sOXJZC
   8AwgpQ1m7KW+B8Xsyx5UjBSjHvJlnK7fzNABAKFPs1RS8rE33oHIhwIai
   JHrDqr/NrdRAomIRWRkEuWLwgzK7i45qO398t1w/Iduw5HkrBP6EdzNJu
   xOsAf0+GblbYbYVZp62Feo0+f8Ay6+mg3+BW7CRoOGBGk+XUmDq0LZr3H
   8J9jUAUgnTAzaW55kofEbOQA+klNshWXFNv6ofqSiz/wz4bIhEeO25eHo
   A==;
X-CSE-ConnectionGUID: 4iKisNB5S/qc3UlrsaGLKA==
X-CSE-MsgGUID: R+rjQZ6HSQOjSUT+8MwySQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="57754588"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="57754588"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 11:36:16 -0800
X-CSE-ConnectionGUID: 9QiSxdOMSHOFInRjyOlQwg==
X-CSE-MsgGUID: hVvxZSH3TeaNo+T7DyIaxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135944371"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.24.8.90]) ([10.24.8.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 11:36:16 -0800
Message-ID: <74fd8a75-66c6-40a8-9ec3-d7aa74469755@intel.com>
Date: Fri, 20 Dec 2024 11:36:15 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf: map pages in advance
To: David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Matthew Wilcox <willy@infradead.org>, Yi Lai <yi1.lai@linux.intel.com>
References: <20241205082948.56212-1-lorenzo.stoakes@oracle.com>
 <65a04f0d-668b-47b6-a532-d1e11ef4835a@intel.com>
 <4ded2d63-03dd-498e-9810-690a9eff0c22@lucifer.local>
 <860a1ef0-678d-414d-8511-9695b90c3ca0@redhat.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <860a1ef0-678d-414d-8511-9695b90c3ca0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/20/2024 1:56 AM, David Hildenbrand wrote:
> On 20.12.24 10:31, Lorenzo Stoakes wrote:
>> On Thu, Dec 19, 2024 at 01:17:44PM -0800, Chen, Zide wrote:
>>
>>> With this patch, it seems perf tool has some problems in capturing the
>>> kernel data with Intel PT.
>>>
>>> Running the following commands, the size of perf.data is very small, and
>>> perf script can't find any valid records.
>>>
>>> perf record -e intel_pt//u -- /bin/ls
>>> perf script --insn-trace
>>>
>>>
>>
>> Hi,
>>
>> I'm on leave (and should really go back to relaxing :>), returning on 2nd
>> Jan so can't really dig into this.
>>
>> But I tried it on my intel box and it 'works on my machine' with and
>> without patch with commands provided, so I'm not sure this is actually a
>> product of this change (which shouldn't impact this).
> 
> Zide Chen, can you try with and without this patch to see if it
> introduces the issue?

Yes, I re-did the test on a SPR server, and the result is same. Without
the patch, it went well; But with it, "perf script --insn-trace" doesn't
show valid records.

This time I tested it on the clean 6.13-rc1 tag, base commit
40384c840ea1944d7c5a392e8975ed088ecf0b37

Also, with this patch, running tools/perf/tests/shell/test_intel_pt.sh:

Error:
The - data has no samples!
