Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B05138490;
	Mon,  7 Oct 2024 05:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728278063; cv=none; b=Ikd9YqWH6mJ7AYfUgD2pYvh2EL6IO8xNSOh6Uh8uzgoKR8HMG0Q8NjdvHqhp4CjVFaB/0N42cjipJ0U610e5MHlfH8DzxQ2yse7GZTowMxTZksH3cwEIjzi3dpfclgwnJw1NN5RZGnXYOK8CmYhxx8cfvpH/dTDzZzzW+sDqtuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728278063; c=relaxed/simple;
	bh=d5lvLGEZ65TVJlhuGEWaEeJKYjfBPSlaDFuG96uwbRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nL67115k0xeRCdtKZ3r/JrLuuZ+MKyGsSMUjDkN4G105gbF9/sLFK01MwX0jM5wmT5CZzAGzpEMbQQcMnD7bb18KrXR4Ig5nDoMRswoS5EkLD7Fh5vTcwKrIt5XjdBmdapOFLJweyicZ1uRYfg5DS86eDnp1sXSgHrlGOEpUKmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPTlktvL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPTlktvL"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e029efecdso532023b3a.3;
        Sun, 06 Oct 2024 22:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728278061; x=1728882861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2reijhdOBoBbFvrgZ4U5IyA3FFXxmpzR2VeqS0lYuQ=;
        b=EPTlktvLBOmTkkYNuu3lZ0BsrIvJ0M1MZVOusPglLEJeqk4X9338eW0bvyPojfCwyH
         yByZ4dtt8akOgJyoY7twU1kRBpd7QL7GQLvIG/rO6uNnKmtzejnBBFQ/YXSyybCncV7L
         OE7/5xKLz914LBUowSkvj2Z1bpplvBsNzoUNBcWmKbOIrhNVeToGfJeFnKVaX/snPD+v
         Ccj1/Fafd9yVw5bGczvGo8yS1zHgs/SZgcBsbFHvpboTJIxlX5ltvB2dSISGXYqYQqJ5
         LsmBLE/DiyCNqJlhAGf5TZWhNZCxIDvqtZ4kLJCClyLJALwkktlL4GBSDIGoOqZBGrl6
         7w3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728278061; x=1728882861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2reijhdOBoBbFvrgZ4U5IyA3FFXxmpzR2VeqS0lYuQ=;
        b=f+NdW5gx8W4ClHqY3+ibsbu7lbKxZn0ZQjN8FLVTvACOHCV9bLdwX3pxvxQC+RuLKE
         ioV7Zr/osqnanGZQiN6OmxBf7OnFrgIdLoroA4UWa3NqRrhuLUTO5yUrIizGe/JiPS5L
         8EnxdpE1UEmdLFSzAoieIxZsX8XBY9ZD5r/WH1ER7e70i7bFKUDukBcELJl8cbtBA3bQ
         PSwK08oopsMT3maZmejioMuMarBG24GEgAwjjAHNClWATAbL/aLpPpWk55d7z+1ZqgT2
         0G4GsqrleTv/CjnAmwgyFB1SsMuWlm3ycRHuJE6GKav3tnoDsHJXp5Uq/29jWdAWVD0F
         P+9A==
X-Forwarded-Encrypted: i=1; AJvYcCVWxbPfsEPr+XlO2mKt3beuYgtTxhsUGCYmQjmC/GY4RkpXo7uJHqTmBEN1ONS8SMTDVaqSXak4wl5aiWU=@vger.kernel.org, AJvYcCWdX7qz1X6JRBJBqw61dcCOWbiZKnYBHb+D8Ue1g5bxyk7wxBlpyzmpR4t1+Scz83TpByer7chNFtqp14jXL+AozQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKJPIf3mn0fZhCjCXydi1u9ljb8jqQM1y9qhOyI/bs7NhB6OIC
	uItEdu8YOZOvShPo4fDSlB7YmYTj3eLkqkJVDoxdZ9+A+EtMVjZV
X-Google-Smtp-Source: AGHT+IHDyJoq1KUGhCm5wUcGaQ9kfOg76bjjtTCRzwsoQNlwsWPHekAhDPIOzW7jIPEeWp5h4+0LNg==
X-Received: by 2002:a05:6a00:ac1:b0:717:8aaf:43be with SMTP id d2e1a72fcca58-71de22de04dmr18254432b3a.0.1728278061355;
        Sun, 06 Oct 2024 22:14:21 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccd04csm3560706b3a.46.2024.10.06.22.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 22:14:21 -0700 (PDT)
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
Subject: [PATCH 1/2] perf build: Change the clang version check back to 12.0.1
Date: Sun,  6 Oct 2024 22:14:13 -0700
Message-ID: <20241007051414.2995674-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007051414.2995674-1-howardchu95@gmail.com>
References: <20241007051414.2995674-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This serves as a revert for this patch:
https://lore.kernel.org/linux-perf-users/ZuGL9ROeTV2uXoSp@x1/

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/Makefile.config | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 4dcf7a0fd235..adfad92ac8ef 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -701,8 +701,8 @@ ifeq ($(BUILD_BPF_SKEL),1)
     BUILD_BPF_SKEL := 0
   else
     CLANG_VERSION := $(shell $(CLANG) --version | head -1 | sed 's/.*clang version \([[:digit:]]\+.[[:digit:]]\+.[[:digit:]]\+\).*/\1/g')
-    ifeq ($(call version-lt3,$(CLANG_VERSION),16.0.6),1)
-      $(warning Warning: Disabled BPF skeletons as at least $(CLANG) version 16.0.6 is reported to be a working setup with the current of BPF based perf features)
+    ifeq ($(call version-lt3,$(CLANG_VERSION),12.0.1),1)
+      $(warning Warning: Disabled BPF skeletons as reliable BTF generation needs at least $(CLANG) version 12.0.1)
       BUILD_BPF_SKEL := 0
     endif
   endif
-- 
2.43.0

