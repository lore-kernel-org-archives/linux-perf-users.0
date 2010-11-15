From: "David S. Ahern" <daahern@cisco.com>
Subject: off-box analysis of perf.data file
Date: Sun, 14 Nov 2010 21:03:20 -0700
Message-ID: <4CE0B108.8020205@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-5.cisco.com ([171.68.10.87]:14361 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756331Ab0KOEDW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 14 Nov 2010 23:03:22 -0500
Received: from [10.20.182.149] (sjc-daahern-8914.cisco.com [10.20.182.149])
	by sj-core-5.cisco.com (8.13.8/8.14.3) with ESMTP id oAF43LGc012639
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Nov 2010 04:03:21 GMT
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org


I'm trying to understand how the latest perf tools are designed with
respect to off-line analysis.

Specifically, I have a system running binaries and libraries that are
stripped and no vmlinux is installed. For analysis, I have a local tree
based on software versions with full debug symbols. Events are collected
into a perf.data file and the file is pushed off-box for analysis.

Without assuming write access to local tree or even ownership of the
perf.data I imagine running a command something like:

perf report -fi /path/to/perf.data \
    --rootfs /path/to/symboled-tree \
    --kallsyms /path/to/kallsyms
    ...

where /proc/kallsyms is dumped for the running system and retrieved
along with the perf.data file.

I've been reading the source and can't say I follow all of the build-id
stuff. Before I spend time working on code modifications I wanted to
better understand the expectations and options for the latest code.

Thanks,

David
