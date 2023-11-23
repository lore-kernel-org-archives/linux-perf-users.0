Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444E611C87
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Nov 2023 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2N6V6Bnv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2437C433C8;
	Thu, 23 Nov 2023 08:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700729006;
	bh=X6UC0tS12SQOCt0lR7U1b/1JhPu/SkTtugMUqL64nTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2N6V6BnvIGAbQBN7qjltzbQX/le4K1s3yx/Ywvi7F9BJ4Tg4y8sy4LAxaEwKx2sII
	 MrsHGYW8KibdChXzs4600b9I05tS8EtTzTCXHms8G3V2g2/Y35t/AOul65Qh0IJYqb
	 w9QQ5c8wKtD5Go2Jd004YKdSfiaJPi1eXTK14TIs=
Date: Thu, 23 Nov 2023 08:43:21 +0000
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
Message-ID: <2023112312-sandbar-emu-fbb1@gregkh>
References: <aca1eb79-5dee-4634-8727-eebb251c9e1e@linux.ibm.com>
 <2023112248-unskilled-flagman-05e6@gregkh>
 <2be9c97e-3208-4deb-8172-004601aabc7e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2be9c97e-3208-4deb-8172-004601aabc7e@linux.ibm.com>

On Thu, Nov 23, 2023 at 08:54:19AM +0100, Thomas Richter wrote:
> On 11/22/23 10:31, Greg KH wrote:
> > On Wed, Nov 22, 2023 at 08:38:28AM +0100, Thomas Richter wrote:
> >> perf tool fails on linux-next since Nov 16th on s390 when invoking perf on
> >> any PMU event, as in
> >>
> >>   # perf stat -e cycles -- true
> >>
> >>    Performance counter stats for 'true':
> >>
> >>      <not supported>      cycles                                                               
> >>
> >>        0.000598399 seconds time elapsed
> >>
> >>        0.000055000 seconds user
> >>        0.000567000 seconds sys
> >>
> >>   # perf stat -e pai_ext/NNPA_ALL/ -C0 -- true
> >>   event syntax error: 'pai_ext/NNPA_ALL/'
> >>                        \___ Bad event or PMU
> >>
> >>   Unable to find PMU or event on a PMU of 'pai_ext'
> >>
> >>   Initial error:
> >>   event syntax error: 'pai_ext/NNPA_ALL/'
> >>                        \___ Cannot find PMU `pai_ext'. Missing kernel support?
> >>   #
> >>
> >> This error is caused by following commit, which got into linux-next around November 15th:
> >>
> >> commit 652ffc2104ec1f69dd4a46313888c33527145ccf
> >> Author: Greg KH <gregkh@linuxfoundation.org>
> >> Date:   Mon Jun 12 15:09:09 2023 +0200
> >>
> >>     perf/core: Fix narrow startup race when creating the perf nr_addr_filters sysfs file
> >>
> >>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>     Link: https://lkml.kernel.org/r/2023061204-decal-flyable-6090@gregkh
> >>
> >> This commit adds function pmu_dev_is_visible() as the PMU bus function
> >> to make sysfs attribute files visible.
> >> On a failing system these sysfs attribute files are exported:
> >>
> >> #  ll /sys/devices/pai_ext/
> >> drwxr-xr-x. 2 root root    0 Nov 21 14:59 events
> >> drwxr-xr-x. 2 root root    0 Nov 21 14:59 format
> >> lrwxrwxrwx. 1 root root    0 Nov 21 14:43 subsystem -> ../../bus/event_source
> >> -rw-r--r--. 1 root root 4096 Nov 21 14:43 uevent
> >> #
> > 
> > /sys/devices/pai_ext/ is a real device?  Why there?  That's a very odd
> > location, what type of device is this?
> 
> S390 has 5 different PMU devices, all show up at /sys/devices/ directory:
> drwxr-xr-x   4 root root 0 Nov 22 14:30 cpum_cf
> drwxr-xr-x   4 root root 0 Nov 22 14:30 cpum_cf_diag
> drwxr-xr-x   4 root root 0 Nov 22 14:30 cpum_sf
> drwxr-xr-x   4 root root 0 Nov 22 14:30 pai_crypto
> drwxr-xr-x   4 root root 0 Nov 22 14:30 pai_ext

And that's messed up, we need to put them in the "proper" place, in
either a bus-specific directory, or somewhere lower, they shouldn't be
in the "root" of the device hierarchy which is what I think started this
whole conversation a while ago.

I'll work on that as a different patch...

thanks,

greg k-h
