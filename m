Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33271C3311;
	Fri, 27 Sep 2024 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463248; cv=none; b=ExS4W3hUcxnMoxtmn40cKVFvaMkNGTmwERcUufjz85dY08T5+qCpJ7dDzZb3AXn7C6yDZT/YMfUwqaLLTcChcHy32yMm/MjdcauKbjQULAVKI2PeDlO8scKy5AiX7V7iLodbWEROzJsVTk3nRl1pdX4OkJ7U6HLGUS4qDbQ3A7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463248; c=relaxed/simple;
	bh=BfKLXsdD+x//Y3ebfcycwHplNHYTY+Xgi8RSHLfMrc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPE0TUCGTH8x98NMb6+jThSTu+h5dT3OdpIb9N2GMMs+dsKiIj/CwxBu/0psgNT520RJPV2xeP8x1TkT3UVK5wHfWcB0b7ABhay1MvVyJdjhL+fx+Nm3uRFjfdeVVsPiXGpTkib7FQNGmIq4iuK8e0nwLb3JOZXmiXJp2FQT1zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWhz9m0f; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWhz9m0f"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7179069d029so1845292b3a.2;
        Fri, 27 Sep 2024 11:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727463246; x=1728068046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6D5uxLLs8a+eADmi1psHFkftjw0ias/dpesC5XMo5zY=;
        b=EWhz9m0fWuCmgj/el1egnxH5RyZJFK6C0yDrQWSI1XddrvfC4RudzqS5h7LdXqx2r+
         i0Locl3uZLHPZYfS5GIYjWSpGcDOEHjuaZog3MG+C3gxoK4do4MsENku6MYd9YyRaQP5
         T5c9AeenHkCO334GE3brQZUzKGcXZcT6Hi9IFgMdTQrwV1WDxkZM5HsOvl6n4KPFWXL8
         3dtt3pwBFpscvw4+P+cE8CV2axxQ0ORGzmsgZjCa81t/uFQvE3UvvwMcRHXSX1icw7Gs
         ZXY3co4hqpwcAP1AcmaCye2+mO+Yc+Sq+2lVyjdaav2h0oEvoLlu9nuBMePvMSDuZIEV
         sdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727463246; x=1728068046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6D5uxLLs8a+eADmi1psHFkftjw0ias/dpesC5XMo5zY=;
        b=M/kdLmjLE6xRz40SUZ8pxwsPgWGLQ+QWCjZeHMUTKqSF4cpN+sr82NpR5ijGdp5CdV
         6Xrs1KAm672rUnrH34F2+tDbSFhoI6rGhHZz3TlschhRyb/2qqH2XwBUqacLmPOlzFG0
         /u+pdDvnzseZ9XX4GGWAXn1fXgXGrFpNeD0HLd+s93bUwv99C8cNtzfjUiBfT3ox8MKn
         XqbmNQs0oaFGPuYFBMvs5QDE3x8cDKYlKVoNuFXFuvpAK6Al5RECLfT1sGust3r1L7UC
         mxtShw1WP5fF469nFlmQiaNK2393tJCE4aOeq/h17ZzCHkPZTo5B0NhkPttXi1Q3wUwu
         56Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWrj3Ux0yBgE/RTfFTux6m8wt6JcZeScw9D6yNCnuUDqeo3VR4OR/Pw47PkVOZtSoCgQ/LhCxca/x0f8PHSc4IZkg==@vger.kernel.org, AJvYcCX5qEnU6RPAG/XrK1dCOYU7xL1yHQP4SzZQCUQzuKZL9RW3FwF8bj4KRmtA3NuGAOGEjH6APPHIJpUHxys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzetOcWfTohKFhFGWzBlopFeZz3ArOmkSyJ3I+w5MI7rM7/Uynr
	SchDAUW0/Oq2kcpSH9HygIwH2NzUvbEN04ZOdufTYZ+eBau+aszK
X-Google-Smtp-Source: AGHT+IHrbCVEEqGTZ8bZC2jc1QIYHcrzuf434sFSyUvR+qhiT47QXKTbyasJ/1lOz6W6LlrFacpQ/A==
X-Received: by 2002:a05:6a00:1304:b0:714:1d96:e6bd with SMTP id d2e1a72fcca58-71b25f6a9d1mr6467553b3a.13.1727463245839;
        Fri, 27 Sep 2024 11:54:05 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264c23b6sm1930244b3a.88.2024.09.27.11.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 11:54:05 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v5 6/8] perf evsel: Delete unnecessary = 0
Date: Fri, 27 Sep 2024 11:53:38 -0700
Message-ID: <20240927185340.658143-7-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240927185340.658143-1-howardchu95@gmail.com>
References: <20240927185340.658143-1-howardchu95@gmail.com>
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
 tools/perf/util/evsel.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 500ca62669cb..32196e4f0637 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2965,7 +2965,6 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array++;
 	}
 
-	data->intr_regs.abi = PERF_SAMPLE_REGS_ABI_NONE;
 	if (type & PERF_SAMPLE_REGS_INTR) {
 		OVERFLOW_CHECK_u64(array);
 		data->intr_regs.abi = *array;
@@ -2982,25 +2981,21 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
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
2.43.0

