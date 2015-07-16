From: =?UTF-8?B?TWFydGluIExpxaFrYQ==?= <mliska@suse.cz>
Subject: Re: perf annotate with sample counts
Date: Thu, 16 Jul 2015 10:00:18 +0200
Message-ID: <55A76492.8030203@suse.cz>
References: <55A70107.3030106@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44973 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752751AbbGPIAU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 16 Jul 2015 04:00:20 -0400
In-Reply-To: <55A70107.3030106@us.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Paul Clarke <pc@us.ibm.com>, linux-perf-users@vger.kernel.org

On 07/16/2015 02:55 AM, Paul Clarke wrote:
> Is there a way to get perf annotate to display sample counts instead of, or in addition to, percentages?
> 
> The percentages seem relative to the function, which isn't as helpful in a global context.
> 
> Regards,
> PC

Hello Paul.

I think you are exactly looking for: https://lkml.org/lkml/2015/6/19/742, which
I implemented couple of weeks ago :)

Martin

> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
