Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE47C241F1
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 13:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6060311B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 06:48:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2BC4DA7;
	Thu,  5 Oct 2023 01:20:43 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A75683F762;
	Thu,  5 Oct 2023 01:20:03 -0700 (PDT)
Message-ID: <552cbde4-6077-d5a4-251e-6c77786e1b31@arm.com>
Date: Thu, 5 Oct 2023 09:20:03 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] perf tests test_arm_coresight: Fix the shellcheck
 warning in latest test_arm_coresight.sh
Content-Language: en-US
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
 acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
 irogers@google.com, namhyung@kernel.org,
 "coresight@lists.linaro.org" <coresight@lists.linaro.org>
References: <20230929041133.95355-1-atrajeev@linux.vnet.ibm.com>
 <20230929041133.95355-2-atrajeev@linux.vnet.ibm.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20230929041133.95355-2-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 29/09/2023 05:11, Athira Rajeev wrote:
> Running shellcheck on tests/shell/test_arm_coresight.sh
> throws below warnings:
> 
> 	In tests/shell/test_arm_coresight.sh line 15:
> 	cs_etm_path=$(find  /sys/bus/event_source/devices/cs_etm/ -name cpu* -print -quit)
>                   ^--^ SC2061: Quote the parameter to -name so the shell won't interpret it.
> 
> 	In tests/shell/test_arm_coresight.sh line 20:
> 		if [ $archhver -eq 5 -a "$(printf "0x%X\n" $archpart)" = "0xA13" ] ; then
>                 	             ^-- SC2166: Prefer [ p ] && [ q ] as [ p -a q ] is not well defined
> 
> This warning is observed after commit:
> "commit bb350847965d ("perf test: Update cs_etm testcase for Arm ETE")"
> 
> Fixed this issue by using quoting 'cpu*' for SC2061 and
> using "&&" in line number 20 for SC2166 warning
> 
> Fixes: bb350847965d ("perf test: Update cs_etm testcase for Arm ETE")
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/tests/shell/test_arm_coresight.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
> index fe78c4626e45..f2115dfa24a5 100755
> --- a/tools/perf/tests/shell/test_arm_coresight.sh
> +++ b/tools/perf/tests/shell/test_arm_coresight.sh
> @@ -12,12 +12,12 @@
>  glb_err=0
>  
>  cs_etm_dev_name() {
> -	cs_etm_path=$(find  /sys/bus/event_source/devices/cs_etm/ -name cpu* -print -quit)
> +	cs_etm_path=$(find  /sys/bus/event_source/devices/cs_etm/ -name 'cpu*' -print -quit)
>  	trcdevarch=$(cat ${cs_etm_path}/mgmt/trcdevarch)
>  	archhver=$((($trcdevarch >> 12) & 0xf))
>  	archpart=$(($trcdevarch & 0xfff))
>  
> -	if [ $archhver -eq 5 -a "$(printf "0x%X\n" $archpart)" = "0xA13" ] ; then
> +	if [ $archhver -eq 5 ] && [ "$(printf "0x%X\n" $archpart)" = "0xA13" ] ; then
>  		echo "ete"
>  	else
>  		echo "etm"


Reviewed-by: James Clark <james.clark@arm.com>
