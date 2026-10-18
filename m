Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8057D3A0E8D;
	Sun, 18 Oct 2026 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331616; cv=none; b=uo5pApkkLHHLNPWCj268fHmog9MVDbA1YgClqyGX3xLm0eWf4hsGKTwpN9yt8t62oTQXrLn2diQldx4gM37xmosl7ptKLvsishaQo8CUsq/xrbP5acLf3SzO4zHYtvVSdaUTztr94G21CFhPwS6YHc6IvDoyVCYocS+4TFCe0R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331616; c=relaxed/simple;
	bh=sgJectzh7qFFPO/UVGmk0Nh0g8lMaSPwNGmHiC1LsdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQXsYKMoz/Sc9vFtVfar0beemIyTYp1HenbEYuiiJUgl72sGIINJQUEA5D8zFCJEc74L7A9Aqtsk0Y85xXJrFNJIXsE9DO8cfps7rGgTPeCoA8d8NdXxsRMphNntmhift44UfWQ4aXjTOkjWYQQVcjSOcRSHbxigd0m6HYnxVjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzZHOzqw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzZHOzqw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CF61F000C4;
	Sun, 18 Oct 2026 13:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792331615;
	bh=V/CwHlaGhnNmKVy9kiRkOmng0w9ivK3rMdXuyGEs5X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jzZHOzqwblo+CYkH31+bAL4Hi0+BD9GHgoljQou+VuQ8QpR6HLGPEgYom2vnL9zQO
	 61wFwZZKA5vcopJdOgQNW3cJeY3D2GTU96vjcpvoFFxhG29ULBr+1a9rCqDb4aQVzb
	 BdVpz9yJ4eQO5MjVtqj2J+L/EBhqmjWfdC2J+T0Gl04vUZybLB9rJXqtfTdkvbw78u
	 t2drUA9tIFcT1Dg2PkSG+TZN7rGFgp36zEyO6YbLWiFfBSZ18+msP0vIRkOHkbZ8+z
	 sQNMVlpLJ0o3D2AtUkL0rdYqt+MTsO+CmmyKcCq7bRrknO00Pytqmw3Fvm6xObU599
	 U2Rknkzcu/88w==
From: Sasha Levin <sashal@kernel.org>
To: Ian Rogers <irogers@google.com>
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
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/7] perf build: Add MINIMAL=1 to build without optional features
Date: Sun, 18 Oct 2026 09:53:32 -0400
Message-ID: <20261018135332.3987231-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAP-5=fV_A+k-_g683q7n897YMudBwwvQPkS_cKRSdOxkEYFa0Q@mail.gmail.com>
References: <20261016143143.3613501-1-sashal@kernel.org> <20261016143143.3613501-4-sashal@kernel.org> <CAP-5=fV_A+k-_g683q7n897YMudBwwvQPkS_cKRSdOxkEYFa0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 16, 2026 at 08:41:29AM -0700, Ian Rogers wrote:
>In perf-tools-next/linux-next both LIBPYTHON and LIBPERL are gone
>(context in https://lore.kernel.org/linux-perf-users/20260926062029.800743-47-irogers@google.com/#t
>).
[...]
>We should expand this with NO_MYPY and NO_PYLINT for the
>perf-tools-next version.

The series is based on mainline, which still has NO_LIBPYTHON and runs mypy and
pylint only when asked to, so 3/7 only covers those knobs.

I sent the perf-tools-next version on its own: it uses NO_PYTHON_MODULE and
also sets NO_MYPY and NO_PYLINT.

https://lore.kernel.org/r/20261018135321.3986899-1-sashal@kernel.org

-- 
Thanks,
Sasha
