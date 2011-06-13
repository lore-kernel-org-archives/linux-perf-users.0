From: Arun Sharma <asharma@fb.com>
Subject: Re: [BUG] perf report core dump
Date: Mon, 13 Jun 2011 13:16:59 -0700
Message-ID: <4DF6703B.1040006@fb.com>
References: <4DF2A5AA.90409@fb.com> <BANLkTi=7uznMtmTFyu_UXgdV=WvS-eXq3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from outmail019.snc4.facebook.com ([66.220.144.151]:37808 "EHLO
	mx-out.facebook.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750941Ab1FMUQR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Jun 2011 16:16:17 -0400
In-Reply-To: <BANLkTi=7uznMtmTFyu_UXgdV=WvS-eXq3g@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Sam Liao <phyomh@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 6/11/11 9:24 AM, Sam Liao wrote:

> I noticed similar error, but It seems it leads by the "-s pid" option
> instead added "caller/callee" specifier. Remove this patch, symptom
> also showed up.

Yes - the bug doesn't seem to be caused by your patch, but it affects 
the primary use case with  -g graph,0.5,caller --sort pid.

builtin-report.c:

         /*
          * Only in the newt browser we are doing integrated annotation,
          * so we don't allocated the extra space needed because the stdio
          * code will not use it.
          */
         if (al->sym != NULL && use_browser > 0) {

makes it clear why it hits the --tui case, but not --stdio. I'll 
probably just disable this code path for now, until there is a better 
solution.

  -Arun
