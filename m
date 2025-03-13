Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E71267B77
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Mar 2025 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875141; cv=none; b=WIKHMnriKF2jhBEGlEdhbOY2HH6smyYsRJKNaLPBhXJG+Gi0YWNlGwRrDrNptZ3LRt79jB2ZmurNZ1PCp0TyC7SW9+N0tREY6ktUGiR2tC90Pf7Ovopqt0iGSU+g6IZbYv9y85LYY7Z+GKTsobVrhp0PbN6bjugyfS0eAfnvTbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875141; c=relaxed/simple;
	bh=EQb0SSqK+nGH9Bh8+yrxOQuY4w2JsbtSQJQgNEbhL5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCngEtAv9h8UvavVdfm2UgRHRHEqtuoZctXnSN8CIj1R3MG8YmWuIhh6QN9rA7n+B4O4Se1At1fxjUcBDrgw1CeGKz4cC2eE4L8AcMbCWpEuwC0QLLRc4zgqh9CNSn/3srvUGwiZndbKPjf/+fLNC/qbiS1NrXX4bMb2Jf1Dzng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvDU8a+0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvDU8a+0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741875135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xTSCTViFsCC8M3AWW7+HEFBBSa3sEutKnMAaO+/MsLQ=;
	b=MvDU8a+0jLgMjbq4ump1yzYjjpxsx3LPnTHgmG5ho/QKHQInVLKmnbts+pB+fllFdGMVgm
	o6JZi63lNnP7lrV+3c2CN1AqTo8Y9WuQQYUMbBhL+YBSIgB5OtzJ+lfiTmp67evL1/rlrg
	MZpkBfqFEwt7T/XNdlYLS+ou7EtGVPc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-8gUCB3avNLKN9SPwjjF6tA-1; Thu, 13 Mar 2025 10:12:13 -0400
X-MC-Unique: 8gUCB3avNLKN9SPwjjF6tA-1
X-Mimecast-MFC-AGG-ID: 8gUCB3avNLKN9SPwjjF6tA_1741875133
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e900f6dcadso23035226d6.3
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Mar 2025 07:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741875133; x=1742479933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTSCTViFsCC8M3AWW7+HEFBBSa3sEutKnMAaO+/MsLQ=;
        b=t77zk/dHMpnHI4PAeMpUVNZTZNgrataunJ7lLpnF1pcQ7YHn6Wd1pFj6vPcR1H9z8B
         WOuVvtOIHTXJI1+h8Z7aSw73UVA929Ii36S0mo4+KAurcW/aShFs3gM+1FWgQtIyc/Tg
         HbgJU/mcDO+zJK4/Y8T7dueQffXqHf8U9k4R++37Uu6YRJatyuCVCp580sWSy+uQZxrj
         ItLHuyCirAYX+B61FeGEdRaNOjgSG7XYRsxDVfok5ClB2M3txnI/qnpejj0yzCdEF879
         zGo3seN0OUwkbPxEtIHceOuSOkcoFPGLJu/SDLKzIQDv6olyoHXmHJJtG2/21CkSHUFu
         7ENw==
X-Forwarded-Encrypted: i=1; AJvYcCWvga9exX2DLhDFCkOiAXz8cE3FuI05tI2227SyEpBqQGMSPIzjDbExpUTY1cfhfpFCuk/1pAE1LXyDpSMv7Ssd@vger.kernel.org
X-Gm-Message-State: AOJu0YwuEN8A4pTLNQYMeVPcK+T0lsnnrivaYUownF0DqErUsnZ6HrqX
	24U8lrlEf9sfPgk/sX3D80geZ4+pcpnGEv4jlG5vz4NSBMhonw4YzR0SUDg4H51igPuMC/ZyLlv
	DiUYSQfUa977Y0PFnbpaJMKGnkGtUNORep24kzea/yxU4jnZrb4bydaOQyG4LBKQpo6Y=
X-Gm-Gg: ASbGncuaT19u2IkOjJkuZknV2aGxliumaXMEq3TyyP0MgAsEqVTOaB5mvXDUXncapHb
	qWgaI3RmhmTSO9f4/ZGUBiILfAmIAyJWvP4uBA/FPEzRqkW3KVVNOYOZQ2DQueSVTbA8vcghs8R
	3HrK+1DXsX8Q3vhrn+V7pxnf6CCOBygOSFWPWzuKzsnrApkYuoEJDQqHEWtXc+3k/zMpUoycoCw
	WrHzog0xUQ/EO7E7ntpEgXP26swVCxQgVg3heGhJ4D245Q4vm4hEkyT6Tlsu1oJWRHonoS5AmqI
	grvC0YU7IYM=
X-Received: by 2002:ad4:5beb:0:b0:6e8:ed7f:1a79 with SMTP id 6a1803df08f44-6e9006773e7mr422214876d6.32.1741875133036;
        Thu, 13 Mar 2025 07:12:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSdv1Udz8OiduVCV/r0UNSUpke1W8wSfiJZ1L2LpzbF7s+BBan2QBwjnmyG0rUa71XbBcyYw==
X-Received: by 2002:ad4:5beb:0:b0:6e8:ed7f:1a79 with SMTP id 6a1803df08f44-6e9006773e7mr422214486d6.32.1741875132694;
        Thu, 13 Mar 2025 07:12:12 -0700 (PDT)
Received: from thinkpad2024 ([71.217.65.43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade330c68sm9983166d6.82.2025.03.13.07.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:12:12 -0700 (PDT)
Date: Thu, 13 Mar 2025 10:12:09 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] Introduce a C extension module to allow libperf
 usage from python
Message-ID: <Z9LnuXCvK5P5KCiU@thinkpad2024>
References: <20250313075126.547881-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313075126.547881-1-gautam@linux.ibm.com>

Hello Gautam

On Thu, Mar 13, 2025 at 01:21:21PM +0530, Gautam Menghani wrote:
> In this RFC series, we are introducing a C extension module to allow
> python programs to call the libperf API functions. Currently libperf can
> be used by C programs, but expanding the support to python is beneficial
> for python users.
> 
> The structure of the patch series is as follows:
> 1. Patch 1 : Create wrappers for the perf structs which are used by
> examples/counting.c
> 
> 2. Patch 2: Create the C extension module that maps and exposes the
> libperf functions to python programs

May I ask why you are not using SWIG? With libcpupower the kernel has
already been using SWIG to generate Python bindings for a C user-space API.

This has several advantages including a much smaller footprint (you only
need to copy the header definitions into a .swg file), can generate for
several languages (Perl, Ruby, Java and C#), and SWIG is an active,
tested, and mature piece of software code that has been around for
almost as long as the Linux kernel.

Python bindings including the makefile as an example:
https://elixir.bootlin.com/linux/v6.13.6/source/tools/power/cpupower/bindings/python

How to use the bindings in a script:
https://elixir.bootlin.com/linux/v6.13.6/source/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py

Original discussion:
https://lore.kernel.org/linux-pm/20240724221122.54601-1-jwyatt@redhat.com/

SWIG has been pretty useful as it helped me find two issues in the
libcpupower API that have been around for over 10 years:
https://lore.kernel.org/linux-pm/20240905021916.15938-1-jwyatt@redhat.com/T/#mf04b4ba93f79fe68c20c1d88d8ed966164a1c7d7
https://lore.kernel.org/linux-pm/20250305210901.24177-1-jwyatt@redhat.com/

> 
> 2. Patch 3: A python variant of counting.c - counting.py to demonstrate
> the usage of libperf from python
> 
> We have not added support for entire libperf, as we want to get
> community feedback on the approach taken in this series.
> 
> Gautam Menghani (3):
>   libperf: Introduce wrappers for perf structs to be exposed to python
>   libperf: Introduce a C extension module for python
>   libperf: Add counting.py example to demonstrate libperf usage from
>     python
> 
>  tools/lib/perf/Build                          |   1 +
>  .../perf/Documentation/examples/counting.py   |  74 +++
>  tools/lib/perf/Makefile                       |  12 +-
>  tools/lib/perf/include/perf/py_perf.h         | 431 ++++++++++++++++++
>  tools/lib/perf/libperf.map                    |   1 +
>  tools/lib/perf/py_perf.c                      | 262 +++++++++++
>  6 files changed, 779 insertions(+), 2 deletions(-)
>  create mode 100755 tools/lib/perf/Documentation/examples/counting.py
>  create mode 100644 tools/lib/perf/include/perf/py_perf.h
>  create mode 100644 tools/lib/perf/py_perf.c
> 
> -- 
> 2.47.0
> 

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat

