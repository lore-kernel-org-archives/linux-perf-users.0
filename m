Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA124A12;
	Tue,  7 May 2024 04:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715055939; cv=none; b=WE9Rar0UXpcPnr7mfmj2515myCkIyV+SGVl8cQqfon+vpqLVmEvNNtp0TsaUGhsyv0eNhW0MNNbrd//rDG1gMNfdkPr5H+s4tdDJyG9yO2/lUDhPdOpxH/kKa9hLm6irI5NEZ8soFstrf1oWhtBTF7DFaZx6x6GLmUkn9KPTe2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715055939; c=relaxed/simple;
	bh=0DV+Xv8i2wS2RJP3zjqNPEMDxchETKTnTQyk0XX7Mk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNzJVoR/v+1GTUvlh77/dJRGoD8iOSf+bSzKUk11wKTpFXtUmxTpo2WH2VVcazCs0eBq0iu/uEyZz0/KbD1W9U53Eo+2av7TzR+SzDnzVqKsf7hn4Lpfe3yD6jel25uro9yJKXqTUJkI05yqYo6KsG2h73Y84PiW57owwal1R6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAFD21042;
	Mon,  6 May 2024 21:26:02 -0700 (PDT)
Received: from [10.163.33.37] (unknown [10.163.33.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5A323F762;
	Mon,  6 May 2024 21:25:28 -0700 (PDT)
Message-ID: <3fa5f992-b758-4928-9bf9-0c6e82db1f65@arm.com>
Date: Tue, 7 May 2024 09:55:30 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/17] coresight: Clarify comments around the PID of the
 sink owner
Content-Language: en-US
To: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
 gankulkarni@os.amperecomputing.com, scclevenger@os.amperecomputing.com,
 coresight@lists.linaro.org, suzuki.poulose@arm.com, mike.leach@linaro.org
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20240429152207.479221-1-james.clark@arm.com>
 <20240429152207.479221-10-james.clark@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240429152207.479221-10-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/29/24 20:51, James Clark wrote:
> "Process being monitored" and "pid of the process to monitor" imply that
> this would be the same PID if there were two sessions targeting the same
> process. But this is actually the PID of the process that did the Perf
> event open call, rather than the target of the session. So update the
> comments to make this clearer.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

This indeed removes the ambiguity that the PID belongs to the perf session
owner rather than the monitored or target process.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 5 +++--
>  drivers/hwtracing/coresight/coresight-tmc.h     | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index e75428fa1592..8962fc27d04f 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -36,7 +36,8 @@ struct etr_buf_hw {
>   * etr_perf_buffer - Perf buffer used for ETR
>   * @drvdata		- The ETR drvdaga this buffer has been allocated for.
>   * @etr_buf		- Actual buffer used by the ETR
> - * @pid			- The PID this etr_perf_buffer belongs to.
> + * @pid			- The PID of the session owner that etr_perf_buffer
> + *			  belongs to.
>   * @snaphost		- Perf session mode
>   * @nr_pages		- Number of pages in the ring buffer.
>   * @pages		- Array of Pages in the ring buffer.
> @@ -1662,7 +1663,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
>  		goto unlock_out;
>  	}
>  
> -	/* Get a handle on the pid of the process to monitor */
> +	/* Get a handle on the pid of the session owner */
>  	pid = etr_perf->pid;
>  
>  	/* Do not proceed if this device is associated with another session */
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index c77763b49de0..2671926be62a 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -171,8 +171,9 @@ struct etr_buf {
>   * @csdev:	component vitals needed by the framework.
>   * @miscdev:	specifics to handle "/dev/xyz.tmc" entry.
>   * @spinlock:	only one at a time pls.
> - * @pid:	Process ID of the process being monitored by the session
> - *		that is using this component.
> + * @pid:	Process ID of the process that owns the session that is using
> + *		this component. For example this would be the pid of the Perf
> + *		process.
>   * @buf:	Snapshot of the trace data for ETF/ETB.
>   * @etr_buf:	details of buffer used in TMC-ETR
>   * @len:	size of the available trace for ETF/ETB.
