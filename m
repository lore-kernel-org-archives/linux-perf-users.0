Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18284CDDDB;
	Sun, 18 Oct 2026 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792334386; cv=none; b=BxPnvBvfbEmTfvObBmpydEpttY8Z3Z/3lx2FG89eq8ipwdPqc8ITqsEXa9Ov7V7x1tR8Gn0k8+s0Bo6axeNliq9SZUGOY3njArqQBJWyo+lJD7nYv50x6zBDQxmFsLi/ZIWMRQ8boNt/LthGLAsFN81VFaPkJAtPiSrYPHj2gL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792334386; c=relaxed/simple;
	bh=MRJx1vIj2fP9MSobtQEAV6lsDe4NVAEkgaD+E81bajs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijCZro+UguG70D5Tb2mAxvnz1IRCFHJogV29uVN9drq8/oi6nyEwKAZ9oYjuLFWfM1DJno+x+ouVJyr+OJ5yEVde6peIDlcQOQByCUXWzwJL7qBMeVYK9WwfgZE3SGVGpFZYOjRXHNVIPukCCK8isZVShJM7NwX1/cr8LK5hNeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EN8uDjjP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EN8uDjjP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0FB1F000C4;
	Sun, 18 Oct 2026 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792334385;
	bh=33NHgzl/lemSJ8wLisSuVgHWppVFEMT9N5u+0R13vPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EN8uDjjPFoy70Fm/b3K+gO21YFWARq9zMmVmOMvZ/K4T5ZeQp24K+6nYKZCYOSiiG
	 ivgXnpJiyP9aSQfo1RmEF8SWgP0WoCPKzCx6OZenn5K73i9pA6v3mlYLt29zw4Hw29
	 v6ru48DyqhuK0DBhXnQv+3KqYcYitqPlVbIhxSgviL3NzDou6HmhvsMnpWSB90Y+ex
	 U2I8OjCzVLQSOxrOhZjjeyrzFksgQBKUyC/f/wn40Nqfhpgc9ogr6rKzvfkCreHF4Z
	 dwCRSe5MToHP89idczVJ7M84Typ8YPHPq25KQP4dtecLXMm7cEvV5ykiy74AQe5SQD
	 9xkbr5REeOo2g==
From: Sasha Levin <sashal@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/7] kbuild: add "make tools_build" to build userspace tools from tools/
Date: Sun, 18 Oct 2026 10:39:42 -0400
Message-ID: <20261018143942.4113179-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <sashiko-outbox-175553@kernel.org>
References: <20261016143143.3613501-1-sashal@kernel.org> <20261016143143.3613501-3-sashal@kernel.org> <sashiko-outbox-175553@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Oct 17, 2026 at 02:32:09PM +0000, sashiko-bot@kernel.org wrote:
>> +dry-run := $(findstring n,$(firstword -$(MAKEFLAGS)))
>
>[Severity: Medium]
>Could this dry-run detection logic produce a false positive for common make
>arguments?
>
>If MAKEFLAGS starts with a long option containing 'n' (such as Kbuild's
>frequent default --no-print-directory), -$(MAKEFLAGS) evaluates to something
>like ---no-print-directory, and findstring erroneously matches the letter 'n'.
[...]
>Is it possible to use the standard Kbuild idiom here, like
>$(findstring n,$(filter-out --%,$(MAKEFLAGS))), to properly check the flags?

MAKEFLAGS does not start with a long option. With make 4.0 and later,
which the kernel requires, its first word holds the single letter
options and the long options follow after a space. With no single letter
options, -$(MAKEFLAGS) starts with "- --no-print-directory" and the
first word is "-". The top level Makefile detects -s the same way.

Under kbuild the first word is "-rR", as kbuild adds -rR to MAKEFLAGS. I
checked with make 4.4.1, calling Makefile.kbuild from a parent that adds
-rR --no-print-directory: dry-run is empty for a plain, -j, -k and -s
build, and is "n" only with -n.

-- 
Thanks,
Sasha
