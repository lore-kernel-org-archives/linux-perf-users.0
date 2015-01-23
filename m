From: Sujoy Saraswati <sujoy.saraswati@hp.com>
Subject: Re: Perf support for interpreted and Just-In-Time translated olanguages
Date: Fri, 23 Jan 2015 08:25:25 +0000 (UTC)
Message-ID: <loom.20150123T092344-985@post.gmane.org>
References: <1417810736.5098.11.camel@oc0276584878.ibm.com>  <CAE40pdcXt_gaCXD7n3UED4Y2_gdpH+A3S627TS-72xkbGDoNsA@mail.gmail.com>  <20141209203419.GI4189@kernel.org> <87ppbs4h5k.fsf@tassilo.jf.intel.com>  <20141209222203.GD8788@kernel.org>  <20141210173228.GA6759@two.firstfloor.org> <54888569.30409@gmail.com>  <20141210180529.GB6759@two.firstfloor.org> <54889086.4070606@gmail.com>  <20141210194302.GH8788@kernel.org>  <1420834758.4897.10.camel@oc0276584878.ibm.com>  <54B0A757.2010407@redhat.com>  <54B141F2.60104@gmail.com>  <1421083368.6211.2.camel@oc0276584878.ibm.com> <54B40B51.5080107@gmail.com> <1421777950.4953.40.camel@oc0276584878.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51596 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753969AbbAWIaF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 23 Jan 2015 03:30:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1YEZcx-0004E2-Il
	for linux-perf-users@vger.kernel.org; Fri, 23 Jan 2015 09:30:03 +0100
Received: from idp01pxyout-6.asiapac.hp.net ([15.219.201.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2015 09:30:03 +0100
Received: from sujoy.saraswati by idp01pxyout-6.asiapac.hp.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2015 09:30:03 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

Carl Love <cel <at> us.ibm.com> writes:

> 
> On Mon, 2015-01-12 at 10:58 -0700, David Ahern wrote:
> > On 1/12/15 10:22 AM, Carl Love wrote:
> > > Ah, this is the ioctl patch you had mentioned you mentioned 
previously.
> > > I hadn't found the patch before.  Yes, this looks like it would 
work.  I
> > > will see if I can get a prototype working with this patch.  
Thanks.
> > >
> > 
> > If you need to shove samples into perf (versus mmap updates) I 
suspect 
> > the prctl system call will have way to much overhead. In that case 
> > perhaps processes could export a shared memory buffer that a perf 
> > session could attach -- another aux buffer similar to what itrace 
needs. 
> > But then that brings in the perf_clock issue; samples would need to 
have 
> > the same time basis as kernel generated samples.
> > 
> 
> I have the kernel patch by Pawel working to send the source file name,
> the code address and the code size to perf and insert a new record 
into
> the perf.data file as a uevent.  In the perf code, I have added code 
in
> file util/session.c, perf_session__deliver_event() to call a function 
to
> process the new event data.  
> 
> I am trying to start with just getting the samples mapped to the elf
> file.  I will try to implement mapping the samples to a specific 
source
> code line later.  
> 
> My thought is I need to take the data and create a "fake" elf file 
entry
> with the file name, start address and code size so the will be able to
> map sample addresses to the elf file for the java method.  I am
> struggling to understand code flow for the perf record, specifically
> when the elf files get read, mapping a sample to an elf file, etc.  It
> is not clear to me how I would go about creating the fake elf file and
> how to make it visible for use by the perf record tool.  Any pointers
> and guidance would be appreciated.  Thanks.

 FWIW, the HP caliper tool on HP-UX/IPF has some similar functionality 
to show Java function names and show an annotated source code in the 
function disassembly part of the report. Caliper runs as a separate 
process measuring the target process by tracing it, and the target 
process can register dynamically generated code/module with caliper. JVM 
code for HP-UX was modified to use this framework to register the 
dynamically generated methods with caliper at runtime.

 As for the source code annotation for JVM generated code through JIT 
compiler, we use a Java option to dump the annotated assembly from JIT 
into a file, and also generate an index file to search the assembly dump 
given an address. The index file is somewhat similar to a dwarf line 
table, but it's just a plain text file and not in an elf format. When 
caliper shows the disassembly, it looks up for the index file and finds 
the relevant annotation to display for the address ranges in the 
assembly. Since the annotated dump comes from Java itself, it contains 
information like source line number, prologue region etc. For example, 
if it is a safepoint, the information about Oop maps, bytecode index, 
etc are available in those annotations which are very JVM specific. 
Basically, the idea was to merge the JVM assembly annotations along with 
the caliper report.

 I am not familiar with perf, but just wanted to bring up this 
information to this forum to see if this could be an approach to 
consider for the samples to source co-relation. The source co-relation 
comes from the JIT compiler like JVM, and can probably made into 
annotation records. Along with this, the index file could be used to co-
relate the annotation records to the address ranges seen in samples.

Regards,
Sujoy
