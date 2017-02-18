From: Taeung Song <treeze.taeung@gmail.com>
Subject: Re: [Suggestion/Problems] perf annoate: Some problems related to the
 source code view and Improvement of it with line numbers
Date: Sat, 18 Feb 2017 09:15:49 +0900
Message-ID: <28f6e48a-9c4e-82e8-d48a-6b5f7aaae768@gmail.com>
References: <5c703d64-3ef4-3d43-bf99-f14c5fc4cdac@gmail.com>
 <20170215132411.GF4020@kernel.org>
 <963c309b-ca3a-e5a7-30f3-e0a521e5c3e5@gmail.com>
 <e0cdc76f-2c45-1528-e1e4-0fa3193c59cd@gmail.com>
 <20170217132939.GA4109@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33343 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751994AbdBRAQA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Feb 2017 19:16:00 -0500
In-Reply-To: <20170217132939.GA4109@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, perf group <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>



On 02/17/2017 10:29 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 17, 2017 at 11:33:29AM +0900, Taeung Song escreveu:
>> Hi, Arnaldo :)
>>
>> Regarding perf annotate:
>>
>> 1) Problem : wrong line numbers on perf-annotate (both stdio and TUI)
>> 2) Problem : wrong sum of overhead(percent) matching source lines
>> 3) Suggestion : new option showing only source code per function
>>                 with overhead info (to be more readable :) )
>>
>> I'll send the patchset for them, maybe it'll a bit take time.
>> But I won't be long..
>
> Concentrate on the first, send the patch, while waiting for review, work
> on the second, and so on :-)
>
> - Arnaldo
>

Understood!
I appreciate your concern :)

Thanks,
Taeung
