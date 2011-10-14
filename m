From: Arun Sharma <asharma@fb.com>
Subject: Re: Profiling sleep times?
Date: Fri, 14 Oct 2011 14:19:26 -0700
Message-ID: <4E98A75E.3010000@fb.com>
References: <4E8A0F53.7020408@fb.com> <1317673027.20367.41.camel@twins> <4E8A2EC5.1030901@fb.com> <1317717291.25926.13.camel@twins> <4E8E2417.2000903@fb.com> <4E8FAB3A.2040801@gmail.com> <4E933E65.1090207@fb.com> <20111012074113.GK18618@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54771 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932362Ab1JNVUO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 14 Oct 2011 17:20:14 -0400
In-Reply-To: <20111012074113.GK18618@elte.hu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: avagin@gmail.com, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, acme@ghostprotocols.net, Stephane Eranian <eranian@google.com>, Frederic Weisbecker <fweisbec@gmail.com>

On 10/12/11 12:41 AM, Ingo Molnar wrote:
>> Generally I'm happy with the direction of these patches. [...]
>
> Ok, will someone please send an updated series of all missing
> patches, with all acks included, for potential v3.2 pickup?
>
> Sleep time profiling is obviously a very hot feature ...
>

I acked two of Andrew's patches. The third one is the most important 
one. I haven't had a chance to review that carefully yet - although it's 
working well for me.

We still need to figure out what's the best way to munge all this data 
in user space to implement wall clock profiling.

  -Arun
