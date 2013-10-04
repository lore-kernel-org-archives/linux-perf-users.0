From: Andi Kleen <andi@firstfloor.org>
Subject: Re: measure uncore events
Date: Fri, 4 Oct 2013 15:35:03 +0200
Message-ID: <20131004133503.GE6882@two.firstfloor.org>
References: <CAJh9x3o3au3ouwn4TTPt+CGyh3bo_u0Qo5LiKshe3HmSY7er4w@mail.gmail.com>
 <87d2nltypp.fsf@tassilo.jf.intel.com>
 <alpine.DEB.2.10.1310040918420.19931@vincent-weaver-1.um.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:41620 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531Ab3JDNfH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Oct 2013 09:35:07 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1310040918420.19931@vincent-weaver-1.um.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: Andi Kleen <andi@firstfloor.org>, Yuanfang Chen <cyfmxc@gmail.com>, linux-perf-users@vger.kernel.org

> are you sure about that?  Support for plain Ivybridge Model 58 uncore
> (which I assume this machine has) was added in Linux 3.10.  
> 
> Or are there low-end mobile IvyBridge chips that lack uncore support?

There's no support for measuring the memory controller and various
other interesting units. We only have that on the server parts.

Yes you're right some basic CBOX support exist, but that wasn't
what the poster was looking for.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
