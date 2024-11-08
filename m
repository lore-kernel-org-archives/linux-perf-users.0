Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196A01EBFEC;
	Fri,  8 Nov 2024 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098509; cv=none; b=qqvquzov6/diOnSiDgrTRHzWc9WFkeg6ReVgPsvXPkw59zi7F1dbt2CM/C/XX3fkR0lje9+UGj+VEuxO4oz71EI7rP8A+8H58MagZeF4KVDRDMPvCMASt8lME0pn2XCVbRWnRRGwqxlnylyjnylbJWTMFtYgZQDH76VhGxa7zkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098509; c=relaxed/simple;
	bh=qfK32nrxof+TkZxXSG7rjc3Yo+eLtgY6yJxrTTp6k4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3mLKIXE507ZF/BjC31ilLY5OKjMMvVj8F0BdEAZRtfnTjcTMTlEVNhw2J3rOs1TuA9GCBhSRhQz/RV3Du8/iecyrhUuH1T5dSo9MgdiLUvUa6ZJUH0cfWPtO/b1ooV2CDs/Ww3hFBRT4vhEtBsCezgrPDiqFtgumFmGzdjHn6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yq9Zj6+M; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yq9Zj6+M"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so1873152a12.2;
        Fri, 08 Nov 2024 12:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731098507; x=1731703307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DDTIIOXrlyRpPj2EqrJgznrv0EYT+anm2NNcd0r7hI=;
        b=Yq9Zj6+MmDVqHl/w6014E9viM/Ahut7qGhNY9c6HeGi26KofHmYHzvzFSWbcdR3XLs
         Y17V1yk9Wxavn3pzWFlr1bE5Ma8Sl9EvLUQmA36bIiaoVw78201EUnQgr+g2R8v4KDMv
         3adUD1HSlnObrsS8Znu13UbAGvsSPmlGGbXWbw/HDuVYg5uNzQViNAAST8tbENeZTApH
         3Nb5WKWtC4/0sqNXN7YwsRlE4xJ83wjQ6HLoOOTdiOW+uOxdY1Zi/QbYUk7nDB0Vgvjq
         NzFKEyj9nL3LbJYgmTEfTGNpTT83++BtKfUoz5OeSxpwStY4U/vQlfM3lfil0Q50/EvE
         kfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731098507; x=1731703307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DDTIIOXrlyRpPj2EqrJgznrv0EYT+anm2NNcd0r7hI=;
        b=c6OOwACn+bdfIfpT1InynA6r8c3D160iTqf0NHQKGcOSqQ0syVIHOzjea5w7ayEcIq
         bLucAL2zBVRLu3pPnhuoeTktjVvvoTRa5DyKW5HIU8UbGL11xXeo9mwv5emcW0g1Jv9C
         hbFI+SSfRER2kMTblBsZMicS1q0qAeqtqwURnX5NLX+r+02baitho8x25hv0QFySTmuH
         stT5oVeawynzS63cSILxMVHxMx0zZj0o5/fZmCfxVS2CIx6Tz2Oc9II5fuDUKsclZhQk
         FYZzM+K3+GWKWpD7eBjxtKcDWHYmmQOcWDiQ07cC/87/k/Fw+mnRcaujeDSPe2Bps4hT
         vkwg==
X-Forwarded-Encrypted: i=1; AJvYcCVXPWWHg00OW4Ivl+nvSMGETk+lVZ9kGVTpt6JOfI73MarUE38RlPZaLbC22GhtCnqzzfWV5gHb5xv5N7w=@vger.kernel.org, AJvYcCXiyD2D4WdbBN7p5NGYpgfqmE1WbnmMP8cPIVqzYqzj7K72y1Nk6O2oqkldBxIRzXXHNT0TP6E1htR8Rf0Wso8UMg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Xya8TVKV7KoJp/JzMH+NRTde24HdzoU6aNBvWGtMcpWo70rw
	84FZSZMawp0n4xjDYkSVcBg3Zj7w23h3il9aORD5WHabvSqniUIW
X-Google-Smtp-Source: AGHT+IH1Cbz6FiqOqAy/mf7i3pJOe+zl8gxK+fYOuqdD8wGHUxkwM1haOtTG0PoE8p1ZCwHA/GAsng==
X-Received: by 2002:a05:6a21:66cb:b0:1d9:25d4:e8b1 with SMTP id adf61e73a8af0-1dc22a60aa2mr4411025637.25.1731098507442;
        Fri, 08 Nov 2024 12:41:47 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffe3sm4221945b3a.2.2024.11.08.12.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:41:47 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org,
	peterz@infradead.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mingo@redhat.com,
	mark.rutland@arm.com,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v7 02/10] perf evsel: Expose evsel__is_offcpu_event() for future use
Date: Fri,  8 Nov 2024 12:41:29 -0800
Message-ID: <20241108204137.2444151-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108204137.2444151-1-howardchu95@gmail.com>
References: <20241108204137.2444151-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/evsel.c | 2 +-
 tools/perf/util/evsel.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f780e30aa259..695f831b463d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1193,7 +1193,7 @@ static void evsel__set_default_freq_period(struct record_opts *opts,
 	}
 }
 
-static bool evsel__is_offcpu_event(struct evsel *evsel)
+bool evsel__is_offcpu_event(struct evsel *evsel)
 {
 	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT);
 }
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 04934a7af174..7f68004507d8 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -554,4 +554,6 @@ u64 evsel__bitfield_swap_branch_flags(u64 value);
 void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 				const char *config_name, u64 val);
 
+bool evsel__is_offcpu_event(struct evsel *evsel);
+
 #endif /* __PERF_EVSEL_H */
-- 
2.43.0

