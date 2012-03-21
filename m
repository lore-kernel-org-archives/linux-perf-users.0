From: David Ahern <dsahern@gmail.com>
Subject: Re: perf stat: Doubt about stall cycle support
Date: Wed, 21 Mar 2012 08:46:28 -0600
Message-ID: <4F69E9C4.8060108@gmail.com>
References: <loom.20120321T054053-857@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58901 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031255Ab2CUOqc (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 21 Mar 2012 10:46:32 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so839928pbc.19
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Mar 2012 07:46:31 -0700 (PDT)
In-Reply-To: <loom.20120321T054053-857@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Yipeng Huang <yipeng@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 3/20/12 10:42 PM, Yipeng Huang wrote:
> I am running perf stat to count hardware counters but am confused about stall
> cycle support.
>
> On running the command perf stat ./progname, I am told that stalled-cycles-
> frontend and stalled-cycles-backend are not counted, but when on running perf
> stat -v ./progname, I am told that stall cycles are not supported by the kernel.
> So which is it?

What does perf --version show?

Should be fixed by 2cee77c4505fc581f41b44e18ffc0953b67a414c.

David
