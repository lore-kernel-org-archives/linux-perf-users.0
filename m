Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645DD32FA36;
	Fri, 21 Nov 2025 06:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763706913; cv=none; b=rFy83D7NlNgnhwlskMF0uIw/TDAqO+eVKxgifhgGsAE8luGapv15TRvL1cPouLYWCOD1wY1vYuj4pp/K6UO00EWtnIVkdjmL8VUjUH6pClyuQlRuGlMTpIrKawnJV3wCAByr0ylMPWBhcDHAQgMz0ZaqGAzFYvZ5/2c501gpYxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763706913; c=relaxed/simple;
	bh=Zz6cCP1KSKUhcCw4A/xMGthElsJqiQrr7KctT/zep4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVf+LCRYRa4IOsRL5HA1k5Z2UIOHWsTJr/78RyJjB9YHaaXZm0ep6YoR8XLATI/Ef1JzGkyMZxg+VA6Tlto3UTm9KnL6HMlcFUGpQcIhhQQYyA6m2uZ8NpCyXUt6VCkNdPmGFm/7yG5RXLw0eO1U1gCe+o/pv3ed0q0kXoZBH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rLqrkcf9; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rLqrkcf9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763706903; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hpRbi0CeVm4uXkBY/YnhHVn+gxawjyC4Z7fefd3l0iE=;
	b=rLqrkcf9qfKfz+kja+Ca6Qv3diX2orOQjmm2cWp+hzsL7xkCDcV8Bg4IFYZeh+eRAKpHUGggHX7wFXp3I1e1lFfCsGlJxASiXOBCVWf2qXWTNIEHuHHWDh3iIobc0vi/JQxbT4CHWLPbyl0vb82bYy3SkbzbJeHnqzHL+7MLAcQ=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0Wt-RZKt_1763706901 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Nov 2025 14:35:01 +0800
From: cp0613@linux.alibaba.com
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	guoren@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH v2 2/4] dt-bindings: riscv: Add XuanTie C930 CPU compatible
Date: Fri, 21 Nov 2025 14:34:37 +0800
Message-ID: <20251121063439.2545-3-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121063439.2545-1-cp0613@linux.alibaba.com>
References: <20251121063439.2545-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

Update Documentation for supporting XuanTie C930.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 153d0dac57fb..581a95eba932 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -65,6 +65,7 @@ properties:
               - thead,c908
               - thead,c910
               - thead,c920
+              - xuantie,c930
           - const: riscv
       - items:
           - enum:
-- 
2.50.1

