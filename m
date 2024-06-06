Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9216813FD84;
	Thu,  6 Jun 2024 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666418; cv=none; b=E+a/hFpjZVyMJou9yuFz8Heh6Kc3d0jmkPE70DliT/MRhJTFzt1H3xC4IFFd0u3TrcE0LkSnxiGaiI6THth1Ihl2rEhEHJi9uuDZIPaqh+zkMFDy3N3J3OL/mPZO+VJXq7BwqVRPIuyhxTvTQCYsGyhS/80KXluRwO4q/3mgC8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666418; c=relaxed/simple;
	bh=yNQtgmOdla3Ckbrk8hnsTrJ71kfZQrEz/u72sExF69g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=hNzCLN5+qvTJ+91kgS1aGAtCj0WnB93Ugy0jusQsKkAi1wqEZT/U+Wa68qQyi6WXUmzupxvr5HKnydumoASU2yRb61XLmHIihfEjIa8IBSF7X6YnfZh4UTx3f6BMNTKVXr8zwQeDJVGw59E5PiSIdGNPljYmvZwhkNSY7UscoUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DB32339;
	Thu,  6 Jun 2024 02:34:00 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A5B03F762;
	Thu,  6 Jun 2024 02:33:33 -0700 (PDT)
Message-ID: <e8d6f004-a19a-4bab-b133-102483a5e2d9@arm.com>
Date: Thu, 6 Jun 2024 10:33:32 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] perf Documentation: Describe the PMU naming
 convention
To: Ian Rogers <irogers@google.com>
References: <20240606044959.335715-1-irogers@google.com>
Content-Language: en-US
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Tuan Phan <tuanphan@os.amperecomputing.com>,
 Robin Murphy <robin.murphy@arm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Bhaskara Budiredla <bbudiredla@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria
 <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Stephane Eranian <eranian@google.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240606044959.335715-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06/06/2024 05:49, Ian Rogers wrote:
> It is an existing convention to use suffixes with PMU names. Try to
> capture that convention so that future PMU devices may adhere to it.
> 
> The name of the file and date within the file try to follow existing
> conventions, particularly sysfs-bus-event_source-devices-events.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  .../testing/sysfs-bus-event_source-devices    | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices b/Documentation/ABI/testing/sysfs-bus-event_source-devices
> new file mode 100644
> index 000000000000..79b268319df1
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices
> @@ -0,0 +1,24 @@
> +What: /sys/bus/event_source/devices/<pmu>
> +Date: 2014/02/24
> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +Description:	Performance Monitoring Unit (<pmu>)
> +
> +		Each <pmu> directory, for a PMU device, is a name
> +		optionally followed by an underscore and then either a
> +		decimal or hexadecimal number. For example, cpu is a
> +		PMU name without a suffix as is intel_bts,
> +		uncore_imc_0 is a PMU name with a 0 numeric suffix,
> +		ddr_pmu_87e1b0000000 is a PMU name with a hex
> +		suffix. The hex suffix must be more than two
> +		characters long to avoid ambiguity with PMUs like the
> +		S390 cpum_cf.
> +
> +		Tools can treat PMUs with the same name that differ by
> +		suffix as instances of the same PMU for the sake of,
> +		for example, opening an event. For example, the PMUs
> +		uncore_imc_free_running_0 and
> +		uncore_imc_free_running_1 have an event data_read;
> +		opening the data_read event on a PMU specified as
> +		uncore_imc_free_running should be treated as opening
> +		the data_read event on PMU uncore_imc_free_running_0
> +		and PMU uncore_imc_free_running_1.

Reviewed-by: James Clark <james.clark@arm.com>
