From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf unwind: Use addr_location::addr instead of ip for
 entries
Date: Tue, 16 Aug 2016 12:56:54 -0300
Message-ID: <20160816155654.GN20972@kernel.org>
References: <20160816153926.11288-1-milian.wolff@kdab.com>
 <20160816154939.GA15204@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56458 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882AbcHPQVN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 16 Aug 2016 12:21:13 -0400
Content-Disposition: inline
In-Reply-To: <20160816154939.GA15204@danjae.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>, linux-perf-users@vger.kernel.org

Em Wed, Aug 17, 2016 at 12:49:39AM +0900, Namhyung Kim escreveu:
> On Tue, Aug 16, 2016 at 05:39:26PM +0200, Milian Wolff wrote:
> > This fixes the srcline translation for call chains of user space
> > applications.
> > 
> > Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, I'll get this in my perf/urgent branch,

- Arnaldo
