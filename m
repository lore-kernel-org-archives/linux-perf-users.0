From: Andi Kleen <andi@firstfloor.org>
Subject: Re: LBR unwinding for user defined dynamic trace point
Date: Tue, 15 Sep 2015 07:02:37 -0700
Message-ID: <874mivkcg2.fsf@tassilo.jf.intel.com>
References: <2495974.rH49Pff4SO@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:54740 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638AbbIOOCi (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 15 Sep 2015 10:02:38 -0400
In-Reply-To: <2495974.rH49Pff4SO@milian-kdab2> (Milian Wolff's message of
	"Tue, 15 Sep 2015 15:12:02 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>, 5A@linux.intel.com
Cc: linux-perf-users@vger.kernel.org

Milian Wolff <milian.wolff@kdab.com> writes:
>
> When I do the same with the Dwarf unwinder, it works just fine. Using the LBR 
> unwinder with a performance counter like instructions also works fine. Does 
> anyone know what the issue is here?

LBR is only supported for PMU sampling at this point.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
