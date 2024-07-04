Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E518C49651;
	Thu,  4 Jul 2024 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720122742; cv=none; b=gJOfeAZtVeWRpsTmsOAz9QOa2Kct/Z2ERXavM1N5o4/gdh9XfG02WNM8b89WdW7yzNTPZyaWBR8YvFarBZ8feAhwhrmXewrgBQ3U094Ck1ZAuamCfE8BdRvqme2aJUwOUaH3noi5L+FM2HZow8nFtOIgvDvbfrYUOP2rwCGSeBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720122742; c=relaxed/simple;
	bh=6WXvQo6kRdj87G0jhRdVG/LsxAhRQHBo6r3OrEE4cCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oK+POtoQeVMnhf5VFfQQu+3pmY9JxQbseqExhk/5MXt9T5IaYwO39s+6CeGB6lxhJ+WT7VPGYI5zVG+avKpBo0TLonJTOwzaZs40Wr2nyEy5HbN0rfgJzWdG6teyGxnwmrKFT7M7wDRRWhPDgS22WIPLJwT4F7JGLovujcokfFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEIMj64/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEIMj64/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209EEC3277B;
	Thu,  4 Jul 2024 19:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720122741;
	bh=6WXvQo6kRdj87G0jhRdVG/LsxAhRQHBo6r3OrEE4cCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qEIMj64/qpo1Zzcas+jnbWBfccrie0ziJ1AfTB3pIOrbmGLRthUbNvO54c0s7zMUY
	 fIOVxAb3rlzoRt0Xa9qxJUNb6INVv7XG4O2k2sitk1QCLAYfD+rBlrUMks5Ea5HfiE
	 yArG7Lfg+oey2Ardg4hE/vf4ZzLxZ9w6MWBwwVq8HjmMIvVLNLHYNWy8KRab57JDwt
	 6b5BDG/ydd7bpgMK9frzOakFCVaZQ6q+onJSYmDqETn9gFdgwpMRcpQGeJNvscyVUV
	 r5264GHX5+rCYjW+yDTL180idqNBBpeIJtYppgcXiNaqOKVH8ExaspUhO4F5lIxCZV
	 ACCUEHVp9UnUw==
Date: Thu, 4 Jul 2024 16:52:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] perf trace: Augment enum arguments with BTF
Message-ID: <Zob9c18uzVA__jPi@x1>
References: <20240704124354.904540-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240704124354.904540-1-howardchu95@gmail.com>

On Thu, Jul 04, 2024 at 08:43:46PM +0800, Howard Chu wrote:
> Changes in v4:
> 
> - Fix landlock workload's build error.

Can you please take a look at what is at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf_trace-btf_enum

?

I have it building on my set of containers, so far:

perfbuilder@number:~$ export BUILD_TARBALL=http://192.168.86.42/perf/perf-6.10.0-rc3.tar.xz
perfbuilder@number:~$ time dm
   1    97.75 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-22) , clang version 17.0.6 (Red Hat 17.0.6-1.module_el8.10.0+3757+fc27b834) flex 2.6.1
   2    99.92 almalinux:9                   : Ok   gcc (GCC) 11.4.1 20231218 (Red Hat 11.4.1-3) , clang version 17.0.6 (AlmaLinux OS Foundation 17.0.6-5.el9) flex 2.6.4
   3   116.11 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1 flex 2.6.4
   4   115.06 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1 flex 2.6.4
   5    97.46 alpine:3.17                   : Ok   gcc (Alpine 12.2.1_git20220924-r4) 12.2.1 20220924 , Alpine clang version 15.0.7 flex 2.6.4
   6: alpine:3.18

And that is what I'm planning to have merged into perf-tools-next, for
6.12, as soon as the next merge window closes.

Tomorrow I'll not be able to participate on the perf-tools Office hours,
I´ll be starting a two week long vacation, I'll be able to reply to some
messages occasionally and if needed do any GSoC procedure step.

Best regards,

- Arnaldo
 
> Changes in v3:
> 
> - Add trace__btf_scnprintf() helper function
> - Remove is_enum memeber in struct syscall_arg_fmt, replace it with 
> btf_is_enum()
> - Add syscall_arg_fmt__cache_btf_enum() to cache btf_type only
> - Resolve NO_LIBBPF=1 build error
> - Skip BTF augmentation test if landlock_add_rule syscall and LIBBPF are not
> available
> - Rename landlock.c workload, add a comment to landlock.c workload
> - Change the way of skipping 'enum ' prefix
> - Add type_name member to struct syscall_arg
> 
> Changes in v2:
> 
> - Add trace_btf_enum regression test, and landlock workload
> 
> v1:
> 
> In this patch, BTF is used to turn enum value to the corresponding
> enum variable name. There is only one system call that uses enum value
> as its argument, that is `landlock_add_rule()`.
> 
> Enum arguments of non-syscall tracepoints can also be augmented, for
> instance timer:hrtimer_start and timer:hrtimer_init's 'mode' argument.
> 
> 
> 
> Arnaldo Carvalho de Melo (2):
>   perf trace: Introduce trace__btf_scnprintf()
>   perf trace: Remove arg_fmt->is_enum, we can get that from the BTF type
> 
> Howard Chu (6):
>   perf trace: Fix iteration of syscall ids in syscalltbl->entries
>   perf trace: BTF-based enum pretty printing for syscall args
>   perf trace: Augment non-syscall tracepoints with enum arguments with
>     BTF
>   perf trace: Filter enum arguments with enum names
>   perf test: Add landlock workload
>   perf test trace_btf_enum: Add regression test for the BTF augmentation
>     of enums in 'perf trace'
> 
>  tools/perf/builtin-trace.c               | 229 ++++++++++++++++++++---
>  tools/perf/tests/builtin-test.c          |   1 +
>  tools/perf/tests/shell/trace_btf_enum.sh |  61 ++++++
>  tools/perf/tests/tests.h                 |   1 +
>  tools/perf/tests/workloads/Build         |   2 +
>  tools/perf/tests/workloads/landlock.c    |  38 ++++
>  tools/perf/trace/beauty/beauty.h         |   1 +
>  tools/perf/util/syscalltbl.c             |   7 +
>  tools/perf/util/syscalltbl.h             |   1 +
>  9 files changed, 317 insertions(+), 24 deletions(-)
>  create mode 100755 tools/perf/tests/shell/trace_btf_enum.sh
>  create mode 100644 tools/perf/tests/workloads/landlock.c
> 
> -- 
> 2.45.2
