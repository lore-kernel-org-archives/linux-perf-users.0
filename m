From: David Ahern <dsahern@gmail.com>
Subject: Re: Tracing kvm: kvm_entry and kvm_exit
Date: Sun, 03 Mar 2013 22:40:20 -0700
Message-ID: <513433C4.7040104@gmail.com>
References: <1361550867.51279e13338a7@www.imp.polymtl.ca> <20130225101804.GC2790@stefanha-thinkpad.redhat.com> <512E36B2.5090100@gmail.com> <512EE1D4.6080808@gmail.com> <1362375371.513432cbdb150@www.imp.polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:63154 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab3CDFkY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 4 Mar 2013 00:40:24 -0500
In-Reply-To: <1362375371.513432cbdb150@www.imp.polymtl.ca>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mohamad Gebai <mohamad.gebai@polymtl.ca>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org

On 3/3/13 10:36 PM, Mohamad Gebai wrote:
> Thank you for this, I have been testing it for the last couple of days, I can
> see that perf kvm is getting more stable. Though I just realized that if you
> launch perf kvm as soon as you start a VM, the VM fails to boot. Any idea why
> this happens?
>

no, but tell me more and I'll see if I can reproduce.

host kernel version?
guest kernel?
qemu-kvm command line? (leave out the disk and network arguments -- just 
the rest)

sequence of events? launching qemu-kvm in one window and at the "same 
time" launching perf-kvm? Or is perf-kvm started a few seconds prior to 
qemu-kvm or vice-versa?
