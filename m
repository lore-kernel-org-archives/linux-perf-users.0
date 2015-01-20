From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Perf support for interpreted and Just-In-Time translated
 olanguages
Date: Tue, 20 Jan 2015 16:29:26 -0300
Message-ID: <20150120192926.GG3451@kernel.org>
References: <54888569.30409@gmail.com>
 <20141210180529.GB6759@two.firstfloor.org>
 <54889086.4070606@gmail.com>
 <20141210194302.GH8788@kernel.org>
 <1420834758.4897.10.camel@oc0276584878.ibm.com>
 <54B0A757.2010407@redhat.com>
 <54B141F2.60104@gmail.com>
 <1421083368.6211.2.camel@oc0276584878.ibm.com>
 <54B40B51.5080107@gmail.com>
 <1421777950.4953.40.camel@oc0276584878.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47908 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557AbbATT3d (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 20 Jan 2015 14:29:33 -0500
Content-Disposition: inline
In-Reply-To: <1421777950.4953.40.camel@oc0276584878.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Carl Love <cel@us.ibm.com>
Cc: David Ahern <dsahern@gmail.com>, William Cohen <wcohen@redhat.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

Em Tue, Jan 20, 2015 at 10:19:10AM -0800, Carl Love escreveu:
> On Mon, 2015-01-12 at 10:58 -0700, David Ahern wrote:
> > On 1/12/15 10:22 AM, Carl Love wrote:
> > > Ah, this is the ioctl patch you had mentioned you mentioned previously.
> > > I hadn't found the patch before.  Yes, this looks like it would work.  I
> > > will see if I can get a prototype working with this patch.  Thanks.

> > If you need to shove samples into perf (versus mmap updates) I suspect 
> > the prctl system call will have way to much overhead. In that case 
> > perhaps processes could export a shared memory buffer that a perf 
> > session could attach -- another aux buffer similar to what itrace needs. 
> > But then that brings in the perf_clock issue; samples would need to have 
> > the same time basis as kernel generated samples.
 
> I have the kernel patch by Pawel working to send the source file name,
> the code address and the code size to perf and insert a new record into
> the perf.data file as a uevent.  In the perf code, I have added code in
> file util/session.c, perf_session__deliver_event() to call a function to
> process the new event data.  
 
> I am trying to start with just getting the samples mapped to the elf
> file.  I will try to implement mapping the samples to a specific source
> code line later.  
 
> My thought is I need to take the data and create a "fake" elf file entry
> with the file name, start address and code size so the will be able to
> map sample addresses to the elf file for the java method.  I am
> struggling to understand code flow for the perf record, specifically
> when the elf files get read, mapping a sample to an elf file, etc.  It
> is not clear to me how I would go about creating the fake elf file and
> how to make it visible for use by the perf record tool.  Any pointers
> and guidance would be appreciated.  Thanks.

I don't think you need to create any fake ELF file. The way things work
are:

Somehow you start processing samples, be it by creating a perf_session
object passing a perf.data file, or directly like 'perf trace' does. The
perf_session method will, behind the scenes, do what perf trace does.

Then the callback you provided to perf_session, more specifically
perf_tool.sample() will be called, and you will call some library
functions to ask for it to find the thread, DSO and symbol for that
sample.

More specifically the sequence map__load -> dso__load() will take place
and at some point you will be able to call map__find_symbol() for a
given address and it will return a struct symbol.

Behind the scenes what is done to have an rb_tree that will get you from
addr to symbol will either use ELF routines to grab the symtab or do it
via a /proc/kallsyms or similar, for instance, that java JIT interface
described in tools/perf/Documentation/jit-interface.txt.

But yes, since you mention "mapping samples to a specific source code
line", then we only have that, at this moment, for ELF files. But if
what you want is that, i.e. source code annotation, then you should look
at how it parses objdump output, we could conceivably have support for
other kinds of annotation sources, or you could instead generate output
that mimics what objdump produces, so that the current parser could grok
it, and instead of calling objdump to get an ELF file and produce that
output, we would call a routine that with your input produces similar
output.

Does that help? Do you need some more specific explanation?

- Arnaldo
