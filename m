Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8902E285C;
	Sun, 30 Aug 2026 05:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788068175; cv=none; b=tZ4xM/WEwNkZ2r95/gL3uad5OnFnXCClFquLl4TeyiDVxF6eZpLmwMjy7Fw0+OuL2ZssuPkLevKvOXrCU0+spJ/eaUHG+hvbBGrn1yENwBVj8D3MCakRx/UgBtp2X846hHLQmC1rPMm2TGtbrdnr1Uuly8x41mFt0q0r2JAFbRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788068175; c=relaxed/simple;
	bh=aVN373zFP2TryjM++K+UXqkmiktR4Feeq0nORoRsZcs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hlWXjyl4aQRdT5f9A3WsPm3PnV7TiJCJhAofbLN1SXVvKLnhBX8ZQOZDLlfQ5jBmB4PoH/v7pw95ww5LjTIwJcaGTiyqjp5CNWwlGX+a93AAhly/7mN6lFQkUnhxfU+vZ4HEBVdHIhlT+UrpfZ3HT/S8KM4C7FeS5VDFkOe1R3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ib5KkRCc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ib5KkRCc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816511F00A3D;
	Sun, 30 Aug 2026 05:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788068173;
	bh=aoXT84wu3b3M6cKIVAxNtWRGNfd+0EUmOjRbcPR1aMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ib5KkRCcBaqbEJv/LZYbQ/c9JF91mXR3LOXP/VgV2lreP6KvoJ4oaTOad6FUa/hz3
	 RLBthlChAJxi/6qvJR/HjkXTU6us6DOAcjf0PYYRIb3jc4ET6iem5bHbGhNCa8gW/l
	 ACMXboyo2+MIX4IIJR90h885Vp9D6vT+RS1WPw38CJ7EglCHssyfyNIkuB8vNJ9Td0
	 CfdV3RpnzJ6KMGNN2MRPL69yb5bbhemXHC03CKdO/okvkMDXfrL/h0fs+UcVgtafFb
	 OdJj8BZELRZaR9KPDd7w+hntcDWPzV7omkgpH+/dca0NdsNjljZESkC/Wu75x/2Zd7
	 OBBuZVVl+VbNw==
Date: Sun, 30 Aug 2026 14:36:09 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v13 10/12] selftests: ftrace: Add wprobe trigger
 testcase
Message-Id: <20260830143609.3668b929ee0dd7437cf0517d@kernel.org>
In-Reply-To: <20260822093925.BA8481F000E9@smtp.kernel.org>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
	<178739070441.1520941.13438898193952389821.stgit@devnote2>
	<20260822093925.BA8481F000E9@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 22 Aug 2026 09:39:24 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The `trigger-wprobe.tc` test has a race condition causing intermittent failures because the `clear_wprobe` trigger executes asynchronously and the test does not wait for it to fire before verifying the trace buffer.
> - [Medium] The `trigger-wprobe.tc` test uses `timer=t` as a fetcharg without enforcing a BTF requirement, which will cause false-positive test failures on kernels without BTF support.
> --
> 
> --- Patch [10]: [PATCH v13 10/12] selftests: ftrace: Add wprobe trigger testcase ---
> commit f8200da0c99be51814ee14df413b8fd81995a06f
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> selftests: ftrace: Add wprobe trigger testcase
> 
> This commit adds a testcase to verify wprobe triggers. It uses set_wprobe
> and clear_wprobe triggers on fprobe and static trace events to monitor
> memory accesses within the trace-events-sample kernel module, and tests
> wprobe trigger syntax error logging.
> 
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com/
> 
> > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
> > new file mode 100644
> > index 0000000000000..0565e2c421778
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
> [ ... ]
> > +:;: "Add a wprobe event used by trigger" ;:
> > +echo 'w:watch rw@0:8 address=$addr value=$value' > dynamic_events
> > +
> > +:;: "Add events for triggering wprobe" ;:
> > +echo 'f:fprobes/testevent sample_timer_cb timer=t' >> dynamic_events
> 
> [Severity: Medium]
> Is it intentional to use a local variable t as a fetcharg here?
> 
> This relies on BTF debug info. On kernels without 
> CONFIG_PROBE_EVENTS_BTF_ARGS=y or architectures lacking BTF support, 
> the kernel's tracing subsystem cannot resolve the argument and the 
> fprobe registration will fail.
> 
> Should this test either add a requirement for BTF arguments in the requires
> directive, or use a register argument like $arg1 instead?
> 
> > +
> > +:;: "Enable all events before setting triggers" ;:
> > +echo 1 > tracing_on
> > +echo 1 >> events/fprobes/testevent/enable
> > +echo 1 >> events/sample-trace/foo_bar_with_fn/enable
> [ ... ]
> > +:;: "Set clear_wprobe trigger on foo_bar_with_fn" ;:
> > +echo 'clear_wprobe:watch' >> events/sample-trace/foo_bar_with_fn/trigger
> > +cat events/sample-trace/foo_bar_with_fn/trigger | grep ^clear_wprobe
> > +
> > +# Disable set_wprobe to prevent sample_timer_cb from re-arming the watchpoint
> > +echo '!set_wprobe:watch:timer' >> events/fprobes/testevent/trigger
> > +
> > +# Clear trace and wait to ensure no new watchpoint events are generated
> > +clear_trace
> > +sleep 1
> 
> [Severity: Medium]
> Can this sequence cause a race condition resulting in intermittent test 
> failures?
> 
> If the test clears the trace buffer here without first waiting for
> foo_bar_with_fn to execute and actually clear the watchpoint, there is a race
> window.
> 
> Since both foo_bar_with_fn and sample_timer_cb run periodically every 
> second, could sample_timer_cb execute after clear_trace but before
> foo_bar_with_fn has fired?
> 
> If so, it would access the still-armed watchpoint and log a watch event in the
> newly cleared trace buffer, causing the final verification step 
> (! grep -q watch trace) to fail.
> 
> > +
> > +:;: "Ensure clear_wprobe trigger deactivated the watchpoint" ;:
> > +! grep -q watch trace
> > +
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/178739053919.1520941.17662338993878200834.stgit@devnote2?part=10


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
