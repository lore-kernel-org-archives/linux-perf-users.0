Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D447A14533F;
	Thu,  8 Aug 2024 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723106112; cv=none; b=rpY16WtSg/xCYZaXdGF718vmcbcj42DTZnwFx2Gcewgx9n/koWCA7+Q5UCFcMfuSr1mGDd7A8h/29ckolASCKsd1HP5GNtXSIRJndr32pzPh9NprBEjgjFINpp8z6L0SIr47WjCVn1yfI58JlxMW8wouBDlD/hBYBC4FXPWNuRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723106112; c=relaxed/simple;
	bh=cW+F5Z3NJwA+OTcTa+kQhg5RIdMToADuCv3NjjJKaqY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=G/3WLJa4dj6p3WBPIIRNUZJodwcH3ZxFRU8PFnQHB72n43TYpZsypXDBZZNSNzDVAPcmtPCcHRBRtiZ5Zt+QV4Dq84DNjrhRpyhUpU/JMQOQD1lQX8RN5q/8w3fjR3YLiG2gvCKaqh/aY22zmijoGTPkqd3fhZ326f0kQrrDBso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1B39FEC;
	Thu,  8 Aug 2024 01:35:34 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09B3E3F71E;
	Thu,  8 Aug 2024 01:35:06 -0700 (PDT)
Message-ID: <38be6496-891f-4a6b-ab33-49d63dc9570d@arm.com>
Date: Thu, 8 Aug 2024 09:35:05 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Leo Yan <leo.yan@arm.com>
Subject: Re: [RFC/PATCH 1/1] tools headers arm64: Sync arm64's cputype.h with
 the kernel sources
To: Besar Wicaksono <bwicaksono@nvidia.com>,
 Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Will Deacon
 <will@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 James Clark <james.clark@arm.com>, Vikram Sethi <vsethi@nvidia.com>,
 Rich Wiley <rwiley@nvidia.com>
References: <Zl4MYzhP0NB-Z1DW@x1> <Zl7aOk2h4_73JmUu@J2N7QTR9R3>
 <a1990b2e-2c10-42b6-93e9-fef324cb91b2@arm.com> <Zl9jLtiFagBcH7oH@J2N7QTR9R3>
 <fc940d6d-7ac3-4f69-8ace-459955f72281@foss.arm.com>
 <ZmAwYjyElYQqQy7c@J2N7QTR9R3>
 <SJ0PR12MB56763246FC68494FB086DB84A0B92@SJ0PR12MB5676.namprd12.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <SJ0PR12MB56763246FC68494FB086DB84A0B92@SJ0PR12MB5676.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Besar,

On 8/8/24 05:37, Besar Wicaksono wrote:

[...]

>>>> Today, Arm Ltd implementations happen to share a format, but that isn't
>>>> implied by PMSIDR_EL1.LDS, and there's no guarantee that future CPUs
>>>> will all use the same format.
>>>>
>>>> For the moment we'll have to keep adding to this list.
> 
> I apologize I didn't follow. Do you mean adding new CPU identifier to neoverse_spe[]
> list is still the way to go for now?

Yes, the conclusion is we still need to maintain the CPU ID list for Arm SPE
data source packets.

>>> I would like to use an opposite way - we can only maintain CPU variants with
>>> special data source format, otherwise, all other CPUs use the common format.
>>
>> I think that's not a good idea.
>>
>> Today, Arm Ltd CPUs happen to share *a* common format, but that's likely
>> to change at some point in future, and CPUs from other vendors are
>> likely to use different formats.
>>
>> Assuming any format by default means that when CPUs with different
>> formats are released, we'll produce incorrect results for those CPU by
>> default, we'll need to update tables to exclude those CPUs, and we'll
>> probably want to backport that exclusion to minimize the risk of users
>> getting incorrect/misleading results.
>>
>> While the current situation isn't nice, I think the alternative is
>> worse -- it will confuse and anger users.
>>
>> I think we need to talk with the Arm architects to see if they can
>> define some discovery mechanism for the data source format.
> 
> Is there a follow-up on this from Arm?

I am working on this. The plan is to add meta data support so we can have more
info about Arm SPE features (e.g. data source packet is supported). Then in
the perf tool we need to consolidate to support not only Neoverse core.

It is deferred as I need to firstly resolve the multiple Arm SPE devices, then
I will work on the meta data things and consolidate data source packet (and
include your patches [1]).

Thanks,
Leo

[1] https://lore.kernel.org/linux-perf-users/20240109192310.16234-1-bwicaksono@nvidia.com/

