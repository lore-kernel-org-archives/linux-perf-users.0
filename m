Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F95221F24;
	Mon, 13 Apr 2026 06:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062276; cv=none; b=FDu8LfDYTV7noA0MSZfb8cQ/7mrrJPK0s5QQ2fKuPDkJCj6DUg+gc/ifjcmcPX1HucMxyjcnDXaD7Cw7Ikb0QTwkpoOX0tHLpx+U9I9ooD9jdetAJjUQ7dawje7GO1V+ycrQSRW6jQegs43ZVDQwTpcCzCmZU5SEYDlXwA5IBM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062276; c=relaxed/simple;
	bh=0WxP6V4lltu4CPt+d+BZQBR7Zepd6vN9kz+S6rOOdd0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umOxo1tagCIBMAYRqkpFzq403jlJoFr8l/fMThJ3ehsx+Jx0mJ3tC+XzK3dfND1UQvS4k1ASbWvAYRBadR+h0l9fkklj7DWzqRIDl0lCeO+2w7ttkStheRPKNPH41YwTjPm9D0z6OBGVDUDAyJbNDE/2QxyDS72nkYalqC48UcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4fvHNZ430Fzb7P3;
	Mon, 13 Apr 2026 14:21:18 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4fvHNY0B89zb7P3;
	Mon, 13 Apr 2026 14:21:17 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 8F3C57892;
	Mon, 13 Apr 2026 14:21:14 +0800 (CST)
Received: from SH-HV00110.Hygon.cn (172.19.26.208) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 13 Apr
 2026 14:21:16 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <akpm@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<muchun.song@linux.dev>, <osalvador@suse.de>,
	<linux-trace-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>, Huang
 Shijie <huangsj@hygon.cn>
Subject: [PATCH 1/3] mm: use mapping_mapped to simplify the code
Date: Mon, 13 Apr 2026 14:20:40 +0800
Message-ID: <20260413062042.804-2-huangsj@hygon.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413062042.804-1-huangsj@hygon.cn>
References: <20260413062042.804-1-huangsj@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

Use mapping_mapped() to simplify the code, make
the code tidy and clean.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/hugetlbfs/inode.c | 4 ++--
 mm/memory.c          | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3f70c47981de..ab5ac092d8a6 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -646,7 +646,7 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 
 	i_size_write(inode, offset);
 	i_mmap_lock_write(mapping);
-	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
+	if (mapping_mapped(mapping))
 		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0,
 				      ZAP_FLAG_DROP_MARKER);
 	i_mmap_unlock_write(mapping);
@@ -707,7 +707,7 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 
 	/* Unmap users of full pages in the hole. */
 	if (hole_end > hole_start) {
-		if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
+		if (mapping_mapped(mapping))
 			hugetlb_vmdelete_list(&mapping->i_mmap,
 					      hole_start >> PAGE_SHIFT,
 					      hole_end >> PAGE_SHIFT, 0);
diff --git a/mm/memory.c b/mm/memory.c
index 2f815a34d924..366054435773 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4297,7 +4297,7 @@ void unmap_mapping_folio(struct folio *folio)
 	details.zap_flags = ZAP_FLAG_DROP_MARKER;
 
 	i_mmap_lock_read(mapping);
-	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
+	if (unlikely(mapping_mapped(mapping)))
 		unmap_mapping_range_tree(&mapping->i_mmap, first_index,
 					 last_index, &details);
 	i_mmap_unlock_read(mapping);
@@ -4327,7 +4327,7 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 		last_index = ULONG_MAX;
 
 	i_mmap_lock_read(mapping);
-	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
+	if (unlikely(mapping_mapped(mapping)))
 		unmap_mapping_range_tree(&mapping->i_mmap, first_index,
 					 last_index, &details);
 	i_mmap_unlock_read(mapping);
-- 
2.43.0


