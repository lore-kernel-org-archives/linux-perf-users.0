From: Mark Davis <markdavisinboston@gmail.com>
Subject: Re: make perf-targz-src-pkg or better approach to install perf?
Date: Wed, 22 Feb 2017 17:04:19 -0500
Message-ID: <CAPe7T+-1ADZ+m7LYZpEGf9LnsCDo0oFvoPKjbdj5CqnAATa5HA@mail.gmail.com>
References: <CAPe7T+-MO04yfoNSMy91F-z9F759Y8Moa_NUBs7KUJURmVrtJA@mail.gmail.com>
 <20170221231507.GI5052@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ot0-f177.google.com ([74.125.82.177]:36561 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754175AbdBVWEU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Feb 2017 17:04:20 -0500
Received: by mail-ot0-f177.google.com with SMTP id j38so12131962otb.3
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Feb 2017 14:04:20 -0800 (PST)
In-Reply-To: <20170221231507.GI5052@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Arnaldo, thanks for pushing that. I will try this with clang 4.0. Just
so I'm clear, I'm assuming your fix does not address my other issue of
"make perf-targz-src-pkg" no longer existing in this version of
tools/perf, right? If that's true, any suggestions on how I get the
dependencies for my system, other than via manual installation?

On Tue, Feb 21, 2017 at 6:15 PM, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
> Em Tue, Feb 21, 2017 at 03:42:39PM -0500, Mark Davis escreveu:
>> Hi all. I used to use
>>
>> make perf-targz-src-pkg
>>
>> to install perf from the linux/tools/perf source. I'm now trying to
>> upgrade my perf installation from source again and I'm not seeing this
>> make target. I'm having a bit of trouble with dependencies. Here's
>> what I get when I try to build. (Note: my source is from github
>> (https://github.com/torvalds/linux) at 772c8f6 (from a couple hours
>
> So, please pull again from that repo, I made changes to make tools/
> build with clang 4.0, should be working and have the warnings addressed
> below fixed.
>
>> ago). Is there a new / recommended approach to installing perf that is
>> similar to the above approach? I don't have root on this machine and
>> need to install either from source or a relatively recent package that
>> I can install to an arbitrary directory. I'm using clang 3.8.0 as my
>> compiler (note: I can change this or upgrade this if necessary). In
>> particular I'm trying to get BPF in perf-record, which seems to be
>> disabled based on the warnings that print out.
>>
>> I'm also getting this other compiler error:
>>
>> warning: optimization level '-O6' is not supported; using '-O3' instead
>>
>>   CC       pmu-events/pmu-events.o
>>
>> error: unknown warning option '-Wstrict-aliasing=3'; did you mean
>> '-Wstring-plus-int'?
>>
>>       [-Werror,-Wunknown-warning-option]
>>
>>
>
> - Arnaldo
