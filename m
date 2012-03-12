From: Arun Sharma <asharma@fb.com>
Subject: Re: [PATCH 0/2] perf: add sort by inclusive time functionality (v2)
Date: Mon, 12 Mar 2012 12:58:04 -0700
Message-ID: <4F5E554C.4060209@fb.com>
References: <1331160079-13821-1-git-send-email-asharma@fb.com> <4F5DA91F.7060908@lge.com> <4F5E3E8C.1020005@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41248 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756287Ab2CLT6Y (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 12 Mar 2012 15:58:24 -0400
In-Reply-To: <4F5E3E8C.1020005@fb.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung.kim@lge.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Mike Galbraith <efault@gmx.de>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org

On 3/12/12 11:21 AM, Arun Sharma wrote:

>>
>> BTW, I don't like the name 'inclusive' as a sort key. If it cares about
>> time, IMHO, the name should contain 'time' - something like 'itime' or
>> 'inctime'?
>
> The existing sort orders: pid, comm, dso, symbol, parent -- all care
> about time, but none of them have time in their name?

I'll take that back. What they sort on depends on the event.

perf record -ge cache-misses
perf report -s inclusive

will sort by the number of cache-misses and not time.

  -Arun
