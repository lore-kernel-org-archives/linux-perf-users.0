Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DDE73475
	for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716978879; cv=none; b=cFTkSHho4x0wJhftVv7Mwbsv8eJOoQfXcktvcXjixiq5aBAa7VJXc1YAXsifD838pcnR123y7h9VIrtovMkS8N5IbO5wP+/FGWxBxyNXTMkAem9tnL3IfPA4PyIyGhqTQQb/F1ogqAk4cb+ThMGagjRfy3PsRn+R5p0VGt+ZPlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716978879; c=relaxed/simple;
	bh=CRf3WH8NFXEodVKW3eb9Aby6CgFjditW7xTHngQWsJo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bvkVQ/rqwJlGrkrAGO3G7ESuYhXDXLJ7xgh4UfSRieqmvIdf/7As24yFH5Srr8hp9qo0KTU9lXKuPnZT+s16Yn4q6uUNLyQLfe8DRlTPH3ixQPzbEkJrJFf+qSalpfEwd3w3Ajf1TK7FEoNkSVyOhrWi1rcunQfvbm+LrBAaO1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBEGR1MC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBEGR1MC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716978876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q6dAYKs0AUyrOIUojhIcLoB9DeGHob/0VFcI/lv7I8Y=;
	b=gBEGR1MCnZZ5YB445IJFFxVtjpyvnjColRnrOL1+ev7mbgDu8zVtGokSenDmgeVmbg9x3G
	JxvZlE5vOSZwPBctvZe5iN7tyi3pf/8mVfSnIZpR+KvjYNW53Gf7LAbY/vquDjfqEmswkE
	1GbwgRgCTR0248zNv2JAQ7oQopqbQ4A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-_8dZA1ZHMeWA6lSjXsunBQ-1; Wed,
 29 May 2024 06:34:31 -0400
X-MC-Unique: _8dZA1ZHMeWA6lSjXsunBQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF4D63806701;
	Wed, 29 May 2024 10:34:30 +0000 (UTC)
Received: from Diego (unknown [10.39.208.29])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F20702026D68;
	Wed, 29 May 2024 10:34:27 +0000 (UTC)
Date: Wed, 29 May 2024 12:34:26 +0200 (CEST)
From: Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To: linux-perf-users@vger.kernel.org
cc: irogers@google.com, vmolnaro@redhat.com, edward.baker@intel.com, 
    perry.taylor@intel.com, samantha.alt@intel.com, weilin.wang@intel.com, 
    acme@kernel.org, alexander.shishkin@linux.intel.com, 
    kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com
Subject: Re: Intel Sapphire Rapids uncore: umask too big
In-Reply-To: <alpine.LRH.2.20.2401300733310.11354@Diego>
Message-ID: <alpine.LRH.2.20.2405281153210.4040@Diego>
References: <alpine.LRH.2.20.2401300733310.11354@Diego>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hello.

Although something has changed so far, the discrepacy between event format
accepted by the kernel ( /sys/devices/intel_cha*/format/* ) and what is
in the JSONs still applies for Sapphire Lake.

This is found by running the "all PMU" test or a "perf_stat :: test_intel_uncore"
from perftool-testsuite on a SPR box. The first seem to stop on first broken
event, the second provides a full list of failed events.

Our testing shows that ~112 events are still broken:

unc_cha_tor_inserts.ia_hit_cxl_acc
unc_cha_tor_inserts.ia_hit_cxl_acc_local
unc_cha_tor_inserts.ia_miss_crdmorph_cxl_acc
unc_cha_tor_inserts.ia_miss_cxl_acc
unc_cha_tor_inserts.ia_miss_cxl_acc_local
unc_cha_tor_inserts.ia_miss_drd_cxl_acc
unc_cha_tor_inserts.ia_miss_drd_cxl_acc_local
unc_cha_tor_inserts.ia_miss_drdmorph_cxl_acc
unc_cha_tor_inserts.ia_miss_drd_opt_cxl_acc_local
unc_cha_tor_inserts.ia_miss_drd_opt_pref_cxl_acc_local
unc_cha_tor_inserts.ia_miss_drd_pref_cxl_acc
unc_cha_tor_inserts.ia_miss_drd_pref_cxl_acc_local
unc_cha_tor_inserts.ia_miss_llcprefcode_cxl_acc
unc_cha_tor_inserts.ia_miss_llcprefdata_cxl_acc
unc_cha_tor_inserts.ia_miss_llcprefdata_cxl_acc_local
unc_cha_tor_inserts.ia_miss_llcprefrfo_cxl_acc
unc_cha_tor_inserts.ia_miss_llcprefrfo_cxl_acc_local
unc_cha_tor_inserts.ia_miss_rfo_cxl_acc
unc_cha_tor_inserts.ia_miss_rfo_cxl_acc_local
unc_cha_tor_inserts.ia_miss_rfomorph_cxl_acc
unc_cha_tor_inserts.ia_miss_rfo_pref_cxl_acc
unc_cha_tor_inserts.ia_miss_rfo_pref_cxl_acc_local
unc_cha_tor_occupancy.ia_hit_cxl_acc
unc_cha_tor_occupancy.ia_hit_cxl_acc_local
unc_cha_tor_occupancy.ia_miss_crdmorph_cxl_acc
unc_cha_tor_occupancy.ia_miss_cxl_acc
unc_cha_tor_occupancy.ia_miss_cxl_acc_local
unc_cha_tor_occupancy.ia_miss_drd_cxl_acc
unc_cha_tor_occupancy.ia_miss_drd_cxl_acc_local
unc_cha_tor_occupancy.ia_miss_drdmorph_cxl_acc
unc_cha_tor_occupancy.ia_miss_drd_opt_cxl_acc_local
unc_cha_tor_occupancy.ia_miss_drd_opt_pref_cxl_acc_local
unc_cha_tor_occupancy.ia_miss_drd_pref_cxl_acc
unc_cha_tor_occupancy.ia_miss_drd_pref_cxl_acc_local
unc_cha_tor_occupancy.ia_miss_llcprefcode_cxl_acc
unc_cha_tor_occupancy.ia_miss_llcprefdata_cxl_acc
unc_cha_tor_occupancy.ia_miss_llcprefdata_cxl_acc_local
unc_cha_tor_occupancy.ia_miss_llcprefrfo_cxl_acc
unc_cha_tor_occupancy.ia_miss_llcprefrfo_cxl_acc_local
unc_cha_tor_occupancy.ia_miss_rfo_cxl_acc
unc_cha_tor_occupancy.ia_miss_rfo_cxl_acc_local
unc_cha_tor_occupancy.ia_miss_rfomorph_cxl_acc
unc_cha_tor_occupancy.ia_miss_rfo_pref_cxl_acc
unc_cha_tor_occupancy.ia_miss_rfo_pref_cxl_acc_local
unc_iio_comp_buf_inserts.cmpd.part0
unc_iio_comp_buf_inserts.cmpd.part1
unc_iio_comp_buf_inserts.cmpd.part2
unc_iio_comp_buf_inserts.cmpd.part3
unc_iio_comp_buf_inserts.cmpd.part4
unc_iio_comp_buf_inserts.cmpd.part5
unc_iio_comp_buf_inserts.cmpd.part6
unc_iio_comp_buf_inserts.cmpd.part7
unc_iio_comp_buf_occupancy.cmpd.part0
unc_iio_comp_buf_occupancy.cmpd.part1
unc_iio_comp_buf_occupancy.cmpd.part2
unc_iio_comp_buf_occupancy.cmpd.part3
unc_iio_comp_buf_occupancy.cmpd.part4
unc_iio_comp_buf_occupancy.cmpd.part5
unc_iio_comp_buf_occupancy.cmpd.part6
unc_iio_comp_buf_occupancy.cmpd.part7
unc_iio_data_req_by_cpu.mem_read.part0
unc_iio_data_req_by_cpu.mem_read.part1
unc_iio_data_req_by_cpu.mem_read.part2
unc_iio_data_req_by_cpu.mem_read.part3
unc_iio_data_req_by_cpu.mem_read.part4
unc_iio_data_req_by_cpu.mem_read.part5
unc_iio_data_req_by_cpu.mem_read.part6
unc_iio_data_req_by_cpu.mem_read.part7
unc_iio_data_req_by_cpu.peer_read.part0
unc_iio_data_req_by_cpu.peer_read.part1
unc_iio_data_req_by_cpu.peer_read.part2
unc_iio_data_req_by_cpu.peer_read.part3
unc_iio_data_req_by_cpu.peer_read.part4
unc_iio_data_req_by_cpu.peer_read.part5
unc_iio_data_req_by_cpu.peer_read.part6
unc_iio_data_req_by_cpu.peer_read.part7
unc_iio_data_req_by_cpu.peer_write.part0
unc_iio_data_req_by_cpu.peer_write.part1
unc_iio_data_req_by_cpu.peer_write.part2
unc_iio_data_req_by_cpu.peer_write.part3
unc_iio_data_req_by_cpu.peer_write.part4
unc_iio_data_req_by_cpu.peer_write.part5
unc_iio_data_req_by_cpu.peer_write.part6
unc_iio_data_req_by_cpu.peer_write.part7
unc_iio_inbound_arb_req.data
unc_iio_inbound_arb_req.req_own
unc_iio_inbound_arb_req.wr
unc_iio_inbound_arb_won.data
unc_iio_inbound_arb_won.final_rd_wr
unc_iio_inbound_arb_won.iommu_hit
unc_iio_inbound_arb_won.iommu_req
unc_iio_inbound_arb_won.req_own
unc_iio_inbound_arb_won.wr
unc_iio_req_from_pcie_cl_cmpl.data
unc_iio_req_from_pcie_cl_cmpl.final_rd_wr
unc_iio_req_from_pcie_cl_cmpl.req_own
unc_iio_req_from_pcie_cl_cmpl.wr
unc_iio_req_from_pcie_cmpl.final_rd_wr
unc_iio_req_from_pcie_cmpl.iommu_hit
unc_iio_req_from_pcie_cmpl.iommu_req
unc_iio_req_from_pcie_cmpl.req_own
unc_iio_req_from_pcie_pass_cmpl.data
unc_iio_req_from_pcie_pass_cmpl.req_own
unc_iio_req_from_pcie_pass_cmpl.wr
unc_iio_txn_req_by_cpu.peer_write.part0
unc_iio_txn_req_by_cpu.peer_write.part1
unc_iio_txn_req_by_cpu.peer_write.part2
unc_iio_txn_req_by_cpu.peer_write.part3
unc_iio_txn_req_by_cpu.peer_write.part4
unc_iio_txn_req_by_cpu.peer_write.part5
unc_iio_txn_req_by_cpu.peer_write.part6
unc_iio_txn_req_by_cpu.peer_write.part7

Thanks.

Michael

On Tue, 30 Jan 2024, Michael Petlan wrote:
> Hello Ian and others,
> 
> we have encountered some issues with uncore events on Sapphire Rapids. There are
> a couple types of problems. One of them is the following:
> 
>     # perf stat -e uncore_cha_55/event=0x35,umask=0x10c0008101/ -a -- ls 
>     event syntax error: '..0x35,umask=0x10c0008101/'
>                                       \___ Bad event or PMU
>     
>     Unable to find PMU or event on a PMU of 'uncore_cha_55'
>     
>     Initial error:
>     event syntax error: '..0x35,umask=0x10c0008101/'
>                                       \___ value too big for format, maximum is 4294967295
>     Run 'perf list' for a list of valid events
> 
> There is a 34bit umask that can handle it, namely umask_ext2, but it is not
> used for sapphire rapids:
> 
> uncore_snbep.c:5958:static struct attribute *spr_uncore_cha_formats_attr[] = {
> uncore_snbep.c-5959-    &format_attr_event.attr,
> uncore_snbep.c-5960-    &format_attr_umask_ext4.attr,
> uncore_snbep.c-5961-    &format_attr_tid_en2.attr,
> uncore_snbep.c-5962-    &format_attr_edge.attr,
> uncore_snbep.c-5963-    &format_attr_inv.attr,
> uncore_snbep.c-5964-    &format_attr_thresh8.attr,
> uncore_snbep.c-5965-    &format_attr_filter_tid5.attr,
> uncore_snbep.c-5966-    NULL,
> uncore_snbep.c-5967-};
> 
> (I see umask_ext4 there and means 32bit:
> uncore_snbep.c:479:DEFINE_UNCORE_FORMAT_ATTR(umask_ext4, umask, "config:8-15,32-55");
> )
> 
> What is wrong? The json files specifying umask=0x10c0008101 for the event,
> or the structure that should rather support umask_ext2 ?
> 
> There are a few more issues, I will update when analyzing them deeper.
> 
> Thanks.
> Michael
> 
> 
> 

