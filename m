From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Tracing kvm: kvm_entry and kvm_exit
Date: Thu, 28 Feb 2013 09:44:48 +0100
Message-ID: <CAJSP0QWinkZ4=fK5WWZOO11xTrJLC_aYvx0pv3jhmp354ri=5Q@mail.gmail.com>
References: <1361550867.51279e13338a7@www.imp.polymtl.ca>
	<20130225101804.GC2790@stefanha-thinkpad.redhat.com>
	<512E36B2.5090100@gmail.com>
	<512EE1D4.6080808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:49426 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796Ab3B1Iot (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 28 Feb 2013 03:44:49 -0500
In-Reply-To: <512EE1D4.6080808@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Mohamad Gebai <mohamad.gebai@polymtl.ca>, kvm <kvm@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Thu, Feb 28, 2013 at 5:49 AM, David Ahern <dsahern@gmail.com> wrote:
> On 2/27/13 9:39 AM, David Ahern wrote:
>>
>> I have been playing with the live mode a bit lately. I'll add a debug to
>> note 2 consecutive entry events without an exit -- see if it sheds some
>> light on it.
>
>
> If you feel game take this for a spin:
>   https://github.com/dsahern/linux/commits/perf-kvm-live-3.8

This is very cool, thanks for sharing.

Next time I'm profiling vmexit latencies I'll give it a try.

Stefan
