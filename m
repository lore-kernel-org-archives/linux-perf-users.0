Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD40F2FBE14
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Oct 2025 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759326554; cv=none; b=Df8a466leLOEXUXXjC0RvOIftWaWdE/dbKQCJ0FnEiejLzxEyy2cO8N8n3vcMdtuUOtWarAE8HlDa1uJKjTOXiU4zwEC/bAyDWbb3J4R/g7pBBhk4zsEUgcTo7PfEwMSgzuoJ6wh1hTCBuz6Nfd01jMmjRimDWfrD32b2rKT3/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759326554; c=relaxed/simple;
	bh=oUMtdNZYK6Fyw7iywZcExti86DdeEspgiPN/lnLvNww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vyjc4lb2ADE8UhXPnOgqQB8gREg5HEB6u2O5ZwLYjlI8keyRCZj6tVvEOQN3g8grNNueOZpx76dRN6sTa/lB4KcPxcM+f/Hqq4FmQmMAqNK+RFVIg8LeftRYBYEQMdJF8eDgEUClyfduO31AEcPeabd9znW9yghgiEhTABoUE4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NlqwsgHc; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NlqwsgHc"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso6037741f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Oct 2025 06:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759326550; x=1759931350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aXTHbm1yGkE2/zORBswhWrACx80/EC1QRjdLtiEom4Q=;
        b=NlqwsgHc3VMPskc1Wanto0WarOUnYXNYz7//IivTe5CGIP4mmC2TSnWOgswNtDO70f
         KbKzT7Ry1DXR2LDvsQqsdYfh049PDvlA+vxxIhSBmNiFKG1JEp+IaIHoYl3EudEX9PfS
         AZQ4KDZuc+gTEENn5waj1QD7oBc19E1noskNsTWcFi1aIQ8rWeAbn/gqnVxxzInlXSz1
         lb0XnzsAKKMCZdmOL5PXXCJdilupD4/XOZUpfRuF+8LxJvMsTim3+xydxqxqaL09QDZG
         g8IGSo0jhktxodWxjac58td2ycXUYxgHApj8ckIKCaHqoBlubOGIsaNn5Wb3JoYl2ENW
         q9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759326550; x=1759931350;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXTHbm1yGkE2/zORBswhWrACx80/EC1QRjdLtiEom4Q=;
        b=C9+yleOpwvRa6uIJ+LKfcfivX3yjU/n2rv63xRq8bHO4hlSCV0jnoIKVic4e4D9ByC
         66H281sDq7VQyqw7T+JmSG6xDFWXK/Yfh9NtcOhGwYZEcuVt2tat1mPHC3yHetYIq7TQ
         bc1viqep6gAUt1Rq6mXf43up07VEiY8+z23LGVUkgSie/1son63WOZ86zbZw1Qz0XkME
         2RDrtzA7DlQcxK0ldL94uCeo2gs0cVcYOOth19VyZ+sRyZ1M3w/TmaehjMMjS5YntJLM
         EZUdD3YvvFGjs0LHFg5xP76/umh1W3ZRdIV+PwNLa5E8oR6xyQLafmda6MujgT5Mh44p
         o2yg==
X-Forwarded-Encrypted: i=1; AJvYcCWRtFnETAPkzN8nspyXzO0FFrmJX8v4AU4QaoE9uziBorCATKdE0TGVKuU+eSdPOXh4Rc8hnUsYScs4C4kTxEZc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9/xDt9xuBK7Wr9K9kjWhFKTqc2al6u3/dK0zmnWF31PzrFzn4
	9pIu1jaaYL0hKbDGmdFx05eYQN/9jFeINAb3tDKdMrhEPPGwd2SMYIaDEMG18Mxavq8=
X-Gm-Gg: ASbGncv8CM78rGGuyI5O9bT6ePVBuUuHZXaqGL9lKyxpiYGdgXFSZN13cc4iSU4cNef
	wQ2q5im11Ms4Vd2G9yisOQx4fUCVVP3Q9McxvT7PT8SYZYS2OOuvjYTffu3nlhe1E/EPyFIrEB7
	jseVYEbdliujytJGrylmWKjYeAENkExNE9d6mbP8o/BFOAqDeNaSDqKeZR0DR1PNVuTF4MGZMhU
	9d6obcbUl6LMnQmW/f5KP8+rE4JqseIh+3oNVcyz9WjxOnhwrR6qhZo4+at2Ynl/JmwXmb9Igmf
	wJ67nH3ShP76Fz/V4ydy2I+W6/bIHnt0FX9f19YBFx/FFc1edHTj8AlL2UDYWDy21CyBKyNTcUv
	IfBc1LbBjFW0SAN6jM8iYx4iz4jws5JJEyjc2UqP6BqcR3syUWPfK
X-Google-Smtp-Source: AGHT+IGLrHf4UIk1KWnOc/zaVSe2/+LGCHS141wLHD+2YH4GOoHIJk5yG2sHN2EHQfFgXGXp5sFacQ==
X-Received: by 2002:a05:6000:2001:b0:3ee:f10c:6baa with SMTP id ffacd0b85a97d-4255780b811mr2734622f8f.37.1759326550066;
        Wed, 01 Oct 2025 06:49:10 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-41f0c467ecasm14427731f8f.38.2025.10.01.06.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 06:49:09 -0700 (PDT)
Message-ID: <6baf0f01-a333-4bca-b39d-d01f8624e170@linaro.org>
Date: Wed, 1 Oct 2025 14:49:08 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] perf test: Extend branch stack sampling test for
 arm64 BRBE
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 "Rob Herring (Arm)" <robh@kernel.org>,
 Adam Young <admiyo@os.amperecomputing.com>, Will Deacon <will@kernel.org>,
 German Gomez <german.gomez@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
References: <20250813-james-brbe-test-v1-0-76a0144b73fb@linaro.org>
 <CAP-5=fXdFQCgeF5DRH=-cUErz2opU98H6u1cTTO3ZPJ7SMQfMw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fXdFQCgeF5DRH=-cUErz2opU98H6u1cTTO3ZPJ7SMQfMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/08/2025 10:38 pm, Ian Rogers wrote:
> On Wed, Aug 13, 2025 at 6:39 AM James Clark <james.clark@linaro.org> wrote:
>>
>> Refactor and add some extra tests for all platforms which were useful
>> when developing and testing the BRBE (Branch Buffer Extension) driver
>> [1]. Then lastly extend the test for new features which are BRBE
>> specific.
>>
>> Tested on the Arm FVP RevC model [2] and Intel Raptor Lake.
>>
>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=58074a0fce66
>> [2]: https://developer.arm.com/Tools%20and%20Software/Fixed%20Virtual%20Platforms
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 

Hi Arnaldo,

If you have a chance can you take this one please. It still applies 
cleanly to perf-tools-next.

Thanks
James

>> ---
>> James Clark (3):
>>        perf test: Refactor brstack test
>>        perf test: Add syscall and address tests to brstack test
>>        perf test: Extend branch stack sampling test for Arm64 BRBE
>>
>>   tools/perf/tests/builtin-test.c        |   1 +
>>   tools/perf/tests/shell/test_brstack.sh | 106 ++++++++++++++++++++++++++++++---
>>   tools/perf/tests/tests.h               |   1 +
>>   tools/perf/tests/workloads/Build       |   2 +
>>   tools/perf/tests/workloads/traploop.c  |  31 ++++++++++
>>   5 files changed, 132 insertions(+), 9 deletions(-)
>> ---
>> base-commit: 6235ce77749f45cac27f630337e2fdf04e8a6c73
>> change-id: 20250811-james-brbe-test-f5a20dffd734
>>
>> Best regards,
>> --
>> James Clark <james.clark@linaro.org>
>>

