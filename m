Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB3D171AA;
	Thu,  3 Oct 2024 02:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727922635; cv=none; b=KgMKFZkReiP9Yl5L+Pigu/JMhtQ3O4MbxhNxXlPbyDSL03jjBOn0pkfv+i8fghiYRbDuBBqC3jCX26omrznVUggtfj5yqCLnCTdueBItv5WnwHuxbBjMFNs+UqcDjkllEMphQiDe02kW4JW5nhzy+TLktyWzhtkzbSL6HZC2fLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727922635; c=relaxed/simple;
	bh=4ixeEG7Rx2KG4yizT1qMt1FetXs/pJHsOibTwl/KC0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dS5PV9hrkchfiFczcULTCMC5CCIGbW0SJ58McM6Vhx40aVZ6WAeT5Shci0Lt32bYQBtJZfK5A41PYQYQ9uUrJ1ngWZxVxnHozes+Q3lJYzN2CwNKfqxnTKcVylqsfbb6P0EB0TIHrxM6INZRdo9piEdfammg+C48rtKy+CenStM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EADAC4CEC2;
	Thu,  3 Oct 2024 02:30:33 +0000 (UTC)
Date: Wed, 2 Oct 2024 22:31:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, Ingo Molnar
 <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark
 Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, Jordan Rome
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 00/11] unwind, perf: sframe user space unwinding,
 deferred perf callchains
Message-ID: <20241002223125.2d610510@gandalf.local.home>
In-Reply-To: <20240916153953.7fq5fmch5uqg7tjj@treble>
References: <cover.1726268190.git.jpoimboe@kernel.org>
	<20240914081246.1e07090c@rorschach.local.home>
	<20240915111111.taq3sb5xzqamhb7f@treble>
	<20240916140856.GB4723@noisy.programming.kicks-ass.net>
	<20240916153953.7fq5fmch5uqg7tjj@treble>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Sep 2024 17:39:53 +0200
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> Completely untested patch here that I hacked up today:

I can tell it wasn't tested ;-)

> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git sframe-2.1
> 
> To avoid races, unwind_user_deferred() can't be called from NMI.  The
> tracers will need to trigger irq_work to call it.

diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 7edb0833fe46..c56cf5d564df 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -177,7 +181,8 @@ int unwind_user_deferred(struct unwind_callback *callback, u64 *ctx_cookie)
 
 		cookie = __this_cpu_read(ctx_ctr);
 		cookie &= ((1UL << 48) - 1);
-		cookie |= ((cpu << 48) + 1);
+		cookie |= cpu << 48;
+		cookie++;
 		__this_cpu_write(ctx_ctr, cookie);
 
 		current->unwind_ctx_cookie = cookie;

As the cookie never got incremented.

That was just one issue. Things are still not working but I'll debug the
rest later.

-- Steve
