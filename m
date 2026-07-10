Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622D835E1D9
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783651807; cv=none; b=V+ZQ8rrheXxit/cVxxZgcmcnbFBnKxhy3sma7ifB3nCbscYe2VFLK3K3Q+UGKiNWMxIItIhUjNkNwIzT4+K3z/baAdGbuoOnfnL1BnS4h+4Z+OhaNLmte1BXuwJC8UMUfCiA4/4B/TsXMLfPi9gJo0kVfQiHf+VdBBBrd0RDXxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783651807; c=relaxed/simple;
	bh=SQMZd0/JTv7/ke4j0fldBwIAE57DdyFJQTMdZf40glg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XELb5Uhhz7sp4nWEH+t+/mszBYlgRuIr3Y8L7rGfzMX6evJCeXfn7eZj1ooT1z4O7EgP3Zv0Zy//5bRRZag4qMtCfymdUH2V2PpfW3937FmHPuk0swvOmrm0wE391L6lHcGsYZ2J35O/cfmzAH0vYKatmX/iMW7/CmDIcUM8hAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lNYoSscW; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lNYoSscW"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cd01a14e81so5850715ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 19:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783651805; x=1784256605; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qk3BfndcOOfHmgQUeQDDoPMTMcTvyVlnIzCKYI7XOqk=;
        b=lNYoSscWyC2Ttljwz+7gOOgUWh1a0qAfv+S3yHWRaZ6mZe/bvPbkz8ghrJJ93gTjnR
         Qiw3AnLI8v9AzDP3NhieDEmu4unSeZqWLdtHH0/OiiG+kj3OskSllWgEYRvehsnGBNjp
         Suo1Xilx/NnYfmpzXZjMP7Z3wKiPuRaGDpNzeHXKgwwHdZ3WXBmY+igpQEKJlLraoPob
         xw2jmMTicwXDdYCdHu4guwgMzLgsCgP5bb6cIrRaBd6Ue8qoGUKbDEK28vETrEtWQVFZ
         G8OvIcts1DXUw6E3ceEyujH1UFoq7x4L/concWXr59BreCBnT2ZPX8efABQyDbzzfFdj
         YUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783651805; x=1784256605;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qk3BfndcOOfHmgQUeQDDoPMTMcTvyVlnIzCKYI7XOqk=;
        b=Lv8IfLdNCc2m2g5yGEyQrFIUE+4AkUali5d5c+RuRuX/KJH7ZKZd5oP8t0zb0ccqBQ
         bpsaxeXYnTPaRnaDtxFxWfdtaRGBepWsjbO1q9B8VXZv45nlV794fyMdRqOrRWFnyIzP
         96zj7LzR9WljCiRs3SakJoOcMJ9vyLwDJtQ6OPzmQm6VpVq9KVRO3Nyt5R0/AAkODQNQ
         P8ht8UN52kCB+jP8orTFNLEu16Mr08pDq1PPbE0ttuGXzlkX+ehRgJ2ur54E+Bl1l3Vz
         GDFoL0QyYdeGisW9NiZyyBF69ElSVK+qenLJJFttmHZQ4X5QAD4kP4l9G0NdZNqtZ7ae
         9buw==
X-Forwarded-Encrypted: i=1; AHgh+RpOSnIScRJQiO1W32F/tmcRJXzOc4dsagipP9FbJMuGACT7Nr8qyxYt03JSUj2j//IibymuNtRN0/Km4Bvu28+S@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/5srUKbNqAUbPCONFkvMdrOi2rS4zUzo0m+5sAeLC7ZbGXOno
	bt1noJSPmubUXT/Ao2jL8+ux390IRPVB6HBSFcvolQOj8v9pzN8Twh+vyibVIia+uUq8JvFUBHQ
	T3KjYpObZxQ==
X-Received: from dldyr15-n2.prod.google.com ([2002:a05:701b:450f:20b0:139:b637:8de6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4506:b0:39b:d937:8020
 with SMTP id adf61e73a8af0-3c0bd0f9e18mr10476203637.42.1783651804341; Thu, 09
 Jul 2026 19:50:04 -0700 (PDT)
Date: Thu,  9 Jul 2026 19:49:46 -0700
In-Reply-To: <20260710024952.1668911-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709165220.1411149-1-irogers@google.com> <20260710024952.1668911-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710024952.1668911-3-irogers@google.com>
Subject: [PATCH v4 3/9] perf disasm: Fix potential NULL pointer dereference in arch__find()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com, sashiko-bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

If arch_new_fn[e_machine]() fails (e.g., returning NULL to reject an
architecture or upon allocation failure), the error path attempts to
print result->name, dereferencing a NULL pointer and leading to a
segmentation fault. Fix it by printing the numeric e_machine value
instead.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/20260709035721.9EE901F000E9@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 0a1a7e9cf3ef..5b114f089d56 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -182,8 +182,8 @@ const struct arch *arch__find(uint16_t e_machine, uint32_t e_flags, const char *
 
 	result = arch_new_fn[e_machine](&key, cpuid);
 	if (!result) {
-		pr_err("%s: failed to initialize %s (%u) arch priv area\n",
-			__func__, result->name, e_machine);
+		pr_err("%s: failed to initialize %u arch priv area\n",
+			__func__, e_machine);
 		free(tmp);
 		return NULL;
 	}
-- 
2.55.0.795.g602f6c329a-goog

