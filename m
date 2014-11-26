From: William Cohen <wcohen@redhat.com>
Subject: Using perf with cgroups and containers
Date: Wed, 26 Nov 2014 11:59:04 -0500
Message-ID: <547606D8.3040601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38184 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbaKZQ7F (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 26 Nov 2014 11:59:05 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sAQGx4mm015704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Nov 2014 11:59:05 -0500
Received: from [10.13.129.109] (dhcp129-109.rdu.redhat.com [10.13.129.109])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id sAQGx48q022241
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Nov 2014 11:59:04 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users <linux-perf-users@vger.kernel.org>

Hi,

I have been looking at how perf supports cgroups and containers.  The
"-G" option allows limiting the data collected to a particular cgroup.
Thus, one can use the option to collect some information about a
particular cgroup with something like:

$ sudo perf stat -a -e cycles  -G machine.slice/machine-qemu\\x2drhel7\\x2dx86_64.scope -e instructions -G machine.slice/machine-qemu\\x2drhel7\\x2dx86_64.scope -- sleep 1

 Performance counter stats for 'system wide':

         9,668,237      cycles                    machine.slice/machine-qemu\x2drhel7\x2dx86_64.scope [82.28%]
         4,685,886      instructions              machine.slice/machine-qemu\x2drhel7\x2dx86_64.scope #    0.48  insns per cycle         [82.28%]

       1.001359839 seconds time elapsed

However, this approach seems to be awkward.  It requires specifying
the cgroup for each event.  It also requires the system-wide option
("-a") to get information for all the tasks in the cgroup and
superuser privileges.  Thus, even if all the tasks are owned by the
user running the perf command, the command still needs superuser
privileges.

Another limitation is when within a container there doesn't seem to be
a way of doing the equivalent to a "perf record -a ..." to collect
related to that container.  When running within a container going to
get something like the following:

# perf stat -a ls
Error:
You may not have permission to collect system-wide stats.
Consider tweaking /proc/sys/kernel/perf_event_paranoid:
 -1 - Not paranoid at all
  0 - Disallow raw tracepoint access for unpriv
  1 - Disallow cpu events for unpriv
  2 - Disallow kernel profiling for unpriv


There is a middle ground between monitoring a process/set of processes
and monitoring the entire machine that perf could do a better job of.
Have three broad categories to scope the data collection: pid, cgroup,
and container.

For pid perf can be monitoring itself or a set of processes.  perf has
checks to make sure that the monitoring process has permission to
monitor the other processes. 

For cgroup monitoring perf implementation only works for systemwide
monitoring "-a".  Why should someone need to specify "-a" when they
specify the cgroup to monitor?  It seems like this should operater
much more like the selection of processes to monitor.

For containers one might want to either monitor a container from
outside for system health or from the inside while doing development.
Currently perf can monitor from outside but isn't able to monitor from
inside.

Can something be done to improve the usability of perf for cgroups and
containers?

-Will
