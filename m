From: Andi Kleen <andi@firstfloor.org>
Subject: Re: IPC sampling
Date: Fri, 03 Jun 2016 07:43:06 -0700
Message-ID: <87oa7imiyt.fsf@tassilo.jf.intel.com>
References: <loom.20160603T134548-395@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7157 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752663AbcFCOnI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 3 Jun 2016 10:43:08 -0400
In-Reply-To: <loom.20160603T134548-395@post.gmane.org> (Jose's message of
	"Fri, 3 Jun 2016 11:54:57 +0000 (UTC)")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jose <jose.sgarcia.aldonza@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Jose <jose.sgarcia.aldonza@gmail.com> writes:
>
> My problem now is that I don't know how to obtain "cycles" and
> "instructions" from perf.data file. I have tried several options using "perf
> report" and "perf script" but I don't achieve it.

perf record -e '{instructions,cycles}:S' ...
perf script

This means sample on cycles, but always read instructions too during the sample.
Then match up the values with the same time stamp from perf script and
calculate ipc, or use a perf script interpreted script to do so.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
