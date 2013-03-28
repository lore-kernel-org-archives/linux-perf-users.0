From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perf event attrributes
Date: Wed, 27 Mar 2013 18:32:04 -0700
Message-ID: <m2boa4ia23.fsf@firstfloor.org>
References: <0C53B16FB1F182409A7BA6DC928E7AFE1FDA4F@039-SN2MPN1-022.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:15117 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755474Ab3C1BcH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 27 Mar 2013 21:32:07 -0400
In-Reply-To: <0C53B16FB1F182409A7BA6DC928E7AFE1FDA4F@039-SN2MPN1-022.039d.mgd.msft.net>
	(Freehill Christopher-RAT's message of "Wed, 27 Mar 2013 15:40:38
	+0000")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Freehill Christopher-RAT063 <RAT063@freescale.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

Freehill Christopher-RAT063 <RAT063@freescale.com> writes:
>
> Any info or suggestions are appreciated.

The perf model for this is to use bit fields in config/config1 and then
declare those in sysfs, so that they can be set as cpu/foo=1,bar=2/
The kernel driver then extracts those fields.

This only supports numerical values, not string enumerations.

You can see the Intel uncore drivers as a example doing this extensively.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
