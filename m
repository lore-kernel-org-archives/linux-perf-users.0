Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1767E25E802;
	Fri, 25 Apr 2025 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593189; cv=none; b=HDp6NQKW5KO/fAeF2otlV4n9iE/mdR1As7eWcvYGSQRhYERBtUlRlTF+aoLQijqcPyt0BdBlkg5ZHjnO6U/YUDz5OeM3rnuSt+PpGtqa90AytxmVYiWmulyyUuZ/aqijucTHJFzD8J7OzA2hRbMxLQRAmuXJJVowGFTPmXQnpZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593189; c=relaxed/simple;
	bh=D/VOhDbMJOCUJefOhLEL64SVfg5EbI+bkP1ni4ll3kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EW9RAlEuRCY97JGjtyoUmBdbiAHdRewJRX5WicF6zMr4m5e5Nb5bmw3dHNyqFJZ//pv5Gv9wcgdjVlt32jSycgamk58pT2ZUFKiss2nhSodJe4hM1r5r2M/V12JHNXcqcNoEDWlCwyEyq+HRfy+msMAhimMLgM03lkYJBaQHBK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXelMUkR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXelMUkR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1903EC4CEE9;
	Fri, 25 Apr 2025 14:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745593187;
	bh=D/VOhDbMJOCUJefOhLEL64SVfg5EbI+bkP1ni4ll3kE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXelMUkRht4xIpCkvFTkz+pQbQhzinYKVZpWyfaUgx6dqCAHLppgIr8zadl4xbqhs
	 ePH8gHu1ZxsyoVhf+Gk74uDmrEBcjW7zdu7/mCJMlXchNhZW3uLEuxyF0PecIVVO1c
	 GUVsN2OH6wg+9TTfUs6mlJHNNs8wyi61BRRUo2tYPgUYfg6m1KrMNc9TDbokgw0DJX
	 tsSpzdeT/RmQ+KmHl6dnL+ECy8piEiVOb6VvY2LpKZVizQtgQojzJLfyTo17BPpsVn
	 W3SoonNmEGFWf1FSjFiaythdf3/t2/bnUkIG2/aahe2YeZvzG8bZYmPMEjNVqiAh6O
	 j3n65W98apwLw==
Date: Fri, 25 Apr 2025 11:59:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	James Clark <james.clark@linaro.org>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Leo Yan <leo.yan@arm.com>,
	Steve Clevenger <scclevenger@os.amperecomputing.com>,
	Zixian Cai <fzczx123@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Martin Liska <martin.liska@hey.com>,
	Martin =?utf-8?B?TGnFoWth?= <m.liska@foxlink.cz>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] perf record: Make --buildid-mmap the default
Message-ID: <aAujYQH3yla8q3UQ@x1>
References: <20250424061943.1321025-1-irogers@google.com>
 <20250424061943.1321025-6-irogers@google.com>
 <CAP-5=fXHay1Qn7c3JUe4nH-cTw8zPhPv6-XWMZdPKpwwT=9n2w@mail.gmail.com>
 <aAugBbpOHQyu7YK2@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aAugBbpOHQyu7YK2@x1>

On Fri, Apr 25, 2025 at 11:45:28AM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Apr 24, 2025 at 12:20:44AM -0700, Ian Rogers wrote:
> > On Wed, Apr 23, 2025 at 11:19 PM Ian Rogers <irogers@google.com> wrote:
> > > @@ -1795,7 +1796,8 @@ record__finish_output(struct record *rec)
> > >                         data->dir.files[i].size = lseek(data->dir.files[i].fd, 0, SEEK_CUR);
> > >         }
> > >
> > > -       if (!rec->no_buildid) {
> > > +       /* Buildid scanning disabled or build ID in kernel and synthesized map events. */
> > > +       if (!rec->no_buildid && !rec->buildid_mmap) {
>  
> > So I think this is wrong. It matches current behaviors, but it is
> > wrong. If we don't process the kernel's mmap events the DSOs won't be
> > loaded and the build ID cache won't contain the DSOs. There is also
> > the bug that the sample processing to find maps to find DSOs, doesn't
> > handle call chains. Given the broken nature of the build ID cache I'm
> > not sure it makes any sense for perf record to be by default
> > populating it. I think it probably makes sense to consider the default
> > population a legacy feature and make -N the default along with
> > --buildid-mmap.
> 
> The first four patches are good fixes/cleanups, so I'm picking them, ok?

I (and b4) missed v2, looking at it now.

- Arnaldo
