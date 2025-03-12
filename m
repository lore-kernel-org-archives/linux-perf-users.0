Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73B3243956;
	Wed, 12 Mar 2025 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776250; cv=none; b=Lzq4IDvbjwsmfPfa4P6YE4X0Pn7lMjpWdxaV+J3KioJHl51MrQLJ1mUhxlRnO04srbRuqqH5cfRW9V2k/ucHu3CAuQ0Jx/P1CMzJqkaXdkyrg10GVLVlXY6qeZrhDXahMBKt9Gd+axbjEEW0QXSmlHmd4U9D127lEM3uTC+yNjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776250; c=relaxed/simple;
	bh=6Dkt5/w7zBMDrhoHG67V8PcHxk6Y3k5mfkUJzlw5VoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPowUR5JP0ygmrQRj9klwbgYG434RZsTiRwkEO0XnxHQmuV7FXthIUfZPad1QcS9u94etnwfyf0wRx2GGz0DSuadM76jRSosofbPXdHa9fKv0iKeHLCBN5CsKkQpVdhbft4UYgxXufWBMMAA0kK51Q10TUdQR9Jl2JNnODyWk64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=scQeckOr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="scQeckOr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=qR4Hm7WDZNeUufbu+QjLgwRPhKliBqhVccVeF6ofnsQ=; b=scQeckOrG+UkeHEF+ATM6U0yUY
	WsuAVF3H1/pUTbvc/551syNu4FQS6LX9cV0YQYuydwQP/gCC4Asx4n+fRhfAJCIV/RGfGij3hLW78
	fAzdZAaEDL7VKrpYjpJ+egVx65rkYNJNmXcgAe30eiPlzIxWSGI6H/wET1TxWi5PVnpIzjwLgjm+i
	tYc+enZvjvTS4COA1CcMkENs3jvaIVqFGPiijEcE0GHaEhDOlLffrHla4cuMsvsoGlu1SuwaT4loK
	PqHGj/zYqsJVVgEL+QLKLIQZuz0dJsSn8ayQ6CIdhjLcZfdv/YisKw3HgW4HeKY4wpvtTpr+ZSY1Y
	I/dHv+lg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsJZB-0000000Cj9G-2buh;
	Wed, 12 Mar 2025 10:44:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 38866300599; Wed, 12 Mar 2025 11:44:01 +0100 (CET)
Date: Wed, 12 Mar 2025 11:44:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mark.barnett@arm.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, ben.gainey@arm.com, deepak.surti@arm.com,
	ak@linux.intel.com, will@kernel.org, james.clark@arm.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/5] perf: Allow adding fixed random jitter to the
 alternate sampling period
Message-ID: <20250312104401.GC9968@noisy.programming.kicks-ass.net>
References: <20250307202247.648633-1-mark.barnett@arm.com>
 <20250307202247.648633-4-mark.barnett@arm.com>
 <20250311113128.GD19424@noisy.programming.kicks-ass.net>
 <20250311113530.GA9968@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250311113530.GA9968@noisy.programming.kicks-ass.net>

On Tue, Mar 11, 2025 at 12:35:30PM +0100, Peter Zijlstra wrote:
> On Tue, Mar 11, 2025 at 12:31:29PM +0100, Peter Zijlstra wrote:
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index b87a5ac42ce2..e5a93edf3b5f 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -8,6 +8,7 @@
> >   *  Copyright  ©  2009 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
> >   */
> >  
> > +#include "linux/random.h"
> >  #include <linux/fs.h>
> >  #include <linux/mm.h>
> >  #include <linux/cpu.h>
> 
> Argh, this is neovim trying to be 'helpful'. If anybody reading this
> knows how to make it stop adding headers, please let me know, its
> driving me nuts.

Adding this cmd thing to the lspconfig like so:

require 'lspconfig'.clangd.setup() {
	cmd = {
		"clangd",
		"--header-insertion=never",
	},
}

seems to do the trick.
