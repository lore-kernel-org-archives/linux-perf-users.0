Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65223D0C5
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153242; cv=none; b=Gyv97sirJdvhsz+D+NarOi6iBHxeJTpvgFWK32gnXyOGhefBkRC0IPQLdUPowPuImu2W2zb6J+jcQlGlu38CS5q3qi9p9bHBPentM7/+N6EJvndFa30cHzClQfiVwiw18iYTHFDtRDpYlZfBPgscstR1Dn5mBmcAe8YfjWyFgEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153242; c=relaxed/simple;
	bh=qp4tup2O1mnu9IXtGzVcuYfiHWi5bTJU4SY95s7YP9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPN2CCPPXMQBN7a/fVlMTZI9rGAn01Xg49R1T/wIkR6y8X8tqoQIIWHIgWL5m2949L6fgPIrCbBGHLo6ZHG+q/wiczQJoeDhVvy1LVSA1GKoS7wOpSeRq6AAu+eDaymuOTlWjzwcxDPvCL6BbcLsEGk8SnBJen+wXwnPlfxLwLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TX+Q0AIw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TX+Q0AIw"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374c1963cb6so778342f8f.3
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 08:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726153239; x=1726758039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MY8Q22WrN9A6BKqFuPJeUqXRj2azetZ70kLGvEilHa4=;
        b=TX+Q0AIwanEl8jcNP6xC5YJ3aYCZES6dk7uNLFkdOONXayuIcNI+Cf11grO3xC/I+d
         +DyohNQkeQmBf2BTRp0zbaa+nXgf00U7MctqqXEC5Aq5SlLZyVrdz9JQOi1/quP1Y1Hl
         Ct6zzAolIogtr0Pt8lf16Bb1r97Ret9MVzh+ipcQqA2350zUzIbWuu3xY5SEx4Qn6zA4
         IMn8CVXXYY5ND9ZHqG8y4cDIPe2T7Qtb3PA7BuoKbjAM4E9nRekUXtLkMp2b0nuiK/rl
         enyQ2oLyCxt2PD/HOZS9L8DkUKkitnyuL6XyPRb32DozwhparXCnsa3sYPzTe/5T7vwN
         q3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153239; x=1726758039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MY8Q22WrN9A6BKqFuPJeUqXRj2azetZ70kLGvEilHa4=;
        b=iX9AsT/5fwNMZxLKC2vZu/aJ4ldm9GeVLzLZnfsx+BSmJ4RV7/MAc1zZ+vG59NI04j
         fsMHmbXR43cXuqjlneOaGRYtEcALS7f2gG4x1Uke5LQghM2QwMqDXRPIjGu5G/IvZKbO
         SgFdWTdP0Dst1MCVLmYg4BpPYuH9KHTNAhrHxYUpuYUTo7cTWbYnYwMbWI5U7zyrQDjc
         livHv4gqduLTU10UZp1Sj0P9wMJF5nmT3cPlSR6CuHKXr3NSkrOmruJo9BU+LcvtZcBh
         VeRihLXBpTs8/er6olDTyEVqkYErUNuRTnXmtTJXXFJ8t/sN6qqQmgIf0w3zRLwKrI66
         GMfA==
X-Forwarded-Encrypted: i=1; AJvYcCWfdZGjTI0NVGuNUP3puWS9tMLv3tPpMRVUlgLSI1T9SBOcwWN9VRz+0acZp+RumB/Topcvek1RE9ZHKIYzagD3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7HZHiPuacFaifSyDDTml6rmpbjvUztzp5PtsVEGmHPVAUkS38
	FYGYA4yt+UFaMFH+kxp620DJrZSKpiu+s1ANc9He5u20Kb2KwY6RFRR29SZBA4A=
X-Google-Smtp-Source: AGHT+IGt2LV5vxwZxZEoCpaKVdX6X/qt4lXoMCZRBVwOgBfiAVMXupPwaDud3LSNSNf2EyLbJ5DHgQ==
X-Received: by 2002:adf:ce10:0:b0:374:c15a:8556 with SMTP id ffacd0b85a97d-378c2d620d4mr1879565f8f.50.1726153238625;
        Thu, 12 Sep 2024 08:00:38 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956ddbbbsm14419453f8f.93.2024.09.12.08.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 08:00:38 -0700 (PDT)
Message-ID: <71023502-b38b-44f9-8b04-96324b3bb461@linaro.org>
Date: Thu, 12 Sep 2024 16:00:50 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf build: Require at least clang 16.0.6 to build
 BPF skeletons
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org
References: <ZuGL9ROeTV2uXoSp@x1>
 <caad2d84-a8ff-4304-b8ab-04642ea18323@linaro.org> <ZuL_0V5jgaaEUOY_@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <ZuL_0V5jgaaEUOY_@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/09/2024 15:50, Arnaldo Carvalho de Melo wrote:
> On Thu, Sep 12, 2024 at 03:40:32PM +0100, James Clark wrote:
>> On 11/09/2024 13:24, Arnaldo Carvalho de Melo wrote:
>>> Howard reported problems using perf features that use BPF:
> 
>>>     perf $ clang -v
>>>     Debian clang version 15.0.6
>>>     Target: x86_64-pc-linux-gnu
>>>     Thread model: posix
>>>     InstalledDir: /bin
>>>     Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>>>     Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>>>     Candidate multilib: .;@m64
>>>     Selected multilib: .;@m64
>>>     perf $ ./perf trace -e write --max-events=1
>>>     libbpf: prog 'sys_enter_rename': BPF program load failed: Permission denied
>>>     libbpf: prog 'sys_enter_rename': -- BEGIN PROG LOAD LOG --
>>>     0: R1=ctx() R10=fp0
>>>
>>> But it works with:
>>>
>>>     perf $ clang -v
>>>     Debian clang version 16.0.6 (15~deb12u1)
>>>     Target: x86_64-pc-linux-gnu
>>>     Thread model: posix
>>>     InstalledDir: /bin
>>>     Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>>>     Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>>>     Candidate multilib: .;@m64
>>>     Selected multilib: .;@m64
>>>     perf $ ./perf trace -e write --max-events=1
>>>          0.000 ( 0.009 ms): gmain/1448 write(fd: 4, buf: \1\0\0\0\0\0\0\0, count: 8)                         = 8 (kworker/0:0-eve)
>>>     perf $
>>>
>>> So lets make that the required version, if you happen to have a slightly
>>> older version where this work, please report so that we can adjust the
>>> minimum required version.
>   
>> I wasn't able to reproduce the issue with either of these versions. But I
>> suppose it could be an issue with only 15.0.6.
> 
> Interesting, that complicates things, probably the best way then is to
> try to build it, if it fails, mention that 15.0.6 is known to be
> problematic and suggest working versions?
> 
> - Arnaldo
>   

I'll try to build it and see. But Ubuntu 22 only has clang 11 to 15 so 
making 16 the minimum could be an issue.
