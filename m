From: Mohamad Gebai <mohamad.gebai@polymtl.ca>
Subject: Re: Tracing kvm: kvm_entry and kvm_exit
Date: Mon, 04 Mar 2013 01:15:52 -0500
Message-ID: <1362377752.51343c188955b@www.imp.polymtl.ca>
References: <1361550867.51279e13338a7@www.imp.polymtl.ca> <20130225101804.GC2790@stefanha-thinkpad.redhat.com> <512E36B2.5090100@gmail.com> <512EE1D4.6080808@gmail.com> <1362375371.513432cbdb150@www.imp.polymtl.ca> <513433C4.7040104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp.polymtl.ca ([132.207.4.11]:58831 "EHLO smtp.polymtl.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727Ab3CDGPz (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 4 Mar 2013 01:15:55 -0500
In-Reply-To: <513433C4.7040104@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org


> On 3/3/13 10:36 PM, Mohamad Gebai wrote:
> > Thank you for this, I have been testing it for the last couple of days, I
> can
> > see that perf kvm is getting more stable. Though I just realized that if
> you
> > launch perf kvm as soon as you start a VM, the VM fails to boot. Any idea
> why
> > this happens?
> >
>
> no, but tell me more and I'll see if I can reproduce.
>
Sure thing:

> host kernel version?
3.8 compiled from perf-kvm-live-3.8
> guest kernel?
3.8.1
> qemu-kvm command line? (leave out the disk and network arguments -- just
> the rest)
Actually using virt-manager for this but here's the most relevant part of the
qemu-kvm command line:
/usr/bin/qemu-kvm -name debian_test -S -M pc-1.2 -enable-kvm -m 1024 -smp
1,sockets=1,cores=1,threads=1

> sequence of events? launching qemu-kvm in one window and at the "same
> time" launching perf-kvm? Or is perf-kvm started a few seconds prior to
> qemu-kvm or vice-versa?
>

Actually qemu-kvm is launched first, then perf kvm is launched right after,
before the bootloader of the VM using this command line:
perf kvm stat -p <vm-pid> -e kvmmmu:*
