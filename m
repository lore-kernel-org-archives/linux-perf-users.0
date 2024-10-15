Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21C9158D9C;
	Tue, 15 Oct 2024 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729024661; cv=none; b=Ta1kC5PtCZKWw/2WDkcuPI9aEU62W0t+N6Bx+jAEivgFNN6AczPh83VOURjS1fyQQLvELUFQz716FFelE12PFF8oPvsdc0jAfcHRWfLFj4vBtantX7Zke5Zx19f7g+Vo3N8fRmozRjKRYreLYTItlOdaFqpTXZQAv/FPCKVvcPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729024661; c=relaxed/simple;
	bh=uPz2K29rBQnQu4jOwz9rFPLvCog9LrME2wH0ycT9U6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfyK1v65wPH4TT7OiaVABMmQj5v6JYnYisQZbEfhW/LX8vy4OsYl9lDJDzWp/8cqs6BmnsAXWGOYvdH8i84YUsCgNGRC9nxXrzZJYYRZtFc5QgMKSxPd7CqGobTtyKFgKRV79bCluLWezlCHIfYaO5Wkv8QRHdXKJqP/e8lltok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orXSbokZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orXSbokZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAFBC4CEC6;
	Tue, 15 Oct 2024 20:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729024661;
	bh=uPz2K29rBQnQu4jOwz9rFPLvCog9LrME2wH0ycT9U6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=orXSbokZXIvrSNTc1oBrnPyZv956fsdhkqE+uqllM7My7zoKylcFZriJqvlMe0kwE
	 Q5XZxp2fltzmNkqHiW/JSlCQzjvrkaWXFPQcjusIwfynadq1d1149KFgSFIViEK1Nq
	 2ZaL8QcM0B3s4JT2HpOKaSFgJbbOhVn/8qcC4ikTgamkDxm/S5lHReh/MhTgo7Wcua
	 DSdfjqydb+VO2y53/NwS7D3rLVRNivO+RM0isLT3ony1Dp/6qtRL+qxLqE03e7iog3
	 SVxljr39WxoEHAS4U4r0QkmCc0DgfWEwli7E6MwMLH9lszn0KPewxbyDrhr8PPB+dB
	 9qf3jc1S6y3wg==
Date: Tue, 15 Oct 2024 17:37:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>, Howard Chu <howardchu95@gmail.com>,
	Andrea Righi <andrea.righi@linux.dev>, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, james.clark@linaro.org,
	alan.maguire@oracle.com
Subject: Re: [PATCH v2 0/2] perf trace: Fix support for the new BPF feature
 in clang 12
Message-ID: <Zw7SkmEaz730uVbL@x1>
References: <20241011021403.4089793-1-howardchu95@gmail.com>
 <Zw61TUe1V97dKWer@google.com>
 <Zw7D9HXBanPLUO4G@x1>
 <Zw7JgJc0LOwSpuvx@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zw7JgJc0LOwSpuvx@x1>

On Tue, Oct 15, 2024 at 04:58:56PM -0300, Arnaldo Carvalho de Melo wrote:
> So I'm trying adding extra bounds checking, marking the index as
> volatile, adding compiler barriers, etc, all the fun with the verifier,
> but got distracted with other stuff, coming back to this now.
 
> Ok, the following seems to do the trick:
 
> [acme@dell-per740-01 perf-tools]$ git diff
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index 3b30aa74a3ae..ef87a04ff8d0 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -486,6 +486,7 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>                                 augmented = true;
>                 } else if (size < 0 && size >= -6) { /* buffer */
>                         index = -(size + 1);
> +                       index &= 7; // To satisfy the bounds checking with the verifier in some kernels
>                         aug_size = args->args[index];
>  
>                         if (aug_size > TRACE_AUG_MAX_BUF)
> 
> I'll now test it without Howard's patch to see if it fixes the RHEL8 +
> clang 17 case.

It works with this one-liner + the simplified patch from Howard and also
on this other system (RHEL9), as well as with Fedora 40, it would be
nice if someone could test with clang 16 and report back the version of
the kernel tested as well as the distro name/release, that way I can try
to get my hands on such as system and test there as well.

Its all at:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tmp.perf-tools

This is the current set of patches that when further tested will go to
Linus for v6.12:

⬢[acme@toolbox perf-tools]$ git log --oneline torvalds/master..
ff14baa7a290bf42 (HEAD -> perf-tools, x1/perf-tools, perf-tools/tmp.perf-tools) perf trace augmented_raw_syscalls: Add more checks to pass the verifier
46180bec048aad85 perf trace augmented_raw_syscalls: Add extra array index bounds checking to satisfy some BPF verifiers
45d1aadac64869a2 perf build: Change the clang check back to 12.0.1
4e21679eb81b5f0d perf trace: The return from 'write' isn't a pid
2d2314d4b09b5ed9 tools headers UAPI: Sync linux/const.h with the kernel headers
⬢[acme@toolbox perf-tools]$

[root@nine ~]# uname -a
Linux nine 5.14.0-427.31.1.el9_4.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Aug 9 14:06:03 EDT 2024 x86_64 x86_64 x86_64 GNU/Linux
[root@nine ~]# perf trace -e *sleep* sleep 1.234567890
     0.000 (1234.742 ms): sleep/80014 clock_nanosleep(rqtp: 0x7ffc55b11240, rmtp: 0x7ffc55b11230)           = 0
[root@nine ~]# clang --version
clang version 17.0.6 (Red Hat, Inc. 17.0.6-5.el9)
Target: x86_64-redhat-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
[root@nine ~]#

- Arnaldo
