Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3192F4A00
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Oct 2025 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549951; cv=none; b=HrsTXdshXJkjF7waW7141WtjYQ2IF3VOI4rEM6Hyj8xOm7zcc5VC4xk4PsbycdaYJ+gcB3xjRl2D1LWRMmZ/ViZxFi2NxWovf9KS2nEQV+/p/7isWP/ib7Ja2hxcvDRE3lig+7ryW9NucgHxc6d6uaTNE0Hi8kMKrbfw2Axwlck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549951; c=relaxed/simple;
	bh=QqFjS0dofGd23R/Vl/Q9AbMhq0HpMlDoOWoGpFbXhOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=UnF4q0xgwblrTDr7xu/H8aoHOrWHhU7cl7Cn6k7gp6MUDU6Se77VoAUT/kClZhIv+Oh8npN5ZGbqbJnKQzTHZ+HIDHoKNeKTk7rk40kbRjzUNqSC8hNXNJP69Qn1Iu8Wr51FGLrlT0YHSGOWDiXVLIRsi2WpkbwTjlQwel2C9Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tkyeFNOh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tkyeFNOh"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so44138285e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Oct 2025 10:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760549946; x=1761154746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AxF13IYBqPGtR5vpSfjG+eCrKpOfLtPiG/9JvCrM9vU=;
        b=tkyeFNOhi0s2A/VVrwm6TCyxzNo6xWqdQ4huZO615R8SgpGbJX3p16R38dHpyCLNAh
         1ZsA1vCLJAnT3F+VOwBSHVa2TfTDNRKTdkNS2usWLUYhYcbWAok1y25WoZJqSeEbGlMi
         mnWyk/JmwQWGhZxFOQip4Ti/G5qKLSU6zaahWvcTs6vBE+LKjt4+fJsQZb3gMbNaA7wZ
         3HKQ4xR8+DvLzYQm+UtM0+Yi6OcKHUJDB9QmFFB2QF5UDx18P4lgSU84/5ar63h7j8y5
         IqJCE7qUis/6+W/4V4uB+BQI2GVdjgWZuhYnAS1X+VYLzhdRbFCEAvEgsSDcOjd5hMqx
         XJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760549946; x=1761154746;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AxF13IYBqPGtR5vpSfjG+eCrKpOfLtPiG/9JvCrM9vU=;
        b=bRlr1DuE9B5SpN0SfWCvxYYJED/aCn1XwvwbJXUNinGtVg3Y9ytkSaP7phJPhOwUyQ
         YyvXJ4ElsCioP/0wuL/FUoQ8QvDBaiX1AsuNFjvOthgZdKggBsrgD+JYmkp+hb4JVREX
         7GwkHrjzmZRaPlI2w332JgEFufzuGJqNAzSAY55M1ZlHyvYfqWDs4M4ce3mEVFK8qV/3
         F8E0r3hkhxtF2IbYa5konGHznm6DbT8iw9puIL1a2qTOVG0xVRi1AlXuVxeSQr3vj4Cp
         oUHFsyNXT8VOWY+v9qsP1KLm08mHYJjBXEZX3uaSDSKdE3iSQrEuzxvaJy0v5l0YEfyD
         AvhA==
X-Forwarded-Encrypted: i=1; AJvYcCWgT42JoKh/WYm7E3cib5DM6fStKWFXgFNMMbjEmxJvWzZgMzr3nzFQRD8c5aoO80caGBzGthwcIf3LFCSCeQC1@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb123Eg8rLg5JtHh4enQo17+9c+03TEl1SkusClqvTtqtHtnte
	YQ2ofJdoNJAKm4ji0fszhDmM0LH+lipEOFkRn/URGXtwYwk6x//cobnrF+z6199QEvo=
X-Gm-Gg: ASbGncsZkDlVC/i1FqiOsFLsPKrJfcL7Sja9/KsDFrOq1Bqx185SYftaESzn3PVr5H8
	UFbZIoBGVfdq3Xwe6PU5wbvKxJl6dqTf9izVCA90IkuM3UZF0lJPf0axamDKkQ4OQaJPYeU98fo
	3HGDm7HG4Zkg89tGjvUgDgjXfjYZmtp4Qw++YyB9I5RrWisp9AmT9+PZkuTv2CSAunesiZHZBzI
	1Grh/hjLBHO5EAJwkyItjtEAPG5H44qeRa82GHyL4OOZHTMcD1fjRUqfqIC1wtTbQIqUfdnfGkl
	rz+uxCc8Vn5e1A2h36IHM+05x1VFwuL/M4jA+Iz5I685qHaOubwejdaIO7bb/SBvNfsa9F95C21
	kXpYvhm3WMmEK8ZP8/qVCdG3P1iGQvTh6fbcq51ofG3uAuQNC0nCjdGvbOifgog==
X-Google-Smtp-Source: AGHT+IFpK9jgy1axnrHwt8bxNrIDpfIAGB6jxP21sfrlK0Qs+Bqe9AnJfPR/yP9WWp76Use+S0n0eg==
X-Received: by 2002:a05:600c:3e15:b0:471:a3b:56d with SMTP id 5b1f17b1804b1-4710a3b063bmr5658705e9.34.1760549945781;
        Wed, 15 Oct 2025 10:39:05 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb55ac08dsm302624115e9.13.2025.10.15.10.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 10:39:05 -0700 (PDT)
Message-ID: <a9f3b996-4fb4-463a-8392-16115862903a@linaro.org>
Date: Wed, 15 Oct 2025 18:39:04 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/27] Legacy hardware/cache events as json
To: Namhyung Kim <namhyung@kernel.org>
References: <20251005182430.2791371-1-irogers@google.com>
 <176054362630.22559.13423487878652916137.b4-ty@kernel.org>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
 Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>,
 Vince Weaver <vincent.weaver@maine.edu>, Ian Rogers <irogers@google.com>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <176054362630.22559.13423487878652916137.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/10/2025 4:53 pm, Namhyung Kim wrote:
> On Sun, 05 Oct 2025 11:24:03 -0700, Ian Rogers wrote:
> 
>> Mirroring similar work for software events in commit 6e9fa4131abb
>> ("perf parse-events: Remove non-json software events"). These changes
>> migrate the legacy hardware and cache events to json.  With no hard
>> coded legacy hardware or cache events the wild card, case
>> insensitivity, etc. is consistent for events. This does, however, mean
>> events like cycles will wild card against all PMUs. A change doing the
>> same was originally posted and merged from:
>> https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
>> and reverted by Linus in commit 4f1b067359ac ("Revert "perf
>> parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
>> his dislike for the cycles behavior on ARM with perf record. Earlier
>> patches in this series make perf record event opening failures
>> non-fatal and hide the cycles event's failure to open on ARM in perf
>> record, so it is expected the behavior will now be transparent in perf
>> record on ARM. perf stat with a cycles event will wildcard open the
>> event on all PMUs, however, with default events the cycles event will
>> only be opened on core PMUs.
>>
>> [...]
> 
> Applied to perf-tools-next, thanks!
> 
> Best regards,
> Namhyung
> 

Hi Namhyung,

I'm still getting the build failure that I mentioned on patch 5. This 
only seems to happen with out of source builds:

   $ make -C tools/perf O=../build/local/ V=1


   static const struct pmu_sys_events pmu_sys_event_tables[] = {
         {
-               .event_table = {
-                       .pmus = pmu_events__test_soc_sys,
-                       .num_pmus = ARRAY_SIZE(pmu_events__test_soc_sys)
-               },
-               .name = "pmu_events__test_soc_sys",
-       },
-       {
                 .event_table = { 0, 0 },
                 .metric_table = { 0, 0 },
         },
make[3]: *** [pmu-events/Build:54: 
/home/james/workspace/linux/build/local/pmu-events/empty-pmu-events.log] 
Error 1

Thanks
James

