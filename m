Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4002A205501;
	Fri,  6 Jun 2025 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749241522; cv=none; b=EmNeqrDb1MmJCjnG9Yo2Y235ht197b5p3L9n5uLwtFNouKkaj4p4pv0sVPLvc+/TMOhi2BR2yb2l0YXFfcP8q+RMgjNks57PYdmKh4WB/0PJUJGYOspEiku7mEN/G+YxP2RH8vQ9ZItolxyaDTVaiAge7yzHaWjXuvVRk5MQPWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749241522; c=relaxed/simple;
	bh=Otn+TbMMpoczEt25Uww0lW5KGyPxmRKnMr5yVaE1rGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQbGYB+1jaGglk/UsaXYMLQcj/onoigV9SmwQLYYVVh3pSDwgrBmmJ7ccOdlKt6LG8Jg0SmEDrhL3lGktHksrKmIBQxD7jfujh3bTFJcyV28vJiV3Q8H60VYp2+5VTfwZAUktG6y2jxf1quN4ArZWhhbFMGMDPCO745uOLILBKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObUoiGRd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObUoiGRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506DEC4CEEB;
	Fri,  6 Jun 2025 20:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749241521;
	bh=Otn+TbMMpoczEt25Uww0lW5KGyPxmRKnMr5yVaE1rGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ObUoiGRdfVzQ8SqaJG4wYyixhyqdfzS/C512G1KGQov1/FYcFvOq6E/W3n9GQFoI/
	 wLu2xdcvcC1Rig7KJ06olabm/f6JGx0YT9mNCDzY6u4DfiP+YndNrRqUoRPpKRhIUF
	 2rRfYZ24LwWED/4dCR+2H5KYAJpzlFmRL2nbnss9Zz7+rP/lpeKg+p83aHfWjRMBZi
	 9+aALEo3WWm62/xEoenFqgaaqXqDMSwcRv4+m0ADsDlqiF7jikAS7DP/NnOkeMTEWX
	 7Cn+z397YnoCyX3kAKqojKnASAxxIqMhyJZ3aLT3KexDY5A/I9HAKScg8/KHR1yrLK
	 mk3SUgBqdYvXw==
Date: Fri, 6 Jun 2025 17:25:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Chun-Tse Shao <ctshao@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Howard Chu <howardchu95@gmail.com>, Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Levi Yun <yeoreum.yun@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Weilin Wang <weilin.wang@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1 v6.16] perf test event_uniquifying: Skip test on
 platforms without 'clockticks' events
Message-ID: <aENOrmDxKPYAaYNR@x1>
References: <aEHugAPinlWLuTAS@x1>
 <aEMqwmCmbyAlb1Y1@google.com>
 <aENM_KGb-x14pHRX@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aENM_KGb-x14pHRX@x1>

On Fri, Jun 06, 2025 at 05:18:07PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Jun 06, 2025 at 10:52:02AM -0700, Namhyung Kim wrote:
> > On Thu, Jun 05, 2025 at 04:22:40PM -0300, Arnaldo Carvalho de Melo wrote:
> > > I'll add this to perf-tools for v6.16, please check.
 
> > Plesae see

> > https://lore.kernel.org/linux-perf-users/20250521224513.1104129-1-ctshao@google.com/
 
> Oh, great, I'll drop my fix and get that one instead.

Nope, that one returns ok if the test can't be performed, it should
return 2 so that it is skipped and since we don't have a way to show the
reason for skipping a shell test, when using 'perf test -vv' the warning
that is there already (the needed PMU not being available) will be
shown.

So I'm amending this on top, ok?

diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/perf/tests/shell/stat+event_uniquifying.sh
index 5a51fbaa13bb9b3c..c39d77ab4ad95bfc 100755
--- a/tools/perf/tests/shell/stat+event_uniquifying.sh
+++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
@@ -47,6 +47,7 @@ test_event_uniquifying() {
   # Skip if the machine does not have `uncore_imc` device.
   if ! ${perf_tool} list pmu | grep -q ${pmu}; then
     echo "Target does not support pmu ${pmu} [Skipped]"
+    err=2
     return
   fi

Then we get:
root@number:~# perf test uniqu
 93: perf stat events uniquifying                                    : Skip
root@number:~#

Instead of the misleading:

root@number:~# perf test uniqu
 93: perf stat events uniquifying                                    : Ok
root@number:~# 

With -vv and the fix:

root@number:~# perf test -vv uniqu
 93: perf stat events uniquifying:
--- start ---
test child forked, pid 94671
stat event uniquifying test
Target does not support PMU uncore_imc [Skipped]
---- end(-2) ----
 93: perf stat events uniquifying                                    : Skip
root@number:~#

- Arnaldo
