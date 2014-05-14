From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Access to backtraces from user-space tracepoint callback in perf-script?
Date: Wed, 14 May 2014 09:33:35 +0900
Message-ID: <87lhu5mc68.fsf@sejong.aot.lge.com>
References: <1998748.ORBRrU6aol@milian-kdab2>
	<4531806.6Q1YW4Luy6@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:40006 "EHLO
	lgemrelse6q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbaENAdj (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 13 May 2014 20:33:39 -0400
In-Reply-To: <4531806.6Q1YW4Luy6@milian-kdab2> (Milian Wolff's message of
	"Wed, 07 May 2014 14:46:31 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: linux-perf-users@vger.kernel.org

Hi Milian,

On Wed, 07 May 2014 14:46:31 +0200, Milian Wolff wrote:
> On Tuesday 29 April 2014 17:44:54 Milian Wolff wrote:
>> Hello,
>> 
>> today I played around with perf-script(-python) and custom tracepoints. What
>> I could not figure out so far is how to print a backtrace from the python
>> callback. Can someone explain me how this is done, or point me to the
>> documentation for this?
>
> Ping? Could someone help me here please?

As far as I know it's not possible currently.. I vaguely recall that
there's a patch to support the feature but unfortunately it didn't get
reviews..

Thanks,
Namhyung
