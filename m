Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9227433B6E7
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769762694; cv=none; b=A7tmGKrFodGqEXGcR6THdPgnV2nFIG0Vilwzyq/3mGx9x6/6vYj6UlBq8wxUfEg/V6aQucuzp8oevyhMEn9zGOpdMjriLE7tFenwcZQRGLEXjhUs6PEK4qiT548P56l+mNE1KI97CUhiffYlmGd80V8YEOasRbONi8oUgz9mzE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769762694; c=relaxed/simple;
	bh=BwK0zS/g35l1dc1wG6ge3L0gSpBMfdzNP+xlAeuthKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNJfDxBhoqFkLMl3HwrG+LcZT1RTad8gCYbIU3BM1+0A8ZTohdMCs/wSYEdJPXM8HMWNKIj3l2dFUTH+qUiLryYYPtUkp/sat9cwuSZ/l+6FwYruCGE+19Cg42LSOClc4uPmlWqhhrQ0PWcVCVh9ntAXdIYN2yq0vUJElzV+mI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZkwR06v; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZkwR06v"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-658cb3ee91aso3208446a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 00:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769762691; x=1770367491; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vX3YZgQSbEYnCed4aFRWBJ56yF0sMkQE0vSG0FeqjQo=;
        b=GZkwR06vTdHm9/14hBqD0e4GhI7ZyYB9WmzLmmf3OWbY/aEL31x0qMHwtdSOFyDFzq
         RlGajG+4KntC3T/G40oudcsi7oRgukXjFQ+xlLDjQABWwLIL+9WbGEZiP/9vCwnjcegv
         eV+6cg3xyp2r/pnMlk6vwBhQEgOR4q6qVEfxCuJn/rBA0toxUmeclyDJMLFoRPd9x7C8
         fEGQgXVV3sb91zWP9v6VrYKwR5NIMK1sv5d7dWx/x1nb1U9tPt5N8S18wFRy63/6Bx9d
         74X1FDtKwEbakg2SI5ayWgYHfOOtvM7Rz/V03sM27eORXtSUVdEyDLKVpqPl/hYR+B/F
         sASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769762691; x=1770367491;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vX3YZgQSbEYnCed4aFRWBJ56yF0sMkQE0vSG0FeqjQo=;
        b=t5A4seu0jRGe3YpEVbuFA5eLuF30pKAY5PmjRMP/FeVTHUsFCKoE5I/LJXs7VrBj5J
         Pi17hpUAuNNtG67cTOOQeuRLwVzYpXqqtb7uNsVcI2V79912s/u9KXrI2LX9gyEGZWt8
         0jhFEB7kQqbomtrpIhWlDVWnmbmXIcqkguc4XXm699LwKNdGUKd1mwvsSDzsVnQJsekJ
         68x88UoYtZLtS0zimmPklxycdhfMFb1tjbrPOMJPRv56L7X+Cej7gps9srjd+lO19SpQ
         XkKNh9IbhR5zHzB4JmidVn7Bn2UtsAuTrXAm6KT/CR4TdyqLS8unw01DmAlZoMnP9C2q
         LihQ==
X-Gm-Message-State: AOJu0YxYGi4aquz0TAuqnKkzPDYvH5Wjb2hquJbWGH5VUukGmEUDTZBV
	TdzKj0eDOURKDbCAW+tUuQWSFu/YMPgLSjaZs9r5E7qYokkJLr7oIMWX
X-Gm-Gg: AZuq6aLtXTet84VrTSdRiC4o7TRgSH1QEnFo39WUiOwj+Dk3KXhGSE93MLhT4UKmHH9
	AfySIohasMxfgkPTndhA6UT8wS5ldyZVwaMBZLHjDtVN2s2yCDoebVmVEBQLLl83rKtt/7nodAy
	GE+0L5R7YJa4SE3SSKjrWtyTwcsT51h2WfDf93ORY54OllEMWnCtyN4NFhLYEKwT22aaqc3KY1y
	bJp0BAdO75hFiZJ2vObKYHlUae8KYxg329sokYD1i7QgwKOPoeBut6EolfDptS/mBDuN3zRKPi7
	g0gvFwNb0c9NedtDpi8sl5b55FiFlSwiKsAmnEIZL2nUpPytsL7QtAIvbgO6GyuISmSU6T1Seh0
	FbmXR4TX4lOWFlseuJ4iV8np/+5Lc+bCPVBIzcIHWEom/KlXSv+IW/t0xV9g4+od4HKWGU81/F7
	u5vpFGzTBp9RC+CFn6T2BzFhtnrkDJw/QZoe6fGR1/7Od2j06uAPry9pS/tjB2GHPV4WRnDFnfl
	wxZ5V+UCBljxbXvAw==
X-Received: by 2002:a17:906:f589:b0:b87:e58:e37d with SMTP id a640c23a62f3a-b8dff6ed5fbmr100525766b.48.1769762690479;
        Fri, 30 Jan 2026 00:44:50 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (ip-109-42-119-114.web.vodafone.de. [109.42.119.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8de8c93c11sm200024066b.28.2026.01.30.00.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 00:44:49 -0800 (PST)
Date: Fri, 30 Jan 2026 09:44:47 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1] perf tests: Test annotate with data type
 profiling and rust
Message-ID: <2frzr2cebxes2qoxofwqshfkb5k3d7jeq72srqnt4ywrlpkz5r@7pzb7cpbm4yw>
References: <20260127083030.5909-1-9erthalion6@gmail.com>
 <aXjvF3N5ZGJlZzFi@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXjvF3N5ZGJlZzFi@x1>

> On Tue, Jan 27, 2026 at 02:00:07PM -0300, Arnaldo Carvalho de Melo wrote:
> I think this should be split into at least two patchs, one introducing
> the new workload and then the new perf test.

Makes sense, will do.

> Isn't that 'perf record' just using cycles? Wouldn't it be better to use
> 'perf mem record'?

'perf record' was an example I've picked up from LPC 2025 talk about
this, but I can switch it to 'perf mem record' as well.

> I don't have rust installed in this container, in this case we need some
> sort of capability query to tell the user that rust is needed for this
> feature to be present in perf.

Right, after some experimenting I think it would be a good idea to add a
new feature into tools/build/feature called "rust" and hide the workload
and the test behind it.

> I see, it doesn't work if I use 'make O=/some/directory/ -C tools/perf'

Ouch, I have to admit I haven't tested it that way, need to figure out
what's different in this case.

> acme@number:~/git/perf-tools-next$ sudo tools/perf/perf annotate -f --code-with-type
> 
> Again, [Type] is there, but no types:
> 
> Samples: 4K of event 'ibs_op/ldlat=0/', 4000 Hz, Event count (approx.): 5414001952
> test_rs  /home/acme/git/perf-tools-next/tools/perf/perf [Percent: local period] [Type]
>    0.14 │       sub    $0x98,%rsp                                                      
>         │       mov    %edi,0x2c(%rsp)                                                 
>         │       mov    %edi,0x84(%rsp)                                                 
>         │       lea    _IO_stdin_used+0x20,%rsi                                        
>    0.07 │       lea    0x60(%rsp),%rdi                                                 
>    0.07 │       mov    $0x4,%edx                                                       
>         │     → call   <alloc::string::String as core::convert::From<&str>>::f
> 
> I'm not managing to reproduce your results, can you please elaborate
> some more?

That's most unexpected for me, the test output I see looks like this:

         : 54     for _ in 1..count {
    0.00 :   5423b8: mov    %ecx,0x7c(%rsp)
    0.00 :   5423bc: mov    %eax,0x80(%rsp)
    0.00 :   5423c3: lea    0x7c(%rsp),%rdi
   12.28 :   5423c8: call   541f00 <core::iter::range::<impl core::iter::traits::iterator::Iterator for core::ops::range::Range<A>>::next>
    0.00 :   5423cd: mov    %eax,0x20(%rsp)
   10.21 :   5423d1: jmp    5423d3 <test_rs+0xb3>
    0.00 :   5423d3: mov    0x20(%rsp),%eax
    0.00 :   5423d7: mov    %eax,%eax
    0.00 :   5423d9: test   $0x1,%rax
    0.29 :   5423df: je     5423f6 <test_rs+0xd6>
         : 65     b.data1 += 1;
   13.69 :   5423e1: mov    0x48(%rsp),%rax     # data-type: struct Buf +0x18 (data1)
    0.00 :   5423e6: add    $0x1,%rax
    0.00 :   5423ea: mov    %rax,0x18(%rsp)     # data-type: u64 +0
    0.00 :   5423ef: setb   %al
   11.17 :   5423f2: jb     54243a <test_rs+0x11a>
    0.00 :   5423f4: jmp    542426 <test_rs+0x106>
    0.00 :   5423f6: lea    0x30(%rsp),%rdi
         : 73     }

Where '# data-type: struct Buf' is as far as I understand a manifestation of
data type profiling succeeding. But my environment has slightly different
version of rust -- I need to figure out what's going on here, thanks.
