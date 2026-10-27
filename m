Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123492;
	b=e4kwQyBliIyT3RV3AzT1M4OXsASTEZuX7mOodBzV6FtKRjLI31CQQIQFP6dnTEb/8lhx
	 RC1suCoM6YYN0iwAivsK+X1W9H4WrIbhYrhTae1/m8NErV3CJZK77KaFrs2IEkia4GBLp
	 MrbI9aDn2yQg2yrmXdwD+VZy5ZuQfnCkE0PQJzn5D3NwzMaxrXC9H+7WKH2CDJ9pzxVXv
	 MRpnYrfPbsDa3ssJbGa9tGCctFYnqvlG3L827LA8Z+WQQnjeGHLA19enMZhOmGf98bC7d
	 bvfkaw6q+xBQ2QW7DQdfyBc1RrLWUygytxfNjQa+ewFRL8gQvh/uFxOdwnSMUgg3Gdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123492;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=ynPryf8FPydp/yEEGiFFJxiHciJ+nwSgBGs4pEky5R0=;
	b=A/mw25KnFN1NldE5EXFEsoLY6+PPzFLHmxOqkO9XBVaxebv6bYFfaO9u67bVs8N4d4/y
	 E/PAxuPv5zEeF9+75lbvnueeALfCeucmhbo4MxHUMM4BmyLrQnQMd8PDZMsSRF2fZjZrV
	 QyYn7xXFUAFJcD4Bi47SLXkBECjiIsYVq7DFX/kMzF0cIOra5Iir1tz/M4VaC32Ip50je
	 9vbs5zdEex2ksMNbch2JqHsA/IFZCBxLX21jBLlfU7fSKbhZ6qJmVQiyYGR9vAE/l9kkB
	 MPWVt4DE6GGrtzLjhaMAaSd4PtyaOKuPwwt7ggOgS34VLxNM+7YAxVPwLk44dCAXwEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KnNsRIn5;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78976606A31F
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 17:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78976606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KnNsRIn5
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so148189a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 10:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793123492; x=1793728292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ynPryf8FPydp/yEEGiFFJxiHciJ+nwSgBGs4pEky5R0=;
        b=b0/39do2g1ZNQ87EZv0XJ3BOnn/r9MsPnVy90a/EF6Es8pMiQtZXVRVm4DO+6EbY7P
         DjQC6E3wqKjXGQlpbxuHj8y0neCWZgAgK8aq6dnbS1gyamUsSW/1o5H787vfJHs+rB5y
         h00khyne7187CpjYtcxk10vqnwkBX/KbzuYAguLtbXMerwwkMJ6GzsB97/YIcKSmTktR
         /aDzglPFbFKT2hLPePyNIGVdRDVMT8v75/lcEWB6iVWW4JN0VW/OfDS4mp8zl5iN0ahT
         aLYWXq2Aoj4u55jek9szYj53DdM4ZE4E6lzDaJTAX9EJh/llc4hBAfVhqBX2Ug2gNzSI
         Mhcw==
X-Forwarded-Encrypted: i=1; AKwUvBzBvW5lLPDFSae16q+s5/kcHcVK7UZMt5ypZo/mNX5eoebIg5x7Q7hjK2WPgwlnrdTCXvZvogaCTxmgxsYJLoND@vger.kernel.org
X-Gm-Message-State: AFq9FYJUoku9p2hT+XF1VZgkVAzBqpedpxfX7A7/TNes5N5XuS/eLA5D
	zRm08G03E5Ifh0IMyBOLf+znUL5Zrz4d6GghT4MvO3oVfi4dBoTdwNwlCXQRpcdOsGThIs4nRQU
	dAZeDKJgrixUIzrgyXXXHWaS/sI8S1V6R0m2GLHnLZiN0r6wsgDTeUemnImqrMlcNRr5b8vfnqR
	Bm4UiPeAxjxHN3M+Yg2dPXD1m5qKIb6OTK8I46+0yr318hIHm2UqsOZ84C/lcrgRuSQn1lWf0cr
	bOnErQudCdVjd2XHpBvC/cwO28X8Det
X-Gm-Gg: AYBFou3x4ElExvHoudsDuY+vN8ew0QB5LYnuEBkgH+Yl28s7TG1Hdu3lfk6uFVtAaoG
	gGG2aMgMrxhSqRy/PNLADM6s5DFVu/+EqzyUCh9Od2ylaiZkJpSuEtfeYB7qgKOLVYnpzvsvowF
	ZzAeHXIw2XnZf4/lSkLQcML4/N5xr5311OLu5QRSbmRQN9x3Hgu3RwLhxtRuej9eYQcUfURu12I
	hUwWPPaWZofk18Xd3B5a+cK59uBSMyXPiY+xq7d29zh2Y67jKEXppvjTEoKDUqz3JrZWeUMxwDR
	NCe/xHlNM21yRR3hEexwvIwdTZwr49Ika/jWXWtKdXrismHmxcCFIbG9KnKQsZ2frQa/NF9rOkP
	/ANKIdKS/02x3L/Iv4/Fu5V2R+BPeJAF5LTCo5Qc1+IER5kezs11zC0Pme8yPz+z+tVyH/zQyY4
	5qUFzSOEH+IgYYzPNAUcdEaAHjjVH6tGz45ckjhv83
X-Received: by 2002:a17:90b:4403:b0:3ab:884b:65ab with SMTP id 98e67ed59e1d1-3adeae86b0emr10268937a91.55.1793123491821;
        Tue, 27 Oct 2026 10:51:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae55a6e1b0sm56971a91.2.2026.10.27.10.51.31
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 10:51:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5363fa3d3e4so4607741cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 10:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793123490; x=1793728290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ynPryf8FPydp/yEEGiFFJxiHciJ+nwSgBGs4pEky5R0=;
        b=KnNsRIn5rPXbYlRZ3D8CkIIIZ3cjZ2XNagJss9nCusmcYzYdSEeFZr4iGUEKO1j6Qa
         VYT0q6RqN4/Qi9WDHp8awscMrllkxaVsdLomH+XO7J7FpvuOB+m+Bit093azr9MDVum0
         q0643wT0D3JWUDFN60poZNns3i8L0mQmhUMiQ=
X-Forwarded-Encrypted: i=1; AKwUvBzAkiqsVSR4Wu7wyJu05LcJGAa7quiOMtmKVeJYdP7Ml2Z1cr7CDTK/Rn0Lz+cF1luf/TJFUiUR7tUj47cPkrbg@vger.kernel.org
X-Received: by 2002:a05:622a:5b09:b0:536:539a:af8d with SMTP id d75a77b69052e-53fc5cbfb48mr1179721cf.0.1793123490130;
        Tue, 27 Oct 2026 10:51:30 -0700 (PDT)
X-Received: by 2002:a05:622a:5b09:b0:536:539a:af8d with SMTP id d75a77b69052e-53fc5cbfb48mr1179381cf.0.1793123489573;
        Tue, 27 Oct 2026 10:51:29 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5383970ab61sm83164511cf.17.2026.10.27.10.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 10:51:28 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Support for BCM5301X AXI trace PMUs
Date: Tue, 27 Oct 2026 10:51:21 -0700
Message-ID: <20261027175124.3518239-1-florian.fainelli@broadcom.com>
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

Changes in v2:

- addressed Sashiko's review by adding the appropriate title length and
  group validation

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
 drivers/perf/bcm5301x_axi_pmu.c               | 452 ++++++++++++++++++
 8 files changed, 619 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/bcm5301x-axi-pmu.rst
 create mode 100644 Documentation/devicetree/bindings/perf/brcm,bcm5301x-axi-pmu.yaml
 create mode 100644 drivers/perf/bcm5301x_axi_pmu.c

-- 
2.53.0

