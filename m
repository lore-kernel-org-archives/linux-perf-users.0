From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Callgraph like kcachegrind
Date: Fri, 6 Jul 2012 10:28:28 +0900
Message-ID: <CAM9d7cjaRxCgwi2QM5dd3w59mORJ5wo8k9DO71d5AhhL5Fvo=g@mail.gmail.com>
References: <r21ub9-8f1.ln1@barney.bruehl.pontohonk.de> <20120705004428.GA17035@infradead.org>
 <87obntlon0.fsf@sejong.aot.lge.com> <4FF6363A.3020206@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:40838 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050Ab2GFB2t (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 5 Jul 2012 21:28:49 -0400
Received: by qadb17 with SMTP id b17so163079qad.19
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Jul 2012 18:28:49 -0700 (PDT)
In-Reply-To: <4FF6363A.3020206@fb.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>, Christoph Bartoschek <bartoschek@gmx.de>, linux-perf-users@vger.kernel.org

Hi,

On Fri, Jul 6, 2012 at 9:50 AM, Arun Sharma <asharma@fb.com> wrote:
> On 7/5/12 5:27 PM, Namhyung Kim wrote:
>>
>> On Wed, 4 Jul 2012 21:44:28 -0300, Arnaldo Carvalho de Melo wrote:
>>>
>>> Em Thu, Jun 28, 2012 at 02:59:39PM +0200, Christoph Bartoschek escreveu:
>>>>
>>>> is it somehow possible to get a callgraph like gets it from kcachegrind?
>>>>
>>>> I tried to use -g/-G on a program that runs but the information is not
>>>> as
>>>> expected. I do not see how the 100% runtime of main() is distributed.
>>>
>>>
>>> This is a feature we should have, but till then I think there is a
>>> script out there that does that, lemme try to google that, gack, I know
>>> there is one, but 'perf tools' really isn't google friendly, anyone?
>>>
>>
>> I saw Arun posted a kind of cumulative (or inclusive) call graph patch
>> long ago. I guess it'd be the first step to have the feature like above.
>> And IIRC Ingo wanted to have it too.
>>
>> Arun, what's the state of the patch?
>>
>
> http://thread.gmane.org/gmane.linux.kernel.perf.user/882 is the most recent
> patch I posted.
>
> The last comments I got were:
>
> * Use a global flag instead of a sort mode
> * Try to integrate with LBR, branch filtering mode.
>
> Unfortunately, I'm tied up with other projects right now and am not able to
> finish this up. Happy to answer questions about the patch if anyone wants to
> take it over.
>

Ok, I'll try to look at it.


> http://thread.gmane.org/gmane.linux.kernel.perf.user/857 (callgraph
> filtering) is also related.
>

And this one once the above gets settled.

Thanks,
Namhyung
