Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0449E15B102;
	Wed, 28 May 2025 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748458091; cv=none; b=ePhy1tvWE8K3kYFJ/Q/yY9WVjHX8HCCZVvHrU1fGB3JPG8eq7kly74jkqnMpkxCffTOvNh7cy1k5cnDdt1FFsikD3uLLNWK4yEmN1aaNJc7/rTzG0jm+niyA5a2Z0QSZOni8IYE5TqgHgeUI0w9tkP85k6UbflyuWYOLYrcIziM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748458091; c=relaxed/simple;
	bh=cT3taaq63q3YAPBypBJrgG0qDTsTKYvmsWAT6whtDTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOJSwUkmbDNB2fQMW0XDGIc31u3lo8p2BR1nGUFPshEYwjqdQCli9ixYGfXympvOyQVLiraDWabN3wvHkNi51NcuQhVTv9Xa9eDkREcIixlGROwgJZvMHS7Rg8Kd+43NQ3KbyN47AwFYO1ZLX9O5q94M/K+DB9OPaMEVFLqsm6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ds8wiysM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ds8wiysM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4E1C4CEE3;
	Wed, 28 May 2025 18:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748458090;
	bh=cT3taaq63q3YAPBypBJrgG0qDTsTKYvmsWAT6whtDTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ds8wiysMk3+oOVEWIhlompRxFmapZ5XRRf5ICyI43r7ow5P3cFUIYKFp4Ra3p+ueV
	 ScYMapxpx3xHyXqYCgSHLoe+tjAiHGaHn6x4FHNzJzutsUGCaYrblJAUSUxrlxaiF9
	 X3suxEp9N9ZR3grBp23iWJvkrc8y7qKduhFwDdMOV2eFomlLxsOkedyXFgK+neUwA8
	 DQIBf1SbKq/IWdS/MO5UgzI3FmSHF40exdeFjefNqbT043o4axRaBvJl6HU52WhE7n
	 AcxzuarkCEucpiMU+PHwOvZkgY6UNp3YB3aXB8Mmx2jOGVX9xHX4dDXGj1pYa21evV
	 9uoLZOdMbrzFQ==
Date: Wed, 28 May 2025 15:48:07 -0300
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
	James Clark <james.clark@linaro.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Zixian Cai <fzczx123@gmail.com>,
	Steve Clevenger <scclevenger@os.amperecomputing.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Martin Liska <martin.liska@hey.com>,
	Martin =?utf-8?B?TGnFoWth?= <m.liska@foxlink.cz>,
	Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] perf: Default use of build IDs and improvements
Message-ID: <aDdaZ0TMA5kwZ-iV@x1>
References: <20250428213409.1417584-1-irogers@google.com>
 <CAP-5=fVy6J+d1aoQwv6TMuybXWAhpeaJOvMmr3-jbsz5ig66kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVy6J+d1aoQwv6TMuybXWAhpeaJOvMmr3-jbsz5ig66kg@mail.gmail.com>

On Tue, May 27, 2025 at 01:48:43PM -0700, Ian Rogers wrote:
> On Mon, Apr 28, 2025 at 2:34 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Build ID mmap2 events have been available since Linux v5.12 and avoid
> > certain races. Enable these by default as discussed in:
> > https://lore.kernel.org/linux-perf-users/CAP-5=fXP7jN_QrGUcd55_QH5J-Y-FCaJ6=NaHVtyx0oyNh8_-Q@mail.gmail.com/
> >
> > The dso_id is used to indentify a DSO that may change by being
> > overwritten. The inode generation isn't present in /proc/pid/maps and
> > so was already only optionally filled in. With build ID mmap events
> > the other major, minor and inode varialbes aren't filled in. Change
> > the dso_id implementation to make optional values explicit, rather
> > than injecting a dso_id we want to improve it during find operations,
> > add the buildid to the dso_id for sorting and so that matching fails
> > when build IDs vary between DSOs.
> >
> > Mark the callchain for buildids and not just the sample IP, fixing
> > missing DSOs.
> >
> > Fix sample__for_each_callchain_node to populate the map even when
> > symbols aren't computed.
> >
> > Other minor bits of build_id clean up.
> >
> > v3: Ensure the struct build_id is initialized empty prior to use as
> >     read paths may fail (Namhyung).
> >
> > v2: Make marking DSOs still the default even with the defaulted build
> >     ID mmap. The command line option still disables this to avoid
> >     regressions. Add callchain patches and jitdump fix.
> 
> Ping. Thanks,
> Ian

⬢ [acme@toolbx perf-tools-next]$        git am ./v3_20250428_irogers_perf_default_use_of_build_ids_and_improvements.mbx
Applying: perf callchain: Always populate the addr_location map when adding IP
Applying: perf build-id: Reduce size of "size" variable
Applying: perf build-id: Truncate to avoid overflowing the build_id data
Applying: perf build-id: Change sprintf functions to snprintf
Applying: perf build-id: Mark DSO in sample callchains
Applying: perf build-id: Ensure struct build_id is empty before use
Applying: perf dso: Move build_id to dso_id
Applying: perf jitdump: Directly mark the jitdump DSO
Applying: perf record: Make --buildid-mmap the default
error: patch failed: tools/perf/builtin-record.c:3349
error: tools/perf/builtin-record.c: patch does not apply
Patch failed at 0009 perf record: Make --buildid-mmap the default
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
⬢ [acme@toolbx perf-tools-next]$

- Arnaldo
