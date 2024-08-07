Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72AD18D63E
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Aug 2024 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723000833; cv=none; b=fyLDDHvNo16i2OQGXfOEKp0f28AI1DTojVNI71m35tRmXm1Irxd/m+nMvDs++28jLjeY1iA+Cp0DefzcLL57PQkwAIBN7iCF+mIRPYBTCmXxCSDp0wJKN32rt2PM7AVhX5IQdESWWgNa0wIroEibO/fU1hkWR3sT4d/mYg3Uukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723000833; c=relaxed/simple;
	bh=PSf2FfGfwm9hvlShXvVH4qt+MH+zYsoIu02haAiBcHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MxjDnhImyb5ElRnrGRtUph3T6ORLF3kQ3YZp5x84OIc/Rw8dSZt3B2bN5nlvSN+aFsVGh+Lgf/FwSCF53WLZoaGAUzRoej7ZFbh2TF3RpR+6XtmQUBEoulD/z79ZDApc/jB1xxUZOIoTs1uPc1lWG2aym6oiBusY+uT1+dYS8vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=c0U+rNIW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="c0U+rNIW"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc587361b6so11683225ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Aug 2024 20:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723000830; x=1723605630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fHWiHDDtgEmQfrOkHzWRCozF8QLif4Nw1j5YmDMQe9M=;
        b=c0U+rNIWnBohP0GwDwyasSzCr/cAbMJdxMUe/gQkGnzg0zCNVBeHdzNOB7kGD9vjTE
         7c2nOgeVW9o69jSWlRyJdOenqb+ItUOr+EnlaYpqXqF6W/JHXpPz2WPK5kUlJZXeoJrs
         PI7Dgo9eGDddwMy1rYdrLo7zbZxlGH4YY8gqQeIPbv0ovZbBttzf6iNJIOSQ2hXAtq8e
         T1Y04j8aYvPs8Wn0ZV4y9oBCyoNzK0jIpvDuclr68Uz13x6sv3yPYCF1dqjhyEDhdgt1
         uGZZkC2P2ikhLeCNNyXWlS/xc3T2SNGs1HUrzqpmvxiTLppezxQeb+z29R/FRFNoOS7x
         XCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723000830; x=1723605630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHWiHDDtgEmQfrOkHzWRCozF8QLif4Nw1j5YmDMQe9M=;
        b=hIVeqZ7s9x3SJGzzSThiUdQQXw73KYv49CL9OHtRB0HGQTYp9O3Xr/R6UjdpR8F7Wv
         9hiipml1vSrdCJL2Vrk0ja0nknQbqYwpKmm7ntvQpj8lX8vWMdsnTmZHTPmkjSwDeA1n
         auhJ2K+mSSyJIFvs0qWgywtFLT3uRLKiEkqJUovDQeO4UHJEF95Z6+uVrMjq5DD+99X/
         GochdI2n+fVRZn/z3LbDfTo4NJrhATKL/41/UFhozc8tPSlMw2bw+P/fxB6ltBLj1lAP
         1+GQJAIvzx6r4gB9Zak7TeU/l9y5BNbtP59HKKILUatH+JcWyPpq5uDv0cFrxgOj8kJf
         f4ew==
X-Forwarded-Encrypted: i=1; AJvYcCXgaLmZR45J1cd/U/pT0SQbl0qmp8jQ0eVuSWN/VyY6i7sUJ7XJtnlxdsn5lzsdKJwBuBa30kBklnz7L5MAFgdFYHX03KWItSCJWTgLZu0A0g==
X-Gm-Message-State: AOJu0YwcfZDvlmBmK4dmyLn566H4DDuDcyAQcDBbeISNM51/a+zY+MLj
	KSNHtXBBHRrqM+HgAwdZFe8Z7t934EkN8v7mTAgh1YdvYwbx6pFZRYq03An8ePg=
X-Google-Smtp-Source: AGHT+IHcZhOwKMlgZxd+felWeQBdrODExJiQTByT1SqKlSR20ml+DJFyfgohKhYvwQ4TtYQyvN/XTQ==
X-Received: by 2002:a17:902:f68a:b0:1f9:c508:acd5 with SMTP id d9443c01a7336-1ff57257f5dmr135329335ad.5.1723000830203;
        Tue, 06 Aug 2024 20:20:30 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f19ebasm95116175ad.23.2024.08.06.20.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 20:20:29 -0700 (PDT)
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
	leo.yan@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v3 0/3] perf: build: Minor fixes for build failures
Date: Wed,  7 Aug 2024 11:20:16 +0800
Message-Id: <20240807032019.1828674-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2:
 - patch1: change LIBDW_VERSION to follow up the style of
   LIBTRACEEVENT_VERSION. (by Leo's suggestion)
 - patch2: Use a new line for the -ldl dependency and with comment,
   synchronize tools/perf/Makefile.config. (by Leo's suggestion)
 - patch3: include header files in alphabetical order,
   add reviewed-by tag from Leo. (by Leo's suggestion)

Changes since v1:
 - patch3: Remove UTF-8 characters from build failure logs

Yang Jihong (3):
  perf: build: Fix static compilation error when libdw is not installed
  perf: build: Fix build feature-dwarf_getlocations fail for old libdw
  perf dwarf-aux: Fix build fail when HAVE_DWARF_GETLOCATIONS_SUPPORT
    undefined

 tools/build/feature/Makefile | 5 ++++-
 tools/perf/Makefile.config   | 7 +++++--
 tools/perf/util/dwarf-aux.h  | 1 +
 3 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.25.1

