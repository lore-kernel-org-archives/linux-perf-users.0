Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCCE296162
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Mar 2025 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103336; cv=none; b=AY5mxmNHXcfqbIw+9koEn7D3BcG33tmLA1LqPASPljWysoEBVBHXEI75KRVdKJUf17yTUkPKOQnRlhK35u+WjPtq1Cku6jFrlLxZgQWR8gTEeRTyxw5ct2Tx3KabhDMU4JQHot3l3JMFLQrMq7FTlhwER3/UeJpJ0E+880vVYrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103336; c=relaxed/simple;
	bh=uyHJhziojFGk/tam8soDl9qH4ruNaNMd8RrIguscx8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEHkEgdeSxEyiQtb33NA+MnFwrTG+rvigXnuEaNBiacvoNls64wJdEjGMa5pTbblj6cByAnpQ7P5P5LgmHqZoUjbtmSsWawKyVOQtuCdBdt/X4+7UsnWXoEaDPNt/jAAcCx7vvzJF/BbownlSxDLG97/WOiTRmGr+sSc/fRB4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKutrPIG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKutrPIG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741103333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RHlzy1ROEWhQbxxG4Yv+rRoMty5ce9tc18f8MaHZsU=;
	b=GKutrPIGTOmggsj984Y/kxh3ZALAk8h/GMHqNfHqou/2uLVS5uHmfJaeZFcMOWPWkNQWFZ
	/Sgzy7nfaRCsbGjWPYukrAgBfUcUjVk/atX63+G4yiyA2SP3o/WHwgXyPklQtNFsIl2Tns
	LJh5JK9c9f5CKNIgOTVTOKFhvvbQOHM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-3r_NvbdUNcafYdP7rNEsHA-1; Tue, 04 Mar 2025 10:48:52 -0500
X-MC-Unique: 3r_NvbdUNcafYdP7rNEsHA-1
X-Mimecast-MFC-AGG-ID: 3r_NvbdUNcafYdP7rNEsHA_1741103331
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43bd0257945so1298595e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Mar 2025 07:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741103331; x=1741708131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RHlzy1ROEWhQbxxG4Yv+rRoMty5ce9tc18f8MaHZsU=;
        b=ZZiXrkHn8irr7RGEvNZQumJTqALntD9Lk/rPUAuXZEhxCQkVlQ+bxy/BndfQK3z/Bw
         jTbh119NxaqpfuMnwbbaUUu6yxUkgviFbBLZ62nv4yTvhZxUXXtSZP2qt2mOF3KZHvyY
         Av+Tr05HLmB+rS6oLfb+P4k3rO330rWwCyICsPJSnOxd0LyAHDwRBdId4ngh031RhYIF
         ViIVUWL98uiEG5H8opa80+P7z/yZ1uFXYhArG/NK+IXf+8sgEVwHCgNe5MTLTClEXyJQ
         rChG3uCBgilhxbgwvzWB28i3kPTYL3ioNNh2j2XtcChIA7+RlZtB2o2rIfYlYd2ejJU4
         Uz9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXw4h8L/nahQplBA0v4pn1K9AUZYlcOF4PJBh+6f1V2r7pvGoCEosAJQodetXdCG1Hu6O+tR92lmrWVjEUesdlG@vger.kernel.org
X-Gm-Message-State: AOJu0YzDshOm2ujpUhfieaciETQ/933NHnQ8N/IY+8WtmtNbBcYYadlb
	o18q/B7mYETzWuMDacsRlOMOIJ9o20J/ywO9zyOzGGKJix6t+Brrs4ad8OErNwc6nPDs7rtpBPQ
	tblQ8oHlFEYaw2HzNgZB4MqMUv7TyCdFxJAhE9zgFSmXpu1GsYTt9aBm31ZH9ez27bNc=
X-Gm-Gg: ASbGncs4W8eCcnWO+Q2/jrBLCv/G5dNykjSK78DL5VZTgw8L/23LjxiYv1+pEgs52it
	5AkIr+a5yiZ+syDQtnXdF7rYgbc6upAq/hxbxgGG366NZEHL7Tg42KgNZnf6sYgTGmR1gaIvnBU
	PIAQmQJW1Zh43A3igC+2amUOXYB5xzCmCTzJuw9a8auPNA9/WKB2PqAQUcKNJRD7Le8wWwMQ767
	lnzSBZLLH+PGVvpc68aQ4gA8ryEP3BmjQR9ehf029ghnGMPesSOKXNoTerjO0MMz3i5XCR/bzA9
	xAJV2piT7uG9CQxeclXMOUKX42HTdx/0KOsl8fza3t0vXSnxuvdRDnSGpB9F7BA/TKhCpZ0EtvD
	B
X-Received: by 2002:a5d:5847:0:b0:390:e94c:453e with SMTP id ffacd0b85a97d-390eca070b2mr17839155f8f.39.1741103331034;
        Tue, 04 Mar 2025 07:48:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS2yQ2nIm92Fqm8oP87QtIsIbeZe5pQ0O0ho/Z0iCYCjljpWAZZP5v8ry/LGiAu8oiIQK1RQ==
X-Received: by 2002:a5d:5847:0:b0:390:e94c:453e with SMTP id ffacd0b85a97d-390eca070b2mr17839137f8f.39.1741103330643;
        Tue, 04 Mar 2025 07:48:50 -0800 (PST)
Received: from localhost (p200300cbc73610009e302a8acd3d419c.dip0.t-ipconnect.de. [2003:cb:c736:1000:9e30:2a8a:cd3d:419c])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e485d906sm18206420f8f.90.2025.03.04.07.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 07:48:50 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH -next v1 1/3] kernel/events/uprobes: pass VMA instead of MM to remove_breakpoint()
Date: Tue,  4 Mar 2025 16:48:44 +0100
Message-ID: <20250304154846.1937958-2-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304154846.1937958-1-david@redhat.com>
References: <20250304154846.1937958-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

... and remove the "MM" argument from install_breakpoint(), because it
can easily be derived from the VMA.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/events/uprobes.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 8fc53813779a4..991aacc80d0e0 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1134,10 +1134,10 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
 	return ret;
 }
 
-static int
-install_breakpoint(struct uprobe *uprobe, struct mm_struct *mm,
-			struct vm_area_struct *vma, unsigned long vaddr)
+static int install_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
+		unsigned long vaddr)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	bool first_uprobe;
 	int ret;
 
@@ -1162,9 +1162,11 @@ install_breakpoint(struct uprobe *uprobe, struct mm_struct *mm,
 	return ret;
 }
 
-static int
-remove_breakpoint(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
+static int remove_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
+		unsigned long vaddr)
 {
+	struct mm_struct *mm = vma->vm_mm;
+
 	set_bit(MMF_RECALC_UPROBES, &mm->flags);
 	return set_orig_insn(&uprobe->arch, mm, vaddr);
 }
@@ -1296,10 +1298,10 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 		if (is_register) {
 			/* consult only the "caller", new consumer. */
 			if (consumer_filter(new, mm))
-				err = install_breakpoint(uprobe, mm, vma, info->vaddr);
+				err = install_breakpoint(uprobe, vma, info->vaddr);
 		} else if (test_bit(MMF_HAS_UPROBES, &mm->flags)) {
 			if (!filter_chain(uprobe, mm))
-				err |= remove_breakpoint(uprobe, mm, info->vaddr);
+				err |= remove_breakpoint(uprobe, vma, info->vaddr);
 		}
 
  unlock:
@@ -1472,7 +1474,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 			continue;
 
 		vaddr = offset_to_vaddr(vma, uprobe->offset);
-		err |= remove_breakpoint(uprobe, mm, vaddr);
+		err |= remove_breakpoint(uprobe, vma, vaddr);
 	}
 	mmap_read_unlock(mm);
 
@@ -1610,7 +1612,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
 		if (!fatal_signal_pending(current) &&
 		    filter_chain(uprobe, vma->vm_mm)) {
 			unsigned long vaddr = offset_to_vaddr(vma, uprobe->offset);
-			install_breakpoint(uprobe, vma->vm_mm, vma, vaddr);
+			install_breakpoint(uprobe, vma, vaddr);
 		}
 		put_uprobe(uprobe);
 	}
-- 
2.48.1

