From: Maynard Johnson <maynardj@us.ibm.com>
Subject: Re: Sampling instruction pointer on PPC
Date: Thu, 01 Mar 2012 13:49:56 -0600
Message-ID: <4F4FD2E4.9090500@us.ibm.com>
References: <4F4FACFA.6080209@bsc.es>
Reply-To: maynardj@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:60078 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561Ab2CATvX (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 1 Mar 2012 14:51:23 -0500
Received: from /spool/local
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <maynardj@us.ibm.com>;
	Thu, 1 Mar 2012 12:51:22 -0700
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id F1D45C4000E
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Mar 2012 12:50:16 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q21Jo54X072338
	for <linux-perf-users@vger.kernel.org>; Thu, 1 Mar 2012 12:50:05 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q21JoIPb031188
	for <linux-perf-users@vger.kernel.org>; Thu, 1 Mar 2012 12:50:18 -0700
In-Reply-To: <4F4FACFA.6080209@bsc.es>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Victor Jimenez <victor.javier@bsc.es>
Cc: linux-perf-users@vger.kernel.org

On 03/01/2012 11:08 AM, Victor Jimenez wrote:
> I am trying to sample instruction pointer along time on a Power7 system. I know
> that there are accurate mechanisms to do so in Intel processors (e.g., PEBS and
> Branch Trace Store).
>
> Is it possible to do something similar in Power7? Will the samples be accurate?
> I am worried that significant delays (skids) may appear.
Victor,
There's a subset of events that have a prefix of "PM_MRK_".  These are referred 
to as "marked events".  When profiling with such events, the PMU will randomly 
select (mark) an instruction in a group and follow it through the pipeline.  By 
profiling on marked events, it's possible to uniquely identify which instruction 
caused a particular event.

This technique results in fewer samples being recorded than for non-marked 
events, but those that are recorded are almost always precise (no skid). 
Because you will get fewer than the normal number of samples, you should either 
profile at a higher sampling rate than normal or make sure your application runs 
long enough to give you statistically valid results.  My rule of thumb is to use 
a sampling rate of 100x what I would normally use for the non-marked event.

-Maynard
>
> Thank you,
> Victor
>
> WARNING / LEGAL TEXT: This message is intended only for the use of the
> individual or entity to which it is addressed and may contain
> information which is privileged, confidential, proprietary, or exempt
> from disclosure under applicable law. If you are not the intended
> recipient or the person responsible for delivering the message to the
> intended recipient, you are strictly prohibited from disclosing,
> distributing, copying, or in any way using this message. If you have
> received this communication in error, please notify the sender and
> destroy and delete any copies you may have received.
>
> http://www.bsc.es/disclaimer.htm
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
