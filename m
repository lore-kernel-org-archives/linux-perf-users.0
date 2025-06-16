Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC522868A4;
	Mon, 16 Jun 2025 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091225; cv=none; b=rdjYZRAQd3AnJnHSqq3vD3DhyZh7Ny2F5GK4vT174e3oDYFcW5HeYuUiqFnJte0kHD4cAcF/c+20VcGX1/3WHTpOInniIIWle6soQKPf/6sMTST7YfJsNAQZTMxGBy+c3My2sm+BiGAUVXUIeNvZd/7NRIRmAPAEtyOK/fxjGy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091225; c=relaxed/simple;
	bh=xukfKGhgprwLtacCuZ7f98jNle1jgBeo1wpJ/3Krm6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1tvQ0cMotnwUdMQqCSyO84Jgde0Ub2cC0Mb8e9Wv2NfSsO0igHbgNC1sDjdAnfaWoKdMTwhcWX0QeumT8+qf7vpcarpjlRUP5Dvm2qdP/nXtoRELjdMHWVN+4jlb198KGTAVyZcp9z3eidE8S8X1LdyisFhvIAXUsdAycsNiww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beEd/8vw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beEd/8vw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2088DC4CEEA;
	Mon, 16 Jun 2025 16:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750091224;
	bh=xukfKGhgprwLtacCuZ7f98jNle1jgBeo1wpJ/3Krm6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=beEd/8vwDo7AmIHGFMqDr2OlaaysqrgiBpERtQYQ+99txrH8nb7pDQltCDXC7a114
	 cv0A+Q/Tj4KCNvz18LQkxnqoeUJFnN7LTFrK8EpvNxBSRCxtgs4p7sNLPhDGX3h2zm
	 pt3YAs9mwlPEk41vyf6QuvrmndE5b0Zi8DaEPwBcGxly6JbxVIOmzJWjeUff0Cn0I+
	 HHHPjAVzGT+9GVNKNS5Jka3NZBb5p5ITw74z0V3NZaMnhp2K1EhCQegJEErZC02eXY
	 wPzrAtt+hT8Bf1f3eB5t0hFnmbpHTFt0o1AY/Z+MvQ3BeeE7AqTK1Qb1y1xb74ejb/
	 MKDrMvUhz4K1w==
Date: Mon, 16 Jun 2025 13:27:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] perf trace: Add missed freeing of ordered events
 and thread
Message-ID: <aFBF1ejZQBBvX7F4@x1>
References: <20250614004108.1650988-1-irogers@google.com>
 <20250614004108.1650988-3-irogers@google.com>
 <CAH0uvojjfOcoZmxPL+bG5NEid8xcAVth7UxOUc=aYjgF5nqs2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvojjfOcoZmxPL+bG5NEid8xcAVth7UxOUc=aYjgF5nqs2A@mail.gmail.com>

On Fri, Jun 13, 2025 at 09:16:26PM -0700, Howard Chu wrote:
> TL;DR: (definitely lost: 5,248 bytes in 17 blocks, 3,586 bytes in 12
> blocks) -> (definitely lost: 4,992 bytes in 16 blocks, indirectly
> lost: 0 bytes in 0 blocks), the leak of thread__new() is fixed.
> 
> Thank you so much for fixing this.
> 
> On Fri, Jun 13, 2025 at 5:41 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Caught by leak sanitizer running "perf trace BTF general tests".
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Howard Chu <howardchu95@gmail.com>

Small enough, applied to perf-tools.

- Arnaldo
