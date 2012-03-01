From: David Ahern <dsahern@gmail.com>
Subject: Re: Sampling instruction pointer on PPC
Date: Thu, 01 Mar 2012 11:00:11 -0700
Message-ID: <4F4FB92B.9080106@gmail.com>
References: <4F4FACFA.6080209@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51391 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543Ab2CASAQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 1 Mar 2012 13:00:16 -0500
Received: by pbcup15 with SMTP id up15so1149729pbc.19
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Mar 2012 10:00:16 -0800 (PST)
In-Reply-To: <4F4FACFA.6080209@bsc.es>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Victor Jimenez <victor.javier@bsc.es>, linuxppc-dev@lists.ozlabs.org
Cc: linux-perf-users@vger.kernel.org

[Added linuxppc-dev list.]

On 3/1/12 10:08 AM, Victor Jimenez wrote:
> I am trying to sample instruction pointer along time on a Power7 system.
> I know that there are accurate mechanisms to do so in Intel processors
> (e.g., PEBS and Branch Trace Store).
>
> Is it possible to do something similar in Power7? Will the samples be
> accurate? I am worried that significant delays (skids) may appear.
>
> Thank you,
> Victor
>
> WARNING / LEGAL TEXT: This message is intended only for the use of the
> individual or entity to which it is addressed and may contain
> information which is privileged, confidential, proprietary, or exempt
> from disclosure under applicable law. If you are not the intended
> recipient or the person responsible for delivering the message to the
> intended recipient, you are strictly prohibited from disclosing,
> distributing, copying, or in any way using this message. If you have
> received this communication in error, please notify the sender and
> destroy and delete any copies you may have received.
>
> http://www.bsc.es/disclaimer.htm
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
