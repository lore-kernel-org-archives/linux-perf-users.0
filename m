Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3279205E36;
	Mon, 17 Mar 2025 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244490; cv=none; b=GfmbfrAHw0681TWJG+Z4jnEYF8NmksWgftIGifA1QmaFVLXW7+xYmmWgMn/sWkenvdbEWIGufz55mtv9vrPwMmPqAfDc3w6qtEmnlsianStjswafU3di8Fb550t8zKmctenkengEWrrH2jTbfKCa8b0zKhaA+/Mn8x5We12e8bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244490; c=relaxed/simple;
	bh=8pdTXWSW1pT+VXM+eBfg/U6FahxzWexs17ihcIHPMJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGWtEcnh/YvEtX7dGBXIYdmWgCzIc0FrZVo3uI/O+CPSQxNX69IkpfaWPP6gXjLyaziQyP76w13/pHTPA7X4mWJ49GrbpfMC61vG1qSIjC7EekDAS8j2b9kTN2/d2yhnYTYN3+Plpl1upotX/zMbD9uX/HSSwvRqTMtNFWOX5gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhM8veCq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhM8veCq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A50DC4CEED;
	Mon, 17 Mar 2025 20:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742244490;
	bh=8pdTXWSW1pT+VXM+eBfg/U6FahxzWexs17ihcIHPMJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EhM8veCqfacvRpt+f0Tvr+Tb69xlnreFzyM3CYm4DK4T3+uPl9ru59UEfXTq0ebK0
	 CFqn/N9smSOGJjxnJp8Q7S4i7UImh1Net50w71WOgCOAVzz2OpwFsYRLV+agzk6Z1C
	 3LTvtiRUgukYDcBgUBk5iLbCljivyEw6ZCgak1vig2/flA/wQErtA9Pu1GdpMbJYyz
	 RElF6rdsfJrE/Kj0PJIhJnwP2Q/Uv03S9bGrKUxd3bkKaSRkFnXF6f1oMA2fvj+RKm
	 mxOb9rT8SCANLJJFg+gkynqiThXDC7UvCVYwLN6XBKjkV7uOvLG7zGq8p2g2kCvRgV
	 qUsnEfHJIxt6w==
Date: Mon, 17 Mar 2025 17:48:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	guoren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 00/11] perf: Support multiple system call tables in
 the build
Message-ID: <Z9iKhwoj1GXvH4c9@x1>
References: <20250308003209.234114-1-irogers@google.com>
 <Z9KFLGpenwOP32q3@google.com>
 <Z9M24AJzui9lFbGo@x1>
 <Z9M9-YhDJg3NgiUy@x1>
 <Z9NEX3j_1RUvaFI0@x1>
 <Z9PCjQ8PhOadVGQ8@google.com>
 <Z9RjHpEJGWtj8PAM@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9RjHpEJGWtj8PAM@x1>

On Fri, Mar 14, 2025 at 02:10:54PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Mar 13, 2025 at 10:45:49PM -0700, Namhyung Kim wrote:
> > On Thu, Mar 13, 2025 at 05:47:27PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Thu, Mar 13, 2025 at 05:20:09PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Still building, but noticed this on x86_64:
> > > > 
> > > > 105: perf trace enum augmentation tests                              : FAILED!
> > > > 106: perf trace BTF general tests                                    : FAILED!
> > > > 107: perf trace exit race                                            : Ok
> > > > 108: perf trace record and replay                                    : FAILED!
> > > > 
> > > > 
> > > > The first doesn´t help that much with verbose mode, haven't checked if
> > > > before this series it was failing :-\
> > > > 
> > > > root@x1:~# perf test -vvv 105
> > > > 105: perf trace enum augmentation tests:
> > > > --- start ---
> > > > test child forked, pid 19411
> > > > Checking if vmlinux exists
> > > > Tracing syscall landlock_add_rule
> > > > ---- end(-1) ----
> > > > 105: perf trace enum augmentation tests                              : FAILED!
> > > > root@x1:~#

This one is now ok:

     0.004 ( 0.000 ms): perf/200342 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_NET_PORT, rule_attr: 0x7ffd649bd0d0, flags: 45) = -1 EINVAL (Invalid argument)
root@number:~# perf test enum
105: perf trace enum augmentation tests                              : Ok
root@number:~#

now looking at:

root@number:~# perf test -vvvvvvvvv 106
106: perf trace BTF general tests:
--- start ---
test child forked, pid 200467
Checking if vmlinux BTF exists
Testing perf trace's string augmentation
String augmentation test failed
---- end(-1) ----
106: perf trace BTF general tests                                    : FAILED!
root@number:~#

No clue from the test, reading its source code now to see where it is
failing to try and reproduce the problem.

- Arnaldo
