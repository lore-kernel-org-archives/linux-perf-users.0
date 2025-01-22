Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DD41BD014;
	Wed, 22 Jan 2025 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737550328; cv=none; b=d4x8lDub7eT+rQPClp/pC82mTpyhnVsy6JssVV9TXoOEQm6tObcVZ+EZDg8yWG98GQg+50kzC+RAtF6LPH+FbnJZZmAxpSTvWh258N5AynuXE0DEPEuItvgfaPbcGoS2BnP6E1KPao/DEJBX0HOhUXtCAeu9meiDN2V1rQABqRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737550328; c=relaxed/simple;
	bh=xy6me1S9SpHZOXVUNTljAyrO3xdV9+f0eMOPh7m+NY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYApZvQBSkB+K/c73gjLifEU5Hh6lII9JTCdGss43JfsmfDIMj8V4b+pO3Avu0YdDiMW1EbExPPyVCzfUGDW0hB6Ww2aaQ/ci2bJg7MR3FqjoaL7F0MxjI4m62vLjHAlrM+Z2KRzeCrKGuTsV6gTD7P+wriZX8R0PHdNMhEwM2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qVYVODTC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qVYVODTC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xy6me1S9SpHZOXVUNTljAyrO3xdV9+f0eMOPh7m+NY8=; b=qVYVODTCZKfQa+kYzd126h83uw
	t58Uwp78v4GL0P4cH0QP5O16kCxcXqOACKnjFQtpPsd/7utk0dsPfVXg+uB8Pz18IjK1Xh1tipSG+
	Mo0siD4EWRxfVcBr5uOAuAoEaTdrevKJuVbE98kzflOc2qrbedIeMBp+TGC1U2ST9sh4AvHgLauLU
	QRPejK72p625qOWXZ31zdtgGI1IQBHKj7t4mcV5H0CHuwRvmXymn1RgdicVX7oZRc0ExdIwXBmSky
	5bv4J82R3LHQSPSPz6pbB9St+iV4NFqhKwai6LeVxQz9oq+EosP90TrRRv309R8N9Vtt4OAQiEemL
	2EIzJPbA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1taaD5-00000001BqD-10XA;
	Wed, 22 Jan 2025 12:51:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CC74F300599; Wed, 22 Jan 2025 13:51:54 +0100 (CET)
Date: Wed, 22 Jan 2025 13:51:54 +0100
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
Subject: Re: [PATCH v4 14/39] perf/x86: Rename get_segment_base() and make it
 global
Message-ID: <20250122125154.GP7145@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <e54e48ab228aa386fb4c5f64ee02ef5291f2d3da.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e54e48ab228aa386fb4c5f64ee02ef5291f2d3da.1737511963.git.jpoimboe@kernel.org>

On Tue, Jan 21, 2025 at 06:31:06PM -0800, Josh Poimboeuf wrote:
> get_segment_base() will be used by the unwind_user code, so make it
> global and rename it so it doesn't conflict with a KVM function of the
> same name.

Should it not also get moved out of the perf code in this case?
