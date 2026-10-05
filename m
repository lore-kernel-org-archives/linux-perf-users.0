Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AFF47F2E0
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206137; cv=none; b=ZkqmbRj1UjPW73kQq20btsh2g04epGWv7jW2Lsh20vO/ld82vJdG+CqyV+fwzVzlcZS1W+eXBI/Wvz6RNBT1u8a1daYH9bxzV3uFyi7V4O7qqfAMztRGzgSMYS9BCV5q7mM4XLd7zNu7NJ9B4dGmPZI17qmlSMKOCyp/GIVYmMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206137; c=relaxed/simple;
	bh=m3tmSH0+leL7BS79iE/YdCgWfzPU9HDRqYcmSoRJD60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAoswqGTxhCkMayw6kmnP0c6CqFBejdehw1I+mj2JiNVjZY3Pdh/+Zsbn01WWCmJARZ+499GFZdFfx4e0YBO9fym0rGHS5ZjIIfsDlt9lMzByCrAz+reI7uGOZsTrYO/vorZs8p50gLMJppx+DmRXG4r/grEGCwfwp3JIQGRw/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KIoe/8CV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KIoe/8CV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C187152B;
	Mon,  5 Oct 2026 06:15:31 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43B0C3F86F;
	Mon,  5 Oct 2026 06:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791206134; bh=m3tmSH0+leL7BS79iE/YdCgWfzPU9HDRqYcmSoRJD60=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KIoe/8CVD+wIe5QvHf9R7AMxlQqGiVNz0V7h5QPw/ZHk2OZsH79wmWEzt9Y1FfqzX
	 ZwsAJ3IoJNBq2cwafU4UjpJMqKW6zdpFuJFYIwSYCjQwsWSP+CbwK11PYGo8zrCCQa
	 FZMAltM8TzJtX3bWD+Hw3zF3f5wPv7kbo7+WdpbY=
Message-ID: <426110f0-0ef4-4f15-b68f-103a863df3aa@arm.com>
Date: Mon, 5 Oct 2026 14:15:32 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf: Add Arm Bus Monitor Unit driver
To: Will Deacon <will@kernel.org>
Cc: mark.rutland@arm.com, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <c936505c43275f434bce924b7657e42bfb25579c.1789652832.git.robin.murphy@arm.com>
 <asLO8rGQPYo3KhKB@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <asLO8rGQPYo3KhKB@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/10/2026 11:10 pm, Will Deacon wrote:
> On Thu, Sep 17, 2026 at 02:47:12PM +0100, Robin Murphy wrote:
>> Arm's Bus Monitor Unit is a low-level performance analysis tool for
>> matching and counting transactions at interconnect interfaces. Each
>> BMU consists of a number of "interface monitoring units", with some
>> global controls to synchronise them and so permit accurate calculation
>> of cross-interface metrics. Each IMU contains, among other things, its
>> own PMU largely based on the CoreSight PMU architecture, but with some
>> functional incompatibilities due to the nature of how much per-event
>> filtering needs to be crammed in to categorise AXI/CHI transactions at
>> the protocol level. As such it gets an honorary home in arm_cspmu/ in
>> order to share the common register definitions, but for simplicity does
>> not try to bend the functional abstraction to fit.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>
>> ---
>> v3:
>>   - Couple of inconsequential tweaks to shut Sashiko up about things
>>     that would never actually happen anyway
>>   - Drop unneeded DT patches that I can't be bothered to fix right now
> 
> Please can you take a look at the Sashiko comments on this one?

I did start writing a reply at the time, but it was getting so sarcastic 
that even I thought better of sending it...

In (polite) summary:

1 - Gibberish
2 - Yes if firmware blatantly mis-describes the hardware then Linux may 
not work properly. Whoop de do.
3 - Yeah so?
4 - Pants-on-head gibberish, but the second part about COMPILE_TEST is 
fair (an oversight from ripping out the DT support) - fix is already in 
-next via the ACPI tree[1]
5 - Yeah so?
6,7 - Yes, welcome to perf...

Cheers,
Robin.

[1] 
https://lore.kernel.org/all/CAJZ5v0g4k6FhyQMypkRyVJMkSBUsmeuetJuxRA826PcA7Mo5Hg@mail.gmail.com/

