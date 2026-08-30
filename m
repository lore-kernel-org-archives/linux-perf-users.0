Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20C525785D;
	Sun, 30 Aug 2026 05:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788068136; cv=none; b=tuWR/0b2WcrTana9Da9azI5ZLW7NIK3MZsioNsPVKNBvaKgLybAB1JLy7R+FYKU4lhauxicfNYCjG/qhjHzJ1rymoy2Wdm9j+Ksm1mg3CM3Sz5t4D5Ofui7749f6JtYb4HemM1voW9Xg2IbZnRcuU/9I9Jh2xkccnEBjquIgOac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788068136; c=relaxed/simple;
	bh=/i4Z8T/TgB/FhDqtss/dodjVlxUzMbJKhrJRyWLlSK0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pMKGbgONu6Dxzxeudc5PER7jx29eRzKzTQEhVtLr9dXpr6ZEr/fPX9QR16gZ58XHokV7Am4Wr2DW4LLFtQyexRiPDQ/v5RHaM4Qt2+MZNkpE6I027vUSsZip5E8OvAT2YnJeBCN5xL8AP2VVnSsaVGCYNALCrUA9MxKJfMY8iCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IT8b5JEs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IT8b5JEs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F811F000E9;
	Sun, 30 Aug 2026 05:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788068135;
	bh=opuSRRSkcfB5nG0C2M32ilPlbfasle6ZOQ7l0sbm1Hs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IT8b5JEs3vPQgc9+FC4xSxa2TcSNbHb/W65FxlFtEJ8qrhLcGn+34xB5/uyQaK/lj
	 5F+RPPM/voYAwn7WLGqu5ikLpo5YWvnCvb3ohqWVtQAP3HYVGoaCgGGcP2IpMU3RTQ
	 WdDJgyDfISdjqX+7Y5FCPbAk450VAH9LXMXIbsEuD4c3Qyq7G+gcztW6xXQzao350L
	 4T9XOaSUQni0BijVn/1MCLmRLAINzdvQvRmQMr1AtEdbb2Xqa/nR6MzUHODpvk4OaN
	 qtTVqZcDX5bkAtAjRiNHw0aZGgbSlGv1v0t+uz8TtCM0VfflDjSPdF41hsG4SXGupr
	 u8VXxF5vv+fCw==
Date: Sun, 30 Aug 2026 14:35:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v13 07/12] selftests: tracing: Add a basic testcase for
 wprobe
Message-Id: <20260830143532.0c2aee25c656896388e6bab7@kernel.org>
In-Reply-To: <20260822093638.8E6971F000E9@smtp.kernel.org>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
	<178739066970.1520941.12929870364050962005.stgit@devnote2>
	<20260822093638.8E6971F000E9@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 09:36:38 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Unreachable error handling logic due to early exit under 'set -e'.
> --
> 
> --- Patch [7]: [PATCH v13 07/12] selftests: tracing: Add a basic testcase for wprobe ---
> commit 6d72a05750c5dfc08de6b03a6fc65e5144b20b9f
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> selftests: tracing: Add a basic testcase for wprobe
> 
> Add an add_remove_wprobe.tc testcase for testing wprobe events that
> tests adding and removing operations.
> 
> > diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
> > new file mode 100644
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
> > @@ -0,0 +1,63 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: Generic dynamic event - add/remove wprobe events
> > +# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README
> > +
> > +echo 0 > events/enable
> > +echo > dynamic_events
> > +
> > +# Use jiffies as a variable that is frequently written to.
> > +TARGET=jiffies
> > +
> > +echo "w:my_wprobe w@$TARGET" >> dynamic_events
> > +
> > +if ! grep -q my_wprobe dynamic_events; then
> > +    echo "Failed to create wprobe event"
> > +    exit_fail
> > +fi
> 
> [Severity: Medium]
> Since the ftracetest framework runs these scripts with set -e (errexit) 
> enabled, will this script exit immediately if the kernel rejects the event 
> creation and the echo command fails?
> 
> If so, the subsequent diagnostic grep check and exit_fail call wouldn't be
> reached, leading to a silent failure without the intended error message.

This is expected, the later grep checks whether if creation command succeeded
but the event is not shown in the dynamic_events. Different check.

> > +
> > +if [ ! -d events/wprobes/my_wprobe ]; then
> > +    echo "Failed to create wprobe event directory"
> > +    exit_fail
> > +fi
> > +
> > +echo 1 > events/wprobes/my_wprobe/enable
> > +
> > +# Check if the event is enabled
> > +if ! grep -q 1 events/wprobes/my_wprobe/enable; then
> > +    echo "Failed to enable wprobe event"
> > +    exit_fail
> > +fi
> 
> [Severity: Medium]
> Similarly, if enabling the wprobe fails at the sysfs boundary, would this
> echo cause an early exit and bypass the diagnostic error message here as well?

Also, this is a kind of double check. Even if writing 1 to enable
succeeded, it is failed to set internal flag. This checks such problem.

> 
> [ ... ]
> 
> > +echo "-:my_wprobe" >> dynamic_events
> > +
> > +if grep -q my_wprobe dynamic_events; then
> > +    echo "Failed to remove wprobe event"
> > +    exit_fail
> > +fi
> 
> [Severity: Medium]
> Could this echo also trigger an early exit if removing the wprobe fails,
> bypassing the failure message?

Ditto.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
