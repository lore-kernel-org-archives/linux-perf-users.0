Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8031199E9A;
	Thu,  6 Jun 2024 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697705; cv=none; b=FEyN4OmEc2YHMY1RhjoYRUDk/7wz/ae8SFRSJT+Plie7NILxffbTZXRxLtGdzkEseOTvcclng6otDRVVbE+m1ywMh51ocXBxa5pjvW4+BeTpsjB/QzjYI7wp4AsG/7argxuNh9R3/51Z8Th1JYoenysOjCWKF2XCePe+QQykZxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697705; c=relaxed/simple;
	bh=egWboMGOoCOOUrz/f57Ri2iKR67Rqvxoy2IOaJTVpvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hjwb12C6x1ZLbj6f1aod9JGRoCj47G04YuKq+p2Kqyac5X/QEojTbTLjyFMCiaDav4HCPcoKHAa9ZhJZxKAnWPntoqFQWBbMKGVjxQEgi+ScfK2a6ToYm64sxT14OzW1/eLASaHnCUAjDRlXpJ/6DdxabyYJplL8JQX+nGWhKVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MUPxSoSc; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUPxSoSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717697704; x=1749233704;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=egWboMGOoCOOUrz/f57Ri2iKR67Rqvxoy2IOaJTVpvk=;
  b=MUPxSoSckSYaIpJkZsH8GAIuRvdmIiRbZiktThf7dDryN6u0/xsjxTYL
   bi6tc4R+UsEu2Nr/KAgLXP6c0aJtbGtFF5Nq5gMrL7vubUgXNfwxYZTlU
   v5epRwEy2DYd94/IBqM8eMDw0mmUkvFNSNqsJEl+0+F/bSzPTXGbDZkMB
   HQjRgdIaqIhHbzU6LIg8BjBos2P9PSGYQovvSrWtoqqCR/236YbWP8hNz
   cGSWtywHmuCNvIkC83SQPbpggN4gE5QxFtiamWgH5vQUGNupHcU2iWVBH
   Wbil1WgkzV+jiapM1ZHy+IgDAId2vTjwvxba78G0Ng8EnxdHtu5mtsCmH
   A==;
X-CSE-ConnectionGUID: PHpZ7/iwQ1+ZpTLC9gItRg==
X-CSE-MsgGUID: QDJvq7n7QtCBc0WvFcQGjw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25788597"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="25788597"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 11:15:03 -0700
X-CSE-ConnectionGUID: DBIHofN/TLK3Lj2QHtHp0g==
X-CSE-MsgGUID: FtCukTPlSLqRoPn9CsJerw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="37978935"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 11:15:02 -0700
Received: from [10.212.72.92] (kliang2-mobl1.ccr.corp.intel.com [10.212.72.92])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 6EA6E20B5703;
	Thu,  6 Jun 2024 11:15:00 -0700 (PDT)
Message-ID: <c7d6eedb-7c5e-4411-a83f-4328dc75ec46@linux.intel.com>
Date: Thu, 6 Jun 2024 14:14:59 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] perf Documentation: Describe the PMU naming
 convention
To: Ian Rogers <irogers@google.com>, Randy Dunlap <rdunlap@infradead.org>,
 Tuan Phan <tuanphan@os.amperecomputing.com>,
 Robin Murphy <robin.murphy@arm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Bhaskara Budiredla <bbudiredla@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, Stephane Eranian <eranian@google.com>
References: <20240606044959.335715-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240606044959.335715-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-06-06 12:49 a.m., Ian Rogers wrote:
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

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

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
