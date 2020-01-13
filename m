From: Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH] perf tools: Fix bug when recording SPE and non SPE events
Date: Mon, 13 Jan 2020 12:28:11 +0000
Message-ID: <14418955-57a8-5e1d-5a42-2d9923b813b6@arm.com>
References: <20191220110525.30131-1-james.clark@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191220110525.30131-1-james.clark@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: nd@arm.com, Mathieu Poirier <mathieu.poirier@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Igor Lubashev <ilubashe@akamai.com>
List-Id: linux-perf-users.vger.kernel.org

On 20/12/2019 11:05, James Clark wrote:
> This patch fixes an issue when non Arm SPE events are specified after an
> Arm SPE event. In that case, perf will exit with an error code and not
> produce a record file. This is because a loop index is used to store the
> location of the relevant Arm SPE PMU, but if non SPE PMUs follow, that
> index will be overwritten. Fix this issue by saving the PMU into a
> variable instead of using the index, and also add an error message.
> 
> Before the fix:
>      ./perf record -e arm_spe/ts_enable=1/ -e branch-misses ls; echo $?
>      237
> 
> After the fix:
>      ./perf record -e arm_spe/ts_enable=1/ -e branch-misses ls; echo $?
>      ...
>      0
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Igor Lubashev <ilubashe@akamai.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
