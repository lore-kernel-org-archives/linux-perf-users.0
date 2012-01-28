From: Andrew Steets <asteets@rgmadvisors.com>
Subject: Re: perf: prctl(PR_TASK_PERF_EVENTS_DISABLE) has no effect
Date: Sat, 28 Jan 2012 17:48:08 -0600
Message-ID: <4F248938.5030507@rgmadvisors.com>
References: <4F22D8D9.3010108@rgmadvisors.com> <20120128120151.GA10390@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120128120151.GA10390@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
List-Id: linux-perf-users.vger.kernel.org

On 1/28/12 6:01 AM, Ingo Molnar wrote:

>> prctl(PR_TASK_PERF_EVENTS_DISABLE) doesn't appear to disable
>> perf event counters.  Here is a demonstration program:
>
> btw., what's your usecase?
>

I'm trying to profile a small section of a long-running program.  I ran
into trouble using call-graph recording and I thought this might be an
alternative way of getting what I was after.

-Andrew

-- 

---------------------------------------------------------------
This email, along with any attachments, is confidential. If you 
believe you received this message in error, please contact the 
sender immediately and delete all copies of the message.  
Thank you.
