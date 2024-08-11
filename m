Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA29EAC5;
	Sun, 11 Aug 2024 03:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723348381; cv=none; b=VLf7ThlrBR1RAPZuihA0Qo6TQ4cLOQFb/2vuh3WtnbRv+vJY4bQZoAwdDcdPYtCIG9C4B6ZjDc2+FO99Rf1Lttw+0YWENBmhWfemsfb+s77T1HGGprvrFJafwSupUY+y5ZzJTHVJF0i9pP7E0N6CBFlvqmXDTt+10qwtWKU07lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723348381; c=relaxed/simple;
	bh=vBmzwVO0mkzkIBgG3/PCFDwKtz21gQaF5AtUaaUZ2pE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GoOssz0MUYWBUiSIrFhVWDtF3SHSXwc2HjDIbVcnAYw+LRyYrPzzSuez0U8c0Ry0OMM08SJoRoRx1pKJ5f0rU5HujcIAd04v3ChxWVAzwnTuezP9roTusl099Q9va/aUrelfKALo4tJ3ifRIQbnOQtZ/NPI4kHbbHZ4mVEMTYOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXmsVZBV; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXmsVZBV"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70eae5896bcso3091223b3a.2;
        Sat, 10 Aug 2024 20:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723348378; x=1723953178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RdJG8hKTqnv7E9J4qtLFQGlZTULiT6h+FzDENLf5SHo=;
        b=eXmsVZBVL31Ey1GQ6QW0Er6z9wzyxauPQpKwqmV42DcKJGPRA+jZP0kINtXTlwPl5l
         yIqe6EkWpcO4O/+6Wy+uCaiGkkY42qjaE4az+3qgONGSCWtd77t11n+uLLbW5SUgTumD
         UVyrzZn+iwgW+AhViVTOSY0v06qAdu3h+iUD++MlDVwqZMOUIb8zrPyUW4LRu5k15954
         XdoODDjDffSrov1c14/xpVULrWhf55ySnyftSatC8TjWNGxH1AVl+AzwoZT4eLeHYJga
         QkM7C7L9LRxBa5OJ/EbbdI1XfTvEILMpUXkWHcOyaOTiezKlSPuZO5rl2eI6XJz48rfZ
         vKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723348378; x=1723953178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RdJG8hKTqnv7E9J4qtLFQGlZTULiT6h+FzDENLf5SHo=;
        b=WYKuS6IcB7yvUdtgCeG9Dg/OwY4g67hyfzI9F65j9QHMLPXsCGKGLgYJ7NgE6k8XAV
         n/7gdJCyD+6//XnjBhqkJo0NUjwJsHOjn61qZJU+VzawCwgR6E8nFMBWVLHGVoNzhuyO
         aHyTR8esDb6GZXg5a+05eVNavc0gZZet0MaAOMcGEVR9XQelxgbY7tCFv6LBGjH4ITig
         X8yIMJBcsvlTrOAm/msXEPdxZHVGID5wHHGkZDmpO9rKr1CDAbDllHHx0QKzwBrvdOHQ
         WaE1gnXwQQyB4GpfSCQHVOyquen3ZooOgHxLuUc4wV5PWMuXL+gz43cBJeJpepyhyBPE
         O6Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVrAc3PSkSHhhVKEzFp2uWgc4zjByWTnoBdKSdiGCeo6RgEN56yYGc7nhIDI4eiYne2W6kQgZ2rwHJ1gExG0LvKfE0dzLWCJtbKda5N8WMQmIlxiznGM+IGVfksKDfNfa8kubEci0lnN0F+eh6Erg==
X-Gm-Message-State: AOJu0Yw7GP20BFit4osl2DpRGj8U+ZtF+pnjGsX8MGDH1J8WGQ3YHPwv
	1HzHvqV2Vng3IgfvHMM5+sfMLvGaD2QmCyeSv7xRAYsOJ9EfQiO5
X-Google-Smtp-Source: AGHT+IGeCR7tCS+AYHJEbvX1MlEd7jEEGx4/snmN8pUVrWSCYrX5WNLCAq1x5T5e0MRzfX03+jEGYw==
X-Received: by 2002:a05:6a00:2d8a:b0:70d:33b3:2d7f with SMTP id d2e1a72fcca58-710dcab70ecmr7388601b3a.26.1723348378198;
        Sat, 10 Aug 2024 20:52:58 -0700 (PDT)
Received: from [192.168.1.3] (123-243-193-68.tpgi.com.au. [123.243.193.68])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbea2327sm1966642a12.79.2024.08.10.20.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Aug 2024 20:52:57 -0700 (PDT)
Message-ID: <f6aca7df-3fc6-4676-bb5b-cb15eba8f97c@gmail.com>
Date: Sun, 11 Aug 2024 13:52:50 +1000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] perf script python: Add the ins_lat field to event
 handler
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>,
 Paran Lee <p4ranlee@gmail.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240809080137.3590148-1-fzczx123@gmail.com>
 <ZrYbbZVE4BQ-oqba@x1>
Content-Language: en-US
From: Zixian Cai <fzczx123@gmail.com>
In-Reply-To: <ZrYbbZVE4BQ-oqba@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/2024 23:36, Arnaldo Carvalho de Melo wrote:
> On Fri, Aug 09, 2024 at 08:01:36AM +0000, Zixian Cai wrote:
>> For example, when using the Alder Lake PMU memory load event, the
>> instruction latency is stored in ins_lat, while the cache latency
>> is stored in weight.
>>
>> This patch reports the ins_lat field for Python scripting.
> 
> So, how did you test this? I tried:

This is how I tested it.

My machine is running 6.5.0-41-generic from Ubuntu 22.04 LTS, and I use OS's perf to record.

$ grep -m1 'model name' /proc/cpuinfo
model name	: 12th Gen Intel(R) Core(TM) i9-12900KF

$ perf version
perf version 6.5.13

$ perf mem record taskset -c 0-15 java -jar /usr/share/benchmarks/dacapo/dacapo-23.11-chopin.jar biojava
...
Using scaled threading model. 16 processors detected, 16 threads used to drive the workload, in a possible range of [1,unlimited]
Version: biojava 7.0.2 (use -p to print nominal benchmark stats)
===== DaCapo 23.11-chopin biojava starting =====
Processing sequences: 100%
===== DaCapo 23.11-chopin biojava PASSED in 7988 msec =====
[ perf record: Woken up 11 times to write data ]
[ perf record: Captured and wrote 3.530 MB perf.data (47646 samples) ]

$ ./perf evlist -v
cpu_core/mem-loads-aux/: type: 4 (PERF_TYPE_RAW), size: 136, config: 0x8203, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, enable_on_exec: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1
cpu_core/mem-loads,ldlat=30/: type: 4 (PERF_TYPE_RAW), size: 136, config: 0x1cd, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, inherit: 1, freq: 1, precise_ip: 2, sample_id_all: 1, exclude_guest: 1, { bp_addr, config1 }: 0x1f
cpu_atom/mem-loads,ldlat=30/P: type: 10, size: 136, config: 0x5d0, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, enable_on_exec: 1, precise_ip: 3, sample_id_all: 1, { bp_addr, config1 }: 0x1f
cpu_core/mem-stores/P: type: 4 (PERF_TYPE_RAW), size: 136, config: 0x2cd, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, enable_on_exec: 1, precise_ip: 3, sample_id_all: 1
cpu_atom/mem-stores/P: type: 10, size: 136, config: 0x6d0, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, enable_on_exec: 1, precise_ip: 3, sample_id_all: 1
dummy:HG: type: 1 (PERF_TYPE_SOFTWARE), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ADDR|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, inherit: 1, mmap: 1, comm: 1, task: 1, mmap_data: 1, sample_id_all: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1

$ ./perf script -g python

Add a new method to perf-script.py

def process_event(params):
    if "cpu_core/mem-loads,ldlat" in params["ev_name"]:
        print(params["sample"]["weight"], params["sample"]["ins_lat"])

$ ./perf script|grep ldlat=|head
         taskset  182628 247517.778385:          1  cpu_core/mem-loads,ldlat=30/: ffffb33a850078a0     40268100142 |OP LOAD|LVL L1 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  Addr               5              33               0 ffffffff8cc2ba08 [unknown] ([unknown])
         taskset  182628 247517.778409:          1  cpu_core/mem-loads,ldlat=30/: ffffb33a85007860     10268100142 |OP LOAD|LVL L1 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A                5              85               0 ffffffff8ce23476 [unknown] ([unknown])
         taskset  182628 247517.778431:          3  cpu_core/mem-loads,ldlat=30/: ffffb33a85007b78     10268100142 |OP LOAD|LVL L1 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A                5             163               0 ffffffff8d2061d0 [unknown] ([unknown])
         taskset  182628 247517.778444:          7  cpu_core/mem-loads,ldlat=30/: ffff90cf25b26280     10668100842 |OP LOAD|LVL L3 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A               96             120               0 ffffffff8dab2627 [unknown] ([unknown])
         taskset  182628 247517.778484:         23  cpu_core/mem-loads,ldlat=30/: ffffb33a85007cf0     10268100142 |OP LOAD|LVL L1 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A                5             218               0 ffffffff8cd96124 [unknown] ([unknown])
         taskset  182628 247517.778561:         39  cpu_core/mem-loads,ldlat=30/: ffffe271848b6600     20268100142 |OP LOAD|LVL L1 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  Data               5             111               0 ffffffff8cd948cc [unknown] ([unknown])
         taskset  182628 247517.778629:         50  cpu_core/mem-loads,ldlat=30/: ffffe27184b6d280     11868100242 |OP LOAD|LVL LFB/MAB hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A              71              73               0 ffffffff8cd94792 [unknown] ([unknown])
         taskset  182628 247517.778725:         67  cpu_core/mem-loads,ldlat=30/: ffff90c061ed6b48     11868100242 |OP LOAD|LVL LFB/MAB hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A             240             242               0 ffffffff8cf9785b [unknown] ([unknown])
            java  182628 247517.778886:         81  cpu_core/mem-loads,ldlat=30/: ffffe27184888430     4026a100142 |OP LOAD|LVL L1 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  Addr                  5              68               0 ffffffff8ce13245 [unknown] ([unknown])
            java  182628 247517.779164:         87  cpu_core/mem-loads,ldlat=30/: ffffe271bf9bca40     1026a100142 |OP LOAD|LVL L1 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A                   5              90               0 ffffffff8cd96387 [unknown] ([unknown])

$ ./perf script -s perf-script.py|head
in trace_begin
5 33
5 85
5 163
96 120
5 218
5 111
71 73
240 242
5 68

The output from the Python script matches the output of plain perf script output, showing both weight and ins_lat.

> 
> But in general try to provide the steps to show that the functionality
> that you are adding is actually working, making it easy for other
> people to try reproducing your results.

Will do for future patches.

> Thanks,
> 
> - Arnaldo

One thing I haven't figure out is that if I use perf I built from source, perf mem record doesn't seem to record the events for the Golden Cove P-cores.

$ ./perf version
perf version 6.11.0-rc2

$ ./perf mem record taskset -c 0-15 java -jar /usr/share/benchmarks/dacapo/dacapo-23.11-chopin.jar biojava

Using scaled threading model. 16 processors detected, 16 threads used to drive the workload, in a possible range of [1,unlimited]
Version: biojava 7.0.2 (use -p to print nominal benchmark stats)
===== DaCapo 23.11-chopin biojava starting =====
Processing sequences: 100%
===== DaCapo 23.11-chopin biojava PASSED in 7157 msec =====
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.251 MB perf.data ]

$ ./perf evlist -v
cpu_atom/mem-loads,ldlat=30/P: type: 10 (cpu_atom), size: 136, config: 0x5d0 (mem-loads), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, enable_on_exec: 1, precise_ip: 3, sample_id_all: 1, { bp_addr, config1 }: 0x1f
cpu_atom/mem-stores/P: type: 10 (cpu_atom), size: 136, config: 0x6d0 (mem-stores), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, enable_on_exec: 1, precise_ip: 3, sample_id_all: 1
dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ADDR|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, mmap_data: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1

I think the above recording issue is orthogonal to this patch, and possibly a result of running 6.11 perf userland on a 6.5 kernel.
