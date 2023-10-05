Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3679E286A6
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95E782B8AD
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 07:23:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37DB41516;
	Thu,  5 Oct 2023 02:37:03 -0700 (PDT)
Received: from [10.57.2.226] (unknown [10.57.2.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA9223F5A1;
	Thu,  5 Oct 2023 02:36:22 -0700 (PDT)
Message-ID: <c59c586e-08ab-df66-7bcd-5249d2481298@arm.com>
Date: Thu, 5 Oct 2023 10:36:21 +0100
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
To: Namhyung Kim <namhyung@kernel.org>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 Leo Yan <leo.yan@linaro.org>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
 irogers@google.com, linux-perf-users@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, kjain@linux.ibm.com,
 disgoel@linux.vnet.ibm.com, Ruidong Tian <tianruidong@linux.alibaba.com>
References: <20230929041133.95355-1-atrajeev@linux.vnet.ibm.com>
 <20230929041133.95355-2-atrajeev@linux.vnet.ibm.com>
 <CAM9d7cj26Dpit3igZjybsbnotBiv_F8mEu62Aor+9bBhwVh55g@mail.gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAM9d7cj26Dpit3igZjybsbnotBiv_F8mEu62Aor+9bBhwVh55g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 05/10/2023 06:02, Namhyung Kim wrote:
> On Thu, Sep 28, 2023 at 9:11 PM Athira Rajeev
> <atrajeev@linux.vnet.ibm.com> wrote:
>>
>> Running shellcheck on tests/shell/test_arm_coresight.sh
>> throws below warnings:
>>
>>          In tests/shell/test_arm_coresight.sh line 15:
>>          cs_etm_path=$(find  /sys/bus/event_source/devices/cs_etm/ -name cpu* -print -quit)
>>                    ^--^ SC2061: Quote the parameter to -name so the shell won't interpret it.
>>
>>          In tests/shell/test_arm_coresight.sh line 20:
>>                  if [ $archhver -eq 5 -a "$(printf "0x%X\n" $archpart)" = "0xA13" ] ; then
>>                                       ^-- SC2166: Prefer [ p ] && [ q ] as [ p -a q ] is not well defined
>>
>> This warning is observed after commit:
>> "commit bb350847965d ("perf test: Update cs_etm testcase for Arm ETE")"
>>
>> Fixed this issue by using quoting 'cpu*' for SC2061 and
>> using "&&" in line number 20 for SC2166 warning
>>
>> Fixes: bb350847965d ("perf test: Update cs_etm testcase for Arm ETE")
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks for the fix.

Nothing to do with this patch, but I am wondering if the original patch
is over engineered and may not be future proof.

e.g.,

cs_etm_dev_name() {
+	cs_etm_path=$(find  /sys/bus/event_source/devices/cs_etm/ -name cpu* 
-print -quit)

Right there you got the device name and we can easily deduce the name of
the "ETM" node.

e.g,:
	etm=$(basename $(readlink cs_etm_path) | sed "s/[0-9]\+$//")

And practically, nobody prevents an ETE mixed with an ETM on a "hybrid"
system (hopefully, no one builds it ;-))

Also, instead of hardcoding "ete" and "etm" prefixes from the arch part,
we should simply use the cpu nodes from :

/sys/bus/event_source/devices/cs_etm/

e.g.,

arm_cs_etm_traverse_path_test() {
	# Iterate for every ETM device
	for c in /sys/bus/event_source/devices/cs_etm/cpu*; do
		# Read the link to be on the safer side
		dev=`readlink $c`
		
		# Find the ETM device belonging to which CPU
		cpu=`cat $dev/cpu`

		# Use depth-first search (DFS) to iterate outputs
		arm_cs_iterate_devices $dev $cpu
	done;
}



> 
> You'd better add Coresight folks on this.
> Maybe this file was missing in the MAINTAINERS file.

And the original author of the commit, that introduced the issue too.

Suzuki

> 
> Thanks,
> Namhyung
> 
> 
>> ---
>>   tools/perf/tests/shell/test_arm_coresight.sh | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
>> index fe78c4626e45..f2115dfa24a5 100755
>> --- a/tools/perf/tests/shell/test_arm_coresight.sh
>> +++ b/tools/perf/tests/shell/test_arm_coresight.sh
>> @@ -12,12 +12,12 @@
>>   glb_err=0
>>
>>   cs_etm_dev_name() {
>> -       cs_etm_path=$(find  /sys/bus/event_source/devices/cs_etm/ -name cpu* -print -quit)
>> +       cs_etm_path=$(find  /sys/bus/event_source/devices/cs_etm/ -name 'cpu*' -print -quit)
>>          trcdevarch=$(cat ${cs_etm_path}/mgmt/trcdevarch)
>>          archhver=$((($trcdevarch >> 12) & 0xf))
>>          archpart=$(($trcdevarch & 0xfff))
>>
>> -       if [ $archhver -eq 5 -a "$(printf "0x%X\n" $archpart)" = "0xA13" ] ; then
>> +       if [ $archhver -eq 5 ] && [ "$(printf "0x%X\n" $archpart)" = "0xA13" ] ; then
>>                  echo "ete"
>>          else
>>                  echo "etm"
>> --
>> 2.31.1
>>

