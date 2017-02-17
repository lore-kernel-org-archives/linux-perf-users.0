From: Taeung Song <treeze.taeung@gmail.com>
Subject: Re: [Suggestion/Problems] perf annoate: Some problems related to the
 source code view and Improvement of it with line numbers
Date: Fri, 17 Feb 2017 11:33:29 +0900
Message-ID: <e0cdc76f-2c45-1528-e1e4-0fa3193c59cd@gmail.com>
References: <5c703d64-3ef4-3d43-bf99-f14c5fc4cdac@gmail.com>
 <20170215132411.GF4020@kernel.org>
 <963c309b-ca3a-e5a7-30f3-e0a521e5c3e5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35046 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754149AbdBQCde (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Feb 2017 21:33:34 -0500
In-Reply-To: <963c309b-ca3a-e5a7-30f3-e0a521e5c3e5@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, perf group <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>

Hi, Arnaldo :)

Regarding perf annotate:

1) Problem : wrong line numbers on perf-annotate (both stdio and TUI)
2) Problem : wrong sum of overhead(percent) matching source lines
3) Suggestion : new option showing only source code per function
                 with overhead info (to be more readable :) )

I'll send the patchset for them, maybe it'll a bit take time.
But I won't be long..

Thanks,
Taeung

On 02/15/2017 11:24 PM, Taeung Song wrote:
>
>
> On 02/15/2017 10:24 PM, Arnaldo Carvalho de Melo wrote:
>> Em Wed, Feb 15, 2017 at 09:34:51PM +0900, Taeung Song escreveu:
>>> > Hi all :)
>>> >
>>> > I found some problems about showing line numbers of perf-annotate.
>>> > and I have a suggestion about perf-annotate.
>>> >
>>> > Sure, I have a plan to send the patchset about that.
>>> > But I'd like to know other opinions about that before sending the
>>> patchset.
>>> > :)
>> Humm, TLDR, please try to find one problem, describe it precisely, show
>> before and after results (in the changeset message), and send it, rinse,
>> repeat.
>>
>> For instance, if the line numbers are different in --stdio and --tui,
>> that is a problem, state that, show the output (as you did below), put
>> it in a patch, send it.
>>
>
> Okey it was too long.
>
> I'll separate the contents into simple parts
> and send a patch with things you said :)
> for easy review.
>
> Thanks,
> Taeung
