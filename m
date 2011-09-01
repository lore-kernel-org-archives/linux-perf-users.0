From: Maynard Johnson <maynardj@us.ibm.com>
Subject: Re: Profiling Java code running on Sun HotSpot JVM with linux perf
Date: Thu, 01 Sep 2011 09:58:34 -0500
Message-ID: <4E5F9D9A.3060307@us.ibm.com>
References: <CACiFetRWM4nmfAhB1J6dSSJdiQnCqov8XQYHqrSuxSiMrWoLFA@mail.gmail.com> <CAJSP0QUEcbuxE6n0pb3rydaUuna_nLi-gPZVT6TXGS5OXMAK9A@mail.gmail.com>
Reply-To: maynardj@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:57160 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932185Ab1IAO7T (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 1 Sep 2011 10:59:19 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p81EP4Qs022313
	for <linux-perf-users@vger.kernel.org>; Thu, 1 Sep 2011 10:25:04 -0400
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p81ExHqL151848
	for <linux-perf-users@vger.kernel.org>; Thu, 1 Sep 2011 10:59:17 -0400
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p81F4K9H012969
	for <linux-perf-users@vger.kernel.org>; Thu, 1 Sep 2011 09:04:20 -0600
In-Reply-To: <CAJSP0QUEcbuxE6n0pb3rydaUuna_nLi-gPZVT6TXGS5OXMAK9A@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Geoffrey Blake <geoffrey.w.blake@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, linux-perf-users@vger.kernel.org

On 08/31/2011 2:35 AM, Stefan Hajnoczi wrote:
> On Tue, Aug 30, 2011 at 9:03 PM, Geoffrey Blake
> <geoffrey.w.blake@gmail.com>  wrote:
>> Hi all,
>>
>> I am trying to profile some java server applications using %>perf
>> record -a, and as expected the majority of the execution time of these
>> applications is spent within jit'ed java code.  According to these
>> lists, the jit should be outputting a /tmp/perf-$pid.map file for each
>> thread being jit'ed.  The Sun JIT does not seem to have this output
>> enabled by default.  Does anyone here know what options I need to set
>> on the command line to get the JVM to output the symbol map files from
>> the JIT?
>
> I don't know the answer but if you don't get one here you could check
> the OProfile mailing list.  I believe there was a solution for JIT
> compilers with OProfile and people probably got popular JVMs like
> HotSpot working.  That might reveal what support HotSpot has for doing
> this.
Geoffrey,
I don't know if there's a way to get perf to show you profile information for 
Java class methods, but as Stefan said, you can indeed get this using oprofile. 
  See http://oprofile.sourceforge.net/doc/index.html and read every section with 
"JIT" in the title.

-Maynard

>
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
