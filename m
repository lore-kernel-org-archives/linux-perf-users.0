Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A2614EC42;
	Wed, 19 Jun 2024 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805333; cv=none; b=cqbA1UCHWfcStOhxCt72185ROjrmYwOH0YnN3ONjuphpRMcSkPQu+qWEvKPyw/pLFE8UX+sAeLIvmIgWx1WgWiwCO6UznDuxU2u1Kpoe7JkMMFd7mwmJnegABxZ9lwhRAvvLVDfT2MptI7zMxEa5iNVlFy9smkDu9il8BNzzS24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805333; c=relaxed/simple;
	bh=sdrbWJs4C9JSQQPyUxLltmmFFyWY2dENHToMBoBCL3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaBRYxvzLlkNWQ6YfeoBQSSREni9ovkjt+gKZmf/XpYMZO6Aw5otam/2hyTbVjy2HTg22kbXLGKqWFEYK9wAXdFimOBBP1J5AT+pyMA68B9/4ucfK/WRRgm6FfKGLgR3At3ottoBXUt7ENj0Xhvzh334Ux/INrUthAYL3zXyNeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvKc6XLY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvKc6XLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956FAC2BBFC;
	Wed, 19 Jun 2024 13:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718805332;
	bh=sdrbWJs4C9JSQQPyUxLltmmFFyWY2dENHToMBoBCL3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvKc6XLYs5ghjKbTSa0puSbpeDvu1GzKXCuMjf+4VURFWhAhz+ET8UQ7+z9YGWRaa
	 ymwUyXnAlDAj9wcElGWahjWYT/P8ZhOPzPikq4svulM+Re3Vi3LtC19lzK9veo6g9i
	 BbNd2d+f6FGRKq37LEHRTetOFwvMBPArjkc+K9/pYqAHfFhXfT+ggp7E4aBULi4uZm
	 8ltFxh6579SwGSSPy1RXlCsiPVKT73yefPsnrg3DWwdQs68WVNBdELFjCe7IBldmPe
	 TQbbBNh4OTUIjtGKAYhJSXwX82FHCmXWoUIoPLUykEF2s8XEeLHN+cLpCZS0AQa7J+
	 2Eg+AbPxgtaTQ==
Date: Wed, 19 Jun 2024 10:55:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 0/5] perf trace: Augment enum arguments with BTF
Message-ID: <ZnLjT_m90EDtRFE0@x1>
References: <20240619082042.4173621-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619082042.4173621-1-howardchu95@gmail.com>

On Wed, Jun 19, 2024 at 04:20:37PM +0800, Howard Chu wrote:
> changes in v2:
> - Move inline landlock_add_rule c code to tests/workloads
> - Rename 'enum_aug_prereq' to 'check_vmlinux'

Usually the versions descriptions comes at the end, after your signature
line, just before the list of csets in the series.
 
> Augment enum arguments in perf trace, including syscall arguments and
> non-syscall tracepoint arguments. The augmentation is implemented using
> BTF.
> 
> This patch series also includes a bug fix by Arnaldo Carvalho de Melo 
> <acme@redhat.com>, which makes more syscalls to be traceable by perf trace.
> 
> Test is included.

Thanks, the patch submission is now very good, at some point you'll be
able to point to a git tree from where to do a pull, then have it with a
signed tag, etc, all this is not necessary at this point in our
collaboration, but as you evolve as a kernel developer, it eventually
will be asked from you.

And it comes with a test that introduces a 'perf test -w' workload,
super great!

- Arnaldo
 
> Howard Chu (5):
>   perf trace: Fix iteration of syscall ids in syscalltbl->entries
>   perf trace: Augment enum syscall arguments with BTF
>   perf trace: Augment enum tracepoint arguments with BTF
>   perf trace: Filter enum arguments with enum names
>   perf trace: Add test for enum augmentation
> 
>  tools/perf/builtin-trace.c                    | 214 ++++++++++++++++--
>  tools/perf/tests/builtin-test.c               |   1 +
>  tools/perf/tests/shell/trace_btf_enum.sh      |  57 +++++
>  tools/perf/tests/tests.h                      |   1 +
>  tools/perf/tests/workloads/Build              |   1 +
>  .../perf/tests/workloads/landlock_add_rule.c  |  32 +++
>  tools/perf/util/syscalltbl.c                  |   7 +
>  tools/perf/util/syscalltbl.h                  |   1 +
>  8 files changed, 289 insertions(+), 25 deletions(-)
>  create mode 100755 tools/perf/tests/shell/trace_btf_enum.sh
>  create mode 100644 tools/perf/tests/workloads/landlock_add_rule.c
> 
> -- 
> 2.45.2
> 
