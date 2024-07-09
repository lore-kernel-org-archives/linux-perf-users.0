Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B60715698D
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jul 2024 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520734; cv=none; b=vGJCspOwXyrb8GCU5SqgjH4fm6OUfN3iI96SZFtJKp/j4UUEjrWjvinxxp1GaEp4e1JG2vbnexEN9toR37a8WRPiaDJm1y6X2t/A941h7TTy/pMX57zbO6XbaNIGRlBTo2lBIyNozj3rUDTnPptwCc+rNzWz7FdAYQAmIK2v9BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520734; c=relaxed/simple;
	bh=EoSR0aXO2+/z3Iwpc6wgpC/ugmvAjQBUjo7PHJ3kGsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=noYTHx9KT+kuUiTIX9a+55QdNs+D7FfoyVjhJ2SMwUOPjQzM8MB3hHqZCPh6/KTskc1otAIvKYnYpRQ4yGdbWn4eFD/qTlHEi1JhoPRDV4g1zvkWLZ5lMQNgCqkEH7ycdOHe3iZxO/7SbVl0AfjfP817DjfInC32PX8BjllF3C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yj+7QbJm; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yj+7QbJm"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so52353261fa.3
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jul 2024 03:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720520730; x=1721125530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwCSgjxT2tK3otzDQLFuNSIFcwYyO+N34TvcAykwDTc=;
        b=yj+7QbJmnaBwMJsJqTe4qDXZjXjNVaPQJc39KaYSB0hqlDgzlaJTigvvkcNuz75Y4e
         fK7AYDBYQNBj2c6duHNiiKtIEg/ezSW/LQoH4dYtsfeOKFifPQsLycmEofRH33RpsROO
         kpvTV6+TiDGjjHbWbvDi9zP3u4jbkJ812+BGgXGHw9vwmh0v0y+e+0G7CQWANw9WJLX7
         wa3mESvF8gjYtLIn4J8YbXpGO/r1PH79BvswPsZcIzTcUbId4innnzXeRIl5pz8HtSLA
         MiRG7jGupAW9+KckvWyUDvCchcquA+FwYupxCGy//fSR4iI4NszsPLY6o8rJS8mTj8Rj
         9p9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720520730; x=1721125530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwCSgjxT2tK3otzDQLFuNSIFcwYyO+N34TvcAykwDTc=;
        b=TP+mk9veY7fpQ/0nQ2B1sZ9DX9GMx8FId6QJDyyESp6gM6bvlIETZt6sHwJCyLrnuJ
         1R2wxDcQmD7u60wtYWyHvMIiqZfeuUxxEV1futNNzeuUx0g66I4smHhLvYeUmcepatNr
         87rta4g7DEJ1yBOIL3EO1KFDlv+scAkF08v0T5QlSvDMC52o+DMWjcV89f8NVdp/JkLJ
         zBNc2Sves3kefuFDTDVWaAMOSVynT/AzyvLPZYrzv2EtrHVZT0vTKYrIeOg8z6fnJ4th
         enDzZjnata2j6cBIOtlN3gW/sOaA27+OCWdtxHgV6vE6iU0jAqYB86y+b5BZk2t1qEOC
         5tzw==
X-Gm-Message-State: AOJu0Ywpqp8L9b+36xr1NBWw+AY4hC2JKHoExDAFzAjUujS0ucpknBiR
	UbsvmgSFCm6OEL3z7luDfNOiNN3PKN61YcvS4K/OYYWDZVsQEdSWe4mQoiMg7Xo=
X-Google-Smtp-Source: AGHT+IHXJH3xjv9MTkIQQxNiMOAgiLbTh1Pv7hSzmS2GYQq3dC5IRHiDgUXWiz4o/lttBs7kCUQaWQ==
X-Received: by 2002:a05:651c:198b:b0:2ed:5c34:4082 with SMTP id 38308e7fff4ca-2eeb30ba0abmr20555151fa.8.1720520730294;
        Tue, 09 Jul 2024 03:25:30 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f741553sm33954285e9.40.2024.07.09.03.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:25:29 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: akpm@linux-foundation.org,
	robh@kernel.org,
	suzuki.poulose@arm.com
Cc: linux-perf-users@vger.kernel.org,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Kees Cook <kees@kernel.org>,
	Matt Ranostay <matt@ranostay.sg>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mao Jinlong <quic_jinlmao@quicinc.com>,
	Hao Zhang <quic_hazha@quicinc.com>,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: arm: Update James Clark's email address
Date: Tue,  9 Jul 2024 11:25:11 +0100
Message-Id: <20240709102512.31212-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709102512.31212-1-james.clark@linaro.org>
References: <20240709102512.31212-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My new address is james.clark@linaro.org

Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../devicetree/bindings/arm/arm,coresight-dummy-sink.yaml       | 2 +-
 .../devicetree/bindings/arm/arm,coresight-dummy-source.yaml     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
index c960c8e0a9a5..08b89b62c505 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
@@ -30,7 +30,7 @@ description: |
 maintainers:
   - Mike Leach <mike.leach@linaro.org>
   - Suzuki K Poulose <suzuki.poulose@arm.com>
-  - James Clark <james.clark@arm.com>
+  - James Clark <james.clark@linaro.org>
   - Mao Jinlong <quic_jinlmao@quicinc.com>
   - Hao Zhang <quic_hazha@quicinc.com>
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
index 6745b4cc8f1c..d50a60368e27 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
@@ -29,7 +29,7 @@ description: |
 maintainers:
   - Mike Leach <mike.leach@linaro.org>
   - Suzuki K Poulose <suzuki.poulose@arm.com>
-  - James Clark <james.clark@arm.com>
+  - James Clark <james.clark@linaro.org>
   - Mao Jinlong <quic_jinlmao@quicinc.com>
   - Hao Zhang <quic_hazha@quicinc.com>
 
-- 
2.34.1

