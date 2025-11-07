Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E8B223DD0;
	Fri,  7 Nov 2025 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762538009; cv=none; b=Dmprdssi5cwLJpQSsYMa4WKOHiQKD125mdRAppMC346D2dl7wcPQO9M3eX6sRHFNgpNjQjRh+fG1YRMiI8ZbfCxtWgII/j/Wx99prAVtOvlvaBlfDWJnzb0OQpnOC9rHh7AUe0qf2+lAhSO09LYW0w7W9h0WheCOcZdzWcptD7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762538009; c=relaxed/simple;
	bh=AOVdJelQfw6EpoFSwiDWn+hfM/JfXcc1JRdXQrUkjV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jS/RPw63yZvJ/XqpT0T0fc7DdJdmt7YzJ1tenLmHHZz/PJvTCEQ1rw/O63JvA8i9JzmM0g5cqreyonVFdKVHT17LhYZPGmMcsDh1Eu2y1Ko4Jyf7rKxDYjh8CYSmrqQwtWCgHeJWwFivpYcAW8ha2eDJiQX1cc3BQL/s1rqUYGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bh99wUlb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bh99wUlb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565C4C113D0;
	Fri,  7 Nov 2025 17:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762538009;
	bh=AOVdJelQfw6EpoFSwiDWn+hfM/JfXcc1JRdXQrUkjV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bh99wUlbfJuMNpjma/XRazA6isz3PnNvYX16acdBowaJb2wvgiLW+ikIiYxIzO2aL
	 4fXzJAVgYZOmddM7cdqK0F0fD2fYc+cwg5E6fkBiytqCdrpiCqTJEP/3zWN3/8DWbl
	 aKOE/R0ZUq3KgJtbV/ZSixA4bUgXc9wKbyHW3ekEnTgZdTOmQ1NDunsTAk2XVe1F/Z
	 dIq7tuTU+J2n9tszRkVTRInRxw4XYN6xQondtB0UfqWHXd/wDiy+tEZ0Nve+Py2mud
	 rwZBtmVp/TnciE42HQG8g2d3ztacg6jvrD3HG9LVnSdvdqI/WqJ+s5z5IMs61XoWpu
	 PEnOte6Jh9a6Q==
Date: Fri, 7 Nov 2025 09:53:27 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf stat: Add ScaleUnit to {cpu,task}-clock JSON
 description
Message-ID: <aQ4yF-_bDedF2535@google.com>
References: <20251106215350.1833191-1-namhyung@kernel.org>
 <CAP-5=fU6gyWb25Qd=U3wZiQ_6D72qVXPKvo6XKQpAu03tAPVUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU6gyWb25Qd=U3wZiQ_6D72qVXPKvo6XKQpAu03tAPVUg@mail.gmail.com>

On Thu, Nov 06, 2025 at 02:09:00PM -0800, Ian Rogers wrote:
> On Thu, Nov 6, 2025 at 1:53 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > This changes the output of the event like below.  In fact, that's the
> > output it used to have before the JSON conversion.
> >
> > Before:
> >   $ perf stat -e task-clock true
> >
> >    Performance counter stats for 'true':
> >
> >              313,848      task-clock                       #    0.290 CPUs utilized
> >
> >          0.001081223 seconds time elapsed
> >
> >          0.001122000 seconds user
> >          0.000000000 seconds sys
> >
> > After:
> >   $ perf stat -e task-clock true
> >
> >    Performance counter stats for 'true':
> >
> >                 0.36 msec task-clock                       #    0.297 CPUs utilized
> >
> >          0.001225435 seconds time elapsed
> >
> >          0.001268000 seconds user
> >          0.000000000 seconds sys
> >
> > Fixes: 9957d8c801fe0cb90 ("perf jevents: Add common software event json")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Applied to perf-tools-next, thanks!

Namhyung

