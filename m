From: Arun Sharma <asharma@fb.com>
Subject: Re: Profiling sleep times?
Date: Mon, 10 Oct 2011 11:50:13 -0700
Message-ID: <4E933E65.1090207@fb.com>
References: <4E8A0F53.7020408@fb.com> <1317673027.20367.41.camel@twins>  <4E8A2EC5.1030901@fb.com> <1317717291.25926.13.camel@twins> <4E8E2417.2000903@fb.com> <4E8FAB3A.2040801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52035 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750972Ab1JJSui (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 10 Oct 2011 14:50:38 -0400
In-Reply-To: <4E8FAB3A.2040801@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: avagin@gmail.com
Cc: Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, Stephane Eranian <eranian@google.com>, Frederic Weisbecker <fweisbec@gmail.com>

On 10/7/11 6:45 PM, avagin@gmail.com wrote:
>> Andrew, are you already working on user space patches?
>
> Yes, I'm working. I've attached the draft version.

Generally I'm happy with the direction of these patches. For doing wall 
time based profiling we'll need support in perf inject to merge sleep + 
cycles events.

Re: examples of why one might need histograms based on various fields in 
a dynamic kernel probe:

I might want to add a probe such as:

perf probe --add 'sys_read fd=%di'
perf probe --add 'sys_read%return bytes=$retval'

and expect to find stack traces that are responsible for most I/O calls 
based on bytes vs fd vs number of syscalls.

  -Arun
