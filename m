From: David Ahern <dsahern@gmail.com>
Subject: Re: perf stat: Doubt about stall cycle support
Date: Wed, 21 Mar 2012 10:24:28 -0600
Message-ID: <4F6A00BC.8070705@gmail.com>
References: <loom.20120321T054053-857@post.gmane.org> <4F69E9C4.8060108@gmail.com> <CAB_n8zK5b0jWA=retCX12DGmrb19gMd2UxJGWkn6HD9nFrdiAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41961 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655Ab2CUQYb (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 21 Mar 2012 12:24:31 -0400
Received: by mail-pz0-f46.google.com with SMTP id r28so1793248daj.19
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Mar 2012 09:24:31 -0700 (PDT)
In-Reply-To: <CAB_n8zK5b0jWA=retCX12DGmrb19gMd2UxJGWkn6HD9nFrdiAQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: yipeng <yipeng@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 3/21/12 9:32 AM, yipeng wrote:
>
>     What does perf --version show?
>
>     Should be fixed by 2cee77c4505fc581f41b44e18ffc09__53b67a414c.
>
>     David
>
>
> I'm not sure what version that hash is. I'm using perf version
> 3.0.22. Is my version that too old?

That's a commit id for perf-stat to discriminate unsupported events from 
not counted events.

It was committed around 3.0 timeframe. Try compiling a newer version of 
perf and see if it addresses your concern.

David
