Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91214F1EF
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Dec 2023 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hw4AUm3e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205FFC433C7;
	Thu,  7 Dec 2023 19:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701978634;
	bh=uolfMoZiIRSE/4h+zQ+qJh3J/h+CcPF6Bi68mWyjVuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hw4AUm3eUGiUHDMPy4OR0enT9w8/FGehvahDwUMqHTW0frjTo3grUXPZ9joA6xby3
	 G/RJsqWb3nxyR1Tp3nBXHGOCrDvDPx92BYBRBGBAJOXIOoaHws87u/0rpJ9Y5X2gDI
	 yB3P8n3F+D9R1iXspXHX6JqjOcTgt3DjK7bIBotQMrILBDhMkS+MbkNLjaEb5KJ5Mf
	 P4lkADP/qH/B+/7rvUOenEDV4+MuzMqrgBv+PxMD8nPclklMvivqb1snTymO6wqLZH
	 5zBJ79msLN5FwG/scROF1W2BiU5IZZ/pyK9ia0vhnKkcXL1D5xIEGSH/I/p8zBDnp/
	 e3kEQWTtB5mSw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id EED24403EF; Thu,  7 Dec 2023 16:50:30 -0300 (-03)
Date: Thu, 7 Dec 2023 16:50:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHSET 0/8] perf annotate: Make annotation_options global (v1)
Message-ID: <ZXIiBp-rvdvSI-ZY@kernel.org>
References: <20231128175441.721579-1-namhyung@kernel.org>
 <CAP-5=fWfKqgT60TFRALw8vTDQT7VFV+0+eo1rFSSH3eVrjzPmA@mail.gmail.com>
 <CAM9d7chKmDETK6Ea2wyR8L21jyHWcPHbKavarnq-JmNA-AoUnQ@mail.gmail.com>
 <CAP-5=fUf6R=bsfg7i8atFApJBY-=zWUBMq7inFsCPZhB+w2==Q@mail.gmail.com>
 <CAM9d7cjDiu=dksnhboJFT4uPQJcvGMB-vBt96v3i7Kqy5LKRMw@mail.gmail.com>
 <CAP-5=fXKbi3DYoOKrJvNKLNU=fJEY9aDAOQhH+Vh+XWxHzGjwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXKbi3DYoOKrJvNKLNU=fJEY9aDAOQhH+Vh+XWxHzGjwA@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Tue, Dec 05, 2023 at 09:59:02AM -0800, Ian Rogers escreveu:
> On Mon, Dec 4, 2023 at 2:46 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > On Thu, Nov 30, 2023 at 10:37 AM Ian Rogers <irogers@google.com> wrote:
> > > Sgtm. My point wasn't to criticize, I think this is a good change, I
> > > was just trying to imagine doing things in a way that could overall
> > > reduce complexity

> > Yep, thanks for your review.  Can I get your ACKs? :)

> For the series:
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next.

- Arnaldo

