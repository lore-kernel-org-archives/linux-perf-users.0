From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Understanding perf mem -t load results
Date: Tue, 07 Jan 2014 13:27:01 -0800
Message-ID: <87wqib4h5m.fsf@tassilo.jf.intel.com>
References: <1776760155.10395562.1386857164818.JavaMail.root@insa-lyon.fr>
	<877gb5vmmn.fsf@tassilo.jf.intel.com> <52AE2721.8020501@insa-lyon.fr>
	<20131215234548.GP21717@two.firstfloor.org>
	<CALbiyZzWsDCANnhMsd9bsdqyjYtFNeSNUiUgvs7hSwH-w4ZZWw@mail.gmail.com>
	<CALbiyZy++Wgcoo6J7sbHHN1sWWJJKe36q4Gvtdnb0vOLjQ=nTg@mail.gmail.com>
	<20131224021822.GH20765@two.firstfloor.org>
	<52B93352.2030909@gmail.com>
	<20131224072813.GI20765@two.firstfloor.org>
	<52B93B01.4020305@gmail.com>
	<20131224212728.GK20765@two.firstfloor.org>
	<52BAB2A8.1040709@gmail.com>
	<CALbiyZyUncZZq7mU=+Hk9mYY7q3ugWiiESWSS9RSP-PfwB9u=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59775 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753783AbaAGV1C (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 7 Jan 2014 16:27:02 -0500
In-Reply-To: <CALbiyZyUncZZq7mU=+Hk9mYY7q3ugWiiESWSS9RSP-PfwB9u=w@mail.gmail.com>
	(Manuel Selva's message of "Tue, 7 Jan 2014 16:06:18 +0100")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <selva.manuel@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Manuel Selva <selva.manuel@gmail.com> writes:


> The perf mem record tool use the
> MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD which I guess belongs to the
> memory PEBS events you mentionned (isn't it ?) is reporting

Yes.

> information about the sources of the events. it seems that for this
> purpose the IP information is used, does it mean that what perf mem
> reports can be wrong because of the random IP selection mechanism you
> mentionned ?

The CPU can theoretically execute billions of loads/stores every second.
There is no way any reporting mechanism can keep up with that.
So the only thing you can do is to sample (only collect
every N operations), with a fairly large period.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
