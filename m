Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793272690;
	b=Tgi7VfBDSFBqqBcmA1g2uyobpEVOR2Ph0hu3nl6i12kUiGVYZLnbRqx5Ze+K8AyCFDXu
	 8nb8hbvJvhaDYlOTI+2hSMLVIJ0pkxjoQlULlhADNcc5KMcgTnwn/JcUIak0nJdbHGrYw
	 Eg8SJbUQcTTJp9lwQ9l2akbakfJW04/WPrK2rOkR4l2NsIQKsJWRpiUa8LRPgVOehNCVC
	 6De92YMpcTMODLFkQ4ljaGQx6wg5JN6MlC0U/7gjd0kvLxsiXm1XtjBTG60/8ZDXu/PqV
	 TDBKIq8nsmrxWeyCWPnUy6Fpf+gvkaxqwYUPMSyNHDxlGh2IeXC0tQkQN1B4bD6k4fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793272690;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:X-ClientProxiedBy;
	bh=CEW/fWCiUClFFtwtQpIhXXX6ntd+4T1TpmWHmmUsuZI=;
	b=hproxDvYRKBI2QItr+as6O8/pdpAo6iyumhtnCNomvuXu1ERuk+U7sOEMKw/C76cvLhn
	 vNzmcPUR6eDfhLPNYEN7yyMZsZtBYB9SQr5K5D9c7LB//S6xzEpnxcv1/bcpF2ZL6I63F
	 bllQAt35gGyyrcu5qQgVqgPtx4pBI1i1EcBE9yXOET3PX9p8h1SEWl8I4ZBfof/bR7Mug
	 an0T0AfMOqxqOf9XI/2mrzCfm5hFEhRM3WKG7TR/YF3xWCLz+EHje11eswOONCgKLSVNe
	 RhBT8ovhcHb9cFFRe2YoCRcF0a2RPMSfrPY7PiOZ1UohEmcrT1os8w4RignCJUihnoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2D3606A31A;
	Thu, 29 Oct 2026 11:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C2D3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jFhXn61Rfz171Yk;
	Thu, 29 Oct 2026 19:17:45 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jFhXl07wXz171Yk;
	Thu, 29 Oct 2026 19:17:43 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 081E930004DE;
	Thu, 29 Oct 2026 19:17:18 +0800 (CST)
Received: from hsj-2U-Workstation (172.19.24.226) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 29 Oct
 2026 19:17:39 +0800
Date: Thu, 29 Oct 2026 19:17:37 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <ravi.bangoria@amd.com>
CC: <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<james.clark@linaro.org>, <tglx@kernel.org>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuqi@hygon.cn>, <lijing@hygon.cn>, <wangfengyu@hygon.cn>,
	<wujianyong@hygon.cn>, <shijie8@gmail.com>, <1537577747@qq.com>,
	<huangsj@hygon.cn>
Subject: Re: [PATCH] perf/amd/ibs: add phy_addr_only software filter for
 ibs_op
Message-ID: <auMrUXp42Djz3zu9@hsj-2U-Workstation>
References: <20260902085251.4046240-1-huangsj@hygon.cn>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260902085251.4046240-1-huangsj@hygon.cn>
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

Hi Ravi,

> Can you please confirm if those additional samples are genuinely valid.

Yes.  
To answer this properly I re-ran the mysql test,
and verified the physical address of every captured sample against
the System RAM ranges in /proc/iomem.

Setup: 384-CPU Hygon box, v7.3-based kernel, MySQL 8 under sysbench
oltp_read_only, 400 threads.  Each round is a fresh 60s
sysbench run; after 15s of warmup, perf records ibs_op for 3s:

  $ perf record -e ibs_op/phy_addr_only=1/ -c 100000 --phys-data \
        -p <mysqld>                    # my patch
  $ perf record -e ibs_op// --phys-data --filter 'phys_addr != 0' \
        -c 100000 -p <mysqld>          # your suggestion

Rounds alternate p1 -> b1 -> p2 -> b2 -> p3 -> b3 so both methods see
the same load conditions.  Each record's phys_addr is then dumped with
"perf script -F pid,tid,phys_addr" and bisect-checked against the
System RAM ranges (read from /proc/iomem as root).

                     samples    phys_addr==0    non-zero in
    round  filter    captured   (valid=1,MSR=0)  System RAM
    -----  --------  ---------  ---------------  -----------
     p1    phy_only  15710042        0.10 %          98.61 %
     b1    bpf       14041851        0.00 %          98.55 %
     p2    phy_only  15580497        0.10 %          98.56 %
     b2    bpf       15416187        0.00 %          98.58 %
     p3    phy_only  15732582        0.10 %          98.59 %
     b3    bpf       15447397        0.00 %          98.58 %

Two observations:
1. The validity ratio is identical for both methods.  Of the non-zero
   addresses phy_addr_only delivers, 98.6 % fall inside System RAM --
   the same ratio the BPF-filtered set shows. 

2. The only set-level difference is 0.10 % of samples where
   dc_phy_addr_valid is set but IBSDCPHYSAD reads 0. 

Thanks,
Huang Shijie

