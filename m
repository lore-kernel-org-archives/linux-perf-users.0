Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE097C43217
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 Oct 2022 22:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiJTWpG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 Oct 2022 18:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiJTWop (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Oct 2022 18:44:45 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6361FCDC;
        Thu, 20 Oct 2022 15:44:30 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E07D43C0BCF;
        Thu, 20 Oct 2022 22:44:29 +0000 (UTC)
Received: from pdx1-sub0-mail-a280.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 57B1D3C0C12;
        Thu, 20 Oct 2022 22:44:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1666305869; a=rsa-sha256;
        cv=none;
        b=AmHnOS0ugMZFFDwYW1mTfb4fvOkcwAQR096xj2ddkFMrel2C5Ww7gJCIx9q8/N4NKW2bvl
        CO/KcbZ/S9aKUHsjesDNs3vCks7EYKZ10OlEUKcAw+e+gMPyJhyYQxLFMgFOATNBdqTuN8
        n6vmfEy2XfocI9vugkj0+wqS904Brd4dlvj+c70XutH/M9/DtO2kHpslfOr7lZ8SL9JJq3
        IRkgtuhrDhqBx+rta1opJRsYpP9j7Y/M8R5CvwcfqzFv4Hwe+87wcD44IgDaOisrKaFtzv
        IM8qiTz47ZQ7vtXcJbjwaWg7K9WhG1egTAuzhlm8C75b/UpM3F1wwQBqS8QmvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1666305869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=kFakZA8TdtUu9b5QUDEfAy78BegNjksy6ocleFzvzLs=;
        b=pPPOJZJccpASxTzR6NhkdHLc3BYMyWInOVu6ncM1/DyKKLXIKvEiV7MfUma+XsMUrkPEw7
        cChboGWE6WmNNYoh/dUJhu/aScf7VHM5MjEdkRY/I8DYY3sH5QG1pE7e2I9FGBLh+ESuF7
        FKowUnejXZCVH20b6ZNjCLl/w0/hlJLognHKapUf0XQmwa8Q3P2I3bCwAPFy14APMQ6IIR
        b/lub/6NEXO6TyQFNa3bwxtJSnf2me0ZkevvRv2qCWzn/CLoSnU9Nas6o4jfboQBRlAuhz
        Jw1oE2a0ii1gZHk12oUobfhV0KalvLSmfcYfANfVDo+Fs/cegWVTDaFSCsK0kw==
ARC-Authentication-Results: i=1;
        rspamd-6955c7cd5b-cs4pp;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Imminent-Illegal: 1a7637f470d0a5bc_1666305869711_2993806550
X-MC-Loop-Signature: 1666305869711:911589282
X-MC-Ingress-Time: 1666305869710
Received: from pdx1-sub0-mail-a280.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.119.144.180 (trex/6.7.1);
        Thu, 20 Oct 2022 22:44:29 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a280.dreamhost.com (Postfix) with ESMTPSA id 4MtjMc0cSjz5h;
        Thu, 20 Oct 2022 15:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1666305869;
        bh=kFakZA8TdtUu9b5QUDEfAy78BegNjksy6ocleFzvzLs=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=mwL4RdMRQujBcnEk0WthhZRJHLp115DoUl8aeem73Hd/r1A+UewKT28IzNopZ0HKV
         olwcPnev39vAlKSwQRD+zuoXHJAYtJXy7ypd3aGKCg4J3f9/BVngAMUTG/p5rc1Ljs
         +hOpZ56uzcUUHcU7xUF+hA7myx8gpma0fppCGZ+LYyYtcVIpYOjpdYSEyiK0WfP+nx
         7If/LyDurgS5+9TGMKAJ51wIEYsWX1skhcE/8JN0RaBo2ozxobZT82QzY9+Ptznlgi
         AtXbBZ8mwy7h4MW8aMau0iHKjPHCFtB4n3qf4UeRQO8LcE+Y/ixFkW/vB/MjkcErvH
         2FwNCCdSfi3bQ==
Date:   Thu, 20 Oct 2022 15:44:24 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        linuxarm@huawei.com, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH v3 3/5] cxl/pci: Find and register CXL PMU devices
Message-ID: <20221020224424.xj4onq44rqlbxk23@offworld>
References: <20221018121318.22385-1-Jonathan.Cameron@huawei.com>
 <20221018121318.22385-4-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221018121318.22385-4-Jonathan.Cameron@huawei.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 18 Oct 2022, Jonathan Cameron wrote:

> static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> {
>+	struct cxl_cpmu_regs *cpmu_regs_array = NULL;
>	struct cxl_register_map map;
>	struct cxl_memdev *cxlmd;
>	struct cxl_dev_state *cxlds;
>-	int rc;
>+	int i, rc, cpmu_count;
>
>	/*
>	 * Double check the anonymous union trickery in struct cxl_regs
>@@ -561,11 +567,54 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>	if (rc)
>		return rc;
>
>+	/*
>+	 * Before registering sub devices that use interrupts, the maximum
>+	 * interrupt used on the device should be established to allow the correct
>+	 * number of irq vectors to be requested. Separate the registration process
>+	 * into before / after interrupt vector request.
>+	 */
>+	cpmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_CPMU);
>+	if (cpmu_count) {
>+		cpmu_regs_array = kmalloc_array(cpmu_count, sizeof(cpmu_regs_array),
>+						GFP_KERNEL);
>+		if (!cpmu_regs_array)
>+			return -ENOMEM;

I don't think failure specific to the cpmu stuff should fail the general pci probing.
That includes memory allocation, which can then fail again somewhere else and properly
handle it.

Thanks,
Davidlohr

>+	}
>+
>+	/* Pass one - just enough to find out what interrupts are used */
>+	cxlds->cpmu_max_vector = -1;
>+	for (i = 0; i < cpmu_count; i++) {
>+		int irq;
>+
>+		rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_CPMU, &map, i);
>+		if (rc) {
>+			kfree(cpmu_regs_array);
>+			return rc;
>+		}
>+
>+		rc = cxl_map_cpmu_regs(pdev, &cpmu_regs_array[i], &map);
>+		if (rc) {
>+			kfree(cpmu_regs_array);
>+			return rc;
>+		}
>+
>+		irq = cxl_cpmu_get_irq(&cpmu_regs_array[i]);
>+		cxlds->cpmu_max_vector = max(cxlds->cpmu_max_vector, irq);
>+	}
>+
>	if (!cxl_pci_alloc_irq_vectors(cxlds)) {
>		cxlds->has_irq = true;
>+		pci_set_master(pdev);
>	} else
>		cxlds->has_irq = false;
>
>+	/* Pass 2 - register the CPMU instances, currently no support without interrupts */
>+	if (cxlds->has_irq) {
>+		for (i = 0; i < cpmu_count; i++)
>+			devm_cxl_cpmu_add(cxlds->dev, &cpmu_regs_array[i], i);
>+	}
>+	kfree(cpmu_regs_array);
>+
>	cxlmd = devm_cxl_add_memdev(cxlds);
>	if (IS_ERR(cxlmd))
>		return PTR_ERR(cxlmd);
>--
>2.37.2
>
