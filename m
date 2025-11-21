Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C94026A1B6;
	Fri, 21 Nov 2025 06:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763706913; cv=none; b=JCElhWkcEEWWcS0cC/Sx6kEdeKYoLODcfrINoMC3GWvPEeXbekZZ1fg3o5NSGGZ3r8cBYEkLMJ8h0jKs7uV74asuww5YSGQjUmkZIuT4Mp23Uv5Xt5aL/RXHttx+pxtLUow8VtTj3W2q4AdaNcKIHZoPtxUkVWkn7DfA6yvEIlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763706913; c=relaxed/simple;
	bh=kXMhAazt0uxA4yg1yuPsBKe1Mfi0G9F6GXwrhBbNi7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bthc+d7AZwvQ9NR+piZ/7+viWPOTYLuHOIaJsAWscB9Op96cTFETyi5GGjWnY0pzDbr/85wy6BWJOdsLLEpxh4Huh+96lO6Kh+/SckB3sW6C7cycRLu2aNj9xni/oAUA9eeDzHLqzHblTCD6DnfGGJclZzdZHms9zBnuklOa2hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=exrzOeio; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="exrzOeio"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763706902; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=48Ey0y3O33KKcN2qk5Z3Lr1o4LbwnuPTXJlui7gSguo=;
	b=exrzOeior8XCY1q2JCWU/8P08giDZ/gyRv1ZzXVdjuvpz3Gz2UnPJhM2FXymCLcF2nY0ZfqXhoZf2amYhI/BA3etqSwyF2YG/+ObXxYxMD5ncG9FpH6TpIyTNeBk6vWkIIqVCUSmqwvwf1jixv3oH3IyQZqFfjX2d5iYmZK0v8Y=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0Wt-RZKC_1763706899 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Nov 2025 14:35:00 +0800
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
Subject: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add prefix for XuanTie
Date: Fri, 21 Nov 2025 14:34:36 +0800
Message-ID: <20251121063439.2545-2-cp0613@linux.alibaba.com>
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

Add new vendor strings to dt bindings for RISC-V vendor XuanTie.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f1d1882009ba..5d28b2da94cd 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1829,6 +1829,8 @@ patternProperties:
     description: Xilinx
   "^xnano,.*":
     description: Xnano
+  "^xuantie,.*":
+    description: C-SKY Microsystems Co., Ltd. (XuanTie)
   "^xunlong,.*":
     description: Shenzhen Xunlong Software CO.,Limited
   "^xylon,.*":
-- 
2.50.1

