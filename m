Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665542A1CF
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Aug 2024 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944893; cv=none; b=JiwAF1wHh5cnRggYtSl/iQheZgoErfA1Ygk7yowdXI9MVCY9+QtZET8QHpyhSCXrEllbBPK4SMcgYWSmDw2LdEr8dWmdIH0U+FV50ysFFvIgPDyl0f+J9YHOLUw5TO6IhKI0wjAI59KyaiTUVQt/CN+TILsTOK5xRJRKupDHOPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944893; c=relaxed/simple;
	bh=u5zRJaTuSvBseINgkqS6UlZoRxRUZSWXK0n4RffFhoA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yr8BGk++EMPkHFk7NB7j5qpKgvb7BMz3qmp6lFXo48oXBFGSlRMyGx7uJ832Hz7fu/fVQagwhRFubtJdZdidRuAW432M04HnyAvo51qmsvBb1tcg2zHJ8d7T2BWnrvTFWOQMIVLWOUBpYlJC5JlWvSPhOeowOLHWhG0MMyuiH1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WwUZVWKa; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WwUZVWKa"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d1a74a43bso367030b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Aug 2024 04:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722944892; x=1723549692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QSWgsBZpug9uAeZNuJufTFCNLfK1NntM3pErkn2XtXA=;
        b=WwUZVWKaefJ+Fx3iaeSCSJDj+kacJIlv2gzVcd09GTxWXslJ3nlSux7/Mi43OHv1Sr
         +hLgwP5vyMUCNHAuC2EUC4Kvkyklc+rXMR+4vTdWVLP+wxUSq2Z+nyfBj8vig+2xWYVg
         wFpL0OI9XJiyZT3mIpNRMok8A+STpib2RArXiNHGdRVQNE3NYZTdpLsCLKlBqAXRMNZc
         ZHX7r9XCL/00gvFtqsfx0nQphyr4leBHTzsl4hkkN4J+qNSq15r/38mYQ1hYiFnsusJX
         FoWkvlXTMUtq+lsRuFpyqCW3ldrQZBCJEFLOJ7JBN+qkOG5NO4OLpi1pPJPbgeZdDReV
         t9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944892; x=1723549692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSWgsBZpug9uAeZNuJufTFCNLfK1NntM3pErkn2XtXA=;
        b=a/+bwKspPufwJ4RhYGpxXuUCnduLK9/YaTlZl4ab7jwnzAgcvEFBQ0r2wAxmDoiBMB
         CpUjz28AIIard4Cfjtmt4zHCwdoFwPvgSzxq8GNrjPUP6/iwfgcsieS+KCRfES8cRVVW
         grxKvIz/vLkU9uHwiDKYOCPshYJ4u9d6fQzfF3EA88DZQX4CrRfs+a+qZ7Ebw0MTtDfm
         KZg3c6s5eVdLAos3F8voyyWpX+oSppMV2dlixQHQhSMuk7lfuXJ9BUAT7GXF66uaFgYa
         hXvQ+GIDi8FUU6cwqh3TztpTMABwmCJM9dgbtm5DpNkHJG+cJ1Gv3e1U9AoF9/v32O4h
         eKdg==
X-Forwarded-Encrypted: i=1; AJvYcCWxONUlPxCOXju+0nKYblNElgy2LNs1hdzvGgCYRFf9zHalnICWHe8MGMPvMmg5Gh2stmwyCrnFJDsthxtmidg/FG+pJWDog85ecMLQXhFFpg==
X-Gm-Message-State: AOJu0Yy1ZDaZ2NcHcw5IJl74vhd3YaLqGr4TxjM7YYvfzpV2uEtNVoO9
	BLVS5hpn9yaCTcKpWnl/KzdEEizuEBZ1e6DJD+bGPttR1o348nVFhC4MvQTpoTw=
X-Google-Smtp-Source: AGHT+IG0l4RbcapZ/5fHoMHXUqZ9zGO50TQOiCiOJC46xPX+zqq+MStm4ii4pxaKSGZ/HnZDrpFUoA==
X-Received: by 2002:a05:6a00:6f4e:b0:70d:1a82:f9a4 with SMTP id d2e1a72fcca58-7106d07bdb1mr11122155b3a.30.1722944891642;
        Tue, 06 Aug 2024 04:48:11 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec43944sm6831705b3a.75.2024.08.06.04.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:48:10 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v2 0/3] perf: build: Minor fixes for build failures
Date: Tue,  6 Aug 2024 19:47:58 +0800
Message-Id: <20240806114801.1652417-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains minor fixes for build failures when statically compiling in Ubuntu 20.04.

Changes since v1:
 - patch3: Remove UTF-8 characters from build failure logs

Yang Jihong (3):
  perf: build: Fix static compilation error when libdw is not installed
  perf: build: Fix build feature-dwarf_getlocations fail for old libdw
  perf dwarf-aux: Fix build fail when HAVE_DWARF_GETLOCATIONS_SUPPORT
    undefined

 tools/build/feature/Makefile | 4 ++--
 tools/perf/Makefile.config   | 2 +-
 tools/perf/util/dwarf-aux.h  | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.25.1

