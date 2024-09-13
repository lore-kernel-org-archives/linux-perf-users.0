Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0371B1D6DB4;
	Fri, 13 Sep 2024 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217091; cv=none; b=YxzrQytHawuIG6C/VDkvE8IvmaNTeEdc8s0SYFLKsQMPsD5kmTY2L3O+8zQvOPUsGWH5JbUkxcbgmGvXpt6ZLpwwea2alA3H7+mQTgComzz/ElLMAH/zY5q9Kz7tqn8sPklZXyjpEhab9sKRZCKPl2uU5KAavhvCWeLu9LK1YGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217091; c=relaxed/simple;
	bh=TmX1uXjQKugIb41wPU+Bk96PgJuVp8IskJbQ37pXCbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W4oKzt9S343ouX/wmSsN8xWJldi8NBPOvL8LY5c2vRszINEaCijC1HpA5aoMR5pyV0iCqVYG3i/hi21s3QDDzKFyC4SgL8ySJYM3i7SqnB9S4Ri408olyjWlrysmZ/RyMShqlSPWCKYd/79Q7XDrMjhnO6l5Ehtc8LDOKYmqPFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98C101477;
	Fri, 13 Sep 2024 01:45:18 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D42DA3F73B;
	Fri, 13 Sep 2024 01:44:44 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	x86@kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-fsdevel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>
Subject: [PATCH 1/7] m68k/mm: Change pmd_val()
Date: Fri, 13 Sep 2024 14:14:27 +0530
Message-Id: <20240913084433.1016256-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913084433.1016256-1-anshuman.khandual@arm.com>
References: <20240913084433.1016256-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This changes platform's pmd_val() to access the pmd_t element directly like
other architectures rather than current pointer address based dereferencing
that prevents transition into pmdp_get().

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/m68k/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
index 8cfb84b49975..be3f2c2a656c 100644
--- a/arch/m68k/include/asm/page.h
+++ b/arch/m68k/include/asm/page.h
@@ -19,7 +19,7 @@
  */
 #if !defined(CONFIG_MMU) || CONFIG_PGTABLE_LEVELS == 3
 typedef struct { unsigned long pmd; } pmd_t;
-#define pmd_val(x)	((&x)->pmd)
+#define pmd_val(x)	((x).pmd)
 #define __pmd(x)	((pmd_t) { (x) } )
 #endif
 
-- 
2.25.1

