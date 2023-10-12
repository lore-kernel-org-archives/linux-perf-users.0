Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B4A6FB1
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D5EFBB
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 09:07:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2C6E13D5;
	Thu, 12 Oct 2023 09:08:21 -0700 (PDT)
Received: from [10.57.3.94] (unknown [10.57.3.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E19813F7A6;
	Thu, 12 Oct 2023 09:07:38 -0700 (PDT)
Message-ID: <2219fc04-4484-b365-1281-a5307b368ec5@arm.com>
Date: Thu, 12 Oct 2023 17:07:37 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] perf tests test_arm_coresight: Fix the shellcheck
 warning in latest test_arm_coresight.sh
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 "David.Laight@aculab.com" <David.Laight@ACULAB.COM>, mike.leach@linaro.org,
 James Clark <james.clark@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 tianruidong@linux.alibaba.com, Leo Yan <leo.yan@linaro.org>,
 yangtiezhu@loongson.cn
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>,
 linux-perf-users <linux-perf-users@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>,
 Disha Goel <disgoel@linux.vnet.ibm.com>
References: <20230929041133.95355-1-atrajeev@linux.vnet.ibm.com>
 <20230929041133.95355-2-atrajeev@linux.vnet.ibm.com>
 <CAM9d7cj26Dpit3igZjybsbnotBiv_F8mEu62Aor+9bBhwVh55g@mail.gmail.com>
 <c59c586e-08ab-df66-7bcd-5249d2481298@arm.com>
 <4C5929B2-96B3-46D5-82ED-ADD6A0CDE97B@linux.vnet.ibm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <4C5929B2-96B3-46D5-82ED-ADD6A0CDE97B@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 12/10/2023 16:56, Athira Rajeev wrote:
> 
> 
>> On 05-Oct-2023, at 3:06 PM, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> On 05/10/2023 06:02, Namhyung Kim wrote:
>>> On Thu, Sep 28, 2023 at 9:11 PM Athira Rajeev
>>> <atrajeev@linux.vnet.ibm.com> wrote:
>>>>

...

>> Thanks for the fix.
>>
>> Nothing to do with this patch, but I am wondering if the original patch
>> is over engineered and may not be future proof.
>>
>> e.g.,
>>
>> cs_etm_dev_name() {
>> + cs_etm_path=$(find  /sys/bus/event_source/devices/cs_etm/ -name cpu* -print -quit)
>>
>> Right there you got the device name and we can easily deduce the name of
>> the "ETM" node.
>>
>> e.g,:
>> etm=$(basename $(readlink cs_etm_path) | sed "s/[0-9]\+$//")
>>
>> And practically, nobody prevents an ETE mixed with an ETM on a "hybrid"
>> system (hopefully, no one builds it ;-))
>>
>> Also, instead of hardcoding "ete" and "etm" prefixes from the arch part,
>> we should simply use the cpu nodes from :
>>
>> /sys/bus/event_source/devices/cs_etm/
>>
>> e.g.,
>>
>> arm_cs_etm_traverse_path_test() {
>> # Iterate for every ETM device
>> for c in /sys/bus/event_source/devices/cs_etm/cpu*; do
>> # Read the link to be on the safer side
>> dev=`readlink $c`
>>
>> # Find the ETM device belonging to which CPU
>> cpu=`cat $dev/cpu`
>>
>> # Use depth-first search (DFS) to iterate outputs
>> arm_cs_iterate_devices $dev $cpu
>> done;
>> }
>>
>>
>>
>>> You'd better add Coresight folks on this.
>>> Maybe this file was missing in the MAINTAINERS file.
>>
>> And the original author of the commit, that introduced the issue too.
>>
>> Suzuki
> 
> Hi All,
> Thanks for the discussion and feedbacks.
> 
> This patch fixes the shellcheck warning introduced in function "cs_etm_dev_name". But with the changes that Suzuki suggested, we won't need the function "cs_etm_dev_name" since the code will use "/sys/bus/event_source/devices/cs_etm/" .  In that case, can I drop this patch for now from this series ?
> 

Yes, please. James will send out the proposed patch

Suzuki


