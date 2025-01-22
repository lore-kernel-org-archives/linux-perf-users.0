Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8569A4E1CA;
	Wed, 22 Jan 2025 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737553069; cv=none; b=NuPuz53MVcyVP36HwKdM6TGBEoiiTwFNo6ItB03E/qvVtoC1F3ARB+m6m3owNkf+8Klz0jNpM2ehCBFwvbaoGOpH0afZfyAdkuIMq1mxE32OBM8StSh3rij+7t+pc1znLYty7TmrYV4cBjkdYaXmielVf5gm7WqtfykY6KBkS6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737553069; c=relaxed/simple;
	bh=+SnQrDX7dHoUtgNXKETf2ZjXUpSyh12tLuV11g2h/q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=undGyTmISldyrK+OXcZJFGvmXRDzsMum2DajNix5iKxhibtOdAkxQJFxkPNNSjQ6/Z6NoLkP3mNNzXlpdOZMGNBhK84Uz9xAYKCQigub29oCEGwLe968uCAuBusB8ki73Z+dO4EDqJUhtZK9RMbkMMx2W68V8jH6jiE0zBbgF3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jD6fizvM; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jD6fizvM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eHKRDk8uE0pl8M6LpDEdlxPIBFjdwXicj/U3aBfx4pI=; b=jD6fizvM2dKb2A4HV212NSWAKi
	58MSs/I9KH7YRMvfJJbKTku7QpXT6d4IUYFXeaRyEtUhuHwGjtQbhNtGP563IkBC86is55fW/FPFD
	LiSfIZCn15HS+5fRxf5RqMOXMV2S78RGwmv2jLG9JUnPRmtBgLrtHc1A/b/+ztvsl4NwHz1JG4znl
	ipyTVsTv0VkpgHxZigjmxQ2D1FtqgYaSOw8nTf1CfDsR9AlLJwPQLAE6kygt4fDRcYO0JgoYtomef
	rZlgFss/0FaCFTQRLoBPLNAPwOJM/myJH9Ebhj1DCUlPLtPYyWgHqNKOC+pv5S2JRKAj3T0lSqwoZ
	oZdCpYrQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1taavD-0000000DZP9-19EH;
	Wed, 22 Jan 2025 13:37:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 828D0300599; Wed, 22 Jan 2025 14:37:30 +0100 (CET)
Date: Wed, 22 Jan 2025 14:37:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
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
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 28/39] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250122133730.GQ7145@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>

On Tue, Jan 21, 2025 at 06:31:20PM -0800, Josh Poimboeuf wrote:
> +/*
> + * The context cookie is a unique identifier which allows post-processing to
> + * correlate kernel trace(s) with user unwinds.  The high 12 bits are the CPU

s/12/16/ ?

> + * id; the lower 48 bits are a per-CPU entry counter.
> + */
> +static u64 ctx_to_cookie(u64 cpu, u64 ctx)
> +{
> +	BUILD_BUG_ON(NR_CPUS > 65535);
> +	return (ctx & ((1UL << 48) - 1)) | (cpu << 48);
> +}
