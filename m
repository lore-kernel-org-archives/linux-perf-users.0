Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0A413DDC2
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 22:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721861673; cv=none; b=a/0BLZgikRl54XXiY0+soSJAOdPDVVISszd7OAU6X48JkvHfw/5W+ScX+f2TZrXk4XCQsDQ4NlnjrxE8RUkLwRq8n5UcW7/4vAUR2ezqZgI2QuPe/y2d1K/It5nS4FLsToHhciQ2QeNn4jV0qSMb/hCbxv6raA3eUpCKVfXmFFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721861673; c=relaxed/simple;
	bh=4M35RJ0MrhFzvtO/gpzcZAZGyvkPqgVAOXcftDMuvps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NmaKYTei3mau8JvtyEezOjLiN006MJnXhE8x0TM8KgYXNa594EeYaL6jL7LMHBNIk+2oiDG24pAokNxP/+9bX1IR9hwaeUKjxO7LNjalTY409DtzCMA+EDkMmaU8vdWrneNzUKJHLCY/OQozCc3+7g9WugAGCd879cWiV3sOFp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oI/1eCgE; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oI/1eCgE"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-70446231242so128539a34.1
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 15:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721861671; x=1722466471; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSkmGq7ZrZbXdHouXcfFGOgcX1f8uJ3n8uj4r7vA1PE=;
        b=oI/1eCgECsTYCFEA0gQCJhXJ82oFmmIiP04yF7Fe5eVU2zyiHJ+yyX/uEMtzPNwSIz
         +UjB75/bMxLwy3ShA+p9pgkbwyuY1Ythp6O5wKE6Zzg4+fJiV5u1RQ4WoDfqlX3GSD2J
         YBzY4pV6zLXcyqBuFxie0xqnzP8UTDQdkgckkqXmqh/E2/NbM8VZLtMrWp8IBQaRFHpa
         RZec0u1CZSr16Lkf+jMGPxPWCuLzaH6Q4i5elCeR6pUfe64lsZJbggOvZkBVZ3ytBmTR
         huEirdnB1u7dIOslpeSer/oKuVkk/7uMQHeg2nF88sP1HG7kV1rNjGAiwEgRk2f10RBj
         2Iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721861671; x=1722466471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSkmGq7ZrZbXdHouXcfFGOgcX1f8uJ3n8uj4r7vA1PE=;
        b=HY3WBOCe4jT9DYXW7692t4FmttDrhrPjn8CpCzTKGN3RnyxuDQLUW/xgiEXt+GoL1u
         aFmA3ftQaKpwvpE4kuz0f4hV29oxmpUz5B7xbdByYktLdkk7ObSGsuAndhS/DxmNWTPK
         EQY0o/3zvDt6fEjyWm1+Y+5B1pzUBeKYcZq95OETxUacyDJZyfhLiKrdQgN+F4LPQTeF
         T12nnQRkpdK6jsm/8Mu0/lPwwtCjiJZiPB3FGDicl2oVWfMb2/etcze60ZcnWy3g2Gdg
         AF8bz0vCWdhc6fKJjLQTvG3+Fx1VWm69uHAo/XAzed0bQf12hIoQYIY3ltDPvonzl+l9
         pSqA==
X-Gm-Message-State: AOJu0YynQY7kcVC6jkxUAQhcrrcF/Z84YuwK35QMQJZ2Mx4B+o+lCgvA
	7S02f0JplqlWLMy3IA+PTEQuscXRgNqSEjJmgxQYG4MYZkXtpQ9unZyg5u9DC+8=
X-Google-Smtp-Source: AGHT+IEkOVbZUMgs8KjJIn54klAlrolAUh6zjRu2D3dQNCcUv5496n2AzBl9GvX9rDRx8tTdsQtvTw==
X-Received: by 2002:a05:6871:6001:b0:260:fc8c:2d28 with SMTP id 586e51a60fabf-264a0e0b39cmr1137866fac.22.1721861671250;
        Wed, 24 Jul 2024 15:54:31 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead874c6fsm74992b3a.165.2024.07.24.15.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 15:54:30 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Jul 2024 15:54:12 -0700
Subject: [PATCH 2/2] perf: Document PERF_EVENT_IOC_SET_EVENT_LIMIT
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-perf_set_event_limit-v1-2-e680c93eca55@rivosinc.com>
References: <20240724-perf_set_event_limit-v1-0-e680c93eca55@rivosinc.com>
In-Reply-To: <20240724-perf_set_event_limit-v1-0-e680c93eca55@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Atish Patra <atishp@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721861667; l=886;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=4M35RJ0MrhFzvtO/gpzcZAZGyvkPqgVAOXcftDMuvps=;
 b=Ft1lYHdZdmWJU19FBYN1LMTLSqpqK9Wblkotv6+rB4MEMMnCzwlA1VGTJPEZ6Ma4ZEXBf2s4b
 gWs9Eg58Rr4AyJkOjYV2FmoT85V2BsuXM+5lI0uCnMS6HfFmTK5vsvq
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Introduce PERF_EVENT_IOC_SET_EVENT_LIMIT and explain the differences
between it and PERF_EVENT_IOC_REFRESH.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/design.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/design.txt b/tools/perf/design.txt
index aa8cfeabb743..1626ae83785a 100644
--- a/tools/perf/design.txt
+++ b/tools/perf/design.txt
@@ -439,6 +439,11 @@ Additionally, non-inherited overflow counters can use
 
 to enable a counter for 'nr' events, after which it gets disabled again.
 
+PERF_EVENT_IOC_REFRESH will increment the event limit by 'nr' and enable the
+event. To increment the event limit without enabling it, use the following:
+
+	ioctl(fd, PERF_EVENT_IOC_INC_EVENT_LIMIT, nr);
+
 A process can enable or disable all the counter groups that are
 attached to it, using prctl:
 

-- 
2.44.0

