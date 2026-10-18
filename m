Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CA94CE662;
	Sun, 18 Oct 2026 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792334390; cv=none; b=hvqlQZSabY0TENngOIbj8cDNKDqcp6Lnc5Y26BTRQCC6rJ5cSXxE5xDZAHQnFLuQqX4KfUNNOItJMjsnXz2DuDlpyJf2hk2NSL1SMPlYLPt5HztjA0pUyu166bUU5Qvn+azsfYcZt/NEIP5DciWkI4O1LnnvrdU0FQ+BQEH7fr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792334390; c=relaxed/simple;
	bh=SuY4gLuyRj7+8bL8p9hnHJM2T5/YY0D+QZt4mhfexhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ey7axoshJcGGTkkqCV11KUDWSfPG/kG8v10lE2iIfMLAtFHKbrUN1kZd9ZnbmmrsmbZonul+lgiuvHWfv4VvUZawOgUYm2ctdVEv60XAteec7SeQtJ21F0a+jacgwB7FhStiBvNxNBqRb1egaIdYkJlWANIbXb6L290b0h23LuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIZQ38Pg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIZQ38Pg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6FD1F000C4;
	Sun, 18 Oct 2026 14:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792334388;
	bh=llN8vi4Rd5xdSPsVbEvXNlM9uyfBMT7kb9KNI9c+8DY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cIZQ38PgZijku0YKSp8HNx2PxsLxD0duQzxinPRcPi/eyqrAnsOLbxnasfQSTiigG
	 UN19RsdSfl4tW+PPnihHCFr5wAVa793i+qPbd/w1H/9Bwe2Vo9W6upfO/rkYlaD48/
	 GDAp0VSLyZqT3/tK9GRCfB7wSnzjJbI4RR4jT4qzTFiKJ9ukNGh8bFhoSZMrIbKktD
	 Df0OJuMFA+qzwsPRu6Bqf6o+iU2ed1zcJYMlRGMYkCHShRzOcNpmIIpMQIHLv9brQm
	 W8lrzBlOVgjISJ5wRkg9Rybu7UNLNgli3k5AslW5jLqpxQfRlnQdQfYrfIvhw++mVJ
	 u2XE1y/E7OQRg==
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
Subject: Re: [RFC PATCH v2 5/7] tools: build kernel selftests in tools_build
Date: Sun, 18 Oct 2026 10:39:45 -0400
Message-ID: <20261018143945.4113338-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <sashiko-outbox-175556@kernel.org>
References: <20261016143143.3613501-1-sashal@kernel.org> <20261016143143.3613501-6-sashal@kernel.org> <sashiko-outbox-175556@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Oct 17, 2026 at 02:32:12PM +0000, sashiko-bot@kernel.org wrote:
>> +config TOOLS_BUILD_SELFTESTS_KEXEC
>> +	bool "kexec"
>> +	depends on X86_64
>
>[Severity: Medium]
>Does this unnecessarily restrict the kexec selftest to X86_64?
>
>Looking at tools/testing/selftests/kexec/Makefile, it explicitly supports both
>x86 (32-bit and 64-bit) and ppc64le:
[...]
>Configuring the tools build on ppc64le or 32-bit x86 will not expose this
>option, silently excluding the test from being built and installed on these
>platforms.

TOOLS_BUILD is only available on x86_64 and arm64 for now
(TOOLS_BUILD_ABI), so no entry can be selected on ppc64le or 32-bit x86.
The kexec Makefile has no tests for arm64, which leaves x86_64.

>> +$(selftest-shared): FORCE
>> +	$(Q)mkdir -p $(@D); \
>> +	newest=$$(find $(CURDIR)/usr/include $(toolsdir)/include $(toolsdir)/arch $(toolsdir)/testing/selftests \
>> +		-type f \( -name '*.h' -o -name '*.mk' -o -name Makefile \) -printf '%T@\n' | \
>> +		sort -n | tail -n 1); \
>> +	touch -d "@$${newest:-0}" $@
>
>[Severity: Medium]
>Will this miss rebuild dependencies on shared build scripts?
[...]
>Modifying core shared files like tools/scripts/Makefile.include,
>tools/scripts/Makefile.arch, or scripts/subarch.include will not trigger a
>rebuild of selftests that include them, which can lead to stale builds.

Right. Of the selftests built here, kexec and vDSO include
tools/scripts/Makefile.arch and rseq includes scripts/subarch.include,
and neither file is checked. I'll add both in the next version.

>[Severity: High]
>Can this trigger a fatal Make syntax error if no selftests are selected?
[...]
>Since this rule uses two colons, it is a static pattern rule. While GNU Make
>ignores empty targets for single-colon rules, an empty target list in a
>double-colon static pattern rule evaluates to : selftest-%: ... and
>triggers a fatal missing target pattern. Stop. build error.

This is not a double-colon rule, and make ignores a static pattern rule
whose target list is empty. With CONFIG_TOOLS_BUILD=y and no tool or
selftest selected, Makefile.kbuild runs with make 4.4.1 and reports
nothing to be done for __tools_build, with and without -n.

-- 
Thanks,
Sasha
