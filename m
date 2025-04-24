Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0253A2820C4;
	Thu, 24 Apr 2025 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514893; cv=none; b=feRwcNpP9dFeqJhAfAStlgloyN4himNmUk660sT9Lzaj3MDqIdUFkb1tJidqDlfAR2CJs/hjA0cXq+Sm/WwDzrOnTa8yxOw2fbafL5+DYpd7XHZGbgrHLg5OguazYmWF0srvsC/aOwpF/Nc0NTTpu0Irlx3aPgKtZiVmEChYvAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514893; c=relaxed/simple;
	bh=Tl4F80LtM2eBXBI/BtGfyF1r4zeBOcVrS0s1/KdVMi0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMPPc0b5KCKUxTF2Nrtl3B9bIWPhMfLqFtxvM3Sl4W3xfcB4ZgB9e6loa03mDYCWY9D7jf1nmYpTmt/nvDmXjq24LlsNLAseAuAu58MjtNzsZc6gLKyWicojxBFEO1QCOjqTTXMfqqv1qCSfcBh66NxQWo1HWK/0tC18VDMdZzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA86C4CEE3;
	Thu, 24 Apr 2025 17:14:49 +0000 (UTC)
Date: Thu, 24 Apr 2025 13:16:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark
 Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, Jordan Rome
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Jens Remus <jremus@linux.ibm.com>, Florian
 Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, Weinan Liu
 <wnliu@google.com>, Blake Jones <blakejones@google.com>, Beau Belgrave
 <beaub@linux.microsoft.com>, "Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH v5 13/17] perf: Support deferred user callchains
Message-ID: <20250424131644.51bc747c@gandalf.local.home>
In-Reply-To: <20250424163845.GG18306@noisy.programming.kicks-ass.net>
References: <20250424162529.686762589@goodmis.org>
	<20250424162633.390748816@goodmis.org>
	<20250424163845.GG18306@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 18:38:45 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > +	guard(irqsave)();
> > +
> > +        /* callback already pending? */
> > +        pending = READ_ONCE(event->pending_unwind_callback);
> > +        if (pending)
> > +                return 1;
> > +
> > +        /* Claim the work unless an NMI just now swooped in to do so. */
> > +        if (!try_cmpxchg(&event->pending_unwind_callback, &pending, 1))
> > +                return 1;
> > +
> > +        /* The work has been claimed, now schedule it. */
> > +        ret = task_work_add(current, work, TWA_RESUME);
> > +        if (WARN_ON_ONCE(ret)) {
> > +                WRITE_ONCE(event->pending_unwind_callback, 0);
> > +                return ret;
> > +        }
> > +	return 0;
> > +}  
> 
> You have whitespace issues ...

Bah, that may have been due to cut and paste to fix up things during the
multiple rebases I did.

Thanks!

-- Steve
