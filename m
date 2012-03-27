From: Arun Sharma <asharma@fb.com>
Subject: Re: [PATCH] perf: Add a new sort order: SORT_INCLUSIVE (v4)
Date: Tue, 27 Mar 2012 11:09:48 -0700
Message-ID: <4F72026C.3050604@fb.com>
References: <1331746607-6706-1-git-send-email-asharma@fb.com> <20120315141402.GA550@somewhere.redhat.com> <4F622DCE.4090608@fb.com> <20120319155742.GF2660@somewhere> <4F691289.7080505@fb.com> <20120325021451.GA14971@somewhere.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53765 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754635Ab2C0SKL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 27 Mar 2012 14:10:11 -0400
In-Reply-To: <20120325021451.GA14971@somewhere.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Arnaldo Carvalho de Melo <acme@redhat.com>, Mike Galbraith <efault@gmx.de>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Namhyung Kim <namhyung.kim@lge.com>, Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org

On 3/24/12 7:14 PM, Frederic Weisbecker wrote:

>> The other problem in branch stacks/LBR is that they're
>> sampled branches. Just because I got a sample with:
>>
>> a ->  b
>> b ->  c
>>
>> doesn't necessarily mean that the callchain was a ->  b ->  c.
>
> Not sure what you mean. If you have a ->  b, b ->  c in single
> LBR sample it means you got a ->  b ->  c.
>

I was going by Stephane's commit message here:

http://article.gmane.org/gmane.linux.kernel/1236999

 > Statistical sampling of taken branch should not be confused
 > for branch tracing. Not all branches are necessarily captured

Stephane, could you please explain if the 16 filtered branches in LBR 
are guaranteed to be from a given callchain to the leaf function? My 
understanding is that it's not.

callchain1: a -> b -> d -> e (sample a->b)
callchain2: a -> c -> b -> f (sample b->f)

on PMU interrupt can we end up with:

b -> f <- top of stack
a -> b
...

even though a -> b -> f can never happen in the actual program flow?

  -Arun
