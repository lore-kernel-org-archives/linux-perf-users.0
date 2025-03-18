Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A83C20DD59
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316031; cv=none; b=W+hM0wYqjSi26P5XSN/0StU8T2IaTbigrgEgEiaIyvKb5MpLcexl6svbXc18UmRd8m98Be0Sul78+k/Cdt2AbiKcx/e8vDlsNFI+nX60dwz5ILr5AcXmwXMCay2c3ogyM4BIZ9uS7T/bZivKRtfZErZ63+o3qguPGFT6LAHSD3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316031; c=relaxed/simple;
	bh=vEPl/y3LgtH2QBGmF75fjZHCU3BgS4XCU7fD+4rRQ6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUAJhAIE5C7Y6z3t2YeG6Zla13YgWiPWcoPXxd/JfVCLTJRFjojtN/FEbD2lbZqzyeS0H4L+vmCtZlBtIDVuPBu/ehPkiEIR4R1D82YCwG+gWVZuSXbR50Tuj8LgCf9zcJgMVPI96SQN9ZijZjv8tGWbddv68wJhu/Y0QSPF1ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24B911063;
	Tue, 18 Mar 2025 09:40:37 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 272823F673;
	Tue, 18 Mar 2025 09:40:28 -0700 (PDT)
Message-ID: <e1d7aee0-06e4-4aa3-be37-98b0e9b165fe@arm.com>
Date: Tue, 18 Mar 2025 16:40:26 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Resend] perf/arm-cmn: Remove CMN-600 DTC domain special
 case
To: Will Deacon <will@kernel.org>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org
References: <67985e39f53b56385d79a4f1264cf7f9cacedb58.1742308248.git.robin.murphy@arm.com>
 <20250318161744.GB13981@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250318161744.GB13981@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/03/2025 4:17 pm, Will Deacon wrote:
> Hi Robin,
> 
> On Tue, Mar 18, 2025 at 02:32:10PM +0000, Robin Murphy wrote:
>> The special case for trying to infer the DTC domain for DTC-adjacent
>> nodes on CMN-600 is fragile and buggy - currently resulting in subtly
>> messed up DTC counter allocation - and the theoretical benefit it
>> offers to a tiny minority of use-cases arguably doesn't outweigh the
>> inconsistency it offers to others anyway. Just get rid of it.
>>
>> Fixes: ab33c66fd8f1 ("perf/arm-cmn: Enable per-DTC counter allocation")
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/perf/arm-cmn.c | 7 -------
>>   1 file changed, 7 deletions(-)
> 
> You've got "Resend" in the subject, but I can't seem to find the original
> posting :/
> 
> Please can you point me at it? I just want to make sure that I'm not
> missing patches, as you're unlikely to be the only person affected if
> that is the case.

Sorry, forgot to explain below the cut - this is a resend from my end 
because I fat-fingered my LAKML alias the first time around, so I wasn't 
entirely sure whether you'd get it twice. I guess the error I got was 
actually from the SMTP server before it delivered anything, phew!

Thanks,
Robin.
