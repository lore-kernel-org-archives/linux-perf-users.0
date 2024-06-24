Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE6213C901;
	Mon, 24 Jun 2024 22:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266790; cv=none; b=hatZzgSalZHCtChgURqb6Ee9GKcdUzNfJBllaRRoaZXCyzvRhTekIm9Ur4Uy0mtVQxA4Sqco/BndPvegNx8eZUV+E2t2pRNo6VR5MNVp8oqefvVbZJkBGqA1sQYdJajVpUX88KooxlUHUP4wdlKXC7tOpSFxCI7PW8DNsFQPGPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266790; c=relaxed/simple;
	bh=v5EkkTErtysweJ6YBb/ej7mjjeGRSkbHCB9ia2QeuFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzvCMBG5EDWm7BBHiHm9jwpBleHBPvBKhb+5wmv6Eu9GFMBjwVb4CMnIRBpOs9XgBEmWicxGa5VUGeV7vH9iuhA042ZG1WhJ561CoknBZiir6DHgHY43w/9NpVDVU3SajYExuwsJATo6TAlVzgl0yQPrwev5IwXB/UzUJVLeCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvjTQ5rg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvjTQ5rg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93567C2BBFC;
	Mon, 24 Jun 2024 22:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719266790;
	bh=v5EkkTErtysweJ6YBb/ej7mjjeGRSkbHCB9ia2QeuFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HvjTQ5rgu3zGt9wN2MRPnEvNll8mjcQ6CS1kmgzj5nt9VOwCAl4HVUoQSiy0WsPZf
	 N+dvkL1GVSMPJCuLXXf0BfueooXspVvUMf3zCUq77PYwkytXL6RTxmuOcMK0kVoNtQ
	 igxE/jSUPkfUPdK3EDumWTuzhXv088yN8ej/ISKT3/vQc1ZEHcWhEiwc/Ci4U45apT
	 d4+/FmnxiSXdVe92T9/RYNhA7y5uQdCODpQ66bv5pUbcNqqLFW9EBCa69e3H4V/AwX
	 R12FM2R2BIoChA2gnOClYF3E3LhMAHgGQclWvn3LcJTOZYQjBrOZWUxU4VJPB4KGXE
	 2AhqYfkPYRI3A==
Date: Mon, 24 Jun 2024 19:06:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] perf trace: Augment enum arguments with BTF
Message-ID: <Znnt4sTOx6ANJZPV@x1>
References: <20240624181345.124764-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624181345.124764-1-howardchu95@gmail.com>

On Tue, Jun 25, 2024 at 02:13:37AM +0800, Howard Chu wrote:
> In this patch, BTF is used to turn enum value to the corresponding
> enum variable name. There is only one system call that uses enum value
> as its argument, that is `landlock_add_rule()`.
> 
> Enum arguments of non-syscall tracepoints can also be augmented, for
> instance timer:hrtimer_start and timer:hrtimer_init's 'mode' argument.
> 
> Changes in v3:

Did a quick test, from a quick look you did the adjustments we agreed
(if (val == 0 && !trace->show_zeros && !arg->show_zero && arg->strtoul
!= STUL_BTF_TYPE), etc), thanks!

And that is the way for collaboration we go on talking on the mailing
list and sometimes writing code, making it available for review and
adopting what we deem best at that point, rinse repeat.

Now I think it would be great if someone like Namhyung or Ian could try
this last patch.

I have to comb thru it but, again, from a quick look and test, it seems
great and probably ready for merging.

Thanks a lot!

- Arnaldo
 
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
>  tools/perf/tests/workloads/Build         |   1 +
>  tools/perf/tests/workloads/landlock.c    |  39 ++++
>  tools/perf/trace/beauty/beauty.h         |   1 +
>  tools/perf/util/syscalltbl.c             |   7 +
>  tools/perf/util/syscalltbl.h             |   1 +
>  9 files changed, 317 insertions(+), 24 deletions(-)
>  create mode 100755 tools/perf/tests/shell/trace_btf_enum.sh
>  create mode 100644 tools/perf/tests/workloads/landlock.c
> 
> -- 
> 2.45.2
