Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2936134A8;
	Tue, 10 Sep 2024 03:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725939377; cv=none; b=mdvm9PfNXnUqFlUacp4G3XveHU9Px384Td+fG0JdLJ3GhEZV/dES2NTT9/2G9BlBQlNpjQSXWUsPPonp+PUPlbjxg7++5yEiVIRCEujHHvMZjw51V6Lne8pPYaVwhTbP9mHgf630PYEVch1Qzk6icgh3T62tDbOYh48edjSqZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725939377; c=relaxed/simple;
	bh=+XjIvwC1nYye6+Aur6kAtVpIKnaRUrf+x+rirubKnOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oLWVyFoz9lwr9zTWLq73X+Ig+Aa0fAr+APKEBOl4lo7l24rTO6XPC5D+WiHlB5Wq0JdzL8/bSWz93BN/3tljUQZiea0lDNeN3mcwyvIgRJF4oBJMWvlj4VAmexyugRVHkj8k70rLEgXyZDExqiC4GAMMA/W8P11M1Ce+M0kRieI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRZy+fgl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRZy+fgl"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-718f28f77f4so333301b3a.1;
        Mon, 09 Sep 2024 20:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725939375; x=1726544175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ycTE8+/JU0ozVfwLfJkVUkbDQjHqEmfJiIS4bw0m4rI=;
        b=ZRZy+fgl7ceK9hlX3TLH7WOXpiLVtOcmovAH7OvV0XczAiJkTulJ4bLxQ8ZERJ1v4W
         Pqd4vlLVZqPCKaWHIvBPg+mqXblDuZImoiQ9vTd8rBP6F556UcmOYf3rereMQyolTzru
         24e/661lLD18ZBJ2hnikmmQ5aoZNW/OTggUVN7mm5YPWTY5XT17s3DDc6hqBcEnQE6GG
         ojYEStypZsHXyvejc+8D9pK4pkjhHdNnJsCh40JzVS/hGgcUowaUGy7KbnqEyyKaVrIj
         fExtGPKtGyZw0kVO6A2pyI5MIvGb7IiCQJFZULYVX3MjmltEi5Q5FfDM0/Wcqpo1rL2U
         Y5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725939375; x=1726544175;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycTE8+/JU0ozVfwLfJkVUkbDQjHqEmfJiIS4bw0m4rI=;
        b=aPJgQVGItKnpC1sUqLCaGYlIcEfaW2nAUe2SczBsdvHdF7Oe89inWNpf8Al0xRDPg1
         +wQcyamfj9PttFBDJYdsKsXz9FcuVjuX8Y85ZrJCj8me8DFPDGxkKkf+l7se3HMmlOf6
         n/pZY2X/UXD/jYhUsrc8t7mIQhsuaFXIRYi/tK87HOtFcVG7mhWVhMISK8wZuYYAsVjk
         nXovLns9d75/VpHWABeHZf9HUor/vSHBlvhSPrrwAofWT5RcF4Df/DROf830azU6fD7/
         vCZmz001OgrFOBwM5HAcP5gdXNldQ+YTq8DeQXZEzGYEqGxp7sw4HLBK1/VS+ScLaUsd
         PtTA==
X-Forwarded-Encrypted: i=1; AJvYcCW7jPliQH6+bwqxTKrJfE5a3NKxeuRRsV38gE7V3TnJ2zHGuKk0tgE1PBaOLjoYqsTMGBn4nAWAO4JYbf1F@vger.kernel.org, AJvYcCWtvQbQeL+NdhR8bUL9BzNDgN+ZAoNx5A2MzYnf7zxnh+ZFr4gtHyd2RPQqa0xJh3l6ECLamLcXG0rfZcfZuMfW/g==@vger.kernel.org, AJvYcCXIPivYWsJokXPDdftoplMkHPFfqjyGe9RXPu+i0g3gcnQfyHQBPwjFQ8o1JAaMJ2GBil+1fDCgitHFjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ZPbUIB8UiD5Qi61Jw87B6rB1qI/uv1yQY8HFmFw+omna+ymz
	oU0AxSf4IuXRjWp1ygLGt5KU0OstXRrNgizKDN8uvP4t72I8/3q7
X-Google-Smtp-Source: AGHT+IE8uPyBvwmlyRx9OPr5CkYfbUQ6f8tDN4MdlsjG2Xd94dO4JKbY2wufCn9UKDbnbRSprbW6Qw==
X-Received: by 2002:a05:6a00:2e0d:b0:718:d942:3475 with SMTP id d2e1a72fcca58-718e3368830mr14029681b3a.7.1725939375009;
        Mon, 09 Sep 2024 20:36:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090c9b08sm437746b3a.207.2024.09.09.20.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 20:36:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f89d1f85-9ae9-43c9-ab2a-24614cbae1ac@roeck-us.net>
Date: Mon, 9 Sep 2024 20:36:09 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/15] Tool and hwmon PMUs
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>,
 Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>,
 Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
 Howard Chu <howardchu95@gmail.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Yang Jihong <yangjihong@bytedance.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 Veronika Molnarova <vmolnaro@redhat.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Oliver Upton <oliver.upton@linux.dev>, Changbin Du <changbin.du@huawei.com>,
 Ze Gao <zegao2021@gmail.com>, Andi Kleen <ak@linux.intel.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>,
 Sun Haiyong <sunhaiyong@loongson.cn>, Junhao He <hejunhao3@huawei.com>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Yicong Yang
 <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hwmon@vger.kernel.org
References: <20240907050830.6752-1-irogers@google.com>
 <CAP-5=fXihU0VH5T=59dZAUo4Qe=c5UAURUnFTuvfai+qs4XSCg@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAP-5=fXihU0VH5T=59dZAUo4Qe=c5UAURUnFTuvfai+qs4XSCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/9/24 19:21, Ian Rogers wrote:
> On Fri, Sep 6, 2024 at 10:08 PM Ian Rogers <irogers@google.com> wrote:
>>
>> Rather than have fake and tool PMUs being special flags in an evsel,
>> create special PMUs. This allows, for example, duration_time to also
>> be tool/duration_time/. Once adding events to the tools PMU is just
>> adding to an array, add events for nearly all the expr literals like
>> num_cpus_online. Rather than create custom logic for finding and
>> describing the tool events use json and add a notion of common json
>> for the tool events.
>>
>> Following the convention of the tool PMU, create a hwmon PMU that
>> exposes hwmon data for reading. For example, the following shows
>> reading the CPU temperature and 2 fan speeds alongside the uncore
>> frequency:
>> ```
>> $ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cpus_online/ -M UNCORE_FREQ -I 1000
>>       1.001153138              52.00 'C   temp_cpu
>>       1.001153138              2,588 rpm  fan1
>>       1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
>>       1.001153138                  8      tool/num_cpus_online/
>>       1.001153138      1,077,101,397      UNC_CLOCK.SOCKET                 #     1.08 UNCORE_FREQ
>>       1.001153138      1,012,773,595      duration_time
>> ...
>> ```
> 
> +linux-hwmon@vger.kernel.org as a heads up.
> 

No idea what you are doing, or why. I am not sure if I care, unless you
introduce dependencies on hwmon internals (or, in other words, define
undocumented APIs into hwmon). Which I'd argue would be a no-go.

Guenter

