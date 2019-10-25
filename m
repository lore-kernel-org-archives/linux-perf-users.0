From: Tan Xiaojun <tanxiaojun@huawei.com>
Subject: Re: [RFC v2 4/4] perf tools: Support "branch-misses:pp" on arm64
Date: Fri, 25 Oct 2019 10:42:52 +0800
Message-ID: <38c18a3e-1b9a-05fe-63f6-920af2f53fc7@huawei.com>
References: <20191024144830.16534-1-tanxiaojun@huawei.com>
 <20191024144830.16534-5-tanxiaojun@huawei.com>
 <AM4PR0802MB224263700592195B3BAE9D5AE26A0@AM4PR0802MB2242.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM4PR0802MB224263700592195B3BAE9D5AE26A0@AM4PR0802MB2242.eurprd08.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: James Clark <James.Clark@arm.com>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>, "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, "jolsa@redhat.com" <jolsa@redhat.com>, "namhyung@kernel.org" <namhyung@kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "yao.jin@linux.intel.com" <yao.jin@linux.intel.com>, "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>, "brueckner@linux.ibm.com" <brueckner@linux.ibm.com>, "songliubraving@fb.com" <songliubraving@fb.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Kim Phillips <Kim.Phillips@arm.com>, Jeremy Linton <Jeremy.Linton@arm.com>
Cc: "gengdongjiu@huawei.com" <gengdongjiu@huawei.com>, "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>, "liwei391@huawei.com" <liwei391@huawei.com>, "huawei.libin@huawei.com" <huawei.libin@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, nd <nd@arm.com>
List-Id: linux-perf-users.vger.kernel.org

On 2019/10/25 0:29, James Clark wrote:
> Hi Xiaojun,
> 
> This looks really good. I tried this, but got an error:
> 
>     ./perf record -e branch-misses:p ls
>     Error:
>     The branch-misses:p event is not supported.

Hi, James,

I can't reproduce this problem. If the current system doesn't support spe, it shouldn't report an error. I use the latest codes of the mainline:

commit f116b96685a046a89c25d4a6ba2da489145c8888 (mainline/master)
Merge: f632bfaa33ed 603d9299da32
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Oct 24 06:13:45 2019 -0400

    Merge tag 'mfd-fixes-5.4' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd

I will go and see why this will be reported.

> 
> 
> I would have expected to use the event name that is listed in the SPE documentation for branch misses which is br_mis_pred or br_mis_pred_retired:
> 
>     E[7], byte 0 bit [7]
>     Mispredicted. The defined values of this bit are:
>     0 Did not cause correction to the predicted program flow.
>     1 A branch that caused a correction to the predicted program flow.
> 
>     If PMUv3 is implemented this Event is required to be implemented consistently with either BR_MIS_PRED or BR_MIS_PRED_RETIRED.
> 

Do you mean that I can add these as new events to perf? If we think of them as new events, what should we do if the user does not add :pp for them?
(Or for these events, users can only add :pp to use them?)

> 
> +       if (!strcmp(perf_env__arch(evlist->env), "arm64")
> +                       && evsel->core.attr.config == PERF_COUNT_HW_BRANCH_MISSES
> +                       && evsel->core.attr.precise_ip) {
> 
> As I mentioned above PERF_COUNT_HW_BRANCH_MISSESdoesn't seem to match up with the actual event counter that is associated with this SPE event (BR_MIS_PRED). The fix for this is probably as simple as adding an OR for the other aliases for branch mispredicts.

What you mean is that we can filter with spe events(like BR_MIS_PRED) first, and if we have other events that are exactly the same(no more for now), then we can handle them by adding OR in the future?

> 
> +               pmu = perf_pmu__find("arm_spe_0");
> +               if (pmu) {
> +                       evsel->pmu_name = pmu->name;
> +                       evsel->core.attr.type = PERF_RECORD_AUXTRACE;
> +                       evsel->core.attr.config = SPE_ATTR_TS_ENABLE
> +                                               | SPE_ATTR_PA_ENABLE
> 
> I wouldn't set physical addresses by default as this requires root. I would leave that to the user if they want to manually configure SPE.

Yes. You are right. I got a error for this case. I will fix it.

------------------
./perf record -e branch-misses:p ls
Error:
You may not have permission to collect stats.
...
------------------

Thanks.
Xiaojun.

> 
> I have only looked briefly and I will do some more testing.
> 
> 
> Thanks
> James
> 
> 
