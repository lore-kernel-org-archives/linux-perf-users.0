From: Tony Jones <tonyj@suse.de>
Subject: Re: restricting counted/sampled events
Date: Thu, 12 Nov 2015 16:05:49 -0800
Message-ID: <5645295D.2020906@suse.de>
References: <5644D7DA.7050200@suse.de> <20151112230807.GF7160@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49444 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932420AbbKMANg (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Nov 2015 19:13:36 -0500
In-Reply-To: <20151112230807.GF7160@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>

On 11/12/2015 03:08 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 12, 2015 at 10:18:02AM -0800, Tony Jones escreveu:
> 
>> I don't believe there is current support to do this,  but maybe I'm
>> overlooking something?
>  
>> I'd like to be able to restrict the pmu (or filter results) to report
>> counting/sampling between two arbitrary code points,  such as a
>> tracepoint or kprobe.
>  
>> I believe it will require core perf changes and was curious on peoples
>> thoughts?
> 
> Something like this:
> 
> https://lkml.org/lkml/2013/9/25/227

Yes, I'd not found that in my searching.   Thanks for the ptr.
