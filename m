From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2] perf script/python: add new compaction-times script
Date: Fri, 21 Aug 2015 20:05:46 +0200
Message-ID: <55D7687A.2050202@suse.cz>
References: <55C9BCC1.4030202@suse.cz> <1439840932-8933-1-git-send-email-tonyj@suse.com> <55D59EE4.7040705@suse.cz> <20150820194242.GD3154@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40089 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344AbbHUSFs (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 21 Aug 2015 14:05:48 -0400
In-Reply-To: <20150820194242.GD3154@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Tony Jones <tonyj@suse.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mel Gorman <mgorman@suse.com>

On 20.8.2015 21:42, Arnaldo Carvalho de Melo wrote:
> Em Thu, Aug 20, 2015 at 11:33:24AM +0200, Vlastimil Babka escreveu:
>> On 08/17/2015 09:48 PM, Tony Jones wrote:
>>
>> Works for me, thanks. I'll leave it to perf experts to judge if the options
>> and output formatting matches what's common for perf scripts.
> 
> Well, we don't have any firm set standard for outputting from scripts,
> so if you did it inspired by existing scripts outputs, probably that is
> good enough, having someone testing it is a plus, and in these cases, if
> the "works for me" means you actually tested it, can we replace the
> "Acked-by" with a "Tested-by"?

Yeah you can change to Tested-by. Thanks.

> Ingo, others, comments on formatting?
> 
> - Arnaldo
> 
