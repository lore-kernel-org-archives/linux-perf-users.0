From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: [PATCH perf/core 21/22] perf: Fix machine.vmlinux_maps to make
 sure to clear the old one
Date: Thu, 10 Dec 2015 10:52:45 +0800
Message-ID: <5668E8FD.7040307@huawei.com>
References: <20151209021047.10245.8918.stgit@localhost.localdomain> <20151209021133.10245.93730.stgit@localhost.localdomain> <20151209152256.GL15864@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:62785 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbbLJCxV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Dec 2015 21:53:21 -0500
In-Reply-To: <20151209152256.GL15864@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>



On 2015/12/9 23:22, Arnaldo Carvalho de Melo wrote:
> Em Wed, Dec 09, 2015 at 11:11:33AM +0900, Masami Hiramatsu escreveu:
>> Fix machine.vmlinux_maps to make sure to clear the old one
>> if it is renewal. This can leak the previous maps on the
>> vmlinux_maps because those are just overwritten.
>>
>> Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
>> ---
>>   tools/perf/util/machine.c |    5 +++++
>>   1 file changed, 5 insertions(+)

This patch solves one of my problem I met when 'perf test':

http://lkml.kernel.org/g/1449541544-67621-17-git-send-email-wangnan0@huawei.com

Thank you.
