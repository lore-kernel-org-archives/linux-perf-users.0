Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1388E1E49F
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Mar 2025 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607592; cv=none; b=nJJLBoC1L61TRPwx8uZ2vx4GU6FLwjNDOb1QYvgZ+o9jvcEv1326puXJeCPVicVwA7eWyeGpnR1iHqx0VXcwJgzNNlgA0Txo0fHKeUPJrOSQrgpu60iIVPqhUOWU5tZw8COFhSa80ciJpUvglaTwva14EqaSc1aVdaIJ/5738nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607592; c=relaxed/simple;
	bh=HnpQN/9JD/0tE3Ii+ujs0VTKkvmubFYbXo2txQ+tvXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBPeAbiRnvrkXZa6tKde9S2Os0/YKorvGs5IT20U/GwvnQp5xvLzc4rzhnzvdn5rVoqjeTRHhb0fkP2CFgNF7sgDFh1HUZRjFSvMoiAN9DpqXso7T/UUgaqC8McbqIYDMylz02Y1s3pLT/cfM0Vss1EFfG3nehb0tF6fLWIgN1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VKWw516x; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VKWw516x"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso5271105e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Mar 2025 04:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741607588; x=1742212388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hl2/xwI0lIiO5oLXfjMLwGGX3+nlXTTbDPHyBctI16M=;
        b=VKWw516xmkaAKPsTVp1Jv9a2liHs20pcVT2McmgueYaY+cCwahHolbzcWKZLOA8pW3
         PbELpEvHdBcNYdutS1ZgX5bs9HXzGK71RYARd4weswyy4Q0TfbEOSMH39FWybQbO462D
         db9PuYKGghErHEBiKAYyJVPSfmNrLGdPqSaF80s5Z0a5xW9g/7iPkmO8xfVvblqrNoEj
         Lx9sfBYjLDbnAs9QYF7h+SHHHEMkhIXFX5alxa9QloS3ybmqf273ijpGWBKEMhPa7miF
         4EjLcUVRnwC7bmNsBnMbrEmbyOMztVeyBp9HkA+B49UpKDXqHsZvwUIcbrrNRKEC9AnP
         emAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741607588; x=1742212388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hl2/xwI0lIiO5oLXfjMLwGGX3+nlXTTbDPHyBctI16M=;
        b=TQvxd2+fBq3kbsDdpgnS/Ff05aetuf/DM1dRAtylIfAvFHwimSClFadFt36gJbiiiG
         n2moPCR2iDwdKqgv6BaynWmHy5CDCsdmdNx8H0Lk/7vLxuMHEHDXViHG9dSlYsnQlg/E
         XauhY59d1r3Qpixq50FMKnagoyMA3D22YnhgTG09VojpfTZF3p93Vw33QY4BFk9LIuSt
         lpIoffKrbC3thgSPO5lfw5XYO7kSB+jHg2NbHHyUjbDZCLt0lteADebKAQPpLbza/GDZ
         KtqRfRkH4y8oC6qTzsJDDBdgkCHMv6VzhWhOjK7UJLAiPykS+sEF10Kx89idg3vEIE3m
         FrzQ==
X-Gm-Message-State: AOJu0YypuIXCduVeRblNIgQ1Z6JcOrk7YUdpkwSefX622yzKU/SPr4h0
	FMPDAKkfsZzX175JGFaHl7ULTafJJb4oXNckb3sj9Cv+yjA+YrYcCpYhZkMyksA=
X-Gm-Gg: ASbGncu3Uy3u1SF3awIad+20DSOPGUpBK/r1OPZJxX+KiGvqo8msdfE5csmA/dnv+BG
	/vdbNFdfbc7nEbSffl0mLQ+iZFLC2xjVU8ubz9mPJJqwnsKR+k4OPorCf9hB5h96bZ+j388bVkE
	5eODY5kZL/jZEXsrcqWw+jEbGfIXjqWih8//kO9+nWZCnKpLqu6zS5yfbFj8IPC8yW8GuwOQ+Vj
	eslCaK2e88DADOxQ1WyHLR7Y6Dd58k0itxJTDpMf3R/Cy9375WY8iBXturhvgdFnU87l/GI3GJ8
	VpYz5/GUDTFjJ9vm7QcV5cxgBLd7XjxbA7ioGHYEYMiJIPGW+Cue
X-Google-Smtp-Source: AGHT+IE0FS0CGqERh2xc5yy/C3HZgRToZod5PBEXaM/KH40EAdKl9vt1u+tijhFXk9MYqlfLU468Sg==
X-Received: by 2002:a5d:648f:0:b0:38f:2b77:a9f3 with SMTP id ffacd0b85a97d-39132dd6934mr9445318f8f.43.1741607588344;
        Mon, 10 Mar 2025 04:53:08 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.65.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cec487fb2sm69148025e9.37.2025.03.10.04.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 04:53:07 -0700 (PDT)
Message-ID: <516dd4bb-c317-42ce-b539-92c6c1eabcbe@linaro.org>
Date: Mon, 10 Mar 2025 11:53:06 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: perf: Live mode flamegraph recording results in segmentation
 fault
To: David <davidzgumberg@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <f3d4363e-1de6-4817-b45e-fb2a05f02723@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <f3d4363e-1de6-4817-b45e-fb2a05f02723@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/03/2025 4:25 pm, David wrote:
> I've reproduced this on recent versions of Debian, Ubuntu, CentOS, and 
> Fedora,
> and I used to be able to downgrade perf and it would work, but an early 
> enough
> version of perf is no longer available from most package repositories.
> 
> Steps I have taken to reproduce:
> 
> 1. Install perf from a distro package manager. ( `sudo dnf install perf`)
> 
> ```
>   $ perf --version
> 
> perf version 6.13.5-200.fc41.x86_64)
> ```
> 
> 2. Attempt a live flamegraph report:
> 
> ```
> 
> $ perf script flamegraph ls
> /usr/libexec/perf-core/scripts/python/bin/flamegraph-report: line 3: 
> 1644 Segmentation fault      (core dumped) perf script -s 
> "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
> ```
> 
> 

Hi David,

Are you able to bisect this to find the breaking commit?

Is this the full output you get? I'm not able to reproduce your exact 
issue. I do see a bug with the template download prompt but it produces 
more output than you have:

  $ perf script flamegraph ls

   Warning: Flame Graph template '/usr/share/d3-flame-graph/d3-
   flamegraph-base.html' does not exist.
   [...]
   s = input("Do you wish to download a template from cdn.jsdelivr.net?
   (this warning can be suppressed with --allow-download) [yn] ").lower()
   OSError: [Errno 9] Bad file descriptor
   Fatal Python error: handler_call_die: problem in Python trace event
   handler
   Python runtime state: initialized

   Current thread 0x00007d1916afd400 (most recent call first):
   <no Python frame>

   Extension modules: apt_pkg (total: 1)
   Aborted (core dumped)

But if I avoid the record/report wrapper and go straight to the script 
it works:

   $ perf record -g ls
   $ perf script flamegraph.py

   [...]
   Do you wish to download a template from cdn.jsdelivr.net? (this
   warning can be suppressed with --allow-download) [yn] y

   dumping data to flamegraph.html

I'm wondering if the template prompt ever worked in conjunction with the 
wrappers? Maybe they were only tested with the template already 
installed, or the script was always used directly when the need for a 
template was added.

Thanks
James

