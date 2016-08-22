From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Failure to parallelize
Date: Mon, 22 Aug 2016 14:14:08 -0700
Message-ID: <8737lw1p7j.fsf@tassilo.jf.intel.com>
References: <20160817135528.GA13652@localhost>
        <21975224.qTVBMiFlMz@milian-kdab2> <20160818185048.GA2242@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56675 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755814AbcHVVOK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Aug 2016 17:14:10 -0400
In-Reply-To: <20160818185048.GA2242@localhost> (Benjamin King's message of
        "Thu, 18 Aug 2016 20:50:48 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Benjamin King <benjaminking@web.de>
Cc: Milian Wolff <milian.wolff@kdab.com>, linux-perf-users@vger.kernel.org

Benjamin King <benjaminking@web.de> writes:
>
> Still, I dabbled a bit with "perf record -s ...; perf report -T", but I find the
> output a little confusing. To wit:

I would rather use perf report --sort cpu,sym

This reports all samples separated by CPUs, but sorted in the same view.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only
