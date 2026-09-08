Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889954DACB
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 21:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904369; cv=none; b=FhZEzep59kKqNP4sx14QkQZ4ihgSBzsNDzt5FP61sj3h54Gu88dKh9yonFIVnHv816gN3UiAf1DYDqxuJkjbAdYZWQwFp50hYvOJ15L5LYo2m1WZooi+wuYVYyqbx3n5c6T3TPDtKt1awDJDeHUn32Yy/19brVHq6RiBXBFpvHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904369; c=relaxed/simple;
	bh=Y23w57CJRhqTn+E8y6/DAizLwRXl2fAZMIOkWGuRCQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzrhqME9n4S9hNY+aqLUTcCMxJXpKvOPOywnVrKe0UXZBS3P/A9vEXyEG9aQTOOO3oRRf+yc9Qbm5wdwyrT8kXfEqXhRFuCJRi0aQ2EXX56sH9bTfN7kMOM2oE3c6NC6yk+xwY8Cq8nNfL212LT7w90AjJYxgrveyVnf1qlcRZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiyrnT1r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiyrnT1r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCC51F00A3A;
	Tue,  8 Sep 2026 21:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788904367;
	bh=iiB3BQzmf7V0mtRZFUYFtWVROQYBf5mPChh7X1kCs2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hiyrnT1rxhRfpfrNNgQhKj6lhtCDBWWv1WX38WfeII6bVyhwW6kBr03syB5NswXhh
	 Q3Law4XKbatrZTKK6o5ZDBuDgEDQqSixj0Gs6p7cFc+6ckwlgMRLtR8dEUwusgqBeN
	 +2YZhpLl3UlupQMvtf0+XG99NLXM1wBP78Qqwf7Gr6DOWsWchSdTu+N5a+o/cBV34G
	 l7F6I3BChbOxYyBY+YdjqetebqSCMVGorzErNeWvk0CPSLgTY8MlGD2wd71xil7AIp
	 6ylxhZcjFYqlid0RiXycxTqkJ/RxpPLCkc7/jS8gloFwwo7VSeV2Ph8hPEWW1ULaZa
	 jTTRlH40wW+8A==
Date: Tue, 8 Sep 2026 18:52:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Kohei Enju <kohei@enjuk.jp>, linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v1 0/2] perf annotate: Fix source option behavior and
Message-ID: <aqCDrJ6zwVI-n6_P@x2>
References: <20260818144149.101248-1-kohei@enjuk.jp>
 <aozBwyQ85OjoPlMi@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aozBwyQ85OjoPlMi@google.com>

On Mon, Aug 24, 2026 at 03:12:19PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Aug 18, 2026 at 02:40:11PM +0000, Kohei Enju wrote:
> > Source annotation has been disabled by default since e201757f7a0a ("perf
> > annotate: Fix source code annotate with objdump"), but the documentation
> > still describes the old default. Also, an explicit --source does not
> > currently override annotate.hide_src_code.
> > 
> > Update the documentation and make explicit --source/--no-source take
> > precedence over the configuration.
> > 
> > Kohei Enju (2):
> >   perf config: Fix annotate.hide_src_code documentation
> >   perf annotate: Honor explicit --source option
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Please rebase, I'll push the patches I have locally later today after
the usual build tests on many distro containers:

⬢ [acme@toolbx perf-tools-next]$        git am ./20260818_kohei_perf_annotate_fix_source_option_behavior_and.mbx
Applying: perf config: Fix annotate.hide_src_code documentation
Applying: perf annotate: Honor explicit --source option
error: patch failed: tools/perf/builtin-top.c:1851
error: tools/perf/builtin-top.c: patch does not apply
Patch failed at 0002 perf annotate: Honor explicit --source option
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
⬢ [acme@toolbx perf-tools-next]$
