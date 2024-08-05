Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E569216BE3A;
	Mon,  5 Aug 2024 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722888870; cv=none; b=IDVIXxL70b1dy/B5J34JR7zamcArOfryKmILy0SH2Bnj35rf89s7sOS2AIjFzZu2VHfvlFeqVgcq5ZauGDZjDeRT6AD5DSP4t+ejUlO+SRI8iV4Bx+Od/2maI/1/MzIDgAu7VO9ceVEA4l8V6DAWzV/YXV7wqZ7Vsbm6kTRtON4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722888870; c=relaxed/simple;
	bh=6JwlNzm8U7u6DCTsfLVPmGM8wRJjuOA3o+8k3Qz5uMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=on0PORYMpQJtBtuqwZDQXc5H1g0JP1lQ8WQjBO5Y2KrbKSV04XPMX9wSldMVVLHL2yG35ZGJ1YmNUCLIWf+NMjmctH038hU2J6QF4BmGSlPOdvmQBo9RdK+px2fRMP9Dh1Zj8zhwhPrkTPz5Y/jUq0nZhnQ3NlUbSSJBJ4fRxlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snvlXvg/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snvlXvg/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232C9C32782;
	Mon,  5 Aug 2024 20:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722888869;
	bh=6JwlNzm8U7u6DCTsfLVPmGM8wRJjuOA3o+8k3Qz5uMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snvlXvg/nNl2QPJpgP+Bep5zro7dWeDMhy6jo4HzKc233tO9lhb9iA+yN7uRylgBc
	 4maM4NXeg0x1s2foFDMg9gsHG94JEgNEXppmy3SYdkK5qd662eQqg+tFqP082PXIz9
	 75i+mAasTIb52cFFuyDQn9N1fFXfX2ResMpzPBU7JeLYG7r2OnqxpfOx1NmGaQs6U/
	 n7AnCKExw2RjTcsCI+L5xDcOL0M0/mWeK0Xy4mTZZ9QEmr1k7Xs3duwWi8kp+VDNZe
	 unYTYgHK58Qt+zMNrWPHi/7knn3ihdDHVMM90naP5t911yTmhWukw2oVb2dYfpFbBk
	 4qwCYhQcqNgww==
Date: Mon, 5 Aug 2024 13:14:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 5/5] perf annotate: Add --skip-empty option
Message-ID: <ZrEyo4CSm6nKU20s@google.com>
References: <20240803211332.1107222-1-namhyung@kernel.org>
 <20240803211332.1107222-6-namhyung@kernel.org>
 <ZrEmZLV0vgU6GUcN@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrEmZLV0vgU6GUcN@x1>

On Mon, Aug 05, 2024 at 04:22:12PM -0300, Arnaldo Carvalho de Melo wrote:
> On Sat, Aug 03, 2024 at 02:13:32PM -0700, Namhyung Kim wrote:
> > Like in perf report, we want to hide empty events in the perf annotate
> > output.  This is consistent when the option is set in perf report.
> > 
> > For example, the following command would use 3 events including dummy.
> > 
> >   $ perf mem record -a -- perf test -w noploop
> > 
> >   $ perf evlist
> >   cpu/mem-loads,ldlat=30/P
> >   cpu/mem-stores/P
> >   dummy:u
> > 
> > Just using perf annotate with --group will show the all 3 events.
> 
> Seems unrelated, just before compiling with this patch:
> 
> root@x1:~# perf mem record -a -- perf test -w noploop
> Memory events are enabled on a subset of CPUs: 4-11
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 10.506 MB perf.data (2775 samples) ]
> root@x1:~#
> 
> root@x1:~# perf annotate --group --stdio2 sched_clock
> root@x1:~# perf annotate --stdio2 sched_clock
> Samples: 178  of event 'cpu_atom/mem-stores/P', 4000 Hz, Event count (approx.): 565268, [percent: local period]
> sched_clock() /usr/lib/debug/lib/modules/6.8.11-200.fc39.x86_64/vmlinux
> Percent      0xffffffff810511e0 <sched_clock>:
>                endbr64        
>    5.76        incl    pcpu_hot+0x8
>    5.47      → callq   sched_clock_noinstr
>   88.78        decl    pcpu_hot+0x8
>              ↓ je      1e     
>              → jmp     __x86_return_thunk
>          1e: → callq   __SCT__preempt_schedule_notrace
>              → jmp     __x86_return_thunk
> root@x1:~# perf annotate --group --stdio2 sched_clock
> root@x1:~# perf annotate --group --stdio sched_clock
> root@x1:~# perf annotate --group sched_clock
> root@x1:~#
> 
> root@x1:~# perf evlist
> cpu_atom/mem-loads,ldlat=30/P
> cpu_atom/mem-stores/P
> dummy:u
> root@x1:~#
> 
> root@x1:~# perf report --header-only | grep cmdline
> # cmdline : /home/acme/bin/perf mem record -a -- perf test -w noploop 
> root@x1:~#
> 
> I thought it would be some hybrid oddity but seems to be just --group
> related, seems like it stops if the first event has no samples? Because
> it works with another symbol:

Good catch.  Yeah I found it only checked the first event.  Something
like below should fix the issue.

Thanks,
Namhyung


diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index efcadb7620b8..8d3ec439b783 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -632,11 +632,15 @@ static int __cmd_annotate(struct perf_annotate *ann)
 	evlist__for_each_entry(session->evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
 		u32 nr_samples = hists->stats.nr_samples;
+		struct evsel *evsel;
 
-		if (nr_samples == 0)
+		if (!symbol_conf.event_group || !evsel__is_group_leader(pos))
 			continue;
 
-		if (!symbol_conf.event_group || !evsel__is_group_leader(pos))
+		for_each_group_member(evsel, pos)
+			nr_samples += evsel__hists(evsel)->stats.nr_samples;
+
+		if (nr_samples == 0)
 			continue;
 
 		hists__find_annotations(hists, pos, ann);
