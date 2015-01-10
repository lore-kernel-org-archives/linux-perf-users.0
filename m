From: William Cohen <wcohen@redhat.com>
Subject: Re: Perf support for interpreted and Just-In-Time translated olanguages
Date: Fri, 09 Jan 2015 23:15:19 -0500
Message-ID: <54B0A757.2010407@redhat.com>
References: <1417810736.5098.11.camel@oc0276584878.ibm.com>	 <CAE40pdcXt_gaCXD7n3UED4Y2_gdpH+A3S627TS-72xkbGDoNsA@mail.gmail.com>	 <20141209203419.GI4189@kernel.org> <87ppbs4h5k.fsf@tassilo.jf.intel.com>	 <20141209222203.GD8788@kernel.org>	 <20141210173228.GA6759@two.firstfloor.org> <54888569.30409@gmail.com>	 <20141210180529.GB6759@two.firstfloor.org> <54889086.4070606@gmail.com>	 <20141210194302.GH8788@kernel.org> <1420834758.4897.10.camel@oc0276584878.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50534 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754043AbbAJEPY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 9 Jan 2015 23:15:24 -0500
In-Reply-To: <1420834758.4897.10.camel@oc0276584878.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Carl Love <cel@us.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On 01/09/2015 03:19 PM, Carl Love wrote:
> Arnaldo:
> 
>> I think this should be solved in the same way, i.e. content based keys,
>> that we call build-ids, every mapping, when put in place generates an
>> event, say PERF_RECORD_MMAP3, that comes with a key that can later be
>> used to retrieve the matching ELF file with DWARF info for annotation,
>> symbol resolution, unwinding, etc.
>>
>> Modern distros have this and that is why we store in the perf.data file
>> just the build ids, not the full ELF files at the time of the recording
>> session:
> 
> I have been looking at and trying to code up some JIT support for perf.
> I have written a library to register the callbacks from a Java
> application. That is all fairly easy stuff.
> 
> I have been trying to figure out how to get this library to communicate
> and send an event record to perf so perf can write it into perf.data, as
> you mentioned above.  Specifically we will want to write the load and
> unload records to perf.data.  The library gets loaded into the Java
> application but if you try loading the library in perf, they do not
> share the same data space so you can't pass the data directly.  
> 
> The only solution I see is creating a shared memory space where the
> library can place the event info.  Then perf will have to connect to the
> shared memory space and "watch" for data to show up.  This seems really
> awkward and slower then what we need. We need the notifications to be
> put into the perf.data file as close in time as possible to the event to
> ensure proper mapping of the addresses. It also means only one Java
> program can be using the interface at a time.  
> 
> I have thought about pipes, callbacks, but I don't see any way to get
> these to work between the library loaded in the Java program and perf.
> Just wondering if you had any thoughts on how to do the communication?
> 
>                  Carl Love

Hi Carl,

Too bad there isn't a "sys_perf_event" syscall to allow user-space applications to inject like a software event style entries into the kernel's recording of perf events. The AMD lightweight profiling mechanism specified the LWPINS instruction to insert a software event entry into the data buffer (http://support.amd.com/TechDocs/43724.pdf).  Seems like the linux kernel should have a similar mechanism to allow user and kernel-space to inject data in the perf records.

-Will
