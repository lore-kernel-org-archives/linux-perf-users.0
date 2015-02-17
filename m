From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Despite exclude_host=1, I see PERF_RECORD_MISC_KERNEL samples
Date: Tue, 17 Feb 2015 12:33:41 -0800
Message-ID: <878ufwxopm.fsf@tassilo.jf.intel.com>
References: <CAL2Y34BuNJ5Hiv-p5ZDJACzeimLa2jqC6i_H_=mbJ1+Vn-aP2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60174 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686AbbBQUdm (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 17 Feb 2015 15:33:42 -0500
In-Reply-To: <CAL2Y34BuNJ5Hiv-p5ZDJACzeimLa2jqC6i_H_=mbJ1+Vn-aP2w@mail.gmail.com>
	(Elazar Leibovich's message of "Thu, 12 Feb 2015 15:37:05 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Elazar Leibovich <elazar.leibovich@ravellosystems.com>
Cc: linux-perf-users@vger.kernel.org, Izik Eidus <izik.eidus@ravellosystems.com>

Elazar Leibovich <elazar.leibovich@ravellosystems.com> writes:
>
> While most of the samples I see have misc event of
> PERF_RECORD_MISC_GUEST_KERNEL or PERF_RECORD_MISC_GUEST_USER, I still
> see a very small amount of samples with PERF_RECORD_MISC_KERNEL
> (1280/345161=0.38%).

This can happen due to skid (PMI firing much later than the trigger).
It usually goes away when you enable precise which reduces the skid
enough that it is very rare.

There was some discussion to add a software filter for this
case, but so far nobody has bothered.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
