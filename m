From: Will Deacon <will.deacon@arm.com>
Subject: Re: Perf support for stalled-cycles-frontend and
 stalled-cycles-backend event
Date: Thu, 7 Nov 2013 17:23:50 +0000
Message-ID: <20131107172349.GJ13139@mudshark.cambridge.arm.com>
References: <CABHD4K9uYYx3ga=joDid71YUWT7o93Cg8hDSQgX=dDy156vAsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:43284 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751535Ab3KGRX7 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 7 Nov 2013 12:23:59 -0500
Content-Disposition: inline
In-Reply-To: <CABHD4K9uYYx3ga=joDid71YUWT7o93Cg8hDSQgX=dDy156vAsQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Amit Tomer <amittomer25@gmail.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Wed, Nov 06, 2013 at 01:33:23PM +0000, Amit Tomer wrote:
> We recently installed Perf tool on our platform based on Cortex A-15  cores and Linux kerenl 3.4.8.
> 
> We enabled the Hardware Performance counter(PMU) and can see below message in dmeg log .
> 
> [    2.292157] hw perfevents: enabled with ARMv7 Cortex-A15 PMU driver, 7 counters available
> 
> This message suggests there are 7 counter avaiable here.
> 
> But when we run the below command ,we find two counters named stalled-cycles-frontend and stalled-cycles-backend are not suported

Take a look at the Cortex-A15 TRM. I couldn't see anything in there which
matched my understanding of stalled-cycles-frontend or
stalled-cycles-backend, so I decided to leave them as UNSUPPORTED.

Do you have a suggestion for which event to use?

Will
