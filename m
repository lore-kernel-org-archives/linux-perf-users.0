Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4720449992
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203368; cv=none; b=d+Zf/UVTdfKpbujZkPDju39pSFORw0yf6W/f/ysyB6nGUEjNKP02CbImiyaDsGIaiDEOw6hDf1/jBJdpbYxJJFJ7lryAwq0iE1ZD2OWJSju1Xs0K++5gdNGgjiBeNDBZnTiDNUrqQbTULILLQkLQc7ADBhC9Lqpnv5AvpNgcz6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203368; c=relaxed/simple;
	bh=kvuyZYEDNj0i1sF9V+F8wbBxaj7cf+K5/6Sca5BzRlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rM5uLfOokQjXxaYA+RiuZWp3a+qKQuV3fhggd/if9Z7a8CO3tsLf/Y4oDqNQOS9lr2aenHdy1YyASUUPNn4IRMBRzAExFsirb8x8L94Q/nhmtrsu1WHVRUz9jpZoUCYbNworZWx7HgFI8CFBr3GfWckG+a3ZP2lzdUwbxbWuZiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PA/Tilmz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PA/Tilmz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A8FE152B;
	Mon,  5 Oct 2026 05:29:21 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54FBF3F86F;
	Mon,  5 Oct 2026 05:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791203364; bh=kvuyZYEDNj0i1sF9V+F8wbBxaj7cf+K5/6Sca5BzRlw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PA/TilmzGf/fTGgNQJNQeV9G4+0zdmbfhEfA1URx62ZNN5JO9GjxBe2vOCPMwaUdh
	 65SSW3CAUb3N0zWPGdGbCyIoVv4BbfVazoF8dfskgQ+eDvfuEWz+wCJpmUCyCUcOTY
	 2n/9+vDBIBqyeUKVYreZxeX9H8Ptew+9Y8NoR2OQ=
Message-ID: <a44431a4-7a4e-4dea-b313-e769ecd55fad@arm.com>
Date: Mon, 5 Oct 2026 13:29:22 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/arm_cspmu: Add Arm system PMU
To: Will Deacon <will@kernel.org>
Cc: mark.rutland@arm.com, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <84a65061841c8870375ee6b0621dd3f61651763d.1788970980.git.robin.murphy@arm.com>
 <asKMMAvyAbT5mGJd@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <asKMMAvyAbT5mGJd@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/10/2026 6:26 pm, Will Deacon wrote:
> On Wed, Sep 09, 2026 at 05:23:00PM +0100, Robin Murphy wrote:
>> Arm's latest Compute Subsystems and SoCs are using a common PMU block
>> in various places which can mostly just be driven as a generic 64-bit
>> CoreSight PMU, but does have an IMP-DEF register for additional
>> filtering. The details of event and filter encodings depend on the
>> particular PMU instance, so are left to the higher level Arm Telemetry
>> Solution tooling.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/perf/arm_cspmu/Kconfig      |  7 +++
>>   drivers/perf/arm_cspmu/Makefile     |  1 +
>>   drivers/perf/arm_cspmu/arm_cspmu.c  |  7 +++
>>   drivers/perf/arm_cspmu/arm_cspmu.h  |  1 +
>>   drivers/perf/arm_cspmu/arm_syspmu.c | 67 +++++++++++++++++++++++++++++
>>   5 files changed, 83 insertions(+)
>>   create mode 100644 drivers/perf/arm_cspmu/arm_syspmu.c
> 
> Sashiko failed to apply this and so did I :/
> 
> What is it based on?

Ah, sorry, I sent this straight off my local branch where it's on top of 
the BMU patches - clearly I forgot to consider that that would mean some 
context conflicts in the Kconfig and Makefile. I can resend if that's 
easiest.

Cheers,
Robin.
