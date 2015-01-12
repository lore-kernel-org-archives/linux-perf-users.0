From: Carl Love <cel@us.ibm.com>
Subject: Re: Perf support for interpreted and Just-In-Time translated
 olanguages
Date: Mon, 12 Jan 2015 09:22:48 -0800
Message-ID: <1421083368.6211.2.camel@oc0276584878.ibm.com>
References: <1417810736.5098.11.camel@oc0276584878.ibm.com>
	 <CAE40pdcXt_gaCXD7n3UED4Y2_gdpH+A3S627TS-72xkbGDoNsA@mail.gmail.com>
	 <20141209203419.GI4189@kernel.org> <87ppbs4h5k.fsf@tassilo.jf.intel.com>
	 <20141209222203.GD8788@kernel.org>
	 <20141210173228.GA6759@two.firstfloor.org> <54888569.30409@gmail.com>
	 <20141210180529.GB6759@two.firstfloor.org> <54889086.4070606@gmail.com>
	 <20141210194302.GH8788@kernel.org>
	 <1420834758.4897.10.camel@oc0276584878.ibm.com>
	 <54B0A757.2010407@redhat.com>  <54B141F2.60104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:46447 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbbALRW5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 12 Jan 2015 12:22:57 -0500
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <cel@us.ibm.com>;
	Mon, 12 Jan 2015 10:22:56 -0700
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 15F506E8047
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2015 12:14:45 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t0CHMp1627721924
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2015 17:22:52 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t0CHMppw010401
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2015 12:22:51 -0500
In-Reply-To: <54B141F2.60104@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: William Cohen <wcohen@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Sat, 2015-01-10 at 08:14 -0700, David Ahern wrote:
> On 1/9/15 9:15 PM, William Cohen wrote:
> >> I have thought about pipes, callbacks, but I don't see any way to get
> >> these to work between the library loaded in the Java program and perf.
> >> Just wondering if you had any thoughts on how to do the communication?
> >>
> >>                   Carl Love
> >
> > Hi Carl,
> >
> > Too bad there isn't a "sys_perf_event" syscall to allow user-space applications to inject like a software event style entries into the kernel's recording of perf events. The AMD lightweight profiling mechanism specified the LWPINS instruction to insert a software event entry into the data buffer (http://support.amd.com/TechDocs/43724.pdf).  Seems like the linux kernel should have a similar mechanism to allow user and kernel-space to inject data in the perf records.
> >
> > -Will
> 
> https://lkml.org/lkml/2014/11/3/917
> 
> David
> 

David:

Ah, this is the ioctl patch you had mentioned you mentioned previously.
I hadn't found the patch before.  Yes, this looks like it would work.  I
will see if I can get a prototype working with this patch.  Thanks.

                Carl Love
