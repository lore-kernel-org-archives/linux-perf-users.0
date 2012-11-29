From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Queries on using PERF tool
Date: Thu, 29 Nov 2012 15:59:59 +0900
Message-ID: <87lidkq4gg.fsf@sejong.aot.lge.com>
References: <loom.20121128T064019-497@post.gmane.org>
	<50B5A903.5080003@core.kaist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:46631 "EHLO
	LGEMRELSE7Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab2K2HAB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 29 Nov 2012 02:00:01 -0500
In-Reply-To: <50B5A903.5080003@core.kaist.ac.kr> (Chulmin Kim's message of
	"Wed, 28 Nov 2012 15:02:43 +0900")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Chulmin Kim <cmkim@core.kaist.ac.kr>
Cc: Shahina Rabbani <shahinarabbani.shaik@gmail.com>, linux-perf-users@vger.kernel.org

Hi,

On Wed, 28 Nov 2012 15:02:43 +0900, Chulmin Kim wrote:
> 2012-11-28 =EC=98=A4=ED=9B=84 2:47, Shahina Rabbani =EC=93=B4 =EA=B8=80=
:
>> Hi,
>>
>> I am a new user of PERF tool. I have few questions to ask about the =
PERF tool.
>> Please help me with the answers.
>>
>> Q1. Is it possible to use PERF tool on a piece of code? Say i have a=
 process P1
>> and the process has several functions F1, F2, F3. Is it possible to =
perform
>> profilng only on F1 Function ??
>>
>
> As other profiling tools do, PERF also supports monitoring per
> function (per SYMBOL).
>
> You can select the result related with the function you are intereste=
d in.

It's not profiling the function only, it's just filtering the function
in the whole result.  You might want to use 'perf probe' command - on a
recent kernel/perf tools support uprobe which is able to insert probe
points dynamically to any user-level codes/functions.

Thanks,
Namhyung
