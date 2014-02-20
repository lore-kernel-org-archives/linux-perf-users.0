From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perf pebs sampling through stores + period is wrong?
Date: Thu, 20 Feb 2014 13:27:58 -0800
Message-ID: <87eh2xcw4h.fsf@tassilo.jf.intel.com>
References: <5305E9AF.3050906@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1174 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317AbaBTV2E (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 20 Feb 2014 16:28:04 -0500
In-Reply-To: <5305E9AF.3050906@bsc.es> (Harald Servat's message of "Thu, 20
	Feb 2014 12:40:31 +0100")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Harald Servat <harald.servat@bsc.es>
Cc: linux-perf-users@vger.kernel.org

Harald Servat <harald.servat@bsc.es> writes:
>
>   $ perf mem -t store record -c 10000 ./a.out
>   ...
>   [perf record: Woken up 4 times to write data]
>   [perf record: Captured and wrote 0.921 MB perf.data (~40247 samples)]
>
>   Notice that the number of samples raised by 20x, which to me seems
> very odd because the number of stores was half, so I expected 0.5x
> here. Or am I supposing this the wrong way?

Likely you're throttling. 10k is a far too low period for such 
measurements

(The cpu can do multiple stores per cycle and it runs at multiple
Ghz. Each PMI takes many thousands of cycles. You can do the math.)

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
