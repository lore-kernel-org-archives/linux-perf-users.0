Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28631207DF0
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Mar 2025 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339198; cv=none; b=jqViQ3g2HWLHFvD3EcycHJyyq8kdKfjpZvtP6y/ysX7o31lbjbxMkkJZutnTEqbd3nI+P3RaiFs0bDpos/AarTTkbUKJW7Rm+fLUQ3Xnv5yTqZfUVNH1gkSMMVsSwID6YhTgZ7l4d3IrPX1RRM5046QDKlX6hyJWnobk30fyXg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339198; c=relaxed/simple;
	bh=mmDJGlTiXfNeJMEuXKVI397heeQI8lNwD4tu96M9a9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvGEd+pfbFExdyq8lJhuG7jXUfsXRZuKh3pnIbJsDtsePDlw6QmQkpXeiboQ+nBTUurzmMA7aeDisnu/h+OirQ1vVrM7RS49mT4dFdomectQBX6wfqyqp/ErCpa4yxcinxxo0O7vwPy5fHwdVtcNVnxUWfAY1d6TKXcE2CrHLOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bNFzI++1; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bNFzI++1"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85b20330c0eso13831239f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Mar 2025 01:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741339195; x=1741943995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZsKZEMr3HHLvjCn4YoRhdUIIxvIOxDzrpOUWVftatik=;
        b=bNFzI++1qvgLg2R3nJqdUYVRLpcWA+H83tJclXa72NYrp+oGyzHGEUdgDES43/PWKf
         c56sk2TfmcA8YkdwlA+GFs6fLcKc0+XLk1LRCBbgjZuRL1/YxjIPj8VbX89E7LSPf+59
         Wed6SILuMBNuizfQGgjqOgTE6/ary3xOHJ5xGio1vMikfjUoUe6cwHJb9d2Aik76afgL
         gv0wJ1mNczi6rfJg6JHO53TMiOYQabe+n5QVinjlLMdA5dNzkLjfXMgkMCF2iib8ihwj
         au8A54FRifwAJLSZ2W8pKfxUKY0xkcWZTbFqTdrPRg/LlCey9YfoDo/yS621hrb8BU2u
         Wb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741339195; x=1741943995;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsKZEMr3HHLvjCn4YoRhdUIIxvIOxDzrpOUWVftatik=;
        b=iN79/xBS0BFbjH5RO3mcnq0Crx6IxpORymWm4K8Q1NqW+dqwag8zYg5hBM/9E23+oI
         eshrgh5/GPEwhRgbD05v8xgqOFmVn2TjUGXrjYqsQNoweYpKVzxZ3+x63PDlQDZfYyFF
         WjfWl76X74jBXZ8rJooQgcbZZJsbZUtouV2XsXlkiVkl/+1ThInFUakOaSPypEWR/A0X
         BzrERfV7Bl3lP37VEcFxWbCAhczh3mA9lugqphRvS2I4StaY55Cn9D7CcTdff1qjHokd
         oDCC7o/2wDPxOngI8T9FiIYnCFsQtFWKX377Svo4IigrFQEe9P6TGFVryqDz6OMxhNYG
         vnMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg8hfWa/88dcTmsvM4tmcSXtzsEIWpIA+k/XJN88CswzeN4jopPeY+RYVvn+NWvjN2g53ngjdit0jvRCebKhRX@vger.kernel.org
X-Gm-Message-State: AOJu0YyIkow40ZuiSypXr5SKdmQa5k1ZQNCmCQwtvC3Rr+DYqmQZPXN2
	9NkEN2DXc3GiM1NOGOCQKyKIduA4HhdkX4M2z57oKwJpcCk6g32BzrcDLKqBePs=
X-Gm-Gg: ASbGncvwEoxK17ToKvZH2WZjY8eDmAHKWVMRcek2jS8Hrd32TvuWF/XdlYXofmamXvA
	QZjUs4gmLmRdGcDHJFgXHtfs0NlNfhSJJVlBTKXzLKzUooVf7xwrOxQxkKH1tEsT1kcaU7BmwJn
	dslymNEB5R61YDz2ZsGkNtyPxFL0KlXl40vrfMgUqtjxRT2YcLI+6QCuxKRUvwLd0sYRbtGYE2r
	JaVcTVzBZ0fMlJlAnsGBAw6lW5jyvVhd7hEKy3HMRwXL5NmlKhoB9FpOV1V2yXmbXxquX8VtcH0
	04YJA4U2NO6L+eMHhbiW3XgQRGZD3DK59YKXYruXDsqd4k/hmgExTAnWCjAXpA==
X-Google-Smtp-Source: AGHT+IHYz1YNu90yzXHeRG9Cltgc3qDq8cWUxHoIVZOWm3IFTOEk9LCi5Cpyrkar83w7qV9HsmfOEw==
X-Received: by 2002:a05:6602:584:b0:855:9ba9:618 with SMTP id ca18e2360f4ac-85b0eb2db5fmr650176639f.8.1741339195150;
        Fri, 07 Mar 2025 01:19:55 -0800 (PST)
Received: from [100.64.0.1] ([170.85.6.166])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f20a008ffcsm822075173.101.2025.03.07.01.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 01:19:54 -0800 (PST)
Message-ID: <1198d3ac-d715-4f82-853e-bf9d0ad9dde7@sifive.com>
Date: Fri, 7 Mar 2025 03:19:52 -0600
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 0/7] perf vendor events riscv: Update SiFive CPU
 PMU events
To: Atish Patra <atishp@atishpatra.org>
Cc: linux-riscv@lists.infradead.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Ian Rogers <irogers@google.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-perf-users@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>, Adrian Hunter
 <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
References: <20250213220341.3215660-1-samuel.holland@sifive.com>
 <Z7ZLB-wZY9wTZSBZ@google.com>
 <CAOnJCUJYKkGXOJiLTnPOgPSnEiCeXFaoGQRiT5Au+rbvP1unZQ@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <CAOnJCUJYKkGXOJiLTnPOgPSnEiCeXFaoGQRiT5Au+rbvP1unZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Atish,

On 2025-03-01 3:21 AM, Atish Patra wrote:
> On Wed, Feb 19, 2025 at 1:27 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> Hello,
>>
>> On Wed, Feb 12, 2025 at 05:21:33PM -0800, Samuel Holland wrote:
>>> This series updates the PMU event JSON files to add support for newer
>>> SiFive CPUs, including those used in the HiFive Premier P550 board.
>>> Since most changes are incremental, symbolic links are used when a set
>>> of events is unchanged from the previous CPU series.
>>>
>>> I originally sent this series about a year ago[1], but received no
>>> feedback. The P550 board is now available (and I have tested this series
>>> on it), so it would be good to get perf support for it upstream.
>>>
>>> [1]: https://lore.kernel.org/linux-perf-users/20240509021531.680920-1-samuel.holland@sifive.com/
>>>
> 
> Tested the patches that are part of sifive's release tree for p550.
> Both perf stat/record seems to work fine
> for a bunch of events.
> 
> Based on that
> Tested-by: Atish Patra <atishp@rivosinc.com>

Thanks for testing!

> @Samuel Holland : perf report that the following two events are not
> supported on the p550 board.
> 
> cycle and instruction count:
>   core_clock_cycles
>        [Counts core clock cycles]
>   instructions_retired
>        [Counts instructions retired]
> 
> I assumed that these are raw events cycle/instruction retired events
> that can support
> perf sampling as well. Maybe I am missing something ? DT binding ?

perf is correct. Those two events are not supported on P550, only by the newer
cores (bulled-0d and p650). Yes, those are aliases of cycles and instructions
that were added to support sampling.

Regards,
Samuel

>>>
>>> Eric Lin (5):
>>>   perf vendor events riscv: Update SiFive Bullet events
>>>   perf vendor events riscv: Add SiFive Bullet version 0x07 events
>>>   perf vendor events riscv: Add SiFive Bullet version 0x0d events
>>>   perf vendor events riscv: Add SiFive P550 events
>>>   perf vendor events riscv: Add SiFive P650 events
>>>
>>> Samuel Holland (2):
>>>   perf vendor events riscv: Rename U74 to Bullet
>>>   perf vendor events riscv: Remove leading zeroes
>>
>> It'd be nice if anyone in the RISC-V community can review this.
>>
>> Thanks,
>> Namhyung
>>
>>>
>>>  tools/perf/pmu-events/arch/riscv/mapfile.csv  |  6 +-
>>>  .../cycle-and-instruction-count.json          | 12 +++
>>>  .../arch/riscv/sifive/bullet-07/firmware.json |  1 +
>>>  .../riscv/sifive/bullet-07/instruction.json   |  1 +
>>>  .../arch/riscv/sifive/bullet-07/memory.json   |  1 +
>>>  .../riscv/sifive/bullet-07/microarch.json     | 62 +++++++++++++
>>>  .../riscv/sifive/bullet-07/watchpoint.json    | 42 +++++++++
>>>  .../cycle-and-instruction-count.json          |  1 +
>>>  .../arch/riscv/sifive/bullet-0d/firmware.json |  1 +
>>>  .../riscv/sifive/bullet-0d/instruction.json   |  1 +
>>>  .../arch/riscv/sifive/bullet-0d/memory.json   |  1 +
>>>  .../riscv/sifive/bullet-0d/microarch.json     | 72 +++++++++++++++
>>>  .../riscv/sifive/bullet-0d/watchpoint.json    |  1 +
>>>  .../sifive/{u74 => bullet}/firmware.json      |  0
>>>  .../arch/riscv/sifive/bullet/instruction.json | 92 +++++++++++++++++++
>>>  .../arch/riscv/sifive/bullet/memory.json      | 32 +++++++
>>>  .../arch/riscv/sifive/bullet/microarch.json   | 57 ++++++++++++
>>>  .../arch/riscv/sifive/p550/firmware.json      |  1 +
>>>  .../arch/riscv/sifive/p550/instruction.json   |  1 +
>>>  .../arch/riscv/sifive/p550/memory.json        | 47 ++++++++++
>>>  .../arch/riscv/sifive/p550/microarch.json     |  1 +
>>>  .../p650/cycle-and-instruction-count.json     |  1 +
>>>  .../arch/riscv/sifive/p650/firmware.json      |  1 +
>>>  .../arch/riscv/sifive/p650/instruction.json   |  1 +
>>>  .../arch/riscv/sifive/p650/memory.json        | 57 ++++++++++++
>>>  .../arch/riscv/sifive/p650/microarch.json     | 62 +++++++++++++
>>>  .../arch/riscv/sifive/p650/watchpoint.json    |  1 +
>>>  .../arch/riscv/sifive/u74/instructions.json   | 92 -------------------
>>>  .../arch/riscv/sifive/u74/memory.json         | 32 -------
>>>  .../arch/riscv/sifive/u74/microarch.json      | 57 ------------
>>>  30 files changed, 555 insertions(+), 182 deletions(-)
>>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/cycle-and-instruction-count.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/firmware.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/instruction.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/memory.json
>>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/microarch.json
>>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/watchpoint.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/cycle-and-instruction-count.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/firmware.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/instruction.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/memory.json
>>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/microarch.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/watchpoint.json
>>>  rename tools/perf/pmu-events/arch/riscv/sifive/{u74 => bullet}/firmware.json (100%)
>>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/instruction.json
>>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/memory.json
>>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/microarch.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/firmware.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/instruction.json
>>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p550/memory.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/microarch.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/cycle-and-instruction-count.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/firmware.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/instruction.json
>>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p650/memory.json
>>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p650/microarch.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/watchpoint.json
>>>  delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json
>>>  delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
>>>  delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json
>>>
>>> --
>>> 2.47.0
>>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> 
> 
> --
> Regards,
> Atish

