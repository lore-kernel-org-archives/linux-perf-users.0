From: Arun Sharma <asharma@fb.com>
Subject: Re: Callgraph like kcachegrind
Date: Thu, 5 Jul 2012 17:50:02 -0700
Message-ID: <4FF6363A.3020206@fb.com>
References: <r21ub9-8f1.ln1@barney.bruehl.pontohonk.de> <20120705004428.GA17035@infradead.org> <87obntlon0.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50238 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750846Ab2GFAuu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 5 Jul 2012 20:50:50 -0400
In-Reply-To: <87obntlon0.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>, Christoph Bartoschek <bartoschek@gmx.de>, linux-perf-users@vger.kernel.org

On 7/5/12 5:27 PM, Namhyung Kim wrote:
> On Wed, 4 Jul 2012 21:44:28 -0300, Arnaldo Carvalho de Melo wrote:
>> Em Thu, Jun 28, 2012 at 02:59:39PM +0200, Christoph Bartoschek escreveu:
>>> is it somehow possible to get a callgraph like gets it from kcachegrind?
>>>
>>> I tried to use -g/-G on a program that runs but the information is not as
>>> expected. I do not see how the 100% runtime of main() is distributed.
>>
>> This is a feature we should have, but till then I think there is a
>> script out there that does that, lemme try to google that, gack, I know
>> there is one, but 'perf tools' really isn't google friendly, anyone?
>>
>
> I saw Arun posted a kind of cumulative (or inclusive) call graph patch
> long ago. I guess it'd be the first step to have the feature like above.
> And IIRC Ingo wanted to have it too.
>
> Arun, what's the state of the patch?
>

http://thread.gmane.org/gmane.linux.kernel.perf.user/882 is the most 
recent patch I posted.

The last comments I got were:

* Use a global flag instead of a sort mode
* Try to integrate with LBR, branch filtering mode.

Unfortunately, I'm tied up with other projects right now and am not able 
to finish this up. Happy to answer questions about the patch if anyone 
wants to take it over.

http://thread.gmane.org/gmane.linux.kernel.perf.user/857 (callgraph 
filtering) is also related.

  -Arun
