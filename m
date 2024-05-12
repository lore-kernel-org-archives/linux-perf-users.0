Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3B542A8B;
	Sun, 12 May 2024 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715551721; cv=none; b=GASLGExKnVYpxOZjsOjN2UseDXQXzS9GdIS5EK4h8TEM1Id1xqnf7h8yOcp9oypTsrh3xwgVubg4oKUKLt+8cGGVWrKA2c4iJQXnnfgUGd51Z5AXUxmRig7BjOAxYDZlErgdsNmuM0ZLPvCtjznD1uHBXjeP+Hf+K3z27pmPVo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715551721; c=relaxed/simple;
	bh=saSiuNCox8WE/j7MV0S3IglJSFOms36rEidWeYmFR6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iXmyZaNx8DNCXUEZv0DNv8d40/9aaaqACxlU71vZ9ScZHs9v7ZyhorO3p8IDKRfhYQc8aKD35Hjwn5pQLJhQMpeVPclwyu3SFzrFIG6SYRSLuH2VmMvcDE8+OEb3jR+guBbaR39ej3J7xArE54o/7RRxQkAr27wlzkr63TPgIfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k30hwl3R; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k30hwl3R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=yFDzHR2BS8U20l3vvwYMeNLYCXMXMPHJ0iTX2uhbBPc=; b=k30hwl3R35fB6PdAne5xNyCYvD
	LKbNIihBVvAvkrMvCX6YcV1hFypEvOmwNXmtaN7Fdo5S5bo92ysfDcJEerHllDR5uId4nsmomJ9eW
	865no5ALTtnmSw851AQMoQvM6e5BQAjRK19Ptmz6/vYheLXI+9Bzo/mUMPdmX5xiMEb7LU/SMBtAD
	XYhnlX+HbBNuYzaKXXRgrrQ3Ew5HIP0P8Q6q+K81vrm6ifviJcmv1RLhC0L6QpfgAKc1iP2wDgJ4H
	fhRvwblJSuJ7a/34+yyIpf0ytHAbF0MHw2JmZKDcw4CsGaHaRobzqYu6a4VA3zAMqhRd7mAi5PFj7
	gxebKkug==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6HMs-0000000Av8y-2DOl;
	Sun, 12 May 2024 22:08:30 +0000
Message-ID: <fe41f9a7-5726-49d5-9bc6-70102d9680a1@infradead.org>
Date: Sun, 12 May 2024 15:08:27 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] perf Document: Sysfs event names must be lower or
 upper case
To: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Jing Zhang <renyu.zj@linux.alibaba.com>,
 James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240502213507.2339733-1-irogers@google.com>
 <20240502213507.2339733-3-irogers@google.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240502213507.2339733-3-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/2/24 2:35 PM, Ian Rogers wrote:
> To avoid directory scans in perf it is going to be assumed that sysfs
> event names are either lower or upper case.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  .../ABI/testing/sysfs-bus-event_source-devices-events       | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> index 77de58d03822..e7efeab2ee83 100644
> --- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> @@ -37,6 +37,12 @@ Description:	Per-pmu performance monitoring events specific to the running syste
>  		performance monitoring event supported by the <pmu>. The name
>  		of the file is the name of the event.
>  
> +		As performance monitoring event names are case
> +		insensitive in the perf tool, the perf tool only looks
> +		for lower or upper case event names in sysfs to avoid
> +		scanning the directory. It is therefore required the
> +		name of the event here is either lower or upper case.
> +

This is ambiguous to me. Is it clear to everyone else?

"for lower or upper case event names":

Is that a logical OR or an exclusive OR?
"AbC" contains lower case or upper case characters. :)

I think the code [static bool permitted_event_name()]
implements an exclusive OR.
The code also allows event names to contain numbers AFAICT.
The documentation doesn't mention this.

HTH.

>  		File contents:
>  
>  			<term>[=<value>][,<term>[=<value>]]...

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html
