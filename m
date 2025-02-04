Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC08158558;
	Tue,  4 Feb 2025 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699147; cv=none; b=RCfM3CDqU9OD8nq0hBzsiTwLnNhe6IpXV6dANQmP/1JGsbcZ7mD+zKePsnpPZFHbRCpG3pEWobe5PisSK0cJLIleiquCXYnQ798v5USz6PLIVuMmzdTO41U7Ki+5qPRBXEQLF4Rzj1jadeQYu+tRZXWWtABjJZeUIvAt3WpZ8hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699147; c=relaxed/simple;
	bh=IWzaGhk9Qj3LEU460SqdAUhaJoZcr4o4neZbqWa19nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABRwzrUssnk0IPpfWHH1BrEV7mnH1gKK78DaZB8XRIi3F1AemsXixwlh1N4/JFZojrGTcONxwAwryyLchM17QGkBhXMnjC3glv3iGu9CCtV5rsSbDGnUcOXVF4Bef3UFFaNvoSULsdnBxoct0bO6eMW7hTFOVbC7XsssLMK7cU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpKje2qv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpKje2qv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB149C4CEDF;
	Tue,  4 Feb 2025 19:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699146;
	bh=IWzaGhk9Qj3LEU460SqdAUhaJoZcr4o4neZbqWa19nI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JpKje2qvF9+lpyx85m42wOB+O30DF/jhcA51qBnG6Q9VfTe+ESYpESWcO4KhStBfZ
	 pHkfFWrNs2efVBgcACh1sm4A77mSuFi9S4zdfd1NqApH6RASS+xX7gk/AKTRpFegRo
	 PulXQKnLnWQlxj7hDpZ3o1oyek7+kumFhhaFlEgCtTiPhDRtqGdKx6H9yvdphFpk6A
	 QBsZhb/Q5DlTzNuhbWoKUo9ilMLAQ2wDjT9EuUDI8XmQFR0KuNF+NZLEzUUiwqL+GL
	 U3D79wKgaPpbWSHGRzEi2Hb7wW/baG0/3ujlN6yiVyxKugJgkRDIdwWikv0JBM2utT
	 YV8GUgm89SWag==
Date: Tue, 4 Feb 2025 11:59:03 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Indu Bhagat <indu.bhagat@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 17/39] unwind_user/sframe: Add support for reading
 .sframe headers
Message-ID: <20250204195903.egpqdseckhfuih2s@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org>
 <CAEf4BzbQGipBq-Ls1=n49nyNoX941Ka13HgXAXLTzGAo9wckAA@mail.gmail.com>
 <20250124192159.ypvqwoqjvhasamev@jpoimboe>
 <47f1e244-992f-44fe-a0a5-6c271e9c719e@oracle.com>
 <CAEf4BzZaWrscT1HrcUJkz45iMMuyCcA6ivfMffeHpxf=LmmXRg@mail.gmail.com>
 <12cef882-b5b2-43e5-9d78-abe4354069dd@oracle.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12cef882-b5b2-43e5-9d78-abe4354069dd@oracle.com>

On Thu, Jan 30, 2025 at 01:21:21PM -0800, Indu Bhagat wrote:
> > Yeah, and it's actually bothering me quite a lot 🙂 I have a tentative
> > proposal, maybe we can discuss this for SFrame v3? Let me briefly
> > outline the idea.
> > 
> 
> I looked at the idea below.  It could work wrt unaligned accesses.
> 
> Speaking of unaligned accesses, I will ask away: Is the reason to avoid
> unaligned accesses performance hit or are there other practical reasons to
> it ?

I think performance is the main concern, though there are still some CPU
arches out there which don't support unaligned accesses.

> Combining the requirements from your email and Josh's follow up:
>   - No unaligned accesses
>   - Sorted FREs
> 
> I would put compaction as a "good to have" requirement.  It appears to me
> that any compaction will mean a sort of post-processing which will interfere
> with JIT usecase.

I think we should still consider the fast lookup table.  We might want
to prototype something just to see what the speedup looks like.  Similar
to compaction it could just be an optional feature implemented by the
linker which JIT doesn't have to use.

-- 
Josh
