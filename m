Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D460DC4332F
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 20:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8AF060E96
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 20:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbhJYUFP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Oct 2021 16:05:15 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9211 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239332AbhJYUCR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Oct 2021 16:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635191995; x=1666727995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xCy3IumqXQBouXXEPa6nxFODZXMtRI4XUvf0Po2mZLM=;
  b=coH3Yy55VEMnGCwW6ypbodCjJ23aqLVx9rMt4gQTotE6wJ/p75WdZFf0
   Wz7q5bAIpMYfdYp4JgGHCjXNrsmHkPcG4wID008clfAsr1jAoh6FjMS2I
   ditN/XPJr1aU06T6he8mdUDtoZXhruneDrqn0OmQSMWmIqoYgyrUnkPiz
   3FPbQZmaErI9Ulj/gPSA7vDpzSew9898eRkJhwPQrqVIDBYLKREg+wRR+
   9qSjS+mY62VDZsSs6hz/jbmxPSRmHVwv8i7bBwATCoNEfV5pClMgbwcIg
   kcyv1PUsNJPsHSRZpj5J7Zp6orX+biP45hv+s2APNPJhaKqVzmYXMTjcz
   w==;
X-IronPort-AV: E=Sophos;i="5.87,181,1631548800"; 
   d="scan'208";a="295545865"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2021 03:53:59 +0800
IronPort-SDR: bY52fTvVU/iZ32c2IWMva4HFzL2He8TiZgs9regi+/yA79DrTEp0v5yub5tpCO7v9DDvIeaA+R
 YDcgSF/UrqYv9+nCvyN/0FMI/sDkfxydeCnpG1MOMYIhu5nobEoOvmL6CRVR98fmTDb2fvax/t
 s2GyNg1eYOHtDSWgsCHSWpxQr2l3P0sXwc8kNRDxpuPki6NguUvryqdZSWHWLyKsV5f1dJqAv4
 mhhc8YRVbXUsvj6kKt934fzRBMNP1+HPVpZ+72VnBPd5A9cnhmjlN7ezevK8HlZYmQece6V87j
 EaGVMcJh67c8BB6WNuKpcrnu
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 12:27:57 -0700
IronPort-SDR: aCtzHnd6pbCvl4fpTnR1j83yaKX8pxZjmksZIRBZqTfD7aLv+ZCH3yAu1XSEW8YQ28LglwCBOm
 mfodnMO14DtBzyQzDZYTvPXQRdmYHVFoejY6Cttr2RXGNbo5AkdwXavvz5GDlj4AdinWNw+kJh
 oK2RSfawvyy1SSCPvlPCBOSAGYfnv26uC7fjog1wwy2sygjLKa60GOyAshiYdg/snBVeEU9SPd
 NWMuXmL92f1u9xbbyf2FeHlMIcNRQWAwZqeNuaX1RhiID97nEOWj3hOvQQXTjXLTpW4DxlvVUa
 tQw=
WDCIronportException: Internal
Received: from unknown (HELO hulk.wdc.com) ([10.225.167.27])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Oct 2021 12:54:00 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        devicetree@vger.kernel.org, Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [v4 10/11] riscv: dts: fu740: Add pmu node
Date:   Mon, 25 Oct 2021 12:53:49 -0700
Message-Id: <20211025195350.242914-11-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025195350.242914-1-atish.patra@wdc.com>
References: <20211025195350.242914-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

HiFive unmatched supports HPMCounters but does not implement mcountinhibit
or sscof extension. Thus, perf monitoring can be used on the unmatched
board without sampling.

Add the PMU node with compatible string so that Linux perf driver can
utilize this to enable PMU.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
index abbb960f90a0..b35b96b58820 100644
--- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
@@ -140,6 +140,9 @@ soc {
 		#size-cells = <2>;
 		compatible = "simple-bus";
 		ranges;
+		pmu {
+			compatible = "riscv,pmu";
+		};
 		plic0: interrupt-controller@c000000 {
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
-- 
2.31.1

