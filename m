From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Does perf randomize the sampling period?
Date: Thu, 10 Sep 2015 08:48:49 -0700
Message-ID: <87r3m68ece.fsf@tassilo.jf.intel.com>
References: <1769534.mDAXVEGQ5L@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31730 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753045AbbIJPtj (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 10 Sep 2015 11:49:39 -0400
In-Reply-To: <1769534.mDAXVEGQ5L@milian-kdab2> (Milian Wolff's message of
	"Wed, 09 Sep 2015 17:11:13 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Milian Wolff <milian.wolff@kdab.com> writes:

> Hey all,
>
> does perf randomize its sampling intervals/period to prevent pattern
> effects?

It does not.

Usually you can get most of the benefits of randomization by using a
prime period with -c.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only
