From: David Ahern <dsahern@gmail.com>
Subject: Re: Tracing kvm: kvm_entry and kvm_exit
Date: Wed, 27 Feb 2013 09:39:14 -0700
Message-ID: <512E36B2.5090100@gmail.com>
References: <1361550867.51279e13338a7@www.imp.polymtl.ca> <20130225101804.GC2790@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-da0-f48.google.com ([209.85.210.48]:61940 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758245Ab3B0QjS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 27 Feb 2013 11:39:18 -0500
In-Reply-To: <20130225101804.GC2790@stefanha-thinkpad.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Mohamad Gebai <mohamad.gebai@polymtl.ca>, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org

On 2/25/13 3:18 AM, Stefan Hajnoczi wrote:
> On Fri, Feb 22, 2013 at 11:34:27AM -0500, Mohamad Gebai wrote:
>> I am tracing kvm using perf and I am analyzing the sequences of kvm_entry and
>> kvm_exit tracepoints.
>> I noticed that during the boot process of a VM, there are a lot more (2 to 3 as
>> many times) kvm_entry event than there are kvm_exit. I tried looking around but
>> didn't find anything that explains this. Is this missing instrumentation? Or
>> what other path does kvm take that doesn't generate a kvm_exit event?
>
> Gleb Natapov noticed something similar when playing with the perf script
> I posted here:
>
> http://permalink.gmane.org/gmane.comp.emulators.kvm.devel/104181

Have you tried using perf kvm stat? It is really easy to add a 
flag/option to dump individual analysis points with the stats summary at 
the end - or only dump data points greater than some threshold.

Latest version for the 'live mode' can be found here:
   https://github.com/dsahern/linux/tree/perf-kvm-live-3.8

>
> Perhaps there is a code path that is missing trace_kvm_exit().

I have been playing with the live mode a bit lately. I'll add a debug to 
note 2 consecutive entry events without an exit -- see if it sheds some 
light on it.

David
