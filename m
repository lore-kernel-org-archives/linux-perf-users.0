Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAD92233E
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Nov 2023 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OuAHd8ld"
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AAF171F;
	Mon, 13 Nov 2023 10:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IGnj/oSG6+zMy3aPMMPNinY1f2iziubTjwUJyW/5HPI=; b=OuAHd8ldaeJn1DmSsSIjmFvKHh
	cHW9zIRxkl/fBvKr5iuAOw3ZcguOeKFGMpEx/pyG/zWhseCXO+ECfn9vUts/OsifAzTEp6ZRFV5Zb
	fzzsdUBdQqiqE/8VSx2aTaczaFtFfAWW36LPEJ8rDEm5IXD9Tr/Urap6XECpMkUsakT/dxPyU7heC
	TWGT4hr1KPc7ypGyYQ28iw8nWpDDaA2CZp71dy6ce/4ayRP0FN68nnXvqd9vbckjBZFKfZCUf5g/F
	4fdqZR/3RuWPLFvKjDrlrWRrOX7Wk68zcmC0ydnA0Z5JYPgWhDhmQ9GDxnElOQqrG2yeiXu5kVnZA
	juE7ParQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r2c0V-00FsCZ-82; Mon, 13 Nov 2023 18:49:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E38B5300427; Mon, 13 Nov 2023 19:49:58 +0100 (CET)
Date: Mon, 13 Nov 2023 19:49:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org
Subject: Re: [PATCH RFC 04/10] perf: Introduce deferred user callchains
Message-ID: <20231113184958.GA7901@noisy.programming.kicks-ass.net>
References: <cover.1699487758.git.jpoimboe@kernel.org>
 <d5def69b0c88bcbe2a85d0e1fd6cfca62b472ed4.1699487758.git.jpoimboe@kernel.org>
 <CAM9d7chZcqR8WCEYtjpP4KzUOeNdJ=kSvae0UrjsO8OgsepjDw@mail.gmail.com>
 <20231111184908.ym4l6cwzwnkl7e6m@treble>
 <CAM9d7chgoiwc3ZfQ8SzO7gV0oQOKMK3bJAdxa63Pzgcqo4i7tQ@mail.gmail.com>
 <20231113172106.GA12501@noisy.programming.kicks-ass.net>
 <CAM9d7chg8c4yftXgAyZZyLuYJQaWYDTa9YY5x-S+Mb-8SM8K-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chg8c4yftXgAyZZyLuYJQaWYDTa9YY5x-S+Mb-8SM8K-A@mail.gmail.com>

On Mon, Nov 13, 2023 at 09:48:32AM -0800, Namhyung Kim wrote:

> Yeah, I thought something like this first, but then I thought
> "can we just use PID for this?"

TID, and assuming things are otherwise time ordered, yes.
