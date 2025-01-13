Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54961FBBFA;
	Mon, 13 Jan 2025 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780399; cv=none; b=nBRfA/ULKiUX6p2XXJrE9tPpZAVtQWi4JDSuKycxJghz5IxGkZP7jAiJ6meZStwM1mx2J5UZjAczsN+WYanNo7TZbKEL6XCeHKwoTsp3gr+0jxpt78loD/uCCkeiC8Hj8RgNYo6ZPSf5PCsjVOyNpg/t/JX4QNNBfDzw1IP+OEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780399; c=relaxed/simple;
	bh=2cBz+0G6GA9CEmidCPXvRwa5ieQZ/1H+gnTR3uZNa+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8RgTkSaFh99BpS88uDfvuYaaWgtOmHcYEBfSvZUDp2dduTdjpTZM0G4AX9mJmYV0EYBf8tue6xwDO+nP9DbNgMfkgf1lzgAnQBpiy3PUvrAcak3cun65eHFZFi4MHh03EfsFnKCfPfrNIivKkTaeXQUAPX+p/zrRNCPnP8TbGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmvhD9md; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmvhD9md"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E564EC4CED6;
	Mon, 13 Jan 2025 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736780399;
	bh=2cBz+0G6GA9CEmidCPXvRwa5ieQZ/1H+gnTR3uZNa+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MmvhD9mdzl9KfZfkpxvJjhvFGzHGevjl3re+aCXSVnK+Ii9Nu0z30Iqr4X1izop5S
	 VruZJDDDAt8qqfx8P3ksw6gQnBcREkq7U/vWf0UUgHzZzQzKV6N4j/ZGbqwZco2SNM
	 M1ggH3NZ6cFUQ1w5Hyrxeps2erDN9INnJQspkda1SnlSFBr5I62veDN4daWqfyia5r
	 IAdsoGZZY9T+YxdAO9bBfdYLD142q1WZk+XuQW4eHpIB4SbsMIH91FmCasTXArADxy
	 IbLev8BwDvup7AsP1ENHmPrk9ac25Ow2xcRAysiXAfSwSvSXXWozeMpDTLJrDiXcGs
	 z7hhgZFUdR7aw==
Date: Mon, 13 Jan 2025 11:59:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: test: Speed up running brstack test
Message-ID: <Z4UqbCJu-kgOB59w@x1>
References: <20241213231312.2640687-2-robh@kernel.org>
 <CAL_JsqJqJzAvG1wVG2y_FBApVxF8wapP+7+xGXeZ2kHiCqy-jQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJqJzAvG1wVG2y_FBApVxF8wapP+7+xGXeZ2kHiCqy-jQ@mail.gmail.com>

On Mon, Jan 13, 2025 at 08:25:45AM -0600, Rob Herring wrote:
> On Fri, Dec 13, 2024 at 5:19 PM Rob Herring (Arm) <robh@kernel.org> wrote:
> >
> > From: James Clark <james.clark@arm.com>
> >
> > The brstack test runs quite slowly in software models. Part of the reason
> > is "xargs -n1" is quite inefficient in replacing spaces with newlines.
> > While that's not noticeable on normal machines, it is on software models.
> > Use "tr -s ' ' '\n'" instead which can do the same transformation, but is
> > much faster. For comparison on an M1 Macbook Pro:
> >
> > $ time seq -s ' ' 10000 | xargs -n1 > /dev/null
> >
> > real    0m2.729s
> > user    0m2.009s
> > sys     0m0.914s
> > $ time seq -s ' ' 10000 | tr -s ' ' '\n' | grep '.' > /dev/null
> >
> > real    0m0.002s
> > user    0m0.001s
> > sys     0m0.001s
> >
> > The "grep '.'" is also needed to remove any remaining blank lines.
> >
> > Signed-off-by: James Clark <james.clark@arm.com>
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > [robh: Drop changing loop iterations on arm64. Squash blank line fix and redo commit msg]
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> > Originally part of this series[1], but I've dropped any Arm specifics,
> > and it stands on its own. No reason this needs to wait on Arm BRBE
> > support (which I'm working on now). I don't expect to have other changes
> > to this test related to BRBE anymore.
> >
> > [1] https://lore.kernel.org/all/20240613061731.3109448-8-anshuman.khandual@arm.com/
> >
> >  tools/perf/tests/shell/test_brstack.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Ping!

Thanks, applied.

- Arnaldo
