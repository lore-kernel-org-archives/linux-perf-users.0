Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4537B676
	for <linux-perf-users@vger.kernel.org>; Sun, 29 Sep 2024 02:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727576694; cv=none; b=T/SA1mZY8hXxPlF64u7U8SzVUKsMeEXrJWBVDq9TeLM9mxDpiBtb5PlTpObcsw7jDc7lwYH5BStywfiQrItZ3t+0QY6W/ed8Ntpt4R8+99XlptZw4iLubvlNuYKlUXuJTjh6bQQ/V0oY4i0qnf10uXA4+QRg3dF4t3T95Rpkx+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727576694; c=relaxed/simple;
	bh=cBICq7Yw77KRwv/0M6WtodAXrSpzg5xQV/fSitTTGNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQshNratm4p+WMYWrRCcI3vX8X5h5YrYxtF+/KK+sfRcbVLXpRmx8pzojcDVwowDn9ixS0W6Zf0xEl5dMJaIkoL2TWctbfOBPqJzcGoJjT6So2ItJgeno1QyRZP+VLVcyJdINMeI6Y8T0ExUSZDUV1iXnTls044koJApIvduGPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ceal/QgE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ceal/QgE"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71b8d10e9b3so1404949b3a.3
        for <linux-perf-users@vger.kernel.org>; Sat, 28 Sep 2024 19:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727576692; x=1728181492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7J9loi/LLkdFcZG+N1SNYfaAIF+3tAmLLQpGcvQRn84=;
        b=ceal/QgEJjidDKqkg3TYWHfsDLvspF21Nudo+q/By9Y9vjMIFI6Mxth91XVa4+5rAz
         9IcAeKti+7Kzw5dlqDp7YKg6wXosjcHSUDpMjNlXTw+gpg5CV+RQRV9mpKuKv4tTmLan
         UU3wUrFppYWkZNzZ4HwB1oCTCXQvfVFM0n1MsRiESO2MrjbkjTYVCkelMc4mGQS29m+R
         Mjz0tn52ufZszfgjL6wFundzw2MksNw7SqjTK10IoXNQiro9fU5V8WJtiDNL1/g1rh2r
         QZ8/I203HE3Bztdrm/jzF31ldD1WrpNhUWXBYmvD+NHexjc5lsk+QHsWDtohAKs/2xLS
         o7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727576692; x=1728181492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7J9loi/LLkdFcZG+N1SNYfaAIF+3tAmLLQpGcvQRn84=;
        b=DtQD+swsC7J9ze+kSyfjoaGx5iWb3pwCq5eMKSbhro+BUimoO0HvRbGiuYRMh6/U1N
         LKlKJGRmEYc+qcV9YhOCw1Cuf4zYpnvwufJaqJ/X+pwdlN1i9WAoV0Y5oUsVFeHToYaW
         iPXbS7tbk4UseivevHN1iKeQCFoUERoPgjfKxM3HO3PDeZGSzq6D1Ne2yHJ74zwvh7gj
         1LIimmTWGtAAMJMCuksVr8aKPNvGOnXh83oXfbZcI0n92LNhSHsVmpKop/MawYHwn3oD
         eO0c9J/XHjvXTbhXXn3yscDddWIYNRa8slbem8OTz/1uPJ1G4VwJsZb7rRP5efOL89v4
         BOlA==
X-Gm-Message-State: AOJu0Yx/hJrnmTLVfIGR9r8mApWPXqbwIXai3M53zla3zI1KyZjkJOwP
	xQwiwJ88qumI6PR83/wJsfarC6H0gQ+KTwXpz2iVaLDPTim/PbdxoTiTnlzDNeE=
X-Google-Smtp-Source: AGHT+IFKqKBstTmcEl8Pn3z+AfZJxb9xQL3LJdSJptREBAQiCuJU5bU5xkhlIFPtdVGXmMq5nCkFrw==
X-Received: by 2002:a05:6a00:6110:b0:714:1bd8:35f7 with SMTP id d2e1a72fcca58-71b25f6ef3dmr8184202b3a.15.1727576692161;
        Sat, 28 Sep 2024 19:24:52 -0700 (PDT)
Received: from [10.70.146.105] ([203.208.189.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bc443sm3819772b3a.70.2024.09.28.19.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2024 19:24:51 -0700 (PDT)
Message-ID: <0a5f0b71-2478-456e-bf4f-5132fb4f255d@bytedance.com>
Date: Sun, 29 Sep 2024 10:24:43 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH -next] perf test: Use ARRAY_SIZE for array
 length
Content-Language: en-US
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20240927084002.8437-1-jiapeng.chong@linux.alibaba.com>
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <20240927084002.8437-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 9/27/24 16:40, Jiapeng Chong wrote:
> Use of macro ARRAY_SIZE to calculate array size minimizes
> the redundant code and improves code reusability.
> 
> ./tools/perf/tests/demangle-java-test.c:31:34-35: WARNING: Use ARRAY_SIZE.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11173
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   tools/perf/tests/demangle-java-test.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/demangle-java-test.c b/tools/perf/tests/demangle-java-test.c
> index 44d1be303b67..611c18cdf4d3 100644
> --- a/tools/perf/tests/demangle-java-test.c
> +++ b/tools/perf/tests/demangle-java-test.c
> @@ -6,6 +6,7 @@
>   #include "session.h"
>   #include "debug.h"
>   #include "demangle-java.h"
> +#include "kselftest.h"

The wrong header file is included here, causing the build to fail:

   CC      tests/demangle-java-test.o
tests/demangle-java-test.c:9:10: fatal error: kselftest.h: No such file 
or directory
     9 | #include "kselftest.h"
       |          ^~~~~~~~~~


The correct header file to include should be: <linux/kernel.h>

Thanks,
Yang

>   
>   static int test__demangle_java(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
>   {
> @@ -28,7 +29,7 @@ static int test__demangle_java(struct test_suite *test __maybe_unused, int subte
>   		  "void java.lang.Object<init>()" },
>   	};
>   
> -	for (i = 0; i < sizeof(test_cases) / sizeof(test_cases[0]); i++) {
> +	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
>   		buf = java_demangle_sym(test_cases[i].mangled, 0);
>   		if (strcmp(buf, test_cases[i].demangled)) {
>   			pr_debug("FAILED: %s: %s != %s\n", test_cases[i].mangled,
