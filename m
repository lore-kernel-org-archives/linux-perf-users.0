Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515029;
	b=vJt2w38sLMSTW5+JTXg97fYuTzRHxuqRhi66FhDXAAl7T8Kn6JVZK3VaSlrQDP7xSRyr
	 qPdK7oShRQh1j+G9qVifF8GvE50H7Q0Aq4t2AwSibPrc7putWQycfX5ppuN+fz4SERmC5
	 6euegEJksEgKahAU0Nz6hoCAtinQLy1rsn7V1qAmSLiJGxz3Mk51WpdmnBZR3x1TyQdoy
	 FzZ+Brugp/a0SssqnZLlW6cmFuPgSo9xKBDTGQX70ZKHheTL/j8GZr8p8VLkorjSNs95G
	 dpWDc4el69vuHEloG22sSv95j+bfumTxW3RNENQpGMlg35E78LYKydRCmrwzYpB1qPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515029;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EcudHbkac4Srr2SEhy6D5BeBR++U6XmBZEuRnxOaSjM=;
	b=CiWPiCj/4ex2ujvFMlEnmRU1mxljR13CcFFGmINSG5KWSypLN9L02nGdbrqTNFvSkGU0
	 NrHZsnI8N76ZXjRgcQ4qBhPFSGsmlbRxhld0jIp0Q/XMt+8y6xjBjIUWFPuyz0EjfEiZ9
	 oaqBuwyp+Y50mu0FwW7ApP8E+4g7u2DwwPPxpyMTTV0quuhAB+z9ev9VaTUlsS+58QvAK
	 f0+6FP8XohjVplAIgVQzuTGgLPNiubDb9OMXzi7446S3lAUTK6pyW+BnBSDu0IA0NV35z
	 Lp2FQ9pqQLXh4bbPRf8Gz5EGPMC5+J0246k0d6hdE1ooCVhn6aISJ7XLA4V9LMrPNBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=N3Zc+5Zn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FDC606A31C;
	Thu, 12 Nov 2026 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=N3Zc+5Zn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE441F000C4;
	Thu, 12 Nov 2026 20:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794515028;
	bh=EcudHbkac4Srr2SEhy6D5BeBR++U6XmBZEuRnxOaSjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N3Zc+5ZncCkUskcdduh41XLWC3tnbnQ8C7qwgh59HI8QCJP838YIkuN6RVp45E+M+
	 0DfvD3nNQ8JGgPpMbVSNrmVgoYjqPyEghjmn4Z5hlMV8tgPk4hUtbaaY+RcIQ5WAwL
	 v0IKeJdVrMydA26T8yOCLLlO1xR0a1/NcNetni5Q=
Date: Thu, 12 Nov 2026 12:23:47 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 linux-kbuild@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>,
 linux-perf-users@vger.kernel.org, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
 <linux@weissschuh.net>, Thorsten Leemhuis <linux@leemhuis.info>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] kbuild: build the userspace tools in tools/ with
 the kernel
Message-Id: <20261112122347.dbb972627dc856c50eb01cd0@linux-foundation.org>
In-Reply-To: <20261112195427.3411746-1-sashal@kernel.org>
References: <20261112195427.3411746-1-sashal@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 14:54:20 -0500 Sasha Levin <sashal@kernel.org> wrote:

> The userspace programs under tools/ are disconnected from the rest of the
> kernel's build system. Each has its own makefiles and build framework, and
> "make" never builds them: apart from the few host tools the build itself needs,
> such as objtool and resolve_btfids, nothing under tools/ is compiled as part of
> a kernel build.
> 
> That makes them easy to break. Most people, and most of the build bots, check a
> change with "make allmodconfig && make", which doesn't cover tools/ at all. A
> change that breaks a tool passes every build check and is only noticed when
> someone happens to build that tool by hand, often much later.

ooh.

A pet peeve is CONFIG_TRIM_UNUSED_KSYMS.  It zaps exports which aren't
used by the current module set.

So the 20-odd selftests which build modules and then modprobe them can
find that some of the exports which they need were zapped by
CONFIG_TRIM_UNUSED_KSYMS, so their modprobe fails.  This happens if the
current module set happens to not use certain exports which the
selftests need.

CONFIG_TRIM_UNUSED_KSYMS has a whitelist dont-zap-this thing but I
don't know how to populate that from the 20-odd selftests modules.

From a high level, I think all this happens because selftests are
considered "out of tree" for kbuild purposes.

Does this patchset fix this CONFIG_TRIM_UNUSED_KSYMS-vs-sefltests thing?
