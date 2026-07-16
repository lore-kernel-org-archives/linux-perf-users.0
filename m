Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8938F28C869
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186650; cv=none; b=XTB81g+8OVLG+pL+CMHwCB2y7Qu4PN50/BMjNpawx3TxBf0voZkNo+bNaUOcpWmC++UjLoR5ggDNC8sOTc99HfY+77iRJZuY7/NQdK++3LKVKgtfUhesDhOl0Sgm2NFVgtodZAJs2IBhUm46wBouxylhDvv7ChwwAJRf8AB2XTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186650; c=relaxed/simple;
	bh=Hpr6Ct/8cmA/RvjXjYpjIb5OutrdWty5c6ypp5NhzYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u4VTjqOjxQbwimaidJ+yMALvpP7VcI8N9hnFMefsTCYK3aVeURkh1GvMMUDu2XUaoI7tg7lTqpD/AcQKHdclUdWebKW0t2wqhzDkKDSyCjPy6KZ/8wgQ3YQmeLA2wQrfvfPm2eB2eHD9/xofGQywKXeo2xR/uw3/BOIx/B50CQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sgxOfdQe; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sgxOfdQe"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cc77a6943eso67791785ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784186643; x=1784791443; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ThQuhkxcEsJtdmQKEs0kN6Aw6E7LaJ1AsEbBaK+sHgM=;
        b=sgxOfdQedgeeLG6gufz5f0ORkC/0EUgc1getB9Ls7Vds/IFNpoBJv5T9tk4OF7AQa+
         Rs6ajM3NDEL2XY+oPbISUKOWuAIDUIHojO3DyJQ3PNUbifylXty/9etQnw6O77fB7aTp
         zgsRUzqqas8HyWlMMHjQHXsnyZpENQ3q768oIfQlWZ657iAewLl3UGM+EGijMT8A3zgc
         99uLDSedLJ6uBAKk8gLdU49LZFllTabhZvnQgI8EpasgqqPjUGFpL5P4uHK7m65qFGEB
         6SBs9gMvOlqAVNJardkgLiwI+ebHNwe5n13/j8Vs+j0xx4jWfHi7Mf48s430NI5TpEzo
         oqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784186643; x=1784791443;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ThQuhkxcEsJtdmQKEs0kN6Aw6E7LaJ1AsEbBaK+sHgM=;
        b=LpmjVCzSVAs38GjCQ6KJ5T8wm3M/xhOb/0wbUYAueYkcnMOQC/MgaBA3/vboBmfE+6
         FK1icfYlAE5jNFaSnRi7VQONbhqupYUdgZcLAAT+x+3JlYQhSfCBMHuQ1tN2IAuOjq3c
         SIhoeXEyfTJsTQug24t7o5VeDGT4Dp7KUlxTh+8Uzpu8XPC1vE8FUnZJ37V6DFRV8Kh0
         TdcTFiBJc4EeguCg35CmYguaYfLSqbLaaPwrlkFTNIVNMSikrVGixHMobz0o760+Tsf0
         FbWpiGjUA0SspFejTjWmOiScixAVkosKH8cSGFjryOHm3QXEDluaHViV+iP4WiPH3+ts
         uw1g==
X-Forwarded-Encrypted: i=1; AHgh+RpTcIMHcc0gLkct/6MpZJA66cl4logoYO6AO6P4um6uEmoj4iFC5G8/VYIicIEgC82BdSWEP0etNHCWutS1/mUy@vger.kernel.org
X-Gm-Message-State: AOJu0YxzEUFsSz1CVqao7bOvHN8eildaob7sPQhXlCPV+H31u5F2cEY/
	SWVOQBIVkzNN4Q5z61PxvgLi9DgFTDk2VLNd9PO1VpeajvXs1tTxJ1JFzcQ8htQp8+3tVlrkEB0
	596idOy5ZQA==
X-Received: from dlep17-n2.prod.google.com ([2002:a05:701b:4591:20b0:13b:279a:f57])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7350:b0:3c0:9c1b:d0c0
 with SMTP id adf61e73a8af0-3c110a5070emr22624181637.75.1784186642689; Thu, 16
 Jul 2026 00:24:02 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:23:46 -0700
In-Reply-To: <20260716072351.560311-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710053628.1861645-1-irogers@google.com> <20260716072351.560311-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716072351.560311-5-irogers@google.com>
Subject: [PATCH v6 05/10] perf disasm: Fix potential NULL pointer dereference
 and use-after-free in arch__find()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jistone@redhat.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

In arch__find(), if the architecture's arch_new_fn[e_machine]() returns
NULL, the error handling path attempts to read result->name, dereferencing
a NULL pointer and crashing. At the same time, it invokes free(tmp)
BEFORE updating the static global archs pointer to tmp. If the
reallocarray() call moved the allocated block, the original archs pointer
remained active but was freed. A subsequent call to arch__find() would
then pass this dangling pointer into bsearch(), causing a use-after-free.

Fix both by printing the numeric e_machine ID instead of result->name,
and updating the static global archs pointer to tmp immediately after the
successful reallocarray() invocation to safely retain the valid prior
architectures.

Closes: https://lore.kernel.org/linux-perf-users/20260709035721.9EE901F000E9@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 0a1a7e9cf3ef..6cfdbabbb8c7 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -180,14 +180,14 @@ const struct arch *arch__find(uint16_t e_machine, uint32_t e_flags, const char *
 	if (!tmp)
 		return NULL;
 
+	archs = tmp;
+
 	result = arch_new_fn[e_machine](&key, cpuid);
 	if (!result) {
-		pr_err("%s: failed to initialize %s (%u) arch priv area\n",
-			__func__, result->name, e_machine);
-		free(tmp);
+		pr_err("%s: failed to initialize %u arch priv area\n",
+			__func__, e_machine);
 		return NULL;
 	}
-	archs = tmp;
 	archs[num_archs++] = result;
 	qsort(archs, num_archs, sizeof(*archs), arch__cmp);
 	return result;
-- 
2.55.0.141.g00534a21ce-goog

