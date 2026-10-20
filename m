Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500193;
	b=gE2U02s3nk+hK56pIIPYAp7pDaIdggqGlJHmDIrol0Qff9lqFQy1DPygoJeT0ijl27J1
	 wwrj5+rwhqMt8IzsyGWUC6Km2gCu153q1LRTiH2UvQHcgxmkPr/gej1nG2s4xCqXzFD21
	 N4qw1GTa101HPekxSQOzTzfo3ETP6gO9g+cIc9TVU1jZZ7jlN16BVjMDgjvKWe81Z/V82
	 z5t0qUVOR8W3+oMO3z2l7MZKJw0K+P9HvmT+AXIpcHLgR2ZtJUus9Q6KiopiCDl1py2F7
	 mNq8uyH1PFjJGT4Q8d9JdrIhjiVAuTmkTNMRTAGJ9xPM603HNBodP4bU8tBonPSGy3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500193;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AhDmp6WvC/eC417OYA4TdSOvkunZ6fJON1hxhaqdPTw=;
	b=pgeVwS5glCVKO5eQhhR+k2GfcL4fyCHUo4woBa8b/xA83C+/wq18lFMQ+NEvWkqUXYCA
	 +3AeU3N5nB6rpXnzb8z+6m4976iGuCYc5Lpp1MTqkDZLdH5LfZEz9drpXPMKE5Ilj/zYp
	 1LfmeVFmiNK3ece0q1wpi8dxqB91HmdsXzLI/Asmn5bYxGPC2ZOpHdV8EKamfPm8fgkEd
	 e6bqrKpZk+I7dERJ1mHjIu+ZMBUqJLNzRkveM+PYh+mO8NpKyHfZk7j5M1g2Jj5RdKVjZ
	 ceknCz1AMSGCcjhHvBuyiH6eOFkumqQ9VwqX/Z6ETfdjTVkS4oHQ00WSIqr5ozzObNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhPVAsUQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61904606A32C;
	Tue, 20 Oct 2026 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhPVAsUQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FE51F000C4;
	Tue, 20 Oct 2026 12:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792500193;
	bh=AhDmp6WvC/eC417OYA4TdSOvkunZ6fJON1hxhaqdPTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PhPVAsUQSJAVGyzlr0tEKxDt8EHuzbvoGQPBDcFUVDq7Q9ttlTEQDN3Gotem8035s
	 y3kkjnDc4p+POMSucSgdW+doYx9Wd3q9N+kSCx9PPq4qzXId/Dml4st4EtkKAUEKfa
	 nDO6n0s8gGyIl4CSOBL523Gw7f/uxSlkNeZsP26AwnwwTAgyoW3IqHQVNZaIVb3LZW
	 G4OqzWp/tjkt5TZnOfHk351Uhrevd1GwaHXcd9R5rg5MMhhcfONskzvZPl1wgg+wmA
	 XszjnNM+hlLO3zD31uNgyqQOCvC4Sdj5g6fqU/NOl4tCmmu3d3s1n9woVSCre3ftwf
	 HRjkS9hFlz8bw==
From: Sasha Levin <sashal@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
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
Subject: Re: [RFC PATCH v2 0/7] kbuild: build the userspace tools in tools/ with the kernel
Date: Tue, 20 Oct 2026 08:43:09 -0400
Message-ID: <20261020124309.3022372-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <e77d6e7e-bc46-4363-8bea-d95ed521b5ab@leemhuis.info>
References: <20261016143143.3613501-1-sashal@kernel.org> <e77d6e7e-bc46-4363-8bea-d95ed521b5ab@leemhuis.info>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Oct 20, 2026 at 01:52:17PM +0200, Thorsten Leemhuis wrote:
>I noticed that "keeps what is built the same on every machine" in 3/6.
>But is it explained anywhere why this is the done?
>
>I wonder, as the overall goal of this patch set is to increase build
>coverage. So why disable optional features that could be built on
>machines that have the required userland libs installed?

Only allmodconfig and allyesconfig turn TOOLS_BUILD_PERF_MINIMAL on. It is off
by default, and then perf is built as a standalone build would build it, with
every feature whose libraries are installed.

For allmodconfig the main reason is that perf's feature detection does not
always turn a feature off when its library is missing: without libelf,
libtraceevent, pkg-config, or python for jevents, the build stops with an
error. Building perf with everything it detects would make those a requirement
for "make allmodconfig all" on every machine, and cross builds would fail
unless the target's libraries are installed as well.

The rest is about reproducing failures: when a bot reports that allmodconfig
breaks perf, the same build should break on the developer's machine too,
whatever libraries it has.

>Isn't that in a very limited scope what we do for the kernel itself
>already, as some small aspects of the build environment (like the
>versions of gcc or rust installed or the availability of things like
>gcc-plugins) already influence somewhat what is built when you run "make
>allmodconfig all"? Or do I misremember this bit?

You remember it right. The difference is that Kconfig probes for those, so a
missing tool turns the option off rather than failing the build, and the result
is recorded in .config.

That is how I'd like to add the selftests that need libraries: a Kconfig
probe per library, so allmodconfig builds them where the libraries are
installed and .config says which ones were built.

-- 
Thanks,
Sasha
