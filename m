Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2360AB676
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Aug 2024 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954927; cv=none; b=XCSZe0RxMlFrTMCwnF4V9Jgcrmq7b4tXQYvgDsO2HEy9Se2q5d1ciX205lnt2pwi1fWFayQ1EaPltDGfAZM0JLa6+4hd7wjz8FP3b3WF8Llw6Dy+iG7W5a9Ds87tyI3vHxIiB4D2rtod+EHBJUeQVo36ESI/HjgcwnJgffS9wbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954927; c=relaxed/simple;
	bh=8ZgLggn5DXpFL3EMstRZqktGTdbpYdZ3YYaRKjKUIrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8aDzdt06WKrjrwFVC+Q+owLAPI1b50Jutn9EfWvpRkG58+20CIAXFzR3JShI76Z9f3drJjnsCY62Gt6qaHFISsBUATp53Xwru23A4hZIUcxRod4WvjqBRBdWGwIlLw6wx8im3kdypdVWVDXZtcAQnc/+v27DyR/+5n05LGDMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tPB88KjS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPB88KjS"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd7509397bso256385ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Aug 2024 07:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722954924; x=1723559724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+hmNljHgKen/qqf3mT/0rODsyeAIg5EluOu5k+cU/g=;
        b=tPB88KjStAiQpD+KeXYbvQ+QxWH3K1JqBMD2wYWRCsNZ8LdOHeMepuAgNYRfkLUxCt
         TRhob+IeQgH3MoLoCnUNgv7fxIDAT2zhAEX9YFB5L3ycJUhhPlOHwQ8Oqo6W1QP5+Ee8
         zKcdi9usLIu68UsCJ9sUJfl3cBjCu0m80bXwStRUoUWCH63qEPpCL3uH7hNrHVOu0rVs
         DkTmSVN+PUY72WPMHSyyIQVJGFKlWGwt3Qzn/xDst2P2tJKtLQGOF0Pabq7GweDx0EVO
         4U/bTfUudBWvMJi8LTxSBZa6AFwcf7+qz9rfvXnI955JKDaWrHKSijRsqlh35C4GIH8Y
         JxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722954924; x=1723559724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+hmNljHgKen/qqf3mT/0rODsyeAIg5EluOu5k+cU/g=;
        b=Z5CjPBXIR8pdsZwDUogPM0qPV7SyFsBIzHHZ0su73KZz1UmdvFh0oBmdwQhyAlWvBF
         iImVJU4F8HHZkAE/DMdpJEflZ5pki+zBJZ9S7fakAu/Nx6bPdX0ENJAIFGPuwRmpYkw/
         3INao4xLD1R8a0VwubwpEF7CIkbikReJgpTzTKBGloraD6O/9zpRMkDbO/ImkanuYiMq
         BZSymwXYzhEOzv4TerYpVAY18x+jyvZop1nQ/3Rm1ejmjZNEu0isyY9tNYu2Czx08mJJ
         oe0B5QZyX564f4+mnjP/7FFtRwZPdvLI1cS0Fy22hHFtmX7M1VsSPi90Aardb4OWdqfq
         B4VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTEXLOISLVSmrv3VdSJlR1L1BUZGWSZIfwRcdBSpjGt8lZIRJEb04jp0wCo8COGm9C6/xca/lyk1Jr3I/iOW4d@vger.kernel.org
X-Gm-Message-State: AOJu0YwDFrSGr+b+Q96FBNXJiRgSdVlAvzbcbpGkodJj3uutZy+dEZXb
	hXY+5FeK1kMUNGwx/FZAj+mUqTW3gsfVHhD6S7e/P7V+4XS+L5+RkOQ5HxvHaekbtQWeJOTU3C3
	GzSI9uz2VybvSm0uMppawsn9eXZkPkBagZvZy
X-Google-Smtp-Source: AGHT+IH7eVtHjxV841U3HTBz8zA4wem/2ThvnzTg0bseE+yQDr5fAmVOEwKawEH4/Wdq9rCfds45W8hdxBdS4FwqODk=
X-Received: by 2002:a17:903:1107:b0:1f6:8836:e43f with SMTP id
 d9443c01a7336-20077fedf2amr2617365ad.17.1722954923922; Tue, 06 Aug 2024
 07:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720062102.444578-1-weilin.wang@intel.com>
 <CAM9d7cgoTyf3Zjt=+2yZi5Pat4UrxKxN=rkLHmyUWZqwZk8_Kw@mail.gmail.com>
 <CAP-5=fWr2Qna9ikzUCFavo3OTUDSP3ztr=i6E=R962CXCdHckg@mail.gmail.com>
 <ZrEpJxtm5zlp5rbo@x1> <CAP-5=fVTaHdiF8G2Dn=vnguvoapa_+ZKsQ7Wy3z51K9nDZQUtg@mail.gmail.com>
 <ZrIl8NCHkIVHQVt2@x1>
In-Reply-To: <ZrIl8NCHkIVHQVt2@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 6 Aug 2024 07:35:12 -0700
Message-ID: <CAP-5=fUVcBw4GBT8tcOWS1MV1C6zbfbovon1pCqk7gmfMN=J_Q@mail.gmail.com>
Subject: Re: [RFC PATCH v18 0/8] TPEBS counting mode support
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, weilin.wang@intel.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 6:32=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Mon, Aug 05, 2024 at 04:33:44PM -0700, Ian Rogers wrote:
> > On Mon, Aug 5, 2024 at 12:34=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Mon, Aug 05, 2024 at 08:10:12AM -0700, Ian Rogers wrote:
> > > > On Mon, Jul 22, 2024 at 10:38=E2=80=AFAM Namhyung Kim <namhyung@ker=
nel.org> wrote:
> > > > >
> > > > > Hello Weilin,
> > > > >
> > > > > On Fri, Jul 19, 2024 at 11:21=E2=80=AFPM <weilin.wang@intel.com> =
wrote:
> > > > > >
> > > > > > From: Weilin Wang <weilin.wang@intel.com>
> > > > > >
> > > > > > Change in v18:
> > > > > >  - Update to exit 2 in TPEBS shell test when not on Intel platf=
orm.
> > > > > >  - Several updates to use EVLIST_CTL_CMD_ENABLE_TAG, EVLIST_CTL=
_CMD_ACK_TAG, and
> > > > > >  etc.
> > > > > >
> > > > > > Changes in v17:
> > > > > >  - Add a poll on control fifo ack_fd to ensure program returns =
successfully when
> > > > > >  perf record failed for any reason.
> > > > > >  - Add a check in the tpebs test to only run on Intel platforms=
.
> > > > > >
> > > > > > Changes in v16:
> > > > > >  - Update tpebs bash test code and variable name.
> > > > > >  - Add a check to ensure only use "-C" option when cpumap is no=
t "-1" when
> > > > > >  forking "perf record".
> > > > > >
> > > > > > Changes in v15:
> > > > > >  - Revert changes added for python import test failure in v14 b=
ecause the code
> > > > > >  works correctly with the new python build code.
> > > > > >  - Update the command line option to --record-tpebs.
> > > > > >
> > > > > > Changes in v14:
> > > > > >  - Fix the python import test failure. We cannot support PYTHON=
_PERF because it
> > > > > >  will trigger a chain of dependency issues if we add intel-tpeb=
s.c to it. So,
> > > > > >  only enable tpebs functions in evsel and evlist when PYTHON_PE=
RF is not
> > > > > >  defined.
> > > > > >  - Fix shellcheck warning for the tpebs test.
> > > > > >
> > > > > > Changes in v13:
> > > > > >  - Add document for the command line option and fix build error=
 in non-x86_64.
> > > > > >  - Update example with non-zero retire_latency value when tpebs=
 recording is
> > > > > >  enabled.
> > > > > >  - Add tpebs_stop() back to tpebs_set_evsel() because in hybrid=
 platform, when
> > > > > >  the forked perf record is not killed, the reader thread does n=
ot get any
> > > > > >  sampled data from the PIPE. As a result, tpebs_set_evesel() wi=
ll always return
> > > > > >  zero on retire_latency values. This does not happen on my test=
 GNR machine.
> > > > > >  Since -I is not supported yet, I think we should add tpebs_sto=
p() to ensure
> > > > > >  correctness for now. More investigation is required here when =
we work on
> > > > > >  supporting -I mode.
> > > > > >  - Rebase code on top of perf-tools-next.
> > > > > >
> > > > > > Changes in v12:
> > > > > >  - Update MTL metric JSON file to include E-Core TMA3.6 changes=
.
> > > > > >  - Update comments and code for better code quality. Keep tpebs=
_start() and
> > > > > >  tpebs_delete() at evsel level for now and add comments on thes=
e functions with
> > > > > >  more details about potential future changes. Remove tpebs_stop=
() call from
> > > > > >  tpebs_set_evsel(). Simplify the tpebs_start() and tpebs_stop()=
/tpebs_delete()
> > > > > >  interfaces. Also fixed the bugs on not freed "new" pointer and=
 the incorrect
> > > > > >  variable value assignment to val instead of counter->val.
> > > > > >
> > > > > > Changes in v11:
> > > > > >  - Make retire_latency evsels not opened for counting. This wor=
ks correctly now
> > > > > >  with the code Namhyung suggested that adjusting group read siz=
e when
> > > > > >  retire_latency evsels included in the group.
> > > > > >  - Update retire_latency value assignment using rint() to reduc=
e precision loss
> > > > > >  while keeping code generic.
> > > > > >  - Fix the build error caused by not used variable in the test.
> > > > > >
> > > > > > Other changes in v10:
> > > > > >  - Change perf record fork from perf stat to evsel. All the maj=
or operations
> > > > > >  like tpebs start, stop, read_evsel should directly work throug=
h evsel.
> > > > > >  - Make intel-tpebs x86_64 only. This change is cross-compiled =
to arm64.
> > > > > >  - Put tpebs code to intel-tepbs and simplify intel-tpebs APIs =
to minimum number
> > > > > > of functions and variables. Update funtion name and variable na=
mes to use
> > > > > > consistent prefix. Also improve error handling.
> > > > > >  - Integrate code patch from Ian for the :R parser.
> > > > > >  - Update MTL metrics to TMA 4.8.
> > > > > >
> > > > > > V9: https://lore.kernel.org/all/20240521173952.3397644-1-weilin=
.wang@intel.com/
> > > > > >
> > > > > > Changes in v9:
> > > > > >  - Update the retire_latency result print and metric calculatio=
n method. Plugin
> > > > > > the value to evsel so that no special code is required.
> > > > > >  - Update --control:fifo to use pipe instead of named pipe.
> > > > > >  - Add test for TPEBS counting mode.
> > > > > >  - Update Document with more details.
> > > > > >
> > > > > > Changes in v8:
> > > > > >  - In this revision, the code is updated to base on Ian's patch=
 on R modifier
> > > > > > parser https://lore.kernel.org/lkml/20240428053616.1125891-3-ir=
ogers@google.com/
> > > > > > After this change, there is no special code required for R modi=
fier in
> > > > > > metricgroup.c and metricgroup.h files.
> > > > > >
> > > > > > Caveat of this change:
> > > > > >   Ideally, we will need to add special handling to skip countin=
g events with R
> > > > > > modifier in evsel. Currently, this is not implemented so the ev=
ent with :R will
> > > > > > be both counted and sampled. Usually, in a metric formula that =
uses retire_latency,
> > > > > > it would already require to count the event. As a result, we wi=
ll endup count the
> > > > > > same event twice. This should be able to be handled properly wh=
en we finalize our
> > > > > > design on evsel R modifier support.
> > > > > >
> > > > > >  - Move TPEBS specific code out from main perf stat code to sep=
arate files in
> > > > > > util/intel-tpebs.c and util/intel-tpebs.h. [Namhyung]
> > > > > >  - Use --control:fifo to ack perf stat from forked perf record =
instead of sleep(2) [Namhyung]
> > > > > >  - Add introductions about TPEBS and R modifier in Documents. [=
Namhyung]
> > > > > >
> > > > > >
> > > > > > Changes in v7:
> > > > > >  - Update code and comments for better code quality [Namhyung]
> > > > > >  - Add a separate commit for perf data [Namhyung]
> > > > > >  - Update retire latency print function to improve alignment [N=
amhyung]
> > > > > >
> > > > > > Changes in v6:
> > > > > >  - Update code and add comments for better code quality [Namhyu=
ng]
> > > > > >  - Remove the added fd var and directly pass the opened fd to d=
ata.file.fd [Namhyung]
> > > > > >  - Add kill() to stop perf record when perf stat exists early [=
Namhyung]
> > > > > >  - Add command opt check to ensure only start perf record when =
-a/-C given [Namhyung]
> > > > > >  - Squash commits [Namhyung]
> > > > > >
> > > > > > Changes in v5:
> > > > > >  - Update code and add comments for better code quality [Ian]
> > > > > >
> > > > > > Changes in v4:
> > > > > >  - Remove uncessary debug print and update code and comments fo=
r better
> > > > > > readability and quality [Namhyung]
> > > > > >  - Update mtl metric json file with consistent TmaL1 and Topdow=
nL1 metricgroup
> > > > > >
> > > > > > Changes in v3:
> > > > > >  - Remove ':' when event name has '@' [Ian]
> > > > > >  - Use 'R' as the modifier instead of "retire_latency" [Ian]
> > > > > >
> > > > > > Changes in v2:
> > > > > >  - Add MTL metric file
> > > > > >  - Add more descriptions and example to the patch [Arnaldo]
> > > > > >
> > > > > > Here is an example of running perf stat to collect a metric tha=
t uses
> > > > > > retire_latency value of event MEM_INST_RETIRED.STLB_HIT_STORES =
on a MTL system.
> > > > > >
> > > > > > In this simple example, there is no MEM_INST_RETIRED.STLB_HIT_S=
TORES sample.
> > > > > > Therefore, the MEM_INST_RETIRED.STLB_HIT_STORES:p count and ret=
ire_latency value
> > > > > > are all 0.
> > > > > >
> > > > > > ./perf stat -M tma_dtlb_store -a -- sleep 1
> > > > > >
> > > > > > [ perf record: Woken up 1 times to write data ]
> > > > > > [ perf record: Captured and wrote 0.000 MB - ]
> > > > > >
> > > > > >  Performance counter stats for 'system wide':
> > > > > >
> > > > > >        181,047,168      cpu_core/TOPDOWN.SLOTS/          #     =
 0.6 %  tma_dtlb_store
> > > > > >          3,195,608      cpu_core/topdown-retiring/
> > > > > >         40,156,649      cpu_core/topdown-mem-bound/
> > > > > >          3,550,925      cpu_core/topdown-bad-spec/
> > > > > >        117,571,818      cpu_core/topdown-fe-bound/
> > > > > >         57,118,087      cpu_core/topdown-be-bound/
> > > > > >             69,179      cpu_core/EXE_ACTIVITY.BOUND_ON_STORES/
> > > > > >              4,582      cpu_core/MEM_INST_RETIRED.STLB_HIT_STOR=
ES/
> > > > > >         30,183,104      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/
> > > > > >         30,556,790      cpu_core/CPU_CLK_UNHALTED.THREAD/
> > > > > >            168,486      cpu_core/DTLB_STORE_MISSES.WALK_ACTIVE/
> > > > > >               0.00 MEM_INST_RETIRED.STLB_HIT_STORES:p       0  =
      0
> > > > > >
> > > > > >        1.003105924 seconds time elapsed
> > > > > >
> > > > > > v1:
> > > > > > TPEBS is one of the features provided by the next generation of=
 Intel PMU.
> > > > > > Please refer to Section 8.4.1 of "Intel=C2=AE Architecture Inst=
ruction Set Extensions
> > > > > > Programming Reference" [1] for more details about this feature.
> > > > > >
> > > > > > This set of patches supports TPEBS in counting mode. The code w=
orks in the
> > > > > > following way: it forks a perf record process from perf stat wh=
en retire_latency
> > > > > > of one or more events are used in a metric formula. Perf stat w=
ould send a
> > > > > > SIGTERM signal to perf record before it needs the retire latenc=
y value for
> > > > > > metric calculation. Perf stat will then process sample data to =
extract the
> > > > > > retire latency data for metric calculations. Currently, the cod=
e uses the
> > > > > > arithmetic average of retire latency values.
> > > > > >
> > > > > > [1] https://www.intel.com/content/www/us/en/content-details/812=
218/intel-architecture-instruction-set-extensions-programming-reference.htm=
l?wapkw=3Dfuture%20features
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > Ian Rogers (1):
> > > > > >   perf parse-events: Add a retirement latency modifier
> > > > > >
> > > > > > Weilin Wang (7):
> > > > > >   perf data: Allow to use given fd in data->file.fd
> > > > > >   perf stat: Fork and launch perf record when perf stat needs t=
o get
> > > > > >     retire latency value for a metric.
> > > > > >   perf stat: Plugin retire_lat value from sampled data to evsel
> > > > > >   perf vendor events intel: Add MTL metric json files
> > > > > >   perf stat: Add command line option for enabling tpebs recordi=
ng
> > > > > >   perf Document: Add TPEBS to Documents
> > > > > >   perf test: Add test for Intel TPEBS counting mode
> > > > >
> > > > > Thanks for your persistence!
> > > > >
> > > > > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> > > >
> > > > Ping.
> > >
> > > I guess Namhyung's reviewed-by should suffice, but since you're pingi=
ng
> > > and I saw previous comments about this serie, would it be possible to
> > > get your Reviewed-by as well?
> >
> > I'm happy with most of the changes and they can have my reviewed-by.
>
> Thanks.
>
> > I'm not happy with:
> > perf stat: Fork and launch 'perf record' when 'perf stat' needs to get
> > retire latency value for a metric.
>
> I don't like it either, but I couldn't find the time to engage in this
> discussion to try to offer an alternative patch and since Namhyung had
> provided his reviewed-by and you pinged me, I felt compelled to move
> forward on this.

I think we should be moving forward on this. I think the series had my
reviewed-by 9 months ago and this work is gating the bring up of Intel
models like Granite Rapids, it also adds metrics for Intel Meteorlake
which is Intel's laptop CPU of the day. After all fixes for the ARM
breakages, this is the 2nd biggest nuts thing we don't have landed.

> > so please leave it off there.
>
> So, what are you proposing, that we process up to some patch?

I was proposing just not having my tag on that patch. Perfect isn't
the enemy of good.

I don't want to be picky on other people's style, especially when it
brings big value as here. A low value series blocked on a style issue
due to 1 reviewer is:
https://lore.kernel.org/lkml/CAP-5=3DfW8YMivp1JW8vRKh=3DOZtGVLPQ4v88z_2ae+c=
AVnr7RXoQ@mail.gmail.com/
I'm happy to give style feedback but generally try to avoid it
blocking merging. In this case I even wrote the patches doing what I'd
suggested.

> For now I'm removing the whole series from perf-tools-next.

Ugh.

Thanks,
Ian

> - Arnaldo
>
> > Context: originally the patches aimed to abstract everything inside of
> > the evsel, now builtin-stat is manually starting and ending the
> > sub-process and has to be aware of TPEBS. There are ugly architectural
> > dependencies. My reviewed-by was correct on the earlier version, as
> > you could make a tpebs evsel just like any... other, open, close, read
> > it, etc. This would be useful say in a python script. This version to
> > my eyes is worse as all TPEBS dependencies are made explicit and the
> > caller needs to be aware of TPEBS. I understand Weilin was asked to
> > make some of the changes, and there was a desire for efficiency, but I
> > think things were better in earlier versions.
> >
> > Thanks,
> > Ian
