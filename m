Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nnuYhLkd"
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C9210C9
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Dec 2023 22:34:50 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-35d72bc5cf2so9922915ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Dec 2023 22:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702103690; x=1702708490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=krIB10NVL6AIK6bQuo2cNO3TNm2D4qclSUfhU0mxqUw=;
        b=nnuYhLkd4aHLz0obzM4UiP8CVt3RIRZxtA3ffa1ewi7NEsj+Q3bXBwCpgFEGgG5Imj
         ElHwa0ruFRARD9ho+Hu0emJpAdqDI5u8u/McVbHbDE93V+B1q4X9cjtO3gd2yQDuH4P2
         WdQ2nsB5QaJDajvkHlk2ssAjpmw+0xM/PcAVwtGXHsfpoGUTwy/HjATThjWTEX6WIEgZ
         7t2wkTFJsA0v2K8Ek0rFL7wdGR3H5ZoxDzrtwoMgSCccIasaxeUNwaLHmiDWvOIX2WiY
         +Iu8UAXXX/iU18fg1vUTiAyjgAvQnMOHwgk8FQK2Vpala6gD5nDd1vlvejaRD08r4kHO
         zZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702103690; x=1702708490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krIB10NVL6AIK6bQuo2cNO3TNm2D4qclSUfhU0mxqUw=;
        b=xCuPeugLSc6E4AfIpfpMPKxxzHB+U4onKbkf+WUjfbHdNI7ujgPejwOtdFfkgukt9t
         NMDSw4GkLmX5scU5jMAZHMCJBTko8LIVEaHfFMYMXg7r8evAEU5ZSItZxqBDgK1WWlZ2
         EpH7mx7QUvU/XiuV5KgchNS2x0F4tUP1BvhhPHEmTZCvDWCWt110jvgsmRTxjLdujeQs
         /uvyu1tFWTGI/aMLSGR7fwEw8RoDYkGYtvzhpq1syLaLevj6n27x/55l839nYGfCWZP7
         NZ9ZfPO3JprGOxGZA+svmIZxL9C1qmCJF+ypOrjjC6CSKw+TRUBNICPEyc58Z4t+k1Af
         FGUg==
X-Gm-Message-State: AOJu0YxT8ACpA04Hr/r7vkkkMImLWjORSTUCdG7WOrjewJppp1NCc0Ae
	zQvRxzltKU/pcqh3etZSanO1GQ==
X-Google-Smtp-Source: AGHT+IHNXxdwGP7ugnByuvD+fvW1/pUMQJah2vdsQ62uiEpucd3NS26DZJpzko1ozuv9mFX8lTWgWA==
X-Received: by 2002:a05:6e02:158c:b0:35d:8995:364 with SMTP id m12-20020a056e02158c00b0035d89950364mr2192704ilu.56.1702103689900;
        Fri, 08 Dec 2023 22:34:49 -0800 (PST)
Received: from leoy-yangtze.lan ([94.177.131.71])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001d052d1aaf2sm2700471plh.101.2023.12.08.22.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 22:34:49 -0800 (PST)
Date: Sat, 9 Dec 2023 14:34:40 +0800
From: Leo Yan <leo.yan@linaro.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
	adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
	james.clark@arm.com, mike.leach@linaro.org,
	yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	tmricht@linux.ibm.com, ravi.bangoria@amd.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 1/5] perf mem: Add mem_events into the supported
 perf_pmu
Message-ID: <20231209063440.GE2116834@leoy-yangtze.lan>
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
 <20231207192338.400336-2-kan.liang@linux.intel.com>
 <20231208102922.GB769184@leoy-huanghe.lan>
 <98863f44-4a35-4910-8db0-dbbf0474f6ae@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98863f44-4a35-4910-8db0-dbbf0474f6ae@linux.intel.com>

Hi Kan,

On Fri, Dec 08, 2023 at 01:14:28PM -0500, Liang, Kan wrote:

[...]

> > Now I cannot access a machine for testing Arm SPE, but I will play
> > a bit for this patch set to ensure it can pass compilation.  After
> > that, I will seek Arm maintainers/reviewers help for the test.
> 
> Thanks. I guess I will hold the v3 until the test is done in case there
> are other issues found in ARM.

I will hold on a bit for the test until this patch set addresses the
concern for the breakage issues on Arm64.  Please check my review in
other replies.

Thanks,
Leo
