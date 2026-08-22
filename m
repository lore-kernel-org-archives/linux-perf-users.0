Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C73A544A;
	Sat, 22 Aug 2026 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787391400; cv=none; b=skYpl+7+6iPcaIKekMG1w9hZWFO7MN6ZgCFY6GpHEYO1dF7PTmqnTJnmmX+tqNCO713CAoAHMGREZp9TWWpgsNWmP1kXvGvHZ2jErGxI15G65TZ6YXjVnYlchNOSaWfaKaWM+o/xbaiWJLnIWu2dN0G6Jmijp5gjOtx2qu7pYLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787391400; c=relaxed/simple;
	bh=LnNF54uYBeoYC8A2HeZKZGgGsDJuHHOjA1nCKylYZ4k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lX2XkBSMa7HYBRDj0KvNIT1WezatNnALm2vp2yW5W++uLd4neaPMnJOB4+oza7e9D/rDh/1kVv2b7iY5+sVoEguXdlNAKbAjTX5hhrV0b+HFh/cRRueEwuJ1sKjBK/2pamWr9xVLuFs92T+uB78f/8vbA4yWgotFlr8N/B/pz6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEWJoBgB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEWJoBgB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6971F000E9;
	Sat, 22 Aug 2026 09:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787391398;
	bh=UXos9JZBAqRXn68N3DzB5XDDql01iuOrSuXc3jZa8nE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hEWJoBgBZueD/YSgYV7pgPWKY8YDp6yCF7wEDqvyf8K4v8Pv9IW0GPkfBEcpXUfdd
	 MeYnkihcxF2lJEPGL7sEJ8zybNAvLJLGJVjCd7dpvrkb+nHyCm3uZjbNlfaiImTTU2
	 wIj3nzlx6k47+fHCtL6Z0kP0FcK7vN71iBOIDKJAkUdx/nBF1IwWV/ESHfSK1CUjXj
	 VASMslzoudR4uMmbIPHVxSAs5RFEfJDlFuBXl0tu9JWJM9Sv5kvYafY6yqDST4RWp2
	 AdiHuCwOIJzEWzOM8lcptg4U6jlLRCn88xEQp7CVKFUtovCdo2jvx+043hXP4A7H/l
	 E5EeeqxDitd9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 07/12] selftests: tracing: Add a basic testcase for
 wprobe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178739066970.1520941.12929870364050962005.stgit@devnote2>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
 <178739066970.1520941.12929870364050962005.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 09:36:38 +0000
Message-Id: <20260822093638.8E6971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unreachable error handling logic due to early exit under 'set -e=
'.
--

--- Patch [7]: [PATCH v13 07/12] selftests: tracing: Add a basic testcase f=
or wprobe ---
commit 6d72a05750c5dfc08de6b03a6fc65e5144b20b9f
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

selftests: tracing: Add a basic testcase for wprobe

Add an add_remove_wprobe.tc testcase for testing wprobe events that
tests adding and removing operations.

> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wp=
robe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.=
tc
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
> @@ -0,0 +1,63 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Generic dynamic event - add/remove wprobe events
> +# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<le=
n>]":README
> +
> +echo 0 > events/enable
> +echo > dynamic_events
> +
> +# Use jiffies as a variable that is frequently written to.
> +TARGET=3Djiffies
> +
> +echo "w:my_wprobe w@$TARGET" >> dynamic_events
> +
> +if ! grep -q my_wprobe dynamic_events; then
> +    echo "Failed to create wprobe event"
> +    exit_fail
> +fi

[Severity: Medium]
Since the ftracetest framework runs these scripts with set -e (errexit)=20
enabled, will this script exit immediately if the kernel rejects the event=
=20
creation and the echo command fails?

If so, the subsequent diagnostic grep check and exit_fail call wouldn't be
reached, leading to a silent failure without the intended error message.

> +
> +if [ ! -d events/wprobes/my_wprobe ]; then
> +    echo "Failed to create wprobe event directory"
> +    exit_fail
> +fi
> +
> +echo 1 > events/wprobes/my_wprobe/enable
> +
> +# Check if the event is enabled
> +if ! grep -q 1 events/wprobes/my_wprobe/enable; then
> +    echo "Failed to enable wprobe event"
> +    exit_fail
> +fi

[Severity: Medium]
Similarly, if enabling the wprobe fails at the sysfs boundary, would this
echo cause an early exit and bypass the diagnostic error message here as we=
ll?

[ ... ]

> +echo "-:my_wprobe" >> dynamic_events
> +
> +if grep -q my_wprobe dynamic_events; then
> +    echo "Failed to remove wprobe event"
> +    exit_fail
> +fi

[Severity: Medium]
Could this echo also trigger an early exit if removing the wprobe fails,
bypassing the failure message?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178739053919.152094=
1.17662338993878200834.stgit@devnote2?part=3D7
