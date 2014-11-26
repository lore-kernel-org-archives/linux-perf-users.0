From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Size of perf data files
Date: Wed, 26 Nov 2014 12:48:59 -0800
Message-ID: <871topit6s.fsf@tassilo.jf.intel.com>
References: <1601237.BEhNSa8l6d@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6430 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793AbaKZUtB (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 26 Nov 2014 15:49:01 -0500
In-Reply-To: <1601237.BEhNSa8l6d@milian-kdab2> (Milian Wolff's message of
	"Wed, 26 Nov 2014 13:47:41 +0100")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

Milian Wolff <mail@milianw.de> writes:

> Hello all,
>
> I wonder whether there is a way to reduce the size of perf data files. Esp. 
> when I collect call graph information via Dwarf on user space applications, I 
> easily end up with multiple gigabytes of data in just a few seconds.

Use a fixed period and reduce the period or so.

-c 10000000

Don't use dwarf backtracing.

On new enough perf you can disable time stamps --no-time.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
