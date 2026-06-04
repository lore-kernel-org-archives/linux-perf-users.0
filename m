Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2839425CC2
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575540; cv=none; b=lesYdz7FuWxlSPSZr34Hs0itnip+8buOIWOENSc5qPaXDTgc7KuabHppjSIYJBjVE4mbK0S6sh4/gyItVY8xXRMYkw20aKEO51eHMClh3CCO3xLZUzg3Fu2jC2zT1xg+9ZeBLP5dOBeYl1f3istLoV+Skw1u5tMy4/+Sy7XvPDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575540; c=relaxed/simple;
	bh=LlzDXkVW2KDnZvT5WLR716/Dj/N1QHBH52PN2KfgwlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIX3djFLgnOhj+pNKQK1737JGQFmj1jVDRKNv6XwGM2LFG9b4hCx7GdM7QdAJqVdoY/dTr/FpxACBvhsLY5fLxojjcT1n/lG3sh0cF6yl6ihC0X/k3bjN5vns55iCrhD7+NfEXQAfbpxEkYOU4H+zqI/BsxwoAQKaGLIY2GeU2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nI3NJviy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nI3NJviy"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so6008925e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 05:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780575537; x=1781180337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2bp5jaoGscH7ESVGw52bNDl430Md7PtGyJ0j9xVCNs=;
        b=nI3NJviyP9o/TqlCEPY69iUG9GC9/2FZxx6YcmB9x7/L51fn6wtudBqfdWjXjKkDZP
         N0AVj0lIsrK+sgh46TWSKCdpClv0XlQydLrkYAR8bQnled0tJesY7LjF0vocPPDDMJeV
         wAwMD3t3vxk0A9llvJgwYA5q+0rRa2yYzKYbUr5OtqiB39E49XjJIWdQHQs3VnGv4u4O
         ySXHjBBeL9eaF+jnr2P/3k8baXfUkLtVl705J+RazEYZk+/577sJgqjZ3YISqO5wInnj
         92W9KVAc3FPNESBCRO51eAaoanxdGW5s0WCh7juy52NxQhTA7GXyydRDtY6SHw6MOU5Q
         rUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780575537; x=1781180337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d2bp5jaoGscH7ESVGw52bNDl430Md7PtGyJ0j9xVCNs=;
        b=oWS4BfV6wYNiEt+lbZvGIkXq0k3U9r9HquiDGfPhjPBJtq7ooXiYcB8V/o/hatjfZN
         8KbNHd5Gdq/QkmPzqmbI9ynoEBmGqz0fA6R5YfMGiAiiORUyz2tJB5VwckmHyPzFdcQX
         TXYGVWjmHdKInsuIuaVyl8YpPFwesCL8kj+Rlu+UQPccdpvogKEWpjDPQfSj9wvSChEG
         qih/N9GanMJiVwNI/5+xr3Dn7lE0fCUs5552fDOGNpCL8RMDqfHWcxmATaW9cvusOCmm
         NvvDu/tyBGda9vKOBenaQuofwnpV5v/40KWGM/NVQ6kpsxRaXFPuvPZ82QAOWRjhSijx
         mjFQ==
X-Forwarded-Encrypted: i=1; AFNElJ/djcuy56pa3zsuR7WsTbk0v7rsckQr4jEcUww68IC/19p3NS/ke+wa5/bddbaU780t5VqOWoTkEaHFEvQQphiR@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk7pISHachFQfZKKBDodKbXUuK/hG0Fa/vnev4ruorwCUbPGV4
	jPlVM+GbBZUiqzRGnco2DRIYN030EbO4PKHFFmko5RCzmxcKWK4cbp/55PcNkEz1fO8=
X-Gm-Gg: Acq92OH4OFRIuRdHx/JBPXa7hAxj2UCfPUhVE9mq7smL40z2+tpV3Xw7cRWfBsf3zy6
	b46r91cv/aVxdUchNEsWsRWayvLP3oQvVeDaTbL+gyvIIlpT4mOnRSvJ5rabFXnIfR+3rL0b0gP
	FVj2ce7S1h1LNhMy8TgzyAOUaOF1aonzdrO2FBAqI94gn5nOHJ44VLsigXouN/JcE980K6l9jeX
	IN0uR4QEkbbj0ffmJixzTxxMX+cifI4sEAAaY2Q9aQ7U1vOz+IC9uG0FeqNzL9P/4iXvIUZ31T5
	nJkBIIe2AeAS4JN88KztMDqqRdS3P/aKW9yVHSihdrUM2y1TDVEL75o47cno6tsvc53X/YZqg1h
	QlKvtZeSXS6njOuoY0K7N22unOlEB+WtvOtshAyMQ1oWGhJOz41eQdX/eMUzIMnb9kY/20KJCIF
	XvNcnRQl/K94TOJdCsSpGFRSAyO9gzOqlzF8L6BYQ=
X-Received: by 2002:a05:600c:1d86:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-490b5fe9688mr128262045e9.20.1780575537237;
        Thu, 04 Jun 2026 05:18:57 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b79d64e8sm165761745e9.0.2026.06.04.05.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 05:18:56 -0700 (PDT)
Message-ID: <011bf252-855e-4941-a6ef-8cc53f0bc48c@linaro.org>
Date: Thu, 4 Jun 2026 13:18:55 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/18] perf test cs-etm: Make disassembly test use
 kcore
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-15-85b5ce6f55c6@linaro.org>
 <20260603173203.GF101133@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260603173203.GF101133@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/06/2026 6:32 pm, Leo Yan wrote:
> On Tue, Jun 02, 2026 at 03:26:57PM +0100, James Clark wrote:
>> Hits in modules return empty disassembly with vmlinux as an input to
>> objdump. Make the disassembly test more reliable by always using kcore.
>> And update the comments to say that this is supported by the script.
> 
> Even without kcore, .ko files should have been saved into buildid
> folder. Before switch to kcore, can we firstly fix the issue that why
> .ko does not work?
> 
> Thanks,
> Leo

I think this description of the problem was wrong, the reason for 
failures was the alternatives patching mechanism. And the only way to 
fix that is by using kcore. I'm not sure what you were thinking of as a fix?

Sashiko commented on V3 that hits in modules would still open the .ko 
file and skip kcore anyway. I tried to investigate but I wasn't able to 
generate any trace or samples with hits in modules. It might be a 
regression but it might have always been like that. I do remember 
switching to static when I was tracing Coresight modules before, but 
that was to make using address filtering easier, and I inadvertently 
avoided this issue.

Seems like fixing this is outside of the scope of this test though. I 
didn't see a single failure on N1SDP and the only failures on Orion O6 
are because of the wrapping/snapshot bug, and we already knew that you 
have to use kcore to get accurate decode. So I'm not sure of a reason to 
not do it?


