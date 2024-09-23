Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9581C19E960;
	Mon, 23 Sep 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105259; cv=none; b=pqROzDKAnCdKzQ3vskH+jvpUBkEqjOr4qoX3pCj611+00SPRxQraqt+w1PF1sc6rx9V3tMS3e3n7h1Y0DlUsBcuAG3O8Z3RWFRVMLeykLxbhe8jJzK6xIzJja+Sxu/HiFZ8ka9Eilx10f/jk/zkMFFS0g709ycoInzDPGIRgNc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105259; c=relaxed/simple;
	bh=Ek1ZmQnBQ5N9V04hAuJzOEr/8GHtw4NHtXcqrcsuFFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZCqpP6+0BDIFahTJcMkavou2R5GO3BkB2Zsl25RTWrC1pGUjrvQt1UGWvMxJuVvnF2WJOs+9zke54fLDw0XQ2a3zfbyUkOyWvcxoU/rZG7qcfWKysYmb7sVcuYGSnAR/fU1vDpKgJLnWmvXg9e0NiYi0C+DCY7PFGhxN8KrEAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHYMMide; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHYMMide"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328E0C4CEC4;
	Mon, 23 Sep 2024 15:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727105259;
	bh=Ek1ZmQnBQ5N9V04hAuJzOEr/8GHtw4NHtXcqrcsuFFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MHYMMideba++EXWNS2eY8EqO8DugaStgRBu2BtD58g8+HsfEiBMxEtvDz+TkJgTNe
	 wGo/C0ctCq4Mzp+9TI7vVxnesmzxV2sDUGf3qPjSLtHH4V1XA4AyB8ofVeAcIh9hMQ
	 LuewuAATNa4CiuffS6bjHIzTqFE2lGo2eUm+kEh5QuQSdUAKMMhtRd0lqNLldwjJtG
	 yKgcFiV7Tgd4fO82f8FgtVvybAcQ3u9wEg4G2vi7463MVzndZUjR28fJrJaZOfRNlL
	 nKIwUBTZBhyPVVL96zPPPEn7W+vGtgthysnN7FSHnW+tjhBivHJ51ImUmHgMnxSqN4
	 RCmwc3qlOgDqQ==
Date: Mon, 23 Sep 2024 17:27:34 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [GIT PULL] Performance events changes for v6.12
Message-ID: <ZvGI5lcRAOnp2rTW@gmail.com>
References: <ZurLc9qEjBH9MkvK@gmail.com>
 <20240919082624.05ca5fd6@canb.auug.org.au>
 <Zuv0kA-um9ZT-Tjd@gmail.com>
 <CAHk-=wiz_57SsfaX1JkmDJ2sMo9Pfiq27XciQeh7GE3tDBVDFg@mail.gmail.com>
 <CAHk-=wjjrLPDVMu2Bj+01XmZF=puP0nKXbLzC40fe_enGDdcBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjjrLPDVMu2Bj+01XmZF=puP0nKXbLzC40fe_enGDdcBg@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 21 Sept 2024 at 15:39, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, 19 Sept 2024 at 02:53, Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > > Thanks: I've queued up the fix for this ARM warning in perf/urgent 
> > > and will get it to Linus later today.
> >
> > So this apparently never happened.

Sorry about that, was sick for a few days.

> > I'm back home now, and so I now do my arm64 builds too, and it is 
> > indeed failing.
> 
> In case people didn't notice - in order to now do my now usual full 
> builds I just took the fix directly (commit 673a5009cf2f: "perf: Fix 
> topology_sibling_cpumask check warning on ARM").

Looks good, thank you!

	Ingo
