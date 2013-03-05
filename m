From: David Ahern <dsahern@gmail.com>
Subject: Re: Tracing kvm: kvm_entry and kvm_exit
Date: Tue, 05 Mar 2013 10:23:54 -0700
Message-ID: <51362A2A.4070500@gmail.com>
References: <1361550867.51279e13338a7@www.imp.polymtl.ca> <20130225101804.GC2790@stefanha-thinkpad.redhat.com> <512E36B2.5090100@gmail.com> <512EE1D4.6080808@gmail.com> <1362375371.513432cbdb150@www.imp.polymtl.ca> <513433C4.7040104@gmail.com> <1362377752.51343c188955b@www.imp.polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:60228 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047Ab3CERYF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 5 Mar 2013 12:24:05 -0500
In-Reply-To: <1362377752.51343c188955b@www.imp.polymtl.ca>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mohamad Gebai <mohamad.gebai@polymtl.ca>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org

On 3/3/13 11:15 PM, Mohamad Gebai wrote:
>> host kernel version?
> 3.8 compiled from perf-kvm-live-3.8

I made no changes to the kernel side so essentially you are running v3.8 
unmodified.

>> guest kernel?
> 3.8.1
>> qemu-kvm command line? (leave out the disk and network arguments -- just
>> the rest)
> Actually using virt-manager for this but here's the most relevant part of the
> qemu-kvm command line:
> /usr/bin/qemu-kvm -name debian_test -S -M pc-1.2 -enable-kvm -m 1024 -smp
> 1,sockets=1,cores=1,threads=1

ok, I take that to mean qemu-kvm 1.2.

> Actually qemu-kvm is launched first, then perf kvm is launched right after,
> before the bootloader of the VM using this command line:
> perf kvm stat -p <vm-pid> -e kvmmmu:*

I have not been able to reproduce it. Host kernel is v3.8, guest kernel 
is 3.8.1-201.fc18.x86_64 (Fedora 18, latest kernel). Host CPU: Intel(R) 
Xeon(R) CPU E5540  @ 2.53GHz.

qemu-kvm version is 1.2. Relevant command line (launched manually)

/usr/local/qemu-kvm/1.2/bin/qemu-system-x86_64 -m 4096 -smp 
1,sockets=1,cores=1,threads=1  -S -M pc-1.2

That starts the VM with paused vcpus. Then launch perf-kvm-stat:

perf kvm stat -p $(vm-status -b f18) -e kvmmmu:*

VM boots just fine.

When I get some time I can try qemu versions 1.3 and 1.4 to see if it 
makes a difference. Any output from the VM or host dmesg? What if you 
start qemu manually?

David
