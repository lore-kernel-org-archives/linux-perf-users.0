Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB23433D1;
	Thu,  3 Apr 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689958; cv=none; b=cychoOKjs3adroCMNDzke607mLSggZkt6f60uOgw4DqETHbt6zm/oXKyxrmZXstK8eyuTYnr/GhgE7yUkveT216amfXumYkyrAil4XufzEzja1EnKf2yAMbLkq/5lFCuEHV07tC3DUboIK8PO4wYgFw2WTIuhcHymPjFbqq1li4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689958; c=relaxed/simple;
	bh=2r3U8ewcuEhS2Jqw1TNGNFLFh3bbW+ULJZIAPbc7h8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWbIWT/a0hN0eYxjprsBbkF+1VV4nKb9gF34EE2da8F8apt85fOixkSPijgZPTswxN3grMeXv2ybH3oggXsO4IOYwZIZKPgJPyfE9hcukBxERXKhp+sykufjFLGZH/Jg2WET0dltF2KvzubDMmQ6KJfeTlaUZEhNdjOHAcmLvw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hF7daB+/; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hF7daB+/"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-af19b9f4c8cso713238a12.2;
        Thu, 03 Apr 2025 07:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743689957; x=1744294757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=khXp6kOEsTlpiucdkkgdxNh1P5TojGz8UwRxJaqxnCw=;
        b=hF7daB+/AkE7Y2g16TF5zbyArB4MzOAuBkkO44kfT6BhW1Z5GY18WT2QrEaG5w21zs
         FFPdqxshRfvceHjLvRoO1d2v3z8MocHaEIfIC3NlHJGMFcVpXueyEjSa9TqTqXWO3BzS
         LiFIJhGy7M0xfUvYpBPoYnyEV9falFc8Y+wfYkiSvN/7tF0Ckt4lizw5IX5uAQcps8Ev
         PThT606dq79RCheV3ENBMcbWII2GFc+OcxNw6EVrr5dBpcF3MwpK7DcSDC56rHfZv3k1
         d9KKkEo8xG3z3qRAdLsj8U2f2GG+nXiK4Q4e3sDwLOjqxVSbuQY1B+v1PriP53eIaWVs
         C7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743689957; x=1744294757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khXp6kOEsTlpiucdkkgdxNh1P5TojGz8UwRxJaqxnCw=;
        b=kaj1L3CbVw7OJ3ayx9+2QKLj9JIMb9nIkMR3msDPqGIGdAD3TXst34iPiry/IpUMSS
         MjIZ+MfDRlib+gdsYWYO8rY2nwIHC1ohYhfZuG77zVAfAC7HPefrCAK/aqrAS6+VIaK4
         w5DMexMya7DiB+YbznZ5kXzwSHwwxOheO5M1IFXxtO1wiouU9jr/wmAIzCnEdCE0HqtK
         Twc1d3lQ+nWCwWM5g0Yr/iSCWi6eZpecytTHoCQmH+ur+XARwWg09vuQve8KJ1bsIrHV
         6DP6yUaGwjY3Cu6OD94+XSYkAGLoGxVjWiq4C8qkCT+B1rBmxlOWNNHPZYqDnCFE7S1w
         LUyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPuofHEHrnn29czEaeixg7exqoattSwXXGlYyncr3S0gNo9q61pEDOcNHX+VKrK3pu43piR7vAtyR+jOl1oQEkfA==@vger.kernel.org, AJvYcCW0opmxmHgLx+fATb8U+ryVxxjAmPhhD3/HWsk5pjc0CFDc7xidBXN8KERW0ERKoUklr+lCGbzpPAOFTuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YznAqhxPRBj+ixIBVGAoS9fcTVT6a/xpah+9WbkGeY7AQIXoC53
	W5x0/YeMxzO+fOA1KCBiILhz8ajWJmt2e1XLUKoN8S/o+0rM4+98
X-Gm-Gg: ASbGncucOyZnU5eJAhOxuZAed+rMcgrdvcrjZGR5fbk5NRFPxaKnvM7rRMPdScJqI8W
	Un1XrF4yrWFQLD+728MpwMo8mg0eqeRTEFtiBBxAdSUeKCDmG5+3fMqpB2FTv5ai5dMYnT+JQvs
	o5QbcEu5BPX07wTxg7VFaehZsmGzfmHGITpR985BsyJ+l2pWyWyEbFOpluF+wDJUyzVitZ+HSii
	uAXfWSQQLVajUOH5y949RLIiZHE3O0I/x2f4aCc1pYLsJyFVqZLPmqWTKbRJsSkYmiIl61W7hZF
	f0d1QgHniqBGq9bsyjJC6SKs71bqNcSJc3774vQ5o66x
X-Google-Smtp-Source: AGHT+IFsE/53OqOyMfyP3T9KIucSDYD9e9PKK/5G+B7y8ncBc+uPWVYiOMM6K5nKTFIC+KJNWKGDsg==
X-Received: by 2002:a05:6a20:9f4e:b0:1f5:8126:8a5d with SMTP id adf61e73a8af0-2009f5fdf88mr29869754637.17.1743689956462;
        Thu, 03 Apr 2025 07:19:16 -0700 (PDT)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc2d331csm1252459a12.12.2025.04.03.07.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:19:15 -0700 (PDT)
Date: Thu, 3 Apr 2025 10:19:13 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>,
	Ben Gainey <ben.gainey@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Eder Zulian <ezulian@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>,
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Howard Chu <howardchu95@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jann Horn <jannh@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Yang Jihong <yangjihong@bytedance.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Graham Woodward <graham.woodward@arm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Hao Ge <gehao@kylinos.cn>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Casey Chen <cachen@purestorage.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Li Huafei <lihuafei1@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Levi Yun <yeoreum.yun@arm.com>, Weilin Wang <weilin.wang@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Andrew Kreimer <algonell@gmail.com>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Xu Yang <xu.yang_2@nxp.com>,
	Steve Clevenger <scclevenger@os.amperecomputing.com>,
	Zixian Cai <fzczx123@gmail.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Yujie Liu <yujie.liu@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH v1 05/48] tools lib: Silence -Wshorten-64-to-32 warnings
Message-ID: <Z-6Y4dH0bhs6VXmj@thinkpad>
References: <20250401182347.3422199-1-irogers@google.com>
 <20250401182347.3422199-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401182347.3422199-6-irogers@google.com>

On Tue, Apr 01, 2025 at 11:23:03AM -0700, Ian Rogers wrote:
> The clang warning -Wshorten-64-to-32 can be useful to catch
> inadvertent truncation. In some instances this truncation can lead to
> changing the sign of a result, for example, truncation to return an
> int to fit a sort routine. Silence the warning by making the implicit
> truncation explicit.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---

...

> diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
> index 2178862bb114..87bd15e3968e 100644
> --- a/tools/lib/bitmap.c
> +++ b/tools/lib/bitmap.c
> @@ -32,7 +32,7 @@ size_t bitmap_scnprintf(unsigned long *bitmap, unsigned int nbits,
>  			char *buf, size_t size)
>  {
>  	/* current bit is 'cur', most recently seen range is [rbot, rtop] */
> -	unsigned int cur, rbot, rtop;
> +	size_t cur, rbot, rtop;
>  	bool first = true;
>  	size_t ret = 0;

Maybe instead typecast find_next_bit()? We don't expect any of those
to overflow the 'unsigned int'.

Thanks,
Yury
