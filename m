Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290331CAAD
	for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716988027; cv=none; b=tWNo6LfL3D/1P3uxVUYFU2QtZm8JA+8+9saLlPLNCXwuHZcZqnCrqv9U8XW432CFlW6qzCbuQ/6JdStiCm4ptr6oXBCiW+SOVh9WqXvuDdJDNwDnAhV8XdkuS1XLf0vfkc6IJk9DMOeo1UwYu48xNnHGBzbC56vpT52vMDS8/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716988027; c=relaxed/simple;
	bh=FNXJyZG8fn4qpVQXoENcBUFrFu7ChC7dl8jobo/nZKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CNRbnOj0AEqkB2KsUhSTf1lnoTw6w8+lhAcKXVMha0E0q76adENivW6iP0t08qNP2qj2yNJEUS7e5SjZ9JrAwlkWwUwXAqCkWkUdcXN4JZMqHXU1KUZugIRsgvZaDeHyqEHanxPz0hRAp3e+TWAj/7D8WRfet5r/3MLaGBmzTvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1lUhJsE; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1lUhJsE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716988026; x=1748524026;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FNXJyZG8fn4qpVQXoENcBUFrFu7ChC7dl8jobo/nZKk=;
  b=H1lUhJsEWw5Xgbpclh9Le7Rk+PLuIPiEIw4ghMsLbg677NROHxttzK3H
   b7rmdFRqq2TJFnmQMtXDX+jUQzpczP/59QtFLptduOuUHpPbtWD/C1cLg
   9jmhI+d5Ot/9nOxjSy9P34TCXF3CRhPBzWytpbosPjRJwTfGGa78kdBAK
   RQZkbPQCmjNu8XhbeXT0ZUtsTpMzMg5iLb8soj1GjhR5MHQjwUKMfy0IO
   PC1Ky6HAR+oCF22sIZ6MLeaPfpoygaJ5UXqtsWV/HKL6e7/B/wewDLyW8
   GllURh+ID0Lhq9k+QV4r+Js6iAhOXd9ZrA4FLpFI8qsoyaLynH2yxr25N
   Q==;
X-CSE-ConnectionGUID: 7QG+iLQjQaSA/h+j5hMlzQ==
X-CSE-MsgGUID: IKZKhprlRS6FZu/xgVxyPg==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24520874"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="24520874"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 06:06:12 -0700
X-CSE-ConnectionGUID: X+2JucUgSjm8kOGMCf1kBw==
X-CSE-MsgGUID: NyarRdHSRGegxnANsU/bMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35496851"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 06:06:12 -0700
Received: from [10.212.55.153] (unknown [10.212.55.153])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id DF6762078A10;
	Wed, 29 May 2024 06:06:10 -0700 (PDT)
Message-ID: <4cc8c681-2ad6-4f38-8050-ad44fa592890@linux.intel.com>
Date: Wed, 29 May 2024 09:06:09 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Intel Sapphire Rapids uncore: umask too big
To: Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org
Cc: irogers@google.com, vmolnaro@redhat.com, edward.baker@intel.com,
 perry.taylor@intel.com, samantha.alt@intel.com, weilin.wang@intel.com,
 acme@kernel.org, alexander.shishkin@linux.intel.com
References: <alpine.LRH.2.20.2401300733310.11354@Diego>
 <alpine.LRH.2.20.2405281153210.4040@Diego>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <alpine.LRH.2.20.2405281153210.4040@Diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-05-29 6:34 a.m., Michael Petlan wrote:
> Hello.
> 
> Although something has changed so far, the discrepacy between event format
> accepted by the kernel ( /sys/devices/intel_cha*/format/* ) and what is
> in the JSONs still applies for Sapphire Lake.
> 
> This is found by running the "all PMU" test or a "perf_stat :: test_intel_uncore"
> from perftool-testsuite on a SPR box. The first seem to stop on first broken
> event, the second provides a full list of failed events.

The kernel patch seems has not been merged yet.
https://lore.kernel.org/lkml/20240416180145.2309913-1-kan.liang@linux.intel.com/

I'll ping it again.

Thanks,
Kan

> 
> Our testing shows that ~112 events are still broken:
> 
> unc_cha_tor_inserts.ia_hit_cxl_acc
> unc_cha_tor_inserts.ia_hit_cxl_acc_local
> unc_cha_tor_inserts.ia_miss_crdmorph_cxl_acc
> unc_cha_tor_inserts.ia_miss_cxl_acc
> unc_cha_tor_inserts.ia_miss_cxl_acc_local
> unc_cha_tor_inserts.ia_miss_drd_cxl_acc
> unc_cha_tor_inserts.ia_miss_drd_cxl_acc_local
> unc_cha_tor_inserts.ia_miss_drdmorph_cxl_acc
> unc_cha_tor_inserts.ia_miss_drd_opt_cxl_acc_local
> unc_cha_tor_inserts.ia_miss_drd_opt_pref_cxl_acc_local
> unc_cha_tor_inserts.ia_miss_drd_pref_cxl_acc
> unc_cha_tor_inserts.ia_miss_drd_pref_cxl_acc_local
> unc_cha_tor_inserts.ia_miss_llcprefcode_cxl_acc
> unc_cha_tor_inserts.ia_miss_llcprefdata_cxl_acc
> unc_cha_tor_inserts.ia_miss_llcprefdata_cxl_acc_local
> unc_cha_tor_inserts.ia_miss_llcprefrfo_cxl_acc
> unc_cha_tor_inserts.ia_miss_llcprefrfo_cxl_acc_local
> unc_cha_tor_inserts.ia_miss_rfo_cxl_acc
> unc_cha_tor_inserts.ia_miss_rfo_cxl_acc_local
> unc_cha_tor_inserts.ia_miss_rfomorph_cxl_acc
> unc_cha_tor_inserts.ia_miss_rfo_pref_cxl_acc
> unc_cha_tor_inserts.ia_miss_rfo_pref_cxl_acc_local
> unc_cha_tor_occupancy.ia_hit_cxl_acc
> unc_cha_tor_occupancy.ia_hit_cxl_acc_local
> unc_cha_tor_occupancy.ia_miss_crdmorph_cxl_acc
> unc_cha_tor_occupancy.ia_miss_cxl_acc
> unc_cha_tor_occupancy.ia_miss_cxl_acc_local
> unc_cha_tor_occupancy.ia_miss_drd_cxl_acc
> unc_cha_tor_occupancy.ia_miss_drd_cxl_acc_local
> unc_cha_tor_occupancy.ia_miss_drdmorph_cxl_acc
> unc_cha_tor_occupancy.ia_miss_drd_opt_cxl_acc_local
> unc_cha_tor_occupancy.ia_miss_drd_opt_pref_cxl_acc_local
> unc_cha_tor_occupancy.ia_miss_drd_pref_cxl_acc
> unc_cha_tor_occupancy.ia_miss_drd_pref_cxl_acc_local
> unc_cha_tor_occupancy.ia_miss_llcprefcode_cxl_acc
> unc_cha_tor_occupancy.ia_miss_llcprefdata_cxl_acc
> unc_cha_tor_occupancy.ia_miss_llcprefdata_cxl_acc_local
> unc_cha_tor_occupancy.ia_miss_llcprefrfo_cxl_acc
> unc_cha_tor_occupancy.ia_miss_llcprefrfo_cxl_acc_local
> unc_cha_tor_occupancy.ia_miss_rfo_cxl_acc
> unc_cha_tor_occupancy.ia_miss_rfo_cxl_acc_local
> unc_cha_tor_occupancy.ia_miss_rfomorph_cxl_acc
> unc_cha_tor_occupancy.ia_miss_rfo_pref_cxl_acc
> unc_cha_tor_occupancy.ia_miss_rfo_pref_cxl_acc_local
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
> Thanks.
> 
> Michael
> 
> On Tue, 30 Jan 2024, Michael Petlan wrote:
>> Hello Ian and others,
>>
>> we have encountered some issues with uncore events on Sapphire Rapids. There are
>> a couple types of problems. One of them is the following:
>>
>>     # perf stat -e uncore_cha_55/event=0x35,umask=0x10c0008101/ -a -- ls 
>>     event syntax error: '..0x35,umask=0x10c0008101/'
>>                                       \___ Bad event or PMU
>>     
>>     Unable to find PMU or event on a PMU of 'uncore_cha_55'
>>     
>>     Initial error:
>>     event syntax error: '..0x35,umask=0x10c0008101/'
>>                                       \___ value too big for format, maximum is 4294967295
>>     Run 'perf list' for a list of valid events
>>
>> There is a 34bit umask that can handle it, namely umask_ext2, but it is not
>> used for sapphire rapids:
>>
>> uncore_snbep.c:5958:static struct attribute *spr_uncore_cha_formats_attr[] = {
>> uncore_snbep.c-5959-    &format_attr_event.attr,
>> uncore_snbep.c-5960-    &format_attr_umask_ext4.attr,
>> uncore_snbep.c-5961-    &format_attr_tid_en2.attr,
>> uncore_snbep.c-5962-    &format_attr_edge.attr,
>> uncore_snbep.c-5963-    &format_attr_inv.attr,
>> uncore_snbep.c-5964-    &format_attr_thresh8.attr,
>> uncore_snbep.c-5965-    &format_attr_filter_tid5.attr,
>> uncore_snbep.c-5966-    NULL,
>> uncore_snbep.c-5967-};
>>
>> (I see umask_ext4 there and means 32bit:
>> uncore_snbep.c:479:DEFINE_UNCORE_FORMAT_ATTR(umask_ext4, umask, "config:8-15,32-55");
>> )
>>
>> What is wrong? The json files specifying umask=0x10c0008101 for the event,
>> or the structure that should rather support umask_ext2 ?
>>
>> There are a few more issues, I will update when analyzing them deeper.
>>
>> Thanks.
>> Michael
>>
>>
>>
> 
