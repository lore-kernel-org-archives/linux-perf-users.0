Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3BB261567
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Feb 2025 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536771; cv=none; b=UgxGxhnlzpr9Yun9wuZ5nU2g3qNkrJrDma6xs56l7lPP4do/Ol893NFlYyN+8QkUq7hNO5JkSDXhlZljBKvZYcoz52mXaNwZhkc85P3gcNLNyK2gtAuyxry0uG+ICurovgCkHF7ut128vprjXTRsitUA4vm7+YpZzWG1uCiNNzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536771; c=relaxed/simple;
	bh=wUJLsBpUfTO41PJVhqFGXmTxlHsCIUkobJgBtybloPY=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=JyXswwL2I5IxqrQKLl3mmb+nGIz9RHKzYMcrmxDeTK2vCbqIFI6tUTrxBanP7oZrs2l8LzrC7G6F6jb3Ic7F2+pdAr+Bo0wQ39S5dMMjE96bG/ZrK3tfkz/ZW8nXokCzRASawt6i2IJiGyu+Q4TKJdoyftSiBcCqNP9vWjYlp9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IztCwXbL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IztCwXbL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739536768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=6QQttv447gqQ+0Sflxds+Jp/b4IfHaPXXxADSvrXK9M=;
	b=IztCwXbLcai30rjlEa7LwAjKnrfTBaSx7w1J38KTIKypoitKYAT/zhwNhBe9YuxhiOEEsn
	/qxB/3+4CsTC5QLPZxVqUmMn5SXzDA0DYFdBV0XqRG/llLbX1t49NwirD3piS1KCgLIb+v
	odcyAHds6dYHzWVeKtfzLD4YOIrRFls=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467--lF9ParjOgmMAZfxtrDXnw-1; Fri,
 14 Feb 2025 07:39:23 -0500
X-MC-Unique: -lF9ParjOgmMAZfxtrDXnw-1
X-Mimecast-MFC-AGG-ID: -lF9ParjOgmMAZfxtrDXnw_1739536761
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 979961800980;
	Fri, 14 Feb 2025 12:39:21 +0000 (UTC)
Received: from Carbon (unknown [10.44.22.21])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9331F1800875;
	Fri, 14 Feb 2025 12:39:18 +0000 (UTC)
Date: Fri, 14 Feb 2025 13:39:14 +0100 (CET)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org
cc: irogers@google.com, weilin.wang@intel.com, caleb.biggers@intel.com, 
    kan.liang@linux.intel.com, namhyung@kernel.org, acme@kernel.org, 
    darcari@redhat.com
Subject: Broken intel uncore events on SPR
Message-ID: <a2372e44-19fc-7eb4-c24b-1a568c742546@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello all,

our testing shows that some uncore events are broken on Intel Sapphire
Rapids (family 6, model 143). I have tested v6.14-rc2 and the results
are the same as with v6.12.

The full list of events that don't work is at the end of this mail.

The reason is that their umasks are too big in the JSON definitions, e.g.:

  {
    "BriefDescription": "PCIe Completion Buffer Inserts of completions with data: Part 0",
    "Counter": "0,1,2,3",
    "EventCode": "0xc2",
    "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART0",
    "Experimental": "1",
    "FCMask": "0x07",
    "PerPkg": "1",
    "PortMask": "0x0001",
    "PublicDescription": "PCIe Completion Buffer Inserts of completions with data : Part 0 : x16 card plugged in to Lane 0/1/2/3, Or x8 card plugged in to Lane 0/1, Or x4 card is plugged in to slot 0",
    "UMask": "0x7001004",
    "Unit": "IIO"
  },

$ cat /sys/devices/uncore_iio_*/format/umask | sort -u
config:8-15

Who is wrong? The JSON or sysfs?

Thanks!
Michael





Broken events:
==============
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

