From: Kim Phillips <kim.phillips@arm.com>
Subject: Re: [PATCH 1/2] perf tests: Add event parsing error handling to
 parse events test
Date: Mon, 11 Jun 2018 12:04:14 -0500
Message-ID: <20180611120414.c128fc280e0fa827aff743a8@arm.com>
References: <0d25bc25-ed0b-81bb-c516-12fd25442427@linux.ibm.com>
        <20180611093422.1005-1-jolsa@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611093422.1005-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Thomas-Mich Richter <tmricht@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Mon, 11 Jun 2018 11:34:21 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Add missing error handling for parse_events calls in test_event
> function that led to following segfault on s390:

like I said, this happens on any $ARCH machine without intel_pt
hardware.

Other than that, for both 1 & 2 in this series:

[Reported-and-]Tested-by: Kim Phillips <kim.phillips@arm.com>

Thanks,

Kim
