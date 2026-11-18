Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997171;
	b=Y/ARSJkJiPy3gKxw8mq3AFalKXtssLReoOn8iausO9WxaGxqrakJTDh66qgcMG6Npzq/
	 JPXXBgxgQ5u/l175tXk9sFhKabW9qSe70noOsLEGx5Q27OzyHFAYg7EcQ4Jz0itzOartn
	 /mj4Ei5Jfn1NsNHW97hfaTdhjkKE5ApRa3TjG0BTOnK6e+7fpOO65HYFGcaX5aurm03k4
	 clCY6V6+92SmxXK+KSufLEOBInqpRjKvKPwNatALErc00ZatbnxITjW9UnK7m5325b8Cn
	 +LjaUX/up3uiPj+XMNj3qiaRvFQi0M1KfBxnKlTnXapHLAxbRhEbw9z6w+d2m3N3tNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=NjR9C+m/zvTfHbg5SMxjrHHBlgzBe0tcW4KYDDXsSd4=;
	b=qM7l9tEhezDFnFom0QLBd3FracbQNhaFUMZXMm1RGeofueDAiBPEXSDgGouhNgHbap44
	 XF7Xy3XytPNVI3j+0nqsLegEhhPQ1B8XxXOyRrhhg2OToZtVkep/kva/g+AEuuCho4EDI
	 2w73pW7XAgNbECtfPqZKg2Q+GgDLFmy8loH9J2Hd74zCyDLy9vo1aDA560FrFPXRS0fBO
	 shXd7VtfF6otU2DzN7Ui1iVneXK2WnKYXrw6G0s+HkAjyOJHeqB8Y0fSyeYtsL+2aXtFm
	 uBxb6migv6003Y8ke5mG1597Tq0FT9JxuBKlq8GVEgs6XfBahpKHPsZ5Uoiksmv4n9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--amitamishra.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fpwZlnO9;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D8606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 10:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A80D8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitamishra.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fpwZlnO9
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a064f294cbso740566b3a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 02:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794997170; x=1795601970; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NjR9C+m/zvTfHbg5SMxjrHHBlgzBe0tcW4KYDDXsSd4=;
        b=fpwZlnO9jilQtLL4DAJCq7YOqNOZGys57uTa9iQ0e/cUCnxXIZPnpxhkYZQnDF/xVh
         7jQP4Fx3SpGgaxZ6nJMImICk4dfSLjcCl4Ve6eP0joRCfJN8eKX5iutyFFrH2rNkgLkr
         V/aWw9RRz7VWisDY+TUexJS9Di7UGVrdg+ELsm8vXQCviDj/SuMqROi+MWx74ynjHyCq
         ass1xoaurR7D/35+e1grHqtmcuI7Cb7N4Tu+fmgndjjm0RMnIJyJ+I1al4ilcgDrnjgq
         FDFu5KOfqfNAx1/jtsIztYwHwYSnSykqar/YutAR6DUR5OEzVBL3/os23ezQvFXxZkud
         Auww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794997170; x=1795601970;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NjR9C+m/zvTfHbg5SMxjrHHBlgzBe0tcW4KYDDXsSd4=;
        b=mFqOlFSvrHj0ld2ReMxfLmlZi4E9EiGa/q5Rwx6JCKzSx90cOsyzHPvGEXaMLEgnWJ
         4sfAJ4XyLY7rZ5jj7W0YdKLT4i71iSyutwUYHxQ1MZ55kidVGeFRnzArYYroJFgRUlzL
         ZdI6G4N7B3UxsFGB7Gd0KVl2g0YVnhIwCupNYEqGnt4blkHHdhYOVlEMtGQBrNvoG50z
         gDFF/seKB7pTmr8xeuktJ05ppZV9qF87BaU/ePItWhBJwS95X3XWa3Vu1nsyOxyC+da1
         G5DFcsPcgRWDhepuN8CRe2ULLXcQV16fq87D8KgWVNNbkTKooRl93Kvuwtb/OD9IKjKz
         w4QQ==
X-Forwarded-Encrypted: i=1; AL+hErFIsg+PBTCVsT1+bGv1dxMFdiHa8UotE5DwHs09osjYf8W2YIdgdWIDHI09ZrxA8LVVrJ/MZd/h56iMZqctrV0+@vger.kernel.org
X-Gm-Message-State: APuU4Z82qMKjMzffzokao4QyL6WQK/F6WX76s70REjLA5lbEY8apiQPz
	mtOA8JYb/+vaLi70on20SW9V43fDndV9NEvJOinhE/caqyQEBSFGawDGEOY/U9n6nLCUYsat4se
	xePcpgAkhUiRiWzJ34WYz2MKdmA==
X-Received: from pgbd17-n1.prod.google.com ([2002:a05:6a02:64d1:10b0:cdb:596a:2134])
 (user=amitamishra job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6372:a748:b0:3dd:a197:735a with SMTP id adf61e73a8af0-3fe8adfdd60mr1941662637.51.1794997169891;
 Wed, 18 Nov 2026 02:19:29 -0800 (PST)
Date: Wed, 18 Nov 2026 10:19:12 +0000
In-Reply-To: <20261118101913.3135869-1-amitamishra@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261118101913.3135869-1-amitamishra@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118101913.3135869-2-amitamishra@google.com>
Subject: [PATCH 1/2] dt-bindings: perf: arm,smmu-v3-pmcg: Allow power-domains
From: Amita Mishra <amitamishra@google.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	amitamishra@google.com
Content-Type: text/plain; charset="UTF-8"

On some SoCs, SMMUv3 Performance Monitor Counter Groups (PMCGs) reside
in switchable power domains rather than an always-on domain.

Document the optional power-domains property so that runtime power
management can manage the PMCG power state.

Signed-off-by: Amita Mishra <amitamishra@google.com>
---
 Documentation/devicetree/bindings/perf/arm,smmu-v3-pmcg.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/perf/arm,smmu-v3-pmcg.yaml b/Documentation/devicetree/bindings/perf/arm,smmu-v3-pmcg.yaml
index a4b53a6a1ebf..aea6623bb98c 100644
--- a/Documentation/devicetree/bindings/perf/arm,smmu-v3-pmcg.yaml
+++ b/Documentation/devicetree/bindings/perf/arm,smmu-v3-pmcg.yaml
@@ -36,6 +36,9 @@ properties:
 
   msi-parent: true
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.56.1.703.gf848ed807c-goog

