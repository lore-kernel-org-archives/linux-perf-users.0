Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9882D061C
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020320; cv=none; b=Ke7fGd9Vp2/LOsmOmvBpLEixtzQhBPDmA5UlmL7nHfAOv3xiaa4hM1wBRHFfzvkSyydRiF/t6XhW8h+WhkhMpLyV4r4UOFNlU9hIwne3BMryP4U4T7U3/ybDuz1gcR3fkwg0HThJ6NpDpcYKcVP5ezIZmNDIvRnQ/sgcntsB7X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020320; c=relaxed/simple;
	bh=Q4WngC6vmWdYNNtsq+E7FJuWMdZnTE5UpPG0PLI+Euk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yll+oFWMzQFq913J8AC64gC27Wf6TK9bj+wg7f7ied9EgrDcbVWU7JoAc6HwLVneg4BQJnf932ulbii0880016grUmMtieXQUH9t/nMNZ8kEnH3v2KDbRNYBOv39TlZBbLvb0q4n8Dtn00mV+63ZgWem0av3jIPIciuE3dRB6PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tAbvYIYG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tAbvYIYG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7C67153B;
	Thu,  6 Aug 2026 05:45:11 -0700 (PDT)
Received: from [10.57.42.103] (unknown [10.57.42.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1F573F632;
	Thu,  6 Aug 2026 05:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786020315; bh=Q4WngC6vmWdYNNtsq+E7FJuWMdZnTE5UpPG0PLI+Euk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tAbvYIYGBAe7EmP8CXWSdUthrp4THKN3QD6nqU2kYZjFHINLtdyIQ9X+2UK55cmeW
	 r+4ClisBpE5d0hpYEYvb3G6ZTUXNuRZ2AGOBipcxRBRMgyJyArJWgBpq5DDJZvmRCM
	 TMrRSucNJ5ART60Xwfpx8Oyi7in4Y2/3yeNze0/E=
Message-ID: <a2af089b-916e-46ec-9a59-8c4506279199@arm.com>
Date: Thu, 6 Aug 2026 13:45:12 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] perf/arm-cmn: Support CMN S3 r2
To: Will Deacon <will@kernel.org>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, ilkka@os.amperecomputing.com,
 leo.yan@arm.com
References: <cover.1785252273.git.robin.murphy@arm.com>
 <anR5CDq3efkXzgG6@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <anR5CDq3efkXzgG6@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-08-06 1:07 pm, Will Deacon wrote:
> On Tue, Jul 28, 2026 at 04:59:20PM +0100, Robin Murphy wrote:
>> v1: https://lore.kernel.org/all/cover.1782830759.git.robin.murphy@arm.com/
>>
>> Hi all,
>>
>> Since nothing else has come up, this is a very minor respin to fix
>> the bisection nit that Leo spotted, and hopefully it's good to land?
> 
> Please can you check the comments from Sashiko?
> 
> https://sashiko.dev/#/patchset/cover.1785252273.git.robin.murphy@arm.com

I did, they're nonsense:

https://sashiko.dev/#/message/fe126e13-440b-4c0b-8e38-4dbcfd3f7846%40arm.com

Yes, the encoding machinery added in patch #4 in preparation for patch 
#5 isn't used until patch #5, shocker! That's why I even explicitly 
changed to title to "Plumb in...", in the hope that in the absence of 
logic, a language model might at least be able to follow language...

Cheers,
Robin.
