Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D501325A321
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216316; cv=none; b=qBUBK3RrFxZ/4WC6aQEAamnscmAO8CeKchW6psZSssgbvFreQ99CZyb7qr5Om08aW4rSgRKL3KVelFH9b/iu3GRBDm/3jps+VasKpi2meAT8px1N36vSu9F01xPp62JSXqP0hyT2K4oki9H1BUGZ2cuAT4g/7EXO8EDkz9L7tmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216316; c=relaxed/simple;
	bh=WTAKrIObiH0+XnAmevo4XgmL855z4Fu5Qvoz089fAGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5GL2HSdvylFHUu7BoczIoKbbctHc3hZhC3BuDuNaMFDG50WskpRiCKWBtgNifz6WWtvs2+WH24vfnjG3C5iBM3S+lNhVs10DJK944lUztUWpksu9sFrjonAoJlMPTeNN76+H3joy1cXjc5WMMlNoaZNtrFrWIvcGeOXuoqXd48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fuR/tZua; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fuR/tZua"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPITbiV5yRtNZIanqm2v+SKlb5hdEoVu/zyhpD+AgeU=;
	b=fuR/tZuabeAN3RHCueQYmMmKXGcP+aIsicl1j4W0aOTKGy9nuOtaXTjpOJWY9SIHPqDlLx
	2HJuS4Ydqm7cRqlYbQoy6VQxslXHDmx2ahdbN5EyWTKP7dSlayTL4TaN7pvglPRGBevX8t
	NAMIoKbNC+g8PZkEc2sn4FtDYkhbVFc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-mrOlOz1bMmusjyYK9o5eNQ-1; Mon, 10 Feb 2025 14:38:32 -0500
X-MC-Unique: mrOlOz1bMmusjyYK9o5eNQ-1
X-Mimecast-MFC-AGG-ID: mrOlOz1bMmusjyYK9o5eNQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43933b8d9b1so12560295e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 11:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216311; x=1739821111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPITbiV5yRtNZIanqm2v+SKlb5hdEoVu/zyhpD+AgeU=;
        b=eUPrvPFHA85ay1NX9SJDH1LZNCXn/RxzX1XX65NacSa5FcN9hSCclpMk/4w6wAXe41
         s6QspTySSnSdsaOEWr0jNt86t9uVAQDJ4D/XHHjlgHxw1N2ocdIbluXA+EKQFBxRjt0o
         yZjCQwXNj2RTri0EkT+9Q5XKB4RYCEIjzWEvfRlcEPDEZIG3KJCKu83kWODR0XWcaXxo
         el8uZKmTyw0EeB5pP83haOY415B8nqabgxCFABP2pTNloQAC3jMsuhYizocRwTT5TN8M
         ygLhhv0lLwRkjKWFUQapxYlQUQKux4OQkThWBKZCtOtwQ7usUNFygWx73v9bbMS+vFum
         HthQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiXvQYpa8h6+/7w+axkWFVBw6q/+OUpZTQmT4cqsLcaD0CDPhcGJ4lNtxjZCyXrXPGTv5hLCNuRCj9UWXcnzjy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw86R7iDA3PMg77iOeuAxv9shcX3R9xugeXHsxsSehdDkYZSBdb
	rwHxBZstjDwBCHPEy6DEeKumLRvajlLbmbrra4PLBW+QRZNItvhgByTp58TkIeUu32I20EoPi4u
	ge2QzttrQPYhyY2IFtRtguhDvdd7T8vs3vbhSwXExeRgIbzBXdrR3HHcLA/0G35YhtnM=
X-Gm-Gg: ASbGncvPZgfApNp9TF6nAy2RHLGOVVz3Zg2zQO//g/O+irv/im7O+mOzxtrHriv5lpE
	Oq3fplNOd6i3u1W+CFw4iMtlZQZhgz+gflpYULZBxlZ2uUGZXVyv5Or1msim8hI/040CwTKJXy2
	XnYeshDv+NZSoNuPTPl1ous/Msh71eIZRQSUXTgOPSYypZZmjEMeiBYCWDPQjdUJPEAkdgeT0gR
	ka0bv0A7R5HibTWXekAOrOZ1ZL6QHO8B3eZZEPn+9vkbZpcKD4N5L9omOrawI7PJryS6326H1Mk
	bJBjiIdnxO2jH+C4aDKHDbyM5r/S7+8j6jFX0Fn0ioKFIAjj3hk1uYhxfIcD4IBfIQ==
X-Received: by 2002:a05:600c:500d:b0:439:3dc0:29b6 with SMTP id 5b1f17b1804b1-4393dc02be1mr57220155e9.2.1739216311475;
        Mon, 10 Feb 2025 11:38:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbUQzL3Yq1p3VwDR+lxH773I/PQZNBDcgTpUgE2nEJHxULXhio/DNj6yNxLtRtBjWIFSwTIg==
X-Received: by 2002:a05:600c:500d:b0:439:3dc0:29b6 with SMTP id 5b1f17b1804b1-4393dc02be1mr57220015e9.2.1739216311167;
        Mon, 10 Feb 2025 11:38:31 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4390d933523sm192523445e9.1.2025.02.10.11.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:38:29 -0800 (PST)
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
Subject: [PATCH v2 07/17] mm/page_vma_mapped: device-exclusive entries are not migration entries
Date: Mon, 10 Feb 2025 20:37:49 +0100
Message-ID: <20250210193801.781278-8-david@redhat.com>
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

It's unclear why they would be considered migration entries; they are
not.

Likely we'll never really trigger that case in practice, because
migration (including folio split) of a folio that has device-exclusive
entries is never started, as we would detect "additional references":
device-exclusive entries adjust the mapcount, but not the refcount.

Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_vma_mapped.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 81839a9e74f16..32679be22d30c 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -111,8 +111,7 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
 			return false;
 		entry = pte_to_swp_entry(ptent);
 
-		if (!is_migration_entry(entry) &&
-		    !is_device_exclusive_entry(entry))
+		if (!is_migration_entry(entry))
 			return false;
 
 		pfn = swp_offset_pfn(entry);
-- 
2.48.1

