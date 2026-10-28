Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793173974;
	b=uKkgBwiH8iH56grdyZoJY/DTJ5s1pc9R4TjeESeKEJ3Vq08TrdvbPNAkyLmkV507VHc5
	 hYhEtowkYGGJ4cxyGDXhnLvsvoKJvhH4xK/J8c+Gd++bFdPfsezOrAoVc4OF5CZGvSs3s
	 fgkZgoJoxMDVwKXGcR+NWgGSs6atQ1rIJbI3ymmMSugQdpEu7AAeF0Bjz+D2yzdnW/cGV
	 9XBsj6OpbKEJkZxuIygVdEoq1f/j7rVSAflHwkmXZzfuoAidf93rBt1mj/5FgjHYvydNQ
	 7kmyDgWKjslCA6ZRCLgRN0U40wE6biDsrjuOYMxB7Ax/irogYoKoQoDP5iV1JmAUQEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793173974;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:X-ClientProxiedBy;
	bh=Hf1CMufnAT672qe7Eu73z3TtfaYwqEFksJs75MflBj0=;
	b=t9XoCztMfH/LDgcW0JSlIE7qGTScBTPvq4DDUyz6g/fWY1+2digX+rhwAb49cRkWcW7f
	 7lUgGaH8yCPJyqXEfAFgGQgI6MlvXBhSHviJGHQmTYsfeQw+XH+c82uNIrzn0s75BTUcS
	 1iXQK1stLoCKHfE6YKtJrhnpZgQkl1er/jsM6mBcCaYzU5LlQz1waGUfJWQoS44THWj4T
	 TIZ2DUJOqwXHSQUcRyWI57EHwSTLZ7xTtj4cbELdHNn+/4olNISvewCOpb3hj921o+rWm
	 8my4Pc0ul3GSowtOCMudYzU4+iaEJh2pZy3WLCsnY6AjEelDwSF8utP5BKleEpuzbnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3739B606A31A;
	Wed, 28 Oct 2026 07:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3739B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jF02P6wZhz4tvGJ;
	Wed, 28 Oct 2026 15:52:29 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jF02M35Fsz4wJL8;
	Wed, 28 Oct 2026 15:52:27 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id B724816DF;
	Wed, 28 Oct 2026 15:52:21 +0800 (CST)
Received: from hsj-2U-Workstation (172.19.24.226) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 28 Oct
 2026 15:52:25 +0800
Date: Wed, 28 Oct 2026 15:52:23 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>
CC: <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<james.clark@linaro.org>, <tglx@kernel.org>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuqi@hygon.cn>, <lijing@hygon.cn>, <wangfengyu@hygon.cn>,
	<wujiangyong@hygon.cn>, <shijie8@gmail.com>, <1537577747@qq.com>
Subject: Re: [PATCH] perf/amd/ibs: add phy_addr_only software filter for
 ibs_op
Message-ID: <auGpt6wenUj5mFP8@hsj-2U-Workstation>
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
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

Hi Ravi,

Thanks for taking a look.

> Why not simply use the BPF filter?
>   $ perf record -e ibs_op// --phys-data --filter 'phys_addr != 0' ...

I did try the BPF filter.

Measurements below are system-wide ibs_op sampling for 5s on a
384-CPU Hygon box under a 400-thread sysbench oltp_read_only load
at three sampling periods:

    -c     filter        valid samples    
  ------  ------------  ---------- 
  100000  phy_addr_only  19,345,907 
  100000  BPF filter     17,939,819 

   30000  phy_addr_only  54,670,617 
   30000  BPF filter     47,926,784 

   10000  phy_addr_only  61,606,488 
   10000  BPF filter     40,826,086 


The phy_addr_only produces more *valid* samples than the BPF filter.

Thanks,
Huang Shijie

