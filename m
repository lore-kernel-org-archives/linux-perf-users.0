Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808323;
	b=uncbja80dxXaO408sH/xWU2Xt8Dc/AOT3UNWW0+dcAMO1MVu3ubi3HbIb3CW62aU8SWV
	 H9rMENdkXXIZ6eLE/SCmm/lx2m5AlnImowpiZE3cZzVFhcMaQRHv8nlA0J2XtAJETpeiv
	 DDSZixmAfaCbRCkTZHV2Mx2G+o6M2EQRt/d3IrhvEQubQtk3zM9JMwKb4+cXErc/h0h+v
	 6SPxWezIpHrf/9yxZWdPL6P8pIa+m2+y11NKz3Bpwwq/t37+MuhVsp0brnWvS/0DnHImf
	 v/o9EhT0p3omy2vPKbzIulCGhgZrfG5GPiLkl+nu4CeNRdzZrzQscX9n7rvsVkomCOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808323;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=21lrakUQobOh3xeTOt2wYElHrzwPEdXy3hVkgjmKexE=;
	b=Ty3CxAZSKqBFwjhGJUB+/7D/M1uXI4cODx8WKy5/1/Y2UxWeKGcamTfq50nYqNvELi6i
	 0yMBZOtUqxWn+C2jRqYE+NAbhUsjr8fNao9iyzAeDuIFDyd6vsFvV+93t/bQbPbGKIL8A
	 6QXOJte/LQwmIPAdJ+gASGw2WseApy1s/PjMZvBOnSIvbDLUgJBFrpXUgi9hj9E5W0ciH
	 hrfbOrb8XXGlhEVQMwf1GipRxuQDl+SCbBR5pTMMvBQKI6ZldNsz/atxTuXc8z1Y2X1dQ
	 5UBIbywoOEfSqQDHg4lFBEHnnjo8mKd5jsn92KHFauRnMzjuh640U1TkC+PuNmgdRhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CbSdTX0o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AEE606A31C;
	Mon, 16 Nov 2026 05:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CbSdTX0o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068401F000C4;
	Mon, 16 Nov 2026 05:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808323;
	bh=21lrakUQobOh3xeTOt2wYElHrzwPEdXy3hVkgjmKexE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CbSdTX0o3lWH3oTLs8ZgRq/2O7RJecGlggApuVIZLa8ikGkvtSO+gagLn2pvJS9G0
	 7bB97gjRf1j2zotcdzpJCDy9cS6tzNyRj1Esgg7r/g/8Vy7Y9Q5nfFBuYGUE3MkG6Q
	 ET54bemkmkHKs0bqtbASGgdY5xfxMjG9jy85UMoimRFQfRkKXsWmyMA5dmV0uIlCX0
	 +qcbef1RfnLMcXGB1nKOhYxJucnUO9/6Nfv6zZy2PvCv/LsHfjJds+6CtXV5ixqUfR
	 tGlsbYo29+KFDb0xzuzvyYRbcAD30U1vjBRoaDhz6XHA6i+VE2mzQfEECtxjIhmR9e
	 aTVcvefdY0sQQ==
Message-ID: <sashiko-outbox-216232@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 09/11] selftests: tracing: Add wprobe trigger
 testcases
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <179480685671.38065.18275795234795685673.stgit@devnote2>
References: <179480675130.38065.3086970856119381693.stgit@devnote2>
 <179480685671.38065.18275795234795685673.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 05:52:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] selftests: ftrace: race checking count=3D1 on active timer in
  trigger-wprobe.tc
- [Low] selftests: ftrace: race truncating dynamic_events after wprobe
  trigger removal
--

commit 99426394cee3a23084f980a46322a802a391dabe
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

selftests: tracing: Add wprobe trigger testcases

This commit adds ftrace selftests covering set_wprobe and clear_wprobe
event triggers, including CPU hotplug and trigger syntax error checks.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe=
.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
> new file mode 100644
> index 0000000000000..13cacfd376e79
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc

[ ... ]

> +:;: "Test field offset, count limit, and conditional clear_wprobe" ;:
> +clear_trace
> +echo 'set_wprobe:watch:timer+16:1' >> events/fprobes/testevent/trigger
> +if ! grep -q '^set_wprobe:watch:timer+16:count=3D1' events/fprobes/teste=
vent/trigger; then
> +  fail "Failed to set counted set_wprobe trigger with offset"
> +fi

[Severity: Low]
Can sample_timer_cb() fire before grep reads events/fprobes/testevent/trigg=
er
here?

events/fprobes/testevent/enable is already set to 1 while sample_timer_cb()
runs every second on a timer.  If the timer expires between registering the
trigger and spawning grep, wprobe_trigger() decrements data->count from 1 to
0:

shell                             <softirq>
write()
  wprobe_register_trigger()
                                  sample_timer_cb()
                                    wprobe_trigger()
                                      data->count-- (1 -> 0)
grep
  wprobe_trigger_print()
    prints count=3D0  <-- grep for count=3D1 fails

Disabling testevent while registering and checking count=3D1, or matching
count=3D[01] before the post-sleep count=3D0 check, would avoid a spurious =
test
failure.

> +
> +sleep 2
> +if ! grep -q watch trace; then
> +  fail "Failed to trigger watchpoint with field offset and count"
> +fi
> +if ! grep -q '^set_wprobe:watch:timer+16:count=3D0' events/fprobes/teste=
vent/trigger; then
> +  fail "Counted set_wprobe trigger did not decrement count to 0"
> +fi
> +
> +echo 'clear_wprobe:watch:timer+16' >> events/fprobes/testevent/trigger
> +echo '!set_wprobe:watch:timer+16' >> events/fprobes/testevent/trigger
> +sleep 2
> +clear_trace
> +sleep 1
> +if ! grep -q '^0\*' events/wprobes/watch/enable; then
> +  fail "Conditional clear_wprobe did not soft-disable watchpoint"
> +fi
> +if grep -q watch trace; then
> +  fail "Failed to clear watchpoint with conditional clear_wprobe"
> +fi
> +echo '!clear_wprobe:watch:timer+16' >> events/fprobes/testevent/trigger
> +
> +:;: "Disable events and remove dynamic events" ;:
> +echo 0 > events/enable
> +echo > dynamic_events

[Severity: Low]
Can truncating dynamic_events immediately after removing clear_wprobe fail
with -EBUSY?

When a wprobe trigger is registered, wprobe_trigger_cmd_parse() takes a
reference on the target wprobe event via trace_event_try_get_ref().
Unregistering the trigger calls wprobe_trigger_free() -> trigger_data_free(=
),
which defers release_private_wprobe_trigger_data() -> trace_event_put_ref()
to trigger_kthread after tracepoint_synchronize_unregister() finishes:

shell                             trigger_kthread
write("!clear_wprobe:...")
  wprobe_unregister_trigger()
    trigger_data_free()
write("" > dynamic_events)
  dyn_events_release_all()
    unregister_trace_wprobe()
      trace_event_dyn_busy()  <-- returns -EBUSY
                                  tracepoint_synchronize_unregister()
                                  release_private_wprobe_trigger_data()
                                    trace_event_put_ref()

The same race applies to cleanup_wprobe_triggers() and to
trigger-wprobe-hotplug.tc where echo > dynamic_events runs immediately after
removing the triggers; calling clear_dynamic_events (which retries in a loo=
p)
or sleeping before truncating dynamic_events would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179480675130.38065.=
3086970856119381693.stgit@devnote2?part=3D9
