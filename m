From: Carl Love <cel@us.ibm.com>
Subject: Re: Perf support for interpreted and Just-In-Time translated
 olanguages
Date: Tue, 20 Jan 2015 10:19:10 -0800
Message-ID: <1421777950.4953.40.camel@oc0276584878.ibm.com>
References: <1417810736.5098.11.camel@oc0276584878.ibm.com>
	 <CAE40pdcXt_gaCXD7n3UED4Y2_gdpH+A3S627TS-72xkbGDoNsA@mail.gmail.com>
	 <20141209203419.GI4189@kernel.org> <87ppbs4h5k.fsf@tassilo.jf.intel.com>
	 <20141209222203.GD8788@kernel.org>
	 <20141210173228.GA6759@two.firstfloor.org> <54888569.30409@gmail.com>
	 <20141210180529.GB6759@two.firstfloor.org> <54889086.4070606@gmail.com>
	 <20141210194302.GH8788@kernel.org>
	 <1420834758.4897.10.camel@oc0276584878.ibm.com>
	 <54B0A757.2010407@redhat.com>  <54B141F2.60104@gmail.com>
	 <1421083368.6211.2.camel@oc0276584878.ibm.com> <54B40B51.5080107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:48856 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbbATSTQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 20 Jan 2015 13:19:16 -0500
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <cel@us.ibm.com>;
	Tue, 20 Jan 2015 11:19:15 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 5BDC93E40030
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2015 11:19:03 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t0KIHtqC22216856
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2015 11:17:55 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t0KIJB2T026340
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2015 11:19:11 -0700
In-Reply-To: <54B40B51.5080107@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: William Cohen <wcohen@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Mon, 2015-01-12 at 10:58 -0700, David Ahern wrote:
> On 1/12/15 10:22 AM, Carl Love wrote:
> > Ah, this is the ioctl patch you had mentioned you mentioned previously.
> > I hadn't found the patch before.  Yes, this looks like it would work.  I
> > will see if I can get a prototype working with this patch.  Thanks.
> >
> 
> If you need to shove samples into perf (versus mmap updates) I suspect 
> the prctl system call will have way to much overhead. In that case 
> perhaps processes could export a shared memory buffer that a perf 
> session could attach -- another aux buffer similar to what itrace needs. 
> But then that brings in the perf_clock issue; samples would need to have 
> the same time basis as kernel generated samples.
> 

I have the kernel patch by Pawel working to send the source file name,
the code address and the code size to perf and insert a new record into
the perf.data file as a uevent.  In the perf code, I have added code in
file util/session.c, perf_session__deliver_event() to call a function to
process the new event data.  

I am trying to start with just getting the samples mapped to the elf
file.  I will try to implement mapping the samples to a specific source
code line later.  

My thought is I need to take the data and create a "fake" elf file entry
with the file name, start address and code size so the will be able to
map sample addresses to the elf file for the java method.  I am
struggling to understand code flow for the perf record, specifically
when the elf files get read, mapping a sample to an elf file, etc.  It
is not clear to me how I would go about creating the fake elf file and
how to make it visible for use by the perf record tool.  Any pointers
and guidance would be appreciated.  Thanks.

                        Carl Love
