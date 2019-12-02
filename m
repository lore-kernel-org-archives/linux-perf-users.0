From: Qi Liu <liuqi115@hisilicon.com>
Subject: Re: [RFC v3 0/5] perf tools: Add support for some spe events and
 precise ip
Date: Mon, 2 Dec 2019 15:07:40 +0800
Message-ID: <07717318-ddab-e57d-e356-52dff683ac76@hisilicon.com>
References: <20191123101118.12635-1-tanxiaojun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191123101118.12635-1-tanxiaojun@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tan Xiaojun <tanxiaojun@huawei.com>, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com, adrian.hunter@intel.com, yao.jin@linux.intel.com, tmricht@linux.ibm.com, brueckner@linux.ibm.com, songliubraving@fb.com, gregkh@linuxfoundation.org, kim.phillips@arm.com, James.Clark@arm.com, jeremy.linton@arm.com
Cc: gengdongjiu@huawei.com, wxf.wang@hisilicon.com, liwei391@huawei.com, huawei.libin@huawei.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org


Tested-by: Qi Liu <liuqi115@hisilicon.com>


On 2019/11/23 18:11, Tan Xiaojun wrote:
> After the commit ffd3d18c20b8 ("perf tools: Add ARM Statistical
> Profiling Extensions (SPE) support") is merged, "perf record" and
> "perf report --dump-raw-trace" have been supported. However, the
> raw data that is dumped cannot be used without parsing.
> 
> This patchset is to improve the "perf report" support for spe, and
> further process the data. Currently, support for the three events
> of llc-miss, tlb-miss, branch-miss and remote-access is added.
> 
> v1->v2:
> Some cleanup and bugfix fixes were made, and support for the precise
> ip of branch-misses was added. Thanks for the suggestions of Jeremy
> and James.
> 
> v2->v3:
> Mainly add four spe precise ip events, you can see through perf list.
> More details in [5/5].
> 
> Tan Xiaojun (5):
>   perf tools: Move arm-spe-pkt-decoder.h/c to the new dir
>   perf tools: Add support for "report" for some spe events
>   perf report: Add --spe options for arm-spe
>   drivers: perf: add some arm spe events
>   perf tools: Add support to process multi spe events
> 
>  drivers/perf/arm_spe_pmu.c                    |  44 +
>  tools/perf/Documentation/perf-report.txt      |  10 +
>  tools/perf/arch/arm64/util/arm-spe.c          |  47 +-
>  tools/perf/builtin-report.c                   |   5 +
>  tools/perf/util/Build                         |   2 +-
>  tools/perf/util/arm-spe-decoder/Build         |   1 +
>  .../util/arm-spe-decoder/arm-spe-decoder.c    | 225 +++++
>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  66 ++
>  .../arm-spe-pkt-decoder.c                     |   0
>  .../arm-spe-pkt-decoder.h                     |   2 +
>  tools/perf/util/arm-spe.c                     | 771 +++++++++++++++++-
>  tools/perf/util/arm-spe.h                     |  20 +
>  tools/perf/util/auxtrace.c                    |  49 ++
>  tools/perf/util/auxtrace.h                    |  29 +
>  tools/perf/util/session.h                     |   2 +
>  15 files changed, 1231 insertions(+), 42 deletions(-)
>  create mode 100644 tools/perf/util/arm-spe-decoder/Build
>  create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
>  create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>  rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c (100%)
>  rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h (96%)
> 
