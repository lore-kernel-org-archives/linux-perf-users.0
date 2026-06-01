Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C491382288
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296881; cv=none; b=XA0OtON1exOdaazpEhMimxOXNKsN4hFJpICHf3uaAEn8O5vaoWc2WVPOnjuY+YP9gowsqqIfx5QASBKTUCUiOCjjTycyZVuig2czNik4sw+MNQMCcHmfBWg/W9RzWZAEnJv/n0yb6+MLeJRWxScpPoJNc5rPojiHKo2lZR6cv/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296881; c=relaxed/simple;
	bh=q8F5fXyoFYv4Qz6hTTwJfP/908BeEKRkibPni3u/nVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bU2L6D5OeId4zK+IWh0xudeFeN8mQUhl7mQCa4VxpIWc9Bgnu+p9i5y6EwrwZqvZLDw7Nieon/zSl3cZi6bzFFVdOf3xi8BnbOpDMHZaeUTyNtcnpSZkCrC2X8TEqRhHMGhhiQ5AOOgIIdtUcO0gNaGovu5PguXejA/aV7HuPHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GlX1ueRQ; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GlX1ueRQ"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137dd3a60e8so1236732c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 23:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780296879; x=1780901679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p3BK9PCy7aBGu0lizAF2iiEjPcXEwff1QpswcRMbmnA=;
        b=GlX1ueRQ9FfPohjCKa0zwkefZ31FvEj8PWvm+FRN0Myed/tRc+wyMIZzPObgbZ5VgP
         yYnfZo91sQG4rhBJg4KJe1sO/lhZUQnycvep5t2OwM8N0yz+JpAl4116br12fKdi60+g
         3IG5Ef7VdUqbUYURmox90H09xTj04Fn7Idqp1taAiy67tyjzUz0luNEYe/wS+U41FowH
         oiWrXAVL9gDooxDK7PtNy5TOidy/5vwmG/0Jbphty9e9vxsxfwF2SOnqMI+JyFvY4zTo
         1+uU2IkZUn9zpjlYn3x3S4USFo275w35HLFLV8HfEcJVfOJ+mZbRpucmbTDcoZc6raCf
         4aJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296879; x=1780901679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3BK9PCy7aBGu0lizAF2iiEjPcXEwff1QpswcRMbmnA=;
        b=raAWsprcA2Xd2hEg2/tywMoNC6b71KnTF972bTsXipmTJeQrueZNX/kquNsdGHExng
         yL/IUYvLopshyRtqEVlXH4DgbaqlUIchpUc26qIyzBLqYmvv2OqyV92j1J6o4pRrUdnS
         01m2iJ8AN51/v1N6x60BAvs7B/LOFMf50MGTf5ur+wjv0jiqd5CRiz3GWzL+yMVdGp2j
         +4QcKFFI8SUsdjiQ33vIeVaIZqo9HB6d3qFJ5lyxtEKLm5Bo0J5v/T31Ym43NWqtk0Zt
         1zNTH+MfLUuTe5+Gxsg6AfzUAXdQL9pILEgD5b6s/1QVUUwIeNrD27f35gXM/XwBj0+w
         NdmA==
X-Forwarded-Encrypted: i=1; AFNElJ8iX5vbPeAHfwuYcx48+R50atniEcgntqzZLZIXp4HZWJv0QWVVgvMq6+8Tku1ZM5Y6ahSKMAmVmqpFodHWwkjK@vger.kernel.org
X-Gm-Message-State: AOJu0YxzdXkpYUVXSVD7u9CWLbnMiBlxY/rgBztjJwY0pVnuowxCBFpX
	uVNu7Tke77PsDqeXcchpjYbPKFOWGld47kO9/j2GbrXnHoxubXSsNNrlGrwqsN+7WPS8A0J9WO/
	+nkpxlrYX1A==
X-Received: from dlbqq4.prod.google.com ([2002:a05:7022:ed04:b0:137:ea37:a378])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6192:b0:132:956b:3a3
 with SMTP id a92af1059eb24-137d401b909mr3976817c88.10.1780296879243; Sun, 31
 May 2026 23:54:39 -0700 (PDT)
Date: Sun, 31 May 2026 23:54:02 -0700
In-Reply-To: <20260601065407.1597927-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503002248.1040791-1-irogers@google.com> <20260601065407.1597927-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601065407.1597927-14-irogers@google.com>
Subject: [PATCH v10 13/18] perf lock-contention: Use perf_env e_machine rather
 than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use the e_machine rather than arch string matching for powerpc.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/lock-contention.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/lock-contention.c b/tools/perf/util/lock-contention.c
index 92e7b7b572a2..119a7206f3cd 100644
--- a/tools/perf/util/lock-contention.c
+++ b/tools/perf/util/lock-contention.c
@@ -104,7 +104,8 @@ bool match_callstack_filter(struct machine *machine, u64 *callstack, int max_sta
 	struct map *kmap;
 	struct symbol *sym;
 	u64 ip;
-	const char *arch = perf_env__arch(machine->env);
+	uint16_t e_machine = perf_env__e_machine(machine->env, /*e_flags=*/NULL);
+	bool is_powerpc = e_machine == EM_PPC64 || e_machine == EM_PPC;
 
 	if (list_empty(&callstack_filters))
 		return true;
@@ -125,8 +126,7 @@ bool match_callstack_filter(struct machine *machine, u64 *callstack, int max_sta
 		 * incase first or second callstack index entry has 0
 		 * address for powerpc.
 		 */
-		if (!callstack || (!callstack[i] && (strcmp(arch, "powerpc") ||
-						(i != 1 && i != 2))))
+		if (!callstack || (!callstack[i] && (!is_powerpc || (i != 1 && i != 2))))
 			break;
 
 		ip = callstack[i];
-- 
2.54.0.823.g6e5bcc1fc9-goog

