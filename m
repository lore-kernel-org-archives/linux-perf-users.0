Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BF822309
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Nov 2023 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtmQIICI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D9210F4;
	Mon, 13 Nov 2023 08:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699891942; x=1731427942;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4VEc6JlfwxRewMFkIOiVv53BgqJpYuGG3zMaWjS+Giw=;
  b=JtmQIICINi0s15C8ltOAu8IzrUcNhOJk99Yg3OL+RJ/YrNrlB2jfm9EL
   /N03d18fQ2OSpi4pBPNq/Cxam7Y76GsoNnpYe5hSBnGnmhO1wlJf+h0Pr
   jH+mKMScfWjWKOi+88/b7fHMEZGL/Ain9vGcrWOf7FAJuudwsotb22TId
   X56gX/4AsUULXnfzMtAAsrjmEXQhP0u7/9wSbK+P6+VUy2DeNzNanpMap
   +8sHQRQt9XzPDJcF/5lXPvd3t0JRsJy+lVSP6hlxby28QNOo0SRcsR+bb
   cWUCW2Gh4tUhSmQVVkcw/Jjt+NDUVLxs5vBb1Ad7n1jNPd6w6fUcrZQZu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="3509097"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="3509097"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 08:11:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="764368123"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="764368123"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 08:11:44 -0800
Received: from [10.212.17.243] (kliang2-mobl1.ccr.corp.intel.com [10.212.17.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id ACAA45805B5;
	Mon, 13 Nov 2023 08:11:43 -0800 (PST)
Message-ID: <85aac482-2318-4fb5-be8a-b6d17e19407b@linux.intel.com>
Date: Mon, 13 Nov 2023 11:11:43 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] perf test: Basic branch counter support
Content-Language: en-US
To: acme@kernel.org, irogers@google.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, jolsa@kernel.org,
 namhyung@kernel.org, adrian.hunter@intel.com, tinghao.zhang@intel.com
References: <20231107184020.1497571-1-kan.liang@linux.intel.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231107184020.1497571-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ian,

On 2023-11-07 1:40 p.m., kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Add a basic test for the branch counter feature.
> 
> The test verifies that
> - The new filter can be successfully applied on the supported platforms.
> - The counter value can be outputted via the perf report -D
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
> 
> Changes since V2:
> - Update the output msg for the skipped case (Ian)
> 

Any comments for this patch?

Thanks,
Kan

>  tools/perf/tests/shell/record.sh | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 4fbc74805d52..cc207a16ae24 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -11,6 +11,9 @@ err=0
>  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  testprog="perf test -w thloop"
>  testsym="test_loop"
> +cpu_pmu_dir="/sys/bus/event_source/devices/cpu*"
> +br_cntr_file="/caps/branch_counter_nr"
> +br_cntr_output="branch stack counters"
>  
>  cleanup() {
>    rm -rf "${perfdata}"
> @@ -154,10 +157,37 @@ test_workload() {
>    echo "Basic target workload test [Success]"
>  }
>  
> +test_branch_counter() {
> +  echo "Basic branch counter test"
> +  # Check if the branch counter feature is supported
> +  for dir in $cpu_pmu_dir
> +  do
> +    if [ ! -e "$dir$br_cntr_file" ]
> +    then
> +      echo "branch counter feature not supported on all core PMUs ($dir) [Skipped]"
> +      return
> +    fi
> +  done
> +  if ! perf record -o "${perfdata}" -j any,counter ${testprog} 2> /dev/null
> +  then
> +    echo "Basic branch counter test [Failed record]"
> +    err=1
> +    return
> +  fi
> +  if ! perf report -i "${perfdata}" -D -q | grep -q "$br_cntr_output"
> +  then
> +    echo "Basic branch record test [Failed missing output]"
> +    err=1
> +    return
> +  fi
> +  echo "Basic branch counter test [Success]"
> +}
> +
>  test_per_thread
>  test_register_capture
>  test_system_wide
>  test_workload
> +test_branch_counter
>  
>  cleanup
>  exit $err
