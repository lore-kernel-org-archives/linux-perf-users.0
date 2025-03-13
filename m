Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A12C1F417E;
	Thu, 13 Mar 2025 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897213; cv=none; b=TNyYIVMYKgEodsWH2v75mafsY352xxXxBvBcqbN51gh1D6aGpJrO5woANXN6B9u9sKslb8rdZNex4ztoD47JhkMszwHiC0KrrsAIRY7caF9dHPr7xut0Z/c1nTNxNn1XmN0TH8JvKwvVXwWf8hiWBdWjDDMGcxv3BdXdzlh158Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897213; c=relaxed/simple;
	bh=7PeCj+W4btHHKEEgyWVcs04k5u5DYkGktv3w5M/oHMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGMDeMo7jqueghwToFo55G0N2opoNJBgXSbXsPPPsPiFBUsPMARu9FcBdToNc/7GGGU7g3Q1oBZ2f85laGdYAgLQXmeDFG2BOmc8eCZY5ppW7JfHuqs2BHJGF9XRDsQX+xhhyjWSl+4GGzQhLnT+hk375pgegB9vODC1sUQFM5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyjZmA1S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyjZmA1S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045BAC4CEE3;
	Thu, 13 Mar 2025 20:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741897212;
	bh=7PeCj+W4btHHKEEgyWVcs04k5u5DYkGktv3w5M/oHMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DyjZmA1Sv+IEeuEtF6WeykYgVhtgrHpisnROviZ79Bes51/ehhkepJm9b30ri/aw2
	 3IGI2vdaL46imyaYjy5dC2z6muRAaVhdPk8Vg5uGxEHnvR16gyiFgfsEQhhba/S7Ix
	 BSUB11Yn1fOJ5/zIvPobTRTnal8ofDK1fmjq91MxpohvmidJctsFPLh0XoIj59acz0
	 wFKK2zDhMr2lrNRMsQriW9rrQaYNBYtuZ4bjPwkGOUHDKCy6fBNVqOiGIa902KoClS
	 NwcTEv7WgS/fCcDHfKVBs6rnhJ1Fq/h63yCB/+JoqbsrRtYSn/v9ZjVgFaHJ8p6f+V
	 1U8RMUKskYSpw==
Date: Thu, 13 Mar 2025 17:20:09 -0300
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
Message-ID: <Z9M9-YhDJg3NgiUy@x1>
References: <20250308003209.234114-1-irogers@google.com>
 <Z9KFLGpenwOP32q3@google.com>
 <Z9M24AJzui9lFbGo@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9M24AJzui9lFbGo@x1>

On Thu, Mar 13, 2025 at 04:49:52PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Mar 13, 2025 at 12:11:40AM -0700, Namhyung Kim wrote:
> > On Fri, Mar 07, 2025 at 04:31:58PM -0800, Ian Rogers wrote:
> > > This work builds on the clean up of system call tables and removal of
> > > libaudit by Charlie Jenkins <charlie@rivosinc.com>.
> > > 
> > > The system call table in perf trace is used to map system call numbers
> > > to names and vice versa. Prior to these changes, a single table
> > > matching the perf binary's build was present. The table would be
> > > incorrect if tracing say a 32-bit binary from a 64-bit version of
> > > perf, the names and numbers wouldn't match.
> > > 
> > > Change the build so that a single system call file is built and the
> > > potentially multiple tables are identifiable from the ELF machine type
> > > of the process being examined. To determine the ELF machine type, the
> > > executable's maps are searched and the associated DSOs ELF headers are
> > > read. When this fails and when live, /proc/pid/exe's ELF header is
> > > read. Fallback to using the perf's binary type when unknown.
> > 
> > Now it works well for me!
> 
> Its working for me on x86_64 as well, I'm doing some more tests, the
> container builds and will do 32-bit tracing on 64-bit ARM (rpi5 aarch64)
> and then report results here, should be later today as the default
> kernel for the rpi5 doesn't come with CONFIG_FTRACE_SYSCALLS=y and BTF,
> so building one with it.

Still building, but noticed this on x86_64:

105: perf trace enum augmentation tests                              : FAILED!
106: perf trace BTF general tests                                    : FAILED!
107: perf trace exit race                                            : Ok
108: perf trace record and replay                                    : FAILED!


The first doesn´t help that much with verbose mode, haven't checked if
before this series it was failing :-\

root@x1:~# perf test -vvv 105
105: perf trace enum augmentation tests:
--- start ---
test child forked, pid 19411
Checking if vmlinux exists
Tracing syscall landlock_add_rule
---- end(-1) ----
105: perf trace enum augmentation tests                              : FAILED!
root@x1:~#

Ditto for 106:

root@x1:~# perf test -vv 106
106: perf trace BTF general tests:
--- start ---
test child forked, pid 19467
Checking if vmlinux BTF exists
Testing perf trace's string augmentation
Testing perf trace's buffer augmentation
Buffer augmentation test failed
---- end(-1) ----
106: perf trace BTF general tests                                    : FAILED!
root@x1:~# 

108 works when its the only test:

root@x1:~# perf test 108
108: perf trace record and replay                                    : Ok
root@x1:~# perf test 108
108: perf trace record and replay                                    : Ok
root@x1:~# perf test 108
108: perf trace record and replay                                    : Ok
root@x1:~#

I'll try to check what is happening with the first two later today.

- Arnaldo
