Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC02F1CB321;
	Tue,  1 Oct 2024 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807737; cv=none; b=j3HTdf5bG3zHP1zfztV/7RYxzp11051ux9NDubLwa6OYOf6XfsSYkCFSs+0usLWZ57Zbe8vr8xlAdJzbEFj2v9snXajCdg4YeohRkR3CENrvQm/V67AtS0N3wXfL2LNK+fapfsKw3+TSGf34Q4GgJqVQayKrZ6DtVNdlGD1px2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807737; c=relaxed/simple;
	bh=2FQsdtksF1hKm/sO3z89H6wen6IaATwa1QglsLLLZdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4d53vmMqJu6kvnu2m0LTRyAye348uo7dtF2ZCGABuo7idUKGPpaNnGjXc2q7OgPFMWQJgXqlmB9ywEjn5klbF7FCxx/VtJ7B+JGKrJ3emOToCOiYIJn4bCYlZL+S3XXrBuln3vwP6nylvVNjpnfnkA+huKV8dkKK1foks/Xn5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E37C4CEC6;
	Tue,  1 Oct 2024 18:35:35 +0000 (UTC)
Date: Tue, 1 Oct 2024 14:36:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Indu Bhagat <indu.bhagat@oracle.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark
 Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, Jordan Rome
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v2 03/11] unwind: Introduce SFrame user space unwinding
Message-ID: <20241001143624.08291d00@gandalf.local.home>
In-Reply-To: <d2e7a4aa-2fd3-4b6f-b6e4-66b11e89d6ae@oracle.com>
References: <cover.1726268190.git.jpoimboe@kernel.org>
	<ca2e603ae3dcfa3e836162ed8c301fd4d9fd4058.1726268190.git.jpoimboe@kernel.org>
	<20240914072358.4afad691@rorschach.local.home>
	<d2e7a4aa-2fd3-4b6f-b6e4-66b11e89d6ae@oracle.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 11:20:35 -0700
Indu Bhagat <indu.bhagat@oracle.com> wrote:

> > So we trust user space to have this table sorted?
> >   
> 
> GNU ld will create this table sorted when linking .sframe sections and 
> will set SFRAME_F_FDE_SORTED in flags in the output .sframe section.  In 
> the current patch, I see the __sframe_add_section () includes a check 
> for SFRAME_F_FDE_SORTED for admitting SFrame sections.
> 
> So proceeding here with the assumption that the SFrame FDE list is 
> sorted should work fine.

No not at all! We *cannot trust* user space. This could lead to a security
hole if we assume it's sorted. The kernel must not trust anything it
receives from user space. Because an attacker will be looking for ways to
confuse the kernel to exploit it.

When I look at code that reads user space, I do not look at it as if it
were made by the compiler. I look at it as if it were made by someone
that's trying to find ways to crack the system. Every read from user space
*must* be validated *every* time it's read. It can not even validate it
once and then think its immutable (unless the kernel actually made it
immutable).

-- Steve
