Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8D31B0F2F;
	Thu, 23 Jan 2025 22:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737670882; cv=none; b=lbQa1xYfPtWhI4/s4w0l+arQLr0hSby+iu6728rVpR2igJfb+pcmo6+YbSKPXoEZO2xx2oFZmmOTrLQlGNYqptwmxgSvgQxWAVoumiFZuDtUMGEOtyLbDzUg7hLJh71IOlyeNPr90MkIgIjTXqm0y6vFTDA4Pqoi4KV9ScF04Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737670882; c=relaxed/simple;
	bh=X57Oh0JS/ZOCaFEKu1rWMqsIenBnOP1ahPElwDUh6nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQnrpf9BJfQC9nN8s+zJDwqXls1tmvrxiFjMBEAfuJCNR5QdpH4nN6ltGcMGcjv0tjs0te8eIYc3RJt3tRSjNM4Gh9tzbTdK5Cr4zKXkg0qIMtL2dhvpsBei4ZsLqjs2o7dmBNYKB2pjokorfKXwKz9dIz5axhpHf4opzuDaYlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TBZLJB4v; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TBZLJB4v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jfhCW7nhk3Q/snlnIdLGiMlH6jeUTF8Nuy8kf8OlzRo=; b=TBZLJB4vjA1ItqBy2dpMdy4x0l
	C9TlCnXZTM8rJN6mJjcB81goNxFPYuaUCW0EFqcDP1JRxx3oJ/wOMGP0gbjPLke3j3+NDrxyxjdlO
	u5NhH9F2ZV5OjbiopUKuRzim++1lIoLY/GcXRDFxJhr7vRFFjxaz4Po0zA7rLPg+b+0rbmVLDZYhh
	Kp5M9R68mXASlKS+6nLFRTtLc4KyI3TygBKXiIIL6sWJBpwMdqLH+9E9h1EW1vbS7IMEbk5gLAI8R
	b5LdyDEnWwf0C/T3szQE2VtOXLVlXKghQa5EHb6aUbyMwr9u4Y05cJdXCb9SOS/p1ITJ7VDA+cthu
	5C3LX45A==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tb5W5-0000000DqtG-1Sby;
	Thu, 23 Jan 2025 22:19:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0C7093006E6; Thu, 23 Jan 2025 23:17:35 +0100 (CET)
Date: Thu, 23 Jan 2025 23:17:34 +0100
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
Subject: Re: [PATCH v4 30/39] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250123221734.GE969@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <4ea47a9238cb726614f36a0aad2a545816442e57.1737511963.git.jpoimboe@kernel.org>
 <20250122141505.GT7145@noisy.programming.kicks-ass.net>
 <20250122224902.hhpmhi7r3azz3a4x@jpoimboe>
 <20250123084026.GF3808@noisy.programming.kicks-ass.net>
 <20250123194807.2mn54dsk2ef5i4iy@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123194807.2mn54dsk2ef5i4iy@jpoimboe>

On Thu, Jan 23, 2025 at 11:48:07AM -0800, Josh Poimboeuf wrote:
> > > > 	cookie = READ_ONCE(current->unwind_info.cookie);
> > > > 	do {
> > > > 		if (cookie)
> > > > 			return cookie;
> > > > 		cookie = ctx_to_cookie(cpu, ctr+1);
> > > > 	} while (!try_cmpxchg64(&current->unwind_info.cookie, &cookie, cookie));
> 
> Should not the 2nd argument be &zero?

This I suppose

	cookie = READ_ONCE(current->unwind_info.cookie);
	do {
		if (cookie)
			return cookie;
	} while (!try_cmpxchg64(&current->unwind_info.cookie, &cookie,
				ctx_to_cookie(cpu, ctr+1)));
