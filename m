Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B163F9EC
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Aug 2024 03:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723000605; cv=none; b=LelYl/e6w5RrNk2n5T8lvvGAHTTc6c90RiebpApLAymD0Bas8Sx+1cj3gYwuLaFa431xd40nouodvBM4XIJ68SLqDJSHzKpSwzfb9Nix6c44C1THdRmVlG/X0hjMpCNpBg+a2Pfar03Lv5N+VtlxOjVvmnGSYdET+2E8DADfQ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723000605; c=relaxed/simple;
	bh=38N+viItxL3yCte3CukZEz3tvk3t9OU93AAf/2ALbZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=V5l+YW1K86AH3fSuxfPEkrQSbaDOQeL1/miidqNbsXj/397/y+gzLn94ODYhLe59ds8MI2sbzVjaP+L1NINU3QK8VFzvED07B1s/Rv3bkYKzaksNjMh+JyabQcTtJd9s11xiYUSes4LZhC0aKyc2Y5yiEd5XRv+9KzplfZYuuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CLuKyXpQ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CLuKyXpQ"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d18112b60so351832b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Aug 2024 20:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723000602; x=1723605402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yi5kPukvjKXes8AfD1B7ddB1OE6zD8xdq2TIopq22Qc=;
        b=CLuKyXpQGQNx2xj0w33vKY1VGjV4YaScG96ffraYhDKHtgA2kDtTPVFkLU8k4BIUTd
         9JavbjGXQpylpoeaiVqVQcwhetwNPk9MFn3mY9ZbkryzXjsqrLOYFieZsHnoHNScM8wd
         hr9TbUbJ7qRa3jN0N7PPJ6pegkKhY2LV9pXwh2r50kdgchMBgEhSCAQQwSUAjN6mCHAG
         e7UY65Rav+mpj5OtARioMO+rtxZQoQQt1G3ucVgJdJAL5FW8GlOGBs0XI83Xa6REy9MP
         GWDHZ7H9gA3+XV2+LL3APKb0zh3sJ2mYHW3YAqyTQHtel2O7ORvURZmlc2bAMNilyPYv
         YplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723000602; x=1723605402;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yi5kPukvjKXes8AfD1B7ddB1OE6zD8xdq2TIopq22Qc=;
        b=Fi6zAlGJTU0v4OxV/FB7j3jdHVB4dJNJGFX21fWZyAp1tLdeRsk6ZNvtZjPRt30ZAH
         hlRfvpVemo/emuUmOKjxcfrMQUpyOCwaLV5zPJwXf7PogVUDw33LQ+KzqEtxdN/mic+J
         WWfwH8mU/Aq+JoQv+G1zrwjHj944PWvoFV/aB+OiIRNV42Wu9jKeGNWRfa4xX4dBCe44
         hbfPvoDUNFQpaXQpk9jBfMl9T7kCxh0OR59nkfglhu1iMJIdV3jhOnGn7fkGKejJ3ZN/
         0v9gKL4L1H6q+OcZJHVRjfSYhgO4hQtaXrpovOUubDHogdIlCfryVxgaqptfk8EmGbLm
         wAew==
X-Forwarded-Encrypted: i=1; AJvYcCWdXNEI6QhXZq/htD7C0nvWbi6sADx0d/13oFZSJv94EyvgJOSfsEnwKECtmRHm/V0O0JoEYOWAv535ZV1dt9a6Uq7VJrR1w4jBgRy2DMbNZQ==
X-Gm-Message-State: AOJu0YzkbK5eJrVR8rsLBjMsMtZGeYzThPhYipvDU8Jlb1H3nf97VWKM
	e35P1IPLgiYeC5bNihOBEvyC4lX5UMRu7VdYjkQBNkqHIew4Gc196MEI0+2EAtI=
X-Google-Smtp-Source: AGHT+IGhf/5MMqzWbbVz0uG1EEfG1GqGNkg4D49WPuVl8SWZESpHxvs6jh34FECeqlLR8khLzAvcAQ==
X-Received: by 2002:a05:6a00:1706:b0:704:151d:dcce with SMTP id d2e1a72fcca58-710bc835cf3mr1361389b3a.5.1723000602249;
        Tue, 06 Aug 2024 20:16:42 -0700 (PDT)
Received: from [10.70.146.105] ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed3389bsm7543742b3a.213.2024.08.06.20.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 20:16:41 -0700 (PDT)
Message-ID: <94f775dd-ee7c-432e-9b41-6cb7a571b1ed@bytedance.com>
Date: Wed, 7 Aug 2024 11:16:35 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] perf: build: Fix static compilation error when
 libdw is not installed
Content-Language: en-US
To: Leo Yan <leo.yan@arm.com>
References: <20240806114801.1652417-1-yangjihong@bytedance.com>
 <20240806114801.1652417-2-yangjihong@bytedance.com>
 <ecf3460a-7f31-4dce-9a8b-fde8f146bfd8@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <ecf3460a-7f31-4dce-9a8b-fde8f146bfd8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 8/7/24 05:00, Leo Yan wrote:
> On 8/6/2024 12:47 PM, Yang Jihong wrote:
>> If libdw is not installed in build environment, the output of
>> 'pkg-config --modversion libdw' is empty, causing LIBDW_VERSION_2
>> to be empty and the shell test will have the following error:
>>
>>    /bin/sh: 1: test: -lt: unexpected operator
>>
>> Before:
>>
>>    $ pkg-config --modversion libdw
>>    Package libdw was not found in the pkg-config search path.
>>    Perhaps you should add the directory containing `libdw.pc'
>>    to the PKG_CONFIG_PATH environment variable
>>    No package 'libdw' found
>>    $ make LDFLAGS=-static -j16
>>      BUILD:   Doing 'make -j20' parallel build
>>    <SNIP>
>>    Package libdw was not found in the pkg-config search path.
>>    Perhaps you should add the directory containing `libdw.pc'
>>    to the PKG_CONFIG_PATH environment variable
>>    No package 'libdw' found
>>    /bin/sh: 1: test: -lt: unexpected operator
>>
>> After:
>>
>>    1. libdw is not installed:
>>
>>    $ pkg-config --modversion libdw
>>    Package libdw was not found in the pkg-config search path.
>>    Perhaps you should add the directory containing `libdw.pc'
>>    to the PKG_CONFIG_PATH environment variable
>>    No package 'libdw' found
>>    $ make LDFLAGS=-static -j16
>>      BUILD:   Doing 'make -j20' parallel build
>>    <SNIP>
>>    Package libdw was not found in the pkg-config search path.
>>    Perhaps you should add the directory containing `libdw.pc'
>>    to the PKG_CONFIG_PATH environment variable
>>    No package 'libdw' found
>>    Makefile.config:473: No libdw DWARF unwind found, Please install elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR
>>
>>    2. libdw version is lower than 0.177
>>
>>    $ pkg-config --modversion libdw
>>    0.176
>>    $ make LDFLAGS=-static -j16
>>      BUILD:   Doing 'make -j20' parallel build
>>    <SNIP>
>>
>>    Auto-detecting system features:
>>    ...                                   dwarf: [ on  ]
>>    <SNIP>
>>      INSTALL libsubcmd_headers
>>      INSTALL libapi_headers
>>      INSTALL libperf_headers
>>      INSTALL libsymbol_headers
>>      INSTALL libbpf_headers
>>      LINK    perf
>>
>>    3. libdw version is higher than 0.177
>>
>>    $ pkg-config --modversion libdw
>>    0.186
>>    $ make LDFLAGS=-static -j16
>>      BUILD:   Doing 'make -j20' parallel build
>>    <SNIP>
>>
>>    Auto-detecting system features:
>>    ...                                   dwarf: [ on  ]
>>    <SNIP>
>>      CC      util/bpf-utils.o
>>      CC      util/pfm.o
>>      LD      util/perf-util-in.o
>>      LD      perf-util-in.o
>>      AR      libperf-util.a
>>      LINK    perf
>>
>> Fixes: 536661da6ea1 ("perf: build: Only link libebl.a for old libdw")
>> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
>> ---
>>   tools/build/feature/Makefile | 2 +-
>>   tools/perf/Makefile.config   | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
>> index 12796808f07a..b18513ec4da6 100644
>> --- a/tools/build/feature/Makefile
>> +++ b/tools/build/feature/Makefile
>> @@ -178,7 +178,7 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
>>
>>     # Elfutils merged libebl.a into libdw.a starting from version 0.177,
>>     # Link libebl.a only if libdw is older than this version.
>> -  ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
>> +  ifeq ($(shell test $(LIBDW_VERSION_2)0 -lt 1770; echo $$?),0)
> 
> I would like to follow up the style of LIBTRACEEVENT_VERSION and
> LIBTRACEFS_VERSION, so change LIBDW_VERSION as below:
> 
>    LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw).0.0
> 
> Does this work for you?
Yes, have tested it in my environment and it works for me.
OK, will change in next version.

Thanks,
Yang
