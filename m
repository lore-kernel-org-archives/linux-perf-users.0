Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0C942A92;
	Tue, 29 Oct 2024 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210947; cv=none; b=DchMHJIBtoFILR5pJDiBpEA7303xIeBTZcs298HHXsZ6PJaQuD/J35oWhvQGceFBGxSgO3nzN2aNjHZ8ILz9ET1nVqZBdwj60UGEiYp9FJctjvOksjg+Eei1pxXWxen3JrQqlB7oR4A0jazexKTSWopW8rZ9MyDl/geCfmn8QOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210947; c=relaxed/simple;
	bh=B3PTd18W5zTwlgnmB7cmpWuhKcY1jJrsoYEOari3Uk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEmOTJjY3Tm9wvw9Ulr/MjPn1nIwcc5OZrX05ariLRrnPk0ezWzjKfH75vsaVfZbKkfS/nh5rDHYCw+D5AZVYdGiC6KiCgg3e4st2aNRwIVk+ygbf7HStWqqcghPNewJvFJsdjKpFxQ4eOTQbyRZLur87fuct3ezBon/SgOk27A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OCYW8KPZ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OCYW8KPZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sHZQoAi2r+bPyI24sxrgAj4c8J8PloQlVCP6audZCho=; b=OCYW8KPZFzeygXXo3yCj7FHYWO
	MBdrf9Q4ohOLgBJZinQLA8b+ZRvsVAPUenxhTjkm5MT0xadANHPQc+zfmcEAUJSL0XvEypNM1HEui
	HOG/+jSHnbktO3JMvlrpHXXmIzsD7EX8T/SWSvUbAFyKdCjTHLrTZKF/WlcjLfiOFRnq1c0FPJMHd
	16I7QJf5GWd7T+57QTcmVxyp8TwgfWqCnl/xIlt3GdVLO0jgYPYloVSWAnGxT5vJDRTPeibCQ+Ugq
	aXtSKNiRD3QzZLeTrMFV5TwM2NXTFyTZnVUAqN78jggV4rKwIRcrw1aeOM8PGZ6LV04rAtx5PLceH
	P6xhM/sw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5mty-00000009uZG-2jT6;
	Tue, 29 Oct 2024 14:08:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 07BDD300399; Tue, 29 Oct 2024 15:08:54 +0100 (CET)
Date: Tue, 29 Oct 2024 15:08:53 +0100
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
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 00/19] unwind, perf: sframe user space unwinding
Message-ID: <20241029140853.GD14555@noisy.programming.kicks-ass.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730150953.git.jpoimboe@kernel.org>

On Mon, Oct 28, 2024 at 02:47:27PM -0700, Josh Poimboeuf wrote:

>   - Is the perf_event lifetime managed correctly or do we need to do
>     something to ensure it exists in unwind_user_task_work()?

You probably want a sync/cancel somewhere near the start of
_free_event().
