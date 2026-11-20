Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207999;
	b=jXYw5Eh2msq9x7MrQCSaqam++goCRblor5mQLN734QNwRS5oc3gnpyHovi1obnNUBC0m
	 Nt9nquAMOKbgNsP9Pqka8AEeNKO3gpwGx0GX9GZISTlyyIMt8pY53hw8MeZpwRoA32NZD
	 9Qb5tE82pc25WQr0qh2SF7VGU07CaCwYCtuIFc6njoXfGe8jWHsp6aZX94b1dQQ7cMJKJ
	 C3k+hkmbvoMWzzNgjvnc3ed01RIX8k/0YWp4vPUTQ4xicxFF83EsT0ehrgDGv/nToKl7G
	 4rsqEvpsk/b/OsX1rfW9gsiKGAjuNAha8m7I+ZD1+Asgt1VN7R8ysTXO3Q7H21aVZiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207999;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=I4MdxbRlq3GLWXo0+OZI0QrC5k3oGhRki3MUjyIl6/I=;
	b=HND6X/9FfgSlDhDxwvPzV5XU+TOqwXHu9uuOQZCKNSHMlOqWB7TCunHlCJYSrypHGEi5
	 fRo/050M4Dn5MgSoBDtmfvLRYmzViw41/OgvdI9oWyTAhoIQSs8ODZ3sKyv9hoaN0kXfn
	 3JTu+n6jgSI3jRZLAVJhGp4ch+4oUNvZJ4Y2o1QkZKLC8btYNvKvJoF9U9MQLnMxvvM39
	 hke7tyyfJS1AcqMDvjjhBI4CRVopdgqcZ0AvM46hnqQo+1UsnOfl9YwPrtuvnI5ZRTurk
	 EUReY7WJUwDLkwRIBzOh8ayZv92SVNiD/XsCy7RExw5Eq+63Om0aAhzN15GvTjRNfVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3+TDlf3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 17792606A6B4;
	Fri, 20 Nov 2026 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3+TDlf3
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C47FA1F000CA;
	Fri, 20 Nov 2026 20:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795207998;
	bh=I4MdxbRlq3GLWXo0+OZI0QrC5k3oGhRki3MUjyIl6/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j3+TDlf3wP4OZJMLhZ/+XBUbpRdI0PEzCyLw7HcX58vQJTGECAVcsJ25e34AllNLn
	 GfJzHbrXzJNkBYHCd62AP8hTlbWSlYAYuMvhYOXUNi26mT/cX8k9y6s2IWtGMluu06
	 3DkOirHRpMoCd/AKZJ38fidKcaMlocfl6IAdnBiy9FOqEiMjG0oPTiSEIx6/4ajs6q
	 v9551tvXmQnC62NzJIDqQpFv+C7Isbjn1pwtExUEf6feUaw9ITW2JQS0qLhuOF6qng
	 7UV9iQoecK3FXxOhy6C/Pa2tulBoxNEAk6gkrkdyvqUvd5izsF/+XWkfZnEwRLTDbm
	 WM5O/74dSuoLA==
Date: Fri, 20 Nov 2026 21:53:09 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sasha Levin <sashal@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	linux-kbuild@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] kbuild: build the userspace tools in tools/ with
 the kernel
Message-ID: <awCzNfN-OMesd12z@levanger>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, linux-kbuild@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org
References: <20261112195427.3411746-1-sashal@kernel.org>
 <20261112122347.dbb972627dc856c50eb01cd0@linux-foundation.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112122347.dbb972627dc856c50eb01cd0@linux-foundation.org>

On Thu, Nov 12, 2026 at 12:23:47PM -0800, Andrew Morton wrote:
> On Thu, 12 Nov 2026 14:54:20 -0500 Sasha Levin <sashal@kernel.org> wrote:
> 
> > The userspace programs under tools/ are disconnected from the rest of the
> > kernel's build system. Each has its own makefiles and build framework, and
> > "make" never builds them: apart from the few host tools the build itself needs,
> > such as objtool and resolve_btfids, nothing under tools/ is compiled as part of
> > a kernel build.

As mentioned above, the tools/ tree is not part of Kbuild but
re-implements some of its features in its own way, cp.  commit
6e6ef2da3a28 ("Makefile: add comment to discourage tools/* addition for
kernel builds").

I am sceptical about integration (up to) the whole tools/ tree into the
regular kernel build, even though I like your motivation.  I try to
review the patches within the next week.


> [...]
[...]
> 
> From a high level, I think all this happens because selftests are
> considered "out of tree" for kbuild purposes.

Why _are_ the selftest modules built as out-of-tree modules?  Might it
make things easier to build them in-tree instead, or is there a good
reason to keep it the way it is?

-- 
Nicolas
