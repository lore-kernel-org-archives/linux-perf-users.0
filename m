Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBDE31065A
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Oct 2025 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759413950; cv=none; b=focRG7PlLEtoO+rnT8AchknPlsQJpkuFDGbpW/kVfT3TGmJzXU5Vo1/srdx1PkUub98CqALBeD61UVMDymB7Dtcs9DARBRYiBuU47J/ApFRu3L+dAXvx0WGBAUQGApuLijX2zl2C53fodBuhmjKce0aIRhX6MtbDK1FRHvYOrNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759413950; c=relaxed/simple;
	bh=75LIbBB37QFaxT2eyTrsBu/AXueOUheASWfjnj8iCE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WCnHY/MtMQpW9yaVye/fm9g2WpYI5BpG2qUzs8D0DEkcZ9rEcAYI1Jg0LbZRTPQZ3oKtUT70J/9gz0G256aAznLP8YiNIYnTighMDtc2vnP6lhSMnJ7W55c0KtMHYtaNJfPQS1TQpTP1ydZvr9y1MpYRClCgaLRTxGbVCdYWjxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zipFALvo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zipFALvo"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e6a6a5e42so4538145e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Oct 2025 07:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759413946; x=1760018746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Id2SYKp7S2R2M6h45vxI5qpqEhA5sCwnRttPXwVp7II=;
        b=zipFALvokpKe2uXbaJymr7+odRL8UjYSaQtlnzYoptYRo/z6uG/uru8PiXCnXoOWEX
         vFmZEq9oWyorqpYzERhVoWu8Ja85I/18Ebfny+NBqmedUyJS5D1+9a22pn2lA2zYZkpL
         i0FNYOWCTsgkcyQMR0forynM45+PzdezdiD2VFXWEw6lvKndaBJdMrFn5sQ/XFAsaOdR
         H7fPMSdYo4VtFdfaw1EKV+9/RknAaC+ia8JUGTaonEkniVmV3gRanpVojsSa00X/SrPt
         iH0OYj7i41HM9Z4p+xBraRtKLQCFWqkrzI1cHfc2fWDsFqWQ92hML7dgX0LsbPG5Q0Pa
         YgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759413946; x=1760018746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Id2SYKp7S2R2M6h45vxI5qpqEhA5sCwnRttPXwVp7II=;
        b=fveF8rLrtK4zYN6zU2gmbOOLETJNcaxKjUAeJLFG80WsmPkdz8J2Tw4WY/XFmv7NPc
         j576wagfGo+9Dz7JjqGDdfDm1MicPB0jlpelODW5bNA/TOv5cWX3rj8Bm9wVlH1xiPz4
         ZHUEyiMfCEPHg0lbHd4pAgVvvoJ/3nhhCim/Vwf2YuFB+bJ85c8m4JLXPM4tzqB1ua3E
         Rlj9WzEEL6jMHeFbH3/04RHJxjtttGdnMnJNqeIrtA6nByOVDuAI/4lxRlI5q0B7WuZN
         0Z0Kpi/f7L8yaCqwDNW7f5ZOOW4dRL9rZ3cWrldt+rwJqRpJv9TButKGMM7cgYgSE90O
         xx8A==
X-Forwarded-Encrypted: i=1; AJvYcCWHpY5U6x2CZVg1OKiEtBUp78yKG8+GcNGYiyTZA8mVO9SZQOrKWfQThWF/WWFII+EdzFP+YVsboxK+pzNPayiy@vger.kernel.org
X-Gm-Message-State: AOJu0YwuWiIszOIFxbE7aQzaPsNaX0acafvozhSxWVx86XlR/wYMLQzR
	bz/k68jIoqp/9e2JYbeMkYk2PnUskX89cRL03ERRyvSC+jeMK8UwFEzALbstMyH+yos=
X-Gm-Gg: ASbGncsTdS1NLUMrR8JcgVpQgsc3BuyaZzQ31IgU7M8K26F4Ko/AgFLfYJUuEqOT2I3
	oUAzJWa/sQ9IhnSrPqHJIq/6c5t67N1XBwbK+9yNfpIbj4DcE66JBe9S12NJcWpVMXixGeXkqKT
	/pR/NoDFegHJ/m0/MGJGS2zlBha6sNnKG4hUlcgBqeAgZw4BNxs5iyL2U3maHJKz1UgwKH/YzeL
	5lSPNCehLsh/H/2n/j8kM+IdqYrlEnNvBbICMwm5q4qRfbjHPn1EnpYh+sHom3hc+mCJdPUg287
	L/pT8TL9datzUQkn1Q339HNnMwN3QC/crMlskXsCjThaSnb65W30ilAod9jav1e8k4vBsOqN7ES
	BMRSXUk2d3oexHt6Hy7ihpvWEDNPVAat5y/641aTV4vWLxTEM21e0jdXyPwHy6WCFPK0=
X-Google-Smtp-Source: AGHT+IEMXgp8iNg22xXGy1qEl1NA6hE9HpYASa/mpzojPW6EVlsSSOvZB14q0p7F9EoXbEaKcb7RKA==
X-Received: by 2002:a05:600c:3d9b:b0:46e:4341:7302 with SMTP id 5b1f17b1804b1-46e612e6a49mr52465615e9.34.1759413945827;
        Thu, 02 Oct 2025 07:05:45 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e97f0sm3816560f8f.27.2025.10.02.07.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 07:05:45 -0700 (PDT)
Message-ID: <cf050a7f-b341-4e14-bc46-8bd30e366b19@linaro.org>
Date: Thu, 2 Oct 2025 15:05:43 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/28] Legacy hardware/cache events as json
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
 Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>,
 Leo Yan <leo.yan@arm.com>, Vince Weaver <vincent.weaver@maine.edu>
References: <20250923223312.238185-1-irogers@google.com>
 <ca47d298-331d-420c-8c4f-83cd29bae902@linaro.org>
 <CAP-5=fWUYH2eji2SNp37_2uHu55qEfRxuhhROYsMZeCixjda+g@mail.gmail.com>
 <CAP-5=fWUVycpDss_+MNQ_DM93AYKWED8aYOUBKLziYTOn68QJA@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fWUVycpDss_+MNQ_DM93AYKWED8aYOUBKLziYTOn68QJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 01/10/2025 9:55 pm, Ian Rogers wrote:
> On Wed, Oct 1, 2025 at 8:12 AM Ian Rogers <irogers@google.com> wrote:
>>
>> On Wed, Oct 1, 2025 at 6:38 AM James Clark <james.clark@linaro.org> wrote:
>>>
>>>
>>>
>>> On 23/09/2025 11:32 pm, Ian Rogers wrote:
>>>> Mirroring similar work for software events in commit 6e9fa4131abb
>>>> ("perf parse-events: Remove non-json software events"). These changes
>>>> migrate the legacy hardware and cache events to json.  With no hard
>>>> coded legacy hardware or cache events the wild card, case
>>>> insensitivity, etc. is consistent for events. This does, however, mean
>>>> events like cycles will wild card against all PMUs. A change doing the
>>>> same was originally posted and merged from:
>>>> https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
>>>> and reverted by Linus in commit 4f1b067359ac ("Revert "perf
>>>> parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
>>>> his dislike for the cycles behavior on ARM with perf record. Earlier
>>>> patches in this series make perf record event opening failures
>>>> non-fatal and hide the cycles event's failure to open on ARM in perf
>>>> record, so it is expected the behavior will now be transparent in perf
>>>> record on ARM. perf stat with a cycles event will wildcard open the
>>>> event on all PMUs, however, with default events the cycles event will
>>>> only be opened on core PMUs.
>>>>
>>>> The key motivation for these patches is so that if, for example, you
>>>> run `perf stat -e cpu-cycles ...` on a hybrid x86 and the results are
>>>> printed out with "cpu_core/cpu-cycles/" and "cpu_atom/cpu-cycles/",
>>>> the perf_event_attr for cpu-cycles and cpu_core/cpu-cycles/ be the
>>>> same, similarly for the cpu_atom event. Prior to these patches the
>>>> event with a PMU prefers sysfs/json over legacy encodings while with
>>>> no PMU legacy encodings are preferred - these are different encodings
>>>> on x86.
>>>>
>>>> The change to support legacy events with PMUs was done to clean up
>>>> Intel's hybrid PMU implementation. Having sysfs/json events with
>>>> increased priority to legacy was requested by Mark Rutland
>>>>    <mark.rutland@arm.com> to fix Apple-M PMU issues wrt broken legacy
>>>> events on that PMU. It is believed the PMU driver is now fixed, but
>>>> this has only been confirmed on ARM Juno boards. It was requested that
>>>> RISC-V be able to add events to the perf tool json so the PMU driver
>>>> didn't need to map legacy events to config encodings:
>>>> https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com/
>>>> This patch series achieves this.
>>>>
>>>> A previous series of patches decreasing legacy hardware event
>>>> priorities was posted in:
>>>> https://lore.kernel.org/lkml/20250416045117.876775-1-irogers@google.com/
>>>> Namhyung Kim <namhyung@kernel.org> mentioned that hardware and
>>>> software events can be implemented similarly:
>>>> https://lore.kernel.org/lkml/aIJmJns2lopxf3EK@google.com/
>>>> and this patch series achieves this.
>>>>
>>>> Note, patch 2 (perf parse-events: Fix legacy cache events if event is
>>>> duplicated in a PMU) fixes a function deleted by patch 17 (perf
>>>> parse-events: Remove hard coded legacy hardware and cache
>>>> parsing). Adding the json exposed an issue when legacy cache (not
>>>> legacy hardware) and sysfs/json events exist. The fix is necessary to
>>>> keep tests passing through the series. It is also posted for backports
>>>> to stable trees.
>>>>
>>>> The perf list behavior includes a lot more information and events. The
>>>> before behavior on a hybrid alderlake is:
>>>> ```
>>>> $ perf list hw
>>>>
>>>> List of pre-defined events (to be used in -e or -M):
>>>>
>>>>     branch-instructions OR branches                    [Hardware event]
>>>>     branch-misses                                      [Hardware event]
>>>>     bus-cycles                                         [Hardware event]
>>>>     cache-misses                                       [Hardware event]
>>>>     cache-references                                   [Hardware event]
>>>>     cpu-cycles OR cycles                               [Hardware event]
>>>>     instructions                                       [Hardware event]
>>>>     ref-cycles                                         [Hardware event]
>>>> $ perf list hwcache
>>>>
>>>> List of pre-defined events (to be used in -e or -M):
>>>>
>>>>
>>>> cache:
>>>>     L1-dcache-loads OR cpu_atom/L1-dcache-loads/
>>>>     L1-dcache-stores OR cpu_atom/L1-dcache-stores/
>>>>     L1-icache-loads OR cpu_atom/L1-icache-loads/
>>>>     L1-icache-load-misses OR cpu_atom/L1-icache-load-misses/
>>>>     LLC-loads OR cpu_atom/LLC-loads/
>>>>     LLC-load-misses OR cpu_atom/LLC-load-misses/
>>>>     LLC-stores OR cpu_atom/LLC-stores/
>>>>     LLC-store-misses OR cpu_atom/LLC-store-misses/
>>>>     dTLB-loads OR cpu_atom/dTLB-loads/
>>>>     dTLB-load-misses OR cpu_atom/dTLB-load-misses/
>>>>     dTLB-stores OR cpu_atom/dTLB-stores/
>>>>     dTLB-store-misses OR cpu_atom/dTLB-store-misses/
>>>>     iTLB-load-misses OR cpu_atom/iTLB-load-misses/
>>>>     branch-loads OR cpu_atom/branch-loads/
>>>>     branch-load-misses OR cpu_atom/branch-load-misses/
>>>>     L1-dcache-loads OR cpu_core/L1-dcache-loads/
>>>>     L1-dcache-load-misses OR cpu_core/L1-dcache-load-misses/
>>>>     L1-dcache-stores OR cpu_core/L1-dcache-stores/
>>>>     L1-icache-load-misses OR cpu_core/L1-icache-load-misses/
>>>>     LLC-loads OR cpu_core/LLC-loads/
>>>>     LLC-load-misses OR cpu_core/LLC-load-misses/
>>>>     LLC-stores OR cpu_core/LLC-stores/
>>>>     LLC-store-misses OR cpu_core/LLC-store-misses/
>>>>     dTLB-loads OR cpu_core/dTLB-loads/
>>>>     dTLB-load-misses OR cpu_core/dTLB-load-misses/
>>>>     dTLB-stores OR cpu_core/dTLB-stores/
>>>>     dTLB-store-misses OR cpu_core/dTLB-store-misses/
>>>>     iTLB-load-misses OR cpu_core/iTLB-load-misses/
>>>>     branch-loads OR cpu_core/branch-loads/
>>>>     branch-load-misses OR cpu_core/branch-load-misses/
>>>>     node-loads OR cpu_core/node-loads/
>>>>     node-load-misses OR cpu_core/node-load-misses/
>>>> ```
>>>> and after it is:
>>>> ```
>>>> $ perf list hw
>>>>
>>>> legacy hardware:
>>>>     branch-instructions
>>>>          [Retired branch instructions [This event is an alias of branches].
>>>>           Unit: cpu_atom]
>>>>     branch-misses
>>>>          [Mispredicted branch instructions. Unit: cpu_atom]
>>>>     branches
>>>>          [Retired branch instructions [This event is an alias of
>>>>           branch-instructions]. Unit: cpu_atom]
>>>>     bus-cycles
>>>>          [Bus cycles,which can be different from total cycles. Unit: cpu_atom]
>>>>     cache-misses
>>>>          [Cache misses. Usually this indicates Last Level Cache misses; this is
>>>>           intended to be used in conjunction with the
>>>>           PERF_COUNT_HW_CACHE_REFERENCES event to calculate cache miss rates.
>>>>           Unit: cpu_atom]
>>>>     cache-references
>>>>          [Cache accesses. Usually this indicates Last Level Cache accesses but
>>>>           this may vary depending on your CPU. This may include prefetches and
>>>>           coherency messages; again this depends on the design of your CPU.
>>>>           Unit: cpu_atom]
>>>>     cpu-cycles
>>>>          [Total cycles. Be wary of what happens during CPU frequency scaling
>>>>           [This event is an alias of cycles]. Unit: cpu_atom]
>>>>     cycles
>>>>          [Total cycles. Be wary of what happens during CPU frequency scaling
>>>>           [This event is an alias of cpu-cycles]. Unit: cpu_atom]
>>>>     instructions
>>>>          [Retired instructions. Be careful,these can be affected by various
>>>>           issues,most notably hardware interrupt counts. Unit: cpu_atom]
>>>>     ref-cycles
>>>>          [Total cycles; not affected by CPU frequency scaling. Unit: cpu_atom]
>>>>     branch-instructions
>>>>          [Retired branch instructions [This event is an alias of branches].
>>>>           Unit: cpu_core]
>>>>     branch-misses
>>>>          [Mispredicted branch instructions. Unit: cpu_core]
>>>>     branches
>>>>          [Retired branch instructions [This event is an alias of
>>>>           branch-instructions]. Unit: cpu_core]
>>>>     bus-cycles
>>>>          [Bus cycles,which can be different from total cycles. Unit: cpu_core]
>>>>     cache-misses
>>>>          [Cache misses. Usually this indicates Last Level Cache misses; this is
>>>>           intended to be used in conjunction with the
>>>>           PERF_COUNT_HW_CACHE_REFERENCES event to calculate cache miss rates.
>>>>           Unit: cpu_core]
>>>>     cache-references
>>>>          [Cache accesses. Usually this indicates Last Level Cache accesses but
>>>>           this may vary depending on your CPU. This may include prefetches and
>>>>           coherency messages; again this depends on the design of your CPU.
>>>>           Unit: cpu_core]
>>>>     cpu-cycles
>>>>          [Total cycles. Be wary of what happens during CPU frequency scaling
>>>>           [This event is an alias of cycles]. Unit: cpu_core]
>>>>     cycles
>>>>          [Total cycles. Be wary of what happens during CPU frequency scaling
>>>>           [This event is an alias of cpu-cycles]. Unit: cpu_core]
>>>>     instructions
>>>>          [Retired instructions. Be careful,these can be affected by various
>>>>           issues,most notably hardware interrupt counts. Unit: cpu_core]
>>>>     ref-cycles
>>>>          [Total cycles; not affected by CPU frequency scaling. Unit: cpu_core]
>>>> $ perf list hwcache
>>>>
>>>> legacy cache:
>>>>     branch-load-misses
>>>>          [Branch prediction unit read misses. Unit: cpu_atom]
>>>>     branch-loads
>>>>          [Branch prediction unit read accesses. Unit: cpu_atom]
>>>>     dtlb-load-misses
>>>>          [Data TLB read misses. Unit: cpu_atom]
>>>>     dtlb-loads
>>>>          [Data TLB read accesses. Unit: cpu_atom]
>>>>     dtlb-store-misses
>>>>          [Data TLB write misses. Unit: cpu_atom]
>>>>     dtlb-stores
>>>>          [Data TLB write accesses. Unit: cpu_atom]
>>>>     itlb-load-misses
>>>>          [Instruction TLB read misses. Unit: cpu_atom]
>>>>     l1-dcache-loads
>>>>          [Level 1 data cache read accesses. Unit: cpu_atom]
>>>>     l1-dcache-stores
>>>>          [Level 1 data cache write accesses. Unit: cpu_atom]
>>>>     l1-icache-load-misses
>>>>          [Level 1 instruction cache read misses. Unit: cpu_atom]
>>>>     l1-icache-loads
>>>>          [Level 1 instruction cache read accesses. Unit: cpu_atom]
>>>>     llc-load-misses
>>>>          [Last level cache read misses. Unit: cpu_atom]
>>>>     llc-loads
>>>>          [Last level cache read accesses. Unit: cpu_atom]
>>>>     llc-store-misses
>>>>          [Last level cache write misses. Unit: cpu_atom]
>>>>     llc-stores
>>>>          [Last level cache write accesses. Unit: cpu_atom]
>>>>     branch-load-misses
>>>>          [Branch prediction unit read misses. Unit: cpu_core]
>>>>     branch-loads
>>>>          [Branch prediction unit read accesses. Unit: cpu_core]
>>>>     dtlb-load-misses
>>>>          [Data TLB read misses. Unit: cpu_core]
>>>>     dtlb-loads
>>>>          [Data TLB read accesses. Unit: cpu_core]
>>>>     dtlb-store-misses
>>>>          [Data TLB write misses. Unit: cpu_core]
>>>>     dtlb-stores
>>>>          [Data TLB write accesses. Unit: cpu_core]
>>>>     itlb-load-misses
>>>>          [Instruction TLB read misses. Unit: cpu_core]
>>>>     l1-dcache-load-misses
>>>>          [Level 1 data cache read misses. Unit: cpu_core]
>>>>     l1-dcache-loads
>>>>          [Level 1 data cache read accesses. Unit: cpu_core]
>>>>     l1-dcache-stores
>>>>          [Level 1 data cache write accesses. Unit: cpu_core]
>>>>     l1-icache-load-misses
>>>>          [Level 1 instruction cache read misses. Unit: cpu_core]
>>>>     llc-load-misses
>>>>          [Last level cache read misses. Unit: cpu_core]
>>>>     llc-loads
>>>>          [Last level cache read accesses. Unit: cpu_core]
>>>>     llc-store-misses
>>>>          [Last level cache write misses. Unit: cpu_core]
>>>>     llc-stores
>>>>          [Last level cache write accesses. Unit: cpu_core]
>>>>     node-load-misses
>>>>          [Local memory read misses. Unit: cpu_core]
>>>>     node-loads
>>>>          [Local memory read accesses. Unit: cpu_core]
>>>> ```
>>>>
>>>> v6. Fix x86 hybrid mismatched number of evsels for the case a PMU is
>>>>       specified. Add patches to make failures in the parse-events test
>>>>       easier to diagnose. Reorder the perf stat default events patch to
>>>>       come earlier.
>>>>
>>>> v5. Add patch for retrying default events, fixing regression when
>>>>       non-root and paranoid. Make cycles to cpu-cycles test event change
>>>>       (to avoid non-core ARM events) the default on all architectures
>>>>       (suggested by Namhyung). Switch all non-test cases to specifying a
>>>>       PMU. Improvements to the parse-events test including core PMU
>>>>       parsing support for architectures without a "cpu" PMU.
>>>>       https://lore.kernel.org/lkml/20250923041844.400164-1-irogers@google.com/
>>>>
>>>> v4: Fixes for matching hard coded metrics in stat-shadow. Make the
>>>>       default "cycles" event string on ARM "cpu-cycles" which is the
>>>>       same legacy event but avoids name collisions on ARM PMUs. To
>>>>       support this, use evlist__new_default for the no command line
>>>>       event case in `perf record` and `perf top`. Make
>>>>       evlist__new_default only scan core PMUs.
>>>>       https://lore.kernel.org/lkml/20250914181121.1952748-1-irogers@google.com/#t
>>>>
>>>> v3: Deprecate the legacy cache events that aren't shown in the
>>>>       previous perf list to avoid the perf list output being too verbose.
>>>>       https://lore.kernel.org/lkml/20250828205930.4007284-1-irogers@google.com/
>>>>
>>>
>>> Hi Ian,
>>>
>>> Did you drop the change to ignore failures to open events in favour of
>>> switching the default from "cycles" to "cpu-cycles" instead? I'm trying
>>> to follow the changelog but couldn't see it.
>>
>> Hi James,
>>
>> your example is using `perf stat` whilst the behavior to ignore
>> failing to open events is for `perf record` and added in:

Oh right yeah I was getting record and stat mixed up.

>> https://lore.kernel.org/lkml/20250923223312.238185-6-irogers@google.com/
>> Changing the behavior for `perf stat` hasn't been in scope for making
>> the behavior of legacy events consistent in any patch series. The
>> whole '<not counted>' vs '<not supported>' vs an early exit is
>> something where not changing behavior has been the name of the game
>> for many years due to potential reliance on the behavior.

I don't see the exact issue here? v3 perf stat reported "<not 
supported>" for the uncore event, which is accurate, and continued on 
with the working event. Which seemed consistent with the change in perf 
record.

What use case would break exactly if we don't do the same for perf stat? 
If a user isn't specific about a PMU it should attempt to open wherever 
it can, if all fail then exit early.

>>
>> Fwiw, this series migrates legacy events to json we should be able to
>> do the same with the legacy hard coded metrics in `perf stat` once it
>> lands. Removing the hard coded metrics will give better metrics as we
>> can use event groups, share events between metrics, .. and only
>> display requested metrics when metrics are requested. My point is that
>> there is further `perf stat` clean up that this work moves us toward
>> but at 28 patches already I'd like not to start work on making perf
>> stat a better place. Getting consensus on what that better place is
>> given the existing fragmentic behavior will be a challenge, but at
>> least these days we have some form of tests, albeit they tend to flake
>> all the time. To solve your problems below where you're specifically
>> picking an event that can wildcard, give the PMU or use cpu-cycles, or
>> one of the many other names ARM already has to mean this. Overloading
>> the event 'cycles' wasn't something introduced in this series and the
>> fact changing the name hasn't happened in the drivers is really very
>> frustrating.
>>
>> Thanks,
>> Ian
>>
>>
>>> In v3 I got <not supported> for the uncore cycles event, but in v6 I get
>>> a complete failure:
>>>
>>>    -> sudo perf-v3 stat -e cycles -- true
>>>
>>>    Performance counter stats for 'true':
>>>
>>>              1732478      cycles
>>>
>>>      <not supported>      arm_cmn_0/cycles/
>>>
>>>
>>>    -> sudo perf-v6 stat -e cycles -- true
>>>    Error:
>>>    Invalid event (cycles) in per-thread mode, enable system wide with '-
>>>    a'.
>>>
>>> The verbose output shows that it tries both, but doesn't ignore the
>>> error on arm_cmn_0 anymore:
>>>
>>> -> sudo perf-v6 stat -e cycles -vvv -- true
>>> Control descriptor is not initialized
>>> Opening: cycles
>>> ------------------------------------------------------------
>>> perf_event_attr:
>>>     type                             0 (PERF_TYPE_HARDWARE)
>>>     size                             136
>>>     config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>>>     sample_type                      IDENTIFIER
>>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>>     disabled                         1
>>>     inherit                          1
>>>     enable_on_exec                   1
>>> ------------------------------------------------------------
>>> sys_perf_event_open: pid 9646  cpu -1  group_fd -1  flags 0x8 = 3
>>> Opening: cycles
>>> ------------------------------------------------------------
>>> perf_event_attr:
>>>     type                             11 (arm_cmn_0)
>>>     size                             136
>>> Required parameter 'wp_dev_sel' not specified
>>> Required parameter 'wp_dev_sel' not specified
>>>     config                           0x3 (cycles)
>>>     sample_type                      IDENTIFIER
>>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>>     disabled                         1
>>>     inherit                          1
>>>     enable_on_exec                   1
>>> ------------------------------------------------------------
>>> sys_perf_event_open: pid 9646  cpu 0  group_fd -1  flags 0x8
>>> sys_perf_event_open failed, error -22
>>> switching off exclude_guest for PMU arm_cmn_0
>>> Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit,
>>> falling back to no-inherit.
>>> Warning:
>>> cycles event is not supported by the kernel.
>>> Error:
>>> Invalid event (cycles) in per-thread mode, enable system wide with '-a'.
> 
> Re v3 vs v6:
> 
> v3 series here has no changes to perf stat:
> https://lore.kernel.org/lkml/20250828205930.4007284-1-irogers@google.com/
> the v6 does change perf stat in the "add_default_events" function:
> https://lore.kernel.org/lkml/20250923223312.238185-5-irogers@google.com/
> but you are reporting an issue with an event specified, so not using
> default events. The evsel changes in v6 are for the evsel__match
> function that isn't used during event opening.
> 
> Thanks,
> Ian
> 

Maybe there are no direct changes to perf stat, but the user facing 
behavior still changes. Now perf record ignores the bad uncore event, 
but perf stat doesn't, making it inconsistent. V3 was better in this regard.

I'm not sure if you are saying that you wouldn't expect there to be 
_any_ change to perf stat in V3? Or just that perf stat itself wasn't 
changed but things that it depends on were? I just want to make sure 
I've tested the right thing and we're talking about the same thing.

I double checked and rebuilt 20250828205930.4007284-1-irogers@google.com 
(v3) and still see the different behavior in perf stat that I posted above.

>>>
>>>> v2: Additional details to the cover letter. Credit to Vince Weaver
>>>>       added to the commit message for the event details. Additional
>>>>       patches to clean up perf_pmu new_alias by removing an unused term
>>>>       scanner argument and avoid stdio usage.
>>>>       https://lore.kernel.org/lkml/20250828163225.3839073-1-irogers@google.com/
>>>>
>>>> v1: https://lore.kernel.org/lkml/20250828064231.1762997-1-irogers@google.com/
>>>>
>>>> Ian Rogers (28):
>>>>     perf stat: Allow retry for default events
>>>>     perf parse-events: Fix legacy cache events if event is duplicated in a
>>>>       PMU
>>>>     perf perf_api_probe: Avoid scanning all PMUs, try software PMU first
>>>>     perf stat: Avoid wildcarding PMUs for default events
>>>>     perf record: Skip don't fail for events that don't open
>>>>     perf jevents: Support copying the source json files to OUTPUT
>>>>     perf pmu: Don't eagerly parse event terms
>>>>     perf parse-events: Remove unused FILE input argument to scanner
>>>>     perf pmu: Use fd rather than FILE from new_alias
>>>>     perf pmu: Factor term parsing into a perf_event_attr into a helper
>>>>     perf parse-events: Add terms for legacy hardware and cache config
>>>>       values
>>>>     perf jevents: Add legacy json terms and default_core event table
>>>>       helper
>>>>     perf pmu: Add and use legacy_terms in alias information
>>>>     perf jevents: Add legacy-hardware and legacy-cache json
>>>>     perf print-events: Remove print_hwcache_events
>>>>     perf print-events: Remove print_symbol_events
>>>>     perf parse-events: Remove hard coded legacy hardware and cache parsing
>>>>     perf record: Use evlist__new_default when no events specified
>>>>     perf top: Use evlist__new_default when no events specified
>>>>     perf evlist: Avoid scanning all PMUs for evlist__new_default
>>>>     perf evsel: Improvements to __evsel__match
>>>>     perf test parse-events: Use evsel__match for legacy events
>>>>     perf test parse-events: Without a PMU use cpu-cycles rather than
>>>>       cycles
>>>>     perf test parse-events: Remove cpu PMU requirement
>>>>     perf test: Switch cycles event to cpu-cycles
>>>>     perf test: Clean up test_..config helpers
>>>>     perf test parse-events: Add evlist test helper
>>>>     perf test parse-events: Add evsel test helper
>>>>
>>>>    tools/perf/Makefile.perf                      |   21 +-
>>>>    tools/perf/arch/x86/util/intel-pt.c           |    2 +-
>>>>    tools/perf/builtin-list.c                     |   34 +-
>>>>    tools/perf/builtin-record.c                   |   97 +-
>>>>    tools/perf/builtin-stat.c                     |  171 +-
>>>>    tools/perf/builtin-top.c                      |    8 +-
>>>>    tools/perf/pmu-events/Build                   |   24 +-
>>>>    .../arch/common/common/legacy-hardware.json   |   72 +
>>>>    tools/perf/pmu-events/empty-pmu-events.c      | 2771 ++++++++++++++++-
>>>>    tools/perf/pmu-events/jevents.py              |   32 +
>>>>    tools/perf/pmu-events/make_legacy_cache.py    |  129 +
>>>>    tools/perf/pmu-events/pmu-events.h            |    1 +
>>>>    tools/perf/tests/code-reading.c               |    2 +-
>>>>    tools/perf/tests/keep-tracking.c              |    2 +-
>>>>    tools/perf/tests/parse-events.c               | 2010 ++++++------
>>>>    tools/perf/tests/perf-time-to-tsc.c           |    4 +-
>>>>    tools/perf/tests/pmu-events.c                 |   24 +-
>>>>    tools/perf/tests/pmu.c                        |    3 +-
>>>>    tools/perf/tests/switch-tracking.c            |    2 +-
>>>>    tools/perf/util/evlist.c                      |   18 +-
>>>>    tools/perf/util/evsel.c                       |   21 +-
>>>>    tools/perf/util/parse-events.c                |  282 +-
>>>>    tools/perf/util/parse-events.h                |   22 +-
>>>>    tools/perf/util/parse-events.l                |   54 +-
>>>>    tools/perf/util/parse-events.y                |  114 +-
>>>>    tools/perf/util/perf_api_probe.c              |   27 +-
>>>>    tools/perf/util/pmu.c                         |  309 +-
>>>>    tools/perf/util/print-events.c                |  112 -
>>>>    tools/perf/util/print-events.h                |    4 -
>>>>    29 files changed, 4523 insertions(+), 1849 deletions(-)
>>>>    create mode 100644 tools/perf/pmu-events/arch/common/common/legacy-hardware.json
>>>>    create mode 100755 tools/perf/pmu-events/make_legacy_cache.py
>>>>
>>>

