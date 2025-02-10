Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FFF25A2A7
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216308; cv=none; b=E4So1dlQOvx5qj3MEEvFX5JO8K4yVxF9vh7pJKIDNtib7flkkeo/C2a/tedOkKK/G5W0qcxiqV7jD8LnDxQK8oj1MgRbuvuX6JNnGiu3OPZ8sPjQGdgG8avlMc7ZA1b8nwDnJ89obgDs9SteDqefPYxGAF0uWuaveLLSw5IPREI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216308; c=relaxed/simple;
	bh=L16e+mH6ktPBqGV6aP9/w+AaZ+mPEhmgfdTbdQ7/2+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riKe3maIGzqkNqZ8ftSOIB1+E2LsL7glGtIQdfe2Y2JwwshahjDFW3GAtQ2AgZizAD/cJrUPjAiop1R4CUoiDDYOJoRwrU4PJT6Qv9G6PxKjZy8bs9DD1ZSbkfPQohJ6vVnfohr2svXqq2K/JBUyQrY7KECU145Qs4Mf4c9ywJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfS4/8jo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfS4/8jo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mARFTZKeX08fN9+zJg7ejGdzGLsE2rU+aFhmUgxRNAg=;
	b=KfS4/8jodMlKiJVwcVyxdPzC5rjodW+uMZr1E8j5emxB1DZQa0h028WB4EWfwhXvsVqwl7
	XdxLCUvtYlmf8VpPiW6mmnp4VZIBl61gmUhchaV8OT8M/H68ydKZ6v5vyI3H0Q9pxqegqu
	zP7AZIx9CUxYsEcpL1X8EBneiTfF3oc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-q21Ea4xmPzuSws9CnGX_ug-1; Mon, 10 Feb 2025 14:38:24 -0500
X-MC-Unique: q21Ea4xmPzuSws9CnGX_ug-1
X-Mimecast-MFC-AGG-ID: q21Ea4xmPzuSws9CnGX_ug
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38de0201875so611253f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 11:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216303; x=1739821103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mARFTZKeX08fN9+zJg7ejGdzGLsE2rU+aFhmUgxRNAg=;
        b=bYC0DYAotCh02diXdGFfhuqd1c/dZE1ci1KKS73FTsPw6v19HPnXnJgZ+IF3w2L+5r
         rPuPRTsmE9UFbe9QmKah89RqE+pYryy4Yr8sJAdinZ3zd2LUvtlCjmP6Qx34K+eWZZ7T
         7zxKC26kn7EPEXNt9IdLaqzY78k6I3R8ONmG7HcHn9VfvDsF8owSSl4Qkkb6IpnO1RCG
         YdJrd+toM8fdc/H1FLYWIg5pPBInUxPj/3V7VnGwabx8/URUm6KvCgJtxJI/aRsDpKhX
         P7602edHn7n/C8XKpZL6Gi0tj+k06AAWBiuDRAo7gZLnv5q8cvELpx1ZEgN2Iu6U7AGE
         T/dg==
X-Forwarded-Encrypted: i=1; AJvYcCW7OwtF/A4MJ71MMtsmWOrWKvDAlxxsznyiCyl2fvqk1CRe8umQwv9yOOj1qTBTNqPb3OyZvIjOmMhgtj3P3cLN@vger.kernel.org
X-Gm-Message-State: AOJu0YxEXCGsdccMSk/TLZWjULi34kIEdVDNquovFiIwAPPjPia2mXgW
	6y+1ncT4Eruf9hveRSYiX5gRA/U+5VCvIuS5z8JVtwakaJrwla3JuPbbrkVySK9SFQMQtKNTi4p
	DxZ6KWKcpa1H01JbHE1rNE0708EcAkr8fb6kptp/r7pmNS2RFMOuxWlE2T8UnxvnKhAg=
X-Gm-Gg: ASbGncv9H4xqi6fSXCkDfDE/AGe7mKkv3NokcEZ6DDuakBRU2NI7ErAuvpvLcXTlADN
	ppquHDf0OIYgfgNwixDj8xDzUTW99bSK+SSva6KFIOINDZl5RmsG9G9RYzcssrMdIW3XfY+ZtF3
	9aCG1EMi1PzCaQwgrLv54AHcYn1FmrUfUHa1fci3avEzvtDT2J9XaWuPm7ylxauddZ2yH33nPn0
	XkR9Q/5FpHfEW23bA/6HPK23s55r68wDbeeEg57lN/wmxLWm9hO4xaIRnM13+mPCuZU+iKduwRp
	tfRCTIFQ2nFS/lMoryqn2N/6tEDtmBrEvFXnjiBn9qg8ek0DsVMjz7alw8UxL9Kzkg==
X-Received: by 2002:a05:6000:18a5:b0:38d:e33d:d0db with SMTP id ffacd0b85a97d-38de33dd2b2mr2312783f8f.14.1739216303472;
        Mon, 10 Feb 2025 11:38:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1Llhtf765OHh3Rdp8g77cDKhZyIe7rPLF3LamWfRFHXBXmPgwl/7uacqNHueSdZU9tH9+kA==
X-Received: by 2002:a05:6000:18a5:b0:38d:e33d:d0db with SMTP id ffacd0b85a97d-38de33dd2b2mr2312758f8f.14.1739216303053;
        Mon, 10 Feb 2025 11:38:23 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38dd3fc7ee5sm7734941f8f.39.2025.02.10.11.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:38:21 -0800 (PST)
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
Subject: [PATCH v2 05/17] mm/memory: detect writability in restore_exclusive_pte() through can_change_pte_writable()
Date: Mon, 10 Feb 2025 20:37:47 +0100
Message-ID: <20250210193801.781278-6-david@redhat.com>
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

Let's do it just like mprotect write-upgrade or during NUMA-hinting
faults on PROT_NONE PTEs: detect if the PTE can be writable by using
can_change_pte_writable().

Set the PTE only dirty if the folio is dirty: we might not
necessarily have a write access, and setting the PTE writable doesn't
require setting the PTE dirty.

From a CPU perspective, these entries are clean. So only set the PTE dirty
if the folios is dirty.

With this change in place, there is no need to have separate
readable and writable device-exclusive entry types, and we'll merge
them next separately.

Note that, during fork(), we first convert the device-exclusive entries
back to ordinary PTEs, and we only ever allow conversion of writable
PTEs to device-exclusive -- only mprotect can currently change them to
readable-device-exclusive. Consequently, we always expect
PageAnonExclusive(page)==true and can_change_pte_writable()==true,
unless we are dealing with soft-dirty tracking or uffd-wp. But reusing
can_change_pte_writable() for now is cleaner.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 539c0f7c6d545..ba33ba3b7ea17 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -723,18 +723,21 @@ static void restore_exclusive_pte(struct vm_area_struct *vma,
 	struct folio *folio = page_folio(page);
 	pte_t orig_pte;
 	pte_t pte;
-	swp_entry_t entry;
 
 	orig_pte = ptep_get(ptep);
 	pte = pte_mkold(mk_pte(page, READ_ONCE(vma->vm_page_prot)));
 	if (pte_swp_soft_dirty(orig_pte))
 		pte = pte_mksoft_dirty(pte);
 
-	entry = pte_to_swp_entry(orig_pte);
 	if (pte_swp_uffd_wp(orig_pte))
 		pte = pte_mkuffd_wp(pte);
-	else if (is_writable_device_exclusive_entry(entry))
-		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
+
+	if ((vma->vm_flags & VM_WRITE) &&
+	    can_change_pte_writable(vma, address, pte)) {
+		if (folio_test_dirty(folio))
+			pte = pte_mkdirty(pte);
+		pte = pte_mkwrite(pte, vma);
+	}
 
 	VM_BUG_ON_FOLIO(pte_write(pte) && (!folio_test_anon(folio) &&
 					   PageAnonExclusive(page)), folio);
-- 
2.48.1

