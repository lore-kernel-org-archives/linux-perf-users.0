Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2454E50C3;
	Mon, 19 Oct 2026 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412347; cv=none; b=gWfZ13iXVc2PfWsF6PBg5rOA/szwrree5LOMCKPON/XmvKCk9SBp+nJUo826OXzuUqzdig1KzE0e39ltJD64iNn6UKLjxDntD/gJnqTwVjur+6R5VqXIjkzd0Z1t8AauEf287F9jWWEEZ+XHKbVLbfvtXxNJAJ12hGeouUNekNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412347; c=relaxed/simple;
	bh=84quNg8mXXkbdil51vXlYmCbd/0n54eUNpAWmZRajqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNWAlaZLfXLgHE1A7C0rGj972cSeNootTIGsVCB9604oAQRVAiH6OtfDEYqN7nWSm4vIUrcyajzfF09SK4XjgHLUZ4bQkJs9XIS2JkYbayXPrCVMoNv2WRzRI2yR+ORgEm5fQp16vgbtgjc+trnHBGzbzoF3zakafdfaW+/eroY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISoZLXeC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISoZLXeC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7F51F000C7;
	Mon, 19 Oct 2026 12:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792412346;
	bh=K2l3W+RSBSemTKgTx0z9m564dZ/QRwgka3TAmxYxCyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ISoZLXeCc68LLd4NSrzP8a/g4Uh0wt2wr5m8W1QAC/pJMe57OovUEf8lwAildTm3K
	 c3lPb+6iNr8tI/XjhscA1+FwBN4SvlGqtqfKF+c68zG1LNeaRQRgshUnKf8B/yWSr3
	 QDK0vWki8FlkIv3WBUjpQsbc+syLELGLDUHFKEu0zZguhgkoUS4J5tTxQx0NSlr5NM
	 oA5Dlfg5f33WGYg7kiTBacqj3bfnV89c6+IuSTp08R940rA5C26a/CZPl15jzT53vv
	 qiZYOtC3bKd7PUEECDR7PD457iu7E4FuM1RhYvUHT5EyJPjGCO4c53TUJ9qXy7z6AD
	 BYLFzoQtabNFA==
Date: Mon, 19 Oct 2026 09:19:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alice Rogers <alice.mei.rogers@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf timechart/treport: Fix mypy errors
Message-ID: <atYKtkBbuZzaIYni@x2>
References: <20261006-james-perf-timechart-mypy-v1-0-e2c7edf4dd31@linaro.org>
 <CAP-5=fVypGeXuKw1vJMaqGhpUtF3vqPcdKpo+Q61qZHGKSj2Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVypGeXuKw1vJMaqGhpUtF3vqPcdKpo+Q61qZHGKSj2Ew@mail.gmail.com>

On Tue, Oct 13, 2026 at 09:21:12PM -0700, Ian Rogers wrote:
> On Tue, Oct 6, 2026 at 6:03 AM James Clark <james.clark@linaro.org> wrote:
> >
> > Two small adjustments to silence Mypy static checks.
> >
> > Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
