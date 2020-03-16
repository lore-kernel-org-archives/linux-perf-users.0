From: Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH v4 2/3] perf vendor events amd: add Zen2 events
Date: Mon, 16 Mar 2020 16:51:52 -0500
Message-ID: <34be3999-34ef-871f-0950-089a00e5b1dd@amd.com>
References: <20200314044453.82554-1-vijaythakkar@me.com>
 <20200314044453.82554-3-vijaythakkar@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200314044453.82554-3-vijaythakkar@me.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Thakkar <vijaythakkar@me.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 3/13/20 11:44 PM, Vijay Thakkar wrote:
> Signed-off-by: Vijay Thakkar <vijaythakkar@me.com>

This email address differs from patch 1/3's S-o-b:

Signed-off-by: thakkarv <thakkarv@gatech.edu>

Choose one, and please spell your whole name out - Vijay Thakkar.

> +++ b/tools/perf/pmu-events/arch/x86/amdzen2/branch.json
> @@ -0,0 +1,52 @@
> +[
> +  {
> +    "EventName": "bp_l1_btb_correct",
> +    "EventCode": "0x8a",
> +    "BriefDescription": "[L1 Branch Prediction Overrides Existing Prediction (speculative)."

Remove the leading '[' in the BriefDescription string.

Other than the above two nit picks:

Acked-by: Kim Phillips <kim.phillips@amd.com>

Thanks,

Kim
