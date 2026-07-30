Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3486039E191;
	Thu, 30 Jul 2026 23:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454474; cv=none; b=Lv9OjKccKOXrsM3FrDqwD2ApXqeu2///uylovWUogPiS6chWn/ZPHvXiiAZqzLJrBWLcv9zZfMEyv+N6LyoyiCJiA8N5miUxjXcrMqGj7G//URHuWPOvfqNrDKGSgujtdtMzBtXVgCXKkWSXahgKrsBii3bU6VO8Kz4NEwoXddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454474; c=relaxed/simple;
	bh=FOw8jA81sovztNnUvcUdF0XoJw1ZflskBO9pDaedVPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lwkytl9F8Ks76Muaaq29SOOzsXZTTpMlsYKNIGYAiI1MhDa3KtgbE7lA0VAW61FyxnnDCyoROEeZriG0Lt4CybUzVvuklOPKtfKuEic7IaLA6XC/aK0qhtT8TADgQlHwPkJ253gq9klZAmFDAAb6AnQUzzwRfRs8Sbf6Y23HxeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Un1nT1lA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Un1nT1lA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=CW5PXYM7jodOc8hZA10fsyXKguqdzuPZ27ZUWcSFhCM=; b=Un1nT1lAQlhOSWW0EOSNzKgHWE
	iEb4M9PFNGeGOcZeh6pZG4wHgk/aPmIkQyn/0lbNMWZDaxV5glqQQ+wEYETvlIxKyPzbH0zqD5CGs
	Nu412lJ+waAoanUC4kJSiVhHaXjhT/2DR010WNAg6BJ+1TuIbFJ5tFQDSAizQaIt0wUoeny0lPAOd
	ZBgWhK0ORrgSCxys5Rrk5TmYdsWqb9+/Kb7PTahYW/S3kXsUiC8HvCRrafv/ybkYGiJnUTHcWQ+Vz
	PgOJCT9IqulRdKSdXyXtq0Tygvvsw6c/pWEEYjGBY6A1rUHmwGvztuQB2niJfkWIZUcNRC3xBDElw
	WPKaHzwQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpaGm-0000000BViq-30aY;
	Thu, 30 Jul 2026 23:34:32 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 5/5] x86/intel/quark: clean up function kernel-doc
Date: Thu, 30 Jul 2026 16:34:29 -0700
Message-ID: <20260730233429.285788-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730233429.285788-1-rdunlap@infradead.org>
References: <20260730233429.285788-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a short description for imr_self_test() and drop the comments for
the non-existent imr_self_test_exit() to avoid kernel-doc warnings:

Warning: arch/x86/platform/intel-quark/imr_selftest.c:52 missing initial
 short description on line:
 * imr_self_test
Warning: ../arch/x86/platform/intel-quark/imr_selftest.c:128 function
 parameter 'imr_self_test_init' not described in 'device_initcall'
Warning: ../arch/x86/platform/intel-quark/imr_selftest.c:128 expecting
 prototype for imr_self_test_exit(). Prototype was for device_initcall() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
New patch.

Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org

 arch/x86/platform/intel-quark/imr_selftest.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- linux-next-20260722.orig/arch/x86/platform/intel-quark/imr_selftest.c
+++ linux-next-20260722/arch/x86/platform/intel-quark/imr_selftest.c
@@ -50,7 +50,7 @@ void __init imr_self_test_result(int res
 #undef SELFTEST
 
 /**
- * imr_self_test
+ * imr_self_test - perform the IMR self-test
  *
  * Verify IMR self_test with some simple tests to verify overlap,
  * zero sized allocations and 1 KiB sized areas.
@@ -121,9 +121,4 @@ static int __init imr_self_test_init(voi
 	return 0;
 }
 
-/**
- * imr_self_test_exit - exit point for IMR code.
- *
- * return:
- */
 device_initcall(imr_self_test_init);
