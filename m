Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E393B993F;
	Sat, 22 Aug 2026 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787391567; cv=none; b=dXVGwNtH84aqIwhdKMOZB/X9otZmt6SVKaczooe4Iz2pqmu5SRwybqAknG7ZTuP4k/VHR+d1LM7ff+Ayy6RPJ31FWARTOJ14/IAIv2aKvr4tHPO9JxThdW2xlswJiTV2MLCXL4pZL4aXuDhj01RN75Ysz4eiFUiuCzxNFaA4WRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787391567; c=relaxed/simple;
	bh=OqSBYj1pLlKYt3iqs+f1AVwC09LKvVXGZZgy4XjKLyI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZGVqbARqOazCq3vt8bpA6So4xCpWbB6XdcQt772fVRDvY6R6dYg8t5jjJkflM6ZiJPaE8S+gDJf42AFFjiRSVNZrbnkUi3xMKGfphiS21TPs0FpB1g815wPCvvHDsph/5CUZbk4F7183cc6pmIj3rANGj+zw8wCwnOFf0WwWBFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCJjxFjn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCJjxFjn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8481F000E9;
	Sat, 22 Aug 2026 09:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787391565;
	bh=OqSBYj1pLlKYt3iqs+f1AVwC09LKvVXGZZgy4XjKLyI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kCJjxFjnnUriqRq8Zrna3zVe7wKx+X52LpslLD+oomgnS5OuuNCVCAqyazm8dqjZ7
	 N80ZVWo3wqQhFdJm7+alC8Y10B7ELa73dXvb73N3sRUMMgE5zIMg7XBRgQCD+s+FgZ
	 BHs2OKQ2h5w/6yAa65LQ23eoo+CT3cJXlaOjIXNlDg106652tHfuInPBru3zkpOq6O
	 ebEo8sVnxqMIunW/tQF88k8lhLV8aSZLy3lkcGWqtLdPdDjIiEjW0Yi2BDC1DYCQFy
	 didoSV93udIgZb5UadzGAx0K8VN26Z3ZG3jCZBtw+hzv+Qqk3VwJhCDmxqpnfmqdAC
	 m/dEYJIG3Z6WA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 10/12] selftests: ftrace: Add wprobe trigger
 testcase
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178739070441.1520941.13438898193952389821.stgit@devnote2>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
 <178739070441.1520941.13438898193952389821.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 09:39:24 +0000
Message-Id: <20260822093925.BA8481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `trigger-wprobe.tc` test has a race condition causing interm=
ittent failures because the `clear_wprobe` trigger executes asynchronously =
and the test does not wait for it to fire before verifying the trace buffer.
- [Medium] The `trigger-wprobe.tc` test uses `timer=3Dt` as a fetcharg with=
out enforcing a BTF requirement, which will cause false-positive test failu=
res on kernels without BTF support.
--

--- Patch [10]: [PATCH v13 10/12] selftests: ftrace: Add wprobe trigger tes=
tcase ---
commit f8200da0c99be51814ee14df413b8fd81995a06f
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

selftests: ftrace: Add wprobe trigger testcase

This commit adds a testcase to verify wprobe triggers. It uses set_wprobe
and clear_wprobe triggers on fprobe and static trace events to monitor
memory accesses within the trace-events-sample kernel module, and tests
wprobe trigger syntax error logging.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe=
.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
> new file mode 100644
> index 0000000000000..0565e2c421778
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
[ ... ]
> +:;: "Add a wprobe event used by trigger" ;:
> +echo 'w:watch rw@0:8 address=3D$addr value=3D$value' > dynamic_events
> +
> +:;: "Add events for triggering wprobe" ;:
> +echo 'f:fprobes/testevent sample_timer_cb timer=3Dt' >> dynamic_events

[Severity: Medium]
Is it intentional to use a local variable t as a fetcharg here?

This relies on BTF debug info. On kernels without=20
CONFIG_PROBE_EVENTS_BTF_ARGS=3Dy or architectures lacking BTF support,=20
the kernel's tracing subsystem cannot resolve the argument and the=20
fprobe registration will fail.

Should this test either add a requirement for BTF arguments in the requires
directive, or use a register argument like $arg1 instead?

> +
> +:;: "Enable all events before setting triggers" ;:
> +echo 1 > tracing_on
> +echo 1 >> events/fprobes/testevent/enable
> +echo 1 >> events/sample-trace/foo_bar_with_fn/enable
[ ... ]
> +:;: "Set clear_wprobe trigger on foo_bar_with_fn" ;:
> +echo 'clear_wprobe:watch' >> events/sample-trace/foo_bar_with_fn/trigger
> +cat events/sample-trace/foo_bar_with_fn/trigger | grep ^clear_wprobe
> +
> +# Disable set_wprobe to prevent sample_timer_cb from re-arming the watch=
point
> +echo '!set_wprobe:watch:timer' >> events/fprobes/testevent/trigger
> +
> +# Clear trace and wait to ensure no new watchpoint events are generated
> +clear_trace
> +sleep 1

[Severity: Medium]
Can this sequence cause a race condition resulting in intermittent test=20
failures?

If the test clears the trace buffer here without first waiting for
foo_bar_with_fn to execute and actually clear the watchpoint, there is a ra=
ce
window.

Since both foo_bar_with_fn and sample_timer_cb run periodically every=20
second, could sample_timer_cb execute after clear_trace but before
foo_bar_with_fn has fired?

If so, it would access the still-armed watchpoint and log a watch event in =
the
newly cleared trace buffer, causing the final verification step=20
(! grep -q watch trace) to fail.

> +
> +:;: "Ensure clear_wprobe trigger deactivated the watchpoint" ;:
> +! grep -q watch trace
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178739053919.152094=
1.17662338993878200834.stgit@devnote2?part=3D10
