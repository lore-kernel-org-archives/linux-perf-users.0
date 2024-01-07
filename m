Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E78C1118E
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jan 2024 04:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRMsBe4m"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3606dda206aso6132775ab.3
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Jan 2024 20:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704600510; x=1705205310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zAfQ0Squgs7f3g84+NKtUBvnoJ6EFjDYOhaKBhJp0Gs=;
        b=dRMsBe4mEFmR4yKEIeXkRNHiPQ6A21gPjqdKV3FYWhTVaMeWaWK9RmDDuvNZFVU7lM
         owBCR3hknUEoqk4VyDwhjXo7PjcFd8Nq6QQEZYl5gzP4JlaXBXEjTZzO9rS2QvXE5eyi
         huv9G2KsJZcLCKDFGkNt9wI2ACLE190wclSxwH2Z0EYLMaC1bOOtuaMF2U9p+IT2tOJ4
         NN09ueud5ssqdDIyerCALxlFN31tHHK3ZKLUT9kcDHB9L8VgjzLAEdvHeEIkcKwxtEO4
         BdUi81lPNjY34Ps4TNZr52J7spfJ9e99+ts/8+BCTV6zmsNFRd5iI0LONN8IUuw4DnXI
         7MaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704600510; x=1705205310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAfQ0Squgs7f3g84+NKtUBvnoJ6EFjDYOhaKBhJp0Gs=;
        b=qQj0tx67ntDHSc95AgTQ2JoxQYXAn9PsopKetbFTmr6NT38Y/chjTEG494vYuNNj0c
         1yPVkUzrgZgfmhvYTj93/MpWBmvUGNFWBFGem9aAQwGVQyCoTgrp29rps/K253S3kwdA
         FPCAIRdqCZHmP4YCf/TwpJLPeVFPUheOiPM1Iu9mrcm2etWueNeSaauY40EzKDXDp370
         KQK60brI1jgbS2m2eBtYatNQKzp1q2F9BflHXQE+gCcwWXwzo/F0drZPVPYxrHjy0SMf
         NUgiHoWrjbdoaj6xNHjQtBRvCwtqufjYSPt7Q9gQLx6OjwlNK4E+uGelFuLGOoMAnb7n
         BCCg==
X-Gm-Message-State: AOJu0YymWeKE9G0Ga+V4K2cd91hP3LJFpmOA5kLqo1vCre39peCE1G3S
	FdyTSCrf6tH/fHDRA1akEhjLjRZB1RNL6w==
X-Google-Smtp-Source: AGHT+IGs1yr94hdjI881c3pc1CaOyhKTwKJ1sG25C8SPR3cFLbyYOhNQqq5Wdmkfr+lUJorTxZIGFg==
X-Received: by 2002:a05:6e02:180d:b0:360:24:dabe with SMTP id a13-20020a056e02180d00b003600024dabemr4097995ilv.48.1704600510277;
        Sat, 06 Jan 2024 20:08:30 -0800 (PST)
Received: from debian-dev (211-75-219-200.hinet-ip.hinet.net. [211.75.219.200])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b001d072365b87sm3766623plg.106.2024.01.06.20.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 20:08:29 -0800 (PST)
Date: Sun, 7 Jan 2024 12:08:21 +0800
From: Leo Yan <leo.yan@linaro.org>
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
	adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
	james.clark@arm.com, mike.leach@linaro.org,
	yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	tmricht@linux.ibm.com, ravi.bangoria@amd.com,
	atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V3 0/7] Clean up perf mem
Message-ID: <20240107040740.GA888@debian-dev>
References: <20231213195154.1085945-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213195154.1085945-1-kan.liang@linux.intel.com>

On Wed, Dec 13, 2023 at 11:51:47AM -0800, kan.liang@linux.intel.com wrote:

[...]

> Introduce generic functions perf_mem_events__ptr(),
> perf_mem_events__name() ,and is_mem_loads_aux_event() to replace the
> ARCH specific ones.
> Simplify the perf_mem_event__supported().
> 
> Only keeps the ARCH-specific perf_mem_events array in the corresponding
> mem-events.c for each ARCH.
> 
> There is no functional change.
> 
> The patch set touches almost all the ARCHs, Intel, AMD, ARM, Power and
> etc. But I can only test it on two Intel platforms.
> Please give it try, if you have machines with other ARCHs.
> 
> Here are the test results:
> Intel hybrid machine:
> 
> $perf mem record -e list
> ldlat-loads  : available
> ldlat-stores : available
> 
> $perf mem record -e ldlat-loads -v --ldlat 50
> calling: record -e cpu_atom/mem-loads,ldlat=50/P -e cpu_core/mem-loads,ldlat=50/P
> 
> $perf mem record -v
> calling: record -e cpu_atom/mem-loads,ldlat=30/P -e cpu_atom/mem-stores/P -e cpu_core/mem-loads,ldlat=30/P -e cpu_core/mem-stores/P
> 
> $perf mem record -t store -v
> calling: record -e cpu_atom/mem-stores/P -e cpu_core/mem-stores/P
> 
> 
> Intel SPR:
> $perf mem record -e list
> ldlat-loads  : available
> ldlat-stores : available
> 
> $perf mem record -e ldlat-loads -v --ldlat 50
> calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=50/}:P
> 
> $perf mem record -v
> calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=30/}:P -e cpu/mem-stores/P
> 
> $perf mem record -t store -v
> calling: record -e cpu/mem-stores/P

After applying this series, below tests pass with Arm SPE:

# ./perf c2c record -- /home/leoy/false_sharing.exe 2
# ./perf c2c report

# ./perf mem record -e list
# ./perf mem record -e spe-load -v --ldlat 50
# ./perf mem record -v
# ./perf mem report
# ./perf mem record -t store -v
# ./perf mem report

Tested-by: Leo Yan <leo.yan@linaro.org>
