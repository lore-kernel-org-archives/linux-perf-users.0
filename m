Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD23A18F2D9;
	Wed,  3 Jul 2024 23:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047905; cv=none; b=RSwSVnW2napwEpSFK+jcKXrFsELBTYbQkg9IOsUWb7liggbov3R0//6V15ZdrGjSMklSg+c55MV0kRa+9rG4pNIwpz/lIuEsVCBvtmhvGLRQd9CPqjrSH43Fu3JtdZNDQ0Rb7A8n8L5ox5U4d1Wp3GclN2HLHqTsFB8U9Fz7mfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047905; c=relaxed/simple;
	bh=KXRKYuYC80pP6Iwb+lH8BOjipEd96XsVJjSlMbkv8FE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0yhStPf3zgDsUjnTmomDnNsdwjRLcCrBadR3Po1T7m6+7/YpAtcuI1w7UopjHDi2441InULN1C+RrKpwCFQWJVjXhYc4HYa9j0+zk4HnNr6Qt1y7ZapZYLGyJgIwpPOqvy2S07ysaJWOMJxU1grY/UFq49oF0DluAc57SQlkTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F267C2BD10;
	Wed,  3 Jul 2024 23:05:04 +0000 (UTC)
Date: Wed, 3 Jul 2024 19:05:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Guilherme Amadio <amadio@gentoo.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Ian Rogers <irogers@google.com>, Thorsten Leemhuis
 <linux@leemhuis.info>, Leo Yan <leo.yan@arm.com>,
 linux-perf-users@vger.kernel.org, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] tools: Make pkg-config dependency checks usable
 by other tools
Message-ID: <20240703190502.392be247@rorschach.local.home>
In-Reply-To: <ZoXDoajJqDiIcgwg@google.com>
References: <20240628202608.3273329-1-amadio@gentoo.org>
	<20240628203432.3273625-1-amadio@gentoo.org>
	<20240628203432.3273625-3-amadio@gentoo.org>
	<ZoSP_vFMVl83pxES@google.com>
	<20240703153617.650fcc1c@rorschach.local.home>
	<ZoXDoajJqDiIcgwg@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 14:33:21 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> On Wed, Jul 03, 2024 at 03:36:17PM -0400, Steven Rostedt wrote:
> > On Tue, 2 Jul 2024 16:40:46 -0700
> > Namhyung Kim <namhyung@kernel.org> wrote:
> >   
> > > +CC Steve and linux-trace-kernel list.  
> > 
> > There doesn't seem to be a cover page, and it doesn't apply on
> > v6.10-rc6 nor on tip.  
> 
> Oh, sorry.  You can find the whole series here.
> 
> https://lore.kernel.org/linux-perf-users/20240628203432.3273625-1-amadio@gentoo.org/#r
> 
> I think this is based on the perf-tools-next tree and depends on perf
> changes.  If you're ok with the change, I can carry it in the perf tree.
> 

Hmm, I checked out git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
master branch, and it looks to contain just Linus's changes. Is there a specific branch?

-- Steve
