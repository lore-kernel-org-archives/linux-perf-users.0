Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A312D3B6BE8
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098756; cv=none; b=L4hKPByQ0tbairfRxbgQOJWz+l6K+A4SQS7kxav318gqp+PQLWm8e9dphHNcJQ8HWWat1KJEvXMG+xCPy/TnKwY+29uoqTV2ddKU/GhptVQCgqyA6bTosjRcF36yfjs2sKXqrQ3aCJeehDVqzFdAY1vW5VvIhMLLrW2H2rTe0VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098756; c=relaxed/simple;
	bh=N00Ky+WGYp84SzDMbu+B9refsaRvWDuX8zkxZe2IH6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofw+QG5THwPBQXtOP5ARi6TmBQRRpe5m8mJbyWUSVbzcgdHYkorXAh83g3MR5REJ5Yt+HS5vhnMBPjzCnLr24DDBwPODkctCEPsiOhGo3RfdGFNIasTbJzuXK1w38ETpDThAVEcxeO4WTuNVSTYg2sjVacd8htHw21ffYvRWefE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hyi9U7hf; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hyi9U7hf"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68b482888c3so10540299a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781098753; x=1781703553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PPHRXTOIn1D18o4cjb2DkZuJ0R5woSyQD9xCP2gFXJ8=;
        b=hyi9U7hfgZolEYgEQ3Jwq17irQMB/0NlS0TnZBiMuQkw4oQu3UIFLcbcTtGw7uItpb
         xemNm1mCVVLkjCIl7gz0BA843mGaTmbZB+pjs0rPvEefU6PQcsJAzP90ZIS7e53NMWNO
         2kBpLuAfiuO4BvpX2TNhHliiO2MB4YAnBPFIE+hSwHFJDsC7NAsGTG4rCX3JBVDanD7p
         5k4SYjtnjEzV0DlPfMsoh6OLnGuSsCd1MXMBu6CCmOkXiFIa41421N0UPPj3+pF3NpeI
         9TCDQUVI2Nrr7OMGPPW1siTU/TOi6cilxRsbMZZgPhYCtdRHWh6Tqp19XJY79MHmzVSY
         6Kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781098753; x=1781703553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPHRXTOIn1D18o4cjb2DkZuJ0R5woSyQD9xCP2gFXJ8=;
        b=r/gL6ylHbPeJBLH35JQqHQnX5PaVMKDUlayvF5BRjHdJjl5HIeL+QSVq9QshGeaSaJ
         jUN69AejgPZNfFtEz7+9FyNhyLg2/5Xwg5v2nVB4J3LGbsvL/wOq14SEXhsAWd7TLQ0b
         nkJt2lplcAHpwtuIm0BzlAKZQyL+KFm4udP0u6j+uyYWPGKLPXtu0tOE6D2Ntc6awUVm
         szNl9/EIsJ26+034Oy3O8WiCtBvu9buGNfkXruHC8iI0VasWCfP/valS0KNISDS3olpo
         +JN3pj60HVkfzuo+iNogvnw7kYu/0ZAGLvl4l9gOqw0JU9Gku9sKz10bXhC+qz/ohZVc
         izEg==
X-Forwarded-Encrypted: i=1; AFNElJ8VuaIB8d68SqkNB97Qt9a5Svabg/gUSFEb7lT+UWlwqTOAuqcW3nicGi/3s4ht4mrzL+4Q/jSlD6+3HFLCD0A3@vger.kernel.org
X-Gm-Message-State: AOJu0YxT23OIVf6rxCsDaVnSbFXWxEvhNK8ZT6aciHR67zv6qq8CWgsn
	SFU4WTDwwvr2fjM75M05pn7HjjRbd0NFgBxrtq+J5KIQOssqbrwDNNn2Jhah8i7qPog=
X-Gm-Gg: Acq92OE/wy19l4QbxbHg9blmEYNP22yEb2w1MpjiZ0H3GodkG6N3cfJUuneUobjaxp/
	ELP6AFiQqK1yEP/nKhDtb7ODjPpMPZAKlyk7s6BpYbYDGhmzg0W5cou+ArvlHKrK3ExRdEG8A+N
	+T8UTvpA8/baTGJvGAOPRDFB87omZyuOw8dkMK+lrUZ/cI0uMTGZLtfnSIOVG8t5yeo9LcGeY7l
	MeA+VO42RYQWd0BwDIw8gPC6bwR6NB4aD5tBbc7ml24vvQvj4SlKxyJ53Rd/9T8F3jSLA4qXbEC
	7QJgYfBNHXMt5KJS6fXF4P5DAwpj5wZzFxuLN7vBDWjeC3UBmsy0+Q7QAtK3rRY0zCfmawS1h9n
	E2ns6vA2MQbTUB0x+9ySytHRlCrtd9FVDZHeiSPjQuJKm5rezbwXN/4NpKZsVg0DbRIoRZqcsuh
	D8zSKt7w0ylOieUV0CIg3a/feW9rd9+O2WE1WrOdE=
X-Received: by 2002:a17:907:60d1:b0:bd8:fc89:cda0 with SMTP id a640c23a62f3a-bf3a8a0cdbamr1035525466b.24.1781098752912;
        Wed, 10 Jun 2026 06:39:12 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e04a89sm1179772566b.41.2026.06.10.06.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 06:39:12 -0700 (PDT)
Message-ID: <a76b93d7-89bb-483a-80dd-59e3dbf921a3@linaro.org>
Date: Wed, 10 Jun 2026 14:39:10 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf s390: Fix TEXTREL in Python extension by compiling
 as PIC
To: Jens Remus <jremus@linux.ibm.com>
Cc: Jan Polensky <japo@linux.ibm.com>, Thomas Richter
 <tmricht@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260610112451.1553054-1-jremus@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260610112451.1553054-1-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/06/2026 12:24 pm, Jens Remus wrote:
> On s390 the Python extension build fails as follows when using a linker
> that is configured to treat text relocations (TEXTREL) in shared
> libraries as error by default:
> 
>    GEN     python/perf.cpython-314-s390x-linux-gnu.so
> /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
> 
> This occurrs because util/llvm-c-helpers.o is erroneously built from
> util/llvm-c-helpers.cpp without compiler option -fPIC but linked into
> the shared library (via libperf-util.a(perf-util-in.o)).
> 
> On s390, object files must be compiled as position-indepedent code (PIC)
> in order to be linked into shared libraries.  Commit a9a3f1d18a6c ("perf
> s390: Always build with -fPIC") added compiler option -fPIC to CFLAGS
> for s390, which is used in C compiles.  Add -fPIC to CXXFLAGS for s390
> as well, so that it is also used in C++ compiles.
> 
> Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>
> ---
> 
> Notes (jremus):
>      This patch applies on top of the perf-tools-next tree:
>      
>        git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git  master
>      
>      Note that this resolves the issue discussed in thread "[PATCH 1/1] perf
>      build: Fix Python extension build with GCC 16 hardening":
>      https://lore.kernel.org/all/ahV2XGx_6h7upuc3@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com/T/
> 
>   tools/perf/Makefile.config | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 333ddd0e4bd8..33f90968c8a9 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -109,6 +109,7 @@ endif
>   
>   ifeq ($(ARCH),s390)
>     CFLAGS += -fPIC
> +  CXXFLAGS += -fPIC
>   endif
>   
>   ifeq ($(ARCH),mips)

Reviewed-by: James Clark <james.clark@linaro.org>

