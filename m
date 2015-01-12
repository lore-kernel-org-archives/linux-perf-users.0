From: Carl Love <cel@us.ibm.com>
Subject: Re: Perf support for interpreted and Just-In-Time translated
 olanguages
Date: Mon, 12 Jan 2015 10:43:09 -0800
Message-ID: <1421088189.6211.7.camel@oc0276584878.ibm.com>
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
Received: from e39.co.us.ibm.com ([32.97.110.160]:38226 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755790AbbALSnO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 12 Jan 2015 13:43:14 -0500
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <cel@us.ibm.com>;
	Mon, 12 Jan 2015 11:43:14 -0700
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id EB9D938C8046
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2015 13:43:11 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t0CIhB9n30801966
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2015 18:43:11 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t0CIhAAe025996
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2015 13:43:11 -0500
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
> David

David:

My thought was to just send the load/unload notifications with a key of
some sort that can then be used to correlate the load/unload key to the
same key associated with an entry in a separate file where the code
would be written.  The build-id was mentioned by Arnaldo which could be
used as the key.  I was trying to figure out if I can generate the
build-id key in the java library file.  Not sure if that is practical at
this point.  

            Carl Love
