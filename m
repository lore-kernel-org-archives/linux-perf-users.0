Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916AB257AC8
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216312; cv=none; b=hsFfSyKPKrT9qm82NWAAtTNOsUht/H1F7jJEpqBuTFzO1vCApTC9KOH0RfXSZjfSlfbRfguDx7RlYKIF3ffWJksCOCxKMZ+JoCWHkK6pQlCJTnHuXqlM5n5CNm2huUV6qFk1+2xl22zfCb6ffziu32/HPL5EjRnjFjwfqwsjSrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216312; c=relaxed/simple;
	bh=aAO5U4rIUSmSiW9HiZeU+4RaV76aniUNOw4ep9QcM3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGLjqGTGYQNR0srkWh7Ea7qfSC1ujXSHqzQUtunrFN6aW+XnA818OjtwXELF/lFOXMwe1lR0B7s+3KweQwiLnezPAneaqO99Y68woACdD9awlPOEtAiBjoQBsTnSRwGPtYTAevTbdqirzal2KjngHux3Jaju8E7pFgMtiz1d3ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NpYCj3cC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpYCj3cC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLiFHA5Aiy4k7pcGr1QPi7NyoGcLfJYJaAk0JBe4xM8=;
	b=NpYCj3cC8idYOqPU/wdSr7o2+xUjI9LjsolEb/QAqnrPduqkL62kgrXWsUZjIC2NDFoU/q
	FZK05KDgTkbQLjGPBv8iIh1IQNM9pH91U7r028kLIwzvoNBx0mS4oEtEEQmbfGVZo3Mui6
	zzypFlUYzRApdZEDrTFF4a+k1jU1vOo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-Zu-_IIBIN1KOmGJyNUvKRA-1; Mon, 10 Feb 2025 14:38:28 -0500
X-MC-Unique: Zu-_IIBIN1KOmGJyNUvKRA-1
X-Mimecast-MFC-AGG-ID: Zu-_IIBIN1KOmGJyNUvKRA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4388eee7073so27031065e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 11:38:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216307; x=1739821107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLiFHA5Aiy4k7pcGr1QPi7NyoGcLfJYJaAk0JBe4xM8=;
        b=rcLVgsY9ZETYH0ywQ1exl6tzqRcXvl8byZtahZAS3sMUNc32+AlZ+/oibmlFM1RRpg
         rZm0FYSSYb8iuFEk+QI16jpLfSuJQsbQXfz8XKar4d35UbgKBpYqi25X6zxEFDog4/eC
         Xp3JXktrBMnjikKgiRS65kNzmL4c4uN5Eb1KIQDGHtsY/jHsCn3sUO/9gEh6HLfZ62cK
         DmHTApdgEkokj8QW8FsAwSnCICxWy440XtTLCH1uCopmSFFnkZnJ0WauIeUac5p4+Kch
         fpi6U0JmqAx2e2s9xIshgepk+FUEIZFgogKpEHLYch3ev6rs0uOSkLq/w96/yVdLA6cm
         pfrg==
X-Forwarded-Encrypted: i=1; AJvYcCV2aEcbAoXk63V0grQVjr2UrTruutT3mGo39fyv5t+OxE1BP5rX3kUstcLntQdry69zA/AlkmzdSwjuwBCME+ft@vger.kernel.org
X-Gm-Message-State: AOJu0YxNlqNe+rb2CNfu3VAge0/WWFQBpcK/XjU94B8epVyYIz0lLz2J
	RpMmFDM9uHbUxaJORuIbt+Ldzqflx2PUns+zaPdaJQAM/X7dTga1Hl5H8x911rHWaRN1LzOAAE9
	BCrxQWCAz5QC2q4zoruxO2DBiB3+PB3XFoZ5YdjRO9qeqCA5Q/fFEG0Xm7DCOX0n0POY=
X-Gm-Gg: ASbGnct19SwiYcvJgOhHM9w7+YCQtjEqEowdRfbbWPkaBy8t9cPyNJDPMfCUplbv9mH
	mRg8RSH9455qrI2DQUcfG8Vn9H8pudanVAM4STAVF/FnVklWBNmSrsjEBAAeGaP15dhuHBC7ZoQ
	dvsWc4UNuKvGcTRNgotr5wHBrCdG0/YeKYLYJ0drH5bHfhTnYLuwgrpKugJRj+jevLwIiSSEY/J
	vPybyjnzHShkQmExZcxD1MKJJQxW95WMNl6RkhEFPPXU9sM1YiZkyq8/bdPzpDhI4EjgQVXlJGg
	17UmUhG1IfULpaRv+hpVWJNG/O4O7C4cOAng1hzfCW2aH7B6UzJzx4wrv33mu5ln7A==
X-Received: by 2002:a05:6000:2ab:b0:38d:e3fd:1a1c with SMTP id ffacd0b85a97d-38de43b38d8mr568343f8f.23.1739216307229;
        Mon, 10 Feb 2025 11:38:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsdgSvAB5qD8mlN6AGjEYvBbSJNfBUob/X5TfyCrhv/WAdQoby+DEB/v6QRZcPR+eQm0f2lQ==
X-Received: by 2002:a05:6000:2ab:b0:38d:e3fd:1a1c with SMTP id ffacd0b85a97d-38de43b38d8mr568308f8f.23.1739216306759;
        Mon, 10 Feb 2025 11:38:26 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38dc2f6aeafsm11911098f8f.20.2025.02.10.11.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:38:25 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org,
	nouveau@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	damon@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Peter Xu <peterx@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: [PATCH v2 06/17] mm: use single SWP_DEVICE_EXCLUSIVE entry type
Date: Mon, 10 Feb 2025 20:37:48 +0100
Message-ID: <20250210193801.781278-7-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210193801.781278-1-david@redhat.com>
References: <20250210193801.781278-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need for the distinction anymore; let's merge the readable
and writable device-exclusive entries into a single device-exclusive
entry type.

Acked-by: Simona Vetter <simona.vetter@ffwll.ch>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/swap.h    |  7 +++----
 include/linux/swapops.h | 27 ++++-----------------------
 mm/mprotect.c           |  8 --------
 mm/page_table_check.c   |  5 ++---
 mm/rmap.c               |  2 +-
 5 files changed, 10 insertions(+), 39 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index b13b72645db33..26b1d8cc5b0e7 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -74,14 +74,13 @@ static inline int current_is_kswapd(void)
  * to a special SWP_DEVICE_{READ|WRITE} entry.
  *
  * When a page is mapped by the device for exclusive access we set the CPU page
- * table entries to special SWP_DEVICE_EXCLUSIVE_* entries.
+ * table entries to a special SWP_DEVICE_EXCLUSIVE entry.
  */
 #ifdef CONFIG_DEVICE_PRIVATE
-#define SWP_DEVICE_NUM 4
+#define SWP_DEVICE_NUM 3
 #define SWP_DEVICE_WRITE (MAX_SWAPFILES+SWP_HWPOISON_NUM+SWP_MIGRATION_NUM)
 #define SWP_DEVICE_READ (MAX_SWAPFILES+SWP_HWPOISON_NUM+SWP_MIGRATION_NUM+1)
-#define SWP_DEVICE_EXCLUSIVE_WRITE (MAX_SWAPFILES+SWP_HWPOISON_NUM+SWP_MIGRATION_NUM+2)
-#define SWP_DEVICE_EXCLUSIVE_READ (MAX_SWAPFILES+SWP_HWPOISON_NUM+SWP_MIGRATION_NUM+3)
+#define SWP_DEVICE_EXCLUSIVE (MAX_SWAPFILES+SWP_HWPOISON_NUM+SWP_MIGRATION_NUM+2)
 #else
 #define SWP_DEVICE_NUM 0
 #endif
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 96f26e29fefed..64ea151a7ae39 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -186,26 +186,16 @@ static inline bool is_writable_device_private_entry(swp_entry_t entry)
 	return unlikely(swp_type(entry) == SWP_DEVICE_WRITE);
 }
 
-static inline swp_entry_t make_readable_device_exclusive_entry(pgoff_t offset)
+static inline swp_entry_t make_device_exclusive_entry(pgoff_t offset)
 {
-	return swp_entry(SWP_DEVICE_EXCLUSIVE_READ, offset);
-}
-
-static inline swp_entry_t make_writable_device_exclusive_entry(pgoff_t offset)
-{
-	return swp_entry(SWP_DEVICE_EXCLUSIVE_WRITE, offset);
+	return swp_entry(SWP_DEVICE_EXCLUSIVE, offset);
 }
 
 static inline bool is_device_exclusive_entry(swp_entry_t entry)
 {
-	return swp_type(entry) == SWP_DEVICE_EXCLUSIVE_READ ||
-		swp_type(entry) == SWP_DEVICE_EXCLUSIVE_WRITE;
+	return swp_type(entry) == SWP_DEVICE_EXCLUSIVE;
 }
 
-static inline bool is_writable_device_exclusive_entry(swp_entry_t entry)
-{
-	return unlikely(swp_type(entry) == SWP_DEVICE_EXCLUSIVE_WRITE);
-}
 #else /* CONFIG_DEVICE_PRIVATE */
 static inline swp_entry_t make_readable_device_private_entry(pgoff_t offset)
 {
@@ -227,12 +217,7 @@ static inline bool is_writable_device_private_entry(swp_entry_t entry)
 	return false;
 }
 
-static inline swp_entry_t make_readable_device_exclusive_entry(pgoff_t offset)
-{
-	return swp_entry(0, 0);
-}
-
-static inline swp_entry_t make_writable_device_exclusive_entry(pgoff_t offset)
+static inline swp_entry_t make_device_exclusive_entry(pgoff_t offset)
 {
 	return swp_entry(0, 0);
 }
@@ -242,10 +227,6 @@ static inline bool is_device_exclusive_entry(swp_entry_t entry)
 	return false;
 }
 
-static inline bool is_writable_device_exclusive_entry(swp_entry_t entry)
-{
-	return false;
-}
 #endif /* CONFIG_DEVICE_PRIVATE */
 
 #ifdef CONFIG_MIGRATION
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 516b1d847e2cd..9cb6ab7c40480 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -225,14 +225,6 @@ static long change_pte_range(struct mmu_gather *tlb,
 				newpte = swp_entry_to_pte(entry);
 				if (pte_swp_uffd_wp(oldpte))
 					newpte = pte_swp_mkuffd_wp(newpte);
-			} else if (is_writable_device_exclusive_entry(entry)) {
-				entry = make_readable_device_exclusive_entry(
-							swp_offset(entry));
-				newpte = swp_entry_to_pte(entry);
-				if (pte_swp_soft_dirty(oldpte))
-					newpte = pte_swp_mksoft_dirty(newpte);
-				if (pte_swp_uffd_wp(oldpte))
-					newpte = pte_swp_mkuffd_wp(newpte);
 			} else if (is_pte_marker_entry(entry)) {
 				/*
 				 * Ignore error swap entries unconditionally,
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 509c6ef8de400..c2b3600429a0c 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -196,9 +196,8 @@ EXPORT_SYMBOL(__page_table_check_pud_clear);
 /* Whether the swap entry cached writable information */
 static inline bool swap_cached_writable(swp_entry_t entry)
 {
-	return is_writable_device_exclusive_entry(entry) ||
-	    is_writable_device_private_entry(entry) ||
-	    is_writable_migration_entry(entry);
+	return is_writable_device_private_entry(entry) ||
+	       is_writable_migration_entry(entry);
 }
 
 static inline void page_table_check_pte_flags(pte_t pte)
diff --git a/mm/rmap.c b/mm/rmap.c
index 0cd2a2d3de00d..1129ed132af94 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2492,7 +2492,7 @@ struct page *make_device_exclusive(struct mm_struct *mm, unsigned long addr,
 	 * do_swap_page() will trigger the conversion back while holding the
 	 * folio lock.
 	 */
-	entry = make_writable_device_exclusive_entry(page_to_pfn(page));
+	entry = make_device_exclusive_entry(page_to_pfn(page));
 	swp_pte = swp_entry_to_pte(entry);
 	if (pte_soft_dirty(fw.pte))
 		swp_pte = pte_swp_mksoft_dirty(swp_pte);
-- 
2.48.1

