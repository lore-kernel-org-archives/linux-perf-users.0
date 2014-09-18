From: Milian Wolff <mail@milianw.de>
Subject: Re: Perf event for Wall-time based sampling?
Date: Thu, 18 Sep 2014 15:41:20 +0200
Message-ID: <5166825.efsYl6z7uN@milian-kdab2>
References: <2221771.b2oSN5LR6X@milian-kdab2> <20140918132350.GE2770@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:49689 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136AbaIRNlW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 18 Sep 2014 09:41:22 -0400
In-Reply-To: <20140918132350.GE2770@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

On Thursday 18 September 2014 10:23:50 Arnaldo Carvalho de Melo wrote:
> Em Thu, Sep 18, 2014 at 02:32:10PM +0200, Milian Wolff escreveu:
> > Hello,
> > 
> > is it somehow possible to use perf based on some kernel timer? I'd like to
> > get
> Try with tracepoints or with probe points combined with callchains
> instead of using a hardware counter.

Hey Arnoldo,

where would you add such tracepoints? Or what tracepoint would you use? And 
what is the difference between tracepoints and probe points (I'm only aware of 
`perf probe`).

Bye
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
