Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8952E1749;
	Thu, 13 Nov 2025 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073213; cv=none; b=fhUfQkWtlPJIwn6yplRLHOAdq/GBP9XwqQRFo5WvizVAg+ss/L/9oZct0XLMlOY9+WpyU9olr7RHLPH4Lg7Qki33yy9JqMozfoW/eDecHEBC36gEZawu4zM6beYxA0PcrcM9U65dz+Y4MzkG0lDSI+okxUuLKE3pTAxW4pACj3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073213; c=relaxed/simple;
	bh=UgTP40gdgm/2g7rUs8/SmLHmEbjBMjU/gtVigiNafN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRsiBsnM021uT40TjwrM1WTDCRPDFCVS+6S1cjTZKu/6R5f7HUpVpXi0kK4S06zZvduM3Tisfkp8c12oG9daihjPpfzA+IY0ZLDfYhWVsLaat2MjLl4TTzQ55d9UsI765AmlKF/fJc9krHGZK/AYC3ySyV8rPZS2FxGQtv2aVRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=binPp88N; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="binPp88N"
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADJBb5B024101;
	Thu, 13 Nov 2025 22:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=bcJQQ1KPTwb8eK8XW7TwGgVXE4
	0jB/JkLsdDLKCcbPI=; b=binPp88NyMn03e/bkmtHSrcjiFLWsHMxcUO6nOtZu6
	Q3hRxUUXL/r4hHJxxWSO8UQUY72LOs/Zr2g5YYerXE3Zu6zbNHYKblURY8LV6tHy
	4CoI9IiKb9rvi69Am/pWmOEGd5O7AYr1wmgeF19cdNypM2d+rTYuYCI08HtRkCXi
	NXYr2WsQ6S/ZWIFSiKOdgv31He+OO03Z4nwnJT310XdpdjcHU9BFh5AQEWZ5xIgR
	BgLWjliqDaf0iGuMrT/9TC5KNG5+WtA2ylWEk4KNi56ybXGqAkKcimjVxPFrZL5K
	FTk1zsgcW21EhiMtcuY2ZwNtLldYBMAv2Jhxu/kMwTlg==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4adetdpb71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 22:32:46 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 38522805653;
	Thu, 13 Nov 2025 22:32:45 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 38046800E9A;
	Thu, 13 Nov 2025 22:32:42 +0000 (UTC)
Date: Thu, 13 Nov 2025 16:32:39 -0600
From: Steve Wahl <steve.wahl@hpe.com>
To: Zide Chen <zide.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Xudong Hao <xudong.hao@intel.com>,
        Falcon Thomas <thomas.falcon@intel.com>,
        Steve Wahl <steve.wahl@hpe.com>
Subject: Re: [PATCH 1/2] perf/x86/intel/uncore: Skip discovery table for
 offline dies
Message-ID: <aRZch3BMB-kCPDdh@swahl-home.5wahls.com>
References: <20251029220711.57909-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029220711.57909-1-zide.chen@intel.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA4NiBTYWx0ZWRfXwcXFjhwEH9xa
 jukJj5ROSsaxrRYAm1+zPMeNzzQtnnfdD6EmHRO4VxEvdzI3pTbM/VnGob/bnIXQdBJDSWcJGDg
 KEX1zBu8+f1nxidGOTUvnUFEhYwIOypsy48QhgSnaUgaX4nDa5ty1MPas6AUE4s7bkbD39wtCM7
 5uGWbYKHHOEhtqQJpSs/osafNgzsjertUhu0hi18upq+8L8V3Q6g9IIol/KDC7d/Y3Sh9mU36cy
 sR32EB54jyWmtWE8eujdqJvuUv7+2vftHL3oCbzZ7//Rj+BtAzOLrtb8WY6pWKEOUnTqEEJKmIw
 +AUSTd/VKcRXBY++080uWDFD9/XBYEKs2mAsL6x2my00udeqTjprPJcopZqd1Jf/7jYDA7JP8OI
 5wmtvpINTiCYeGFTIuepP0CVS9X2tA==
X-Proofpoint-GUID: rnJH_0BToN6XgUb0zRTtXEt8uYI9Q1PR
X-Authority-Analysis: v=2.4 cv=c++mgB9l c=1 sm=1 tr=0 ts=69165c8e cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=MvuuwTCpAAAA:8 a=QyXUC8HyAAAA:8 a=2NGp21swkA0pWk24jV0A:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: rnJH_0BToN6XgUb0zRTtXEt8uYI9Q1PR
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511130086

Tested-by: Steve Wahl <steve.wahl@hpe.com>

On Wed, Oct 29, 2025 at 03:07:10PM -0700, Zide Chen wrote:
> This warning can be triggered if NUMA is disabled and the system
> boots with fewer CPUs than the number of CPUs in die 0.
> 
> WARNING: CPU: 9 PID: 7257 at uncore.c:1157 uncore_pci_pmu_register+0x136/0x160 [intel_uncore]
> 
> Currently, the discovery table continues to be parsed even if all CPUs
> in the associated die are offline. This can lead to an array overflow
> at "pmu->boxes[die] = box" in uncore_pci_pmu_register(), which may
> trigger the warning above or cause other issues.
> 
> Reported-by: Steve Wahl <steve.wahl@hpe.com>
> Fixes: edae1f06c2cd ("perf/x86/intel/uncore: Parse uncore discovery tables")
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore.c           | 4 ++++
>  arch/x86/events/intel/uncore_discovery.c | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index ee586eb714ec..5c3aeea5c78d 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1380,6 +1380,10 @@ static void uncore_pci_pmus_register(void)
>  
>  		for (node = rb_first(type->boxes); node; node = rb_next(node)) {
>  			unit = rb_entry(node, struct intel_uncore_discovery_unit, node);
> +
> +			if (WARN_ON(unit->die >= uncore_max_dies()))
> +				continue;
> +
>  			pdev = pci_get_domain_bus_and_slot(UNCORE_DISCOVERY_PCI_DOMAIN(unit->addr),
>  							   UNCORE_DISCOVERY_PCI_BUS(unit->addr),
>  							   UNCORE_DISCOVERY_PCI_DEVFN(unit->addr));
> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
> index 1bf6e4288577..d6aee12139f1 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
> @@ -388,7 +388,7 @@ static bool intel_uncore_has_discovery_tables_pci(int *ignore)
>  				     (val & UNCORE_DISCOVERY_DVSEC2_BIR_MASK) * UNCORE_DISCOVERY_BIR_STEP;
>  
>  			die = get_device_die_id(dev);
> -			if (die < 0)
> +			if ((die < 0) || (die >= uncore_max_dies()))
>  				continue;
>  
>  			parse_discovery_table(dev, die, bar_offset, &parsed, ignore);
> -- 
> 2.51.1
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
