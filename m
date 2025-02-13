Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AF780034;
	Thu, 13 Feb 2025 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739411069; cv=none; b=MsZQAGip0xJAQYxcTrv5/JyPcZkTf/1v7juT92mBVkH/y6Lefg7ijQkqw5qo1Z/EG9LiBq4ocmIqwbsNKGq5mGEKnGDzpnzOpTBt1NsyGiZKW0/aY2ciesUiYjfV6NNhhMGm1tEhNCtC74bLQhhb+cqXO7E80x8esTJULCo4FmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739411069; c=relaxed/simple;
	bh=wzUJkID6PgklgGpm0weU8DjYBBZpfzyA5yAhlyuAsG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpjeOTlD4X2SiWlZ/SiF69l1ehC4Kbpdsh4TuJKwhLPYRkMbg3XvuRPbhK5VosVK7Rur0VaAMHn1B2ChUjtlNcAOh7rhijhSFF/HPkuFHOIM+cDHp4mDVWB2q/fGu3yI2+Josthrq09NZYagKAe1YC3/txBIWiBcn2CE0+1ymW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxmfcJ0c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxmfcJ0c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A51C4CEDF;
	Thu, 13 Feb 2025 01:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739411068;
	bh=wzUJkID6PgklgGpm0weU8DjYBBZpfzyA5yAhlyuAsG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MxmfcJ0cVtyMjA9UmTwDiDTwP6zb603GgyKEXaWMW5F1ZA1fNvbyHCxhlnX7EU3iG
	 gz3nt7ngw2IjzHpSdpEVq9GaKj7tJm2LHcPweuWQ6xNjOKTr8fVEdMpsYY+pSO8K6b
	 WXvZbxZriCGIn8ZFgsTfHExcNYkoeRkc/j63P95SFhhMjh5GW56dQr1H8R6/oK51qn
	 IXRGwxopzg2C9odZ0O8ikyZUQtawVACT3uQMjmvMSJmtcEotydwTzsOLDWxxjAVDmw
	 kpDfo7FGjJJ0OVIhzA89bJXD8waO1TOs4nt3wWCQsP8K5rmBKOfFeYqdL9udp0iNUx
	 2gJ36ih0JT2qg==
Date: Wed, 12 Feb 2025 17:44:24 -0800
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
Message-ID: <Z61OeArP-P-I5NjU@google.com>
References: <Z6rAHhAIdlkAryGJ@google.com>
 <CAP-5=fXjmJ+Rr7ejL6fCMeu6PZSit7n84hQkjh=0jQhkr1on3Q@mail.gmail.com>
 <Z6uOGNO6p7i9Fese@google.com>
 <CAP-5=fVxFe4nMS_dHmO=6-ddA40XbVdvouPLuOxj5cenjUr8ng@mail.gmail.com>
 <Z6v-mPJq6m61pFA4@google.com>
 <CAP-5=fU+-4igQomO4Q41=7xo6YWyDdVqJdZd34dcMUS-Ua=N1Q@mail.gmail.com>
 <Z6zslLa8XM1ubwXj@google.com>
 <CAP-5=fUrzPvV3sD1_wMzQ7dF8xk3hL9_nkdS6toFjt7L+SRsgg@mail.gmail.com>
 <Z60nBQCetMzhRg5b@google.com>
 <CAP-5=fWG7JOmQhTa+OccOxSLhik6Du-qy9d90q-zhDTu0P=q3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWG7JOmQhTa+OccOxSLhik6Du-qy9d90q-zhDTu0P=q3A@mail.gmail.com>

On Wed, Feb 12, 2025 at 03:17:35PM -0800, Ian Rogers wrote:
> On Wed, Feb 12, 2025 at 2:56 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Feb 12, 2025 at 12:00:42PM -0800, Ian Rogers wrote:
> > > On Wed, Feb 12, 2025 at 10:46 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > It's not completely broken and works sometimes.
> > >
> > > No this is the definition of completely broken. If it only works
> > > sometimes then you can't use it, we can't put a test on it, there is
> > > no point in it. Even when it doesn't fail on perf_event_open, does it
> > > work for processes that start after /proc is scanned? No, it is
> > > completely broken.
> >
> > Ok, we have a different definition for it.  Let's ignore the imaginary
> > users of the broken features.  Have you added a test for this change?
> >
> > Anyway I've tested your change and found some issues:
> >
> > 1. It silently exited when BPF-skel is not built.  Better to put some
> >    messages at least.
> >
> >   $ sudo ./perf record -u $(id -u) -- sleep 1
> >
> > 2. Even with BPF-skel, perf record doesn't work well.  It did something
> >    but failed to get sample data for some reason.
> >
> >   $ sudo ./perf record -u $(id -u) -- sleep 1
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 0.045 MB perf.data ]
> >
> >    Oh, I think you now need to pass -a because it now works in
> >    system-wide mode and drops samples for other users.
> 
> This is a pre-existing problem, no?

No, it worked without -a in the past.  Please see my previous reply.
I think -u/--uid is one of the supported target in the perf tool (not
for the system call) and it used to disable system-wide mode if -u is
used at the same time.

Thanks,
Namhyung

> 
> > 3. With BPF-skel, non-root users will see this.
> >
> >   $ ./perf record -u $(id -u) -- sleep 1
> >   cannot get fd for 'filters' map
> >   failed to set filter "BPF" on event cycles:P with 13 (Permission denied)
> >
> >    I think it's confusing and better to tell user that you need to run
> >    'perf record --setup-filter pin' as root first.  But maybe due to the
> >    issue #2, you still need to run it as root.
> >
> > Thanks,
> > Namhyung
> >
