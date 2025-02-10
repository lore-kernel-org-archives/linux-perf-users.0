Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C0D2505DB
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 19:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216347; cv=none; b=U5XUfyJI2DiCM2qiCpl4kDy8mLV+ymmtVrxKMBxy22JH5pRTgGgRVeVvNyq2mqZHd0QIFHNVK7dKbtqf9R9WVKePCtwPk8FT5AUoZ8wwZVK3qON+rvk4z7F4l9F7gbO40mMINPNfXZKqfB6Kf4OegB+GJDxTc/4HFWGN04bP2Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216347; c=relaxed/simple;
	bh=eeTQic3U3Pz3ShuuvH4rmh3qdHr2tcndU+mn29E8LNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BiJnbeRQZzA+uPVoJ4eAJvvBq6VF4qlR4fHdjYzUC1r5ZTmcwEVZizTJHwJD/K0jOsQVLkPGF92nFwJHg3C30r4/eoi/hb/tJBwq1Q33qaNM888IxAVE7O0c3JWjtgTDPt/0qdi1WBH/t+zs6mQlsX8u9ERB0xts+93PztfwOEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GIf9EIBn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIf9EIBn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNpxFEEEyxoH6lwF3K+DQE9+aA/s7jzY02gjXCRiBPg=;
	b=GIf9EIBn800qN8VHy/2XREBmN6R5F0adch97q/LfMYsUscssVKg/l3JjSI6U+i/GbpwRES
	rIhLWnGtc310tcF1GdqaNnsWkeGLJ/zonzpPLva9jrv5Ewy2ckvxNAXf2wH430W5PNaHvS
	7ag4kxrkQJt81nwFebuCflIHl4volCc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-tY6MX0uYOAKp_n9Zshp0qA-1; Mon, 10 Feb 2025 14:39:03 -0500
X-MC-Unique: tY6MX0uYOAKp_n9Zshp0qA-1
X-Mimecast-MFC-AGG-ID: tY6MX0uYOAKp_n9Zshp0qA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38de0201875so611365f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 11:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216342; x=1739821142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNpxFEEEyxoH6lwF3K+DQE9+aA/s7jzY02gjXCRiBPg=;
        b=aR3Q4xaBDh6cYAiyi0uwfvxFG3dC+HHcJ1QPdoyZIetF3qqajH45S45S1W/03X3Cxz
         +TFsjfWE+QetGomjcWNP5cksBDn5XrTmXL9/oVSpaSAC0JbZHa3Pg3cPay0ikn2l029F
         9udYKuwWCNub4ud1tuKZtBsyXW1BYdX+9dnGwPjaryJrjPXcDKBAk52zlmJweW4amlmJ
         Mg0aPwDBHECWnqV88cObjF0Fq8CeorkCskXjFyS7kdtWOufBqoSWqWyKsK8mBnaS4PYe
         kD3LC92Sd8nDsHBmM5ER7J+VekrR3k/UZHZtBVGHHXFBmZ9pggEJc4pLE61cEEkNkUqk
         5dZg==
X-Forwarded-Encrypted: i=1; AJvYcCWFg0ZCSVpuqtGX7gulDkvJ/pqQCzvne9TMeHrDvv2x+g4iVXB+Cr9WQTbhcmeKV3sO8FnB+4WGkKbgrm5GqQOn@vger.kernel.org
X-Gm-Message-State: AOJu0YzkEGWhbIdkWzJajAs2dv7n/naT5dl6MY9nVCD3d94R6Kj0SLCd
	Wa0kAl24u2LMbB1NP4cI1LE9NCsd6SCPEjuigOjpR9SzyXZOcpzQw7O4uZ/Wq7WArsESGCKlZgz
	3ldLs8IyC4qbwHkrfuBbHcXGZ4oj03QIzYh3se4llmOhHP4uaAcNcUCZtG2sFFLUzj+8=
X-Gm-Gg: ASbGncsUobq4FeEJWRVES1xOT/Lymde4PmyuerP9EW0WxeVH2jTVjH+waT3ftE0bcHF
	ZkqLHuBO5K83KITqQ3EcdDLDKEPelC3p/3PW2mUY5zOwOSvP+HBzcWyAkgtavE5y9FtflcRJBlA
	tw5ZtjSUi/SGfqQBJk1NzeeOB+HPPcfFzBirhO37eIAgHidWFwZZj8NeJrWR+x7ky4ZcOmWMUJB
	k50KwTko14uLjVv6S2EpckHl+zWuPDkAnTUi1g/5wf4N9dUzwrJLm22FR5uh/V9+FSok+vq5jNj
	Po9RcR/JWUYRzEjXbKlK3zw+X7AEhGN/9UXMNc+AsXT1zPr6kqsLwdGehrqTz2fsZA==
X-Received: by 2002:a05:6000:1813:b0:38a:418e:21c7 with SMTP id ffacd0b85a97d-38dc935246fmr8277023f8f.53.1739216342062;
        Mon, 10 Feb 2025 11:39:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTiiTPkwAyfuLx0qL+LO6PapdaXuVNjUwBeGg/Z0ah/0RffyIckymQJ3LkKa1NUzxInLX6yQ==
X-Received: by 2002:a05:6000:1813:b0:38a:418e:21c7 with SMTP id ffacd0b85a97d-38dc935246fmr8276996f8f.53.1739216341643;
        Mon, 10 Feb 2025 11:39:01 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38dc4d00645sm11916376f8f.66.2025.02.10.11.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:39:00 -0800 (PST)
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
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 15/17] mm/damon: handle device-exclusive entries correctly in damon_folio_mkold_one()
Date: Mon, 10 Feb 2025 20:37:57 +0100
Message-ID: <20250210193801.781278-16-david@redhat.com>
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

Ever since commit b756a3b5e7ea ("mm: device exclusive memory access")
we can return with a device-exclusive entry from page_vma_mapped_walk().

damon_folio_mkold_one() is not prepared for that and calls
damon_ptep_mkold() with PFN swap PTEs. Teach damon_ptep_mkold() to deal
with these PFN swap PTEs. Note that device-private entries are so far not
applicable on that path, as damon_get_folio() filters out non-lru
folios.

Should we just skip PFN swap PTEs completely? Possible, but it seems
straight forward to just handle it correctly.

Note that we could currently only run into this case with
device-exclusive entries on THPs. We still adjust the mapcount on
conversion to device-exclusive; this makes the rmap walk
abort early for small folios, because we'll always have
!folio_mapped() with a single device-exclusive entry. We'll adjust the
mapcount logic once all page_vma_mapped_walk() users can properly
handle device-exclusive entries.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/damon/ops-common.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index d25d99cb5f2bb..86a50e8fbc806 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -9,6 +9,8 @@
 #include <linux/page_idle.h>
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
 
 #include "ops-common.h"
 
@@ -39,12 +41,29 @@ struct folio *damon_get_folio(unsigned long pfn)
 
 void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr)
 {
-	struct folio *folio = damon_get_folio(pte_pfn(ptep_get(pte)));
+	pte_t pteval = ptep_get(pte);
+	struct folio *folio;
+	bool young = false;
+	unsigned long pfn;
+
+	if (likely(pte_present(pteval)))
+		pfn = pte_pfn(pteval);
+	else
+		pfn = swp_offset_pfn(pte_to_swp_entry(pteval));
 
+	folio = damon_get_folio(pfn);
 	if (!folio)
 		return;
 
-	if (ptep_clear_young_notify(vma, addr, pte))
+	/*
+	 * PFN swap PTEs, such as device-exclusive ones, that actually map pages
+	 * are "old" from a CPU perspective. The MMU notifier takes care of any
+	 * device aspects.
+	 */
+	if (likely(pte_present(pteval)))
+		young |= ptep_test_and_clear_young(vma, addr, pte);
+	young |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE);
+	if (young)
 		folio_set_young(folio);
 
 	folio_set_idle(folio);
-- 
2.48.1

