Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230E46EB65;
	Tue,  7 May 2024 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715116052; cv=none; b=iv6u9bdlNTN/SZCknEHf0Ivb3r6ROlxMAr62LybmJxbIztUGhJmbx8hPWiLq3yEZCmnDecH89L3qToe7ISzhPrnN8M9gSdJd2hpkGmcBz/iWxYI1vHjzRP5A6qc3TKc0WEcRjB7EsufaRL7+t7yRrL/fl5OIb5lv9iqOuUc36yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715116052; c=relaxed/simple;
	bh=IruPKvmHK22rd3Atyzt9f//OhnIvVhMuPrqqtt9DPSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGzEPq/PiZgj3Sv60NPYL1o2a4VRHCeIs8woOlWCsZZJShqUOZ6WQ9jB864XAdG01ZIb3DbkReu0szKebOq5sqV4XKkB/6bAl3sfQtoWJEbEsCtn1YPLIqhSrkVEGRFzh0faEfwOpvFCEMdZeAhuA9XkEnj2lXuTOP85Pb58g0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRar/O50; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRar/O50"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A36C2BBFC;
	Tue,  7 May 2024 21:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715116050;
	bh=IruPKvmHK22rd3Atyzt9f//OhnIvVhMuPrqqtt9DPSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JRar/O50ZvQKN+7xk/G/FDvHxyqaReRGL5ZpbC7aLsA36ByRqjQtnamcnNiR7/03U
	 do6YQFagyR+x3Y+Sw0spCnqH2O/z/Ys0q+9J8Dr86991ivYuoZNgESUtNstMJYI/Hj
	 z+ea713knJ+yIw0fkiXkFLHQcY+rzHC8o04ew8Xqsk+gUP0Qr2emt1XZdiggJoq85v
	 h95cP/YanIE9j4eQwPntPjoan/WzBDfyx6XX1a9QAmsk7nZu1mR1P7SX8aR/rAOwca
	 Wx9javJMlil7LRIJwFAgSuWkwVzsUXT0yfsSzXPJh+UpuaV8cE8vonzh8aQs6CNU/3
	 e7LdQuEoqDgTQ==
Date: Tue, 7 May 2024 18:07:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Clark <james.clark@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Kajol Jain <kjain@linux.ibm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>, Li Dong <lidong@vivo.com>,
	Paran Lee <p4ranlee@gmail.com>, Ben Gainey <ben.gainey@arm.com>,
	Andi Kleen <ak@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/8] perf ui browser: Don't save pointer to stack
 memory
Message-ID: <ZjqYD-q7EqQW6hVE@x1>
References: <20240507183545.1236093-1-irogers@google.com>
 <20240507183545.1236093-2-irogers@google.com>
 <ZjqNKPgWR7mBFaV4@x1>
 <ZjqNjrJ2ElrT11iB@x1>
 <CAP-5=fUsQwKsCi3us+dp-Tj+PayNPrYTqTQeo-YLbvSuOt1=9w@mail.gmail.com>
 <ZjqXa25BnFncJmw-@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjqXa25BnFncJmw-@x1>

On Tue, May 07, 2024 at 06:04:43PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, May 07, 2024 at 01:48:28PM -0700, Ian Rogers wrote:
> > On Tue, May 7, 2024 at 1:22 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > >
> > > On Tue, May 07, 2024 at 05:20:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Tue, May 07, 2024 at 11:35:38AM -0700, Ian Rogers wrote:
> > > > > ui_browser__show is capturing the input title that is stack allocated
> > > > > memory in hist_browser__run. Avoid a use after return by strdup-ing
> > > > > the string.
> > > >
> > > > But everything happens in that context, i.e. hist_brower__run() will
> > > > call ui_browser__ methods and then exit.
> > > >
> > > > We end up having browser->title pointing to returned stack memory
> > > > (invalid) but there will be no references to it, no?
> > > >
> > > > If we return to hist_browser__run() we then call ui_browser__show
> > > > passing a new title, for "live" stack memory, rinse repeat. Or have you
> > > > noticed an actual use-after-"free"?
> > >
> > > And I'll take the patch, I'm just trying to figure it out if it fixed a
> > > real bug or if it just makes the code more future proof, i.e. to avoid
> > > us adding code that actually uses invalid stack memory.
> > 
> > My command line using tui is:
> > $ sudo bash -c 'rm /tmp/asan.log*; export
> > ASAN_OPTIONS="log_path=/tmp/asan.log"; /tmp/perf/perf mem record -a
> > sleep 1; /tmp/perf/perf mem report'
> > I then go to the perf annotate view and quit. This triggers the asan
> > error (from the log file):
> > ```
> 
> Thanks, it is indeed a bug, I'll keep that Fixes tag, people interested
> in the full details can hopefully find this message going from the Link:
> tag.

Nah, I added your explanation to the cset log message.

Thanks,

- Arnaldo
