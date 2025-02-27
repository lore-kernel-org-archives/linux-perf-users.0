Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B9F22A4CD
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652538; cv=none; b=tzsLKjx+JQN2qopXIblTN9uPf2ZHzwGiK7I/1NFTmhKJL8jbCz11IyzT7He74ZJxo0hxG0ZUYNS1t+lntrAO+pVSLrRewt2egWxezAeEmNvWc4QaAKefJ3k7d/aDx25/jVUHSiAhGPhx7jLf6lDg2CmIqdVTvS65FuotQTKyGfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652538; c=relaxed/simple;
	bh=XiUg4lquAssfrYJ7zIy7C8r9PFTuRNbILtU8GvqzcGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=g83tnPF5B8E98R3DeFfhm0TFFONb4ED0iBuTSTXbnz9WhHDCx3LnQ8xcpZIgQaTy5nE/ScVRbbX25dQ8pKJRy3XldaXdab5FZil9dXQsCrm/GSfgvZeh/AK0kWlt6todHLq1AqPvuC05+xm6Cb9xRM76/jGzC4jaJUBzaNPEt5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=irmQPac9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="irmQPac9"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-439a2780b44so4857045e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 02:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740652532; x=1741257332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xPFzFL3HoPChXCAEL+cQ7eabmafPxqsFZAdvcYb7obQ=;
        b=irmQPac99v/jByhVzEFJZiDzQgtXUA9fieu2dd4PtBnhhvk/S1zl0rUtt2u9dE8anW
         Qla7uA1kOIiuG9PG7mMaj3mlNmrHKsdvjta1QyA7N728tY4YoTODJEMUXZrsNqh/7Vip
         7HTPV0fWrhyu3qyRyq7GiMacw5qWJkdxCHrQWeyAUqO6mqOcIiriJqgSqqqImS4yJNRJ
         gtjL8xczKTUbKCUT2LmQwmLfA8Z0ZpHVzIzP+48EApldzJDEPJIOpD+GVBF9DU6o85TN
         uJY9fEDrIPt2CwDw9aLBHTYyAqj5TVC1v0HNbi+bPPU2rEe+uEuVsyrlO+QvJ/C0I1hH
         D/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740652532; x=1741257332;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPFzFL3HoPChXCAEL+cQ7eabmafPxqsFZAdvcYb7obQ=;
        b=geIh1EhG9VSxRyvV9iTQu8SYGhQMrsA2eKnwIGiL1tf3/tQT1u3jBrpv6RmRjf5qe2
         wKmZEPq4x9LODg6YbeLuiTS961XUbeqIIDJaYXXC10QGoty7TON2MeEB8/qr+MVy8FPS
         Mg4ILs4dB74phbf5joseeTGvcRaBl+eNwuulbUWc3QzxoQi+OeADqUSsiAYPNQsAoSoh
         EJ+xqEIkIc7VfBU+fVWZlG6d3/SXTHuq1RzqPyWYye/orTqjimldVoG+fw0UfTfJ/Opw
         DRZWZYwGJev0xuiLJjdQUG7X3DyurWWS02uScKCpLlnvwc8SCpICPtgIgqTuzgnH2lAg
         cteQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAx7FicbG6v1W3sU7j0d2f5FNK2tr8mDh19OtATBQ54JT4GL7FoFijV/hj348ij2NKfiUhCx8Hd4INVbWzM43P@vger.kernel.org
X-Gm-Message-State: AOJu0YwYvO5Q6Sk68NVlqJXnObXoaMPNx9SosNDTrt/Jz8HEo4nKRQy2
	V0V2S5A5/2uWYv5CXjC6uy0zZ0ApXGXCQcAc9lfMJTNPqAUrftuEhDBFqz8y7pU=
X-Gm-Gg: ASbGncvKPmGv6PDu0+cZyhOtxfSaaEKdJiLE7tOYeT/ItDrNY9Xzwv/zxrqKKek5JBx
	UgEt8Tgq2tDcIyQy/PE8ahAvvmF0rtU5VXM7SA1JIrw6i8jw7lTjG6VY6qaBj+aj2Xr/PBgauSV
	Whd/8xvXTjxmGrgV9IYNMee5fALThf1wReoz7Qwa9yZjyrZWtWPDlZMk3DB6kydNQ3VbUVe4znL
	ceaa0eaPUlf9RFJI5QjNI+t5oR+DRmFjBjPiCmxjB5SiGrNRPA92NomyYbKAmXxjYJ5mvRKBl5/
	ukrnSvpN7x15qCWrzyJIVaEkxb1xn8O/0Q==
X-Google-Smtp-Source: AGHT+IGTDFJiC8AWbAlrfhtEWtcbYEibMXKjCqlgRiPvFG3whc3Ax0mp1g7LPuKQXJRD9RGqRIyApA==
X-Received: by 2002:a05:600c:34c9:b0:439:9828:c422 with SMTP id 5b1f17b1804b1-43abdcd387amr33419975e9.18.1740652531994;
        Thu, 27 Feb 2025 02:35:31 -0800 (PST)
Received: from [192.168.1.247] ([145.224.66.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba57145esm49746715e9.30.2025.02.27.02.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 02:35:31 -0800 (PST)
Message-ID: <ac1350fd-ef8d-485c-ab70-b38a3ffe9b87@linaro.org>
Date: Thu, 27 Feb 2025 10:35:30 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf tests: Fix data symbol test with LTO builds
To: Ian Rogers <irogers@google.com>
References: <20250226230109.314580-1-irogers@google.com>
 <CAP-5=fUN7=cQ9X10tH1qpmzpJoSoqHH5CV5MVwhqXkQ8vkbwoA@mail.gmail.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fUN7=cQ9X10tH1qpmzpJoSoqHH5CV5MVwhqXkQ8vkbwoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27/02/2025 5:42 am, Ian Rogers wrote:
> On Wed, Feb 26, 2025 at 3:01 PM Ian Rogers <irogers@google.com> wrote:
>>
>> With LTO builds, although regular builds could also see this as
>> all the code is in one file, the datasym workload can realize the
>> buf1.reserved data is never accessed. The compiler moves the
>> variable to bss and only keeps the data1 and data2 parts as
>> separate variables. This causes the symbol check to fail in the
>> test. Make the variable volatile to disable the more aggressive
>> optimization. Rename the variable to make which buf1 in perf is
>> being referred to.
>>
>> Before:
>> ```
>> $ perf test -vv "data symbol"
>> 126: Test data symbol:
>> --- start ---
>> test child forked, pid 299808
>> perf does not have symbol 'buf1'
>> perf is missing symbols - skipping test
>> ---- end(-2) ----
>> 126: Test data symbol                                                : Skip
>> $ nm perf|grep buf1
>> 0000000000a5fa40 b buf1.0
>> 0000000000a5fa48 b buf1.1
>> ```
>>
>> After:
>> ```
>> $ nm perf|grep buf1
>> 0000000000a53a00 d buf1
>> $ perf test -vv "data symbol"126: Test data symbol:
>> --- start ---
>> test child forked, pid 302166
>>   a53a00-a53a39 l buf1
>> perf does have symbol 'buf1'
>> Recording workload...
>> Waiting for "perf record has started" message
>> OK
>> Cleaning up files...
>> ---- end(0) ----
>> 126: Test data symbol                                                : Ok
>> ```
>>
>> Fixes: 3dfc01fe9d12 ("perf test: Add 'datasym' test workload")
>> Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ah, I see we're trying to force -O0 and -fno-inline in the Makefile
> (git.kernel.org is giving 403s):
> https://github.com/torvalds/linux/blob/master/tools/perf/tests/workloads/Build#L11
> Which LTO later undoes. I'm not seeing LTO breakages for brstack.c and
> the shell test "Check branch stack sampling". I think LTO is able to
> optimize this case as it is a variable/struct being optimized, so the
> "-O0" and "-fno-inline" mustn't be being made to apply. Not a wholly
> satisfactory reason to add the volatile, but I'm short on
> alternatives.
> 
> Thanks,
> Ian
> 
> 
> 

Adding -fno-lto to that file works for me (llvm-15):

   CFLAGS_datasym.o          = -fno-lto -g -O0 -fno-inline ...

In fact it looks like we should add this to everywhere we're already 
doing -g and -O0. If lto is just another form of optimisation it should 
be disabled as well.

