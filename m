Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1F926981E;
	Fri, 25 Apr 2025 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593798; cv=none; b=fWkLRnOtU4byc9aDyPSx254yJ6b8JHrjYPfMx2xipqcSU7q6zONGYDVbmG1Lw1LT7S926xysWOu9vsbxEBEZQ3luDADkpC0Y02ad4ZM3f1rTWydZ/Wyj/lKj8rwOPvBxboPFX/CKeVTBchS/lFUERACSH+nXQR/lA2HpTxP42t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593798; c=relaxed/simple;
	bh=EIBrRW6pSpT48bOHI0PJpzhoy9SNKaPDbB33zZhg9zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J188aStFCa5ux6PeYaiD+ld//sgjXpT8d3qw3PfSYSMo+d1tPWETpJj6i10I6Wt9TjqM+R8abSKBo6co/wiyhlXC7CL97gKAyULeUrukNXEJjJKoZuH2FOE2QgN+Sk2i6VVr1KmkJpey+8fzzquAFN2OnAuzLi3H+b1NXmfT6c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppB35Oe/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppB35Oe/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20ABCC4CEE4;
	Fri, 25 Apr 2025 15:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745593798;
	bh=EIBrRW6pSpT48bOHI0PJpzhoy9SNKaPDbB33zZhg9zM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppB35Oe/DmhNr2hEVw/NY+7HiZtvS/xyR2bqhIizqs4G9DxLEmqa9a99XaTPKNKi1
	 zGQFCrU4DXoGOnanl9SzoJt5U3yaKrcS2lygDpaIIOAahn4EX/amkLBsF3BKeGQpey
	 R4QZrf68zhVdYsWL+K2gIsVRj9Bjp5NTJe/RS56QEzeUNDU/LAy2b+N9i7ROC8+7v3
	 egcuaW7eYCutf67+ask/AHtTjUYHKYPR3m0K2gnN29T0TL6/x+z0ewJ10EHEMmAvvz
	 2hGMytBcCZM7ApZB1cGV9QDNi2uO2SpKuu3iALuK+501kxyzikkeSs+NfNkliqC4WQ
	 9JhlSBvoXAZxA==
Date: Fri, 25 Apr 2025 08:09:55 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jens Remus <jremus@linux.ibm.com>, 
	Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>, 
	Blake Jones <blakejones@google.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Alexander Aring <aahringo@redhat.com>
Subject: Re: [PATCH v6 11/18] perf: Use current->flags & PF_KTHREAD instead
 of current->mm == NULL
Message-ID: <2fjdalrdgadbt6kmv7wgbc2vs42ojkwh2vj6yfwlttmoo2rijs@5gtrvow66g7m>
References: <20250425145422.132820147@goodmis.org>
 <20250425145813.518795213@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250425145813.518795213@goodmis.org>

On Fri, Apr 25, 2025 at 10:54:33AM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> To determine if a task is a kernel thread or not, it is more reliable to
> use (current->flags & PF_KTHREAD) than to rely on current->mm being NULL.
> That is because some kernel tasks (io_uring helpers) may have a mm field.

There's a current->mm check in the user space unwinder (patch 1) which
should probably also be converted.

-- 
Josh
