From: Andi Kleen <andi@firstfloor.org>
Subject: Re: First time user, problem with toplev.py levels (-l)
Date: Wed, 25 Sep 2013 08:24:45 -0700
Message-ID: <87ob7gsz42.fsf@tassilo.jf.intel.com>
References: <CAA2XHbcy6qSvm_s=XPdp3GuXHgTAQqtiDZ1cgvM5rZMF9f00RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59250 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755499Ab3IYPYr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 25 Sep 2013 11:24:47 -0400
In-Reply-To: <CAA2XHbcy6qSvm_s=XPdp3GuXHgTAQqtiDZ1cgvM5rZMF9f00RQ@mail.gmail.com>
	(Luke Gorrie's message of "Wed, 25 Sep 2013 13:44:41 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Luke Gorrie <luke@snabb.co>
Cc: linux-perf-users@vger.kernel.org

Luke Gorrie <luke@snabb.co> writes:

> I'm a first-time user of toplev.py today. The -l option isn't working
> for me, and I'm wondering if someone can help me understand why?
>
> I've tested with a few different programs under test and combinations
> of -l<n>, -v, and -d. No luck yet. Here's an example below:

What CPU do you have (head -n20 /proc/cpuinfo) ? 

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
