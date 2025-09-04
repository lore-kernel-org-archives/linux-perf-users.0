Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEBA2C2353;
	Thu,  4 Sep 2025 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975524; cv=none; b=p78hkeRjX1/1Vp2RTP+E1nkn052w8xWKGhifLqvMV7t7whPi++D+e9JcIQYWaKe1WBRqHCSe+2+5bmJvRfW9EcwRbDsOgvt1UeOuIsNF1/IMibULyDMoTrRDstbSoAMpt2T/zkCzl9WJE+KJmQtcOQjJCatTZssZ9KHdgPVbeTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975524; c=relaxed/simple;
	bh=0Zkxv3e0c498Bfy2dnYSmnT0FhKSenEt5q7Sh6NS6fU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAvknQpd7zXd0ep4x/91419swc/Cm/+F5PHdq1BSYJy4rBIVWndV+ty/Tc8FGy9hN8QjsK0x/6DzgWEZZLIB460ciX3GE9Gb3Y1Mj4PgvWAsJbYEX/YkNQTywE6h/cyHChHiT+D69aRiLhCgx1Uk77bAeg8cTkrmnst5ATKvDHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=js0XzQkh; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="js0XzQkh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To
	:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J/bn/zYjokNNkh2+bhloO0t0BfHU6p3Y8J0E+7oNy1Y=; b=js0XzQkhoxMGZ80VXbDdfC2Kfe
	SbLCAtVJFQHDPhjSDFWAOwgSHEnxZyiSNVXLa86jwh8ENO9pJ1jwNW2Nsfp1O1lvVTeqvIdg8xE4O
	DgWgwucxmtY3NoWREKG2XKxzCyvSfEPueV6ful7MrdxDNH2J+HAQe+XU8G6d0coxMkD+9n7fPl1kZ
	YkepvgZ51D5oZnVouwrZvADgpWjkiUGLK3kjYMkii/yhSSwKGIvTXI+5H0SoWO/Hm406Dw3nrh7Eb
	emFriHLXxmSYQpJ4ki+hx8AuMCoG+ikx66obfY+4mW2M/n2fSWXUILXbd64Z6X8QQNTIpN+m78z34
	YrEUVdvA==;
Received: from cw141ip122.vpn.codeweavers.com ([10.69.141.122])
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <rbernon@codeweavers.com>)
	id 1uu5Jq-008uJK-1v;
	Thu, 04 Sep 2025 03:27:46 -0500
Message-ID: <2b958dec-7ba9-41a3-b11b-43b5e8418849@codeweavers.com>
Date: Thu, 4 Sep 2025 10:27:43 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf symbols: Fix HAVE_LIBBFD_BUILDID_SUPPORT build
To: James Clark <james.clark@linaro.org>, Ian Rogers <irogers@google.com>,
 Sam James <sam@gentoo.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
 <20250903-james-perf-read-build-id-fix-v1-2-6a694d0a980f@linaro.org>
 <CAP-5=fWHGFBaCgiRcj8zVy196OE07F8jnSUbjvsO_HerdqeyTg@mail.gmail.com>
 <70bd9eea-905a-4fa9-8265-f84ab9894b12@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?R=C3=A9mi_Bernon?= <rbernon@codeweavers.com>
In-Reply-To: <70bd9eea-905a-4fa9-8265-f84ab9894b12@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi!

On 9/4/25 10:13, James Clark wrote:
> 
> 
> On 03/09/2025 5:07 pm, Ian Rogers wrote:
>> On Wed, Sep 3, 2025 at 8:15 AM James Clark <james.clark@linaro.org> 
>> wrote:
>>>
>>> read_build_id() now has a blocking argument, but libbfd uses fopen()
>>> internally which doesn't support O_NONBLOCK. Fix the build by adding the
>>> argument and ignoring it:
>>>
>>>    util/symbol-elf.c:964:8: error: too many arguments to function 
>>> ‘read_build_id’
>>>      964 |  err = read_build_id(filename, bid, block);
>>>
>>> Fixes: 2c369d91d093 ("perf symbol: Add blocking argument to 
>>> filename__read_build_id")
>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>
>> Libbfd should go away:
>> https://lore.kernel.org/lkml/20250823003216.733941-14-irogers@google.com/
>> but I can imagine that currently this is hit in a build test - sorry
>> for missing that and thanks for the fix!
>>
> 
> Yeah just one of the build tests, I'm not actually using it.
> 
> Remi are you still using this? To be fair the addition for PE support is 
> fairly recent and even includes a binary for testing it so I'm not sure 
> if we should be so quick to remove it.
> 
Yes, I'm still using it occasionally, and I think it's generally useful 
for Wine profiling purposes and I would rather prefer that it's not removed.

I know it's not built by default because of license conflicts. I didn't 
realize that was an issue when contributing the changes, and it is quite 
unfortunate (and silly IMO).

Then I'm not particularly attached to libbfd and any other option that 
would let perf read PE files would be alright, as long as PE support is 
kept.

Cheers,
-- 
Rémi Bernon <rbernon@codeweavers.com>
