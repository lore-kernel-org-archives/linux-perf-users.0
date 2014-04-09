From: Peter Hofer <peter.hofer@jku.at>
Subject: Samples taken in kernel with wrong stack pointer
Date: Wed, 9 Apr 2014 17:54:53 +0200
Message-ID: <20140409175453.213a5d55@sunflower.ssw.jku.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from emailsecure.uni-linz.ac.at ([140.78.3.66]:21100 "EHLO
	emailsecure.uni-linz.ac.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933909AbaDIQCA (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Apr 2014 12:02:00 -0400
Received: from sunflower.ssw.jku.at (unknown [140.78.145.173])
	by emailsecure.uni-linz.ac.at (Postfix) with ESMTPSA id 3B0945C02C
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2014 17:54:54 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello everyone,

 I have an application on x86_64 that uses the perf_event_open syscall
and mmap mechanism to obtain samples of its own threads. Samples are
triggered by the HW_REF_CPU_CYCLES counter with frequency set to 10000.
To perform a stack walk in the application code, the samples include
the user-level SP, BP and IP registers as well as 16K of the user-level
stack. This works very well for samples taken while execution is in
user code.

When I also want to observe where threads are waiting by taking samples
in the kernel (exclude_kernel = 0), it frequently seems like a chunk
from the stack top is missing in the sample. Most of the time, the IP
register indicates that execution is in pthread_cond_wait() or write().
But when I look at the sampled stack fragment in the debugger, I don't
see any return addresses to code that uses these functions. Instead, it
looks as if the stack fragment in the sample was taken at a significant
offset to the actual top of stack. The stack pointer included in the
sample, however, appears to always match the start of the sample's stack
fragment.

When I additionally sample the most recent calls and returns with the
branch stack (Intel Haswell LBR), I get a realistic call chain that
cannot be found in the sample's stack fragment.

I experienced this issue with Linux 3.11.10 on openSUSE 13.1, and
3.14.0 on openSUSE Tumbleweed. As a possible workaround, I tried using
the SW_CONTEXT_SWITCHES event, but the resulting samples have the same
problem.

Have you observed this problem before? Is there a possible workaround?

Thanks,
 Peter Hofer
