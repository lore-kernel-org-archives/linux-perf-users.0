Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ADA4CB5B;
	Tue,  4 Feb 2025 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697640; cv=none; b=WCuJCMM52lwB+OAqPqtFtyqJMRWMZjZAloSExW/JwFwVSOQQK1Ph3s+N5lp5z3FwDFEgErRL0DfjnubteMtD2e0IdZbjxxR9AlnaGhOjJYAaQwtilePqfW2jG7HTpkTndh16SZaU4DPk1pbjt8utVNHw4J9h9/WtaIbhuu8MePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697640; c=relaxed/simple;
	bh=58yFNr7ClvRQHRC03uxlYrcj9NoegSe4a6JsWMk6y4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BO971rQkOkxnu96irL81Qh99pEU2hCJep+E21B/UkGe0j46qVwl4JUsvTB0Mfgt5C0KzKwXVdE2q2VIte95rfhxC3pGuQt5UcrCFXLEXhZbzUruI1YgL4m2HM/tl683f4AWgrPX2JluyHjNojdQb2NKa3o81dW6KzQGwSjjenNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOsrjP7U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOsrjP7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C27C4CEDF;
	Tue,  4 Feb 2025 19:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738697640;
	bh=58yFNr7ClvRQHRC03uxlYrcj9NoegSe4a6JsWMk6y4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOsrjP7UvMkuRwKJEmzxhOe4rX1fLWG2XIRU+EJu3yqUQMDqz1xosTUMYKR5JVCtN
	 SPD2rLaSh10jhA4+WjxZFpXq/lRh7/dN2iSvxupzHfSi6BNquXmPO0XzDwHDQEQEuy
	 oWXMaXr/d2tvTKbnroeKJoNAFD5wE2LOLLPQ6JMoRB0NaqmJt2vp6ZIQSeGXvTy58z
	 YSi3uchWOlF7a5A4PiBKJTyw5Puuzjtrtgj7ntg1SgQoLsdcZg2D3LEAUaYoRH19N+
	 Rpd+CgcxsUoIWV0m3eE3X5qm3BWuOnwj2wayKZBI7wBI/xvNgmPpBPEx9XSK+Ia33K
	 PqkV6d7i+/Dtg==
Date: Tue, 4 Feb 2025 11:33:57 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>, Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v4 26/39] unwind_user/sframe: Enable debugging in uaccess
 regions
Message-ID: <20250204193357.wdlram4qfghccre6@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <990b28ae7855b67c5e6d6385b9de78ffa336dd73.1737511963.git.jpoimboe@kernel.org>
 <b0193d69-d328-432d-86af-54fac7cef711@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0193d69-d328-432d-86af-54fac7cef711@linux.ibm.com>

On Thu, Jan 30, 2025 at 05:38:24PM +0100, Jens Remus wrote:
> Add a similar debug message for SFRame FDE user copy failures?
> 
> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> 
> @@ -125,6 +125,7 @@ static __always_inline int __find_fde(struct sframe_section *sec,
>         return 0;
> 
>  Efault:
> +       dbg_sec_uaccess("fde usercopy failed\n");
>         return -EFAULT;
>  }

Indeed.

> Printing the IP is probably not an option due to security concerns?
> Printing the the CFA, FP, and RA offsets is too much traffic?  To debug
> issues on s390 I had to add tons of additional debug messages to make
> sense of what was actually going on.

I guess it depends on what you're trying to debug.  These messages are
intended to help diagnose problems with the section format.  It gets
unloaded if any of these errors are detected, so it helps to try to
communicate why that happened.

So yeah, they're intended to be very low traffic, only used for errors
where an .sframe section is getting unloaded (i.e., all the -EFAULTs).

Corrupt CFA/FP/RA offset values are harder to detect, that could also be
related to some other issue like stack corruption.

-- 
Josh
