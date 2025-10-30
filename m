Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E017735504F;
	Thu, 30 Oct 2025 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829788; cv=none; b=uKNCbIFa5HcrC0JiOMuugvB2eXHT19rRGwHR2sG3+UTWxP50W13nla0BiUT44E6LCXTfd9QddL8RRpBePhzXREPmIbWjae9EVg5+UPMUYR1s6CepwNxHlyX9pFmUU/BZ0+4Uu9vmiFD7SsJkWR4oh59KNwK4tsZDV+iOH7ny81M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829788; c=relaxed/simple;
	bh=SUrknLG6QL1vQeKkYQ9LgNsZWR2AlazjvKoTTCaah5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQXirzIltLE9vaduRx7MESU/1dUshzbFVMWWAROvsljsQOutWtQs8bQaEcUz/ApbFGoQjkNJPzNy3O4yUGVsF0erGyEZN/RAbIKy1rFJOlUG2qp+j+aIEucq9/sVvTpvuMW0inub3+vZVml7UACNsX8sp0D3fMGox2r4yIs36fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNbbo1TN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNbbo1TN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B796AC116C6;
	Thu, 30 Oct 2025 13:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761829787;
	bh=SUrknLG6QL1vQeKkYQ9LgNsZWR2AlazjvKoTTCaah5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NNbbo1TNVYrGDJMyIf32j6DBUmdBhPNsSdrOSV5SUrhahDUEescR04yjH5RFV2e6t
	 x82u6S9t/s8K/GdbKNbq5hxjFgK2NgkEH/22IsycijNKYYbfoMA/WyCyC/wz+irwDH
	 QNagLe62maPjlla9DDEP5BWBKZ/zGw1Mad066mC+Nfg/6gxzVU5UGDwIxUP2+rCeqX
	 QNejnQwqVVz0JVZWFri83rQYt3tlC+qlOUb8Usw7xEtt6YjLaM08aDba7emI+1s7wK
	 Pr/BaD8lqA+rpD50JZ9n60iQWAvQZUDs2gRxrNetylBqhMHnhr2bPCDbEg/RE9FA0Z
	 i91DMj5owhaAg==
Date: Thu, 30 Oct 2025 10:09:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Howard Chu <howardchu95@gmail.com>, Song Liu <song@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Levi Yun <yeoreum.yun@arm.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Blake Jones <blakejones@google.com>,
	Anubhav Shelat <ashelat@redhat.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
	Weilin Wang <weilin.wang@intel.com>
Subject: Re: [RFC PATCH v1 12/15] perf evlist: Add reference count
Message-ID: <aQNjmD6hh8rhaACb@x1>
References: <20251029053413.355154-1-irogers@google.com>
 <20251029053413.355154-13-irogers@google.com>
 <aQI_OJziRPMRqzM9@x1>
 <CAP-5=fXz+tG-6q54FNY2OrKcz4zjncRXEWzV8E2suXmOA4MzEw@mail.gmail.com>
 <aQJeEFKHUfevLB50@x1>
 <CAP-5=fX=oDBeJ4aLW4ARB3x_=UJ7zSYQWjJf28E2jgTc_rxJyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX=oDBeJ4aLW4ARB3x_=UJ7zSYQWjJf28E2jgTc_rxJyg@mail.gmail.com>

On Wed, Oct 29, 2025 at 02:12:11PM -0700, Ian Rogers wrote:
> On Wed, Oct 29, 2025 at 11:33 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> > On Wed, Oct 29, 2025 at 09:56:50AM -0700, Ian Rogers wrote:
> > > On Wed, Oct 29, 2025 at 9:22 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> > > > On Tue, Oct 28, 2025 at 10:34:10PM -0700, Ian Rogers wrote:
> > > > > This a no-op for most of the perf tool. The reference count is set to
> > > > > 1 at allocation, the put will see the 1, decrement it and perform the
> > > > > delete. The purpose for adding the reference count is for the python
> > > > > code. Prior to this change the python code would clone evlists, but
> > > > > this has issues if events are opened, etc. This change adds a
> > > > > reference count for the evlists and a later change will add it to
> > > > > evsels. The combination is needed for the python code to operate
> > > > > correctly (not hit asserts in the evsel clone), but the changes are
> > > > > broken apart for the sake of smaller patches.

> > > > Looks ok, noisy for all the s/delete/put/ but that is ok, but then you
> > > > are not using the RC_CHK_ACCESS stuff from the get go, why not?

> > > So if I did RC_CHK_ACCESS then every evsel access would need updating,

> > Fair enough, I think it would be informative to have a comment
> > mentioning this near the refcount_t to avoid this question popping up
> > again.
 
> Sgtm. I think we can also add the RC_CHK_ACCESS to evlist as that is a
> boring blob of a thing to pass around.
 
> How are things outside of this? The python changes, how to do the
> process_events callbacks, etc. Any thoughts on the tool API vs the
> script API (stat vs stat_round) ?

I'll try and resume reviewing at that point, but I don't antecipate
problems and like the direction of this work.

- Arnaldo
