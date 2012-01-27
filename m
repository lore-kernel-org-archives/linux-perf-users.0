From: Andrew Steets <asteets@rgmadvisors.com>
Subject: Re: perf: prctl(PR_TASK_PERF_EVENTS_DISABLE) has no effect
Date: Fri, 27 Jan 2012 14:06:48 -0600
Message-ID: <4F2303D8.80300@rgmadvisors.com>
References: <4F22D8D9.3010108@rgmadvisors.com> <1327684363.2446.176.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:36753 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752034Ab2A0UG5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 Jan 2012 15:06:57 -0500
Received: by mail-yx0-f176.google.com with SMTP id l9so1098064yen.21
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jan 2012 12:06:50 -0800 (PST)
In-Reply-To: <1327684363.2446.176.camel@twins>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>

On 1/27/12 11:12 AM, Peter Zijlstra wrote:
> On Fri, 2012-01-27 at 11:03 -0600, Andrew Steets wrote:
>> Can anyone tell
>> me if I'm using this wrong or if this is a bug?
>
> You're using it wrong, it will disable events you own (created) not
> events that monitor you.

Is there an alternate way of disabling events that monitor the current
process?  I ask because I came across the following description in
tools/perf/design.txt:

     A process can enable or disable all the counter groups that are
     attached to it, using prctl:

         prctl(PR_TASK_PERF_EVENTS_ENABLE);

         prctl(PR_TASK_PERF_EVENTS_DISABLE);

     This applies to all counters on the current process, whether created
     by this process or by another, and doesn't affect any counters that
     this process has created on other processes.  It only enables or
     disables the group leaders, not any other members in the groups.

-Andrew

-- 

---------------------------------------------------------------
This email, along with any attachments, is confidential. If you 
believe you received this message in error, please contact the 
sender immediately and delete all copies of the message.  
Thank you.
