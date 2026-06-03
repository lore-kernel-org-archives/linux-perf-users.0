Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9053D3CE2
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485436; cv=none; b=DrJhUVd5EPR6ZkuhZu2uN0OzOfNSVpO5XnS0cagB3rf5LbR2K5wQYGWpX21DHOVmscr/X5NMMGoUUhj5PKUDFksJf32NScjKOnON5dTYMdkMtlbgab+4ZRALgRCovgfPfhlW2hbCrL78yD9WD+Fca15/0muCsKwcRPURL+uuUu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485436; c=relaxed/simple;
	bh=YH1yDlcQ1Btc01IgTRsUEjs4GCr14HE188gaQM2nQnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DisKWWuQHWoOEZx3mFULg54Ni6l/orbpm3r+Dif4W+aQpgShh02XsAwnj6Y+rD0ngVAPVvCvAH8B3kF9HyrqBujtxjD3vimcw1D+V2ebJUOJsOFaL3Y3HuncYuhjRihhiViZbt0t84Jk1hiqpyNQkdajnWgIjgQN/ja9evoORkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xyWN6bgA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xyWN6bgA"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b3637b90so15383145e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 04:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780485432; x=1781090232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+KyrkqrXHlGePKgaipm3bkHOjJ6TJi29svJlMHw/IA=;
        b=xyWN6bgAa4Ta8P3t/fTKYccMvqp+hFJRnJjzysXxF9frrIoNjXv74Iqg3xPB0pOpzX
         Xpx6MYQTZFYrifX+4DLkfnF7R3rj5RCdLheFzRuOWvNvzmj+Hlre0tOfXI6S6GeJDwy5
         tyAGA3oDG5jLAYYv4k2lyCtHlH1im9wYIcpgldaqySc9T/dEFzX5kEmxwhkQ/Dh6WbKJ
         cZSyStjwhWZNQHNHRZiJaC0BPvoh8un2twBRyUDcZ2gtrsh3Kp390IShz1wUgYDu/21R
         gJXysm03VAmwu28uST/qa0wecP+dkeTktfNOgbA1NXvT8cxwLQTk4dFNZjts4yLjPdwy
         ZobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780485432; x=1781090232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+KyrkqrXHlGePKgaipm3bkHOjJ6TJi29svJlMHw/IA=;
        b=qWvL7yyo7+Da1ZrPz06umXcKC0xv7vDwqtgsE0HdXhGH4L3JRmUo99lW9DZXkS/3Mu
         g0RuXIJ/aRTrt+WUY9FqRQReak4TvEc6nUOK/4GxNBQYGrUbbGx6eGEDxpCCYzm9GyuU
         YmCA9W9mZv/vf6Yx/4/ZtJtaWMmdeJBqVeeAPfxt5x3Xe1gIFtdue4VCPVMwzxQxSs0Z
         1nYxceyWpfX38RiuFjhkkb7Yo7gpv7fmcdxZzvi+plEeEFLmXMfJQn7BcuIwAn//NAee
         SgGJJ1P5hGLRWUyrC4L50f7d5sk0dyIYYPCuSO4SuYbGBir+ojx/RluxA49YHdu/ONmE
         CX8A==
X-Forwarded-Encrypted: i=1; AFNElJ95hqasj0aE5BhZQID8CgfRKiCcMGOo8FE7TZlFxRAZyt2u/hF0zArqLioCZPAgo1YMiBfU1NhgTHqghTVk3uCj@vger.kernel.org
X-Gm-Message-State: AOJu0YwpKSEd92+MyxT50y+7PzRu9C9x/F7wHHGC8XnmvKdCInE09j1A
	YTq4z2k/SAOJN8Jf6And3Qp7+L4zF5VEOOa87pGaASS+4CEHL8l7eXn99uCrWK2+S+o=
X-Gm-Gg: Acq92OFYtln1NEnWPvxBkUG8oHtSWO4gYnBbZGc9ZNXJOJYNrvJqZrqFcQBDEcCwRL6
	wR/c1KRM5ph8Xfr910ntZNdbWjYvkC5EqB/xk0rhHTjFCNo35GTxuRPx2irf3WwVypbzQEQ+O6I
	xnqa2ZEsd26l1y8MWGoRWIbSp5X6SaFYHnaDkenYWbDe4w1+atbDEhKOb/i7/SSRBOLroSGLwNx
	YAbkzpkw1sETj5ec9koNmnmttctCBsX/nNQl4jYXm903jJAqgeCaUBdKIoCYx3deOcEmKk6G5gy
	QWDAzwCwZSdpy1tkXRjsBHgObk1amSLcgdV3I+1tBswgW0wU6gWyI9qCTDzMo596doN3zcmf9Wd
	Auzi55AHyLVh62NCTxeKbqKlw1JGmQoUPBa75wvYkWzHlx2LiibLTXToRbJ0i0SLxgWtF3vNafT
	QjEUH/UKz83TCkR8p6l66K+uG8DQ69woo/cywiy30=
X-Received: by 2002:a05:600c:c092:b0:490:b724:5085 with SMTP id 5b1f17b1804b1-490b724521cmr29027425e9.33.1780485432205;
        Wed, 03 Jun 2026 04:17:12 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7e6c6a4sm20016975e9.2.2026.06.03.04.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 04:17:11 -0700 (PDT)
Message-ID: <34b3b085-cb13-47d2-aad4-fac8c7812bd3@linaro.org>
Date: Wed, 3 Jun 2026 12:17:10 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/18] perf test: Add a workload that forces context
 switches
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
 <20260602-james-cs-context-tracking-fix-v2-3-85b5ce6f55c6@linaro.org>
 <20260603110621.GR101133@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260603110621.GR101133@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/06/2026 12:06 pm, Leo Yan wrote:
> On Tue, Jun 02, 2026 at 03:26:45PM +0100, James Clark wrote:
> 
> [...]
> 
>> +/* Not static to avoid LTO clobbering the function name */
>> +void context_switch_loop_proc1(int in_fd, int out_fd);
>> +noinline void context_switch_loop_proc1(int in_fd, int out_fd)
>> +{
>> +	for (int i = 0; i < loops; i++) {
>> +		read_block(in_fd);
>> +		context_switch_loop_work += i * 3;
>> +		write_block(out_fd);
>> +	}
>> +}
> 
> Rather than struggling with unexpected options, and "noinline" might
> not work as it is not a standard compiler option (it is defined in
> kernel header as AI reminded me), wouldn't it is reliable to use a
> dedicated CFLAG rule same as other programs?
> 
> Thanks,
> Leo

noinline seems to be used as standard across the tools codebase, so if 
it doesn't work there are bigger problems. Perf also only really seems 
to support GCC and Clang and they both work for this test.

And I don't actually think it matters if this is inlined or not as long 
as the debug info reports those lines as being in this function. That's 
what what having it as a global symbol is supposed to achieve, but 
that's about renaming rather than inlining. Maybe inline is over the 
top, but its a pattern copied from other similar workloads and tests.

Probably makes sense to wait for an actual failure to appear and then we 
can decide what to do with it then.

