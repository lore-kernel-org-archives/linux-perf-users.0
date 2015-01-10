From: David Ahern <dsahern@gmail.com>
Subject: Re: Perf support for interpreted and Just-In-Time translated olanguages
Date: Sat, 10 Jan 2015 08:14:58 -0700
Message-ID: <54B141F2.60104@gmail.com>
References: <1417810736.5098.11.camel@oc0276584878.ibm.com>	 <CAE40pdcXt_gaCXD7n3UED4Y2_gdpH+A3S627TS-72xkbGDoNsA@mail.gmail.com>	 <20141209203419.GI4189@kernel.org> <87ppbs4h5k.fsf@tassilo.jf.intel.com>	 <20141209222203.GD8788@kernel.org>	 <20141210173228.GA6759@two.firstfloor.org> <54888569.30409@gmail.com>	 <20141210180529.GB6759@two.firstfloor.org> <54889086.4070606@gmail.com>	 <20141210194302.GH8788@kernel.org> <1420834758.4897.10.camel@oc0276584878.ibm.com> <54B0A757.2010407@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:51345 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657AbbAJPPD (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 10 Jan 2015 10:15:03 -0500
Received: by mail-pa0-f47.google.com with SMTP id kq14so24033044pab.6
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Jan 2015 07:15:02 -0800 (PST)
In-Reply-To: <54B0A757.2010407@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>, Carl Love <cel@us.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On 1/9/15 9:15 PM, William Cohen wrote:
>> I have thought about pipes, callbacks, but I don't see any way to get
>> these to work between the library loaded in the Java program and perf.
>> Just wondering if you had any thoughts on how to do the communication?
>>
>>                   Carl Love
>
> Hi Carl,
>
> Too bad there isn't a "sys_perf_event" syscall to allow user-space applications to inject like a software event style entries into the kernel's recording of perf events. The AMD lightweight profiling mechanism specified the LWPINS instruction to insert a software event entry into the data buffer (http://support.amd.com/TechDocs/43724.pdf).  Seems like the linux kernel should have a similar mechanism to allow user and kernel-space to inject data in the perf records.
>
> -Will

https://lkml.org/lkml/2014/11/3/917

David
