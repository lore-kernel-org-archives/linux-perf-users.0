From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: memory read/write access counts event in perf
Date: Sat, 02 Nov 2013 12:06:09 +0100
Message-ID: <5274DCA1.2050405@gmail.com>
References: <loom.20131102T102049-521@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38439 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab3KBLGM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 2 Nov 2013 07:06:12 -0400
Received: by mail-wi0-f170.google.com with SMTP id ex4so274681wid.3
        for <linux-perf-users@vger.kernel.org>; Sat, 02 Nov 2013 04:06:11 -0700 (PDT)
In-Reply-To: <loom.20131102T102049-521@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: caobenzhi <caobenzhi0915@gmail.com>, linux-perf-users@vger.kernel.org

Hi,

You can have a look at the "perf mem record" and "perf mem report" 
tools. On Intel hardware, the recording of memory latency is done 
through the PEBS load latency facility.

Manu

On 11/02/2013 10:25 AM, caobenzhi wrote:
> Hi,everyone~
> Recently I want to use perf to count the memory read/write access times, but
> when I use perf list|help, I can't find corresponding events? Does perf
> cannot be used to count memory access times? Any help will be appreciated,
> thanks a lot~
> Best
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
