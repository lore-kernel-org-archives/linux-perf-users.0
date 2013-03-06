From: David Ahern <dsahern@gmail.com>
Subject: Re: make O=/my/personal/build/using/root's/kernel/sources  --  broken
 for perf
Date: Wed, 06 Mar 2013 13:29:06 -0700
Message-ID: <5137A712.8080805@gmail.com>
References: <20130306115629.e98077bd2ec86da58b2d2996@lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:49892 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab3CFU3L (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 6 Mar 2013 15:29:11 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so6520207pbc.10
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Mar 2013 12:29:10 -0800 (PST)
In-Reply-To: <20130306115629.e98077bd2ec86da58b2d2996@lavabit.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: rh <richard_hubbe11@lavabit.com>
Cc: linux-perf-users@vger.kernel.org

On 3/6/13 12:56 PM, rh wrote:
> I hadn't tried to build perf using make O= previously so I don't know
> if it ever worked. But I tried to use it and it doesn't work.
>
> Also, I have a local libdef.h but perf doesn't see it/use it, it is in
> /usr/include/libelf/libelf.h
>
> I'm trying to use my system as an end user that has no root privileges.
> Therefore I am building the kernel in /usr/src/linux with
> make O=/my/output/dir

That's how I always build perf. Either from top-level 'make 
O=/tmp/pbuild -C tools/perf' or from tools/perf and just 'make 
O=/tmp/pbuild'. And often from a VM mounting the kernel tree over NFS 
read-only. It works fine for me.

What problem are you having and what version?

David
