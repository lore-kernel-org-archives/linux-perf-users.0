From: Carl Love <cel@us.ibm.com>
Subject: Re: Perf support for interpreted and Just-In-Time translated
 olanguages
Date: Tue, 20 Jan 2015 12:34:23 -0800
Message-ID: <1421786063.4953.49.camel@oc0276584878.ibm.com>
References: <54888569.30409@gmail.com>
	 <20141210180529.GB6759@two.firstfloor.org> <54889086.4070606@gmail.com>
	 <20141210194302.GH8788@kernel.org>
	 <1420834758.4897.10.camel@oc0276584878.ibm.com>
	 <54B0A757.2010407@redhat.com> <54B141F2.60104@gmail.com>
	 <1421083368.6211.2.camel@oc0276584878.ibm.com> <54B40B51.5080107@gmail.com>
	 <1421777950.4953.40.camel@oc0276584878.ibm.com>
	 <20150120192926.GG3451@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:33873 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752059AbbATUea (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 20 Jan 2015 15:34:30 -0500
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <cel@us.ibm.com>;
	Tue, 20 Jan 2015 15:34:29 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A4EB76E803F
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2015 15:26:18 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t0KKYPAo24051786
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2015 20:34:25 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t0KKYOD0016239
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2015 15:34:25 -0500
In-Reply-To: <20150120192926.GG3451@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: David Ahern <dsahern@gmail.com>, William Cohen <wcohen@redhat.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Tue, 2015-01-20 at 16:29 -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jan 20, 2015 at 10:19:10AM -0800, Carl Love escreveu:
> > On Mon, 2015-01-12 at 10:58 -0700, David Ahern wrote:
> > > On 1/12/15 10:22 AM, Carl Love wrote:
> > > > Ah, this is the ioctl patch you had mentioned you mentioned previously.
> > > > I hadn't found the patch before.  Yes, this looks like it would work.  I
> > > > will see if I can get a prototype working with this patch.  Thanks.
> 
> > > If you need to shove samples into perf (versus mmap updates) I suspect 
> > > the prctl system call will have way to much overhead. In that case 
> > > perhaps processes could export a shared memory buffer that a perf 
> > > session could attach -- another aux buffer similar to what itrace needs. 
> > > But then that brings in the perf_clock issue; samples would need to have 
> > > the same time basis as kernel generated samples.
> 
> > I have the kernel patch by Pawel working to send the source file name,
> > the code address and the code size to perf and insert a new record into
> > the perf.data file as a uevent.  In the perf code, I have added code in
> > file util/session.c, perf_session__deliver_event() to call a function to
> > process the new event data.  
> 
> > I am trying to start with just getting the samples mapped to the elf
> > file.  I will try to implement mapping the samples to a specific source
> > code line later.  
> 
> > My thought is I need to take the data and create a "fake" elf file entry
> > with the file name, start address and code size so the will be able to
> > map sample addresses to the elf file for the java method.  I am
> > struggling to understand code flow for the perf record, specifically
> > when the elf files get read, mapping a sample to an elf file, etc.  It
> > is not clear to me how I would go about creating the fake elf file and
> > how to make it visible for use by the perf record tool.  Any pointers
> > and guidance would be appreciated.  Thanks.
> 
> I don't think you need to create any fake ELF file. The way things work
> are:
> 
> Somehow you start processing samples, be it by creating a perf_session
> object passing a perf.data file, or directly like 'perf trace' does. The
> perf_session method will, behind the scenes, do what perf trace does.
> 
> Then the callback you provided to perf_session, more specifically
> perf_tool.sample() will be called, and you will call some library
> functions to ask for it to find the thread, DSO and symbol for that
> sample.
> 
> More specifically the sequence map__load -> dso__load() will take place
> and at some point you will be able to call map__find_symbol() for a
> given address and it will return a struct symbol.
> 

I see that mmap and mmap2 call map__new() in map.c to create a new map
then call thread__insert_map() to add it into the rb_tree.  

> Behind the scenes what is done to have an rb_tree that will get you from
> addr to symbol will either use ELF routines to grab the symtab or do it
> via a /proc/kallsyms or similar, for instance, that java JIT interface
> described in tools/perf/Documentation/jit-interface.txt.

Yes, I see where the map__new() puts in the file name as
"/tmp/perf-pid.map" entry.  It looks like I will want to have the JIT
method name instead of "perf-pid".  This would then give the mapping of
the sample back to the JIT method name.  I will work on this a bit more.

> 
> But yes, since you mention "mapping samples to a specific source code
> line", then we only have that, at this moment, for ELF files. But if
> what you want is that, i.e. source code annotation, then you should look
> at how it parses objdump output, we could conceivably have support for
> other kinds of annotation sources, or you could instead generate output
> that mimics what objdump produces, so that the current parser could grok
> it, and instead of calling objdump to get an ELF file and produce that
> output, we would call a routine that with your input produces similar
> output.

The source code annotation would be nice in the future.  I will be happy
to just start with something a bit simpler, i.e. mapping the addresses
to the method name.  Best to get the basics figured out and then build
from there.

> 
> Does that help? Do you need some more specific explanation?

Yes, it helps get me going in the right direction.  Let me see if I can
get the mapping to the JIT method name working and I can then post what
I have so far and we can go from there.

Thanks.

               Carl Love
