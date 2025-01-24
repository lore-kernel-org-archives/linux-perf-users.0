Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC961ADC80;
	Fri, 24 Jan 2025 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737738462; cv=none; b=vGjO/3tPLTtMCaC+d0V9ojzVqNQZLhUsva/IByVreukffDOMbJVqkz+k3Qs2ydrM/vrjEdPsGn9GLUC2a4OvlneOtuQUpbdFPJ6fNynjMwyLHymUxt6WmbiaSCZrlbnVz60BYogZdrn0Bt3h+5oKggX4WJ9FqVs8wfAtQ07FvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737738462; c=relaxed/simple;
	bh=E1bAFitXybHEtPZ8TCHNUgsLNVAC56dGNsXImLjMDus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThJQL5N0Ep4KmW+cFVCTttiFJ3dZyy4+fQAaXzoOtPz/DJGmklgbgXaC96He/lt4xtL+DCr57D7MQXTU9zRQCs0db5q7ifwxI0Iary6Js7Gmt8NnNz2xaeQdnFkw9yoisuQWrjAOVgWhlF7MtyDsAi5qIA3xuuslqAvdE0BNlMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsUqJYOO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsUqJYOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B0EC4CED2;
	Fri, 24 Jan 2025 17:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737738461;
	bh=E1bAFitXybHEtPZ8TCHNUgsLNVAC56dGNsXImLjMDus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EsUqJYOOy4u8WUE7j7LPKgePgwgPJhPajin/NGO/AoneOUpc9H4cveQzIAQha/ljH
	 FuYY3vk1lDLh1fDPaxV9vmkK/FOC1F8IS5lHw7JdQsrPla8r/budJZoIAtncL35lq+
	 hmP8hOBZzO9Fpx7rZ1Yn8UcrQ8Aosx5KIqgpoEZJtru0s2cCubkDKD4wEZ2BYDBRT3
	 JA4wXHjbEmEBUpO764MpgoZmPOPs2bPpA2m+u4TZIL2eDQyhGpD9bKMRbButZ0eguZ
	 vPO1mW5Argey2fpRkTSf+WzRZ5NJG3RijebyB8UzP46DF4ApTIolJHCF4O8lOyY9Ch
	 OaTRIXDYWE8Kw==
Date: Fri, 24 Jan 2025 09:07:39 -0800
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
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 19/39] unwind_user/sframe: Add support for reading
 .sframe contents
Message-ID: <20250124170739.e3uzaoggmumhl2cq@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org>
 <4379b9c6-e896-4ea4-a4a5-9c6b3c9f2f75@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4379b9c6-e896-4ea4-a4a5-9c6b3c9f2f75@linux.ibm.com>

On Fri, Jan 24, 2025 at 05:36:38PM +0100, Jens Remus wrote:
> On 22.01.2025 03:31, Josh Poimboeuf wrote:
> 
> > diff --git a/include/linux/sframe.h b/include/linux/sframe.h
> 
> > @@ -3,11 +3,14 @@
> >   #define _LINUX_SFRAME_H
> >   #include <linux/mm_types.h>
> > +#include <linux/srcu.h>
> >   #include <linux/unwind_user_types.h>
> >   #ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
> >   struct sframe_section {
> > +	struct rcu_head	rcu;
> > +
> 
> Nit: You are adding a blank line, that you later remove with
> "[PATCH v4 25/39] unwind_user/sframe: Show file name in debug output".

I suppose that was intentional.  The original blank line created visual
separation between the rcu head and the sframe values.  The later patch
instead sort of uses the ifdef to keep some separation?  But yeah, I'll
keep the blank lines for consistency.  <shrug>

struct sframe_section {
	struct rcu_head	rcu;

#ifdef CONFIG_DYNAMIC_DEBUG
	const char	*filename;
#endif

	unsigned long	sframe_start;
	unsigned long	sframe_start;
	unsigned long	sframe_end;
	unsigned long	text_start;
	unsigned long	text_end;

	unsigned long	fdes_start;
	unsigned long	fres_start;
	unsigned long	fres_end;
	unsigned int	num_fdes;

	signed char	ra_off;
	signed char	fp_off;
};

-- 
Josh
