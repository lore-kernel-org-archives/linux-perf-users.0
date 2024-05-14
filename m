Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACEC17FF;
	Tue, 14 May 2024 05:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715665256; cv=none; b=pzoAKQDO3i2bQlbpTj4dtFx969fOyNEA9anU6WTOiTJTO+LDxQ1VTLJIZOxnjXMcY1YM/QOqY+6l7fJrVzzgtYtic5Az338U7aQGZPKSkPZ04BVtfixFJHtgAtq3QKthOEkSSOqIHW+wxtf06LDWzlpD+G0sxF3FqYE3Cv42rO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715665256; c=relaxed/simple;
	bh=Pu/7+bRXOsXzA1dbf5qN3S1loGmvxS5Xgd1PfNlSCcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WwzrUvUH63QUk+Rq5IikQ/D4yIeL9byIM5iuvXaVEiEqny5RR8bVdU6tAhFQTChU6Oa4yTDysbxxJ0bGPhexCLGwziUix3y1GOHro4SgtlPNoBSiZZO5jbsqrmAq6xbvJV0wB0c8WjCCYa8F3TBGpFmtcys8vk6tuB1g+pWdvGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kSq4+5+4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kSq4+5+4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=wGQ2BN7dODhp2l12BVwJ1rFeeAjNCfz9WxnSHzHK97I=; b=kSq4+5+4366RAk2fuBgmmgIpnf
	T8K3mtJuQNBpm5J2SFdJnRaEbsRb1iUUYvlBfZ7JBTeg4gZjZqF+iOri+ozUL2nbyj8FIL/vWMEo/
	/LeVcu5wr0pKjc5jBgBbOClyciPeeAi2e9gUzNMaAeyauLALMgxAze6KWZobUHo0hLY2LSQ218nCt
	p/LBPBOC+htOB9rZTssNr14NOeu0bbxrplhEYtovXgjWmZMSLifprUh6bD78HsqvHY1q7nGJoanP2
	zrfto5OZUPQRWiJxR5k6RuQ3qhRFo5Pj+iAMXL8xzeTGWmUV47BmU9ShjRPqUE73UwquARF1iz8wA
	lzsQ7BFA==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6ku6-0000000F3Q4-1p7E;
	Tue, 14 May 2024 05:40:46 +0000
Message-ID: <793876b1-fd4d-42ef-91e2-88b4a48794b7@infradead.org>
Date: Mon, 13 May 2024 22:40:44 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] perf Documentation: Describe the PMU naming
 convention
To: Ian Rogers <irogers@google.com>,
 Tuan Phan <tuanphan@os.amperecomputing.com>,
 Robin Murphy <robin.murphy@arm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Bhaskara Budiredla <bbudiredla@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Stephane Eranian <eranian@google.com>
References: <20240514005817.2902473-1-irogers@google.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240514005817.2902473-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/13/24 5:58 PM, Ian Rogers wrote:
> It is an existing convention to use suffixes with PMU names. Try to
> capture that convention so that future PMU devices may adhere to it.
> 
> The name of the file and date within the file try to follow existing
> conventions, particularly sysfs-bus-event_source-devices-events.
> ---
>  .../testing/sysfs-bus-event_source-devices    | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices b/Documentation/ABI/testing/sysfs-bus-event_source-devices
> new file mode 100644
> index 000000000000..3f7e53e82de7
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices
> @@ -0,0 +1,24 @@
> +What: /sys/bus/event_source/devices/<pmu>
> +Date: 2014/02/24
> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +Description:	Performance Monitoring Unit (<pmu>)
> +

Mostly looks good to me. I prefer a small change (below).

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
> +		uncore_imc_free_running_1 have an event data_read,

s/,/;/
or: s/,/./ and begin the next sentence with a capital letter.

> +		opening the data_read event on a PMU specified as
> +		uncore_imc_free_running should be treated as opening
> +		the data_read event on PMU uncore_imc_free_running_0
> +		and PMU uncore_imc_free_running_1.

With that change, you may add:

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html
