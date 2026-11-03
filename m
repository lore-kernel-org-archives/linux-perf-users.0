Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793700890;
	b=f42cLq/MkX6LhlEMFT2gDoUiPH22Sve5F7OW0cdF9T5kf6zu2dnm8UWOhMrbwajYbf0e
	 Q3UnP4ltVyotTdmIcecauLHdPXTkHiMB/6V1JUlJDqHnNgrjZxNm9sD1MS1e55f1AOMgW
	 ZA6tkOaeJsgQFddhc6ym7dhXErQtP+R016l/RQbgsJsl8LwjC+266dyxYjzpla33cLNVZ
	 F6VkbPCtVbhwnqfi2ZHQ9TKNeMsgXi1laKH4GqujhbEVWeuFGr0T5PgefWYOGKRSLlTNZ
	 V2e/V5T3hB6p/5FToQ27JXq4MtD2ira2TwfRJxIINJQgFQvfJtNJeJMnL3w8ybLRC6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700890;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cNoGgX+UJiBvCGY47GMUcYG+per3jFnV5URk2F0Da2E=;
	b=mpQPDzP+1lULTUpS6rK/UKQA18+ZcCFcAKgE6VblozpgE7CxHgbB9PWx4V5bC2yYTlWh
	 bhDxXPee016sZKUENWHdrpWJNYlKKzXJ7MWHld4ULp34N/dMQg9VnrqV2iWaDyxtrCma1
	 50ByzvFevCQ8f4tTbsPH82NDSzJOiuTZ1e1hCTQGH8SGOqpZHbm+UMMJJZCsspTcb4mkg
	 0Z5ivkwfsmrrge3Oy2UBOBvu/688J+AZLGFuX5eiciAYU1UA8YWQGr24ykFY/zrwY9tX3
	 A1ji+9JlWYm9iBocn8CfSLTuHw0IvGakpdcqujYVVULKIErphQSiUsvdGaPAeCMhL0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hftTaAF8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6632606A800;
	Tue,  3 Nov 2026 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hftTaAF8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793700889;
	b=0Miq07ZMRLYB01pxwpG1F98bS95cp4MqchTiFq9BQxVjenlLxQiWwbEI7T4CAvCAEdpZ
	 pFba+YfWRS7kA+qWXnIcKVahRvkHjiUwg7lrnw8PL3GlYEEEtAUj9CrXn2i036It212v9
	 SsizlqWD5+oPdmQyz7Mf8g8Fh7ZhXu+/d9ynU5f09vN2yPTxt+sL9S/x+JwMt4azJNKFX
	 SRU3Sa7hWoyIlDiCOYN6pPVH5XGfOVe8K0NXGKqJqEED6h7siIDyoH6oeaTeyvAEGDVRK
	 ulDVxBrAlaInwfCB1hyxG24qkLtftQ5nTcWKh3chjFXkw71t0fNANGSycN8wLrkJzgA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700889;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cNoGgX+UJiBvCGY47GMUcYG+per3jFnV5URk2F0Da2E=;
	b=y8ByIaeaZSg0VEnP8xoVogVMAu8b+lH9AjpniAtsz6fzc8blim8wMhrKuFVK00/bRlVN
	 gEFavoPu2HQSspGyXyagqjjeVGoYW1ipGRvuoM6OeBXfLaF8gZIQyhgBTJ/raJ1LjMn8E
	 xmysFH3AL0jkGY1rHD8zGSXnVrQBX4dRE9PME2+IikHBoWGzp9t2qZ8FhFk5puTijDHnM
	 3eaJcdOERpPn5BNbfNEbou/NGG9kWPh33ID/PBphYJErXaBiBn+8b+IDgl3yLNE8/cO/V
	 qPb9jJKnntMObqncD3Az7T/oiXWftdqfcc+hcPOAnEDqLD7trl7P2802J9C9h66kIsg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 261F61F000C1;
	Tue,  3 Nov 2026 10:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700889;
	bh=cNoGgX+UJiBvCGY47GMUcYG+per3jFnV5URk2F0Da2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hftTaAF89UUS606phWBtcNNu+5QtaWJJyjuRbF3s1pvIOn6ysUq+Tby79f60TepnZ
	 WThhlnzKSOsGl18AXtFK87sWqYVh1eRfVCyRbRwfmrtWB1+ap4kxVpwXnbc0/kUmZK
	 2cKrV/9wE7WeJCG/Y3/Rcx+Jr86Q9xUP3hJIlFvzPJtZv3yR57+HZIFQZg8Av5S/i+
	 oKvWwrWWSNY8KmBQTzb/gFBo1sTsh7v63tS5lNvrfTaIC+JcfssmNsIeREsKIkG9SD
	 pc+Ue4RlXRe9H+h9tfIwMGFWrT5AYHXSPxmG1nflvezmnsfI+tpqH+um5nbQuMhimA
	 xGp1yZZzF37sA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8397B4687E;
	Tue,  3 Nov 2026 10:14:47 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Date: Tue, 03 Nov 2026 21:14:36 +1100
Subject: [PATCH 01/13] dt-bindings: arm: pmu: Add Apple M3/M4/A18 Pro SoC
 CPU PMU compatibles
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-m3-plus-pmu-events-v1-1-a8eb6c1139fe@gmail.com>
References: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
In-Reply-To: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Yuvan Shen <yuvanshen09@gmail.com>, 
 Myria Sarvay <myrialsarvay@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=j1e1lB3ujOCOFCosr6O6hKLnB66STlyve85ZT8PSD4A=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYsl5uEf7beptPf2reQX42teRrIqnXGV+rKHW+2WD95
 M8CI8E3YRM7SlkYxLgYZMUUWfRN07QnszVcKl3mugVmDisTyBAGLk4BmIjRDIa/Mn3Hsma/busv
 rHm2fonITqUT0WwHjx979ufPqf0K+3f26jH8D82afVrOTfDehyv7Dyp/tRZJ+fpWvkdJs+rven2
 VpefmMQAAsJ5OFQ==
X-Developer-Key: i=myrialsarvay@gmail.com; a=openpgp;
 fpr=2F35662B930680D275A645B452444118A8ADFEE9
X-Endpoint-Received: by B4 Relay for myrialsarvay@gmail.com/default with
 auth_id=1027
X-Original-From: Myria Sarvay <myrialsarvay@gmail.com>
Reply-To: myrialsarvay@gmail.com
Content-Transfer-Encoding: 7bit

From: Myria Sarvay <myrialsarvay@gmail.com>

Document the compatibles for all current M3, M4 and A18 Pro SoC PMU
variants. Note that the M4+ are split out by chip codenames, instead of
name for the types of cores, as they no longer have individual names for
the performance and efficiency cores.

Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
---
 Documentation/devicetree/bindings/arm/pmu.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
index f47baaefcdac..c27f06e82de1 100644
--- a/Documentation/devicetree/bindings/arm/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -22,8 +22,16 @@ properties:
           - apm,potenza-pmu
           - apple,avalanche-pmu
           - apple,blizzard-pmu
+          - apple,brava-e-pmu
+          - apple,brava-p-pmu
+          - apple,donan-e-pmu
+          - apple,donan-p-pmu
+          - apple,everest-pmu
           - apple,firestorm-pmu
           - apple,icestorm-pmu
+          - apple,sawtooth-pmu
+          - apple,tahiti-e-pmu
+          - apple,tahiti-p-pmu
           - arm,armv8-pmuv3 # Only for s/w models
           - arm,arm1136-pmu
           - arm,arm1176-pmu

-- 
2.56.0


