From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/8] perf metrics: fix parse errors in cascade lake
 metrics
Date: Wed, 22 Apr 2020 07:38:40 -0700
Message-ID: <20200422143840.GJ608746@tassilo.jf.intel.com>
References: <20200422074809.160248-1-irogers@google.com>
 <20200422074809.160248-3-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200422074809.160248-3-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 22, 2020 at 12:48:03AM -0700, Ian Rogers wrote:
> Remove over escaping with \\.
> Remove extraneous if 1 if 0 == 1 else 0 else 0.

So where do these parse errors happen exactly? Some earlier 
patches introduced them as regressions?

The original metrics worked without parse errors as far as I know.

If it fixes something earlier it would need Fixes: tags.

-Andi
