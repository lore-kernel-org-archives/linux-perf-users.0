Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123502;
	b=YeNiCoVA3pe6C8syxQOUNGv+dOFYC9zmggzoyqcGgDGEAw86bYIbv2s8iGe0YaAF1rnA
	 d3H97dGxTRWpsX3yMowKizvaQI6wrUGSTJr93pdhNcf1b0TLSFd2YezNC5xg7XqqAboaP
	 qU7YmZGHNPoPKQG5RhaMQE078RFRf0OkdC9aNdEtlmsgp1NC/f/hzs6P0ckkT7l5h6vNC
	 4ALBqD2OSx7FyR0qHAQOwiwRKsoMK2Dc6CQe2GYKK7zpjzGgKoKlBBoC124ANZckT+DB8
	 U39v3296UIvU2OFuZdGEfs+Y093yIYZCVbpwMi1oSpSuJlU5azggpkzM3oJ8kQmJLcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123502;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=QkAGfe/UDsHGvMGKL2L3uZbprb9NTy21LdH6RR7axyA=;
	b=k6HIjLQhRh9yFB9rIp8uuvXmk60XSLxFqatfu+2ao8CPrxqyPEHHJWu7K2/yQ6Wbe8tf
	 NzaVY9qQZv/OEXhJEkCntwUO9RGbURBBjEZwEeJuFq6mpdg7WWfvF6B7a76CWkEoMO10p
	 Fz51+dbGPAonl02W1qSwD67Hwui6wz09nj3nK8kFC62bHPwuoaLt1k29IkljBp7eTqHRw
	 r7nDrWoU+tX+/WsyDfaH0ahzHaEjEtyLTrZOd6IO9xafet1o6IROuVWVoqs7HWTKXqErp
	 ONyt8dC4bxomrcZ9p7Od0Uy70yDvo7MLCNXhS9PIqBxCdMKnRO2jtRBysXFG8r9U2AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="Qczylg/H";
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5847606A325
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 17:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5847606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Qczylg/H
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so139357a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 10:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793123501; x=1793728301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QkAGfe/UDsHGvMGKL2L3uZbprb9NTy21LdH6RR7axyA=;
        b=jTIqOfKbm6ozQQBHz+rd5O3yhCDO15ALw5EoTB8G1HZjb4bGGHESVwvb0Du6a4XAuO
         pWoJBYSDEydFrmxyylDiT98pPAYfcmZTV5AAF1C8UxXhjazwEUsntmBFoJHceWqXlf6U
         CnIJ4unjTZqGgW/qQlHJBkIXK6TSLNpI8QQE38/2O+F3yPCpxAFoHPqxvf5X3OKwNhU/
         fiOP+hjDT1guvteTO6EqjivgoC61bpHMHwcHemIfCV9VaKk+8eHXAyAHdiVo7lSWYTJL
         fr4tWzwatMINGfMBfnhKSzb3EVKreP72SQJnfr/Gc/t6RjKkMY9/zTGa49ACZYieFuLu
         VLfg==
X-Forwarded-Encrypted: i=1; AKwUvBzeFLTL9Y2ke7rSEMT4oT74MyqcClI/bNhTTHtQgHFFgkDGU9xS/uMVw5eWDBfQNgUgyFlfkQ8Ufu1dtlmZV0zc@vger.kernel.org
X-Gm-Message-State: AFq9FYLdSh7t3bKS9DQ9BBpF4+RjvZJeLP/svJ5f7x2a8XwuPwOtOcu4
	EVP/3KUnVL82i+2X1lG6aN2rM7x3gtlakhXwAUBYbslPt2yYfuser7xrBelfH1UjnVHkaSAS8og
	sxAKfrQtQ8tqz5wHyt8NaD4+eV5sTp0I9cQNLya7DrQ6FrcisOtSufv/1Ut/whEMhyPH2DHYEMV
	5W7s1550EOybyZ6FIDvNaY7nCFYoFx9etYU2Kjq8PdVUCEPXLWAVASaHFrrRXEaUpUzXoXStoZp
	nvB8NvY0PknnKRma2YLaKD239rmq7NJ
X-Gm-Gg: AYBFou19hVDASR9uicceaLSuk+6rb6SFN1iMYxT+mDHb6Y9SZQZnxknzx9ACZ6Yd2Gi
	5g9g8JT9pmxST8+zSSO8eoVEGFtKJ0+8xxYU7qY0z8WlzPbRgBTZ1hX8NcTwKC3tYq+1UW9u1E9
	r+5OWzjgvV49ahpw8XY3DzYnGXesiJhTTbG9MRpgwY8rxIx3IGccdvv692kweGPZX+m727NPHuY
	XdALq+x1t3p7rj2f+XxMeK5fkGUzfWqU2uW5dyGX/7Hy767c6yQvrKfwk95T3sXmhULR5B3cShi
	UxnQ5zgTQk42sKlVo/zxew3pcXJvnEvR5zVh+02w21g3rtmNcyiVhPfNwrjqlQ2E13gPhyHK8TR
	Mu8g3702h2dY+jQkFC58xwbhG6YQjDnrKkIq2J4V0k7hvsmaA/m7OvQuzPSvSvnBFTfihY1Zrkm
	gAcYwgIIc+fV0Ib3XzTPxD4UjSifslXcKtxR7scTbA
X-Received: by 2002:a17:90b:3f4c:b0:3a8:d71:5fda with SMTP id 98e67ed59e1d1-3adeafc7f8amr7956046a91.63.1793123501152;
        Tue, 27 Oct 2026 10:51:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae55d66953sm60988a91.1.2026.10.27.10.51.40
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 10:51:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5337b591609so3155081cf.3
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 10:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793123500; x=1793728300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QkAGfe/UDsHGvMGKL2L3uZbprb9NTy21LdH6RR7axyA=;
        b=Qczylg/H+JxabyUKQO6+Wf2DSWugEEbAKDOWvySYrn6hpb5ft8XX4RJjP5IP7UFiOB
         dTXQrSXG7Wk6MX2PRDH2ffPJOdtECGQQyL0KqWBiZJxBr8hftLXax6E4dODUW3ZpMtwl
         lbd90VI+GbwwIaaS3WR1UzOc04ZGFLcrwcG/o=
X-Forwarded-Encrypted: i=1; AKwUvBxh3FhmBjVPRKivgZHOY4i2CR1INxCIWsBh7NwlTlPvueRW2p0EwwXHENmEZ9gRcz12TLd1vZeKfqORWQDxp/dw@vger.kernel.org
X-Received: by 2002:a05:622a:54c:b0:536:3eef:56f3 with SMTP id d75a77b69052e-53fcc6c1af8mr63551cf.58.1793123499697;
        Tue, 27 Oct 2026 10:51:39 -0700 (PDT)
X-Received: by 2002:a05:622a:54c:b0:536:3eef:56f3 with SMTP id d75a77b69052e-53fcc6c1af8mr62871cf.58.1793123498959;
        Tue, 27 Oct 2026 10:51:38 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5383970ab61sm83164511cf.17.2026.10.27.10.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 10:51:37 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM5301X ARM ARCHITECTURE),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-perf-users@vger.kernel.org (open list:ARM PMU PROFILING AND DEBUGGING),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Subject: [PATCH v2 3/3] ARM: dts: BCM5301X: Enable AXI PMUs
Date: Tue, 27 Oct 2026 10:51:24 -0700
Message-ID: <20261027175124.3518239-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027175124.3518239-1-florian.fainelli@broadcom.com>
References: <20261027175124.3518239-1-florian.fainelli@broadcom.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Describe the three BCM5301X AXI Trace Modules and enable them on the
BCM5301X base DTS file.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm/boot/dts/broadcom/bcm5301x.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/broadcom/bcm5301x.dtsi b/arch/arm/boot/dts/broadcom/bcm5301x.dtsi
index f06a178a9240..dcae7cba37c4 100644
--- a/arch/arm/boot/dts/broadcom/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm5301x.dtsi
@@ -10,6 +10,21 @@
 
 / {
 	mpcore-bus@19000000 {
+		axi_pmu_m0: pmu@3000 {
+			compatible = "brcm,bcm5301x-axi-pmu";
+			reg = <0x3000 0x1000>;
+		};
+
+		axi_pmu_m1: pmu@4000 {
+			compatible = "brcm,bcm5301x-axi-pmu";
+			reg = <0x4000 0x1000>;
+		};
+
+		axi_pmu_acp: pmu@7000 {
+			compatible = "brcm,bcm5301x-axi-pmu";
+			reg = <0x7000 0x1000>;
+		};
+
 		a9pll: arm_clk@0 {
 			#clock-cells = <0>;
 			compatible = "brcm,nsp-armpll";
-- 
2.53.0

