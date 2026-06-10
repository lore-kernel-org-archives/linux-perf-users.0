Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EE32E7391
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098709; cv=none; b=KDznYra56CBU67ANciGO372Ok0dO9vsGg+o33BYCyX2AAJ1pzVJciqgCQ+9Rs9EcCg2F4GHNK7YCvsttaVdoTVrUFqI4aZIhuqWTqE+SB26bHjUXipbW+msDUoYqXoGc2GToQSH1HaJgkHObOAp/CO7Qgp6z54T108cYIP2cxX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098709; c=relaxed/simple;
	bh=f5xF23PvbD03zrgF6UzgwUbWasiF/s+dmaVBDDMQYnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aiZIBNLtroKNidEZRullWqB0pY2jq120jxxI89pVe7GDyKutrRR2OzS1hhvS6Q/IfyaIrci7N14Ty0WnvpOVxOsdBX5FiPrXb8qonqWaJB073Mxj8lPEKZ7T1amFZ2ztF5AfTdfj7ZqYfD9rrZh0Z0fRxR25J2J/+uABcHqpwRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sM6IQSP3; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sM6IQSP3"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-beb1bee8c16so883173666b.0
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 06:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781098706; x=1781703506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hHFAGJXeiT/y4W+FHHHiOJeeM3a7WGwNiF8ZLx2zfY=;
        b=sM6IQSP3Ilo3vdosRXO5FKC5RotGlTj5bVscIgX/YaYKPpaYYg3j/GMuXNty/azgj5
         ZLcNS+x4jsVRMOQ/2AzXcajPExAkVr9tL/XBpzH+tni8lWQwl/3CqGczXqM886MMZVvU
         edN921MhTqOE85DtXepDtPC0Qe7ic0reD6kROyIxqm89G1in7FbfysunXW9/F7zPAHIf
         P4v+XNA1YALPCzycexDU0M+2GdrQjMZEXP7jbIJxZAsWH0D0Ihv5Wtifis4Xr6UlNRrQ
         k2A1d+AyZtrBScb3GBfujcRT7MCwyLI3yu6si1t60TzpsTEyOUY2woHeGQzPO0dFNKQh
         cirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781098706; x=1781703506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5hHFAGJXeiT/y4W+FHHHiOJeeM3a7WGwNiF8ZLx2zfY=;
        b=BkJ6QHDAe2z7kb7TtMn9Utu5Rm2Vl9wrRLbTXX6B2Qe2aSznmqGvw5aZiT1MX4RW2N
         GrUbZ05PXRm2h+cWxiK83JskrPk8SgKgjwoy6Xemf5Gl3iI5yDIArx/Hwc43ewCAf5Bk
         XVOxWCIhO/E56+ZiB7auO0/BMewGSLk1HAqDUPOgaEJcKYlAPvCBGjNxIn1qbSitiGmY
         EudKwrGfcZY+GzLRzAlCVS6jvvfsgnj3Xrzk5IKdWthfuYimnJKgQBnYzR43GfeLQbGD
         7FSf5tfTr22pkUTBllr/uouiRgHu86cQ0pt+LG1CNnsDp3PHBKE+6ukPqVy6IslmS0gG
         bxsg==
X-Forwarded-Encrypted: i=1; AFNElJ+dd5/C5urf1vp3xorONgfgf8crmf7t51vK/YG+VWxcwu3T1EZWiIOgNiC531WqhqLxlbM0Hz6afHwkMDE+R3+b@vger.kernel.org
X-Gm-Message-State: AOJu0YyYsxAkHNCjtyhfPpyyOjZR6ge6VRtvXT0EHOg1RiT0Fr15PYDo
	4KViQxLEPtIssxLgC+F+3tt1kYUtKVZkb6CNJnnWNQ7nFYwjUdbnyjpeFDv8baB5Gus=
X-Gm-Gg: Acq92OFHzguFANULEckjqZhxnJeTJf3Z6ySJP9J2L+WVATu8KbYlP4anqy9Ct36lp4x
	aK20E3QHDEeVN9fzkn/8ea/YrRJ9ucZ3QejpW8sdJ2SY+mpMb1UGbPuROVH4hsp9b8G0gyTtGYv
	1t4bWrnWWtlm3iM3aAsqq7gD2j+jB40kXFcxoWM/MbEvy1z7NwT0UOYv0qq4KauAgZCavS5OXrD
	vOvZaWrPOx5MWf61lwRjXZx3HBsFxhvqhdmk6JELCZvYYRmEFG6ml4MUh/fGO4/XAhA8zp6NWwo
	noiHs4u/cgt9H0C25K+BFuy41j5McIBQxiauacFlapzIeAoGg9q7FAhxBF8aU93FlIqBC8hNvnv
	yajreOyYJaWB4w2CBKFvH3sCXkPs5Ut3j9ihHaPJJ2w+bdBwJCnU88NYOdtKfbfwDKcRK/HzoeM
	Hfdt5JJdu86iQgasN5Ahi+e98IiKgl9Ke4CA+SUls=
X-Received: by 2002:a17:906:518a:20b0:bf8:970f:e4d8 with SMTP id a640c23a62f3a-bf8970fe4f0mr317498166b.12.1781098706106;
        Wed, 10 Jun 2026 06:38:26 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf05176fd07sm1203628966b.1.2026.06.10.06.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 06:38:25 -0700 (PDT)
Message-ID: <82e8f48d-50da-4010-9df2-82dfd436d85c@linaro.org>
Date: Wed, 10 Jun 2026 14:38:24 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf build: Do not duplicate CFLAGS in Python extension
 builds
To: Jens Remus <jremus@linux.ibm.com>
Cc: Jan Polensky <japo@linux.ibm.com>, Thomas Richter
 <tmricht@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260610112344.1550111-1-jremus@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260610112344.1550111-1-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/06/2026 12:23 pm, Jens Remus wrote:
> setuptools already uses CFLAGS.  Passing CFLAGS with additional flags as
> extra compile arguments causes CFLAGS to effectively get passed twice:
> 
> $ make -C tools/perf V=1 JOBS=1
> ...
> building 'perf' extension
> gcc [CFLAGS] -fPIC -Iutil/include -I/usr/include/python3.14 \
>    -c /root/linux/tools/perf/util/python.c \
>    -o python_ext_build/tmp/root/linux/tools/perf/util/python.o \
>    [CFLAGS] \
>    -fno-strict-aliasing -Wno-write-strings -Wno-unused-parameter \
>    -Wno-redundant-decls -Wno-cast-function-type \
>    -Wno-declaration-after-statement
> 
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
> 
> Notes (jremus):
>      This patch applies on top of the perf-tools-next tree:
>      
>        git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git  master
>      
>      Note that my "[PATCH v2] perf build: Respect V=1 for Python extension
>      builds" [1] needs to be applied to actually observe the Python extension
>      build command and output with V=1.
>      
>      [1]: https://lore.kernel.org/all/20260608160613.3153795-1-jremus@linux.ibm.com/
> 
>   tools/perf/util/setup.py | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index b65b1792ca05..a0ce76624a23 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -74,18 +74,17 @@ class install_lib(_install_lib):
>           self.build_dir = build_lib
>   
>   
> -cflags = getenv('CFLAGS', '').split()
>   # switch off several checks (need to be at the end of cflags list)
> -cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
> +extra_cflags = ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
>   if cc_is_clang:
> -    cflags += ["-Wno-unused-command-line-argument" ]
> +    extra_cflags += ["-Wno-unused-command-line-argument" ]
>       if clang_has_option("-Wno-cast-function-type-mismatch"):
> -        cflags += ["-Wno-cast-function-type-mismatch" ]
> +        extra_cflags += ["-Wno-cast-function-type-mismatch" ]
>   else:
> -    cflags += ['-Wno-cast-function-type' ]
> +    extra_cflags += ['-Wno-cast-function-type' ]
>   
>   # The python headers have mixed code with declarations (decls after asserts, for instance)
> -cflags += [ "-Wno-declaration-after-statement" ]
> +extra_cflags += [ "-Wno-declaration-after-statement" ]
>   
>   src_perf  = f'{srctree}/tools/perf'
>   build_lib = getenv('PYTHON_EXTBUILD_LIB')
> @@ -94,7 +93,7 @@ build_tmp = getenv('PYTHON_EXTBUILD_TMP')
>   perf = Extension('perf',
>                    sources = [ src_perf + '/util/python.c' ],
>   		         include_dirs = ['util/include'],
> -		         extra_compile_args = cflags,
> +		         extra_compile_args = extra_cflags,
>                    )
>   
>   setup(name='perf',

