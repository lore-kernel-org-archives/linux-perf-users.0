From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Callgraph like kcachegrind
Date: Fri, 06 Jul 2012 09:27:47 +0900
Message-ID: <87obntlon0.fsf@sejong.aot.lge.com>
References: <r21ub9-8f1.ln1@barney.bruehl.pontohonk.de>
	<20120705004428.GA17035@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE1Q.lge.com ([156.147.1.111]:54674 "EHLO
	LGEMRELSE1Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932852Ab2GFAbo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 5 Jul 2012 20:31:44 -0400
In-Reply-To: <20120705004428.GA17035@infradead.org> (Arnaldo Carvalho de
	Melo's message of "Wed, 4 Jul 2012 21:44:28 -0300")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@infradead.org>
Cc: Christoph Bartoschek <bartoschek@gmx.de>, linux-perf-users@vger.kernel.org, Arun Sharma <asharma@fb.com>

On Wed, 4 Jul 2012 21:44:28 -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jun 28, 2012 at 02:59:39PM +0200, Christoph Bartoschek escreveu:
>> is it somehow possible to get a callgraph like gets it from kcachegrind?
>> 
>> I tried to use -g/-G on a program that runs but the information is not as 
>> expected. I do not see how the 100% runtime of main() is distributed.
>
> This is a feature we should have, but till then I think there is a
> script out there that does that, lemme try to google that, gack, I know
> there is one, but 'perf tools' really isn't google friendly, anyone?
>

I saw Arun posted a kind of cumulative (or inclusive) call graph patch
long ago. I guess it'd be the first step to have the feature like above.
And IIRC Ingo wanted to have it too.

Arun, what's the state of the patch?

Thanks,
Namhyung
