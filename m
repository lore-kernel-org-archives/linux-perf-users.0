From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: My options when vendor refuses to supply debug symbols
Date: Mon, 9 Nov 2015 12:17:28 -0300
Message-ID: <20151109151728.GC4715@kernel.org>
References: <loom.20151105T061223-246@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39649 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855AbbKIPRe (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 9 Nov 2015 10:17:34 -0500
Content-Disposition: inline
In-Reply-To: <loom.20151105T061223-246@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ryan Heniser <ryan.heniser@rsp.com.au>
Cc: linux-perf-users@vger.kernel.org

Em Thu, Nov 05, 2015 at 05:14:18AM +0000, Ryan Heniser escreveu:
> What options do we have when a third party vendor refuses to provide debug 
> symbols because they fear it might leak IP? There code is compiled into one 
> dynamic shared object. Is there a way to perf record the memory addresses 
> such that I could pass them on to the company for them to convert to function 
> signatures?

Sure, this is the most basic usage model, i.e. you run 'perf record'
with the options you want, then it produces a perf.data file, for
instance:

Recording 10 seconds of system wide 'cycles' samples:

# perf record -a sleep 5
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 1.072 MB perf.data (3711 samples) ]

It generates this:

# ls -lah perf.data
-rw-------. 1 root root 1.1M Nov  9 12:02 perf.data

That has this kind of samples:

# perf evlist -v
cycles:pp: size: 112, { sample_period, sample_freq }: 4000, sample_type:
IP|TID|TIME|CPU|PERIOD, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq:
1, task: 1, precise_ip: 2, sample_id_all: 1, exclude_guest: 1, mmap2: 1,
comm_exec: 1
# 

So, 4kHz (4000) cycles:pp (the most precise kind of CPU cycles available
in this specific CPU).

In the header you will have, among other info, this table:


# perf buildid-list | head
282777c262e6b3c0451375163c9a81c893218ab1 /lib/modules/4.3.0-rc1+/build/vmlinux
b35cc378488d971b1c0d9c65dec9733eb5355e7a /lib/modules/4.3.0-rc1+/kernel/drivers/net/tun.ko
42710c186bb9005471f7bcb66bcbb4c2a08fc6ca /lib/modules/4.3.0-rc1+/kernel/net/netfilter/xt_conntrack.ko
aad451e400f7a46b433c18bb6f4df368d11c098f /lib/modules/4.3.0-rc1+/kernel/arch/x86/kvm/kvm-intel.ko
c3f2ebe812e626fc55ba809d3631a768831a415b /lib/modules/4.3.0-rc1+/kernel/arch/x86/kvm/kvm.ko
9152616a7ab0667625f03a259ab13766510893c7 /lib/modules/4.3.0-rc1+/kernel/drivers/gpu/drm/i915/i915.ko
cc07527c1a9f88677c7600af8d0f930a41537ff5 /lib/modules/4.3.0-rc1+/kernel/drivers/gpu/drm/drm_kms_helper.ko
7e02c312e2cb28429293a0768979db75df318e33 /lib/modules/4.3.0-rc1+/kernel/drivers/gpu/drm/drm.ko
3df5385c6be529423a8ae3dd39a3deb9425201cc /usr/lib64/libc-2.20.so
39f6c99e1ecd6a2b9207a8595a90fee3cdc07e55 /usr/lib64/libpthread-2.20.so
[root@zoo ~]# 

So. it doesn't record the symbol tables, just a content based SHA + the
pathname, it will, using this, lookup the symbol tables in various places, for
instance:

# rpm -qf /lib64/libpthread-2.20.so 
glibc-2.20-8.fc21.x86_6

The best source of IP -> symbol map, i.e. a symtab, for glibc files is in the
"glibc-debuginfo" package, and that has:

# rpm -ql glibc-debuginfo | grep f6c99e1ecd6a2b9207a8595a90fee3cdc07e55
/usr/lib/debug/.build-id/39/f6c99e1ecd6a2b9207a8595a90fee3cdc07e55
/usr/lib/debug/.build-id/39/f6c99e1ecd6a2b9207a8595a90fee3cdc07e55.debug
[root@zoo ~]#

See? that build-id for /usr/lib64/libpthread-2.20.so is the key used to go from
the perf.data file to the required file with the symtab.

Please read the man page for the 'perf buildid-cache' to see how to add files
with such build-ids to a place (the buildid cache) where the tools also look
for it.

There is also the --symfs option, see its option in the 'perf report' man page,
that will allow using an alternative way even without build-ids, when you are
completely sure that just doing pathname based lookups are ok:

       --symfs=<directory>
           Look for files with symbols relative to this directory.

- Arnaldo
