Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38EE3B635A
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762671; cv=none; b=rA/p6lALDhjWLC1T9okZ1yhlvE1VehyxJxDIBNwLJUKkvZfRGUZarx61wr1NTLkRn9DpOwYrD+f1oajT8vnfdemwfdWqvNHykBJNTOtDvVBDm7bNEag9S54S92V9mn5lOYxMe6ZzM7ATpeFgc1Am96+7TgH+tTSBBBltwxAC05A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762671; c=relaxed/simple;
	bh=pBflsT81qdfN3qA1r6lGnnc6NuQ/DEK2gyeoOLRjcY4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nj9OhrJOZXqymrgq38w8vu9qUnI+NbTtSGcr/IqSMEizYGw9y8VQNTzAt9rXOAWUC3TRPkVJMrKfoEbt40Sz08LzL0MHg6YGQxkKkdjUwwNdao14BkOt1sMn2i0zq5P2TAUby25iA9B91w5j9oTSdlp1HuoaPypidZU/0AbZRUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAho5psO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAho5psO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12491F000E9;
	Wed, 22 Jul 2026 23:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784762669;
	bh=pBflsT81qdfN3qA1r6lGnnc6NuQ/DEK2gyeoOLRjcY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OAho5psOcNIc3476yADQlM+uji2CXP1e5BYrDYExRwLkTo32SQZ7t57D00fWE3+xz
	 5ygozH51/69iCnBSQdDUfzjvE0UenSNcprULQh1JdcCB+lLpK65G22T8K2YcDc5Pk6
	 sDFJ1KKRuEuEJr0g9HT7KXI7lGeoN3xbZJHG62GqoqCDHolpjKJ1kld1m8wWHZFoCi
	 XvHvsnEdbcc1Asni8HwZt0Xo0niH2d52kQUfH0aybxJp0PipbgJyFj+y8fkDT0g6HX
	 KnRKJiPSVheAT8qgeiR3WEkBuAWAUU3uho5wwg/TnDoLR26usaHJ0TKnDLVos4pkDD
	 GNJVtGNdEqZLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 09/11] selftests: ftrace: Add wprobe trigger
 testcase
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178476145365.26117.17416572855784144092.stgit@devnote2>
References: <178476134787.26117.10094977293012760490.stgit@devnote2>
 <178476145365.26117.17416572855784144092.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 23:24:29 +0000
Message-Id: <20260722232429.A12491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Test teardown verification is bypassed due to shell quoting and =
explicit `exit 0`, hiding teardown failures.
- [Medium] Hard-enabling `dentry_kill` before dropping caches floods the tr=
ace ring buffer, causing test flakiness.
- [Medium] Global tracepoints lacking PID filters allow background processe=
s to hijack the wprobe watchpoint, causing test flakiness.
--

--- Patch [9]: [PATCH v10 09/11] selftests: ftrace: Add wprobe trigger test=
case ---
commit fe30508ad92d4c48b6107f15074a5539f6b55528
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

selftests: ftrace: Add wprobe trigger testcase

Add a testcase for checking wprobe trigger. This sets set_wprobe and
clear_wprobe triggers on fprobe events to watch dentry access.

> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe=
.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
[ ... ]
> +:;: "Add wprobe triggers" ;:
> +echo 'set_wprobe:watch:dentry' >> events/fprobes/truncate/trigger

[Severity: Medium]
Since this trigger is attached globally without a PID filter, could a
background process hitting do_truncate latch the wprobe onto the wrong
dentry?

If another process truncates a file before the test modifies its temporary
file, it seems the test might fail to detect its own file accesses, causing
flakiness.

> +echo 'clear_wprobe:watch:dentry' >> events/fprobes/dentry_kill/trigger
> +cat events/fprobes/truncate/trigger | grep ^set_wprobe
> +cat events/fprobes/dentry_kill/trigger | grep ^clear_wprobe
> +
> +:;: "Ensure wprobe is still disabled" ;:
> +cat events/wprobes/watch/enable | grep 0
> +
> +:;: "Enable events for triggers" ;:
> +echo 1 >> events/fprobes/truncate/enable
> +echo 1 >> events/fprobes/dentry_kill/enable
> +
> +:;: "Start test workload" ;:
> +echo 1 >> tracing_on
> +
> +echo aaa > $TMPDIR/hoge
> +echo bbb > $TMPDIR/hoge
> +echo ccc > $TMPDIR/hoge
> +rm $TMPDIR/hoge
> +
> +:;: "Drop dentry caches (for dentry_kill)" ;:
> +# Use append (>>) to avoid calling do_truncate again.
> +sync && echo 2 >> /proc/sys/vm/drop_caches

[Severity: Medium]
Will hard-enabling the dentry_kill fprobe earlier cause this drop_caches
command to flood the trace ring buffer?

A system-wide dentry eviction generates a massive number of dentry_kill
events. This could easily wrap the default ftrace ring buffer, potentially
overwriting the watch events needed for the final assertion.

> +
> +:;: "Check trace results" ;:
> +cat trace | grep watch
> +
> +
> +:;: "Ensure wprobe becomes disabled again" ;:
> +cat events/wprobes/watch/enable | grep 0
> +
> +:;: "Remove wprobe triggers" ;:
> +echo '!set_wprobe:watch:dentry' >> events/fprobes/truncate/trigger
> +echo '!clear_wprobe:watch' >> events/fprobes/dentry_kill/trigger
> +! grep ^set_wprobe events/fprobes/truncate/trigger
> +! grep ^clear_wprobe events/fprobes/dentry_kill/trigger
> +
> +exit 0

[Severity: Medium]
Does this sequence properly fail the test if the triggers cannot be removed?

Because the script ends with exit 0, and the grep pipeline ignores the shell
errexit option, any failures in verifying the trigger removal might be
swallowed, causing the test to pass even if teardown fails.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178476134787.26117.=
10094977293012760490.stgit@devnote2?part=3D9
