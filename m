Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771633EA83
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688623; cv=none; b=odLgqTCEmh2SGygJFaYnEYC8e/AwT4gQALxK4nbhdCattTHZhADhiATygmY8jHaS13oaf1xgQXYghPpOQfWY7fORDGo7yJZF+Huvh6yRhoOoFzl81Y/WtWB7Z8lUfM+nHlXbhEYSZWm+Of3THbFxYqf851zhgYUYK1DtKv+fxEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688623; c=relaxed/simple;
	bh=FxBaun4pdZBHvxTC07nUwmAIP3SkrZPLSFgtzPq1s/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPXPZkoz1BybuNDAY0W8kmtzGVa0np2cypLvRfg0NtKrWjJY+8u6tT7jKN+cz3s+xEZzEGFSVqOs6iIbqxTncF+ijsdGRtCZshISduDAz/6Kyjch/by9PlFjnXL7B65BN5b4zQNt+aFNDcJjWLZ8uppsm+4MgCnTOf+VrdIpJw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vAdQyzKO; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vAdQyzKO"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3912c09bea5so4456927f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 03:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741688620; x=1742293420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EsUvKrN3lGeU7elQgnkz/2u+v24ACs6BvK1wOE/EzHM=;
        b=vAdQyzKOdlkCc/ktczYlbqQnXMKCTtzagTSNMZXYtMi9CGnmJWBYsJY3gUDvjN6UWa
         7hzatGL4115xwA11ZMh7xfd8b+ljjSBmV1zEmOa6gtxJpcIA2ODfAGGBK0Mx6SbJ8sf5
         oKKCUedKfXUJYg2PbTlIZ9ApuvVPmkFIK4gs0LGiNT2aPdXtH476NjVJl3jdqB/aV8CU
         CR3La58n2MfwbpPnDRMqvAUQddMTn0SdsiMVyH9ML2sFxTPs1Du1S2yVVyINiu6wdEvf
         AFsKP3Ex8NbQhI9kV6jbrrHjT9Tf2BJlGZBbizVwYFksP5kyMgA9UZ4VWtb/HPUz09p9
         cdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741688620; x=1742293420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EsUvKrN3lGeU7elQgnkz/2u+v24ACs6BvK1wOE/EzHM=;
        b=eEZKG1KzRUdZRYGiHxiE8mIRFPI3bHQSMTM6DSiOWgxRDrDBi2LkMDSKrjykE1lkf1
         71i6TqJIGM9Xy6RKLWhDwQiXntoEo2JxhXsCzBhe+ssOrlrNq4fAlzVJsvQ31b13tQHe
         K4c/Lu1NMZSQJUFEdeUEe4riEwIJC1QFqY7kRPRODDlKZYFLJeYLsV482OYMTKLzyNAi
         z88SjMS+/QVQMsztulgbbUkdCFZM1OsZ0r78q3sSMH9wv81UCCIz1s/IHYsDsnwcxGCg
         EevLvWFlXR+Xm/6TdilH/62P6DP2eTPNes0A/YIYuhVttrrZsUdMRK1wSVDgbgfMobrh
         pDJg==
X-Forwarded-Encrypted: i=1; AJvYcCWDek5AeQHXqVgHwpJejVhcRg1XrPlqJ3rBq34aTZTj7HodzfZ+yfXuPpvnN70vRIRPuFbES0STi5sIM1yzKngV@vger.kernel.org
X-Gm-Message-State: AOJu0YwI84oB9R2fxMvl+6BrPGMdq23gzgS+hkyxqJNTWMxNxVmO8/PZ
	5zjiFZmXD4e0Z9VPEpIMZV1+RIsncbtF3e3cYneBrIj6oecxegCfgMNTZfuUGWc=
X-Gm-Gg: ASbGncvWklH9/C7R3F3LNGaz25nGdnn6gLCw/O7f/HesQ2HYaMVD8ZdF7GGN0z4LAtz
	m4A39P0qqOtyuauZM7bE+OvSX8JbkGOguNOQkqbUIqszV2GQpd9oHCKBYcDgAh3MdRwJUbjDRqk
	RH97DJsL7UbBm/wbupyqiZz1dsSo3W52q16rhAdRMe7dRDJpfrB+nrYbVcMukUflh4Sk6rzlz4+
	Y6bCVq7Ds/PXxA6DNUBptDSlgoHrHgAxDbNSJrqh0fC0xjEKfrJAq58gn7JmAN14TDErlyJDbEb
	iQugc8lfpciEWig0dtPsZIU3HeO8qDMHNcqnTceWAUdurj3R8qmg
X-Google-Smtp-Source: AGHT+IGw1gF9spyhtTlh9lkRqWETxIRrNY+vCXx/sVLk+VCf9F3MBQY/Fg7L9o/CHmwi6Y/9q0AxqQ==
X-Received: by 2002:a05:6000:1f8c:b0:391:4835:d888 with SMTP id ffacd0b85a97d-3926bfe0777mr4064106f8f.42.1741688619690;
        Tue, 11 Mar 2025 03:23:39 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.65.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfad7sm17505438f8f.26.2025.03.11.03.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 03:23:39 -0700 (PDT)
Message-ID: <90aa918e-da55-4096-b964-dca9b4d044c4@linaro.org>
Date: Tue, 11 Mar 2025 10:23:32 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: perf: Live mode flamegraph recording results in segmentation
 fault
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 agerstmayr@redhat.com
Cc: David <davidzgumberg@gmail.com>, linux-perf-users@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>
References: <f3d4363e-1de6-4817-b45e-fb2a05f02723@gmail.com>
 <516dd4bb-c317-42ce-b539-92c6c1eabcbe@linaro.org>
 <Z89Z7zvqbKmc82gA@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <Z89Z7zvqbKmc82gA@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/03/2025 9:30 pm, Namhyung Kim wrote:
> On Mon, Mar 10, 2025 at 11:53:06AM +0000, James Clark wrote:
>>
>>
>> On 07/03/2025 4:25 pm, David wrote:
>>> I've reproduced this on recent versions of Debian, Ubuntu, CentOS, and
>>> Fedora,
>>> and I used to be able to downgrade perf and it would work, but an early
>>> enough
>>> version of perf is no longer available from most package repositories.
>>>
>>> Steps I have taken to reproduce:
>>>
>>> 1. Install perf from a distro package manager. ( `sudo dnf install perf`)
>>>
>>> ```
>>>    $ perf --version
>>>
>>> perf version 6.13.5-200.fc41.x86_64)
>>> ```
>>>
>>> 2. Attempt a live flamegraph report:
>>>
>>> ```
>>>
>>> $ perf script flamegraph ls
>>> /usr/libexec/perf-core/scripts/python/bin/flamegraph-report: line 3:
>>> 1644 Segmentation fault      (core dumped) perf script -s
>>> "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
>>> ```
>>>
>>>
>>
>> Hi David,
>>
>> Are you able to bisect this to find the breaking commit?
>>
>> Is this the full output you get? I'm not able to reproduce your exact issue.
>> I do see a bug with the template download prompt but it produces more output
>> than you have:
>>
>>   $ perf script flamegraph ls
>>
>>    Warning: Flame Graph template '/usr/share/d3-flame-graph/d3-
>>    flamegraph-base.html' does not exist.
>>    [...]
>>    s = input("Do you wish to download a template from cdn.jsdelivr.net?
>>    (this warning can be suppressed with --allow-download) [yn] ").lower()
>>    OSError: [Errno 9] Bad file descriptor
>>    Fatal Python error: handler_call_die: problem in Python trace event
>>    handler
>>    Python runtime state: initialized
>>
>>    Current thread 0x00007d1916afd400 (most recent call first):
>>    <no Python frame>
>>
>>    Extension modules: apt_pkg (total: 1)
>>    Aborted (core dumped)
>>
>> But if I avoid the record/report wrapper and go straight to the script it
>> works:
>>
>>    $ perf record -g ls
>>    $ perf script flamegraph.py
>>
>>    [...]
>>    Do you wish to download a template from cdn.jsdelivr.net? (this
>>    warning can be suppressed with --allow-download) [yn] y
>>
>>    dumping data to flamegraph.html
>>
>> I'm wondering if the template prompt ever worked in conjunction with the
>> wrappers? Maybe they were only tested with the template already installed,
>> or the script was always used directly when the need for a template was
>> added.
> 
> I don't know but it didn't work well for me too.  Maybe it should have
> default 'y' for live mode.
> 
> Thanks,
> Namhyung
> 

Looks like this bug was discussed previously here [2].

And the issue about shipping vs downloading here along with prompting on 
the original change [1]. But considering the following I think it's 
worth bringing it up again:

  * We download a fixed version (rather than latest)
  * The contents are hash checked so are fixed for that reason too
  * We know network requests should be avoided (so prompt for input)
  * The packaging request didn't go anywhere

In light of all of the above what's the difference between downloading 
it vs packaging it into Perf? It has an Apache licence, but I'm pretty 
sure it's separate enough for that to not be an issue.

One argument was that it's a minimized blob, but only the .min.js is. 
The unminimized version is available too.

[1]: 
https://lore.kernel.org/lkml/928c76bf-39bc-cbc0-373e-70c5561cd5b0@redhat.com/T/#mf0942ae7abc78882c9b10b1c1f18a119393e3e2b

[2]: 
https://lore.kernel.org/all/CAP-5=fW+jpi_iLCrpA2GeEQBzNYASF52qrX7ExrSNL82uaDREQ@mail.gmail.com/

