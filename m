From: Kumar Ranjit-B04060 <B04060@freescale.com>
Subject: RE: perf trace
Date: Mon, 18 Apr 2011 17:46:35 +0000
Message-ID: <8CB5FB7FBAFD274A8E92A53BBAFE339D0BB323@039-SN1MPN1-003.039d.mgd.msft.net>
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
 <8CB5FB7FBAFD274A8E92A53BBAFE339D0BB2AC@039-SN1MPN1-003.039d.mgd.msft.net>
 <4DABDEAF.7040207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:11361
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754795Ab1DRRqj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 18 Apr 2011 13:46:39 -0400
In-Reply-To: <4DABDEAF.7040207@gmail.com>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

David


 > meaning periodic samples of the counter? perf-record does not generate periodic reads of H/W counters.

Just curious, How does then the profiling works? Perf report shows % no of sample point corresponding a particular event. So it must be sampling the PC periodically.
Regards
Ranjit
