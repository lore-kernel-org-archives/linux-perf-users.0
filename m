From: Rick Jones <rick.jones2@hp.com>
Subject: Re: Using perf to generate a call stack from a kernel function to
 the user space caller
Date: Tue, 20 Jan 2015 10:40:17 -0800
Message-ID: <54BEA111.9060504@hp.com>
References: <loom.20150120T180008-930@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from g2t1383g.austin.hp.com ([15.217.136.92]:47868 "EHLO
	g2t1383g.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbbATSkT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 20 Jan 2015 13:40:19 -0500
Received: from g2t2353.austin.hp.com (g2t2353.austin.hp.com [15.217.128.52])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g2t1383g.austin.hp.com (Postfix) with ESMTPS id 495F12A5B
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2015 18:40:19 +0000 (UTC)
In-Reply-To: <loom.20150120T180008-930@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: AKel <ankelly006@hotmail.com>, linux-perf-users@vger.kernel.org

On 01/20/2015 09:08 AM, AKel wrote:
> Hi,
>
> I'm trying to profile an application which is spending quite a bit of time
> in the kernel (~40% in do_raw_spin_lock for example). To fully understand
> what is happening I would like to generate a call stack using perf (or
> otherwise) to see where the calls to this function are originating from.
> Is this possible? My hands are slightly tied in that I don't have sudo
> access to the system I'm working on, so a solution which accounts for this
> would be greatly appreciated. Even transferring files to/from the system
> is very difficult so I'm rather restricted in what i can do.

I suspect you will have to resolve the sudo issue by getting sudo. 
Ignoring that for the time-being, it sounds like you could use the 
call-graph functionality of perf record/report/top?

rick jones
