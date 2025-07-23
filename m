Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3E22192F4;
	Wed, 23 Jul 2025 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753298661; cv=none; b=YTrWWqmoJ9f4VQQI4nBUIsSNO309PGeI9vlmi0ZgprSaSEttER5F15jDZ8q7OEMhHeyTWS+sE/+RqSPrbEqmgIdkXWiWEA6OHhXHbaLmAh/IJH9+c3I9Qxqmr2Q+Szwo0F8+XsN3+CuGw0YHPT0j/fpqKL45YlF4WNUnph4UJ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753298661; c=relaxed/simple;
	bh=Vm3veatecaJYU4VIsRdH8NCXde2FjUk++0i7MGDnLSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnIUDvQ+fLdVP6fHNpuhh5dJEWhnuLOkH/F23BeZG3vdEXRhfxEe/7Wie6XjID54006EjL/tfwpF5AkC0lUK3k+Xy8divXKVbarKP6CwURFjTnh4bLUl/tbVJoBTcFG7wqQJj4yLAZlg6waen04UXkFCmjoT4F9hGoH2SgvlMUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdXNQ/v4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdXNQ/v4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E24FC4CEE7;
	Wed, 23 Jul 2025 19:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753298660;
	bh=Vm3veatecaJYU4VIsRdH8NCXde2FjUk++0i7MGDnLSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tdXNQ/v4aT+sV8Po9m6wkOdCdj13AQSFYRr3ic/Zf7qm55kS8ImW1jPrqFDFEQGOt
	 H4uVReEuuGSKfBNIDi5jTmdMc/oaGTlaEm8gFRiPQGekUXaMWaN+NllBhJvO3UwUhh
	 z+sbXDoO8gdEoYBOVgVEfu6+wOWP28x4fgz+uyj9/0hsRdaLNsiKda8+79dopLz0IC
	 TTir97SiPxr4pKhEIEvY0cf427GSvlKXc4mxLhiCD+9YXUm4NFZ8gHOjreFY6C60Nk
	 PqTnvgkd1wRXdVi9xMJN0duMh+b1/aaI3jV6OFpaXG23wtJMK+0IoqLJn/QO1xD4Ir
	 NQc6opbxw46pw==
Date: Wed, 23 Jul 2025 16:24:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 00/16] New perf ilist app
Message-ID: <aIE24fDAuIqDXX3h@x1>
References: <20250714164405.111477-1-irogers@google.com>
 <CAP-5=fW=AG8ztbzS-KXpo9fH_Hp_fkZ3CVDuG9pN7P32Qm0oyg@mail.gmail.com>
 <aIEjMroa3bW-T7d-@google.com>
 <aIEzRNLTCTA5Gqhm@x1>
 <aIEzzt1f3UWDCAIw@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIEzzt1f3UWDCAIw@x1>

On Wed, Jul 23, 2025 at 04:11:13PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Jul 23, 2025 at 04:08:55PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Jul 23, 2025 at 11:00:18AM -0700, Namhyung Kim wrote:
> > > > I think there is some follow up for "make install" for scripts like
> > > > these, but I'm keen for the python API to move forward.
  
> > > I'll review the series today so that we can get some part of it, at
> > > least.  Basically I think we need a wrapper script like perf-ilist to
> > > run this easily (maybe with documentation).
 
> > I just tried, with the series applied:
 
> > root@number:~# perf ilist
> > perf: 'ilist' is not a perf-command. See 'perf --help'.
 
> > Did you mean this?
> > 	list
> > root@number:~#
 
> > Now trying to figure out why it is not running.
 
> So it is not wired up like 'perf archive', trying it directly:
 
> root@number:~# ~acme/git/perf-tools-next/tools/perf/python/ilist.py 
> Traceback (most recent call last):
>   File "/home/acme/git/perf-tools-next/tools/perf/python/ilist.py", line 11, in <module>
>     from textual import on
> ModuleNotFoundError: No module named 'textual'
> root@number:~#
 
> I thought there was some discussion about catching this exception and
> providing guidance, lemme try...

root@number:~# sudo dnf install python-textual
Updating and loading repositories:
 google-chrome                                        100% |   6.1 KiB/s |   1.3 KiB |  00m00s
 Copr repo for PyCharm owned by phracek               100% |   2.0 KiB/s |   2.1 KiB |  00m01s
 RPM Fusion for Fedora 42 - Nonfree - NVIDIA Driver   100% |   2.6 KiB/s |   2.5 KiB |  00m01s
 RPM Fusion for Fedora 42 - Nonfree - Steam           100% |   5.8 KiB/s |   2.4 KiB |  00m00s
 google-chrome                                        100% |   7.2 KiB/s |   3.2 KiB |  00m00s
 Copr repo for PyCharm owned by phracek               100% |  15.7 KiB/s |   4.8 KiB |  00m00s
Repositories loaded.
Package                           Arch    Version         Repository     Size
Installing:
 python3-textual                  noarch  1.0.0-1.fc42    fedora      6.6 MiB
Installing dependencies:
 python3-linkify-it-py            noarch  2.0.3-4.fc42    fedora    110.4 KiB
 python3-markdown-it-py           noarch  3.0.0-8.fc42    fedora    496.3 KiB
 python3-markdown-it-py+linkify   noarch  3.0.0-8.fc42    fedora      9.0 KiB
 python3-markdown-it-py+plugins   noarch  3.0.0-8.fc42    fedora      9.0 KiB
 python3-mdit-py-plugins          noarch  0.4.2-2.fc42    fedora    289.4 KiB
 python3-mdurl                    noarch  0.1.2-9.fc42    fedora     41.4 KiB
 python3-platformdirs             noarch  4.2.2-4.fc42    fedora    162.0 KiB
 python3-pygments                 noarch  2.18.0-4.fc42   fedora     10.6 MiB
 python3-rich                     noarch  13.9.4-2.fc42   fedora      2.5 MiB
 python3-uc-micro-py              noarch  1.0.3-4.fc42    fedora     13.1 KiB

Transaction Summary:
 Installing:        11 packages

Total size of inbound packages is 5 MiB. Need to download 5 MiB.
After this operation, 21 MiB extra will be used (install 21 MiB, remove 0 B).
Is this ok [y/N]: y
<SNIP>
[13/13] Installing python3-textual-0:1.0.0-1.fc42.noarch                                                                         100% |  10.1 MiB/s |   6.8 MiB |  00m01s
Complete!
root@number:~# ~acme/git/perf-tools-next/tools/perf/python/ilist.py 
╭────────────────────────────────────────────────────────────────── Traceback (most recent call last) ──────────────────────────────────────────────────────────────────╮
│ /home/acme/git/perf-tools-next/tools/perf/python/ilist.py:470 in compose                                                                                              │
│                                                                                                                                                                       │
│   467 │   │   │   return tree                                                                                                                                         │
│   468 │   │                                                                                                                                                           │
│   469 │   │   yield Header(id="header")                                                                                                                               │
│ ❱ 470 │   │   yield Horizontal(Vertical(metric_event_tree(), id="events"),                                                                                            │
│   471 │   │   │   │   │   │    Vertical(Label("event name", id="event_name"),                                                                                         │
│   472 │   │   │   │   │   │   │   │     Static("description", markup=False, id="event_descript                                                                        │
│   473 │   │   │   │   │   │   │   │     ))                                                                                                                            │
│                                                                                                                                                                       │
│ ╭───────────────────────────────────────────────── locals ─────────────────────────────────────────────────╮                                                          │
│ │ self = IListApp(title='Interactive Perf List', classes={'-dark-mode'}, pseudo_classes={'dark', 'focus'}) │                                                          │
│ ╰──────────────────────────────────────────────────────────────────────────────────────────────────────────╯                                                          │
│                                                                                                                                                                       │
│ /home/acme/git/perf-tools-next/tools/perf/python/ilist.py:433 in metric_event_tree                                                                                    │
│                                                                                                                                                                       │
│   430 │   │   │   """Create tree of PMUs and metricgroups with events or metrics under."""     ╭─────────── locals ────────────╮                                      │
│   431 │   │   │   tree: Tree[TreeValue] = Tree("Root", id="root")                              │ pmus = TreeNode('PMUs', None) │                                      │
│   432 │   │   │   pmus = tree.root.add("PMUs")                                                 │ tree = Tree(id='root')        │                                      │
│ ❱ 433 │   │   │   for pmu in perf.pmus():                                                      ╰───────────────────────────────╯                                      │
│   434 │   │   │   │   pmu_name = pmu.name().lower()                                                                                                                   │
│   435 │   │   │   │   pmu_node = pmus.add(pmu_name)                                                                                                                   │
│   436 │   │   │   │   try:                                                                                                                                            │
╰───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
AttributeError: module 'perf' has no attribute 'pmus'
root@number:~# 

Ok, that was with the 'python-perf3' rpm package on fedora 42, trying
with the new one...

root@number:~# export PYTHONPATH=/tmp/build/perf-tools-next/python
root@number:~# ~acme/git/perf-tools-next/tools/perf/python/ilist.py 

Cool stuff!

Lots of flashing lights! :-)

Interesting to quickly browse all those events, I like it.

I searched for "wakeup" and stumbled on ftrace:wakeup failures, but that
should be just a minor adjustment, some exception list:

root@number:~# ls -la /sys/kernel/tracing/events/ftrace/wakeup/
total 0
drwxr-xr-x. 1 root root 0 Jul 23 16:04 .
drwxr-xr-x. 1 root root 0 Jul 23 16:04 ..
-r--r-----. 1 root root 0 Jul 23 16:04 format
-r--r-----. 1 root root 0 Jul 23 16:19 hist
root@number:~# 
root@number:~# ls -la /sys/kernel/tracing/events/sched/sched_wakeup/
total 0
drwxr-xr-x. 1 root root 0 Jul 23 16:04 .
drwxr-xr-x. 1 root root 0 Jul 23 16:04 ..
-rw-r-----. 1 root root 0 Jul 23 16:19 enable
-rw-r-----. 1 root root 0 Jul 23 16:19 filter
-r--r-----. 1 root root 0 Jul 23 16:04 format
-r--r-----. 1 root root 0 Jul 23 16:19 hist
-r--r-----. 1 root root 0 Jul 23 16:04 id
-rw-r-----. 1 root root 0 Jul 23 16:19 trigger
root@number:~#

Do you know how to take text screen shots in textual?

Apart from the super minor nits, thanks for working on this:

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
