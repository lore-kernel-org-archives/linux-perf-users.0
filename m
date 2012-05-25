From: Vince Weaver <vweaver1@eecs.utk.edu>
Subject: Re: perf event "instructions"
Date: Thu, 24 May 2012 23:07:05 -0400
Message-ID: <alpine.DEB.2.00.1205242304100.7065@cl320.icl.utk.edu>
References: <loom.20120525T044121-415@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:24736
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753370Ab2EYDH1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 24 May 2012 23:07:27 -0400
In-Reply-To: <loom.20120525T044121-415@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Hank <hankendi@bu.edu>
Cc: linux-perf-users@vger.kernel.org

On Thu, 24 May 2012, Hank wrote:

> I've collected number of instructions using predefined event named
> "instructions" and also collected using the raw event (register and unit mask)
> for instructions retired. Although they are similar, outputs are not the exactly
> the same. 
> 
> Can anyone explain me what is the built-in event "instructions" measuring? If it
> is the number of retired instructions, then what might be the reason for getting
> different output when I use the raw event number?

what processor are you running on?  What raw event are you using?
what version of Linux?

Are you specifying things like user-only?

There's enough variation in retired instruction counts that entire papers 
have been written on it.
   
http://web.eecs.utk.edu/~vweaver1/projects/deterministic/fhpm2010_weaver.pdf

Vince
