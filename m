From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH] perf trace: add total time column to summary.
Date: Thu, 06 Aug 2015 11:53:42 +0200
Message-ID: <1825374.qTnqrC8ilh@milian-kdab2>
References: <1438853069-5902-1-git-send-email-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:60652 "EHLO mail.kdab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142AbbHFJxo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 6 Aug 2015 05:53:44 -0400
In-Reply-To: <1438853069-5902-1-git-send-email-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org

Hey Arnaldo,

On Thursday 06 August 2015 11:24:29 Milian Wolff wrote:
<snip>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>

I hope this patch is OK. I have some more questions:

a) Should I always send to linux-kernel and CC linux-perf-users, or is it OK 
to send it only to linux-perf-users? 

b) Should I put you explicitly into the CC, I recon you also read the mailing 
lists?

c) Should I add more people to the CC list? The get_maintainer script also 
lists Ingo Molnar and Peter Zijlstra, but your recent patch set has them not 
in the CC list.

d) My patch has some warnings according to checkpatch, because some lines are 
too long. Is this very frowned upon in the Kernel? It would make the table 
much harder to read when I split it onto multiple lines, but of course I can 
amend that if you want it.

If I messed up anything else, please tell me.

Thanks
-- 
Milian Wolff | milian.wolff@kdab.com | Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
