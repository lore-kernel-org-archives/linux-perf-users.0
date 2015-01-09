From: Carl Love <cel@us.ibm.com>
Subject: Re: Perf support for interpreted and Just-In-Time translated
 olanguages
Date: Fri, 09 Jan 2015 12:19:18 -0800
Message-ID: <1420834758.4897.10.camel@oc0276584878.ibm.com>
References: <1417810736.5098.11.camel@oc0276584878.ibm.com>
	 <CAE40pdcXt_gaCXD7n3UED4Y2_gdpH+A3S627TS-72xkbGDoNsA@mail.gmail.com>
	 <20141209203419.GI4189@kernel.org> <87ppbs4h5k.fsf@tassilo.jf.intel.com>
	 <20141209222203.GD8788@kernel.org>
	 <20141210173228.GA6759@two.firstfloor.org> <54888569.30409@gmail.com>
	 <20141210180529.GB6759@two.firstfloor.org> <54889086.4070606@gmail.com>
	 <20141210194302.GH8788@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:54630 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbbAIUTW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 9 Jan 2015 15:19:22 -0500
Received: from /spool/local
	by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <cel@us.ibm.com>;
	Fri, 9 Jan 2015 15:19:21 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 6126138C804A
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Jan 2015 15:19:19 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t09KJJsJ22413542
	for <linux-perf-users@vger.kernel.org>; Fri, 9 Jan 2015 20:19:19 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t09KJJEI009489
	for <linux-perf-users@vger.kernel.org>; Fri, 9 Jan 2015 15:19:19 -0500
In-Reply-To: <20141210194302.GH8788@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

Arnaldo:

> I think this should be solved in the same way, i.e. content based keys,
> that we call build-ids, every mapping, when put in place generates an
> event, say PERF_RECORD_MMAP3, that comes with a key that can later be
> used to retrieve the matching ELF file with DWARF info for annotation,
> symbol resolution, unwinding, etc.
> 
> Modern distros have this and that is why we store in the perf.data file
> just the build ids, not the full ELF files at the time of the recording
> session:

I have been looking at and trying to code up some JIT support for perf.
I have written a library to register the callbacks from a Java
application. That is all fairly easy stuff.

I have been trying to figure out how to get this library to communicate
and send an event record to perf so perf can write it into perf.data, as
you mentioned above.  Specifically we will want to write the load and
unload records to perf.data.  The library gets loaded into the Java
application but if you try loading the library in perf, they do not
share the same data space so you can't pass the data directly.  

The only solution I see is creating a shared memory space where the
library can place the event info.  Then perf will have to connect to the
shared memory space and "watch" for data to show up.  This seems really
awkward and slower then what we need. We need the notifications to be
put into the perf.data file as close in time as possible to the event to
ensure proper mapping of the addresses. It also means only one Java
program can be using the interface at a time.  

I have thought about pipes, callbacks, but I don't see any way to get
these to work between the library loaded in the Java program and perf.
Just wondering if you had any thoughts on how to do the communication?

                 Carl Love
