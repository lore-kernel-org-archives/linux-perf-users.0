From: Kumar Ranjit-B04060 <B04060@freescale.com>
Subject: RE: perf trace
Date: Mon, 18 Apr 2011 06:38:15 +0000
Message-ID: <8CB5FB7FBAFD274A8E92A53BBAFE339D0BB2AC@039-SN1MPN1-003.039d.mgd.msft.net>
References: <AANLkTi=pRKpdupEcXS0FmOA-PiAiXHWPYwWxN4F27fFC@mail.gmail.com>
 <AANLkTikXKDiyf7Q=mY_ez2P3OSw23VaRMdKcF_M-KCc0@mail.gmail.com>
 <AANLkTi=VrazJpV+dpzX2hWJ8dYDgbdo_5FAOMRYRo0GD@mail.gmail.com>
 <AANLkTi=A5hkUE0xna5zmuXGt=LvMS_C41whzwM0-nUNs@mail.gmail.com>
 <4D8DE695.3000606@gmail.com>
 <AANLkTiktVqjaaNRm7EaCTJMsYsQnKUWrekDqF4r7YW7=@mail.gmail.com>
 <4D8DF6E4.1070804@gmail.com>
 <AANLkTik4RrEh8wgj+TXB1DYZtfn1Wp3iMiZs-XZBrsRG@mail.gmail.com>
 <4D8EB605.7070407@gmail.com>
 <AANLkTi=JefJqiUdvZ+r+sS25+bbDG_c6M8825xKpSUnu@mail.gmail.com>
 <4D8FA787.7020308@gmail.com>
 <AANLkTinvS527WGa7+tYo7pqgZj1dSviY0HrLo=2XGqT-@mail.gmail.com>
 <loom.20110329T185259-431@post.gmane.org> <4D923B8D.1020204@gmail.com>
 <8CB5FB7FBAFD274A8E92A53BBAFE339D0BB25C@039-SN1MPN1-003.039d.mgd.msft.net>,<4DABD54B.5090509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:16046
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752288Ab1DRGiS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 18 Apr 2011 02:38:18 -0400
In-Reply-To: <4DABD54B.5090509@gmail.com>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

It is supported by perf for H/W counter as i can use perf stat for various H/W events. I want to see actual instruction flow for a particular application. Like we have Kernel Function Trace for the kernel.
Regards
Ranjit

________________________________________
From: linux-perf-users-owner@vger.kernel.org [linux-perf-users-owner@vger.kernel.org] on behalf of David Ahern [dsahern@gmail.com]
Sent: Monday, April 18, 2011 11:38 AM
To: Kumar Ranjit-B04060
Cc: linux-perf-users@vger.kernel.org; baozhao
Subject: Re: perf trace

On 04/17/11 21:43, Kumar Ranjit-B04060 wrote:
> Hi David
> I need to generate instruction trace for Freescale e500mc core. Please tell me whether I can use perf for that.
> If yes then please tell me some steps to do that.
> Regards
> Ranjit

I have no idea if that processor is supported by perf for H/W counters.

What do you mean by "instruction trace"?

David
