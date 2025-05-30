Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383B320B80E;
	Fri, 30 May 2025 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748586257; cv=none; b=l3GuKbI2jlNM7W7BFKTUCgMouLbLi5talS0pNtymuNbidIcIbSHBbz5H2sJHwMdyTBy80SI2UE37MFYFD8RoFv1i/d+BLYJS0+aLPp5wUUWKqxwxblqL7WbbGGpn5b4AQFtGlyV2/bWy9FlYiz6NmbQlwcpj99rkTAtK0SRuin8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748586257; c=relaxed/simple;
	bh=rsHqclV0wwJ+jYvaB6k+vgMp1oYs6c5EIO//r1OUdho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkIWU82YKORQEXMWRnjFsYFZMkjdCTHPjn+jPQIfu8s/95Q8IWZFO46aCSxH0tssCM9Y3XHKxd/4/bz/JiTVUAnVNevnDGQDjN4qYxMI3zTGCn8owvB+huvDmFiwHhIY6YssX7HOaGQB4UKtxFl263I7WFMoJrNYYRfGB7PQBz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2du+f0Y; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2du+f0Y"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742c27df0daso1376906b3a.1;
        Thu, 29 May 2025 23:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748586254; x=1749191054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwHMlGLBbWMktCeyAIGsdWrLp2OXZKXa5jc6etwR3FQ=;
        b=G2du+f0YOPaCDagqvwQ2pdBrTZbLrTFSEuLF44q35zVskN/Wc+3RbFIvyZPUtUW/kh
         FWXtQjNu8ry+JzEEiSfhPy+9v3UbWSQMmowxdow4hfR/Mm3TzP067e0z8CjqPnYR/INv
         1ep7ax4r7S/reUbtE4mgtF8IB8RegY9GU6VzrE42Hnn/BWPINk4r9Y7zXy6ZqDwgAjV0
         Ufz8PKbnYpM2QnHjNjTNs9utEFh7ZbVtaNRml3ktKtfRdZ4sHhOKAlcdQKa/AlGfon9g
         4OrOFiRDvzGDGRK+xxHkJPQHA18upQsRNeKB7uf8bH5Vco3uW6Mcbr59aa1HYJHBVXl0
         XElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748586254; x=1749191054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwHMlGLBbWMktCeyAIGsdWrLp2OXZKXa5jc6etwR3FQ=;
        b=NTaRoXk7VeuBJ0ei+VQBT7qne2Ha5Ap8qR2Eg7T5zNCuujT4SeFh6HUOYjp+nW0QPQ
         u2qfX+GhsOpRbyztn+69uH2NGku4PxLy7suF2y5Vyhh8Wg06M7Zx0j/s5DUiS0h4Y+7Z
         9dB/GZoifyHwBuHt8dWevwcSvA7HaZlqmtwpFfzQtCAVgNMb0f/yYsG0qwyzo2YeM3KB
         kkBwNaMrf2HWFMs1cM9P8OZwBWAwB8uuA8eH2GzbKjLRPF5ak3dP7qno3UkJf/yOaz9/
         5DJAV2b2tzFFh8j2l324DIbInqoyfaVbulSEG1GRa2SJ5GHTFbgOw+3qz9TviM9f24AP
         cQlw==
X-Forwarded-Encrypted: i=1; AJvYcCVR68ZkOKfIGSfaKY7NMe911LaCcahDbYu0HkOsAg5exBmoI/Kv/U6ZJTG62kXAWmz5xPzEYZEgb0YF+UijLdKU3A==@vger.kernel.org, AJvYcCVbjgcuKVVfAqES9Kp7VFzv9W7qGxacTI3ruwsikPJG0Zy0kzGQ+EunHSA/4jBYPJvEP0eN4zNwA+TBrGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnVkslqZOCRbQCYLDbf3bH2FiQqOAZJJNXRY/KnfoWDs8bA3/N
	lksGwTIupz2F/fN4MkS86g6vUTPxyWaQyB/KxWOPFgp280VRIs3i7cYN
X-Gm-Gg: ASbGncs/RCDnIDWjAbOytAra1o3mjsjKp9N4qgiG9hKwHfK2x2xrUX5byATLi1hES2s
	uGzy2WSDk8RHw+Ac9NsQHh/fFCVK5b6pFMbwn03fbwDM2KgfnIhyk5679evAkRZVb5+AKypC6GI
	vMi9AhSgqoFRDCub6tmxRRk+bTSGH66PNWJDH4VP4lCzAuyFvJBeCMv1bxfI9c1Ea1/ManMwQuW
	uQG7r2FmeROm95tJ2KbX9f6nRnq7Cio0aNa9QsdVxcHHcMqXC/yn5Fj3Yh8mG1LLnLCi/8lOCQj
	w15g21lDGbjmIOZiMKeFchUHldIa6GyluwhFPgDrmCDV9g1h1/27nu+bpqgiFg652kJt3jZMEi9
	YLRrXq6Zj3jk=
X-Google-Smtp-Source: AGHT+IEWuw8NAHaYGrNnE/bVGa1Yuo/O/jxEoQUYt2NcNRy377Xme8SuumEbqFGesDEc2zI45jruLg==
X-Received: by 2002:a05:6a20:2591:b0:1fe:90c5:7cfb with SMTP id adf61e73a8af0-21ad9816be9mr4005375637.27.1748586254374;
        Thu, 29 May 2025 23:24:14 -0700 (PDT)
Received: from howard.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2ecebb6857sm757498a12.73.2025.05.29.23.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 23:24:14 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v1 2/2] perf evlist: Remove evlist__has_bpf_output()
Date: Thu, 29 May 2025 23:24:08 -0700
Message-ID: <20250530062408.1438861-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250530062408.1438861-1-howardchu95@gmail.com>
References: <20250530062408.1438861-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function is no longer needed.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/evlist.c | 12 ------------
 tools/perf/util/evlist.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7b5837c6e6bb..876952685803 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2618,18 +2618,6 @@ void evlist__uniquify_evsel_names(struct evlist *evlist, const struct perf_stat_
 	}
 }
 
-bool evlist__has_bpf_output(struct evlist *evlist)
-{
-	struct evsel *evsel;
-
-	evlist__for_each_entry(evlist, evsel) {
-		if (evsel__is_bpf_output(evsel))
-			return true;
-	}
-
-	return false;
-}
-
 bool evlist__needs_bpf_sb_event(struct evlist *evlist)
 {
 	struct evsel *evsel;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 85859708393e..dd5e32583c74 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -436,7 +436,6 @@ void evlist__format_evsels(struct evlist *evlist, struct strbuf *sb, size_t max_
 void evlist__check_mem_load_aux(struct evlist *evlist);
 void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_list);
 void evlist__uniquify_evsel_names(struct evlist *evlist, const struct perf_stat_config *config);
-bool evlist__has_bpf_output(struct evlist *evlist);
 bool evlist__needs_bpf_sb_event(struct evlist *evlist);
 
 #endif /* __PERF_EVLIST_H */
-- 
2.45.2

