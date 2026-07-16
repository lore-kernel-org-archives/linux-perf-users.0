Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C0026738C
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 03:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784171156; cv=none; b=NSYcka7PHfQjgnCc+RfCvYBlz4MqXJ4DhzbkG3InDEy6Ni+W/8GuxyjqmaOwGYYUrfJ7rsWAinqK+uAmQ6JgxyxK4/Rz/iYkQaLa3vsuKYU5MmBq2DosAUZy/Hq1MbJVRFXowVxIVp2VU5HwLQgYPidczZtwGF0mGqMMIvbXByU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784171156; c=relaxed/simple;
	bh=DmNCRk/l/+4aG9cTcyAfhEPxz1h9que/8j/naxfC5jk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lbanbrRZ9rGCOAFXtTe8LTLjehkFmGk/NgDQ2JBEfjb7AxBxpRLTm+zXHZmBs+SPO+6yRGoSfVfvaN3L/u5Bp/Wf5dTR/wy4miR0dMVWhXZSsvc4EAVM9sbU7gQac1+I3x9mDPJsJ/FtFNhN1bX5nvdmXkQ/V6N+mmYDyhQsRfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxjGLZYI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxjGLZYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E401F000E9;
	Thu, 16 Jul 2026 03:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784171155;
	bh=ElYxNrxxVQh3wkQUYHs3vQUH/XQYzQc3WOuTHHCjCo8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SxjGLZYIf4mkfDAFmXIGV4xdPukkA8STs3298BRA6b+ayLbUSypm/rjdzkzD/uc3O
	 utzkXmfNOsWbVEZkpnR3GNHhgF6Yt5KTu0xeAxV9Aah/e2nF5Reg+eSDsD6EGdjdcQ
	 hXaKu+hjyO2CSUuWhhP+KN2Rr682NeElJk4ASL/aK9ObFKGG6KFpXzZHffuNUuWPK9
	 mX/hz510CFECGsdLrZ3ANm9NexFnnDHHxsndgkPDUWsmBCoNIOsAJRIxNBf6ME37zD
	 bi25Zo2HpTJ21cPlRS1+MdohmG2NCZZheepJ6ieTBPFG3JIXXAy1xV6eMp8UPwNSQW
	 2IdcOZT5BBYAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/9] selftests: tracing: Add a basic testcase for
 wprobe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178417036552.209165.10709545532621528052.stgit@devnote2>
References: <178417033089.209165.16717079876036408877.stgit@devnote2>
 <178417036552.209165.10709545532621528052.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 03:05:54 +0000
Message-Id: <20260716030554.D7E401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Error handling blocks checking `$?` are dead code because the test =
script runs under `set -e`.
--

--- Patch [3]: [PATCH v8 3/9] selftests: tracing: Add a basic testcase for =
wprobe ---
commit 0ee1282cbf519c56b378956b7875111e8d6bc222
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

selftests: tracing: Add a basic testcase for wprobe

This commit adds a basic testcase 'add_remove_wprobe.tc' to verify the addi=
ng
and removing operations for wprobe events.

> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wp=
robe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.=
tc
> new file mode 100644
> index 0000000000000..5ddf28ddd2c4b
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
> @@ -0,0 +1,69 @@
> +#!/bin/sh

[ ... ]

> +echo "w:my_wprobe w@$TARGET" >> dynamic_events
> +
> +grep -q my_wprobe dynamic_events
> +if [ $? -ne 0 ]; then

[Severity: Low]
Since ftracetest executes these scripts with errexit (set -e) enabled, will
the script exit immediately if the grep command fails?

If the script aborts on the failed command, this if block and the others li=
ke
it throughout the script become dead code, preventing the custom diagnostic
messages from being printed in the failure logs.

> +    echo "Failed to create wprobe event"
> +    exit_fail
> +fi
> +
> +test -d events/wprobes/my_wprobe
> +if [ $? -ne 0 ]; then

[Severity: Low]
Similarly here, does the test command cause an immediate exit before $? can=
 be
evaluated?

> +    echo "Failed to create wprobe event directory"
> +    exit_fail
> +fi

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178417033089.209165=
.16717079876036408877.stgit@devnote2?part=3D3
