Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ECF1C5792;
	Tue,  6 Aug 2024 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951156; cv=none; b=WZ2AT2nI1vTTTkdwCBR+RaQa3EXSZUvbveYv6TOKTYGroG1sVw0C/R4QRH5aHChcv7sHjSbFhPbnjGls/PfAZ9HmryscssjFh4kxKcgDnEg4YhXsNJeMGAVtjf1sxNnAdmmiScAWfHETuXpMUHY8tkGbgNY/1FfAqtPugK+Q4So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951156; c=relaxed/simple;
	bh=1/hOT1teYDjCnab1J6u5zZvPN7xUqhdY7qulzsyiAHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBprTscBYYIsgQ72lH5ZZQKVNWjYHhwCyWhLRIOQFa6F2aA1qOg6IbN+cvRoz+EI0bpIIQhbCNnN+gH1/0qs85WO6clfl5KotqWhzfarFoolC6nho+gEIA0vqxsy48UifbhSFWympOTegvX4E1hScIbZ0f5vygxwRrxkNClDW2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHewcVbL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHewcVbL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97CDC4AF0C;
	Tue,  6 Aug 2024 13:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722951156;
	bh=1/hOT1teYDjCnab1J6u5zZvPN7xUqhdY7qulzsyiAHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HHewcVbLVQgPrwbAgB79Lrw0faT8+P71+hgPYj+krUOO3dQIVnPlAGjOq1XxJtchm
	 hH76BeDhZNbxqsfdddj5AyWLlYpe+dzkYLfGnydr29bK86gJHPd33AgEAezXL+BvyA
	 ustquKIo7gRg20dBD0GOemtP6uUL9U1BfPPw3oHDAbrs1H5se69VA1zHUB5MEnwBsD
	 2kZnt5W4kmr93aMyd8LkD5fYqiOGsjuslsmWdV2QAlRhzJW4UrZpZJ+gG4XQGrmsV0
	 TrT8xJPUjsEqDx88Ax97QNLdU8BVI5kpab1gJLsrwKM4pupSmieC+l55slWpuPNN/H
	 fwjsRbrX6rs8g==
Date: Tue, 6 Aug 2024 10:32:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, weilin.wang@intel.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v18 0/8] TPEBS counting mode support
Message-ID: <ZrIl8NCHkIVHQVt2@x1>
References: <20240720062102.444578-1-weilin.wang@intel.com>
 <CAM9d7cgoTyf3Zjt=+2yZi5Pat4UrxKxN=rkLHmyUWZqwZk8_Kw@mail.gmail.com>
 <CAP-5=fWr2Qna9ikzUCFavo3OTUDSP3ztr=i6E=R962CXCdHckg@mail.gmail.com>
 <ZrEpJxtm5zlp5rbo@x1>
 <CAP-5=fVTaHdiF8G2Dn=vnguvoapa_+ZKsQ7Wy3z51K9nDZQUtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVTaHdiF8G2Dn=vnguvoapa_+ZKsQ7Wy3z51K9nDZQUtg@mail.gmail.com>

On Mon, Aug 05, 2024 at 04:33:44PM -0700, Ian Rogers wrote:
> On Mon, Aug 5, 2024 at 12:34 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Mon, Aug 05, 2024 at 08:10:12AM -0700, Ian Rogers wrote:
> > > On Mon, Jul 22, 2024 at 10:38 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Hello Weilin,
> > > >
> > > > On Fri, Jul 19, 2024 at 11:21 PM <weilin.wang@intel.com> wrote:
> > > > >
> > > > > From: Weilin Wang <weilin.wang@intel.com>
> > > > >
> > > > > Change in v18:
> > > > >  - Update to exit 2 in TPEBS shell test when not on Intel platform.
> > > > >  - Several updates to use EVLIST_CTL_CMD_ENABLE_TAG, EVLIST_CTL_CMD_ACK_TAG, and
> > > > >  etc.
> > > > >
> > > > > Changes in v17:
> > > > >  - Add a poll on control fifo ack_fd to ensure program returns successfully when
> > > > >  perf record failed for any reason.
> > > > >  - Add a check in the tpebs test to only run on Intel platforms.
> > > > >
> > > > > Changes in v16:
> > > > >  - Update tpebs bash test code and variable name.
> > > > >  - Add a check to ensure only use "-C" option when cpumap is not "-1" when
> > > > >  forking "perf record".
> > > > >
> > > > > Changes in v15:
> > > > >  - Revert changes added for python import test failure in v14 because the code
> > > > >  works correctly with the new python build code.
> > > > >  - Update the command line option to --record-tpebs.
> > > > >
> > > > > Changes in v14:
> > > > >  - Fix the python import test failure. We cannot support PYTHON_PERF because it
> > > > >  will trigger a chain of dependency issues if we add intel-tpebs.c to it. So,
> > > > >  only enable tpebs functions in evsel and evlist when PYTHON_PERF is not
> > > > >  defined.
> > > > >  - Fix shellcheck warning for the tpebs test.
> > > > >
> > > > > Changes in v13:
> > > > >  - Add document for the command line option and fix build error in non-x86_64.
> > > > >  - Update example with non-zero retire_latency value when tpebs recording is
> > > > >  enabled.
> > > > >  - Add tpebs_stop() back to tpebs_set_evsel() because in hybrid platform, when
> > > > >  the forked perf record is not killed, the reader thread does not get any
> > > > >  sampled data from the PIPE. As a result, tpebs_set_evesel() will always return
> > > > >  zero on retire_latency values. This does not happen on my test GNR machine.
> > > > >  Since -I is not supported yet, I think we should add tpebs_stop() to ensure
> > > > >  correctness for now. More investigation is required here when we work on
> > > > >  supporting -I mode.
> > > > >  - Rebase code on top of perf-tools-next.
> > > > >
> > > > > Changes in v12:
> > > > >  - Update MTL metric JSON file to include E-Core TMA3.6 changes.
> > > > >  - Update comments and code for better code quality. Keep tpebs_start() and
> > > > >  tpebs_delete() at evsel level for now and add comments on these functions with
> > > > >  more details about potential future changes. Remove tpebs_stop() call from
> > > > >  tpebs_set_evsel(). Simplify the tpebs_start() and tpebs_stop()/tpebs_delete()
> > > > >  interfaces. Also fixed the bugs on not freed "new" pointer and the incorrect
> > > > >  variable value assignment to val instead of counter->val.
> > > > >
> > > > > Changes in v11:
> > > > >  - Make retire_latency evsels not opened for counting. This works correctly now
> > > > >  with the code Namhyung suggested that adjusting group read size when
> > > > >  retire_latency evsels included in the group.
> > > > >  - Update retire_latency value assignment using rint() to reduce precision loss
> > > > >  while keeping code generic.
> > > > >  - Fix the build error caused by not used variable in the test.
> > > > >
> > > > > Other changes in v10:
> > > > >  - Change perf record fork from perf stat to evsel. All the major operations
> > > > >  like tpebs start, stop, read_evsel should directly work through evsel.
> > > > >  - Make intel-tpebs x86_64 only. This change is cross-compiled to arm64.
> > > > >  - Put tpebs code to intel-tepbs and simplify intel-tpebs APIs to minimum number
> > > > > of functions and variables. Update funtion name and variable names to use
> > > > > consistent prefix. Also improve error handling.
> > > > >  - Integrate code patch from Ian for the :R parser.
> > > > >  - Update MTL metrics to TMA 4.8.
> > > > >
> > > > > V9: https://lore.kernel.org/all/20240521173952.3397644-1-weilin.wang@intel.com/
> > > > >
> > > > > Changes in v9:
> > > > >  - Update the retire_latency result print and metric calculation method. Plugin
> > > > > the value to evsel so that no special code is required.
> > > > >  - Update --control:fifo to use pipe instead of named pipe.
> > > > >  - Add test for TPEBS counting mode.
> > > > >  - Update Document with more details.
> > > > >
> > > > > Changes in v8:
> > > > >  - In this revision, the code is updated to base on Ian's patch on R modifier
> > > > > parser https://lore.kernel.org/lkml/20240428053616.1125891-3-irogers@google.com/
> > > > > After this change, there is no special code required for R modifier in
> > > > > metricgroup.c and metricgroup.h files.
> > > > >
> > > > > Caveat of this change:
> > > > >   Ideally, we will need to add special handling to skip counting events with R
> > > > > modifier in evsel. Currently, this is not implemented so the event with :R will
> > > > > be both counted and sampled. Usually, in a metric formula that uses retire_latency,
> > > > > it would already require to count the event. As a result, we will endup count the
> > > > > same event twice. This should be able to be handled properly when we finalize our
> > > > > design on evsel R modifier support.
> > > > >
> > > > >  - Move TPEBS specific code out from main perf stat code to separate files in
> > > > > util/intel-tpebs.c and util/intel-tpebs.h. [Namhyung]
> > > > >  - Use --control:fifo to ack perf stat from forked perf record instead of sleep(2) [Namhyung]
> > > > >  - Add introductions about TPEBS and R modifier in Documents. [Namhyung]
> > > > >
> > > > >
> > > > > Changes in v7:
> > > > >  - Update code and comments for better code quality [Namhyung]
> > > > >  - Add a separate commit for perf data [Namhyung]
> > > > >  - Update retire latency print function to improve alignment [Namhyung]
> > > > >
> > > > > Changes in v6:
> > > > >  - Update code and add comments for better code quality [Namhyung]
> > > > >  - Remove the added fd var and directly pass the opened fd to data.file.fd [Namhyung]
> > > > >  - Add kill() to stop perf record when perf stat exists early [Namhyung]
> > > > >  - Add command opt check to ensure only start perf record when -a/-C given [Namhyung]
> > > > >  - Squash commits [Namhyung]
> > > > >
> > > > > Changes in v5:
> > > > >  - Update code and add comments for better code quality [Ian]
> > > > >
> > > > > Changes in v4:
> > > > >  - Remove uncessary debug print and update code and comments for better
> > > > > readability and quality [Namhyung]
> > > > >  - Update mtl metric json file with consistent TmaL1 and TopdownL1 metricgroup
> > > > >
> > > > > Changes in v3:
> > > > >  - Remove ':' when event name has '@' [Ian]
> > > > >  - Use 'R' as the modifier instead of "retire_latency" [Ian]
> > > > >
> > > > > Changes in v2:
> > > > >  - Add MTL metric file
> > > > >  - Add more descriptions and example to the patch [Arnaldo]
> > > > >
> > > > > Here is an example of running perf stat to collect a metric that uses
> > > > > retire_latency value of event MEM_INST_RETIRED.STLB_HIT_STORES on a MTL system.
> > > > >
> > > > > In this simple example, there is no MEM_INST_RETIRED.STLB_HIT_STORES sample.
> > > > > Therefore, the MEM_INST_RETIRED.STLB_HIT_STORES:p count and retire_latency value
> > > > > are all 0.
> > > > >
> > > > > ./perf stat -M tma_dtlb_store -a -- sleep 1
> > > > >
> > > > > [ perf record: Woken up 1 times to write data ]
> > > > > [ perf record: Captured and wrote 0.000 MB - ]
> > > > >
> > > > >  Performance counter stats for 'system wide':
> > > > >
> > > > >        181,047,168      cpu_core/TOPDOWN.SLOTS/          #      0.6 %  tma_dtlb_store
> > > > >          3,195,608      cpu_core/topdown-retiring/
> > > > >         40,156,649      cpu_core/topdown-mem-bound/
> > > > >          3,550,925      cpu_core/topdown-bad-spec/
> > > > >        117,571,818      cpu_core/topdown-fe-bound/
> > > > >         57,118,087      cpu_core/topdown-be-bound/
> > > > >             69,179      cpu_core/EXE_ACTIVITY.BOUND_ON_STORES/
> > > > >              4,582      cpu_core/MEM_INST_RETIRED.STLB_HIT_STORES/
> > > > >         30,183,104      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/
> > > > >         30,556,790      cpu_core/CPU_CLK_UNHALTED.THREAD/
> > > > >            168,486      cpu_core/DTLB_STORE_MISSES.WALK_ACTIVE/
> > > > >               0.00 MEM_INST_RETIRED.STLB_HIT_STORES:p       0        0
> > > > >
> > > > >        1.003105924 seconds time elapsed
> > > > >
> > > > > v1:
> > > > > TPEBS is one of the features provided by the next generation of Intel PMU.
> > > > > Please refer to Section 8.4.1 of "Intel® Architecture Instruction Set Extensions
> > > > > Programming Reference" [1] for more details about this feature.
> > > > >
> > > > > This set of patches supports TPEBS in counting mode. The code works in the
> > > > > following way: it forks a perf record process from perf stat when retire_latency
> > > > > of one or more events are used in a metric formula. Perf stat would send a
> > > > > SIGTERM signal to perf record before it needs the retire latency value for
> > > > > metric calculation. Perf stat will then process sample data to extract the
> > > > > retire latency data for metric calculations. Currently, the code uses the
> > > > > arithmetic average of retire latency values.
> > > > >
> > > > > [1] https://www.intel.com/content/www/us/en/content-details/812218/intel-architecture-instruction-set-extensions-programming-reference.html?wapkw=future%20features
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > Ian Rogers (1):
> > > > >   perf parse-events: Add a retirement latency modifier
> > > > >
> > > > > Weilin Wang (7):
> > > > >   perf data: Allow to use given fd in data->file.fd
> > > > >   perf stat: Fork and launch perf record when perf stat needs to get
> > > > >     retire latency value for a metric.
> > > > >   perf stat: Plugin retire_lat value from sampled data to evsel
> > > > >   perf vendor events intel: Add MTL metric json files
> > > > >   perf stat: Add command line option for enabling tpebs recording
> > > > >   perf Document: Add TPEBS to Documents
> > > > >   perf test: Add test for Intel TPEBS counting mode
> > > >
> > > > Thanks for your persistence!
> > > >
> > > > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> > >
> > > Ping.
> >
> > I guess Namhyung's reviewed-by should suffice, but since you're pinging
> > and I saw previous comments about this serie, would it be possible to
> > get your Reviewed-by as well?
> 
> I'm happy with most of the changes and they can have my reviewed-by.

Thanks.

> I'm not happy with:
> perf stat: Fork and launch 'perf record' when 'perf stat' needs to get
> retire latency value for a metric.

I don't like it either, but I couldn't find the time to engage in this
discussion to try to offer an alternative patch and since Namhyung had
provided his reviewed-by and you pinged me, I felt compelled to move
forward on this.

> so please leave it off there.

So, what are you proposing, that we process up to some patch?

For now I'm removing the whole series from perf-tools-next.

- Arnaldo
 
> Context: originally the patches aimed to abstract everything inside of
> the evsel, now builtin-stat is manually starting and ending the
> sub-process and has to be aware of TPEBS. There are ugly architectural
> dependencies. My reviewed-by was correct on the earlier version, as
> you could make a tpebs evsel just like any... other, open, close, read
> it, etc. This would be useful say in a python script. This version to
> my eyes is worse as all TPEBS dependencies are made explicit and the
> caller needs to be aware of TPEBS. I understand Weilin was asked to
> make some of the changes, and there was a desire for efficiency, but I
> think things were better in earlier versions.
> 
> Thanks,
> Ian
