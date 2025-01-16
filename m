Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7271D22DC43;
	Thu, 16 Jan 2025 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055815; cv=none; b=O9+ebbM7B++Tggnhwvjp0lA0htPMaSuh3ETJVG4H7qlc42o5K4kBUYblFu+CmUwLMvbHJ7Ec6CmRV2ZLr1X0dL3PpxfNZCud5ZUEMsgvj6Dz+AGK7Cf52Y3szlnjf26qPbeSLBBc+YOYn/CKs5sbGm6XG63ohYx51c773HX9jDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055815; c=relaxed/simple;
	bh=B9Ib45mpJK9EOYzGiGJeNYhXnxeHIvxE59jtq3JsKS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FRqz69YFhZZCrM7LhB1xyymmdYJBMIaeE532jrGwa/tYCY6CVAtpTh+TlRh9Ux+WxBHPATFV/wYBk8n5Vu9SaluYJwrvD6m4EIvalByJ8LrmjXibeJhFpJSjceBxm+xPbISfGM80RTMesEXUS3viZ9McOjg4WinCMatbd87rI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A0BC4CED6;
	Thu, 16 Jan 2025 19:30:13 +0000 (UTC)
Date: Thu, 16 Jan 2025 14:30:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Michael Petlan <mpetlan@redhat.com>, Veronika
 Molnarova <vmolnaro@redhat.com>, Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] tracing: gfp: Fix the GFP enum values shown for user
 space tracing tools
Message-ID: <20250116143018.0b156e42@gandalf.local.home>
In-Reply-To: <CAHk-=wg_2zXOKH2kDAnAyvC6MDWWgyuMRqQDNTGzKJBhfVzHVQ@mail.gmail.com>
References: <20250116132359.1f20cdec@gandalf.local.home>
	<CAHk-=wiFEeyY5HE3NMvDYd254yHynzaQyzwYhv5gzRj7KU+gjA@mail.gmail.com>
	<20250116141800.31d519eb@gandalf.local.home>
	<CAHk-=wg_2zXOKH2kDAnAyvC6MDWWgyuMRqQDNTGzKJBhfVzHVQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 11:19:20 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 16 Jan 2025 at 11:17, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > But they are only defines, they are not created until used. Are you worried
> > that it will slow down the compile?  
> 
> Yes, and the whole "pointless noise" thing.
> 
> I *look* at header files sometimes. I don't want to see pointless
> noise that isn't relevant to the context.
> 
> This is not relevant to non-tracing users.

Would it at least be OK to add a comment there to update the tracing code
if a new GFP flag is added?

/*
 * If a new GFP flag is added, a new TRACE_DEFINE_ENUM needs to be added
 * in path/to/where/define/is/made.h
 */


?

-- Steve
