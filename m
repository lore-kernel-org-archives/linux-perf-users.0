Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF8171089
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720791505; cv=none; b=ZZNbd9JaeqmEsd4Q/rlEVfMw6xLLrWaI5ZD/XGewHY/amKL+91S9JrWMXYfiyCRDOq9PpLaft40saMmjVjeD0C5hSA/s6/KwRbdxEM9/qWQm08K/Y5iLSd+iENSp63RoJmjCLSXZ05YoOH6p1mVFxF8Tpe37bHtYLqdXCR7q1O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720791505; c=relaxed/simple;
	bh=T4H+8IrrmrAPxWFvSUM2MhUOGIEV5vFXnhSXl/h/Rqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sa8bz5M8bGPhaisOB+LiIqh1JkhREiJSup89lh4mI/VBXEkXmEPRgIS45sayz5FD9DoA8RIE9XvnHeOp2DEs32ewnHJ1R4Su+mSyuGIVbqQ9lDS7bgdUqOee6R0GzFGgVVAbdO5zpV640XcRcPhnXpEcBQPk0/MAqreH5Bl6uRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BMdt9gcJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BMdt9gcJ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4267300145eso16048295e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 06:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720791501; x=1721396301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cC1jAi1iv6WdqEK+EAzRU4oNQ4sXJVOHSwTyXKEqpio=;
        b=BMdt9gcJBTT6iTeXHxpNtOVkFEZ1WlV2zyLJ68qA4m5uRvIyyhtrlgEa2LBBlt1Pxf
         xWBu7XvXRsyIwhsVoFy5FUJeEoBArcfkgUBDEot5qmV87bAUvVgBc8qVplHa1qjQDzCd
         5a1sGUt+T69pRBCyebeQxXK+MKtJY270oiDialzb6qNuJByTFmWea3sZqlWuOkcOaLGL
         E7j54Q2QsA8sH2kMG9NGNb2ubSgekBarhCCZW3qoCpiKatqnO0jthmKnCasusv1liswY
         zYaLK08R+Fugru56hLVuSCsP4f5Rw4/R/yzmqKXV2cCNEGPlRXlhRSOKxgIdN0z8MvPl
         RTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720791501; x=1721396301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cC1jAi1iv6WdqEK+EAzRU4oNQ4sXJVOHSwTyXKEqpio=;
        b=O/YZzv7YQ+iWEz+a19G8wRkJhxRLWxkaNgjRcS5oPd1R64hw7fvLAXx7qMPLgJE/51
         5TxkDMoCzy1sNXwMLu6EKj6u/xZiuaCeK8SIzOOeUiqfvnGMDyl8r8DrsXJAVxB5CcEK
         /wMLCbxUaVdOV98J5WHCKno6CQpHaLMsqv47WBEWtFD5M0pEfanVHch1QqJ6CArp0N7N
         n0XDS7sPJirXwC3Dbd4TG0zB2SznbcnYE8BsMMlbr0QiM7t/pIjKYhBnRf6N2UrRpIr5
         sg70aM1KWIaMlq1nvPx4i2oXR04B5nTW1tcbVdcfCpM5XPrZsb//vV33FLpGnynlk6MO
         JVqg==
X-Forwarded-Encrypted: i=1; AJvYcCXCLj5vw61LO7EeKTnOydUzOdkxUPxtMaudQi7L7deQfOGvNtZSR3sjpgiY5LvhUFgapyRBS1gyXjfcplRS99XfFDIt+fPrlnVkWnSQ60NZ9g==
X-Gm-Message-State: AOJu0YxBQzeh1AGPTj2HwqXGaBB3blXs+nI3nMNQQw2yVoSBhEGVec9e
	0MNcBz35XJ25dKUEGlq3ihs3IRy03LfbvB+yhEhAMzG1686HVsugt7IQYwDTp4o=
X-Google-Smtp-Source: AGHT+IEhyKGkl/VF/a4vHFezgDI+nStbpoqP8KMLCsMj4wEfKGgRy7eiqctDREifaFXVEsurbSfJFg==
X-Received: by 2002:a7b:c052:0:b0:426:5c81:2538 with SMTP id 5b1f17b1804b1-426707cf827mr88262375e9.14.1720791501208;
        Fri, 12 Jul 2024 06:38:21 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f265ce6sm24098085e9.16.2024.07.12.06.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 06:38:20 -0700 (PDT)
Message-ID: <83301e3e-e049-4af4-9f0b-29bdfc201543@linaro.org>
Date: Fri, 12 Jul 2024 14:38:19 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] perf docs: Remove the Android cross building
 document
To: Leo Yan <leo.yan@arm.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>,
 Nick Terrell <terrelln@fb.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Changbin Du
 <changbin.du@huawei.com>, amadio@gentoo.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240706182912.222780-1-leo.yan@arm.com>
 <20240706182912.222780-8-leo.yan@arm.com> <ZpC3-p0kG7dGkp_5@google.com>
 <3b16778b-f825-42a2-b53d-17c9b8c22a52@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <3b16778b-f825-42a2-b53d-17c9b8c22a52@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/07/2024 12:02 pm, Leo Yan wrote:
> Hi Namhyung,
> 
> On 7/12/24 05:58, Namhyung Kim wrote:
>> On Sat, Jul 06, 2024 at 07:29:12PM +0100, Leo Yan wrote:
> 
> [...]
> 
>>> The Android NDK (as time being the latest LTS version is r26d) changes
>>> toolchain to LLVM / Clang, so GCC compilers is not included in the NDK
>>> anymore. Therefore, the Android document contains obsolete info for
>>> building perf binary with NDK.
>>
>> Do you know if the version prior to the change is still used?
> 
> Based on the Android NDK wiki claims [1], since NDK r15 (backed to 26th
> July, 2017) "GCC is no longer supported. It will not be removed from the 
> NDK
> just yet, but is no longer receiving backports".
> 
>>> Furthermore, the Clang included in the Android NDK is problematic for
>>> cross compilation Aarch64 target. The building reports multiple errors
>>> with the compiler aarch64-linux-android34-clang.
>>>
>>> Thus, delete Documentation/android.txt to avoid confusion.
>>
>> If so, maybe we can keep the document little more and add a note that
>> this works only for some old versions.
>>
>> I'm also curious if it's still broken after your fixes.
> 
> When I tried Android NDK for cross building perf, it is still broken after
> applied this series.
> 
>  From my testing, now using LLVM for native building works well:
> 
>    make LLVM=-15 VF=1 DEBUG=1 -C tools/perf
> 
> But it failed for cross compilation. Since Android NDK system root does not
> contain some dependency libs, we must use extra options to disable some
> features (e.g. NO_LIBELF=1 NO_LIBTRACEEVENT=1). The commands I tried for
> cross building but failed:
> 
>    make ARCH=arm64 CC=$NDK_TOOLCHAIN/aarch64-linux-android-clang \
>      LD=$NDK_TOOLCHAIN/ld.lld AR=$NDK_TOOLCHAIN/llvm-ar \
>      NM=$NDK_TOOLCHAIN/llvm-nm STRIP=$NDK_TOOLCHAIN/llvm-strip \
>      OBJCOPY=$NDK_TOOLCHAIN/llvm-objcopy \
>      OBJDUMP=$NDK_TOOLCHAIN/llvm-objdump \
>      READELF=$NDK_TOOLCHAIN/llvm-readelf \
>      HOSTCC=$NDK_TOOLCHAIN/clang \
>      HOSTCXX=$NDK_TOOLCHAIN/clang++ HOSTAR=$NDK_TOOLCHAIN/llvm-ar \
>      HOSTLD=$NDK_TOOLCHAIN/ld.lld VF=1 DEBUG=1 NO_LIBELF=1 \
>      NO_LIBTRACEEVENT=1 EXTRA_CFLAGS=-fgnuc-version=0 \
>      -C tools/perf
> 
> Given the test result, my conclusion is the doc for Android cross building
> is not useful for a long while. If we really want to support it, I would
> like to suggest to take a separate task for fixing LLVM / Clang cross
> compilation.

We could replace the entire contents of the file with something like 
"Android NDK compilation deprecated -- no longer supported". It might 
help someone in being able to recover the history of the file by leaving 
in some keywords. If you delete it it becomes very unlikely that the 
history will be found by someone trying to get it working again.

> 
> Thanks,
> Leo
> 
> [1] https://github.com/android/ndk/wiki/Changelog-r15
