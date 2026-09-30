Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C4E51DB00;
	Wed, 30 Sep 2026 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793282; cv=none; b=WYyoGiN4LZcjwEaU51pdWgryuXeNiw9FSyNoX+gmepAwjXmce0tgUKAO0TkEKEJNHXNtSMMd9lRsunZIxi6p4KP9VBNN0x1wmJ2i6YAabPI9917gu74spe1TnFo3kpMGJpngBaQxCs2DmOMicvlQ0TPzngwAizzFYJLiF3McpxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793282; c=relaxed/simple;
	bh=iOA+hljNgTQlV2FjRZi4idRNoL5x5N6Iw0ZTJsLCnTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcN7OoWI2RaZpLv6RlTWRGQhOOVGNuz3hr2x4AqTXw8a+XQA1nHVCeoXPb5AmxEGNu9NIIQZMu2CJvfs/6Por+DeJgDrIYq9Iz2jUw7wax9Zsy+Dk01Xo1xqnOGmAMasn+fpbPYxYJLpulunbXyUnutaWUNb8rolo0dDVsv2ny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUDlo7R1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUDlo7R1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4BA1F00898;
	Wed, 30 Sep 2026 18:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790793281;
	bh=G5p+tUbbQAtboTNnRK5POtLjO0iVgmPQ96HsfkMVQUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SUDlo7R1KqV6QtBN+saj8qCmv5hoD27SigoYqKnlgZfhiwWGqJZKwCP8YVivvGjWv
	 dcRkzaEqf2yQ5JTr4ENqPB9mrlRNSALz5OGXBgu5gvj7eO7OyfJmWguOb+c27QTH3H
	 ETsV/cB+OPr7R7zmBd7gZVlUunmQWtFXPIB1l2PldytkEncE6upfafvyh9xmY1qpYv
	 Bynno+NPNe86WE16mkm7hN/lfd1SZO41jL0hxC3CPfxvQsBGwmgcIviMaNm5D5i1sb
	 MfUZntQuxBu9zO2b7x1Z3o7+fic81gqE1VQMenl5CTFO7yrmJnlRaK1boj7HuLegv/
	 j4Od2RYmXyhTA==
Date: Wed, 30 Sep 2026 20:34:37 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/26] perf trace: Bounds check augmented arguments
 before reading them
Message-ID: <ar1WPTMpXCd0FbYp@x2>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-5-irogers@google.com>
 <tmdefnif2mxxe6ul2ljhofoma6dm6ljymkdzcws4o6p5ozxtro@ragt2whqbwap>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tmdefnif2mxxe6ul2ljhofoma6dm6ljymkdzcws4o6p5ozxtro@ragt2whqbwap>

On Wed, Sep 30, 2026 at 02:20:43PM -0400, Aaron Tomlin wrote:
> On Mon, Sep 28, 2026 at 11:25:43AM -0700, Ian Rogers wrote:
> > syscall_arg__scnprintf_buf() and syscall_arg__scnprintf_augmented_string()
> > trust the augmented arg's size, so a bad one reads out of bounds:
> > 
> >   #3 0x4c0fa0 in syscall_arg__scnprintf_buf builtin-trace.c:1955
> >   #4 0x4c2f3d in syscall_arg_fmt__scnprintf_val builtin-trace.c:2632
> >   #5 0x4c33ae in syscall__scnprintf_args builtin-trace.c:2722
> >   #6 0x4c43d3 in trace__sys_enter builtin-trace.c:3094
> >   #7 0x4c7865 in trace__handle_event builtin-trace.c:4013
> > 
> > Move the check in btf_struct_scnprintf() to a helper,
> > syscall_arg__augmented_args_valid(), and use it in both. When the check
> > fails, syscall_arg__scnprintf_filename() now falls back to vfs_getname or
> > the pointer.
> 
> Thank you Ian.
> 
> Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

Added to the cset.

Thanks,

- Arnaldo
