Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85622045A1;
	Wed, 12 Feb 2025 22:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739400967; cv=none; b=D3Clkz0cVICx2GPz2STiW9zE9vXhOqWNiNLoIuE4rm72hDoAupMGe+kuHBpxRPBWfE1iOaEKRvD0TJvTNDzbn8npPP7Ls/wVc6wRUEOb6acpNrH/8VhcUCvQqRGnjv3BZvmi0TKvid64MvboToiXEl1jv9NE6lOv1SotXZbDSiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739400967; c=relaxed/simple;
	bh=/ixeuw+sP1h2HlhY+xFvfHUHI7nevOOg8s37LSTC0tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzx8OfbDn1nB8e6BhYala7hfzWt2ayNLGZlFt5lMoSJssgVvKX+Oq8wFd8q5ICHyZYFlshGixq9L/CtLYvRSjljOnatk98DQKTHh3Dq0mNgfm+yT4CDB3wwFY4HidkaYz3fCvzEus3ZTXBdNyEtA2lFJjkPB5U0q+67BVI0bdLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqkU3JYR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqkU3JYR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B7AC4CEDF;
	Wed, 12 Feb 2025 22:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739400967;
	bh=/ixeuw+sP1h2HlhY+xFvfHUHI7nevOOg8s37LSTC0tI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LqkU3JYRAbcPqbKej9sprTUJgj/cBZNUa+KqErDX9CnNGplxQ60VrA2ly+wwcOfk/
	 bMaIPZkIHYSe5FOoV09z1pbFnTX5s+ix+V75AYrZIBSd2bvm1QtGIqDwThZ9MyLN0r
	 SKs3d1HXw1teBKyx9XGACfic1E36RQjOhn7qTgPWvtE6WeiH3mBh3TvwHoUc1kehFa
	 itecSmpwrGQw+dijYNvt7/6HmlOuNYh4mvIE74NmNkkyxhx3RMSVG6SkUxmUVHebI2
	 LL4lh0GCvrxIEzOqPUR58mnO2nZaIocA6zUQUU5JZuV0NRKDGg2DxEdDyndf1GBXuv
	 UCCQt81cDqKrw==
Date: Wed, 12 Feb 2025 14:56:05 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, Hao Ge <gehao@kylinos.cn>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Levi Yun <yeoreum.yun@arm.com>, Xu Yang <xu.yang_2@nxp.com>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/10] Move uid filtering to BPF filters
Message-ID: <Z60nBQCetMzhRg5b@google.com>
References: <Z6panMzNSm1op8Di@google.com>
 <CAP-5=fUY83gifsMZA0Q45kiQQbAKp2uJxkuwrwGtHK2hiUFRDA@mail.gmail.com>
 <Z6rAHhAIdlkAryGJ@google.com>
 <CAP-5=fXjmJ+Rr7ejL6fCMeu6PZSit7n84hQkjh=0jQhkr1on3Q@mail.gmail.com>
 <Z6uOGNO6p7i9Fese@google.com>
 <CAP-5=fVxFe4nMS_dHmO=6-ddA40XbVdvouPLuOxj5cenjUr8ng@mail.gmail.com>
 <Z6v-mPJq6m61pFA4@google.com>
 <CAP-5=fU+-4igQomO4Q41=7xo6YWyDdVqJdZd34dcMUS-Ua=N1Q@mail.gmail.com>
 <Z6zslLa8XM1ubwXj@google.com>
 <CAP-5=fUrzPvV3sD1_wMzQ7dF8xk3hL9_nkdS6toFjt7L+SRsgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUrzPvV3sD1_wMzQ7dF8xk3hL9_nkdS6toFjt7L+SRsgg@mail.gmail.com>

On Wed, Feb 12, 2025 at 12:00:42PM -0800, Ian Rogers wrote:
> On Wed, Feb 12, 2025 at 10:46 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > It's not completely broken and works sometimes.
> 
> No this is the definition of completely broken. If it only works
> sometimes then you can't use it, we can't put a test on it, there is
> no point in it. Even when it doesn't fail on perf_event_open, does it
> work for processes that start after /proc is scanned? No, it is
> completely broken.

Ok, we have a different definition for it.  Let's ignore the imaginary
users of the broken features.  Have you added a test for this change?

Anyway I've tested your change and found some issues:

1. It silently exited when BPF-skel is not built.  Better to put some
   messages at least.

  $ sudo ./perf record -u $(id -u) -- sleep 1

2. Even with BPF-skel, perf record doesn't work well.  It did something
   but failed to get sample data for some reason.

  $ sudo ./perf record -u $(id -u) -- sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.045 MB perf.data ]
   
   Oh, I think you now need to pass -a because it now works in
   system-wide mode and drops samples for other users.

3. With BPF-skel, non-root users will see this.

  $ ./perf record -u $(id -u) -- sleep 1
  cannot get fd for 'filters' map
  failed to set filter "BPF" on event cycles:P with 13 (Permission denied)

   I think it's confusing and better to tell user that you need to run 
   'perf record --setup-filter pin' as root first.  But maybe due to the
   issue #2, you still need to run it as root.

Thanks,
Namhyung

