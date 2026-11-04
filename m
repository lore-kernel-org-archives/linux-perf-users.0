Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814890;
	b=fAEKcZswcjanx1J7vGw8fJGH6y0eKbnM+Xa6PPf6NUnror7fIpvE0U0yJET2xNJO1oML
	 /SyyQSjIqvuHneTu7ftM+KcqUhVxSiG8JjwNK8jfIty1AkPSxX0U1n7RO7ijC4ed20/7Z
	 5cnlaIJ9j86iC7u8AC2VN4uLBVBTbFoNb1UES5dpDjveLEfZlYVFyNU+7LxNQTSKU/Tca
	 HpyBqigI0MaojmSjNvrP9ouKXQx+Av7n5u9EUofTz47ErETX7wdmmYBkCoCe7Ybl99HOr
	 z+xzSRaOl3NaxGSBdvhUwpiY0J1/0rlu8AFIca4W85sl8knYVX46Heild0AGipkvj2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814890;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=3XMRgIjajaQRkvFd53KAJBG+JI2fzjczkpx99FvXAIs=;
	b=2fkNo0Zc3z26pVQbGvqVRBsLHe/bPHilvhHm3O3RX5KY6mzh1RVZX5tcEKjqirSuz8CH
	 K3bUfpv7uDpAggBk6OMjF8PbNepm6ZMRiBvSco9DXzJk0MJGcQtveYlqs6v/YDffijOK9
	 iLp4q3rIPMEpxS+h6jopSUZxE0FMv510M3W1uE+GzeFZaaqMI/ZU49oGWOJwtmuLQDdsZ
	 y/jepox1/C+sjrJwrChMbD8Tj6PSGLd0e5CSyn0U008rp0Owaemetty2J1ft0RgHa97c9
	 eZ0BbdLhs19jp1Br8dUp3hciM1sUdtXpGjqz+dmZhD8GcZqXvOxey0ZPD4y+UUqApaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AXaVxpkf;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB6C606CFDB
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 17:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAB6C606CFDB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AXaVxpkf
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c38ac26cc5dso155950566b.2
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 09:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793814888; x=1794419688; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3XMRgIjajaQRkvFd53KAJBG+JI2fzjczkpx99FvXAIs=;
        b=AXaVxpkfljM68lxlk7nie9l6HuOHkE/PNgvUOqd7yM4ZRnqrMT7lAX+miAz44WyuEq
         YhtfGBvHhh+jRrta6ETWIq7rPCmIIlJuq2lB6kUpL1ohtfFdriANJrCooZSwtpWAOOPs
         M9wu5yeQyB2sKHtOQavuzzGUSw7i2d1OLxK3swnyfeLybv9RP2KuWjVDlhTJEDb94oS4
         S82blmqu2GrU55nJ8d4Cgr3C4mEyAdhQ0FZthkEzEMGZgjr2dIuaxxvnVcabAHyjGgfg
         +Fil0gqr2iNNqqwYSqtnWnhFyJEUiuqM2e9cxkNYzMrdTlDo4HTDLJEsPwjYOcONv7Nh
         eGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793814888; x=1794419688;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3XMRgIjajaQRkvFd53KAJBG+JI2fzjczkpx99FvXAIs=;
        b=c0GzN5MDMFPoBu3G4qBTKeHndZO+Q3nabGtRFjQpzpQfESs9QG537YRX4WTbzA8WwC
         YC08uVjyZDeBlHadHFsv3avoMgQZPVMIgKyLTHG4tWR8EbG99ukrG7GmMZREgP7N+z7B
         2MnQehEL3jBkc6bRk+KWwE7tJ5gqq6JVdLiHNKsCF8gmX9a1Pe0fZWgo0KtzXplwhJLu
         /bVO8zHZ3RJ8PrwV8qdD4rJZTv+cwiMKNfXYBcTC21qmQ8xtzeh7xDPuE8LQNkosz3rf
         m1wVZEMvmYZech08R0YZO74e2hN5ZyUEg/r8GmG77E7FWZbSJD/XHQWH+Mnb+IDpSuFj
         hd2A==
X-Forwarded-Encrypted: i=1; AKwUvBxGwN01kNZkOcZegrREamyPEhrvo1YyVVwwyFGpHpgDXFeZEa2lx+mxAYJz/72M1cq345sJR1Qgwy0QVhHMd3Yx@vger.kernel.org
X-Gm-Message-State: APuU4Z+W6/GjM3SwVOTm6MahwivdmQtGeDO9Pf0HASlzU74yX7Y2kfKK
	5VD7SXzT5UDsXGotYjkl7Q4C1cn2iSrkUcazKwc5FCLfl6Z9JElwBvZXCx7lFk8G/yA=
X-Gm-Gg: AYBFou1ONbB24fXcuDcyCJudyzBGxNnWwN4bVedEK8NR3FYuOyCWvT3Zg91PFSHKIzr
	TQhpG9hOEoOziUA+hsU1nPDSvlEsPN50FM+px13hYLdJNuBR3cQGqoph2qW/DrcSm157OAhXbdQ
	WHzSvAovwC0eY+Oe7rkiRXTtatzQatp9D0C0g4gmOLCcy+XSFAzB8AY1xs9UoHuGMbIDWm15A6o
	FsUVbQ0ry/zJdHVqkNWUrMxYcbXIgno4731XkPw3SFGtJUvz18P29uLGb/s0b1xy2ckabCdXnZA
	qyVcdURSzTnenJoXOT+SEwQtAwYoibhBKKEvyShmDeW3MxmUV38d1IrzQUBfBW0TPoH62GjXus9
	bo1i10sSaDacki0S+K2QHLeFWkZM4vOqn4cZuTjHGDLK7+S1HXmOZh+bkVtxvH8RcYQCI/gt44M
	SZsfWrnFqB0xYzDYfQieuHt6F1aEsxkZ6Ga8pN5YHs8XLQW/YUBaPETU3/LAZsRuTvWWxpsAsUY
	CUUJ9gEXgvjC+VBzq99P5WyQIh01enLxmQRl/7EDBKeXjnsqeFYCA2f+kkxu2NmB6k8vxkynltb
	SL1ij2stehtNqtP+qHz8gsK+koqdHZV+
X-Received: by 2002:a17:906:99cd:b0:c41:731c:534 with SMTP id a640c23a62f3a-c4ca7a86e67mr1494767166b.24.1793814887972;
        Wed, 04 Nov 2026 09:54:47 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e41e711sm92156066b.14.2026.11.04.09.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 09:54:47 -0800 (PST)
Message-ID: <c7c04e5f-2c65-4914-be41-f28365c47d94@linaro.org>
Date: Wed, 4 Nov 2026 17:54:45 +0000
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
Subject: Re: [PATCH v3 05/18] perf test: cs-etm: Increase window size in
 disassembly test
To: Leo Yan <leo.yan@arm.com>
Cc: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org,
 John Garry <john.garry@linux.dev>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-5-dbcb0c281b9b@linaro.org>
 <20261104163657.GJ9176@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261104163657.GJ9176@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/11/2026 16:36, Leo Yan wrote:
> On Mon, Nov 02, 2026 at 12:15:19PM +0000, James Clark wrote:
>> When we increase the default timestamp interval in a later commit, less
>> trace will be recorded. At the moment the amount of trace overflows the
>> 64K buffer, so the exit snapshot trace is what happened at the end of
>> the process rather than the beginning. With the new default interval,
>> the entire execution will be contained in one buffer and the first few
>> samples are always various instruction and data faults. These go to the
>> kernel so don't result in ranges that can be disassembled.
>>
>> Increase the window to 6 samples to ensure something with a branch can
>> be disassembled even with the fault samples.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> I don't mind to set even a bigger sample number (like 50). I did test
> and 50 samples just add 0.5s run time.
> 
> Either is fine:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>

I quite like keeping it small because it's more likely to catch a 
regression in the decoding. But we can increase it if there is some 
other reason in the future.
