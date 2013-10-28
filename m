From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Changing frequency rate to perf mem
Date: Mon, 28 Oct 2013 15:50:43 +0900
Message-ID: <87sivl99do.fsf@sejong.aot.lge.com>
References: <5267EE8E.3020306@bsc.es> <87ppqvs15r.fsf@tassilo.jf.intel.com>
	<5268D0B9.50704@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from lgeamrelo01.lge.com ([156.147.1.125]:64029 "EHLO
	LGEAMRELO01.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857Ab3J1Gup (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 28 Oct 2013 02:50:45 -0400
In-Reply-To: <5268D0B9.50704@bsc.es> (Harald Servat's message of "Thu, 24 Oct
	2013 09:48:09 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Harald Servat <harald.servat@bsc.es>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

Hi Harald,

On Thu, 24 Oct 2013 09:48:09 +0200, Harald Servat wrote:
> On 24/10/13 07:12, Andi Kleen wrote:
>> Harald Servat <harald.servat@bsc.es> writes:
>>> Unfortunately, this seems to break something and
>>> perf segfaults often. Which is the most appropriate way to tune the
>>> user frequency of perf mem?
>>
>> Best would be probably to fix it to pass through unknown
>> options, then -F/-c could be just used. I'm not sure
>> if this is possible easily with the git option parser.
>
> Sorry, I'm not sure what is the "git option parser" here.

Just implementation details.  The source code of the option parser came
from the git project.


> I think that this could be implemented extending the mem_options[] in
> file builtin-mem.c lines 205-221.

Or else, use 'perf record' directly as Andi suggested.

>
>> Alternatively you can just specify the command line perf mem record
>> would specify directly to perf record, plus -c/-F

  $ perf record -Wd -e cpu/mem-loads/pp -F 200 -- ls

  $ perf mem report


Thanks,
Namhyung
