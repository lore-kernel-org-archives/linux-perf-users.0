From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/2] perf record: wrong size in perf_record_mmap for last
 kernel module
Date: Mon, 7 Aug 2017 13:05:49 -0300
Message-ID: <20170807160549.GT12201@kernel.org>
References: <20170724143514.55574-1-tmricht@linux.vnet.ibm.com>
 <20170724143514.55574-2-tmricht@linux.vnet.ibm.com>
 <20170724182007.GY4134@kernel.org>
 <20170802185047.GL12201@kernel.org>
 <7e74f3d2-204d-0067-4914-1dbba3f02db2@linux.vnet.ibm.com>
 <20170804170614.GP12201@kernel.org>
 <d0db66fd-32ae-f644-b3e1-bb12776a793e@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751879AbdHGQFw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Aug 2017 12:05:52 -0400
Content-Disposition: inline
In-Reply-To: <d0db66fd-32ae-f644-b3e1-bb12776a793e@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: brueckner@linux.vnet.ibm.com, zvonko.kosic@de.ibm.com, linux-perf-users@vger.kernel.org

Em Mon, Aug 07, 2017 at 09:26:14AM +0200, Thomas-Mich Richter escreveu:
> On 08/04/2017 07:06 PM, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Aug 03, 2017 at 11:41:02AM +0200, Thomas-Mich Richter escreveu:
> >> The idea for the roundup to page size is the assumption that the kernel
> >> allocates full pages for memory to load modules. The size filed in the /proc/modules
> >> output refers to the module size in bytes.

> >> If this is wrong we can omit the roundup.

> > Its not wrong, just looks unnecessary, a distraction, I'll remove it, ok?

> Sure go ahead.

Thanks, applied.

- Arnaldo
