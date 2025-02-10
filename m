Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A023D24E4DA
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216339; cv=none; b=cA+JTfD0ZVsq76/nSUGwhq2w/2/7dC3jheyHs510JiGa5wu841ggCPnzJkEwu5b8jNo5P9JO72D+jDhR4Yelggt3ryX0SgbEXnBVX8gpbWO8CSmo7FJxRolZbgseS4rziWTIeOBuTzLVqodaboIW06S9WOW6AKid/h6o69bxpD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216339; c=relaxed/simple;
	bh=OGZL6ZsQM7FmXrtZCcJrdgAs8xmw1WSnlW2HAWblnM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvV1qHcK7v5BuRGunpfXvx8sp6Ck0IZcpWAgN5RLD6Ywn2Op337/Fgivf7pkcClRDq0KP0vcmVsCVvj2hXGrUoD3xW0eHLa/HD8L5+a8Gi4uJK8lMCK5Vr8dfEkOwAjpDqkxgI7oLSD2Eei99DhgVe5d7x6g+nBW0oVNZXscvsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XdOo9gMS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XdOo9gMS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwHnciP+OvnJG9alUSG9/jEypyVF3ZPTXQLV9dVcfyg=;
	b=XdOo9gMSZSqnTHaKJ0tOLousfIs0hjXtmEzkgMEz2eSxUVfAzvpHxj4meMF2bBPtdpXstL
	hWX61uB23xzGHmHcdP/app0H72bz+KGiTWMlWwzroOcPFCfEjTyISGJcNgRyLAVS+3QSOw
	rndLTExp5bS29vrEFs24ZbrWSe2MNvc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-rCx4_k4pMluFplB0mlXtng-1; Mon, 10 Feb 2025 14:38:55 -0500
X-MC-Unique: rCx4_k4pMluFplB0mlXtng-1
X-Mimecast-MFC-AGG-ID: rCx4_k4pMluFplB0mlXtng
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38dc709f938so1785921f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 11:38:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216334; x=1739821134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwHnciP+OvnJG9alUSG9/jEypyVF3ZPTXQLV9dVcfyg=;
        b=clnaBoXf/KNCunQFJwlbmBLPGmvrr/j30/Bq1ZzXuVZdhvldsOzJLWd+HHb+TU+9jP
         l2JFmukev1SxkbPhX5XuxbxtqHfHOyeTWAm6kns9Ga0CSpaXmFzysSXCshO9tfMe9XQX
         57P7k4k2TNY02/uUji5HTBxv7TKTGTE/xUSIYIa9BAr4aTLq5vd8vQ5yC78KURSNToup
         D95234ed1G5C+nfpEv3de+S2wUyv7NP265wSsVb+77qPjYyIprE+TVBEuAwRBd9MZw/N
         GLnLbKlXO4Zojqlcw7OTELA2758PoyYARn3pQqfk6b0x2VplWtVEhDzwBLVUR9jwSNLU
         99EA==
X-Forwarded-Encrypted: i=1; AJvYcCURx7n3aSQW+YLy62jI4mqrTlCMyoMLO9qVWyy3eOOkWQgyUUhxn1NPSTkJ4WM8voF8JOIbmU/uWhLTlZF6SbVE@vger.kernel.org
X-Gm-Message-State: AOJu0Yye/lOiQFGQJdTy6OQRpXNotTEhh9M54GU5mlAk1zsbFu56n5b/
	Urx8hrhUFcIE8EhPdUF5hEsr2isuQ8XvEU1GMOf2INfRoLmIkhvK/VGBVMtj7jTJ/tpC98Vkor5
	l1jis1o4u+3YWrT1M8jNusxSXadH1ShBvM2w7C3jc+Ijh35f9E/wuFo0xy9h2MLN1fDI=
X-Gm-Gg: ASbGncsigQgaBnADrcvvPpiQe9Zh4Hh5N5SAmehq1Vsd1h9NULcGGbAy4jIeZRBc2v1
	TPggByLZ0dciukT6/duYC62ZNRQCxPxKCWq8BckdikuauIvB0lvmHVA9LPnqRv1QyUIr6wZ78L4
	3CNjD9YS7eh5Lmc4y6W0hvNoLtufEMSZ2PEvfCIiOqY+XWtUeN0D0Z+ECvXf4DzadVFzF+Hhb31
	uwxboSLNJWaZsDzpUr029XfyuG3be8xpxHS3moLqmUBuFM7eyYWw5T2X//JI+tgBSoBGk1BM9LE
	/fkgnwvuPVrKTliik+irhbpzJbQOnaMk6kdSGpMnUkmNbb001sr6VBPASVTZ8VZobQ==
X-Received: by 2002:a5d:5f42:0:b0:38d:df15:2770 with SMTP id ffacd0b85a97d-38de432d90fmr568624f8f.0.1739216333913;
        Mon, 10 Feb 2025 11:38:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQ8jI3Pr0PhgIrX5XFi88nBpwoaMc1TLFqexlyUt/iDFsCN9k6Hzlrlovdfu0/+3mYproMTQ==
X-Received: by 2002:a5d:5f42:0:b0:38d:df15:2770 with SMTP id ffacd0b85a97d-38de432d90fmr568579f8f.0.1739216333460;
        Mon, 10 Feb 2025 11:38:53 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4390db11200sm187831345e9.38.2025.02.10.11.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:38:52 -0800 (PST)
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
Subject: [PATCH v2 13/17] mm/page_idle: handle device-exclusive entries correctly in page_idle_clear_pte_refs_one()
Date: Mon, 10 Feb 2025 20:37:55 +0100
Message-ID: <20250210193801.781278-14-david@redhat.com>
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

page_idle_clear_pte_refs_one() is not prepared for that, so let's
teach it what to do with these PFN swap PTEs. Note that device-private
entries are so far not applicable on that path, as page_idle_get_folio()
filters out non-lru folios.

Should we just skip PFN swap PTEs completely? Possible, but it seems
straight forward to just handle them correctly.

Note that we could currently only run into this case with
device-exclusive entries on THPs. We still adjust the mapcount on
conversion to device-exclusive; this makes the rmap walk
abort early for small folios, because we'll always have
!folio_mapped() with a single device-exclusive entry. We'll adjust the
mapcount logic once all page_vma_mapped_walk() users can properly
handle device-exclusive entries.

Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_idle.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/page_idle.c b/mm/page_idle.c
index 947c7c7a37289..408aaf29a3ea6 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -62,9 +62,14 @@ static bool page_idle_clear_pte_refs_one(struct folio *folio,
 			/*
 			 * For PTE-mapped THP, one sub page is referenced,
 			 * the whole THP is referenced.
+			 *
+			 * PFN swap PTEs, such as device-exclusive ones, that
+			 * actually map pages are "old" from a CPU perspective.
+			 * The MMU notifier takes care of any device aspects.
 			 */
-			if (ptep_clear_young_notify(vma, addr, pvmw.pte))
-				referenced = true;
+			if (likely(pte_present(ptep_get(pvmw.pte))))
+				referenced |= ptep_test_and_clear_young(vma, addr, pvmw.pte);
+			referenced |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE);
 		} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
 			if (pmdp_clear_young_notify(vma, addr, pvmw.pmd))
 				referenced = true;
-- 
2.48.1

