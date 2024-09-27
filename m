Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B94E14D70A;
	Fri, 27 Sep 2024 05:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727413746; cv=none; b=bx4kLZqW7FBIFtqRMTaC/NWOZ+QJnbWaVU2n+DtlnAT1mIX+EFuLtA1GVW10T+volCZk08kfm/qq/2I5gWryfcouaeJo8RykIiGcDrdcSMLfUgAjn+sCEfpOUa7uCZ9u+YffU+yBTsIi1MSovBDCT7w5VaM0iy5WFwpUAed9/Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727413746; c=relaxed/simple;
	bh=dLp9HOwbUAAz3Jk4I7DYOqMMusaoZNzcxxzSSgz/w44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=novbwbRgqKoS9Lja4zjQjpv1aHNye4CMzMng/6s2hG92+MByKc5v3Qyw5Lb2whHuRiw7SvRAwHAMhi9cmpJ3+f/0ClFUV6ZzkXvc41N4h0YiAz4prgKsyTvgv+navbPYk0n+i2xfMiAtb7yTHaGN1/0bMfyVPcJrgr5mYyOdR+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d4093722bso233828366b.0;
        Thu, 26 Sep 2024 22:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727413743; x=1728018543;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZTtup+lwfKWXa/Ias75NJdtw40G4xptZVP6xMcf26E=;
        b=Tz+Qzw1DDoWSMmV0joFk6xxkJHtEHnjZTgnW5l4akedASspO9kFacZW0ewZltCOf7o
         JMrXP3u49dCD0vL9vJqF7MUWYI3oDfZvilnadmq388c3EKteHvPjP1X88pPu1vGQCDw1
         NHA6SyzcE37SYJ7XVWA9LHXq2W9AxRS73GDGe0D9m04hIIerNSK65a/gY3tYEVm2db4u
         yWVtcOy4iGythgxB8xrYWEYVfa2FfC4gLwFFcIR1KLsAUlNhKB+Xqo44YMRC+5J2V/VC
         Nnyvhn/ctQZauI5si3jvCk31Voxk6D7rF7MlRVP2k2gvR8lfs40MF9r2ddsbSL/9dNiR
         uqfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWpJOwifc3OZIg87FKgAXdOSIkHDICv/FY2c+4nKCRVq1v5BHtEGaoAfps555FC0vn8ffIWa8aGfixG3N6Pz92ig==@vger.kernel.org, AJvYcCXlHmwjB67SGl6wewI2uVMBzexg8i41gXabg7jIp1ecgKkFkL83C3ZEj6KwCIlRbk9d4ORz/5DsG0dkuLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsaZTaCyXPWAor3YggvyzrkFHdJcUlk1GD+ScTwUUEIMZgLGkl
	qVlmij/68PXRJy55UP3BpLnwZz77+0wDWiGsqsoib+Z67P74Fehp
X-Google-Smtp-Source: AGHT+IFmeJVuBgpBX8VHvMDQIIkh4P/beldjre+PzQ9G5UcG7vCAvxebL0CdsRrys9eC/LZUyRuC9w==
X-Received: by 2002:a17:907:7da8:b0:a86:a56a:3596 with SMTP id a640c23a62f3a-a93c4a98d4cmr176104866b.60.1727413742702;
        Thu, 26 Sep 2024 22:09:02 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c5b52sm79807566b.53.2024.09.26.22.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 22:09:02 -0700 (PDT)
Message-ID: <c279ad02-2543-4a95-9404-9304e1e704da@kernel.org>
Date: Fri, 27 Sep 2024 07:09:01 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFT] Re: [PATCH v5 1/8] perf trace: Fix iteration of
 syscall ids in syscalltbl->entries
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>,
 Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20240705132059.853205-1-howardchu95@gmail.com>
 <20240705132059.853205-2-howardchu95@gmail.com>
 <6fe63fa3-6c63-4b75-ac09-884d26f6fb95@kernel.org> <ZtJWEVn8-w07Wm0q@x1>
 <0f841525-e02a-4e11-b5f8-1acc61979ccf@kernel.org> <ZtYJ0z8f-1jwYSbV@x1>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <ZtYJ0z8f-1jwYSbV@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02. 09. 24, 20:54, Arnaldo Carvalho de Melo wrote:
> On Mon, Sep 02, 2024 at 07:25:17AM +0200, Jiri Slaby wrote:
>> On 31. 08. 24, 1:30, Arnaldo Carvalho de Melo wrote:
>>>   From 174899051e54ecdab06c07652a3d04ad000ab301 Mon Sep 17 00:00:00 2001
>>> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>>> Date: Fri, 30 Aug 2024 19:53:47 -0300
>>> Subject: [PATCH 1/1] perf tools: Build x86 32-bit syscall table from
>>>    arch/x86/entry/syscalls/syscall_32.tbl
>>>
>>> To remove one more use of the audit libs and address a problem reported
>>> with a recent change where a function isn't available when using the
>>> audit libs method, that should really go away, this being one step in
>>> that direction.
>>>
>>> The script used to generate the 64-bit syscall table was already
>>> parametrized to generate for both 64-bit and 32-bit, so just use it and
>>> wire the generated table to the syscalltbl.c routines.
>>>
>>> Reported-by: Jiri Slaby <jirislaby@kernel.org>
>>> Suggested-by: Ian Rogers <irogers@google.com>
>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>>> Cc: Howard Chu <howardchu95@gmail.com>
>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>> Cc: Kan Liang <kan.liang@linux.intel.com>
>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>> Link: https://lore.kernel.org/lkml/6fe63fa3-6c63-4b75-ac09-884d26f6fb95@kernel.org
>>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>
>> Tested-by: Jiri Slaby <jirislaby@kernel.org>
> 
> Thanks a lot! Added to the cset.

Oh, 32bit arm still affected:
/usr/lib/gcc/armv7hl-suse-linux-gnueabi/14/../../../../armv7hl-suse-linux-gnueabi/bin/ld: 
perf-in.o: in function `trace__init_syscalls_bpf_prog_array_maps':
tools/perf/builtin-trace.c:3461:(.text+0x899a0): undefined reference to 
`syscalltbl__id_at_idx'

-- 
js
suse labs

