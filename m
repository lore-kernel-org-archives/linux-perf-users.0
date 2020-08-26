From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf test: Perf test 67 dumps core on s390
Date: Wed, 26 Aug 2020 09:55:57 -0300
Message-ID: <20200826125557.GD1059382@kernel.org>
References: <20200825071211.16959-1-tmricht@linux.ibm.com>
 <CAP-5=fUkOyVUgagpkh6zgbjA1Dd0oP_WmP4HVA8f6J3WifwM9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP-5=fUkOyVUgagpkh6zgbjA1Dd0oP_WmP4HVA8f6J3WifwM9w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Aug 25, 2020 at 02:04:30PM -0700, Ian Rogers escreveu:
> On Tue, Aug 25, 2020 at 12:12 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> > Linux 5.9 introduced perf test case "Parse and process metrics" and
> > on s390 this test case always dumps core:

<SNIP>

> Acked-by: Ian Rogers <irogers@google.com>
> 
> This also shows up with address sanitizer on all architectures
> (perhaps change the patch title) and perhaps add a "Fixes: <commit>"
> tag.

$ git tag --contains 0a507af9c681ac2adedc5fe1b2d534e27be85446
perf-tools-2020-08-10
perf-tools-2020-08-14
perf-tools-tests-2020-07-02
perf-tools-tests-2020-07-17
perf-tools-tests-2020-08-05
perf-tools-tests-2020-08-06
v5.9-rc1
v5.9-rc2
$


I added this:

Fixes: 0a507af9c681ac2a ("perf tests: Add parse metric test for ipc metric")

As Jiri forgot to add that sentinel when he first introduced this
pmu_event table, iterators depend on the .name to be NULL to stop.

And added Jiri to the CC, as well as Namhyung Kim, as they are listed in
MAINTAINERS as reviewers for perf:

PERFORMANCE EVENTS SUBSYSTEM
R:      Jiri Olsa <jolsa@redhat.com>
R:      Namhyung Kim <namhyung@kernel.org>

And help me with reviewing all this, thanks,

- Arnaldo
