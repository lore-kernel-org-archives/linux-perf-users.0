Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F37139D0C;
	Tue, 18 Jun 2024 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699211; cv=none; b=DrUa59X7t8YP6OknZSGlu8xGLMDbPnY53S35JgAnSWpgkcc3qCgHPCqxHFZYYz8XA69iHO8pbykOFe8RsLHKUXvck7iB0DfGVpuX4zb6UASzeSShhiFlG5BlJUr5RHpeMfEWZ1C9S36VFZLIUHeeq+7Bt9XAMrk81CN++NzjZmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699211; c=relaxed/simple;
	bh=yz2C5fvBJTGqQpnuSLNkBiIZocKFHu/gpBvI/hES3l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWQsXf8wT23nuhA1kdsNj0cD65a+hhGVjIcOFmV2MFiT1ZnnILxD0w7NOTArXxJH7vHO6VBm8MTrkmsYPCqM/QNKKRVYBg86Xl9cmn6iaf6pwSHhydt1W301FJvjn3XrIpO0nKP1OPfUjLsJx+Kc6+Otf2wi7Be7dgDYEz+FeA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TD8kRNf5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TD8kRNf5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y/V05mUJk5DDD/0Y/A3n8rzv2x+59hyyMuOW2I/yfmo=; b=TD8kRNf5i7wpP4NwVa51buHFqy
	4luHLDjx1w/Xbig1Fi4uuSpTm6uTRaww56SpHtlvj70vUb6uoywFJ3Y8wj8CvSxdBH88Xi41DdKJ4
	gZLXsidw0hcwi7I7jolrjupEz89w8k+t2h1OczpMw/7WaBKMhOgAsfrR0bjhMK4YfolJJblo6Vkvh
	de2lHllu6t4vDXrrGnzzN5SiOJlDCb6XtVoHyD+SsxOhm6wfR4VAlmExV4T/H8wSRGcp8TJuWo4tA
	1JqxPn8us9pTWW95CTZW4UrVLPGrv/jyzEXUEJVXO/FhOr3YsimhVMFnypbCh/6m23y8zQn05qEm+
	Bnivz25Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJU78-0000000707D-3Mbp;
	Tue, 18 Jun 2024 08:24:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C57D1300886; Tue, 18 Jun 2024 10:22:42 +0200 (CEST)
Date: Tue, 18 Jun 2024 10:22:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Martin Uecker <uecker@tugraz.at>,
	Erick Archer <erick.archer@outlook.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Matthew Wilcox <mawilcox@microsoft.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 0/3] Hardening perf subsystem
Message-ID: <20240618082242.GC31592@noisy.programming.kicks-ass.net>
References: <202406101010.E1C77AE9D@keescook>
 <20240610200544.GY8774@noisy.programming.kicks-ass.net>
 <202406101438.BC43514F@keescook>
 <20240611075542.GD8774@noisy.programming.kicks-ass.net>
 <202406121148.688240B@keescook>
 <20240612220821.GA18881@noisy.programming.kicks-ass.net>
 <202406121530.D9DB956C8@keescook>
 <20240614101708.GO8774@noisy.programming.kicks-ass.net>
 <c8234b8e2c9c1122eec73c97901e36586160f0cb.camel@tugraz.at>
 <202406171019.9F0127F@keescook>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406171019.9F0127F@keescook>

On Mon, Jun 17, 2024 at 10:28:20AM -0700, Kees Cook wrote:

> But, using type attributes we have much more flexibility. Hence, the
> proposed "wraps" attribute:
> https://github.com/llvm/llvm-project/pull/86618

So I still think that's going about things backwards.

unsigned explicitly wraps. signed is UB.

When using -fwrapv signed is well defined as 2s complement, which takes
away the UB and makes it implicitly wrap.

When extending the language, it is important to not break existing code,
so the default must remain wrap. This in turn means you need to add a
'nowrap' thingy.

Also, I would very much not make this an attribute, but a full type
qualifier. Furthermore, add type promotion rules to ensure nowrap takes
precedence and is preserved throughout expressions. Such that:

  'long' + 'nowrap int' -> 'nowrap long'

Then, once you have this, you can go do things like:

typedef nowrap unsigned long size_t;
#define sizeof(x) ((size_t)sizeof(x))

and things will just work. Hmm?
