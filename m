From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 5/5] perf list: specify metrics are to be used with -M
Date: Thu, 19 Sep 2019 15:06:15 -0700
Message-ID: <20190919220615.GG8537@tassilo.jf.intel.com>
References: <20190919204306.12598-1-kim.phillips@amd.com>
 <20190919204306.12598-5-kim.phillips@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190919204306.12598-5-kim.phillips@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Phillips <kim.phillips@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Borislav Petkov <bp@suse.de>, Martin Liska <mliska@suse.cz>, Luke Mujica <lukemujica@google.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

> This misleads the uninitiated user to try:
> 
>   $ perf stat -e C2_Pkg_Residency

Actually I guess we could just fix -e to support metrics too.
Would probably not be that difficult.

-Andi
