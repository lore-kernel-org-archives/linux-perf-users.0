From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Understanding perf mem -t load results
Date: Tue, 24 Dec 2013 22:27:28 +0100
Message-ID: <20131224212728.GK20765@two.firstfloor.org>
References: <1776760155.10395562.1386857164818.JavaMail.root@insa-lyon.fr>
 <877gb5vmmn.fsf@tassilo.jf.intel.com>
 <52AE2721.8020501@insa-lyon.fr>
 <20131215234548.GP21717@two.firstfloor.org>
 <CALbiyZzWsDCANnhMsd9bsdqyjYtFNeSNUiUgvs7hSwH-w4ZZWw@mail.gmail.com>
 <CALbiyZy++Wgcoo6J7sbHHN1sWWJJKe36q4Gvtdnb0vOLjQ=nTg@mail.gmail.com>
 <20131224021822.GH20765@two.firstfloor.org>
 <52B93352.2030909@gmail.com>
 <20131224072813.GI20765@two.firstfloor.org>
 <52B93B01.4020305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:55397 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab3LXV1a (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 24 Dec 2013 16:27:30 -0500
Content-Disposition: inline
In-Reply-To: <52B93B01.4020305@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <selva.manuel@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

> I checked what can be measured with the offcore facility. I can ask
> to count remote memory accesses, but now I am not sure PEBS is
> enable for these events. If the answer is no, I can't accurately
> identify remote memory accesses with offcore events ? As a
> consequence I am wondering if there is a way to do such thing ?

The OFFCORE events are not PEBS enabled. However the memory PEBS
events report the same information (with some limitations) in
the PEBS record (and perf reports this information) 

In general you cannot accurately profile all memory accesses.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
