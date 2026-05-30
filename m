Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C19FF9D9;
	Sat, 30 May 2026 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780099307; cv=none; b=pBHcj1PRhvsmaQ4ZO2RAMOPTS4F30Heabyw31+iw9LDrZLwJTuxK7lRjLfX77ph1C4c9R/hGgqBxX2rZEkKuXbP/PTidsQ1y5JZm5g9Mb34vNb+QKL9O/7J44ckmZQubhE6HrbqdFRFWs+TgRA4ExQcN2hmiFPFFlr2YMM3zITM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780099307; c=relaxed/simple;
	bh=yqwLwB2B9kljwikF1bhuqrCPOFR4NH6d4jtMMgaDC5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZIAh8XS6+/5/4+Hl9cmCDxwlqoFPrD40qDTmZfzX52HjwaE1+Dg32OxXUbH2GKQ9Ai+LnIlbAWohxfVZLQsxGMT/M+LEELPYqNz8mgywlwxLTY6fnKAx5jqjE8iy8RX992iExDJc7toI7f/XBzaDGDt2h3Ern9YIUEOGGttBvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChyQpitP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChyQpitP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDAD1F00893;
	Sat, 30 May 2026 00:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780099306;
	bh=D7djoSGosrfa+muilz6GgByxSVGvd52+1HJJvvuJ18E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ChyQpitPiqWnIx0Nb8Lf1UGm93rS8OURyYiFBTu5X0V5gvrXXUpQ8FLpjpAkhvXRY
	 KozcQ/JGrGWhmwJVxgHYuFxM6fqrkgOg8CooVIeLxSMGT5QGlO4Il5VKJVcT1cnbur
	 qz/uKcdFVtSoXpf9Bd+emBDbhMUqTWos/oLo3xOTZUHvwyDUJYr2d1qYjw1Wdk3SZp
	 IeLnwIECrkTkPr2VvmWTILYOBtb7+dWkB8ZOjIiXYLK2m5bZxsBH3yM/boAG3MpTXC
	 QusmEKp8HKecTgW3bcOFw7g4spSQJ3TJ5uwgJE/tY70dYBuVRgDB/6OKslKPydcdb5
	 F7nQmGu2ca5/g==
Date: Fri, 29 May 2026 21:01:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Tejas Manhas <tejas05@linux.ibm.com>
Cc: Gautam Menghani <Gautam.Menghani@ibm.com>, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	atrajeev@linux.ibm.com, Gautam Menghani <gautam@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script powerpc: Update the hcall list with new
 hcalls
Message-ID: <ahoo5dI-6fVlFvvR@x1>
References: <20260512084654.57729-1-Gautam.Menghani@ibm.com>
 <61c8d600-72b4-4320-a1ff-18e061569f24@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61c8d600-72b4-4320-a1ff-18e061569f24@linux.ibm.com>

On Wed, May 20, 2026 at 09:25:08AM +0530, Tejas Manhas wrote:
> From: Gautam Menghani [1]<gautam@linux.ibm.com>
> 
> Update the hcall list with the hcalls in bcc's ppchcalls script [1].
> 
> [1] : [2]https://github.com/iovisor/bcc/blob/master/tools/ppchcalls.py
> 
> 
> Hi Gautam,
> 
> This patch doesn't seem to resolve the issue where numbers are seen instead of h
> calls.
> I have applied to the latest upstream but the numbers are still visible in perf
> script.
> Also the command doesn't recognise python-audit already present in the system.
> 
> Please find logs below for better understanding.

Any progress on this?

- Arnaldo
 
> before patch
> # perf record -a -e powerpc:hcall* sleep 10
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.343 MB perf.data (2388 samples) ]
> [root@ltcden14-lp10 perf]# perf script  -s ./powerpc-hcalls.py -i ./perf.data
> Install the python-audit package to get syscall names.
> For example:
>   # apt-get install python3-audit (Ubuntu)
>   # yum install python3-audit (Fedora)
>   etc.
> 
> hcall                            count   min(ns)   max(ns)   avg(ns)
> --------------------------------------------------------------------
> H_VIO_SIGNAL                       614       376     14068      1644
> 584                                 36      1094     16120      2839
> H_ADD_LOGICAL_LAN_BUFFER             9       660      3572      1320
> H_STUFF_TCE                        132       632     12530      1310
> H_PUT_TCE                          236       466      5500       865
> H_RANDOM                             4       446      3300      1168
> H_PUT_TCE_INDIRECT                  53       648     14318      2066
> H_SEND_CRQ                         108       848      7754      1983
> after patch
> # yum install python3-audit
> Updating Subscription Management repositories.
> Unable to read consumer identity
> 
> This system is not registered with an entitlement server. You can use subscripti
> on-manager to register.
> 
> rhe12_debug1                                    8.4 kB/s | 1.5 kB     00:00
> rh102_base_upd                                   41 kB/s | 2.7 kB     00:00
> rh102_app_upd                                    14 kB/s | 2.8 kB     00:00
> rh102_crb                                        14 kB/s | 2.7 kB     00:00
> rh102_srcbase                                   7.6 kB/s | 1.5 kB     00:00
> rh102_srcas                                     6.9 kB/s | 1.5 kB     00:00
> rh102_debug                                     7.1 kB/s | 1.5 kB     00:00
> rhe102_debug1                                   7.1 kB/s | 1.5 kB     00:00
> Package python3-audit-4.0.3-5.el10.ppc64le is already installed.
> Dependencies resolved.
> Nothing to do.
> Complete!
> # ./perf script -s scripts/python/powerpc-hcalls.py -i ./perf.data
> Install the python-audit package to get syscall names.
> For example:
>   # apt-get install python3-audit (Ubuntu)
>   # yum install python3-audit (Fedora)
>   etc.
> 
> hcall                            count   min(ns)   max(ns)   avg(ns)
> --------------------------------------------------------------------
> H_VIO_SIGNAL                       533       404     13154      1638
> 584                                 37      1034     14722      3178
> H_ADD_LOGICAL_LAN_BUFFER             8       802      2602      1217
> H_SEND_CRQ                          11       926     17536      4105
> H_STUFF_TCE                         13       658      5306      1974
> H_PUT_TCE                           18       476      5034      1476
> H_PUT_TCE_INDIRECT                   5      1698      8934      4370
> [root@ltcden14-lp10 perf]#
> 
> Please add the tag below.
> Reported-by: Tejas Manhas [4]<tejas05@linux.ibm.com>
> 
> Thanks & Regards,
> Tejas
> 
> References
> 
>    1. mailto:gautam@linux.ibm.com
>    2. https://github.com/iovisor/bcc/blob/master/tools/ppchcalls.py
>    3. mailto:gautam@linux.ibm.com
>    4. mailto:tejas05@linux.ibm.com
