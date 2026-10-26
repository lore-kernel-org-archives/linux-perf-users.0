Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049122;
	b=O9Hwjc6w1KbXh/oVShpcY+YLOerRoX6LBxlk6fPMnzUibj8KNoVyFOEHY+2lUkNILDSe
	 V6D4sy9upFOqzbUqHW8u0OWaVhGtVTIkYidOLgtFhfDSZQhPmlru8mzyputgk/aA/Cztq
	 kyN1v1z6BWurEcTssfeIUUErQPr+6VT/U9RWIIlgnUtrYEIdASZECtDpE2jBknzDxGRLm
	 +oKtHShPLFZk37ZcsE299Cwqykk1pJ0jiqoAb79/vyO1+kKjI4tgHGbOB0o0D6yilFCxr
	 qxgXtobQB5HIwAh2CnKa8DRNLQ7ZlArseLul01M9DtrJOyfqtO+qCvbHHwTHDUYv6Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049122;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=/ESG1GK92x5B58pgVYf4SxkXNGgkEl2iePaEHR3ImRM=;
	b=1DzxwZ35f/AMY0jfli5o0FMQd7eXBId25sYWoIsbxSgXcpiGfX9A9JfqDxY1P0bHai6C
	 YytzHWYOkGN5r2r/NdHNHEZ/JSfTWkfYkNhu8qGjGkU/m43sfWikEW6f7W8BBFp2pSN/E
	 2h08Y1o0vQDtGdeMzIx0mw2WqcdWTHyb752zHKVyv2XcLMyxBooEH4h3QPB7PsmdfgoJE
	 62qs8AKYaBqc0maRcPvCgFB6l/c7MJRcC43MWzEXcRSv/UET0XaLNW7wHs+VBuoSWxdND
	 qpcdx5OI2dePh3AMFakpIfYFR4NPP8SjN6qs/elcskTFFTM35gTGUhpZwqvHrHHgoiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="N7msw/Lj";
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76252606A31B
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 21:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76252606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=N7msw/Lj
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cd6a7b62ce8so1036853a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 14:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793049121; x=1793653921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/ESG1GK92x5B58pgVYf4SxkXNGgkEl2iePaEHR3ImRM=;
        b=NfYzFJ23rH37oST7uJRj6NB3NhqNYwHxd7Rlk3fdVav/JebtENbrm6yWUVQjvb+LOa
         EaJsKc5O+ldRke2mLjqaANbrazpu1tUP1Mz4lSFeii3UTIj7RsmnPZPo2RZwbVTgH4iD
         nJpQGpFEZ7+85UzgHwE2VGZ4BSoVRy9a3ASwVavHU0D/O82fuEH1S+da3D9kidC06sHa
         Fuuuw/o8iXhTU4WMYOY9K2pY7th6hDN7FOMg+sXpjsO5Q8p9JS4CVIx7rDVqtFuRm79j
         WLmaMKGBwdtZ6GPlMqx3yuWgS3TPsP1TmrouWxsqbN2q2PdVFQJSvzzm5md7svpocTeG
         iNTQ==
X-Forwarded-Encrypted: i=1; AKwUvByO8Jcf7ftG/ZrO291RxIiQpFy5MU9irwQn63YKx4Romng5t3effA9WmDJgusRZLpARw+ntFS951QCgVaPJcers@vger.kernel.org
X-Gm-Message-State: AFq9FYKrPgqZQWO377U3nax185L00/RSZy0w0vddId7IJzQtySeM3w2e
	DK0IGHc2H/QypLHXHNmEsMvfFUv2NGN6JPHeMFexkO7vbPypQRG5cyzdnO1aEVdECkj1jOnvTyh
	GVlNAUMZVN7QsnKAanZTmbwwIcZ+f06Obcmy0LLD1PIf6f+RPXUYNYeSYy7t/Xb5OBZN4IcF912
	oGeiUXGVxk63cWG6UfI51BhLdN2YZheukJQMqwLbn7cxNkNY2uk49hIMKJSVQFoHc5lp+Y15Z2f
	7zhnQHFuqjl0n7TI5ZlMKU0+VO+X8hm
X-Gm-Gg: AYBFou1dphxBwA7VJBlPAoMWRVLcpEwqccdZQL9dDu+bPnUp/ZUDSn23QXhl4FIkZJ2
	jfCwiZ2dZ+KWCZPNh9hTFjdfjkrhOnpK+4ZbPsMtEx272MeZQMICdNWU5sv8/Autiki/4+/n5LD
	v+N10DeAsvFBgRCSbThvn0coU0LBat2/5rkAvv9uDYDssBD5teldIqqGNusZAMgiEHl5jCpJM+e
	vAhOnO6f9QcvoL7Vh1X8b9PmIf0tdV81RQPtsmkYjWp8s4LCDM/bwBIt5sBYzpfQhNS2w44ABnl
	taj8ElQlYGFzS/9Jukc1O+lnv1+Fp8Jk1NPvYgiQfjipFTtiScFolkz9lYKily7T9WSAHfNEO3V
	NRnCkMKpsR31ryrV45jJNItWWxhllMKpVzci1u0lxIDFeZ82rkU8Asua/yhZ9jX/0XgjvS6BX9b
	I24wQMudcZKx2kUa2CwNA7f6eZqMcbSc5+IAzCCUkC
X-Received: by 2002:a17:90b:2646:b0:3ac:7378:be04 with SMTP id 98e67ed59e1d1-3ade946f3d6mr6713880a91.0.1793049120773;
        Mon, 26 Oct 2026 14:12:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae405f13ecsm526661a91.4.2026.10.26.14.12.00
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 14:12:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-18b5ee75447so3762672c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 14:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793049119; x=1793653919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ESG1GK92x5B58pgVYf4SxkXNGgkEl2iePaEHR3ImRM=;
        b=N7msw/LjUAO06jTT33HAeE2jfXss/tWdcRa9CMPvn2AKZ84mrvNCO+U7NZQpgULCVG
         ktJvfFKjLUPxWZyP7zlpGrpw15mIHiNENiWyKewSda7W+LPLvHHM0zs50wssyTonX1Jn
         HhxxF+MXnk2PkUrCusJPEKXuOzENWxd0e7gWw=
X-Forwarded-Encrypted: i=1; AKwUvByHC3Irfp7zwd0G5PIYvIzOAtR4gFNwuaeY36NYkP3JsHKJXTyXde6lpX/xDtPMvonm3qGd6FnlGj1DYVJVbb2c@vger.kernel.org
X-Received: by 2002:a05:701b:42cd:10b0:165:4b88:abc2 with SMTP id a92af1059eb24-19936e394f2mr11809676c88.26.1793049118831;
        Mon, 26 Oct 2026 14:11:58 -0700 (PDT)
X-Received: by 2002:a05:701b:42cd:10b0:165:4b88:abc2 with SMTP id a92af1059eb24-19936e394f2mr11809638c88.26.1793049118184;
        Mon, 26 Oct 2026 14:11:58 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0f81ea9sm31915678c88.11.2026.10.26.14.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:11:57 -0700 (PDT)
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
Subject: [PATCH 0/3] Support for BCM5301X AXI trace PMUs
Date: Mon, 26 Oct 2026 14:11:48 -0700
Message-ID: <20261026211151.3212237-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
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

This patch series adds support for the BCM5301x PMUs which are AXI trace
engines present in the chip.

Florian Fainelli (3):
  dt-bindings: perf: Describe the Broadcom BCM5301X AXI PMU
  perf: Add Broadcom BCM5301X AXI Trace Module counters
  ARM: dts: BCM5301X: Enable AXI PMUs

 .../admin-guide/perf/bcm5301x-axi-pmu.rst     |  92 ++++
 Documentation/admin-guide/perf/index.rst      |   1 +
 .../bindings/perf/brcm,bcm5301x-axi-pmu.yaml  |  43 ++
 MAINTAINERS                                   |   3 +
 arch/arm/boot/dts/broadcom/bcm5301x.dtsi      |  15 +
 drivers/perf/Kconfig                          |  12 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/bcm5301x_axi_pmu.c               | 450 ++++++++++++++++++
 8 files changed, 617 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/bcm5301x-axi-pmu.rst
 create mode 100644 Documentation/devicetree/bindings/perf/brcm,bcm5301x-axi-pmu.yaml
 create mode 100644 drivers/perf/bcm5301x_axi_pmu.c

-- 
2.53.0

