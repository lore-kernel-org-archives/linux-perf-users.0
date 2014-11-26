From: William Cohen <wcohen@redhat.com>
Subject: Re: Using perf with cgroups and containers
Date: Wed, 26 Nov 2014 16:29:13 -0500
Message-ID: <54764629.9050601@redhat.com>
References: <547606D8.3040601@redhat.com> <87wq6hhegq.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58164 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526AbaKZV31 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 26 Nov 2014 16:29:27 -0500
In-Reply-To: <87wq6hhegq.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

On 11/26/2014 03:52 PM, Andi Kleen wrote:
> William Cohen <wcohen@redhat.com> writes:
> 
>> Hi,
>>
>> I have been looking at how perf supports cgroups and containers.  The
>> "-G" option allows limiting the data collected to a particular cgroup.
>> Thus, one can use the option to collect some information about a
>> particular cgroup with something like:
>>
>> $ sudo perf stat -a -e cycles  -G
>> machine.slice/machine-qemu\\x2drhel7\\x2dx86_64.scope -e instructions
>> -G machine.slice/machine-qemu\\x2drhel7\\x2dx86_64.scope -- sleep 1
> 
> You can specify multiple events with -e. Typically you should anyways,
> to define appropiate groups with {}
> 
> perf record -a -e cycles,instructions -G cgroup  ...
> 
> -Andi
> 

Hi Andi,

Is there some where that explain use of the "{}" for event grouping?  The various perf man pages I have looked at (perf-record, perf-stat, and perf) don't seem to mention it. When reading the following from "man perf-record" it sounded like the comman separated event list wouldn't work:

      -G name,..., --cgroup name,...
           monitor only in the container (cgroup) called "name". This option
           is available only in per-cpu mode. The cgroup filesystem must be
           mounted. All threads belonging to container "name" are monitored
           when they run on the monitored CPUs. Multiple cgroups can be
           provided. Each cgroup is applied to the corresponding event, i.e.,
           first cgroup to first event, second cgroup to second event and so
           on. It is possible to provide an empty cgroup (monitor all the
           time) using, e.g., -G foo,,bar. Cgroups must have corresponding
           events, i.e., they always refer to events defined earlier on the
           command line.

The results looks pretty questionable on my machine with the version of perf and kernel I am using:

$ uname -a
Linux santana 3.17.3-200.fc20.x86_64 #1 SMP Fri Nov 14 19:45:42 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
$ rpm -q perf
perf-3.17.3-200.fc20.x86_64
$ sudo perf stat -a -e cycles,instructions -G machine.slice/machine-qemu\\x2drhel7\\x2dx86_64.scope -- sleep .2

 Performance counter stats for 'system wide':

         2,983,776      cycles                    machine.slice/machine-qemu\x2drhel7\x2dx86_64.scope [74.96%]
        87,972,874      instructions              #   29.48  insns per cycle         [100.00%]

       0.201151985 seconds time elapsed

$ sudo perf stat -a -e "{cycles,instructions}" -G machine.slice/machine-qemu\\x2drhel7\\x2dx86_64.scope -- sleep .2

 Performance counter stats for 'system wide':

         2,512,934      cycles                    machine.slice/machine-qemu\x2drhel7\x2dx86_64.scope [82.53%]
       813,334,082      instructions              #   323.66  insns per cycle         [ 0.09%]

       0.201360285 seconds time elapsed


-Will
