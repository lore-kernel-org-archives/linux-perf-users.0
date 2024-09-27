Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3C0EEA6;
	Fri, 27 Sep 2024 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727462404; cv=none; b=WuQHSTJnVZ6gfrJy2ZCoC+JXEgFJXpWbopHVDvhxq7LCMXtIISstxioTJg07Qm1p1ZLkEHlxVkrIeQdB5xOS+L8ncAO7Fg41UWISNqS4rz9IVdP/p/vvhf+Wrp0di1WFVzff9AlBjz6rkRcVGzEIgeSmD8u7c43kQ0jfbfu9jeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727462404; c=relaxed/simple;
	bh=ruHoKeoHFman1KriLqEzcqXsv15cD8neYbr3yhKxVzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7UnZh4W70+Q9jfK0+5VgtdVNcelOIaJl2FWrJ/c+JmCtVDCm0OrkJrpOK2kqVK0RGTIB8Jb0/ge4Eq2Jg1/9Gf5xnN823qxWW3lJ1HRYiwSSPkOy9sXjmIoxrtc4AoVXfGvnKdivovz19qrfq0KBhHgMXAUinIwWdpMrnPfBEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqKIz2o4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqKIz2o4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069A9C4CEC4;
	Fri, 27 Sep 2024 18:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727462403;
	bh=ruHoKeoHFman1KriLqEzcqXsv15cD8neYbr3yhKxVzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TqKIz2o4dsLNAjYnc0HSipxgHtmivglTT/H1orOhBOoYPBNzg933uhLutNEF40Xyv
	 yonaU5nisKxoUFx0lhLx9DBf/+np0I1KjzlTSrYLSZcB3VaQg8K5YWC0riPQ1zWI/V
	 g/EdZwkiDJzlV6oLtmBiWK9jYWTiKMEGM7eow5Gd7gZZ1iKKQ7sHtMmsbRrwmMFGwt
	 9YebceyDRmUNkd2G948MKYiZ9FDvBTagSogVYveHdbLyayCQ8J87439yYVy3FxD7Bw
	 MknZ71uhyctTsyYag7lIx7ZcotCpS9TLukW8ov3e7Yc9QLuAijXKUROKKijZchBK1F
	 dosK2CktUkEpg==
Date: Fri, 27 Sep 2024 15:39:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf vdso: Missed put on 32-bit dsos
Message-ID: <Zvb7_9Z9QGOVuOD6@x1>
References: <20240912182757.762369-1-irogers@google.com>
 <ZuM9zc71XXXZ3eRZ@x1>
 <CAP-5=fUCVa3VoByKUFDp8Q+M2ZOTdy7ccL7Ter8E8dSE368KAA@mail.gmail.com>
 <CAP-5=fX9FO70B2Z4jp50owX-Lr3sAuECje+0s13tc9C9s1v+jw@mail.gmail.com>
 <ZvH4p3-kdnZfij_4@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvH4p3-kdnZfij_4@google.com>

On Mon, Sep 23, 2024 at 04:24:23PM -0700, Namhyung Kim wrote:
> On Mon, Sep 23, 2024 at 12:01:23PM -0700, Ian Rogers wrote:
> > On Thu, Sep 12, 2024 at 12:31 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Thu, Sep 12, 2024 at 12:15 PM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Thu, Sep 12, 2024 at 11:27:57AM -0700, Ian Rogers wrote:
> > > > > If the dso type doesn't match then NULL is returned but the dso should
> > > > > be put first.
> > > >
> > > > I guess we can add:
> > > >
> > > > Fixes: f649ed80f3cabbf1 ("perf dsos: Tidy reference counting and locking")
> > > >
> > > > ?
> > >
> > > Yep, that's the one that added the reference count increment.
> > 
> > Noticed this isn't in the tree yet, do I need to resend for the fixes tag?
> 
> Arnaldo, can you please pick this up to perf-tools?

Right, I just did that, b4 was nice enough to notice the Fixes tag I
suggested, its in my local branch, will push out soon.

- Arnaldo
