Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB6D2DBF7C
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Oct 2025 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840491; cv=none; b=c07eK1VDTJmKl5GSE1kzw5e6+ZrmbzFZge4NutxemoLEVr1eXgmAynqbXAtsmwCVflnSAAhuKfx3eWcmMOfIYgfGSph1z6syffUzDHkRUft1zEb6JKrvuo1bEc2CPm7uWIacV5dTQtTZxOf6oRtunNHgr/y5gWDDx7asHXKAZ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840491; c=relaxed/simple;
	bh=K7HootoGsJoDCytEZbhrEIRHi1K8dNLAb4/ufI/qnWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DqAWhK2RvkcAtLJeXYPPD8UssP7/TL8IXDVHxQwIQaBqQgWHLZnFLZKMmwpJaFD3ztz2RUBzkmV7GJBsYAQlOYqaqZmuNlbPv6cuZ66b+rEz+unRqA4WvjwcurKRIQ9jcobIduikAiQuXB5gcA3ogqrcXpPYbQfzk3PPPnaS7A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IQ+6DY3O; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQ+6DY3O"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so48169555e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Oct 2025 05:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759840488; x=1760445288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mlMpRFESv4rtaqIC7khHxfBNOCJGnluYaphvkdManIs=;
        b=IQ+6DY3OHUJuUzejcC8KblO5Qd3EaZIxBEBt4BLd2ZOhKMbmP7GL5jL6+35QL1EN4V
         MSyLy+9/O3hxbL0/tKl15bsqL1X8n8a+0kEqjOWIw447RhMJksgA0sOGdcw6svW6A22x
         2IW7MQsBJlRI+/adrD9EfCZiQ90uWw117IKklT0N1NU43zPmAzpiCvdMaWyaLhdVkQTV
         YtoKjWqagyVhnc4OxtdWlgSgofIqdo7WT/FX2DQvrn6YOEFopl75DMmeyxZD4LP0oyxp
         qSveIEwVljiw9RpkEMe7hgdJnh2021lBAYehvgQotHTFlAFDL/NO1k9IT896EOCMnPBO
         jsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759840488; x=1760445288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mlMpRFESv4rtaqIC7khHxfBNOCJGnluYaphvkdManIs=;
        b=nz292SCDgTpbRbs0wry8/apcD1NgvGE8JphfaxCNc97CzRpnGXgdWMN4Wzi0L0MAuE
         nuT0oyHPuDj66mljDO657UgRzWU0jVjmKUg59ogCGn7P6RvVpmaas5HsOTkikQjrOKM8
         naOTDka2P8Oh3FvA+TUCk6S0Tn1qeqE7vRtQUABm5QCedshazzWuSMmhRHfC8fIrt4nv
         flKg1RDi2EXH0CqQHoSPup5QSd2l/Y2G/UtrR3wdBRlZzxtxcy/RfZU4DVHt2yrtR7ca
         tiVCQPvdZgz+J5YtZCJVDJ89gHbefWBV+mhuk2IgSuc+wckYqh8M39sS3RMXKfKg+BIo
         fiXA==
X-Forwarded-Encrypted: i=1; AJvYcCVWpS6gdbmXm7azctJ3/39ChxRXOaIVZQy+lbBfxzoE4jpW3hWn22rCXNAB8MzajqEyzz5K1kotZB90eAh0TK5E@vger.kernel.org
X-Gm-Message-State: AOJu0YxffsMnpjrMC/CrsSWyv7B8JVglR62RJ9ikfZppqx4dBkqEaTLB
	RXY87tgMubDL7KeeqRz3JKa0xFlgA9cYCyEMgdj0h9DrmgLYCtb0Hhxumec9XGzGzR4=
X-Gm-Gg: ASbGncuzqpe10SEPudXBNVKYlWmNAdTGd03tZFLrXFC71pFqcx5aDsOIRhhSevPmjhW
	pmlghAzvK+iTweT0/e28DgT28K/+VzTrBGVAEBVJCiflGgrPFA9mH2DwyCX8H7s1i0e1LCc2LzI
	T96sZyd6ktzawHmJuhCI3G/Mfr9NxhCYxgIVwi3rR1I3JfNh7n5yn5z7HfZYzxkxd10vT9lvb3Q
	9pKo/HugWCVdps6l2BM77r/g+WagIpWvkhVQg4ya3uhotJ4R/p1cMwl9jWg+pA9UMWg1o8ixsNz
	yoxU5RKbS0XwAg7HraThMPE8gXg+u16CxegrN/4604Bcz8o9waMMVCgTxRrm//yDyGcgNks8TTw
	1BWSML/NXXpjuR+gSLCePNxJ15P3W8EV7H1e1aM9ITXyjqqvj4CabvAWW
X-Google-Smtp-Source: AGHT+IEdq9klpaIcMnOinitXn3AkphWfbtMmEJdjRN6LHJgnvDptPdzK2zC2u4AyApf7Ti+eTPVVjg==
X-Received: by 2002:a05:600c:6094:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-46e710fff73mr120842315e9.5.1759840488096;
        Tue, 07 Oct 2025 05:34:48 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e72374ac5sm231512715e9.18.2025.10.07.05.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 05:34:47 -0700 (PDT)
Message-ID: <ff157071-e241-4b81-8241-cfd15e5705ef@linaro.org>
Date: Tue, 7 Oct 2025 13:34:46 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests record: allow for some difference in cycle
 count in leader sampling test on aarch64
To: Thomas Richter <tmricht@linux.ibm.com>,
 Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, linux-perf-users@vger.kernel.org, peterz@infradead.org,
 mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 dapeng1.mi@linux.intel.com
References: <20251001195047.541745-2-ashelat@redhat.com>
 <906a9e47-ec19-4897-bbc0-06101d7afd24@linux.ibm.com>
 <CA+G8DhL49FWD47bkbcXYeb9T=AbxNhC-ypqjkNxRnW0JqmYnPw@mail.gmail.com>
 <901d2d1d-647a-4a76-a0ee-d8a687ed3f85@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <901d2d1d-647a-4a76-a0ee-d8a687ed3f85@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/10/2025 6:47 am, Thomas Richter wrote:
> On 10/2/25 15:39, Anubhav Shelat wrote:
>> On Oct 1, 2025 at 9:44 PM, Ian Rogers wrote:
>>> If cycles is 0 then this will always pass, should this be checking a
>> range?
>>
>> Yes you're right this will be better.
>>
>> On Oct 2, 2025 at 7:56 AM, Thomas Richter wrote:
>>> Can we use a larger range to allow the test to pass?
>>
>> What range do you get on s390? When I do group measurements using "perf
>> record -e "{cycles,cycles}:Su" perf test -w brstack" like in the test I
>> always get somewhere between 20 and 50 cycles difference. I haven't tested
>> on s390x, but I see no cycle count difference when testing the same command
>> on x86. I have observed much larger, more varied differences when using
>> software events.
>>
>> Anubhav
>>
> 
> Here is the output of the
> 
>   # perf record  -e "{cycles,cycles}:Su" -- ./perf test -w brstack
>   # perf script | grep brstack
> 
> commands:
> 
> perf 1110782 426394.696874:    6885000 cycles:           116fc9e brstack_bench+0xae (/r>
> perf 1110782 426394.696875:    1377000 cycles:           116fb98 brstack_foo+0x0 (/root>
> perf 1110782 426394.696877:    1377000 cycles:           116fb48 brstack_bar+0x0 (/root>
> perf 1110782 426394.696878:    1377000 cycles:           116fc94 brstack_bench+0xa4 (/r>
> perf 1110782 426394.696880:    1377000 cycles:           116fc84 brstack_bench+0x94 (/r>
> perf 1110782 426394.696881:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
> perf 1110782 426394.696883:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
> perf 1110782 426394.696884:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
> perf 1110782 426394.696885:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
> perf 1110782 426394.696887:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
> perf 1110782 426394.696888:    1377000 cycles:           116fc98 brstack_bench+0xa8 (/r>
> perf 1110782 426394.696890:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
> perf 1110782 426394.696891:    1377000 cycles:           116fc9e brstack_bench+0xae (/r>
> perf 1110782 426394.703542:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
> perf 1110782 426394.703542:   30971975 cycles:           116fb7c brstack_bar+0x34 (/roo>
> perf 1110782 426394.703543:    1377000 cycles:           116fc76 brstack_bench+0x86 (/r>
> perf 1110782 426394.703545:    1377000 cycles:           116fc06 brstack_bench+0x16 (/r>
> perf 1110782 426394.703546:    1377000 cycles:           116fc9e brstack_bench+0xae (/r>
> perf 1110782 426394.703547:    1377000 cycles:           116fc20 brstack_bench+0x30 (/r>
> perf 1110782 426394.703549:    1377000 cycles:           116fc9e brstack_bench+0xae (/r>
> perf 1110782 426394.703550:    1377000 cycles:           116fcbc brstack_bench+0xcc
> 
> They are usual identical values beside one or two which are way off. Ignoring those would
> be good.
> 

FWIW I ran 100+ iterations my Arm Juno and N1SDP boards and the test 
passed every time.

Are we sure there isn't some kind of race condition or bug that the test 
has found? Rather than a bug in the test?

At least "This looks like the result of some hardware property of 
aarch64 processors" in the commit message can't be accurate as this 
isn't the case everywhere.

James

