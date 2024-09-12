Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6365F1AE053
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152026; cv=none; b=AJRXOmHdwHPw54uZCuRuaQ471NNIy10XiF4rEZBQVU7DldPuuI8K+LfluqGzofCUDoIzgFyEAlt4/sepsKmg5dRxb60oEIA62mZ+F6rbhOnpZpqoQwGjfWXdP3GhE4ungjgDihQQbe/h0Z3Brk6duJomvcY567lg3qrGpI8viWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152026; c=relaxed/simple;
	bh=7PsnzH/zX1w9wQh7QhZfA3aCh3LfvKI92gde2iSDiFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ugX6aYW47JKxks8lIyoMPV5UhInRsJk+QOJID95d4uoY/NdA9sHRHg/NLiimwPDGZ8vhKia7dx+1I8PAJCcLck4WsUlR6yy9AV6cmWERF64lZ0rO6jY0D+nguxjTICB8/a2T7FBkT7LgRQ8mwqwJYQLRs5mdeIK9zsJR0PgcWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jveiMRDo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jveiMRDo"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42bbffe38e6so8671025e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726152023; x=1726756823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kuBQUYzd7Xk8zQ7Lv73CQH3VywELyjU4bkUJu8mOPEg=;
        b=jveiMRDotR92zT8BmKydamIgZJ1f4f8vErV9KPxrAvJ5d5ha93JRA4ooCUqw8Qb0ff
         G9hzE5GpB1qdAaH/V261Xmn3TlX0tVOrKd60DefjhZLj7wQtG7JPxDs/KPunnDlHhCD2
         aqpS3PNgO1T4T1hdJO2aZHjSuOWCDp19NXm+S8JU0RBVh/PH1CkzMm3hIAhpfRnBpQ1O
         gZ7yZLyaVjF5NoMugMuCcxph+Fo6dNxLZAqFWuAnNOTreQUyHcsCbHCVDyV/u8rQ5Ihz
         5r+muXUxAzroqxdk0b/WvBXUPxuXahLYcVqSXcergB7zvFWV/din4kKDyS+6fBnJOM4m
         fOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152023; x=1726756823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuBQUYzd7Xk8zQ7Lv73CQH3VywELyjU4bkUJu8mOPEg=;
        b=i4ikbHjjxd9v8cJpZWEvFoMfQ6tP++9tlcB1k/M8PBjwk0XoCqYw12O6qwki1NLVfZ
         E3dr7CKDSx9BgqUDnHkHLpvbgpEAkJXfOjoGIlZXjbLc8fhLlQFjOM7CqaRtvAHY1yEZ
         xnpF0czuI3bw83WmFLB4Nh+2c74DW35A33k4zUVqdoqioeMODgWT5x30oEDS1DVYizY6
         pGfZKI7a14MSb6LlwxD9sl5rWrmqffOuEzaQl3GkoplZMz7OicKkZvHK5cPeNVH+z2dE
         gLDRrdHR5+UxVQZIdL9ajXhKe4Eu+lHzIjt/mV9h8Uu3YwCbRJK+pIOfowLg80KRHgv7
         JXGg==
X-Forwarded-Encrypted: i=1; AJvYcCW2KHFtOMKWU1MOySh+MH1CvnJQIHn1trOiri5RYhIifLwkcNZCe6kcA7rSAe4cbsyXkYVB0qv/0zpe2lKxGQdT@vger.kernel.org
X-Gm-Message-State: AOJu0YzcXKcld5+LpopcE7zTjiVvzzByofwwIc19gtYT7PGhBEHtb/iy
	75AujBJ4RZCseLUwlcbWZFn5gF06K54RVJ1ZpkCeKfv8XVzxjzYdRwO5ybNINn4=
X-Google-Smtp-Source: AGHT+IH/FtGHzSI/SrDj/IcyFNHIZ5YZ4pPBHUw8767ElxUadBbxNnErWTIC1dcQddhP2c8LSouX3A==
X-Received: by 2002:a05:600c:4446:b0:42c:a580:71cf with SMTP id 5b1f17b1804b1-42cdb571ec0mr25230455e9.30.1726152021932;
        Thu, 12 Sep 2024 07:40:21 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cbbbf8a4csm107767085e9.47.2024.09.12.07.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 07:40:19 -0700 (PDT)
Message-ID: <caad2d84-a8ff-4304-b8ab-04642ea18323@linaro.org>
Date: Thu, 12 Sep 2024 15:40:32 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf build: Require at least clang 16.0.6 to build
 BPF skeletons
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org
References: <ZuGL9ROeTV2uXoSp@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <ZuGL9ROeTV2uXoSp@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/09/2024 13:24, Arnaldo Carvalho de Melo wrote:
> Howard reported problems using perf features that use BPF:
> 
>    perf $ clang -v
>    Debian clang version 15.0.6
>    Target: x86_64-pc-linux-gnu
>    Thread model: posix
>    InstalledDir: /bin
>    Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>    Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>    Candidate multilib: .;@m64
>    Selected multilib: .;@m64
>    perf $ ./perf trace -e write --max-events=1
>    libbpf: prog 'sys_enter_rename': BPF program load failed: Permission denied
>    libbpf: prog 'sys_enter_rename': -- BEGIN PROG LOAD LOG --
>    0: R1=ctx() R10=fp0
> 
> But it works with:
> 
>    perf $ clang -v
>    Debian clang version 16.0.6 (15~deb12u1)
>    Target: x86_64-pc-linux-gnu
>    Thread model: posix
>    InstalledDir: /bin
>    Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>    Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>    Candidate multilib: .;@m64
>    Selected multilib: .;@m64
>    perf $ ./perf trace -e write --max-events=1
>         0.000 ( 0.009 ms): gmain/1448 write(fd: 4, buf: \1\0\0\0\0\0\0\0, count: 8)                         = 8 (kworker/0:0-eve)
>    perf $
> 
> So lets make that the required version, if you happen to have a slightly
> older version where this work, please report so that we can adjust the
> minimum required version.
> 

I wasn't able to reproduce the issue with either of these versions. But 
I suppose it could be an issue with only 15.0.6.

$ clang -v
Ubuntu clang version 15.0.7
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/11
Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/12
Selected GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/12
Candidate multilib: .;@m64
Selected multilib: .;@m64


Ubuntu clang version 14.0.0-1ubuntu1.1
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/11
Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/12
Selected GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/12
Candidate multilib: .;@m64
Selected multilib: .;@m64
