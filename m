Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049128;
	b=zLaTVMo6xoKPDkQNnAUOdjYW1hpuP2yOKKl/1uIBpP39f68zz9DGXb/E7vyWUSHF5Ww8
	 fGp71yQGKJnmHb57Md1fPzRI/YhHCYOVo6UKjDNXGtfRyzlQGYjX0BwRPCGoPCwuWsJT1
	 W2E1ltf7KOw+2Ib5D+YGb5ZcjtVflMz5eDmBXAZfTqyTs90r0AFa6gw6eCWqasxhL4Zh0
	 KRfmaT52TZLGInzRlcD86VorcQgGJGb24xec8SDB1lZErA2246QTAcLZFZgBURIgoQdMU
	 4cWMZsSTYi461J8dNWsRXddXyQNL6nzO4zP6gMZIDmOPW0TkhVkG0LKpMpMxaLHqIhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049128;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=QkAGfe/UDsHGvMGKL2L3uZbprb9NTy21LdH6RR7axyA=;
	b=uC2p0qNj7c41QJ/oyRsQAqwGhQhNxo8FpexvwmFtByYDEaMi5vTzeFWI6uhiu7JZWTnB
	 cWj/xfuuYLuHp7s9pl7f0q7HpFsQrkZev80wOAp9RdKMhjmFoP5LLC7SswC8Z/8hTkeAq
	 MWqVIxk9G86wyCzZfMmnQ/WlN/SKtHLIqLrN3oJ/F/9G+yQIdLzsgRGejIYo395YQrfrr
	 Ew97wM9Uewg9faqMqFQJYwIz7fLoeZw37ZnFc7UUv59ph06Dtna0L11DTYQGz331BBkPA
	 DGqC+glwtsMK79nZWuJiJSgVN6+SfUqtg8fFdcUj+/k2O7MrLel8ASOgUInD4SMIEPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=PfhwGTgB;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3A60A2605
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 21:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51B3A60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=PfhwGTgB
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso1802514a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 14:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793049128; x=1793653928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QkAGfe/UDsHGvMGKL2L3uZbprb9NTy21LdH6RR7axyA=;
        b=Qwi8n/F2L+g9G/xjYe0Pwk7snIxy7Rpo+031PWE65g2Hx0ZHzKQ+q0xcfkjn+Uy5lW
         h52gSLDZ+/KIdYCvuYH54CpFrtiu0yvNZA4uZhA8zUJ33LrmVUgMbuofLQkIIjc8rtgB
         NxrFdL6K6sLCvAD0f0eEQ3FIS97UmmIhfaxA4QONAD2/DXhAU+9joDemHC44w0fFMcsi
         6xee3NP5WQGKnWjGVDKFXdPdCyGI5lC9Z9cjCosQV3wQWrXYqpvXUPPuVQf6DMl8zoMz
         GaaVSereTyRKg8PfaJuifD2k3MKCgaF74NyOO6hYMZOhHSzR1UxTrzF2ShOLup8jYU3+
         HvuQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQ6BY+6UH707m2wJ9DnqTXca0zuoKUQJfyOB9AhLuB3NBc9inoivBs43J3uPfm/AlJYyZhT0MbmIwEBUPl6ncT@vger.kernel.org
X-Gm-Message-State: AFq9FYKHgKvsaIvpfEsMYlxq9IyAlFHe/Z74Jtag8cKFujSkOqEgn3NE
	9++9xJVPvV5RRTyD21jOy5sgHa960/nKZRUqTbAl5GfEYWyyOyn4uIeFT1qNkvav6uD7CCUQyjM
	y2XGPhPuW09XQyiBgOd4kD9Wb7ZgM5/r1WioJnRS0a0kejvil/Dz16qk5FsIiMWprpJsssAn/N4
	1A2deo7aBWt9iakd/RLNGwfwtcHjWUY2KZb6kPFY4JhYvgBzAlE35Aawq3jwXUoX1K3MQ88dXdh
	RokfRn9KBRqWom5xakf9bB+Yw9buERU
X-Gm-Gg: AYBFou0DrtXGgTJYX/+Z6C8/PyPpBFe/X69b4/LMmeIg6dK8K0MmnVe4lNnlcdDb3jU
	pXUa1Rdc0VEXyY91oFs6rdavDmf/khRaEHwdMduVURVBsekmS04VZcLesz17+8AdkzvDu+p+uXf
	iFC7NvFjv0x/D1IXxPsgZWLeUFOMwUfwnQyJmcFbj7A+lvak7D5OeAbEddehXuAAw7VaSz+bux7
	Hzx1z6vpjTgKHEWajy+NYFmqlAKrfjM7Tn95pwI1rN0ZsQR0nCMevYvwrN0CXD3YHPjRJBjtrDh
	qvp9k3yAtus330VwtuX1B7HSJvilM1i+HdlVFrYCKHRsgjf8c1AKA1n8cesRFgnEKTe9i/3KBM6
	06RE9mvT0d5KJRki3LVtL6KrRr4I7kusEZIpxJFHM7YmoYanJHeS1u8Qi2Z5rqK/65I5n2Fazjj
	L7NDcfiuUBKUePK4nb2IXrs9PUnqYgPtqsYIuqgZCx
X-Received: by 2002:a17:90b:134b:b0:3ac:ffb8:1809 with SMTP id 98e67ed59e1d1-3adeb0f6cedmr5478183a91.39.1793049127784;
        Mon, 26 Oct 2026 14:12:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae406dbad7sm513695a91.2.2026.10.26.14.12.07
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 14:12:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1665200f4c2so4093038c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 14:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793049126; x=1793653926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QkAGfe/UDsHGvMGKL2L3uZbprb9NTy21LdH6RR7axyA=;
        b=PfhwGTgBUJ5zVQWhxz7I/MWHGTjwtEFi9lj8OhLboPwwYtWFCEHd6vrlAKSuoPTfNQ
         PVmETTYCdSTnH2Kn5A2I15wJ80v5D5POqMQVujnoUbNWV+cplC0XsBh9VxycTzpjOeTd
         7YXlmUeWiyFXpMMax+eVFNra0ZwM13Sq8eX9w=
X-Forwarded-Encrypted: i=1; AKwUvBzoZ6AGRBkoNqYxbQ7haLRWBB8/SfShTI6GuCp2hAz3g02SEQ78Q5AKvJn/uf0buwD5yeVySC0BYByIjwqFPF/v@vger.kernel.org
X-Received: by 2002:a05:7022:eb50:10b0:191:a5b2:ef4a with SMTP id a92af1059eb24-1993677ac8fmr11277907c88.28.1793049125726;
        Mon, 26 Oct 2026 14:12:05 -0700 (PDT)
X-Received: by 2002:a05:7022:eb50:10b0:191:a5b2:ef4a with SMTP id a92af1059eb24-1993677ac8fmr11277868c88.28.1793049125085;
        Mon, 26 Oct 2026 14:12:05 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0f81ea9sm31915678c88.11.2026.10.26.14.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:12:04 -0700 (PDT)
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
Subject: [PATCH 3/3] ARM: dts: BCM5301X: Enable AXI PMUs
Date: Mon, 26 Oct 2026 14:11:51 -0700
Message-ID: <20261026211151.3212237-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026211151.3212237-1-florian.fainelli@broadcom.com>
References: <20261026211151.3212237-1-florian.fainelli@broadcom.com>
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

