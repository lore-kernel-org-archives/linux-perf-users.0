Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BFD27442;
	Fri, 25 Apr 2025 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592328; cv=none; b=GlPV58TlShenwG281uUMwyVsleyzJ/bqZsVB//c//pqMxiNKYVc07sQMSkiTPSRU6fb+h3wafMUxXMrOu9Il0p/vn3M+O4WjTYHuz2gc4wkjo0C4TysgtJCmbhqXs59XtFm/k/qqeLcCAamlmZ03D1IiuaRmQ+/1Z44aT867te8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592328; c=relaxed/simple;
	bh=3aszn78wDHY26MZWaW7gHNMdRUzRJGQMF00IYaHmUEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKF8Y8/1bkhLzk6KXxjU9b8AWZUO77hzLW5RdIx+5+onFcLIyvmhWJ4kOSYTcrz0xod8G/uXt9lmHPl2UH9xmXm2TsIwx0OMFlr5vlM4sKT/8MiILwabYyeZUii7Qj6sX/9BwI7f6ySGEtH2BLE2Ji1pWtnebXBdkDI2PDUGFZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LROELy5d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LROELy5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8599C4CEE4;
	Fri, 25 Apr 2025 14:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745592328;
	bh=3aszn78wDHY26MZWaW7gHNMdRUzRJGQMF00IYaHmUEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LROELy5dEtL0zBKXwvrAJJA/6jN1inizSwk5kXUfWVFNGDZhriPUySn6jctyoGJCW
	 3rtMqgQ4cYLgGG5cwtuiUYAc9WYpcOlwkkDRsz11XfyUpMMXbYpRSwCFRsj3ai81Bk
	 7MvynbJi2XCkMitLbpSS9ePJfcJHmePukUrOwHz607Sy6Xsce4zZcS3bOKv60XCrw4
	 bl+hdu1+0xfM3NXPgtgiIE6ykPTmak8Zfd8C15+BwjSyx+a3anV4h/iDWeGAP2c9UP
	 LxXpkSq1AU49yzl9nid03oq7UdKixscWD4m8TfV1zgE/29U3yGngAHTLh0tI9HEWd6
	 2ohMtEi7x9A4g==
Date: Fri, 25 Apr 2025 11:45:25 -0300
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
Message-ID: <aAugBbpOHQyu7YK2@x1>
References: <20250424061943.1321025-1-irogers@google.com>
 <20250424061943.1321025-6-irogers@google.com>
 <CAP-5=fXHay1Qn7c3JUe4nH-cTw8zPhPv6-XWMZdPKpwwT=9n2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXHay1Qn7c3JUe4nH-cTw8zPhPv6-XWMZdPKpwwT=9n2w@mail.gmail.com>

On Thu, Apr 24, 2025 at 12:20:44AM -0700, Ian Rogers wrote:
> On Wed, Apr 23, 2025 at 11:19 PM Ian Rogers <irogers@google.com> wrote:
> > @@ -1795,7 +1796,8 @@ record__finish_output(struct record *rec)
> >                         data->dir.files[i].size = lseek(data->dir.files[i].fd, 0, SEEK_CUR);
> >         }
> >
> > -       if (!rec->no_buildid) {
> > +       /* Buildid scanning disabled or build ID in kernel and synthesized map events. */
> > +       if (!rec->no_buildid && !rec->buildid_mmap) {
 
> So I think this is wrong. It matches current behaviors, but it is
> wrong. If we don't process the kernel's mmap events the DSOs won't be
> loaded and the build ID cache won't contain the DSOs. There is also
> the bug that the sample processing to find maps to find DSOs, doesn't
> handle call chains. Given the broken nature of the build ID cache I'm
> not sure it makes any sense for perf record to be by default
> populating it. I think it probably makes sense to consider the default
> population a legacy feature and make -N the default along with
> --buildid-mmap.

The first four patches are good fixes/cleanups, so I'm picking them, ok?

- Arnaldo
