From: David Ahern <dsahern@gmail.com>
Subject: Re: How to trace threads created by a process after perf has started
 recording, using the -p PID flag?
Date: Sat, 22 Sep 2012 12:39:13 -0600
Message-ID: <505E05D1.6090405@gmail.com>
References: <CAHFo2uodOOiTKRbeZvFFbGry8XK85unXz+_L6imgH6EeiROc0Q@mail.gmail.com> <CAKYOsXwF-Rk97BEWk_fEHhfVisPy_q439tdx7H9onAOyFi=-uA@mail.gmail.com> <CAHFo2up0cy4A8pSX5=dJ4k95ZtUTEzvzqcvfRoaoUjedpcvw5Q@mail.gmail.com> <5046268F.4050504@gmail.com> <CAHFo2uq2pKx1FKSv5=mE7WhaqixJ2vzCSBxPeaz3DKE90vz0OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57635 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664Ab2IVSjS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 22 Sep 2012 14:39:18 -0400
Received: by pbbrr4 with SMTP id rr4so4765474pbb.19
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Sep 2012 11:39:17 -0700 (PDT)
In-Reply-To: <CAHFo2uq2pKx1FKSv5=mE7WhaqixJ2vzCSBxPeaz3DKE90vz0OQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mikolaj Konarski <mikolaj.konarski@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Bernie Pope <florbitous@gmail.com>, Duncan Coutts <duncan@well-typed.com>

On 9/22/12 1:58 AM, Mikolaj Konarski wrote:
> Are we missing anything? Is the "--timestamp" option of perf-record
> related in any way? Any other tips?

That option adds the timestamps to the samples if it were not otherwise 
added.

>
> We're working around right now by syncing with a timestamp
> of a known event, but that leaves us vulnerable to a time drift.
> If there's no way currently to generate externally meaningful
> timestamps, could we file a feature request for the sake of the future?

You mean like this: https://lkml.org/lkml/2011/6/7/638

David
