From: Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH v5 1/3] perf vendor events amd: restrict model detection
 for zen1 based processors
Date: Mon, 16 Mar 2020 18:59:22 -0500
Message-ID: <b2deb965-7274-8b6f-08b7-1a93e4a2e4df@amd.com>
References: <20200316225238.150154-1-vijaythakkar@me.com>
 <20200316225238.150154-2-vijaythakkar@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200316225238.150154-2-vijaythakkar@me.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Thakkar <vijaythakkar@me.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 3/16/20 5:52 PM, Vijay Thakkar wrote:
> This patch changes the previous blanket detection of AMD Family 17h
> processors to be more specific to Zen1 core based products only by
> replacing model detection regex pattern [[:xdigit:]]+ with
> ([12][0-9A-F]|[0-9A-F]), restricting to models 0 though 2f only.
> 
> This change is required to allow for the addition of separate PMU events
> for Zen2 core based models in the following patches as those belong to family
> 17h but have different PMCs. Current PMU events directory has also been
> renamed to "amdzen1" from "amdfam17h" to reflect this specificity.
> 
> Note that although this change does not break PMU counters for existing
> zen1 based systems, it does disable the current set of counters for zen2
> based systems. Counters for zen2 have been added in the following
> patches in this patchset.
> 
> Signed-off-by: Vijay Thakkar <vijaythakkar@me.com>

For the series:

Acked-by: Kim Phillips <kim.phillips@amd.com>

Thanks,

Kim
