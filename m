Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D67F2E5B2A
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Mar 2026 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881342; cv=none; b=lCtfpdkThY84XRsguhKRtA9EOW2i920z6vu3zFPI+o2AxZSpnmPUegDAMW8m/lg6T3WVReYrtTIpaXLmSNJCHDYCzCuRCdd4okmjRo6mr24GDeg0s1ZjgAVMVmL27Q0+qrz+hP//zqdBGbbJ+uzNBgJ5V5BhqgJJOJ2UIptyjV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881342; c=relaxed/simple;
	bh=UkVa6cmf3QGn7h3L7OioSsm6tUbCai0QK/j4KgC0qNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBFEWRO1eJ4XwQKgUjekw14v5iFBZOSPZGRfIGdprHJWnV3jWomWVqr9nAeanqJra3xVaO81oLaWG80YugoxhTyTd6690fplO0d0XdOdMa0z8+WGAlLwQtlIy2HIINhI92nPtsEitvi6Nb9nAEi46GVYnSg46NQzPA5r74ZOYDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eTA9qv/G; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTA9qv/G"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso54967315e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Mar 2026 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774881339; x=1775486139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OABjowBdKssAqbCjvzHnHU7J4j90A7eNOnV4X5RcKF4=;
        b=eTA9qv/G+r8NX0QjJ+L+MlMygPRWWvzjnXw6vM7FWuTC6H4qP1OyRM28sh85UNxVBh
         TkUO6jtZFr6EWmi3q2W/y0gyJK6n/LbVvoFiumTb5kfTBbnZlE85iqUOTkKxSgdemogQ
         v/pkdNRiBm4CcVAqbPYTX/A4ryd74QXC2D5ziqNmyYJqWtPCMAcHWVimDNMexcvHSZST
         uNoRp/IcjAbCZ8KLYPry4rgztBM6rY4/5b+1u83xl8vcKLTbsInMHYcybBluzKrzb/h4
         mQprIqRCVRcwYh06l2KRm3WS6AB6k6oQ14FUlpS6ffdU5UEQywmvhdEkkIIjLHi8zIps
         PBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774881339; x=1775486139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OABjowBdKssAqbCjvzHnHU7J4j90A7eNOnV4X5RcKF4=;
        b=BhK2CdqCDcB540KpVKYCaU5noDoPQnS9dyTv7KaBd7YSk2bt7m8/HbQeAsqcsANTXl
         U/zC2emw9+WjBwpTXqjChuZP+SOpGNyo4T1rTTKoWSkh/WZqtpU+ps0emfFN9GDsDSZy
         gVlWFv8vVAsb+RCauKNmTALHfV/KmscQa7M5ihCOhsfUQTV56lRGWPCDoW7cci/IN9Kd
         RvtSpyWiShiIxKWKghy02+cFNFHNCGKuuYX4mZfhfoY5u2MEqI2h0DArvsQ6/iZdmkHS
         9MHfoBGBGbb+Za//PvjIc4TqeAS7RW5nLLpJR3g3mjpYmYdlyLwN3lDBqbalpLOkIUNf
         6D6g==
X-Forwarded-Encrypted: i=1; AJvYcCUqiKdW+xlqbxCAecavXDPY+orokXDPZaKeCr1NxAqqKGxKozqbxkGyxVEsORCGoKoPo4BkHttaw9fP/nCb5NI9@vger.kernel.org
X-Gm-Message-State: AOJu0YwbF4kudq8z/KMmJRVK/lx8IZzgYTH8Xg4NMwali1U2rS77VaoS
	qDuQOUkAIhmnVSGIirdnVd1+p92ysi8gu43uQ7tnajman9F+st7u1AFpeK43ISROoQmZ/deaWPz
	JkSaO1NI=
X-Gm-Gg: ATEYQzyWJn79hl/RBclPD6EEuISReZOYWxl5jo8wRNuJQ5ZzjYUrIcMYRYF9RRMmn7t
	hbnUvdKAPTOrxO0W4eHUstwvNvWTuGWHzRsEn6v2tYCLG0O1DIVq9s0TE4+8Qf9M4Yzn3dNUWUy
	PZwVrsT+5+OMipFhCD9dlVQM2iIihxNmzSWCGj1x6xn3XNxDj+FHma0xJJ635U5SYVpQzdDvqsm
	llMTbIXqk7X3vp4LCbOI2IcPOFdt2NO8HEY0sfOlcM5hWQI/puDvMqxjMzZ3AHyEtHqabpXKtuM
	don/MNokyLbCTIz3xpiSq7gzxmtJ3UMPb+WcINEVrHbXXqizuUpis0cFURy9SR+sGiIAFyS5PBH
	mj+w6HNeoIy2c3wK4G5NdKjLyK7w+lgwlfSL5Gqv+0wl0i9e9FrE0L0Aomndi6pfv89ZLKUKenB
	6rOFNUrckep2OJbkCil2mtjac2dazb
X-Received: by 2002:a05:600c:8b63:b0:482:f564:d613 with SMTP id 5b1f17b1804b1-48727eafa46mr190145605e9.15.1774881339360;
        Mon, 30 Mar 2026 07:35:39 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873cd7d039sm70710925e9.15.2026.03.30.07.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 07:35:38 -0700 (PDT)
Message-ID: <3e218109-261d-4046-8cac-86aa1362ddda@linaro.org>
Date: Mon, 30 Mar 2026 15:35:36 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] perf sched stats: Add support for live mode
To: Swapnil Sapkal <swapnil.sapkal@amd.com>, Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, james.clark@arm.com, ravi.bangoria@amd.com,
 yu.c.chen@intel.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, rostedt@goodmis.org,
 vincent.guittot@linaro.org, adrian.hunter@intel.com,
 kan.liang@linux.intel.com, gautham.shenoy@amd.com, kprateek.nayak@amd.com,
 juri.lelli@redhat.com, yangjihong@bytedance.com, void@manifault.com,
 tj@kernel.org, sshegde@linux.ibm.com, ctshao@google.com,
 quic_zhonhan@quicinc.com, thomas.falcon@intel.com, blakejones@google.com,
 ashelat@redhat.com, leo.yan@arm.com, dvyukov@google.com, ak@linux.intel.com,
 yujie.liu@intel.com, graham.woodward@arm.com, ben.gainey@arm.com,
 vineethr@linux.ibm.com, tim.c.chen@linux.intel.com, linux@treblig.org,
 santosh.shukla@amd.com, sandipan.das@amd.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
 <20260119175833.340369-8-swapnil.sapkal@amd.com>
 <CAP-5=fXNtVXEjDD-euueztjO7vj+6LQ2CHgHfxVoHuRF2Nb0Xw@mail.gmail.com>
 <bda6c5d3-94cc-4f34-a3b6-b9a50c6b28e8@amd.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <bda6c5d3-94cc-4f34-a3b6-b9a50c6b28e8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/03/2026 10:08 am, Swapnil Sapkal wrote:
> Hi Ian,
> 
> Sorry for the delay.
> 
> On 04-03-2026 00:17, Ian Rogers wrote:
>> On Mon, Jan 19, 2026 at 10:02 AM Swapnil Sapkal 
>> <swapnil.sapkal@amd.com> wrote:
>> [ snip ]
>>> +       /* wait for signal */
>>> +       pause();
>>
>> I'm seeing the perf sched stats test hang here, requiring me to kill
>> the perf process started by the test. It is unclear what signal is
>> being waited upon, but is there a race condition where the signal
>> could have occurred before the pause? Should the pause at least be
>> conditional on that happening? Given that a race condition would exist
>> even with a test, would it be better to use a condition variable?
>>
> 
> I am able to reproduce the issue. There are other places also where the 
> same issue can be reproduced. (e.g. with `perf lock contention -b`)
> 
> I will propose a fix.
> 
>> Thanks,
>> Ian
> -- 
> Thanks and Regards,
> Swapnil

Hi Swapnil,

I'm also seeing the same issue, did you come up with a fix yet? I think 
checking the finish condition in a loop would work as long as it's 
sleep() instead of pause(). Or if you want to use pause() you have to 
mask the signals before launching and then do a sigsuspend() to unmask 
and pause atomically.

I was able to reproduce it every time by using the runs per test option:

   $ perf test -vvv -r 10 "perf sched stats tests"

Running multiple in parallel also showed another issue because the test 
writes to and deletes perf.data in the current working directory. 
Usually the tests do mktmp somewhere so they have a unique output dir to 
not conflict with other tests.

Thanks
James

