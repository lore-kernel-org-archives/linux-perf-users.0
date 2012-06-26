From: David Ahern <dsahern@gmail.com>
Subject: Re: --mmap-pages option seemingly has no effect to help with LOST
 samples
Date: Tue, 26 Jun 2012 14:16:37 -0600
Message-ID: <4FEA18A5.8090106@gmail.com>
References: <4FD7ACB9.70205@us.ibm.com> <4FD7AF0C.1030300@gmail.com> <4FD8B32C.60608@us.ibm.com> <4FD8B641.9040907@gmail.com> <4FE49663.7000908@us.ibm.com> <4FE49A6F.7020503@gmail.com> <4FE4C589.5080802@us.ibm.com> <4FE4CB21.90005@gmail.com> <4FE4D446.5000906@us.ibm.com> <4FE4D7A8.5080607@gmail.com> <4FE87153.8010502@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59341 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab2FZUQn (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 26 Jun 2012 16:16:43 -0400
Received: by pbbrp8 with SMTP id rp8so538894pbb.19
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Jun 2012 13:16:43 -0700 (PDT)
In-Reply-To: <4FE87153.8010502@us.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Maynard Johnson <maynardj@us.ibm.com>
Cc: linux-perf-users@vger.kernel.org, suka@us.ibm.com

On 6/25/12 8:10 AM, Maynard Johnson wrote:

> Just an FYI -- adding ":u" doesn't help for RHEL 6.2.  Thanks much for the help so far.
>

What kind of processor are you using and what is the output of:
dmesg |grep Perf

David
