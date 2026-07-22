Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5CD40F751
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716986; cv=none; b=tmTXNXe5DBexWIq0uy96LeaRPHhW+2QPPEPQBZmKHIEBz4LEiInz4vP+HiAEuYTkAl8+yNafb/j0pjSrUmOpJL8+iNEh3vpx+cE6G3nXfhT6/3LbTPmv1WODS3/npJ+z/Ld4uZnm/t0ZRVgtE17HIZKubJ4avfKP4g7xbKXsWFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716986; c=relaxed/simple;
	bh=avX17YujvNShW2/vZDJ2Xhz8U8M9SPol+g9H8Fsfkek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwwvDYZ+fueLy4wA9VuNH9fhwMCoEXtZhA6jv0bEE6eF+ROTF35SbZhXNtb5ywYY7O+OiN1wD4FAfKSVUy1xXDhvsyt4MBhjg85mfBhcr5NE5c2OA0nWwwppaYNqT3seXjEP0ItNJ+eeK/jgKtMeKHQUhCyqFxkyOyeasOVUy9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PwdlpcaL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PwdlpcaL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C85D1595;
	Wed, 22 Jul 2026 03:43:00 -0700 (PDT)
Received: from [10.57.86.212] (unknown [10.57.86.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 595953F58B;
	Wed, 22 Jul 2026 03:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784716984; bh=avX17YujvNShW2/vZDJ2Xhz8U8M9SPol+g9H8Fsfkek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PwdlpcaLICCnQKTjVr/boQjIfDTRYauUxMkoR19UaYRGcUW8z4apZyLX4Nqwx2mUH
	 hkUDfmr9J9z3dp4HkAyBIc/lrLnEoPicvIvaqRNvt813QT4Ct60p74NOMRp3Q5iZHi
	 pDIDMtAzC2uFC1B9nuS41KGOGqw8glxlAuDxB6lo=
Message-ID: <c1cd8fac-9656-4f3f-890f-bcb8f605d0a0@arm.com>
Date: Wed, 22 Jul 2026 11:42:57 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] perf/arm-cmn: Add workarounds for CMN-S3 on
 Graviton5
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, kernel-team@android.com, mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 zeev@amazon.com, blakgeof@amazon.com, avivb@amazon.com,
 ilkka@os.amperecomputing.com
References: <cover.1782824005.git.robin.murphy@arm.com>
 <178466981527.100304.690835278646398901.b4-ty@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <178466981527.100304.690835278646398901.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-07-22 9:23 am, Will Deacon wrote:
> On Tue, 30 Jun 2026 14:01:16 +0100, Robin Murphy wrote:
>> v5: lore.kernel.org/r/20260603150025.30980-1-avivb@amazon.com
>>
>> Hi all,
>>
>> I'm reposting Aviv's series partly for visibility, since the previous
>> versions were buried in a thread, but also to respin patch #1 - Aviv had
>> fixed up the bugs in my initial draft, but I also get reports against the
>> original commit on my branch, so I ended up taking a second look, and
>> deciding the improvement was worthwhile.
>>
>> [...]
> 
> Applied to arm64 (for-next/perf), thanks!
> 
> [1/2] perf/arm-cmn: Move DTM index data out of hw_perf_event
>        https://git.kernel.org/arm64/c/56603c28d916
> [2/2] perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5
>        https://git.kernel.org/arm64/c/9d0b1714e1af
> 
> If you get a chance, please can you take a look at Sashiko's comment on
> the second patch? It said something similar on Aviv's v5:
> 
>    https://sashiko.dev/#/patchset/cover.1782824005.git.robin.murphy@arm.com

I did already respond to that back on v3 or so - the code is correct 
compared to what the standard CMN tooling generates. The main DTC always 
has a logical ID of 0, while secondary DTCs inherit the logical ID of 
whatever XP they are attached to (and in this case the main DTC is on XP 
0 anyway so it works out neatly).

Subsequently I did also spend a while trying to make sense of the 
generation scripts themselves, and while I couldn't find any obvious 
proof that the DTC domain numbers (other than 0) will always line up 
with the logical ID order (although there definitely looks to be some 
sorting of things before the XP logical IDs are assigned), apparently 
it's not been an issue for anything anyone's built so far, and if it did 
become one, then it's a problem for arm_cmn_init_dtcs() to solve in general.

Cheers,
Robin.
