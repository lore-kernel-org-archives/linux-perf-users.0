Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282AA2BEFEE;
	Mon, 26 Jan 2026 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459747; cv=none; b=cRE4E+n0wNtIIcn8wqcVb+7yIbrMjEvlxAv5ILUsrkr+XYYZd8KT7cBoO4zJq96vALhX0Li57+gafwDlYNJz+NbzVWzy2bdDujgKqeLKW8dASiouUeGTypW/qqHtedSHcQP2ZRIuHh4nJd/UmPC5dIvtP7oxbJxePy4uzTUjA+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459747; c=relaxed/simple;
	bh=r4zZ6r6I+Gw+BLz2KXDK9fynqibcupa8dAibb8ZCTnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imh2vnMbHfedvzH6OGwY3hUGgN6y3iR78ksvZ8HmjA9Qu89lwES8vdez2qj7JT71NFaYa29TT1Mt1/tGdl0T3cuJcTsFsqSa3UYfBeU50+5Xk3gbzINRqhhxrmtZQifDMnsIMGZ34VL3SYQtPO601fID5mT/8BuN05JiMz1tBkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtoCA5wV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtoCA5wV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0D0C116C6;
	Mon, 26 Jan 2026 20:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769459747;
	bh=r4zZ6r6I+Gw+BLz2KXDK9fynqibcupa8dAibb8ZCTnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FtoCA5wVdtvpAYuKsyHXMmqNlQ0XJhMYNuJqqgrwV90mi1KlOKEOwEv0JRHLQfjpT
	 4WXvdjwB7DhBBu96oiuVgwjRYcbQLuxfkgN21aYlnrUz2EMihcsqnOX3dcfZqQFiAk
	 CfFSrl+2cAoP/FCIoAkrZfhSa2ulyZ95K7xm2Gvl94ger2ohvLYcqCUzO0nC8FOODD
	 eOFEnuKbgq9+n+Dcfogc6OK78WbanZUwohYG7j+vQTKRmFPOQOatjXBns9F7caoaiu
	 AF+LPWz+AfvoQCrdg5koQYUtjC3NDzttXxzKty7jvY2BG7vJZobRkpoIIGIN3BNau1
	 h960FXKJ3X/pg==
Date: Mon, 26 Jan 2026 17:35:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Suyash Mahar <smahar@meta.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Subject: Re: [PATCH] perf vendor events amd: Fix Zen 5 MAB allocation events
Message-ID: <aXfQHyNAVUXZaFNa@x1>
References: <9a7eaa4f2e50a4ab2d98781c52bce6f98568a888.1769069215.git.sandipan.das@amd.com>
 <CAP-5=fWH+GT-wuw5e-0MQQanUNMqUGVD+V=y7vq2jN4xe_GEmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWH+GT-wuw5e-0MQQanUNMqUGVD+V=y7vq2jN4xe_GEmQ@mail.gmail.com>

On Thu, Jan 22, 2026 at 08:00:09AM -0800, Ian Rogers wrote:
> On Thu, Jan 22, 2026 at 12:10 AM Sandipan Das <sandipan.das@amd.com> wrote:
> > The unit masks for PMCx041 vary across different generations of Zen
> > processors. Fix the Zen 5 events based on PMCx041 as they incorrectly
> > use the same unit masks as that of Zen 4.

> > Fixes: 45c072f2537a ("perf vendor events amd: Add Zen 5 core events")
> > Reported-by: Suyash Mahar <smahar@meta.com>
> > Signed-off-by: Sandipan Das <sandipan.das@amd.com>
 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
