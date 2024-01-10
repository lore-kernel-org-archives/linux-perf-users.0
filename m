Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2F73EA82;
	Wed, 10 Jan 2024 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESMH/sf+"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d54c7ef801so5020485ad.0;
        Wed, 10 Jan 2024 00:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704874345; x=1705479145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdLU/U7TSYkmEg20IDPG1xvAMQzbpbdvIaAXCBEqQ4o=;
        b=ESMH/sf+RRHlA+5aajuRYZ+nuZJWG0bq1S+YEuOMK63urN75ziuzteS+3elYqhCW1C
         +wUG1K5Wn4zjw3HoMGueYDM6sKsrmCtYKFWkuWyMtRvi0gec3BLQ053QiZGw9vHzlLbN
         0b+drW9S59v1RkF9JgnLn1E2kaBPYj2udNtAq7Ikl0Ifjwn0kkLhRCYvojfv6IEduSmZ
         qgC4eT3hMLQfiK51Tr1kUnrX+xuuTwsQfaH3nHn0ofxzd/Q0i+rrEqC06dQFxQM5qugX
         5o6y0eO3u9Q+znoiP2qS7Vp+WTXABRCD0gugmR1DuplF9Rs+J66w7/XPL06KZmZY69lU
         KoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704874345; x=1705479145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdLU/U7TSYkmEg20IDPG1xvAMQzbpbdvIaAXCBEqQ4o=;
        b=OIRT+0iNnJfgHX5tm+Xb49WoFB3zdyGsEaaTwucQs2AZu2SznpbA6Wrx3GxPo+yW0t
         XF+lR1z8uaFrLigqfJ+SjzjIiko5sGbomImnGkX/2SL5JGzYOxcx2KPSyLsJhupnkdkq
         KgDd0wqN4IHqk/ZVxfiX0Ncz9P9+18wVYkbxMs5ugQfCPOpWWrxSOm0P3bCwRcVLdfFQ
         5OtPjNZ09oxUwuKpFq6R5pPtbMtTh3xkyr4cRqW60WxSNV9ugTnCvf1sFYoSxTOrjZXV
         rADHpEcXsvwapL7jrRguvXnEKg9dno7w/tLu8ALMCnZGWzgewKqjWoHhNrPxdm5xtmlr
         iXTQ==
X-Gm-Message-State: AOJu0YzwNMAKYi8HXgnu2tyacUDiBCxqZN9gc7bl00Jt/D7Ac5v+Lgod
	Fp8hesCTu46jJwTqOF2jhgE=
X-Google-Smtp-Source: AGHT+IGhot4iwi3m1yLqxzOhmtU6B0eeF2Q4Mt3OnQKrQybwteCJEtqqeNLgCiiTVHFo9tCuL/z6mA==
X-Received: by 2002:a17:902:d50e:b0:1d4:e665:c54f with SMTP id b14-20020a170902d50e00b001d4e665c54fmr1172366plg.6.1704874344734;
        Wed, 10 Jan 2024 00:12:24 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902b68c00b001cf51972586sm3044243pls.292.2024.01.10.00.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 00:12:24 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [RESEND PATCH v2 1/2] lib min_heap: Optimize number of calls to min_heapify()
Date: Wed, 10 Jan 2024 16:12:12 +0800
Message-Id: <20240110081213.2289636-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240110081213.2289636-1-visitorckw@gmail.com>
References: <20240110081213.2289636-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve the heap construction process by reducing unnecessary heapify
operations. Specifically, adjust the starting condition from n / 2 to
n / 2 - 1 in the loop that iterates over all non-leaf elements.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 include/linux/min_heap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
index 44077837385f..18a581310eb3 100644
--- a/include/linux/min_heap.h
+++ b/include/linux/min_heap.h
@@ -70,7 +70,7 @@ void min_heapify_all(struct min_heap *heap,
 {
 	int i;
 
-	for (i = heap->nr / 2; i >= 0; i--)
+	for (i = heap->nr / 2 - 1; i >= 0; i--)
 		min_heapify(heap, i, func);
 }
 
-- 
2.25.1

