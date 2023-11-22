Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE353DB9D
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2023 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ybOBnr3m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C4EC433CA;
	Wed, 22 Nov 2023 09:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700645487;
	bh=wuQbmKuP8ke77VDsHsQadgcU9siRkJrWGwGpsyHIPjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ybOBnr3mSLnqTxX8lj1dwt0OGddS/Rv0+lBbPy/LqzmfvANnWbPPavBuVS6M7EPcA
	 n5TOAjVOG9Et3y/DJit2uTIIroym80pkrLzBJCQKIarI/p9rBlNNTuGGsh10wSpRl6
	 2n/IjLhHom4C4Rhfw6PSRa+tGNITQtUSh3POpV3w=
Date: Wed, 22 Nov 2023 09:31:24 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: Re: REGRESSION linux-next since Nov 16th, perf tool broken (at least
 on s390)
Message-ID: <2023112248-unskilled-flagman-05e6@gregkh>
References: <aca1eb79-5dee-4634-8727-eebb251c9e1e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aca1eb79-5dee-4634-8727-eebb251c9e1e@linux.ibm.com>

On Wed, Nov 22, 2023 at 08:38:28AM +0100, Thomas Richter wrote:
> perf tool fails on linux-next since Nov 16th on s390 when invoking perf on
> any PMU event, as in
> 
>   # perf stat -e cycles -- true
> 
>    Performance counter stats for 'true':
> 
>      <not supported>      cycles                                                               
> 
>        0.000598399 seconds time elapsed
> 
>        0.000055000 seconds user
>        0.000567000 seconds sys
> 
>   # perf stat -e pai_ext/NNPA_ALL/ -C0 -- true
>   event syntax error: 'pai_ext/NNPA_ALL/'
>                        \___ Bad event or PMU
> 
>   Unable to find PMU or event on a PMU of 'pai_ext'
> 
>   Initial error:
>   event syntax error: 'pai_ext/NNPA_ALL/'
>                        \___ Cannot find PMU `pai_ext'. Missing kernel support?
>   #
> 
> This error is caused by following commit, which got into linux-next around November 15th:
> 
> commit 652ffc2104ec1f69dd4a46313888c33527145ccf
> Author: Greg KH <gregkh@linuxfoundation.org>
> Date:   Mon Jun 12 15:09:09 2023 +0200
> 
>     perf/core: Fix narrow startup race when creating the perf nr_addr_filters sysfs file
> 
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>     Link: https://lkml.kernel.org/r/2023061204-decal-flyable-6090@gregkh
> 
> This commit adds function pmu_dev_is_visible() as the PMU bus function
> to make sysfs attribute files visible.
> On a failing system these sysfs attribute files are exported:
> 
> #  ll /sys/devices/pai_ext/
> drwxr-xr-x. 2 root root    0 Nov 21 14:59 events
> drwxr-xr-x. 2 root root    0 Nov 21 14:59 format
> lrwxrwxrwx. 1 root root    0 Nov 21 14:43 subsystem -> ../../bus/event_source
> -rw-r--r--. 1 root root 4096 Nov 21 14:43 uevent
> #

/sys/devices/pai_ext/ is a real device?  Why there?  That's a very odd
location, what type of device is this?

> These is no file named 'type'. Other files are also missing.
> Therefore the perf tool can not access any PMU event defined by this PMU.
> 
> On a system with proper export of all PMU sysfs attributes (same linux-next kernel):
> #  ll /sys/devices/pai_crypto/
> total 0
> drwxr-xr-x. 2 root root    0 Nov 21 14:44 events
> drwxr-xr-x. 2 root root    0 Nov 21 14:44 format
> -r--r--r--. 1 root root 4096 Nov 21 14:44 nr_addr_filters
> -rw-r--r--. 1 root root 4096 Nov 21 14:44 perf_event_mux_interval_ms
> lrwxrwxrwx. 1 root root    0 Nov 21 14:43 subsystem -> ../../bus/event_source
> -r--r--r--. 1 root root 4096 Nov 21 14:44 type
> -rw-r--r--. 1 root root 4096 Nov 21 14:44 uevent

Ick, again, a "root" device?  That's not right and needs to be fixed
first.

> # cat /sys/devices/pai_crypto/type
> 12
> #
> 
> Also on such a system the perf stat works again:
> # perf stat -e pai_crypto/CRYPTO_ALL/ -C0 -- true
> 
>  Performance counter stats for 'CPU(s) 0':
> 
>                  0      pai_crypto/CRYPTO_ALL/
> 
>        0.000741258 seconds time elapsed
> 
> #
> 
> On s390 there is no need to export sysfs file 'nr_addr_filters', but setting
> this member pmu::nr_addr_filters to a non-zero value before
> calling perf_pmu_register() exhibits the old behavior again.
> 
> In my opinion this breaks previous behavior.
> 
> Is this intended?
> How to fix this?

Looks like no attributes are exported unless nr_addr_filters is present
in the device, right?  That's the way the patch was written, maybe the
change is not correct?  I wrote it a while ago, sorry, I can't
remember...

thanks,

greg k-h
