Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792657700;
	b=KWK5VF4D/45ZftGSpr/zJ1OPFWpaFnYWezzK/4WECgaClxtP9okKJQuDbHfSL35HSvHW
	 hg9VBMHp0ljDRMNGKxHkbKEbiLoZC0jELub/kmCg8oB7RhBlmVqDMrmJ35f9oErOypXCC
	 l0vd65avf/xwnF1H29bVuQOz4lIp8/c0B4C8tRkZKwqek4eUqy/aM2zgeBJBPFAOtdyo+
	 X+6Z+dNvdrXWaegdTgLvt+csC+suveyJqso79ceFwRMtNgEhSXVvcMcd5o0FXkSoJb+nS
	 1eAj9bG7LtIexwkyNo3AyjbAr1qu4+YYDeCbQye1arBi9yMbysntzSC45PkEILaqhkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657700;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=iwLOjvHCtgaLp2E9XIBdvGe/pxFGO4huYHU7gKZLKOA=;
	b=0R8tx3luvaRhxp/wbMF+Dgk41xaU9KDRfEtoe6I/GHNoFYymMHztlIQw1OzKWGgRkn8Y
	 DgUQDje60Im3F9ZtRws3+WCshNzv9x7gAoz7YQqtAHkla53YQdnrxZ+vlXa25B9t9gjpi
	 +/yPlLX7awBupdYzNR0Z8HoXOuYCKtKDbx9q3+Vs06xGTCjq6wxgUVcpD/fKwq1V+ofjD
	 xIVB5gZvTi9ztWeKgfm26OPSOlSeYVw9JFldaU5UazSW5JNJhj45u0Fae74iGL7o2zuwh
	 sUgDhW3q8QeKjSTUZSpaL2YCH2zcsIgzNlImvgBzEEb+pZe7/GO3WubzIo5CndUOfHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jUsa9ftz;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D5C606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 08:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61D5C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jUsa9ftz
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a20b122af8so1493995e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 01:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792657699; x=1793262499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iwLOjvHCtgaLp2E9XIBdvGe/pxFGO4huYHU7gKZLKOA=;
        b=jUsa9ftzzGj06xox8H7waPRA+MWch8Q8m/vEUpJAbBUKEmdriaGIcGTRgFRBlvCRE1
         qxLU5zh7C8/h6jaHuYPa92SlX5IOhMBpH1hP/Qz4hm3oT1E6oKhPvqoWEByxLPhnxaoi
         Z96BbuMoSzDdjohCPU00ExWEb0Z+todJbtyAc23HKtpbug29DrdQY3a0S8R1PQIKMUDr
         BA0L+K0uGlzO1uDvunDTvBf5wVWm39MjHGUgss5l1l+4OgJ6DD5eB2Hg4q120N8ODQ60
         EZPe17VXTFVNM4Gk8YLkRxN+xZGqsb7SAeplwX61a+3J4rBQBze3PVJFOi/41NAOLH4j
         I86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792657699; x=1793262499;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iwLOjvHCtgaLp2E9XIBdvGe/pxFGO4huYHU7gKZLKOA=;
        b=gevw7Z3F1/Wj8dFvxhi7kU4KTYbP19yqCR7neNC+G204WDsiY2gh7+ZTfi4ujEt1Vt
         f3iimwbSXbHk6RP9qk59E1OtSDWUqCQX3ugkV2C6T3IL42+1S0UbPBLkhGMy+Yu4Y/aP
         mDULaqxk26LAo4II7jRQVZ+/9/oQzBtd6Q0pVgVC1U6Xy+Ab5gcwL4cZ5OSkQ3CDi5tM
         UqjZpttnAocA4SDct7Tgulrr9aw2r+x86qJpl6AMhrgayx6SoexreKnO9j+OPrvRtDET
         KwHJ77en3O5x+yZ3DC9TTmflF9thOT95eZXuUQ3TTaVIulpbiw1ZEmphYSIRJeI9jf2E
         JZKA==
X-Forwarded-Encrypted: i=1; AKwUvBx4Go94R58jiu7jHoBDyWchV6lxkwzyHUQLxhwckzVFeviQyWS1OLZRiwiquw2q4kq+giotv17WUzqGUPhD+I5I@vger.kernel.org
X-Gm-Message-State: AFq9FYJaEUxVeXlhM1K5mcfoF+gPykW2djW8XHQR5WJqSbz3mAqjJyNY
	bxukFyTcyGvLFcZvHy+qFHZaqd36Qqc0969IWoh5IjEJoF3j9LWr5X7BDsIOSnwUe/w=
X-Gm-Gg: AYBFou0m2S9g3HIFNQv9Rjv/A0lFtlNGY21O7PonkrfWcnvbuAEcCANs5wm7eliKF+S
	xV0Bv1IE3QwxURURbGzLmWH6w06r3vmLlo1Qo5fZWWTVF+CA+uq8OybEcpDDLiIiXRnvZpdaKac
	W3E6/0ZF3ZoyijbP2LXtYrhmhQuMU8vTybTLk4ox+wNLyJlvyn+OSzRo751N8oGWlkXd5CkbMCZ
	7mkuar8CUPTVuKmNjJxehn2IuDsfvX13vq0v07gMkZ+c9yNBSNElz2rryNi/iaBuV6SJRVAYH9m
	W6p6eowTOzabqUbNjPI4zH2G7cl8R7dXrvs+YC4gCwGJdtJhiOT8dKdhzetU/2KXdCx98+0fkFA
	ldU7EV8h1FuCzW2pd6Q4aA0Hck6oHFRrvIAsEGSctUS633CF8n0NPLEB3jkG36SwzOa9WVVxUdp
	4Xqo7YxrDGqERsQMN9C3wDQ1cZavBv164YREdch6fVNM2atyGw7FOM7uGiet2k2bbKPn5UAwOim
	LE6A7Ed4Qv/+KZSsUC3AVWZSVwSGMWuA3DKyQfwmP1lJBDfdLLT7MR42ewf
X-Received: by 2002:a05:600c:8b6c:b0:4a0:1b14:e283 with SMTP id 5b1f17b1804b1-4a1fd8a7de3mr103361785e9.1.1792657698735;
        Thu, 22 Oct 2026 01:28:18 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203963f3fsm62310355e9.2.2026.10.22.01.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 01:28:18 -0700 (PDT)
Message-ID: <96e51831-ef50-4d0f-aa5c-74d5e3c8ae9e@linaro.org>
Date: Thu, 22 Oct 2026 09:28:16 +0100
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] perf: cs-etm: HW_ID improvements
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
References: <20261002-james-cs-hw_id-output-failure-v3-0-1d8b6ef339c8@linaro.org>
 <2bc4b058-3a5b-4a9c-a469-eb8c93215594@linaro.org> <atjDCpTIrchbCLt7@x2>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <atjDCpTIrchbCLt7@x2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/10/2026 14:50, Arnaldo Carvalho de Melo wrote:
> On Wed, Oct 21, 2026 at 09:42:24AM +0100, James Clark wrote:
>> On 02/10/2026 12:15, James Clark wrote:
>>> James Clark (3):
>>>         perf: cs-etm: Don't add global v0 HW_IDs to unformatted queues
>>>         perf cs-etm: Free partially created queues
>>>         perf: cs-etm: Respect --no-itrace option
>   
>> Hi Arnaldo,
>   
>> Is it ok to take this one please, Leo has left his review tags.
> 
> Thanks, applied to perf-tools-next, for v7.4.
> 
> - Arnaldo

Thanks!
