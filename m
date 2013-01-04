From: David Flater <dflater@nist.gov>
Subject: Appended data not reportable
Date: Fri, 4 Jan 2013 17:28:22 -0500
Message-ID: <50E75786.4040902@nist.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from wsget1.nist.gov ([129.6.13.150]:28059 "EHLO wsget1.nist.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754934Ab3ADW2Y (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Jan 2013 17:28:24 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Perf Users <linux-perf-users@vger.kernel.org>

With kernel/perf 3.7.1, trying to do something akin to the "sum" option of
gprof to pool the samples from multiple runs.

This option from the perf-record man page looked promising:
-A, --append
    Append to the output file to do incremental profiling.

bash-4.2$ perf record -F 1000 ./app
bash-4.2$ perf record -F 1000 -A ./app

perf.data gets bigger, but then neither perf report nor perf script work.  Both
say:
0x1a0 [0]: failed to process type: 0

Is this a regression?

Thanks,
-- 
David Flater, National Institute of Standards and Technology, U.S.A.
