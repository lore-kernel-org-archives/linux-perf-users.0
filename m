Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2937F
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 03:15:27 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AB59F;
	Mon, 25 Sep 2023 20:15:24 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VsvBD6V_1695698120;
Received: from 30.221.149.38(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VsvBD6V_1695698120)
          by smtp.aliyun-inc.com;
          Tue, 26 Sep 2023 11:15:22 +0800
Message-ID: <f4812cce-14d2-9771-233f-b0db5af449be@linux.alibaba.com>
Date: Tue, 26 Sep 2023 11:15:19 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v10 0/7] Add metrics for Arm CMN
To: Ian Rogers <irogers@google.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 James Clark <james.clark@arm.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 Zhuo Song <zhuo.song@linux.alibaba.com>,
 Shuai Xue <xueshuai@linux.alibaba.com>
References: <1695621444-56530-1-git-send-email-renyu.zj@linux.alibaba.com>
 <CAP-5=fWuaii1rOOvN7rJDo3UoQvkEtiJv3QiBhLRhYk1_Se7ew@mail.gmail.com>
From: Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <CAP-5=fWuaii1rOOvN7rJDo3UoQvkEtiJv3QiBhLRhYk1_Se7ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/9/26 上午12:37, Ian Rogers 写道:
> On Sun, Sep 24, 2023 at 10:58 PM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>>
>> Changes since v8:
>> - Add fully match identifier check as suggested by Ian.
>> - Link: https://lore.kernel.org/lkml/1695037955-107983-1-git-send-email-renyu.zj@linux.alibaba.com/
>>
>> Jing Zhang (7):
>>   perf pmu: "Compat" supports regular expression matching identifiers
>>   perf metric: "Compat" supports regular expression matching identifiers
>>   perf jevents: Support EventidCode and NodeType
>>   perf test: Make matching_pmu effective
>>   perf test: Add pmu-event test for "Compat" and new event_field.
>>   perf jevents: Add support for Arm CMN PMU aliasing
>>   perf vendor events: Add JSON metrics for Arm CMN
> 
> Thanks for the patience with all the to and fro. I was able to test
> the series with "git am -3" to get around a merge issue on
> perf-tools-next.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Tested-by: Ian Rogers <irogers@google.com>
> 

Thank you for following this series and providing many valuable suggestions.

Thanks,
Jing

> Thanks,
> Ian
> 
>>  .../pmu-events/arch/arm64/arm/cmn/sys/cmn.json     | 266 +++++++++++++++++++++
>>  .../pmu-events/arch/arm64/arm/cmn/sys/metric.json  |  74 ++++++
>>  .../pmu-events/arch/test/test_soc/sys/uncore.json  |   8 +
>>  tools/perf/pmu-events/empty-pmu-events.c           |   8 +
>>  tools/perf/pmu-events/jevents.py                   |  11 +-
>>  tools/perf/tests/pmu-events.c                      |  65 ++++-
>>  tools/perf/util/metricgroup.c                      |   2 +-
>>  tools/perf/util/pmu.c                              |  27 ++-
>>  tools/perf/util/pmu.h                              |   1 +
>>  9 files changed, 456 insertions(+), 6 deletions(-)
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json
>>
>> --
>> 1.8.3.1
>>
