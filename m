Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D3929CE8;
	Mon, 17 Mar 2025 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742246393; cv=none; b=hC6B+iErIJnUQlp45/nLa9r2XRIt2YkWHFRdrLS2DG6TWzrULAebql1a9L5RNreS7motYMahJBtbsi7VbyuGJnXJ3KYflTdzBFp+OYzK/ov0UEzbLMTzgnBiNneKRad9dpYN/KvVs9Ipkp4tAX9a0tTD5Zy7mI1B5cnfKeppgH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742246393; c=relaxed/simple;
	bh=sJ6V7jkkaFv6f6/KnI1DYggtxUE5WU7pJdhow50px1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RG779OMAiqt7Qqzy7Up8E6IA0jjHPKF9yZ2N4vN6SONmy+7tqUfczH4CPPEuo/LBFLuJxogpezi15mEs6osh/DKjUmA2UsPFdraI10ZTQmtPKAdnrWomYxUd/VNWse4FaPn5pZY+/NuaU18vLbkvj1eQFiGX4IOVRAueYN4DoeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWCv+zb6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWCv+zb6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8C8C4CEE3;
	Mon, 17 Mar 2025 21:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742246392;
	bh=sJ6V7jkkaFv6f6/KnI1DYggtxUE5WU7pJdhow50px1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EWCv+zb65t1erf7mNp1n3wlDSg7N1Ehr3MtQYr69qMkJx4fNJ9PsNwrjwE69hGJ3Q
	 y0c6PtQGJ9sZOHq564nBFC53Y03F56F5/t5PKQfLk7/EFiuvUKHPH4Lg3xMu6WHEkN
	 MP41himlDFtUSaLWdxHAH8lIBoz/00EqeX9VaIMZ59jFuxig/TycEOxsPy43dq7WEN
	 /XUwcJQWoGM6q4JMjDTiMcbE4nADwtjGimkee72dcNZZkRhPfjEgo17vQB2AQ1OqYO
	 dCtrOhP7C0RKkIYVtstp3RjOjs2YTICgixi7y9HsuY7KnSkdy16WlvZ8zz8G0cKaNn
	 ZOaRpmBdUssrA==
Date: Mon, 17 Mar 2025 18:19:50 -0300
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
Message-ID: <Z9iR9iocSKg0SPph@x1>
References: <20250308003209.234114-1-irogers@google.com>
 <Z9KFLGpenwOP32q3@google.com>
 <Z9M24AJzui9lFbGo@x1>
 <Z9M9-YhDJg3NgiUy@x1>
 <Z9NEX3j_1RUvaFI0@x1>
 <Z9PCjQ8PhOadVGQ8@google.com>
 <Z9RjHpEJGWtj8PAM@x1>
 <Z9iKhwoj1GXvH4c9@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9iKhwoj1GXvH4c9@x1>

On Mon, Mar 17, 2025 at 05:48:10PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Mar 14, 2025 at 02:10:54PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, Mar 13, 2025 at 10:45:49PM -0700, Namhyung Kim wrote:
> > > On Thu, Mar 13, 2025 at 05:47:27PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Thu, Mar 13, 2025 at 05:20:09PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > Still building, but noticed this on x86_64:
> > > > > 
> > > > > 105: perf trace enum augmentation tests                              : FAILED!
> > > > > 106: perf trace BTF general tests                                    : FAILED!
> > > > > 107: perf trace exit race                                            : Ok
> > > > > 108: perf trace record and replay                                    : FAILED!
> > > > > 
> > > > > 
> > > > > The first doesn´t help that much with verbose mode, haven't checked if
> > > > > before this series it was failing :-\
> > > > > 
> > > > > root@x1:~# perf test -vvv 105
> > > > > 105: perf trace enum augmentation tests:
> > > > > --- start ---
> > > > > test child forked, pid 19411
> > > > > Checking if vmlinux exists
> > > > > Tracing syscall landlock_add_rule
> > > > > ---- end(-1) ----
> > > > > 105: perf trace enum augmentation tests                              : FAILED!
> > > > > root@x1:~#
 
> This one is now ok:
 
>      0.004 ( 0.000 ms): perf/200342 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_NET_PORT, rule_attr: 0x7ffd649bd0d0, flags: 45) = -1 EINVAL (Invalid argument)
> root@number:~# perf test enum
> 105: perf trace enum augmentation tests                              : Ok
> root@number:~#
 
> now looking at:
 
> root@number:~# perf test -vvvvvvvvv 106
> 106: perf trace BTF general tests:
> --- start ---
> test child forked, pid 200467
> Checking if vmlinux BTF exists
> Testing perf trace's string augmentation
> String augmentation test failed
> ---- end(-1) ----
> 106: perf trace BTF general tests                                    : FAILED!
> root@number:~#
 
> No clue from the test, reading its source code now to see where it is
> failing to try and reproduce the problem.

root@number:~# rm -f /tmp/1234567 ; touch /tmp/1234567 ; perf trace -e renameat* --max-events=1 -- mv /tmp/1234567 /tmp/abcdefg
         ? (         ): mv/200698  ... [continued]: renameat2())                                        = -1 EEXIST (File exists)
root@number:~# 

At this point it works:

⬢ [acme@toolbox perf-tools-next]$ git log -1
commit 58f4f294b358861adaee68dfd19da1060058ec27 (HEAD)
Author: James Clark <james.clark@linaro.org>
Date:   Mon Jan 6 16:42:58 2025 +0000

    perf test trace_btf_general: Fix shellcheck warning


root@number:~# rm -f /tmp/1234567 ; touch /tmp/1234567 ; perf trace -e renameat* --max-events=1 -- mv /tmp/1234567 /tmp/abcdefg
     0.000 ( 0.006 ms): mv/218282 renameat2(olddfd: CWD, oldname: "/tmp/1234567", newdfd: CWD, newname: "/tmp/abcdefg", flags: NOREPLACE) = -1 EEXIST (File exists)
root@number:~#

Seems like some transient problem on this test machine, didn't manage to
bisect and now everything seems to work:

Well, not always :-\

root@number:~# perf test 105 106 107 108 
105: perf trace enum augmentation tests                              : Ok
106: perf trace BTF general tests                                    : Ok
107: perf trace exit race                                            : Ok
108: perf trace record and replay                                    : Ok
root@number:~# perf test 105 106 107 108 
105: perf trace enum augmentation tests                              : Ok
106: perf trace BTF general tests                                    : Ok
107: perf trace exit race                                            : Ok
108: perf trace record and replay                                    : Ok
root@number:~# perf test 105 106 107 108 
105: perf trace enum augmentation tests                              : FAILED!
106: perf trace BTF general tests                                    : FAILED!
107: perf trace exit race                                            : Ok
108: perf trace record and replay                                    : Ok
root@number:~# perf test 105 106 107 108 
105: perf trace enum augmentation tests                              : FAILED!
106: perf trace BTF general tests                                    : FAILED!
107: perf trace exit race                                            : Ok
108: perf trace record and replay                                    : Ok
root@number:~# perf test 105 106 107 108 
105: perf trace enum augmentation tests                              : FAILED!
106: perf trace BTF general tests                                    : FAILED!
107: perf trace exit race                                            : Ok
108: perf trace record and replay                                    : Ok
root@number:~# perf test 105 106 107 108 
105: perf trace enum augmentation tests                              : FAILED!
106: perf trace BTF general tests                                    : FAILED!
107: perf trace exit race                                            : Ok
108: perf trace record and replay                                    : Ok
root@number:~# perf test 105 106 107 108 
105: perf trace enum augmentation tests                              : Ok
106: perf trace BTF general tests                                    : FAILED!
107: perf trace exit race                                            : Ok
108: perf trace record and replay                                    : Ok
root@number:~# for test in 105 106 107 108 ; do perf test $test ; done
105: perf trace enum augmentation tests                              : FAILED!
106: perf trace BTF general tests                                    : FAILED!
107: perf trace exit race                                            : Ok
108: perf trace record and replay                                    : Ok
root@number:~# for test in 105 106 107 108 ; do perf test $test ; done
105: perf trace enum augmentation tests                              : FAILED!
106: perf trace BTF general tests                                    : FAILED!
107: perf trace exit race                                            : Ok
108: perf trace record and replay                                    : Ok
root@number:~#

So, overall, I think this should land and we should continue trying to
figure out how to find out about the above failure cases, probably the
perf trace cases, since they do set up BPF programs, etc should be done
serially?

Doesn't seem to be the case:

root@number:~# for test in 105 106 107 108 ; do perf test --sequential $test ; done
105: perf trace enum augmentation tests                              : FAILED!
106: perf trace BTF general tests                                    : Ok
107: perf trace exit race                                            : Ok
108: perf trace record and replay                                    : Ok
root@number:~# for test in 105 106 107 108 ; do perf test --sequential $test ; done
105: perf trace enum augmentation tests                              : FAILED!
106: perf trace BTF general tests                                    : Ok
107: perf trace exit race                                            : Ok
108: perf trace record and replay                                    : Ok
root@number:~# perf test --sequential 105 106 107 108
105: perf trace enum augmentation tests                              : FAILED!
106: perf trace BTF general tests                                    : Ok
107: perf trace exit race                                            : Ok
108: perf trace record and replay                                    : Ok
root@number:~# 

But then if that is the case it needs some love and care to deal with
other BPF users in the system, being more graceful in the face of
errors.

- Arnaldo
