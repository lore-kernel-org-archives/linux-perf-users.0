Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98944152781
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Apr 2024 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487768; cv=none; b=kWvTlxPefymtyacccyCZPIOYW2mwMx3WOnJ/DnowFo9JQmsTnkmym2QNI6Q/TSqd+drfktwfZCrWLZSolH5SeDDpK6pvd+fxOCqr/9It3719Z0fgDlHwkHVJAv3gdaV3b/h8HpV50xclD64rxqKK6B6UvFfjSsnl9H37Ik3+rVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487768; c=relaxed/simple;
	bh=9dqN/aRWuNLVid6/A9CDN4qIxnMtFET3MrRfW067klg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nkw6S1/gUTElBDuTlgaAo87qK2ZY5RKnJrJ4eyorABfyF1drQx/DC3z9D9uJq/KDMcvq6o4Ut4UNcsvAClOrjxrsfZ5YvnhKghn11DJolDhXxzIdHbmR7d6H44BJm+KyUbfFusDpYfhb23EKMa4tfNnCFiXal6AO92S0GXRVXow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 419EE339;
	Tue, 30 Apr 2024 07:36:32 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 679683F793;
	Tue, 30 Apr 2024 07:36:04 -0700 (PDT)
Message-ID: <40bd4bb1-a2fa-4173-aea8-8ccd3ca23df3@arm.com>
Date: Tue, 30 Apr 2024 15:36:02 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about using the perf c2c in UMA system
To: Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linux.dev>
Cc: "?????? (Baisheng Gao)" <baisheng.gao@unisoc.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "???? (Hao_hao Wang)" <Hao_hao.Wang@unisoc.com>
References: <80f723d230744bc299044cfd4f8c4d92@shmbx06.spreadtrum.com>
 <20240429214321.GB125@debian-dev>
 <CAP-5=fUdVHu6a8TLi_HYOZv3Ur_Sr4nvx92rkSaxxKJummPzKw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fUdVHu6a8TLi_HYOZv3Ur_Sr4nvx92rkSaxxKJummPzKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 30/04/2024 04:40, Ian Rogers wrote:
> On Mon, Apr 29, 2024 at 2:43 PM Leo Yan <leo.yan@linux.dev> wrote:
>>
>> Hi Baisheng,
>>
>> On Mon, Apr 08, 2024 at 10:52:59AM +0000, ?????? (Baisheng Gao) wrote:
>>> Hi linux-perf-users,
>>>
>>> My perf tool version is 6.6, and I compiled it to run on an Android system.
>>> The problem is:
>>>
>>> # ./perf c2c report
>>> Failed setup nodes
>>>
>>> According to the articles on the Internet, it seems that the perf c2c is only supported
>>> in NUMA system. However, the cache false sharing does not exist only in NUMA, and
>>> the UMA system has also the problem. So I wonder how to support perf c2c in UMA.
>>
>> The log above is related with parsing NUMA nodes, but this doesn't
>> mean 'perf c2c' must run on NUMA system. My understanding is both
>> x86_64 (memory event) and Arm64 (SPE) support 'perf c2c' not only on
>> NUMA.
> 
> The lack of SPE on most ARM hardware really is a pain. Can we add a
> better error message to make it clearer to users that they need a
> neoverse CPU? :-)
> 

This issue seems to be about report rather than record, so I'm assuming
that the record worked and SPE is present.

Having said that, the error message for no SPE isn't great, but it's not
that bad either:

  $ perf c2c record
  failed: no PMU supports the memory events

