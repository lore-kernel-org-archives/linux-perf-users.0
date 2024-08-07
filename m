Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EC813C66F;
	Wed,  7 Aug 2024 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045164; cv=none; b=Sx2k7sHV8ozyremvLQntERa6HaYGMf8KilyP0cNXAcxy8U2XtelR/hnfVYKkPo3/pcxNnEuJqM3JZ3mv8+6RhbJBSYPBrZfE5zpH/qWcNC1OV5zP0gPUU9T/4a3qlw5OEEqsELllszVoft1eeEYskPLZYNFE8hW80JIdgpKtBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045164; c=relaxed/simple;
	bh=MVIxRPaOswQa3Xdpi40A7xdtRH3kCEfhA40AFB41mEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3WAsTAW8fhoMNhq2boVxYS0SzHvP75Ec1A0Tj8lD6ZaHFxhcB5SoFxaFU4ULubZJZ0fTa1WUucfj53+MQ9/fGClsQ7+07VqOViTSP7cNI9ezUb+AGyqQ+fAWMcNoQdypPZ9JraZ8Zl8i5gaSn3bxpsE80IGvn4t9gieg0bf7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgVoIglG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgVoIglG"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fec34f94abso396525ad.2;
        Wed, 07 Aug 2024 08:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723045163; x=1723649963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ge6280gYdYEUDrL5AI92yP7xEDZ/VciZzyHbENVq6rg=;
        b=UgVoIglGYAbaF1CCXEblyGaKngI4tl+TQk/dk7aWU6B6kR9FNk+sAlGajccO6FeouA
         MhppmONIyMcFRwJwGR201pbPdJDy1lm+M/W/S0EojZqYG1Lr0+iSnCnbBNtYUqOdvmji
         trPoyaC1GKaFNZ86KLU+Wl22bkDPC0YqQfFCg45kTZ7UNNkJa2YB8JHR/EcfxCsTN6/5
         wy6x666KrLohoCsYVAfBqmPX5ZhAaOUehEUJObUSRo3nbpRuAPMscv92cPFSOrVxAmyT
         dg17v1vZ7Z6/lLTWD42Zl3BWI5bHOsYstNR3y29RDphm60QWbSTuJvinHlkxoXyBd8So
         RNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723045163; x=1723649963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ge6280gYdYEUDrL5AI92yP7xEDZ/VciZzyHbENVq6rg=;
        b=R17h+9jFVZyAnpWKHvs+3TgisS8/N6Yg1Ct7GDRQ9oC9x5qoHK/uJJ6hh6mbh9jtCQ
         zyk9V7KRKvqhbJ1UMh8z0yrBv7lsvBuH8GKSD+/MzdxmOWEt7VNFUUgdu8OCL8ofpWg1
         ppM4BcAX5EY1G43vNZjnbTEFSPkWKkUUP14VMoKGp9+qP5W+c+TTu9M64/M9N3TYsZjX
         PxDVycS4i1UP1L93pSPjidImuaiswOjdMxaivrKSGTnDW9hjynxkzcHQf282BxCoG0Br
         JJFbY3SLWwXWptK2JDYyE+Akz1Uw6mOGUnl916SQcf/7dNVbnGp4JsEe8c2qQyzbnurC
         NiCg==
X-Forwarded-Encrypted: i=1; AJvYcCUkKeO7+cpZdKiblJWr0WIUijEI1JLRiZc+MWWSB1mxNUnwvnnZvrJnRx6kIudlrUzohFgsmSQLbYU1lZNH5vpzCmOAH3CjOxdc0OTy9NxWK6jToHL8OgW1XprXUndIYcts1G1iIUNwK1YrqBoC/A==
X-Gm-Message-State: AOJu0Yw6+dOcmL9s/H6uHiS0m1e64wgjmmI2r/X8wipsIR5BbwJQU3A9
	2pEwdPHuQn1mdl1Y3z7BWQqscfqpY/cG6KiwZ4I0BuPD86kZObcL
X-Google-Smtp-Source: AGHT+IGgpM9BGwxmxW5iCClXM0iwbOlva9Elci7CAkMF1EscX7uq8vp5Mb9jbgb6YqHTNkBgguBiOw==
X-Received: by 2002:a17:902:ea08:b0:1f9:c3e4:4c0f with SMTP id d9443c01a7336-1ff572c56b4mr185015815ad.34.1723045162683;
        Wed, 07 Aug 2024 08:39:22 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59297329sm108097375ad.247.2024.08.07.08.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:39:22 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: namhyung@kernel.org
Cc: irogers@google.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/9] perf evsel: Delete unnecessary = 0
Date: Wed,  7 Aug 2024 23:38:40 +0800
Message-ID: <20240807153843.3231451-7-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807153843.3231451-1-howardchu95@gmail.com>
References: <20240807153843.3231451-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delete unnecessary zero-initializations because they are already set to
zero at the top of evsel__parse_sample(). If we don't remove them, it
becomes troublesome to overwrite the sample using data from raw_data.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/evsel.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ccd3bda02b5d..c1aac09ad0a5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2611,8 +2611,6 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		return perf_evsel__parse_id_sample(evsel, event, data);
 	}
 
-	array = event->sample.array;
-
 	if (perf_event__check_size(event, evsel->sample_size))
 		return -EFAULT;
 
@@ -2879,7 +2877,6 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array++;
 	}
 
-	data->intr_regs.abi = PERF_SAMPLE_REGS_ABI_NONE;
 	if (type & PERF_SAMPLE_REGS_INTR) {
 		OVERFLOW_CHECK_u64(array);
 		data->intr_regs.abi = *array;
@@ -2896,25 +2893,21 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		}
 	}
 
-	data->phys_addr = 0;
 	if (type & PERF_SAMPLE_PHYS_ADDR) {
 		data->phys_addr = *array;
 		array++;
 	}
 
-	data->cgroup = 0;
 	if (type & PERF_SAMPLE_CGROUP) {
 		data->cgroup = *array;
 		array++;
 	}
 
-	data->data_page_size = 0;
 	if (type & PERF_SAMPLE_DATA_PAGE_SIZE) {
 		data->data_page_size = *array;
 		array++;
 	}
 
-	data->code_page_size = 0;
 	if (type & PERF_SAMPLE_CODE_PAGE_SIZE) {
 		data->code_page_size = *array;
 		array++;
-- 
2.45.2

