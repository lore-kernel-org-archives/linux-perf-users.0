Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA232185BC;
	Tue,  4 Feb 2025 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738694333; cv=none; b=olXQeZQ7dyg0NODZhWUHbLx72GoEqtlS1mtTy86fQHsoWujNUh63QNHma0luwZQnxsW+XOJtMD5PHUbRhXNwF7IgjmK2Tl9YfmKqsBq7WgXfkkpIyZrD6lITIdSoV7rnnu/25cxeH+mG8pVPUtXZAFuHRbMWVNMnuQ48zxKr5K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738694333; c=relaxed/simple;
	bh=qfKEeCtyCwX8cwgD/StYBwedErfhe0C0rQM403/Xl6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S81rZtSAlP8nOEckRfk1ajgH9HW17+quRvJwFzxHjXm8PxihCMudU3fGELjrPpSTsFYp5Nu1+QVfx02gj/E61Qw5rLP+r2dTtt1VzjBXHfkH9UoDsvMCtfKnzoiM6u/N1e9JLurP6YGaXr/SVfAJDJ+efGTqyLmEbrKIvbRTqM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/+uf8Sj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/+uf8Sj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D5EC4CEDF;
	Tue,  4 Feb 2025 18:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738694332;
	bh=qfKEeCtyCwX8cwgD/StYBwedErfhe0C0rQM403/Xl6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/+uf8SjJJDZOvDZbb6/CCEoO5fsTVxPROiE8hVmJY2MWI66KuD25DreUVXoQuMTC
	 D5FkOeOPwszJD7/ngmL30g8VvQyUwJBrCKrlNbU+MTyWdL5FEC5BUaOd9kN7ullpKZ
	 tkuP6V8rOb20qVy5SBhozHnFhNMXZLe7lJY02c75R3RMSBdESAwF+hwJjD1DZMgoFl
	 0lxXF+yabbmYpf6PvFPgYYbLzEqpGvD7c4zzqhK2nz3U1bjDcNsY+SJ2KO5Wwg67YW
	 j5cOeb6A9oGSmKfuFIgcumJiqMmtaUNt1RD1QzYrkulc34Ik0gR+Qq2j44sCZkapDm
	 ThGLNAUdRunKQ==
Date: Tue, 4 Feb 2025 10:38:47 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Indu Bhagat <indu.bhagat@oracle.com>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
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
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 19/39] unwind_user/sframe: Add support for reading
 .sframe contents
Message-ID: <20250204183847.mr2dnge55simbmkl@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org>
 <3f890bd0-b883-4bd1-a0f1-4cf78db42857@oracle.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f890bd0-b883-4bd1-a0f1-4cf78db42857@oracle.com>

On Thu, Jan 30, 2025 at 07:07:32AM -0800, Indu Bhagat wrote:
> On 1/21/25 6:31 PM, Josh Poimboeuf wrote:
> > +	for (i = 0; i < fde->fres_num; i++) {
> > +		int ret;
> > +
> > +		/*
> > +		 * Alternate between the two fre_addr[] entries for 'fre' and
> > +		 * 'prev_fre'.
> > +		 */
> > +		fre = which ? fres : fres + 1;
> > +		which = !which;
> > +
> > +		ret = __read_fre(sec, fde, fre_addr, fre);
> > +		if (ret)
> > +			return ret;
> > +
> 
> It should be possible to only read the ip_off and info from FRE and defer
> the reading of offsets (as done in __read_fre) until later when you do need
> the offsets. See below.
> 
> We can find the relevant FRE with the following pieces of information:
>   - ip_off
>   - fre_size (this will mean we need to read the uin8_t info in the FRE)

Indeed, I'll skip reading the offsets until after the loop.

-- 
Josh
