From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
Subject: Re: perf top -z not working?
Date: Mon, 22 Oct 2012 07:50:41 -0400
Message-ID: <50853311.3040707@cs.utoronto.ca>
References: <507EA40D.60206@cs.utoronto.ca> <507EB776.9030304@core.kaist.ac.kr> <20121022014618.GA7924@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from bureau60.ns.utoronto.ca ([128.100.132.147]:57594 "EHLO
	bureau60.ns.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412Ab2JVLuu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 22 Oct 2012 07:50:50 -0400
In-Reply-To: <20121022014618.GA7924@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Chulmin Kim <cmkim@core.kaist.ac.kr>, linux-perf-users@vger.kernel.org

On 21/10/2012 9:46 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Oct 17, 2012 at 10:49:42PM +0900, Chulmin Kim escreveu:
>> 2012-10-17 =EC=98=A4=ED=9B=84 9:26, Ryan Johnson =EC=93=B4 =EA=B8=80=
:
>>> (Please CC me in replies, not a list member)
>>>
>>> It seems that `perf top -z' does not behave as advertized, at
>>> least not on the 3.2.0-25 kernel (Ubuntu) that I'm running. The
>>> man page states that it should "zero history across display
>>> updates" but the counts still seem to accumulate (the total
>>> samples reported rises monotonically) and processes still show up
>>> in the display long after they have exited. Pressing `z' or `Z'
>>> seems to have no effect, either.
> Are you using the --tui or --stdio interface? Try with both and check=
 if
> it works in one of them, I bet the problem is with --tui.
--stdio does the same, so I'll have to try updating my kernel like=20
Chulmin suggested (haven't had time to do that yet)

Thanks,
Ryan
