Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47822E03FE;
	Thu, 13 Nov 2025 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073232; cv=none; b=LRTqp9Ppp/tJL33e7UcUsaBRb1R1p5zl5kBw8T38Sy1YyUASF6tzoB4UhiMjE7iqn5fyhGf7tXvgjDRm1s++I/GJdliEpmKbLponnzrAudEXTzGaopw7KZGj2pti8bbjlI6YpxAyp6bUDYOXaey03L77BLid6NHLTjGYN/9JDz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073232; c=relaxed/simple;
	bh=5JsTPklb3AAH8tOASrVVckiF5ZWc2DNojagUppLWGPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYYL1Vhqly0DnmjtldGLRoI3OO1VgoIecvS3kLVwuVgOcUudHx6bfCWbev9wwCsMw/ySJ1NiYzl78Hg1xXAmMIod3P+NoVgoSV9Qh6ArD0K3QtnJiOWfYYgRSbCNqJSi8Y9B318yoROcJZsdXLR4f9rXP8CG2pdfLW0fUh0PNYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=SolBzfJX; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="SolBzfJX"
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADEwD8L005276;
	Thu, 13 Nov 2025 22:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=32nQ0TzcXPNhMoRh8dvAMphhNj
	FxwxasLvkwdB+bQvU=; b=SolBzfJXHsuZYpGphXfUyVCPZGJEih5uYE6deKasPr
	MNrZtr1N/BdVffPNcsVZ78E3hKRuzUuFKerNNouy8sj2V+opBqqcA2F7dDPKoeR3
	uAIrnK3jtFGzu5z7bfBT+f8/gSGNo38zECy2c5VC1LgZhbCVqQKvFSGf8l65LVF/
	4V/nn1iyVyShqHDqDEufFTL0QiivjYFg7ysSS1LH+DJR3mDSWxhhgtDPA51oeiXX
	CpU27Nfc2sJ8Gg1vEuoEnr6Wq0de/93AbIc8LmAQTH+Qo+Kbny6zx0GIV48o0hIi
	KNK2ReLw8NPz7YvJmZx/KENAO+oYwtwqSccdkwyRJMUg==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4adhjacuje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 22:33:17 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 691C88005F6;
	Thu, 13 Nov 2025 22:33:16 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 266C9803527;
	Thu, 13 Nov 2025 22:33:12 +0000 (UTC)
Date: Thu, 13 Nov 2025 16:33:10 -0600
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
Subject: Re: [PATCH 2/2] perf/x86/intel/uncore: Fix die ID init and look up
 bugs
Message-ID: <aRZcpjyBu4ah-3Li@swahl-home.5wahls.com>
References: <20251029220711.57909-1-zide.chen@intel.com>
 <20251029220711.57909-2-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029220711.57909-2-zide.chen@intel.com>
X-Proofpoint-GUID: weS5dy3MDDD56ZEXVZ-B-QrD3F1O3x1N
X-Proofpoint-ORIG-GUID: weS5dy3MDDD56ZEXVZ-B-QrD3F1O3x1N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDExNSBTYWx0ZWRfXwdWZcGnr/g3Q
 aCOEH8XhRUaFbB0ZkQ53bWU5xqQYuPWZvibjm4bQmFQoYEgUbmNJUO6bDMD4EWntZEDRVNm3NDX
 Z0en3U8WK+fE37QrX5Y3TEUYilRUVuTitrpykpjfJIh/xOkBJqxW/Axl1utf4zck13IXGGAYod7
 QTLr1gHklJTZxNZ8QsPdDjDYX8gcyFjb6TrSXA+2apaAELfe7avPTNS8LbTEl2s3sx8PGL9AA1G
 hF2SUSfPaTV+44YLfyn3eHAwm4PeGAUCHeeq9Wg79neZbaJO4fM6rKyj+6H9i8iG2fI1280oMt0
 UoBZSKYBJg4Ad9g2TO9lfL59tLao8/gd2yx3C2zXy/Am6U4odTmyJk1VGBu6ovqHBIs+TJPpVpM
 Od+2/dh1X+4PYUw6sgux3rTSpjIIkg==
X-Authority-Analysis: v=2.4 cv=D7BK6/Rj c=1 sm=1 tr=0 ts=69165cad cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=MvuuwTCpAAAA:8 a=QyXUC8HyAAAA:8 a=aOeS5Nrn9sgnvQA8YMUA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511130115

Tested-by: Steve Wahl <steve.wahl@hpe.com>

On Wed, Oct 29, 2025 at 03:07:11PM -0700, Zide Chen wrote:
> In snbep_pci2phy_map_init(), if there are more than 8 nodes,
> uncore_device_to_die(ubox_dev) may return -1 if all CPUs
> associated with the UBOX device are offline.  This is not an error
> and we still need to populate map->pbus_to_dieid[].
> 
> If NUMA is disabled on a NUMA-capable platform, pcibus_to_node()
> returns NUMA_NO_NODE and uncore_device_to_die() returns -1.  As a
> result, in spr_update_device_location(), which is used on Intel SPR,
> GNR etc., the PMON units are ignored and not added to the RB tree.
> 
> Use uncore_pcibus_to_dieid() instead, which retrieves topology
> information from the GIDNIDMAP register of the UBOX device.
> 
> Fixes: 9a7832ce3d92 ("perf/x86/intel/uncore: With > 8 nodes, get pci bus die id from NUMA info")
> Fixes: 65248a9a9ee1 ("perf/x86/uncore: Add a quirk for UPI on SPR")
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore.c       |  1 +
>  arch/x86/events/intel/uncore_snbep.c | 13 ++++++-------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 5c3aeea5c78d..84d6e481f18f 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -77,6 +77,7 @@ int uncore_die_to_segment(int die)
>  	return bus ? pci_domain_nr(bus) : -EINVAL;
>  }
>  
> +/* Note: This API can only be used when NUMA information is available. */
>  int uncore_device_to_die(struct pci_dev *dev)
>  {
>  	int node = pcibus_to_node(dev->bus);
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index ad4d11762ecf..e68467f617f9 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -1471,13 +1471,7 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
>  			}
>  
>  			map->pbus_to_dieid[bus] = die_id = uncore_device_to_die(ubox_dev);
> -
>  			raw_spin_unlock(&pci2phy_map_lock);
> -
> -			if (WARN_ON_ONCE(die_id == -1)) {
> -				err = -EINVAL;
> -				break;
> -			}
>  		}
>  	}
>  
> @@ -6530,7 +6524,7 @@ static void spr_update_device_location(int type_id)
>  
>  	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, dev)) != NULL) {
>  
> -		die = uncore_device_to_die(dev);
> +		die = uncore_pcibus_to_dieid(dev->bus);
>  		if (die < 0)
>  			continue;
>  
> @@ -6554,6 +6548,11 @@ static void spr_update_device_location(int type_id)
>  
>  int spr_uncore_pci_init(void)
>  {
> +	int ret = snbep_pci2phy_map_init(0x3250, SKX_CPUNODEID, SKX_GIDNIDMAP, true);
> +
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * The discovery table of UPI on some SPR variant is broken,
>  	 * which impacts the detection of both UPI and M3UPI uncore PMON.
> -- 
> 2.51.1
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
