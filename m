Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6D01FBE90
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 02:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784081803; cv=none; b=XQ1V74mY35fg6pk9lGRn6JrH+jYhSXgi0LbI98j+K51TjTOAAL0vvWqzh9fhbQiP+WGWXyDfJaQhXUhkOUnQ6C8VhkMbb4UibE8Mw4iSdDLek/3LozXltJYgaaB509i1s/a/7dniTaAzpaKkN+mk41N3w+O9u0W75PU6a6BxK3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784081803; c=relaxed/simple;
	bh=MXybX/E8/hq+V6D9xCYy/4RrD5UaZ4rlzG7JuhApWug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WEo1Ovxx+6AmMGzqnMA/k2Ghy+lTEvHZk/put1xemsO7sUH2iR0h0G8/KvVaMIKF7vWjyoCS7Q/ulnyOxgAqLoYvJ5z9qd3FIPXQDSUnFa5mpw2AJn0sld7pcbuRKnCoN4o4TXps70fmdLZsh/za88FWrpKkS48Xj6dNCC1O5eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUtBqLHg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUtBqLHg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D691F000E9;
	Wed, 15 Jul 2026 02:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784081801;
	bh=ZpDUebz3hW3/h3yMUGbxOvVIpJX+bjBzth32z/Uo9sI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VUtBqLHgypWO2gDUMpN/uFjbq4pZeIzaTYEsIqnvLZDZUhe5Zyg8Tz3/eWB+rgNRC
	 i3rH+8ObomJgf+GLwB+GjAVaaAPFVcYcyd6M7mksi9LLmmNnatV36Qy8Oy5AFw7YtV
	 tvv6pbeE40KzlkLHPG/Qyh2LSeym086+nlF6tnPZPcmaS6pIf+M1rhiOadQWLjiMpY
	 afkzuV4X83VevQdNS4XV57Jx76fFTfkABQkd+SD2WY8UUA5qu931ve02nxbbYxVx/w
	 Rl1go8OFVy2KXzHnAtVLV2UAzsKTJCkV4/u7WUsiTyVrqQ8CBzYCLq7CQnhsoAubBi
	 UxwS7Jv0kkHAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/10] selftests: ftrace: Add wprobe trigger testcase
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178407995495.95826.11582585035165074036.stgit@devnote2>
References: <178407983818.95826.12714571928538799781.stgit@devnote2>
 <178407995495.95826.11582585035165074036.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 02:16:41 +0000
Message-Id: <20260715021641.B3D691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Permanent leak of trigger_data and wprobe_data when unregistering =
a wprobe trigger.
- [Medium] The selftest fails to declare its dependency on fprobe in the `#=
 requires` directive, causing test failures on unsupported kernels.
- [Low] The test uses a hardcoded path `/tmp/hoge` for triggering file oper=
ations, leading to test brittleness.
- [Low] The test hooks a static function `dentry_kill` without checking its=
 presence in `available_filter_functions`.
--

--- Patch [10]: [PATCH v7 10/10] selftests: ftrace: Add wprobe trigger test=
case ---
commit 3a609968e71e94ce3399d95a2f00d2d3b0974ab0
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

selftests: ftrace: Add wprobe trigger testcase

This commit adds a testcase to check the wprobe trigger functionality.
It sets set_wprobe and clear_wprobe triggers on fprobe events to watch
dentry access, validating features that depend on both wprobe and fprobe.

[Severity: High]
While not part of this commit's diff, there appears to be a regression
associated with the wprobe trigger registration tested here.

In kernel/trace/trace_wprobe.c:wprobe_trigger_cmd_parse():

	ret =3D event_trigger_register(cmd_ops, file, glob, trigger_data);
	if (ret) {
		event_trigger_reset_filter(cmd_ops, trigger_data);
		trace_event_enable_disable(wprobe_file, 0, 1);
		return ret;
	}
	/* Make it NULL to avoid freeing trigger_data and wprobe_data by __free() =
*/
	trigger_data =3D NULL;
	wprobe_data =3D NULL;

	return 0;

Does this code permanently leak the trigger_data and wprobe_data structures
when unregistering a wprobe trigger?

The successful path returns without calling event_trigger_free(trigger_data=
),
stranding the reference count at 2.

> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe=
.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
> new file mode 100644
> index 0000000000000..cc7a0532d7ff8
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
> @@ -0,0 +1,48 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test wprobe trigger
> +# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<le=
n>]":README events/sched/sched_process_fork/trigger

[Severity: Medium]
Will this script fail with an error exit code on environments without
fprobe support, rather than gracefully skipping the test?

The test relies on fprobe (f:), but does not declare this dependency in the
# requires directive.

Without this requirement, the ftracetest runner will try to write f:truncate
to dynamic_events on kernels configured with CONFIG_WPROBE_EVENTS=3Dy but
without CONFIG_FPROBE_EVENTS, causing the test to fail.

> +
> +echo 0 > tracing_on
> +
> +:;: "Add a wprobe event used by trigger" ;:
> +echo 'w:watch rw@0:8 address=3D$addr value=3D+0($addr)' > dynamic_events
> +
> +:;: "Add events for triggering wprobe" ;:
> +echo 'f:truncate do_truncate dentry=3D$arg2' >> dynamic_events
> +echo 'f:dentry_kill dentry_kill dentry=3D$arg1' >> dynamic_events

[Severity: Low]
Is it safe to assume the static function dentry_kill is always available
for tracing?

The script attaches an fprobe to dentry_kill without checking if it exists =
in
available_filter_functions.

If the compiler aggressively inlines or eliminates dentry_kill, the fprobe
creation will fail and abort the test.

[ ... ]

> +:;: "Start test workload" ;:
> +echo 1 >> tracing_on
> +
> +echo aaa > /tmp/hoge
> +echo bbb > /tmp/hoge
> +echo ccc > /tmp/hoge
> +rm /tmp/hoge

[Severity: Low]
Could this hardcoded path cause unexpected failures if /tmp/hoge already
exists, is owned by another user, or if tests run in parallel?

The test writes to a fixed global path instead of relying on the isolated
$TMPDIR standard within ftracetest.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178407983818.95826.=
12714571928538799781.stgit@devnote2?part=3D10
