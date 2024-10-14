Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AE81AAE23;
	Mon, 14 Oct 2024 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903618; cv=none; b=QpoW2JZzYhWeP8o9FQtCCw3Cm8CzVfZ/zynlIhe3NB3p7kilD8LW5oDdCohZtYbdtDVycNfq7iRKO994/UK0cANFludtHdSCpkn+rGSuvnXNcvd7Fbrbq0RPzUOnw0xaif0pPSVb+slAmYwRVFLc7Pe3X4s8DKPzu4DIvQMr4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903618; c=relaxed/simple;
	bh=ckI1+T2GFgSWcVYnvAcaN2k41SpN9b7TGriYQVjzmWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9BM+aPJgJLWkBWmbx23IgDHdKZj/bRCqaYC/L/R5mVTF1WAj5+IRcD6LV7IRqB0D1Q5O9a4f16PIUJPswIQ77CntslSrzWMmdplzeeJ1U8RRuPGSkyvDQEjp2MuH9w8CpqPaUxcBrEiLzID+OZneHlhF1aMHgPEbVcMv8R64/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89DBA168F;
	Mon, 14 Oct 2024 04:00:46 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B5403F51B;
	Mon, 14 Oct 2024 04:00:14 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org
Subject: [RFC PATCH v1 16/57] perf: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:23 +0100
Message-ID: <20241014105912.3207374-16-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

Refactor a BUILD_BUG_ON() so that we test against the limit; _format is
invariant to page size so testing it is no bigger than the minimum
supported size is sufficient.

Wrap global variables that are initialized with PAGE_SIZE derived values
using DEFINE_GLOBAL_PAGE_SIZE_VAR() so their initialization can be
deferred for boot-time page size builds.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 include/linux/perf_event.h | 2 +-
 kernel/events/core.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1a8942277ddad..b7972155f93eb 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1872,7 +1872,7 @@ _name##_show(struct device *dev,					\
 			       struct device_attribute *attr,		\
 			       char *page)				\
 {									\
-	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);			\
+	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE_MIN);			\
 	return sprintf(page, _format "\n");				\
 }									\
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8a6c6bbcd658a..81149663ab7d8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -419,7 +419,7 @@ static struct kmem_cache *perf_event_cache;
 int sysctl_perf_event_paranoid __read_mostly = 2;
 
 /* Minimum for 512 kiB + 1 user control page */
-int sysctl_perf_event_mlock __read_mostly = 512 + (PAGE_SIZE / 1024); /* 'free' kiB per user */
+__DEFINE_GLOBAL_PAGE_SIZE_VAR(int, sysctl_perf_event_mlock, __read_mostly, 512 + (PAGE_SIZE / 1024)); /* 'free' kiB per user */
 
 /*
  * max perf event sample rate
-- 
2.43.0

