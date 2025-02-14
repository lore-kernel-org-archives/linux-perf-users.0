Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A36263C6C
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Feb 2025 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739544444; cv=none; b=VObTnGOkKKBAJfa4Ead0j730T0kJoOVl2rOM5l7LGBhQND6oaLvwl+41OB6vGljRBGwGTsJfWOgPa74alLI5JMXn46dPYTybZJTTTJKjrm3vAS5mP+BcLhKfamsorB6i5aob+5360Jk2RLbHbZS+Cj1nEH/3Vn0rtNq+PGzGKK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739544444; c=relaxed/simple;
	bh=7HLTaF+BBkk+hEoEkrNF5fADmwQaFFWMKT5GcHFLncY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JR/Ewwsw8ereklpSR7Y3Qw0UgeX4SLVjxvCV/O9h5ZcskqR49ZuTIlh7xMKEx8Oge4VdTKfwE3g3sxseECVDx3rT3CmykjqYz/HxAMlxK/BqjJITWcELT0NoYB0suqybQk2VMeIipu4fVovdhI8TLnM2tMdMP1bKQqVaRDcroyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uk30BpeF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uk30BpeF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739544443; x=1771080443;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7HLTaF+BBkk+hEoEkrNF5fADmwQaFFWMKT5GcHFLncY=;
  b=Uk30BpeFVQx3vJ7S9PmkraGSpp25VxuPDVH2/iKEXYC3maPI7zBK6OTA
   QypPWNNaRzfhcR5+txQ2TxuJp9X7qfSbhX2PxnqgvrKlhNig3dbOKe4kM
   Jd9+FgkNs/JRcYbvFhhNeV7mfTlx7L0yFLLE4t1z6y3r1VWwPnOPLTDWa
   bisi619EOg8LiHLXA05Gt04Mw/pobS6hB050z9hbKbf6+0GCOXTKtbzug
   ogw3/krFdeFw4imCfSrD0YsNvAiIWV96vcZwjuhxZt8FAno0RddR0cSaf
   ZVPW8lE/QCDaubqeaz95klt3OmFrrvvbnzCPyfMvR7S2thxsGEvK981P/
   A==;
X-CSE-ConnectionGUID: LZavOmrjQ7mJ4++s0U0Zjg==
X-CSE-MsgGUID: Rk1vhtU6S/C/m91ocKEB3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="50939713"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="50939713"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 06:47:23 -0800
X-CSE-ConnectionGUID: kYfTIFJCR0KenRryvqv/qg==
X-CSE-MsgGUID: cDijfOPxSWSBBZMR9vqxUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117601153"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 06:47:22 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id F030320B5713;
	Fri, 14 Feb 2025 06:47:20 -0800 (PST)
Message-ID: <c481b5a2-6d1d-4c27-a32a-df131712a1a0@linux.intel.com>
Date: Fri, 14 Feb 2025 09:47:19 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Broken intel uncore events on SPR
To: Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org
Cc: irogers@google.com, weilin.wang@intel.com, caleb.biggers@intel.com,
 namhyung@kernel.org, acme@kernel.org, darcari@redhat.com
References: <a2372e44-19fc-7eb4-c24b-1a568c742546@redhat.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <a2372e44-19fc-7eb4-c24b-1a568c742546@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-02-14 7:39 a.m., Michael Petlan wrote:
> Hello all,
> 
> our testing shows that some uncore events are broken on Intel Sapphire
> Rapids (family 6, model 143). I have tested v6.14-rc2 and the results
> are the same as with v6.12.
> 
> The full list of events that don't work is at the end of this mail.
> 
> The reason is that their umasks are too big in the JSON definitions, e.g.:
> 
>   {
>     "BriefDescription": "PCIe Completion Buffer Inserts of completions with data: Part 0",
>     "Counter": "0,1,2,3",
>     "EventCode": "0xc2",
>     "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART0",
>     "Experimental": "1",
>     "FCMask": "0x07",
>     "PerPkg": "1",
>     "PortMask": "0x0001",
>     "PublicDescription": "PCIe Completion Buffer Inserts of completions with data : Part 0 : x16 card plugged in to Lane 0/1/2/3, Or x8 card plugged in to Lane 0/1, Or x4 card is plugged in to slot 0",
>     "UMask": "0x7001004",
>     "Unit": "IIO"
>   },
> 

The issue should have been fixed with the latest update.
https://lore.kernel.org/lkml/20250211213031.114209-20-irogers@google.com/

It should be available in the perf-tools-next branch.

    {
        "BriefDescription": "PCIe Completion Buffer Inserts of
completions with data: Part 0",
        "Counter": "0,1,2,3",
        "EventCode": "0xc2",
        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART0",
        "Experimental": "1",
        "FCMask": "0x07",
        "PerPkg": "1",
        "PortMask": "0x0001",
        "PublicDescription": "PCIe Completion Buffer Inserts of
completions with data : Part 0 : x16 card plugged in to Lane 0/1/2/3, Or
x8 card plugged in to Lane 0/1, Or x4 card is plugged in to slot 0",
        "UMask": "0x4",
        "Unit": "IIO"
    },

Thanks,
Kan

> $ cat /sys/devices/uncore_iio_*/format/umask | sort -u
> config:8-15
> 
> Who is wrong? The JSON or sysfs?
> 
> Thanks!
> Michael
> 
> 
> 
> 
> 
> Broken events:
> ==============
> unc_iio_comp_buf_inserts.cmpd.part0
> unc_iio_comp_buf_inserts.cmpd.part1
> unc_iio_comp_buf_inserts.cmpd.part2
> unc_iio_comp_buf_inserts.cmpd.part3
> unc_iio_comp_buf_inserts.cmpd.part4
> unc_iio_comp_buf_inserts.cmpd.part5
> unc_iio_comp_buf_inserts.cmpd.part6
> unc_iio_comp_buf_inserts.cmpd.part7
> unc_iio_comp_buf_occupancy.cmpd.part0
> unc_iio_comp_buf_occupancy.cmpd.part1
> unc_iio_comp_buf_occupancy.cmpd.part2
> unc_iio_comp_buf_occupancy.cmpd.part3
> unc_iio_comp_buf_occupancy.cmpd.part4
> unc_iio_comp_buf_occupancy.cmpd.part5
> unc_iio_comp_buf_occupancy.cmpd.part6
> unc_iio_comp_buf_occupancy.cmpd.part7
> unc_iio_data_req_by_cpu.mem_read.part0
> unc_iio_data_req_by_cpu.mem_read.part1
> unc_iio_data_req_by_cpu.mem_read.part2
> unc_iio_data_req_by_cpu.mem_read.part3
> unc_iio_data_req_by_cpu.mem_read.part4
> unc_iio_data_req_by_cpu.mem_read.part5
> unc_iio_data_req_by_cpu.mem_read.part6
> unc_iio_data_req_by_cpu.mem_read.part7
> unc_iio_data_req_by_cpu.peer_read.part0
> unc_iio_data_req_by_cpu.peer_read.part1
> unc_iio_data_req_by_cpu.peer_read.part2
> unc_iio_data_req_by_cpu.peer_read.part3
> unc_iio_data_req_by_cpu.peer_read.part4
> unc_iio_data_req_by_cpu.peer_read.part5
> unc_iio_data_req_by_cpu.peer_read.part6
> unc_iio_data_req_by_cpu.peer_read.part7
> unc_iio_data_req_by_cpu.peer_write.part0
> unc_iio_data_req_by_cpu.peer_write.part1
> unc_iio_data_req_by_cpu.peer_write.part2
> unc_iio_data_req_by_cpu.peer_write.part3
> unc_iio_data_req_by_cpu.peer_write.part4
> unc_iio_data_req_by_cpu.peer_write.part5
> unc_iio_data_req_by_cpu.peer_write.part6
> unc_iio_data_req_by_cpu.peer_write.part7
> unc_iio_inbound_arb_req.data
> unc_iio_inbound_arb_req.req_own
> unc_iio_inbound_arb_req.wr
> unc_iio_inbound_arb_won.data
> unc_iio_inbound_arb_won.final_rd_wr
> unc_iio_inbound_arb_won.iommu_hit
> unc_iio_inbound_arb_won.iommu_req
> unc_iio_inbound_arb_won.req_own
> unc_iio_inbound_arb_won.wr
> unc_iio_req_from_pcie_cl_cmpl.data
> unc_iio_req_from_pcie_cl_cmpl.final_rd_wr
> unc_iio_req_from_pcie_cl_cmpl.req_own
> unc_iio_req_from_pcie_cl_cmpl.wr
> unc_iio_req_from_pcie_cmpl.final_rd_wr
> unc_iio_req_from_pcie_cmpl.iommu_hit
> unc_iio_req_from_pcie_cmpl.iommu_req
> unc_iio_req_from_pcie_cmpl.req_own
> unc_iio_req_from_pcie_pass_cmpl.data
> unc_iio_req_from_pcie_pass_cmpl.req_own
> unc_iio_req_from_pcie_pass_cmpl.wr
> unc_iio_txn_req_by_cpu.peer_write.part0
> unc_iio_txn_req_by_cpu.peer_write.part1
> unc_iio_txn_req_by_cpu.peer_write.part2
> unc_iio_txn_req_by_cpu.peer_write.part3
> unc_iio_txn_req_by_cpu.peer_write.part4
> unc_iio_txn_req_by_cpu.peer_write.part5
> unc_iio_txn_req_by_cpu.peer_write.part6
> unc_iio_txn_req_by_cpu.peer_write.part7
> 
> 

