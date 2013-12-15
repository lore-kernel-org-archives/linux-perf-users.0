From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Understanding perf mem -t load results
Date: Mon, 16 Dec 2013 00:45:48 +0100
Message-ID: <20131215234548.GP21717@two.firstfloor.org>
References: <1776760155.10395562.1386857164818.JavaMail.root@insa-lyon.fr>
 <877gb5vmmn.fsf@tassilo.jf.intel.com>
 <52AE2721.8020501@insa-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:55463 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab3LOXpt (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 15 Dec 2013 18:45:49 -0500
Content-Disposition: inline
In-Reply-To: <52AE2721.8020501@insa-lyon.fr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <manuel.selva@insa-lyon.fr>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

On Sun, Dec 15, 2013 at 11:03:13PM +0100, Manuel Selva wrote:
> Thanks for the answer Andi.
> 
> Is there any way (I couldn't find in the Intel documentation) to
> have an approximation of the "maximum" acceptable frequency ?

It depends on how much overhead is acceptable and how you configure
perf (which affects the cost of the handler) and what the executed 
code does. You could tune it to minimize throttles.

I would start with something like 20003

If you only want the relative ratios of course using perf stat would
be better.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
