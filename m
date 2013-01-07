From: David Ahern <dsahern@gmail.com>
Subject: Re: Unsing perf BTS support
Date: Sun, 06 Jan 2013 20:14:29 -0700
Message-ID: <50EA3D95.7070308@gmail.com>
References: <50E707C9.4030102@redhat.com> <20130105090249.3253fd1858c5e1d05341c7ba@lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:40564 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477Ab3AGDOi (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 6 Jan 2013 22:14:38 -0500
Received: by mail-ie0-f172.google.com with SMTP id c13so22386584ieb.17
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Jan 2013 19:14:37 -0800 (PST)
In-Reply-To: <20130105090249.3253fd1858c5e1d05341c7ba@lavabit.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: rh <richard_hubbe11@lavabit.com>
Cc: linux-perf-users@vger.kernel.org

On 1/5/13 10:02 AM, rh wrote:
>  From what little I know about perf I think I recall that perf has to come
> from the kernel source of the kernel you're running.

perf binary should be compatible across kernel versions. e.g., perf from 
2.6.35 will work on kernel version 3.8 and perf from 3.8 kernel should 
work on 2.6.35.

David
