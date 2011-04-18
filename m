From: David Ahern <dsahern@gmail.com>
Subject: Re: perf trace
Date: Mon, 18 Apr 2011 00:08:11 -0600
Message-ID: <4DABD54B.5090509@gmail.com>
References: <AANLkTi=pRKpdupEcXS0FmOA-PiAiXHWPYwWxN4F27fFC@mail.gmail.com> <AANLkTikXKDiyf7Q=mY_ez2P3OSw23VaRMdKcF_M-KCc0@mail.gmail.com> <AANLkTi=VrazJpV+dpzX2hWJ8dYDgbdo_5FAOMRYRo0GD@mail.gmail.com> <AANLkTi=A5hkUE0xna5zmuXGt=LvMS_C41whzwM0-nUNs@mail.gmail.com> <4D8DE695.3000606@gmail.com> <AANLkTiktVqjaaNRm7EaCTJMsYsQnKUWrekDqF4r7YW7=@mail.gmail.com> <4D8DF6E4.1070804@gmail.com> <AANLkTik4RrEh8wgj+TXB1DYZtfn1Wp3iMiZs-XZBrsRG@mail.gmail.com> <4D8EB605.7070407@gmail.com> <AANLkTi=JefJqiUdvZ+r+sS25+bbDG_c6M8825xKpSUnu@mail.gmail.com> <4D8FA787.7020308@gmail.com> <AANLkTinvS527WGa7+tYo7pqgZj1dSviY0HrLo=2XGqT-@mail.gmail.com> <loom.20110329T185259-431@post.gmane.org> <4D923B8D.1020204@gmail.com> <8CB5FB7FBAFD274A8E92A53BBAFE339D0BB25C@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51025 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab1DRGIZ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 18 Apr 2011 02:08:25 -0400
Received: by pwi15 with SMTP id 15so2026666pwi.19
        for <linux-perf-users@vger.kernel.org>; Sun, 17 Apr 2011 23:08:24 -0700 (PDT)
In-Reply-To: <8CB5FB7FBAFD274A8E92A53BBAFE339D0BB25C@039-SN1MPN1-003.039d.mgd.msft.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Kumar Ranjit-B04060 <B04060@freescale.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, baozhao <baozhao@gmail.com>



On 04/17/11 21:43, Kumar Ranjit-B04060 wrote:
> Hi David
> I need to generate instruction trace for Freescale e500mc core. Please tell me whether I can use perf for that. 
> If yes then please tell me some steps to do that.
> Regards
> Ranjit

I have no idea if that processor is supported by perf for H/W counters.

What do you mean by "instruction trace"?

David
