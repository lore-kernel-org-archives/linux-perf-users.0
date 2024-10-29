Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D71198A31;
	Tue, 29 Oct 2024 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730220697; cv=none; b=AJmAw3YfmCWu0cwsaYPH+O8F8daIf35Yk1e6xgneo/7Jp/LIkg3mzDdhq739418G0jUNVRE+5HHCbuLtKnVTNeA57ZbYDH/HcgxoY5uZbRFTKmaQYaD+PCEwZRMnvRGJSuscoTDogtAjcHW2ONBg/x55XD+XoWDhMgawhkK1DQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730220697; c=relaxed/simple;
	bh=xqKBn79DKbImua+c6iNNetJOik2hCOzIl/y9TYioMZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f94yP03TIeuCT5scwRCMZb07/Kjpa/wmG/ZSV8FWK3IOG6bfhRAXsHPMbQ/+nK8AppYKLOowF2SRRMqUNPXf4uhgV7p5RGjyoMICrdWxzE31SgX5PrsBotK555t62laGItloBJYA4RlLgvBd87xogfb4BfrCzThlm4CNjAsfoyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpSiyN9R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpSiyN9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C8DC4CECD;
	Tue, 29 Oct 2024 16:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730220697;
	bh=xqKBn79DKbImua+c6iNNetJOik2hCOzIl/y9TYioMZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpSiyN9R5IdN2MfTsa47gXTTmTKJfH0QmVwGzi4bPkiYQptXZ2lg4VCjtEgVqKAiC
	 AetIfEC9ygf1WzZwwjsdiiZv4itUumdgZsmyJU7WLAMtAYMaq+mAgQBKDgBCVxME1k
	 MSg7Ab4FuSHjs9SpbdPRQDEmHGaXAPIBrEQqQjJunqv9vEjJEl44ubBrsXNPtUEymv
	 y3k9QoaCX4eD+RZImnAs7LleuxLG64+Xq3s/TvkLIrJuBZN/m3dEwYT8TDzF+84hLO
	 O0kvMXBFRPHyD6QF3XwH5jS7zPer6bq2QG4tBUHQMt0odgs/XYm2BJL88dJ7d9zqgW
	 UXzz6VFZagg7A==
Date: Tue, 29 Oct 2024 09:51:34 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 11/19] unwind: Add deferred user space unwinding API
Message-ID: <20241029165134.zoeh5vg6b4lmac2d@treble.attlocal.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
 <20241029134807.GZ14555@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029134807.GZ14555@noisy.programming.kicks-ass.net>

On Tue, Oct 29, 2024 at 02:48:07PM +0100, Peter Zijlstra wrote:
> On Mon, Oct 28, 2024 at 02:47:38PM -0700, Josh Poimboeuf wrote:
> 
> > +/*
> > + * The "context cookie" is a unique identifier which allows post-processing to
> > + * correlate kernel trace(s) with user unwinds.  It has the CPU id the highest
> > + * 16 bits and a per-CPU entry counter in the lower 48 bits.
> > + */
> > +static u64 ctx_to_cookie(u64 cpu, u64 ctx)
> > +{
> > +	BUILD_BUG_ON(NR_CPUS > 65535);
> > +	return (ctx & ((1UL << 48) - 1)) | cpu;
> > +}
> 
> Did you mean to: (cpu << 48) ?

Indeed... that was the victim of a late refactoring.

-- 
Josh
