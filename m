From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf tool: perf mem not working on s390x
Date: Fri, 23 Jun 2017 15:33:04 -0300
Message-ID: <20170623183304.GF4622@kernel.org>
References: <4ad64b13-5ed4-a8f0-9a3a-2748663bb5a2@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754327AbdFWSdI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2017 14:33:08 -0400
Content-Disposition: inline
In-Reply-To: <4ad64b13-5ed4-a8f0-9a3a-2748663bb5a2@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-perf-users@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

Em Fri, Jun 23, 2017 at 09:28:53AM +0200, Thomas-Mich Richter escreveu:
> 
> When I run perf mem ... it fails with
> 
> [root@s8360046 perf]# ./perf mem record -- sleep 1
> failed: memory events not supported
> [root@s8360046 perf]
> 
> That is currently not working on s390.
> When I look into the code, the perf mem command is looking for sysfs files in
> 
> -r--r--r-- 1 root root 4096 Jun  9 11:02 /sys/devices/cpu/events/mem-loads
> -r--r--r-- 1 root root 4096 Jun  9 11:02 /sys/devices/cpu/events/mem-stores
> 
> Those 2 sysfs files do not exist on a s390. In fact there is a different
> subdirectory tree.
> 
> I am not sure how this is handled on the s390 at all. I would have expected
> perf mem to somehow retrieve the event numbers and then feed perf record
> with these event numbers.
> Any comments/ideas on how to handle this?

Humm, IIRC perf mem depends on features present only on x86_64, i.e.
mem access features in x86's latest PEBS.

One would have to look for something equivalent in other architectures
to be able to write the necessary glue.

Probably we should just make it available on the arches that have the
necessary hardware facilities.

- Arnaldo
