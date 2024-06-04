Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2803C13E8BF;
	Tue,  4 Jun 2024 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531306; cv=none; b=Fr+chZ/O0YI9rkTFjxWn7IFY8tGjQwqMntMchL8srHimMuOtq1r9FxsCOy/wA+pJxiHy0Vvwgs6JcLIes3FTuIC9oBQd53BvB8w4lEiGvoexE363qcGq5LX6IYuFBgbpZ947neLIEtQ7FwIHRMuQeNOLm7wyc2aRndnjsAE6Wj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531306; c=relaxed/simple;
	bh=RAw2k4mzU8OEDpDAeN6B2j6vr4BCw4gc3iGeitqWH58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGmnAmwtcBmNE07f+U1YnsG+O59CpaYhLd3XXz3pnCLJoAWX1gBGJzcTNFTK/3RCNZcz/q4j0wDdpbKj/pitec6TEo4JC0FGCd/GD4UnV29AqzdXag8gIh0CQNFKSz8/SNZQWakdHkruR7beef6jQ5UAFKYSjPHaK6V2feZl+iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54970FEC;
	Tue,  4 Jun 2024 13:02:08 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F6D83F64C;
	Tue,  4 Jun 2024 13:01:42 -0700 (PDT)
Message-ID: <fc940d6d-7ac3-4f69-8ace-459955f72281@foss.arm.com>
Date: Tue, 4 Jun 2024 21:01:41 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCH 1/1] tools headers arm64: Sync arm64's cputype.h with
 the kernel sources
To: Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Besar Wicaksono <bwicaksono@nvidia.com>, Will Deacon <will@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org, James Clark <james.clark@arm.com>
References: <Zl4MYzhP0NB-Z1DW@x1> <Zl7aOk2h4_73JmUu@J2N7QTR9R3>
 <a1990b2e-2c10-42b6-93e9-fef324cb91b2@arm.com> <Zl9jLtiFagBcH7oH@J2N7QTR9R3>
Content-Language: en-US
From: Leo Yan <niayan01@foss.arm.com>
In-Reply-To: <Zl9jLtiFagBcH7oH@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/24 19:55, Mark Rutland wrote:

[...]

>> Now more and more Arm CPUs support the data source in SPE and share the same
>> data source format. It's not scalable for us to adding every CPU variant
>> into the file util/arm-spe.c.
>>
>> I would like to expose the PMSIDR_EL1.LDS bit (Data source indicator for
>> sampled load instructions) via the 'cap' folder, and then we can save this
>> info into the perf meta data during record phase.
> 
> I'd be happy to expose fields from PMSIDR_EL1.
> 
>> In the perf report, we can parse the meta data and if the
>> PMSIDR_EL1.LDS bit is set, the tool will parse the data source packet
>> based on the common format.
> 
> I don't believe that's right.
> 
> PMSIDR_EL1.LDS indicates that the loaded data source field is
> implemented, but even when it is implemented, the format is
> IMPLEMENTATION DEFINED.

Thanks for correction. PMSIDR_EL1.LDS bit is necessary but not 
sufficient for using the common data source format.

> Today, Arm Ltd implementations happen to share a format, but that isn't
> implied by PMSIDR_EL1.LDS, and there's no guarantee that future CPUs
> will all use the same format.
> 
> For the moment we'll have to keep adding to this list.

I would like to use an opposite way - we can only maintain CPU variants 
with special data source format, otherwise, all other CPUs use the 
common format.

Thanks,
Leo
