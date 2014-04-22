From: Andi Kleen <andi@firstfloor.org>
Subject: Re: recording rapl/power events
Date: Tue, 22 Apr 2014 03:17:56 -0700
Message-ID: <87ppk9brcb.fsf@tassilo.jf.intel.com>
References: <5354D05C.8080201@metascale.org>
	<alpine.DEB.2.10.1404211004570.10033@vincent-weaver-1.um.maine.edu>
	<5355D46A.4090209@metascale.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54272 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755726AbaDVKR6 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 22 Apr 2014 06:17:58 -0400
In-Reply-To: <5355D46A.4090209@metascale.org> (Adrien BAK's message of "Tue,
	22 Apr 2014 11:31:06 +0900")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Adrien BAK <adrien.bak@metascale.org>
Cc: Vince Weaver <vincent.weaver@maine.edu>, linux-perf-users@vger.kernel.org

Adrien BAK <adrien.bak@metascale.org> writes:
>
> This looks promising, although I couldn't find any useful
> documentation on this. Do you know if the perf userland tool allows
> for this kind of slave-sampling or if I have to build my own tool
> around the perf_event API ?

perf record supports it (with :S), but none of the reporting tools
unfortunately.

However keep in mind that very rapid sampling of RAPL is not
likely to give useful results. The data only really makes
sense over longer intervals.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
