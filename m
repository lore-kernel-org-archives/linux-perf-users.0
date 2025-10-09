Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650A72EB84B
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021999; cv=none; b=VrXQaf84ABpjpQZVyNKURZTSviCVjSv85FtRB3KugYlUwkwmTQ70V5r6YjKToXtODG/kDR4W+Dx6+wqFewJeJ0p9zDZoU75mQHn29H1nO/h815iYNr248Y0C3UpEwmciSp/N9ZWdfOm6H61zRlx22fX5w/IJwdjZvImvGDDnKcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021999; c=relaxed/simple;
	bh=L2Lo8kSdfBMnkNRq8XbcHS67JmwwIk/FQgvWpO5WtMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frDfyOYog0iHwOMR0tmPjOTohD0rogHeLncyuoorm5s9WnO01Kd4h+0s1oblt+WUpRSIGEVqb9qI2rA82fMfJMFAHnXcZm8fSZ52v5qD7KwdaTrO2X0K70UYgEV3tXMX8ZFPNhtB4m2rbjZlAahibz8Ez70j09CAvoM2IRnAK2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WzQ2hniD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WzQ2hniD"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e4473d7f6so6705195e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Oct 2025 07:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760021996; x=1760626796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=10iT2oO+cEU1+lBYpHWczzbKaaulijrdCRW16Z1Rnx8=;
        b=WzQ2hniD+oBsCVLh8Pzq53BAaK9JHKXoirfbrUM1jR6FqEZEDovSeZXLYmeE5oQsWI
         xTFdQIxU8YkpyTOMNliRqdZTMNZVK90z1PXenLaPw2+rE6I0W2Yuwm6Qpz+iUkE6uddd
         YNlwa4DIJIv4fRfcuc+TJYZDBo6Tf/Pn9XfZsZeu7iHzFDOvp5XLbCSUE85qcFC5K+w3
         adDLFm6qak39ktqkA0pgnpHTNPQ6pyKOv4S5orV6vBjw4tkkg1QjqpWPgkaTXU7feTj/
         m1NHhXQORX3pPk9P7EQyrQagmSEYk9amKLXXNSy/Ds3mnx9kB1YpsfO9Y1bAISbRCe45
         LkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760021996; x=1760626796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10iT2oO+cEU1+lBYpHWczzbKaaulijrdCRW16Z1Rnx8=;
        b=f7Hq228YWefqhaAp3Q36gJz9yVqE7EXSkWZ3mcjPEVOf635vx+plMC9E3zK/YrnjqB
         xd2YNcIOcqt4xGWOpDFhgEYu/J/XMTAO9h9hUIhRZ37fj1qCQKPdFNBAJ7wuhk5EiHzN
         juHuNrnZ5P3qIsPVEDantRozgGzSC6E9RLf20KKOyUOgxz8DtOsw2AzjBH4Q2BvVIdxl
         kYMvT34BmToyMMWjvBiTagu5B8945jF6r/pbzLyCcN9px69MjzGUHFmIo+J13k/AGCfa
         auImhJp2N98lT0eEghXGjDp408PObxeupHDRwFPfYXJenEz5LiJZlo6j1aZsZI08My04
         vrJw==
X-Forwarded-Encrypted: i=1; AJvYcCUJRu297DplwN1G/q9Z0DW1FlhZO2f6zC89mPPLOJjSlOajWibR2Hr+uLoz3sXWhPGif69VM1o83rSQ9T8inbsX@vger.kernel.org
X-Gm-Message-State: AOJu0YwTBCdUrNWHP6L9LYsozr/MpiG8IYtYYFjFuZfH9FX5AOONBwR2
	EYUWo21xwoZvb/Y2EcHL8cDmYpSfQjoEUTuMFCjWCj9oUiED2M6IBc9C+50mqj5/Dqg=
X-Gm-Gg: ASbGnctZAOUjIF6i/87+It2cqBKfAPbB00t+sLGSzMxIspU8T2OF59YKEH9Txj1qpoQ
	6gmzcOPloPk419rE5cbJ1qmKnVsqzK+a+pPhLS6hsvcjb9v9+0N5rZgGJdvbpImp32nZCLkQYac
	2SNIxbLraixn1mOXxkjaonXlTXAxXwZhickii+Nbr30hhiPWmsoJkZqZLBGaDxj9smeDWearzDs
	YC+jJ8gDmAZLbhLsmoD3ZvleTmELbn1o5UgEBmDKnSA0oqLHtJvgrJh8B9ni8kwdLaBMS72NXcm
	yFJoBmftSejCwuH59rViKI+tkcrOpjh+DMUcDTcZcGsz1YRj4Saoa5SOaGd6+Fv5RShxzPObiwg
	YJvG8ahmyDv7Foqety1hQrb4RIrd2BVPnXiW0gfL1QOaPKzL9FWmkIqZg4jt4CLI90l8=
X-Google-Smtp-Source: AGHT+IGbguFErndnoTwqRl4rWZZWS65OJ9VHr1os7pR1Zp7kyGEsQwEzaK2RUNAV2tBsFHsjvVsISQ==
X-Received: by 2002:a05:600d:420d:b0:45d:cfee:7058 with SMTP id 5b1f17b1804b1-46fa9af9041mr53862665e9.22.1760021995707;
        Thu, 09 Oct 2025 07:59:55 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482ca80sm1473375e9.10.2025.10.09.07.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 07:59:55 -0700 (PDT)
Message-ID: <58801744-44e4-4182-ab4e-bfcf8e2bfc69@linaro.org>
Date: Thu, 9 Oct 2025 15:59:54 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests record: allow for some difference in cycle
 count in leader sampling test on aarch64
To: Anubhav Shelat <ashelat@redhat.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, Namhyung Kim
 <namhyung@kernel.org>, mpetlan@redhat.com, acme@kernel.org,
 irogers@google.com, linux-perf-users@vger.kernel.org, peterz@infradead.org,
 mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 dapeng1.mi@linux.intel.com
References: <20251001195047.541745-2-ashelat@redhat.com>
 <906a9e47-ec19-4897-bbc0-06101d7afd24@linux.ibm.com>
 <CA+G8DhL49FWD47bkbcXYeb9T=AbxNhC-ypqjkNxRnW0JqmYnPw@mail.gmail.com>
 <901d2d1d-647a-4a76-a0ee-d8a687ed3f85@linux.ibm.com>
 <ff157071-e241-4b81-8241-cfd15e5705ef@linaro.org>
 <7a03fb30-87f9-4737-b59a-9f977acc7549@linux.ibm.com>
 <296700d2-878b-4eeb-b8cd-0252b2f92479@linaro.org>
 <CA+G8Dh+Odf40jdY4h1knjU+3sSjZokMx6OdzRT3o9v1=ndKORQ@mail.gmail.com>
 <CA+G8DhKDvkojDnwxXKe1iiLWwJ0uwD62-qc4_sJgBDdS+qLu-g@mail.gmail.com>
 <f4eba834-e45c-4eba-9650-5b6720fcd30f@linaro.org>
 <CA+G8DhKQkTKoNer5GfZedPUj4xMizWVJUWFocP2eQ_cmPJtBOQ@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CA+G8DhKQkTKoNer5GfZedPUj4xMizWVJUWFocP2eQ_cmPJtBOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09/10/2025 3:43 pm, Anubhav Shelat wrote:
> The first machine was running kernel 6.12.0-55.37.1.el10_0.aarch64 on a KVM
> virtual machine.
> The second machine was running kernel 6.12.0-119.el10.aarch64 also on a KVM.
> 

That's quite old. Make sure you test on the latest kernel before sending 
patches. The tests in mainline should be targeting the latest kernel, 
especially in this case because the throttling fix didn't have a fixes 
tag so won't be backported.

That change to fix throttling and group sampling is only from v6.16.

Also what hardware is the VM running on?

> On Thu, Oct 9, 2025 at 3:17 PM James Clark <james.clark@linaro.org> wrote:
>> After reading that patch it seems like we should actually be removing
>> the 80% tolerance from the leader sampling test. Both instances of the
>> cycles counts should be the same now.
> 
> If there's no tolerance then the leader sampling test would fail much more
> often. In most of the runs there's at least one case where the leader event
> has much fewer cycles.
> 

That's assuming that we've agreed that any difference in cycle counts is 
expected and valid. I don't agree that's the case yet and I think it's a 
bug. I only see identical counts, and the commit message in Kan's fix 
describes that the values should be the same for all architectures.

>> (Excluding s390) I'm starting to think you were hitting this bug on an
>> older kernel? Or something else is going wrong that we should  get to
>> the bottom of. The test could have found something and we shouldn't
>> ignore it yet.
> 
> I agree that the first bug I mentioned might be from an older kernel, but
> there's still the case here where the cycle counts don't match. I'll keep
> looking into it.
> 
> Anubhav
> 

