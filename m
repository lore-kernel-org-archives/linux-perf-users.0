Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31768308F1E
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995533; cv=none; b=nxE5Jk35FEhoJh2jnDSWN7WsgyOSRY2QMEPjf7MKgiDO77JP89wA9zNWNbBr4750W7et7SvtHwjG5EGfQhH+aZnqt3RSQ6aIkLhXctKnTowbMhWEEfT0Ii7WZy488uCShufWreL1J4TATokEosZdkZOuhBJkZuNIJQzag6EcTnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995533; c=relaxed/simple;
	bh=fV6QZJMK3A7mCgk771TpM9zs7B32zxtNX3X5HgmzXQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePFC+eZz9w3bSUHUh3/lDi4KjsiMAlOzJEo3X/lgOS8dKZpY8Pz5E6U2fnaapJXhNeYF9DmvNUWel+XPgVJYUbbnP3aGYtlpGErQJTu6fnlcuI9UiLH9gnlJkZgnKMtrE6pZ/olYuBXByQ8zikeGu33g4hjXAbuFDZNJCzqcv4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VZvQidEa; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VZvQidEa"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so552036f8f.2
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Sep 2025 07:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756995528; x=1757600328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a4eb3raQH90FtyFSSlT5n0uTLIaDN9A02enpvUM7aaA=;
        b=VZvQidEat+1SKAajvSAdCcpcJ6IxOGwYVPeTClVFrgsPTIow5L3RbSrJZuXlAG1TAX
         zSWLmlePp7NkNzoSzuPIFpg1DRDmzfsyCBauJmQncWij4WX4g6lvnzuENl29L5e6zcnE
         F12kueDOkJmLk1w2arudTUMS9pCVzh+x5WPmvboycgklUxYHSjK/6zLMWhd3qahgpQYg
         hJcp37GEGK/ASS8kmIBWxdYb16CeIr2E8BfU7xr+ClxKnreJ+r34NkEu6XWotPoozNZN
         +TN0Rnm6xHOqpMBaNV8wI+5iOWdrhFEzAv0JkhtneqJ0CC3ZkxiP/KCIiWzCch5j24S7
         sATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756995528; x=1757600328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4eb3raQH90FtyFSSlT5n0uTLIaDN9A02enpvUM7aaA=;
        b=TXrsWXENhrPXp/kbDngo90CCMKs3A/MUEoeObe4P0XT4jSXhTYOJzz/m/42S+G78Uy
         cOsU0fdZTFxBR53c7liZKGahaRF47faPMil2yjOVev78lIPjzR3PfGssL7ZCrrAB8bRS
         Q0MWhpWvQaJuyZXIr1/aSIS/RiX6X7SGmBcVoxiQJ4nrxYA3r6LaEB8iCpD7lr2TaU8E
         nL1Fd1UW7aXeIqyf9O+wy+/ZvXYD1DmDDn3QVhEKENClUDvVU+TDkfBBORzp5vdKt+q9
         NlJDIuPgnZu8IaEAAz98b359hLQp+yXyuwk6W0UYIehvIfcMWGbHuPAfiuF7fMsfxTRq
         Trcw==
X-Forwarded-Encrypted: i=1; AJvYcCXcZhl2LETYE0fshU/r+fIq22/Ru3s5Xqcb5OdyIcNJgA4S0Vk98ecD0o+iIRcbscQGKb9aVvYK6heqss2Y+IxV@vger.kernel.org
X-Gm-Message-State: AOJu0YzAvY0um64vlkvMwgdf/YS3z8bBQjJA+s9wbMtaBlOOOu9ITzg4
	uAYoH2njPyQ8AE3f0AIAtSBrU8apxgnOnAStp4THC06Au5mFGHOKMPAGR6R9b+8zdmo=
X-Gm-Gg: ASbGnctjQAVYcpjK+XTGqkr9FWXiYuhc19qXqP/UBaOAmLZIfubgx2ewUtp3UEaNaiI
	CM4E6qmT6/VIDqCDBBSJ9kjSVzto4O+XDz+PCpjJm6Cm8Q0+EPldSPVeXLc1MvvfgNGSm6LEXkP
	c8m9HXRjUcR86aKq1280zLgZf8Qan7XikvcTspKGOEfoq1pw9z+I0TB/B9kww5aXIPwWER4ReBk
	5Dhy3Dd8GWX5uMBjPKuZsIoQTd18zkmre2TuHomBu5shpwbaxPcHT/IM5saQpFkuils0SdqwyOb
	hfrZcl1BFD2twKRBjStjCu+CUBIRjLsE6068ExonnbW4NpNYndMQT+izHw9cOUZCziy88/Crmzp
	Y6WnhMIm+U3uuNdcSydO5Xjib90lBFt06q4rh4w==
X-Google-Smtp-Source: AGHT+IGYIcGtmjKKSI+PLZ9Tk7+sG5TKbfSXQHLM5QHRIdALRnoQRGWPqOAwZtuNYrtCBuNfEtpo7A==
X-Received: by 2002:a05:6000:26cb:b0:3d0:9781:6e5f with SMTP id ffacd0b85a97d-3d1e05b6492mr15099217f8f.53.1756995528363;
        Thu, 04 Sep 2025 07:18:48 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d9f3c36a78sm12108166f8f.48.2025.09.04.07.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 07:18:47 -0700 (PDT)
Message-ID: <549d3812-a606-4981-83f5-0a99b0ff9f6a@linaro.org>
Date: Thu, 4 Sep 2025 15:18:46 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf symbols: Fix HAVE_LIBBFD_BUILDID_SUPPORT build
To: =?UTF-8?Q?R=C3=A9mi_Bernon?= <rbernon@codeweavers.com>,
 Ian Rogers <irogers@google.com>, Sam James <sam@gentoo.org>
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
 <2b958dec-7ba9-41a3-b11b-43b5e8418849@codeweavers.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <2b958dec-7ba9-41a3-b11b-43b5e8418849@codeweavers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04/09/2025 9:27 am, Rémi Bernon wrote:
> Hi!
> 
> On 9/4/25 10:13, James Clark wrote:
>>
>>
>> On 03/09/2025 5:07 pm, Ian Rogers wrote:
>>> On Wed, Sep 3, 2025 at 8:15 AM James Clark <james.clark@linaro.org> 
>>> wrote:
>>>>
>>>> read_build_id() now has a blocking argument, but libbfd uses fopen()
>>>> internally which doesn't support O_NONBLOCK. Fix the build by adding 
>>>> the
>>>> argument and ignoring it:
>>>>
>>>>    util/symbol-elf.c:964:8: error: too many arguments to function 
>>>> ‘read_build_id’
>>>>      964 |  err = read_build_id(filename, bid, block);
>>>>
>>>> Fixes: 2c369d91d093 ("perf symbol: Add blocking argument to 
>>>> filename__read_build_id")
>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>
>>> Libbfd should go away:
>>> https://lore.kernel.org/lkml/20250823003216.733941-14- 
>>> irogers@google.com/
>>> but I can imagine that currently this is hit in a build test - sorry
>>> for missing that and thanks for the fix!
>>>
>>
>> Yeah just one of the build tests, I'm not actually using it.
>>
>> Remi are you still using this? To be fair the addition for PE support 
>> is fairly recent and even includes a binary for testing it so I'm not 
>> sure if we should be so quick to remove it.
>>
> Yes, I'm still using it occasionally, and I think it's generally useful 
> for Wine profiling purposes and I would rather prefer that it's not 
> removed.
> 
> I know it's not built by default because of license conflicts. I didn't 
> realize that was an issue when contributing the changes, and it is quite 
> unfortunate (and silly IMO).
> 
> Then I'm not particularly attached to libbfd and any other option that 
> would let perf read PE files would be alright, as long as PE support is 
> kept.
> 
> Cheers,

It looks like libLLVM might work. Looking at the doxygen there are vague 
references to PE binaries around the getBuildID() function. But as 
mentioned in the linked thread, it's huge at 100+ MB.

WRT that thread, I think maybe re-writing some of this in Perf wouldn't 
be so bad. Surely getting the buildID is trivial. For PE binaries it's 
hard to tell what's supported currently, what's being used and what's 
being done by what library or tool. addr2line, libbfd, symbols, 
disassembly etc.

James

