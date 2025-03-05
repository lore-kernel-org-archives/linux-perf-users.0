Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD02505D2
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182263; cv=none; b=T1Zu5IOvOkLRcLPW15bfn/rlxtA9x0Asn23ypsX2sQTDr1eQbC8QSLScJ+x/p5iMJLLRayX9hofyhiLIdNjrsiZjSHe33HMPtckQPfzMtAAWg/g6Ag8RiFGsaRmfL/WRkNqdsYPUH/MjYa4rZIS7i+7Ixsaq0ZWhX46MS38z1aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182263; c=relaxed/simple;
	bh=xrrAddc0Dux542IExfOiJL20FzbLUh8sACsEll+OBQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=J5ibtI3ESFKkMuReclUh4Prrsu3v6S5XXb2+DUpslZuD+8k6mMqjgM7dneznxdUGYkcjKI9G/ZL2hgrY4U41j/qlMaSQzmrPDhvXBto5eAwmORajEwSKir2tUvmI3bq1QQlJxLPaIGREStY2Z6EtpMivxmikQGn0M7E66+BB8AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BkBtHD6j; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BkBtHD6j"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso3603838f8f.3
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Mar 2025 05:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741182260; x=1741787060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Yuyf18O1C9beAnXo5r2fUqE9fJzKJV0tNnseaOAJ1I=;
        b=BkBtHD6j60IDzu33eU+NVm/9jJSPtB5JKPUjFlnDy9wSCKQph1quInznsIyVl6+1y+
         ReukChC0MRf5f4Oat03PtE+shK2Z5TBO+pC6B9rHbtCu6iE4orAXyYYSsbBirAZQh2AE
         EJhkBH4q+EDi/hwnWxlQm8qmum+EQpyJI2Gk1vhEhc703OGsAAtb6tJrwutIjhALXiVJ
         vhL2l8VoVjCFPDgQgtEYY/A8i0EYP1vAQVdA7/1yD111QKofYoPBEX1E/SAxmLY0c1dA
         GdLg7DMt78AkHlIiS5WD0QgYIH2j7Iz/Kcw1xYNwHrTUxKsumU4yCC4WTi1BK5OjnGlA
         V9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741182260; x=1741787060;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Yuyf18O1C9beAnXo5r2fUqE9fJzKJV0tNnseaOAJ1I=;
        b=GildBV/AEZTi+5NdkuNyX3YzbxIzS5dpnLQ9NdBK27DXIEw1NqIWNEmJNqktaidmJU
         4UjGKWRM5TCTdeXS8gND/izMFervx45jnnwPGXEzYSx6OVQ1iQbEn/GcbITvqN0vbtKb
         GFJHncpojAu+/hzII+IdRoEzaeqnClTOh7xdYqj2x/drXg9cV6ETUUYIU/amO9HxmKUT
         aDrc+viFCKKEWIo1X7fOSGG6DKLkxOaWgHyxYGq1HTYSzF9Ot9YPg/tVGwAaxE7E/KwQ
         8COi25FiCGtU5jOef6Pqq02bhCzuCaWN5L/i+E8X4bMwzUnapx1p0wyM1+nIFcff4hc0
         WtaA==
X-Forwarded-Encrypted: i=1; AJvYcCUqKmtxReDsUarc2lSq+4AWIeEvdCQQL5eHxXA4t4nG5xzK7OnOm6Cpp1I11BdsvsF+AL1/37XasrI0RDdduFCV@vger.kernel.org
X-Gm-Message-State: AOJu0YyAebR7DWX4B6q4f81TfVtxHJWIftX9xaiBWaidBfQx3yfw8Z5r
	ekX8kEVb2OjeodFv4mop65f8HxxQQFxymwNlGrPPUI6pjuHnhj7+KCmVBUO4g48wJkWwHxoPPyX
	YZEw=
X-Gm-Gg: ASbGncvXVg0YlyLMRL/kvY8+YgaUX/bX6mcncTGgIu/Clyl33g39ICCmIL+CnaxLzr2
	gJFi/MlPRRfy6SK7w+c+W5jBm5HELw64aKys2gyhaqMt2mEQQOCZn1chrMwMDYyxjAbXGLS0W1W
	nC8qUwInF+cw+o1V0VUpKatpbgOfGyXjKLtCLXOCtAU/wT/FZ3mCuP5UVaBWu0xXI2tmDwKW4mH
	E7Kz3E3T5j7EScUT33kyFFN3MR+Tz80wqc0qNvMVb+bXepOecwz9h95P8n8HN6bCRumHrSdOJRx
	UfM64ugK62e6r1acLZjVjUHqY0w9apefvma7wufairVpV/FeS4Jer24=
X-Google-Smtp-Source: AGHT+IHMWvLxl1WDyzDe67fQu7NHQ3gH4J0xuhCCrvkx6C7VPkprgfxVwtlDiiEjL9nH+nz8AmxYVQ==
X-Received: by 2002:a5d:60cc:0:b0:390:fd23:c145 with SMTP id ffacd0b85a97d-3911f7bda8fmr2112624f8f.36.1741182259933;
        Wed, 05 Mar 2025 05:44:19 -0800 (PST)
Received: from [192.168.1.247] ([209.198.129.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd430c2e9sm17754905e9.33.2025.03.05.05.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 05:44:19 -0800 (PST)
Message-ID: <e2ea3776-12d2-41c2-9b7b-836c7c249c45@linaro.org>
Date: Wed, 5 Mar 2025 13:44:18 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] perf parse-events: Corrections to topdown sorting
To: Ian Rogers <irogers@google.com>
References: <20250305083735.393333-1-irogers@google.com>
 <20250305083735.393333-2-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Dominique Martinet <asmadeus@codewreck.org>, Andi Kleen
 <ak@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Thomas Falcon <thomas.falcon@intel.com>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250305083735.393333-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/03/2025 8:37 am, Ian Rogers wrote:
> In the case of '{instructions,slots},faults,topdown-retiring' the
> first event that must be grouped, slots, is ignored causing the
> topdown-retiring event not to be adjacent to the group it needs to be
> inserted into. Don't ignore the group members when computing the
> force_grouped_index.
> 
> Make the force_grouped_index be for the leader of the group it is
> within and always use it first rather than a group leader index so
> that topdown events may be sorted from one group into another.
> 
> Reported-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Closes: https://lore.kernel.org/lkml/20250224083306.71813-2-dapeng1.mi@linux.intel.com/
> Signed-off-by: Ian Rogers <irogers@google.com>

Testing on Arm seems ok, but presumably this doesn't change anything 
there because arch_evsel__must_be_in_group() is always false.

On x86 I ran into the topdown metrics not opening on cpu_core at all, so 
I'm not sure if I'm able to test that the original issue is fixed on my 
machine. From looking at the link the issue is that the ungrouped 
topdown event is "<not supported>", but I always see that regardless of 
grouping despite perf list saying it exists:

  $ perf list --unit cpu_core | grep -i topdown
   topdown-bad-spec OR cpu_core/topdown-bad-spec/     [Kernel PMU event]
   topdown-be-bound OR cpu_core/topdown-be-bound/     [Kernel PMU event]
   topdown-br-mispredict OR cpu_core/topdown-br-mispredict/[Kernel PMU 
event]
   topdown-fe-bound OR cpu_core/topdown-fe-bound/     [Kernel PMU event]
   topdown-fetch-lat OR cpu_core/topdown-fetch-lat/   [Kernel PMU event]
   topdown-heavy-ops OR cpu_core/topdown-heavy-ops/   [Kernel PMU event]
   topdown-mem-bound OR cpu_core/topdown-mem-bound/   [Kernel PMU event]
   topdown-retiring OR cpu_core/topdown-retiring/     [Kernel PMU event]
   topdown.backend_bound_slots
   topdown.bad_spec_slots
   topdown.br_mispredict_slots
   topdown.memory_bound_slots
        [TOPDOWN.MEMORY_BOUND_SLOTS. Unit: cpu_core]


  $ sudo perf stat -e topdown-retiring -- true
  Performance counter stats for 'true':
      <not counted>   cpu_atom/topdown-retiring/           (0.00%)
    <not supported>   cpu_core/topdown-retiring/


  $ sudo perf stat -e topdown-retiring -vvv -- true
Control descriptor is not initialized
Opening: topdown-retiring
------------------------------------------------------------
perf_event_attr:
   type                             10 (cpu_atom)
   size                             136
   config                           0xc2 (topdown-retiring)
   sample_type                      IDENTIFIER
   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
   disabled                         1
   inherit                          1
   enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 151404  cpu -1  group_fd -1  flags 0x8 = 3
Opening: topdown-retiring
------------------------------------------------------------
perf_event_attr:
   type                             4 (cpu_core)
   size                             136
   config                           0x8000 (topdown-retiring)
   sample_type                      IDENTIFIER
   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
   disabled                         1
   inherit                          1
   enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 151404  cpu -1  group_fd -1  flags 0x8
sys_perf_event_open failed, error -22
switching off exclude_guest for PMU cpu_core
Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, 
falling back to no-inherit.
Warning:
topdown-retiring event is not supported by the kernel.

