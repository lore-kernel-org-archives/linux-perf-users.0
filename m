From: David Ahern <dsahern@gmail.com>
Subject: Re: Profile the waiting time for lock or lock stats for one application
Date: Wed, 26 Feb 2014 20:29:48 -0700
Message-ID: <530EB12C.9020407@gmail.com>
References: <1393351991.27573.YahooMailNeo@web124901.mail.ne1.yahoo.com> <1393471039.86366.YahooMailNeo@web124905.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:57710 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbaB0D3x (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 26 Feb 2014 22:29:53 -0500
Received: by mail-pa0-f48.google.com with SMTP id kx10so1890143pab.7
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2014 19:29:52 -0800 (PST)
In-Reply-To: <1393471039.86366.YahooMailNeo@web124905.mail.ne1.yahoo.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Junjie Qian <junjie.qian@yahoo.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On 2/26/14, 8:17 PM, Junjie Qian wrote:
> Hi all,
>
> This is a follow up question about "perf lock".
> I recompile the kernel, with both CONFIG_LOCKDEP and CONFIG_LOCK_STAT are "y". But when I run the command "perf lock record -- sleep 10", the error information still shows as:
> tracepoint lock:lock_acquire is not enabled. Are CONFIG_LOCKDEP and CONFIG_LOCK_STAT enabled?
>
> Could you give me some suggestions on this?

are you running as root? If you are running perf as a normal user is the 
events directory accessible -- /sys/kernel/debug/tracing? Does 
/sys/kernel/debug/tracing/events/lock exist?

David
