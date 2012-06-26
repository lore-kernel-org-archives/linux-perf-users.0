From: Maynard Johnson <maynardj@us.ibm.com>
Subject: Re: --mmap-pages option seemingly has no effect to help with LOST
 samples
Date: Tue, 26 Jun 2012 15:32:17 -0500
Message-ID: <4FEA1C51.4010701@us.ibm.com>
References: <4FD7ACB9.70205@us.ibm.com> <4FD7AF0C.1030300@gmail.com> <4FD8B32C.60608@us.ibm.com> <4FD8B641.9040907@gmail.com> <4FE49663.7000908@us.ibm.com> <4FE49A6F.7020503@gmail.com> <4FE4C589.5080802@us.ibm.com> <4FE4CB21.90005@gmail.com> <4FE4D446.5000906@us.ibm.com> <4FE4D7A8.5080607@gmail.com> <4FE87153.8010502@us.ibm.com> <4FEA18A5.8090106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:47398 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137Ab2FZUcZ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 26 Jun 2012 16:32:25 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <maynardj@us.ibm.com>;
	Tue, 26 Jun 2012 14:32:24 -0600
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 1D8B1C90050
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Jun 2012 16:32:19 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5QKWK3N19529778
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Jun 2012 16:32:20 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5QKWJaw007569
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Jun 2012 17:32:19 -0300
In-Reply-To: <4FEA18A5.8090106@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org, suka@us.ibm.com

On 06/26/2012 03:16 PM, David Ahern wrote:
> On 6/25/12 8:10 AM, Maynard Johnson wrote:
> 
>> Just an FYI -- adding ":u" doesn't help for RHEL 6.2.  Thanks much for the help so far.
>>
> 
> What kind of processor are you using and what is the output of:
> dmesg |grep Perf
As I mentioned, I'm seeing this symptom (incorrect counts) on both my Intel Core 2 Duo laptop and on an IBM POWER7 server.  On the POWER7, 'dmesg | grep Perf' shows nothing.  On my laptop, I get "Performance Events: PEBS fmt0+, Core2 events, Intel PMU driver."

-Maynard
> 
> David
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
