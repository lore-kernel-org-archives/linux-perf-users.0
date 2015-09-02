From: David Ahern <dsahern@gmail.com>
Subject: Re: Understanding timestamps in perf.data
Date: Wed, 2 Sep 2015 11:00:12 -0600
Message-ID: <55E72B1C.7070108@gmail.com>
References: <55E6C120.3030504@kit.edu> <55E6FCF9.60403@gmail.com>
 <55E71351.8010507@kit.edu> <55E72762.6030209@gmail.com>
 <alpine.DEB.2.20.1509021256550.575@vincent-weaver-1.umelst.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:36236 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755631AbbIBRAN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 2 Sep 2015 13:00:13 -0400
Received: by ioii196 with SMTP id i196so27389479ioi.3
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Sep 2015 10:00:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1509021256550.575@vincent-weaver-1.umelst.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: Dennis Gnad <dennis.gnad@kit.edu>, linux-perf-users@vger.kernel.org

On 9/2/15 11:00 AM, Vince Weaver wrote:
> On Wed, 2 Sep 2015, David Ahern wrote:
>> The counter values are not relevant for profiling. They are programmed to
>> rollover and generate an NMI which causes the sample to be taken.
>
> They might not be relevant for profiling, but some people use the perf
> counters for other tasks.

Dennis was asking about profiling.
