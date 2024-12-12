Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE48223C40;
	Thu, 12 Dec 2024 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028865; cv=none; b=rdLZOMQ8dDcU7jkIFtSYukmp71Wgmcdq+9C5+KmcxTe42sXztG9cp/7p0/k7T5DYoM5aP25gcgrnnoDoJAi02pPhdUNATQe8nGDlUA4ONVuRjmL8hcNqPitbelNKgn3+xsYmcS0xiuB6Eo7nO0xGm7j+giDRJLwr5tKAFoOwDnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028865; c=relaxed/simple;
	bh=Cm3RpNEPByBsyU85TyLlrUed6ZFN4HOcl3ze1OsU+wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sg1BboDZY0P97kUJ8ODrDDxRqaIpmgCAv+taZl9nIzOzhyoE1CDdwE4l+22MMcTySweUN/lAF33dkSPB6KDGQJu4R8G2HH2sNV5yfX3lPpl+XCbd8RV6Spn1aGY9tmyPGp/K3KLShhsOpZy0ki950ImUtHDjjOwmQt3SEipq1PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luD6Dp4X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luD6Dp4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7787C4CECE;
	Thu, 12 Dec 2024 18:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734028865;
	bh=Cm3RpNEPByBsyU85TyLlrUed6ZFN4HOcl3ze1OsU+wU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=luD6Dp4XQBY6UGvQA1wOyhjs9LBkW2KpKu149AOmtODqOkJjVrbWE9TagyoISL1UC
	 c5Q0H3TgUfIHsmq1MyvO6K98J18RNaDmg+gEsPC8O2yVgU3kZ/dC/nACzN+9jA+7ks
	 1W9/rvbxr1001KmIBSj+lOJm+fPCqkHRIC9OdzRmQGnE23ESuM0t5Pid7eR7HoZJaR
	 zDvj5y8MnW3UZUX3cdhENJSBEXrEx+EZ0WwEO8D/4pP8eMU6WC0R0t/6uVw7XuGg3Z
	 Ll1vMSmg0QDvbUWNRfsW+Jn8Z9rZhdkkVky7TkZ249BYYI3e8KbBqhZxppp5KTVoNT
	 Oy1D3KrPqAJcw==
Date: Thu, 12 Dec 2024 15:41:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf tools: Avoid unaligned pointer operations
Message-ID: <Z1suPi7XLncFKtG4@x1>
References: <20241127212655.922196-1-namhyung@kernel.org>
 <CAP-5=fXtL-MFW5YW=5WsYNftCAj7MaXVwN8R3veuiODiC85bdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXtL-MFW5YW=5WsYNftCAj7MaXVwN8R3veuiODiC85bdg@mail.gmail.com>

On Wed, Nov 27, 2024 at 04:51:15PM -0800, Ian Rogers wrote:
> On Wed, Nov 27, 2024 at 1:26 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > The sample data is 64-bit aligned basically but raw data starts with
> > 32-bit length field and data follows.  In perf_event__synthesize_sample
> > it treats the sample data as a 64-bit array.  And it needs some trick
> > to update the raw data properly.

> > But it seems some compilers are not happy with this and the program dies
> > siliently.  I found the sample parsing test failed without any messages
> > on affected systems.

> > Let's update the code to use a 32-bit pointer directly and make sure the
> > result is 64-bit aligned again.  No functional changes intended.

> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
 
> Reviewed-by: Ian Rogers <irogers@google.com>

Looks good, applied to perf-tools-next since this is something that is
not new nor looks urgent.

I think that since we have multiple maintainers, one for not urgent
stuff/development and the other for the current window/urgent stuff,
that we should express the expectation about where a patch should be
processed, by having on the subject the tree the submitter thinks should
take the patch, i.e. for this one:

[PATCH next] perf tools: Avoid unaligned pointer operations

While for urgent stuff we could do:

[PATCH urgent] perf tools: Avoid unaligned pointer operations

wdyt?

- Arnaldo
