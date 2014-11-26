From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Using perf with cgroups and containers
Date: Wed, 26 Nov 2014 12:52:21 -0800
Message-ID: <87wq6hhegq.fsf@tassilo.jf.intel.com>
References: <547606D8.3040601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6872 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbaKZUwW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 26 Nov 2014 15:52:22 -0500
In-Reply-To: <547606D8.3040601@redhat.com> (William Cohen's message of "Wed,
	26 Nov 2014 11:59:04 -0500")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

William Cohen <wcohen@redhat.com> writes:

> Hi,
>
> I have been looking at how perf supports cgroups and containers.  The
> "-G" option allows limiting the data collected to a particular cgroup.
> Thus, one can use the option to collect some information about a
> particular cgroup with something like:
>
> $ sudo perf stat -a -e cycles  -G
> machine.slice/machine-qemu\\x2drhel7\\x2dx86_64.scope -e instructions
> -G machine.slice/machine-qemu\\x2drhel7\\x2dx86_64.scope -- sleep 1

You can specify multiple events with -e. Typically you should anyways,
to define appropiate groups with {}

perf record -a -e cycles,instructions -G cgroup  ...

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
