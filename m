Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954B13EFD1C;
	Wed,  6 May 2026 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073019; cv=none; b=DT2CNIZ0GRNfVm5K1ri2+PsYNMA1dczAEiV/pgGgD5FNF4MU8Myjirt9bL+fgmo80DD8BKt+zmQlEiuA8+xJ4lFiVpgsuKYJCPJGHVgQSQPke/GU4EtG/w0L8klnBXQFcTSTU9c3nty2AYi+pAzTy6IQiXDd7S7w/DQkRVQhRsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073019; c=relaxed/simple;
	bh=aVU+wvCwtOMGltK4Iwx8W3+R54EPoqxWHpmRCMxBqhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfiSeot+bjp9MJP1wAGf8QSSP76Qsbir99ZU1//g6lACVLJRduR2ZjhhDSANj+XRweyuz6B0TyCIBn29w/K/yPn3pyWcMbPmrKjjqEaDUl5sw4C+JpT1LeBlBpYRpVfzeIvgDLYyCzX/s9r5QeiS8mH8f5G7vcKJAYY838qip0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNFI2OCe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNFI2OCe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90623C2BCB8;
	Wed,  6 May 2026 13:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778073019;
	bh=aVU+wvCwtOMGltK4Iwx8W3+R54EPoqxWHpmRCMxBqhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNFI2OCenAUQgd6Jja9furKN98Uxc065k1o3fZ/oXK1iPmnu47fzjHBSly9Ymxpix
	 4b+RhhWm8JVIwHoiO0bX0WZifgcojqqkCdysI3fA3MoMB2MF1XtHHNcwnO0swZ3o/l
	 9oYnabS0QW4lbvu2/XzEPtn4KJTcNr/1r3xnTbffKZYqQpt+0dup/NhS0qGNauuOCw
	 ZUwrzwpSnFgUz8yoON6yug5VxVqPfGx9j97HKJJmqSMptJ1tvPVaEWMVUKp70NtsUC
	 c4/ZvK1TxAKbEKiiMhAKokJDjs5C2DdEy5ywp77nOHe4/Ul7ngTZ8MCOtTpooZWx+C
	 A9/2Dv/G7t0aw==
Date: Wed, 6 May 2026 10:10:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf sched: Avoid segv if tp_handler not set
Message-ID: <afs9tx6hpi9CiEzN@x1>
References: <20260321061448.810525-1-irogers@google.com>
 <acW_IHQVZnxIETdd@google.com>
 <CAP-5=fWh66OwPC0K4ZyedAWqwyXez0ya9Dz6hzbgY0AhoqMfdg@mail.gmail.com>
 <ac8pEDUKjuMxXUS6@google.com>
 <CAP-5=fXeBje03BM8D9q-0KsXg2KmyRa81CuphtSQfHp0isFc_w@mail.gmail.com>
 <adPzEmwDaHq4SsZw@google.com>
 <CAP-5=fW-H-ri3MdVv4Vh4xiyB-qpDqnO3gqXR+XyfMK+kXpHQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW-H-ri3MdVv4Vh4xiyB-qpDqnO3gqXR+XyfMK+kXpHQA@mail.gmail.com>

On Tue, May 05, 2026 at 02:56:02PM -0700, Ian Rogers wrote:
> On Mon, Apr 6, 2026 at 10:53 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > On Fri, Apr 03, 2026 at 08:29:25AM -0700, Ian Rogers wrote:
> > > On Thu, Apr 2, 2026 at 7:42 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > On Tue, Mar 31, 2026 at 10:59:52PM -0700, Ian Rogers wrote:
> > > > > On Thu, Mar 26, 2026 at 4:20 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > On Fri, Mar 20, 2026 at 11:14:47PM -0700, Ian Rogers wrote:
> > > > > > > Doing a `perf sched record` then `perf sched stats report` crashes as
> > > > > > > the tp_handler isn't set. Add extra checks that tp_handler is set
> > > > > > > before accessing through it.

> > > > > > Oh.. unintended use case. :)  Probably better to add a dummy handler
> > > > > > for `perf sched stats report`.

> > > > > Perhaps. I'd prefer to land the simpler change as-is.

> > > > Well.. I guess the dummy handler approach would be simpler and perform
> > > > better. :)

> > > > +++ b/tools/perf/builtin-sched.c
> > > > @@ -4955,6 +4955,7 @@ int cmd_sched(int argc, const char **argv)
> > > >                 .switch_event       = replay_switch_event,
> > > >                 .fork_event         = replay_fork_event,
> > > >         };
> > > > +       struct trace_sched_handler stats_ops  = {};
> > >
> > > Oh, because there's an existing null test on the function pointer we
> > > don't need dummy functions, which is what I thought you were asking
> > > for. I'm still not convinced this is very intention revealing, but if
> > > it works for you then you can have my reviewed-by tag.

> > Applied this and the patch 2 to perf-tools-next, thanks!
 
> Thanks Namhyung. Did this get accidentally dropped? I'm not seeing it
> in perf-tools-next.

Not applying:

⬢ [acme@toolbx perf-tools-next2]$ b4 am -ctsl --cc-trailers CAP-5=fW-H-ri3MdVv4Vh4xiyB-qpDqnO3gqXR+XyfMK+kXpHQA@mail.gmail.com
Grabbing thread from lore.kernel.org/all/CAP-5%3DfW-H-ri3MdVv4Vh4xiyB-qpDqnO3gqXR%2BXyfMK%2BkXpHQA@mail.gmail.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 10 messages in the thread
Analyzing 0 code-review messages
Checking attestation on all messages, may take a moment...
---
  ✗ [PATCH v1 1/2] perf sched: Avoid segv if tp_handler not set
    + Tested-by: Swapnil Sapkal <swapnil.sapkal@amd.com> (✓ DKIM/amd.com)
    + Link: https://lore.kernel.org/r/20260321061448.810525-1-irogers@google.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✗ [PATCH v1 2/2] perf tests sched stats: Write output to temp file
    + Tested-by: Swapnil Sapkal <swapnil.sapkal@amd.com> (✓ DKIM/amd.com)
    + Link: https://lore.kernel.org/r/20260321061448.810525-2-irogers@google.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ---
  ✗ BADSIG: DKIM/google.com
---
Total patches: 2
---
 Link: https://lore.kernel.org/r/20260321061448.810525-1-irogers@google.com
 Base: not specified
       git am ./20260320_irogers_perf_sched_avoid_segv_if_tp_handler_not_set.mbx
⬢ [acme@toolbx perf-tools-next]$        git am ./20260320_irogers_perf_sched_avoid_segv_if_tp_handler_not_set.mbx
Applying: perf sched: Avoid segv if tp_handler not set
Applying: perf tests sched stats: Write output to temp file
error: patch failed: tools/perf/tests/shell/perf_sched_stats.sh:4
error: tools/perf/tests/shell/perf_sched_stats.sh: patch does not apply
Patch failed at 0002 perf tests sched stats: Write output to temp file
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
⬢ [acme@toolbx perf-tools-next2]$ git log --oneline -5
5a5b82a2a9bf1d3f (HEAD -> perf-tools-next) perf sched: Avoid segv if tp_handler not set
2d840126356314bf perf sched stats: Fix segmentation faults, memory leaks, and stale pointers in diff mode
8c8f2093614373ea perf build: Remove NO_GTK2 build test
53bc032892782e54 perf build: Add -fms-extensions for GEN_VMLINUX_H=1
e41cac8617a9b399 perf build: Update error message for BUILD_NONDISTRO=1
⬢ [acme@toolbx perf-tools-next]$
