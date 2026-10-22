Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634249;
	b=IUHR1GcvoAKjHn2lxRHt/EpNxCdrHjShyieA7RcO1rcsbnoc29xxYhQKC2ioimDl7lrr
	 K5B11guQ4bnxc7D6FH92+LDZh70MxejjlY+xERAK9yZ7ukzIdMqVlFEFgb6OgPZGlKXSN
	 G4YHyAFbxa6XeeemPSoMZzFlNQ5MFQfiuPiGM2REzwCeyl1W3Apz/th+KW2ZyDby7I3Gb
	 Vtii90nr3HK8IvmQm7buH5J7Msmciz0vJw82b3Ae2VoYxq3Nc7bupDk26ze5OW+UfleNy
	 msS8RS6hEH09Go7zaRugsvZw+05CLb8Bmx81ENc/tDeW8c9+mCVzKW4UasXB+Dl9pVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/p+8Vl7+8PhXJMc34NF0xrQaeakIDsKG9S8+b35h8GU=;
	b=wo5/E4ofYtfDBet0XRpGkF29J3SGznglR58bMJqQVJGwg6zst6E/pJaF5MNNIPX0nBr/
	 9UNfomtJKJRvM9/kGOABaREbYjKSGeaQL8CgGz/1MOTq5ebtXKFS1qg1Cf9O/gs+AnodA
	 mgbYEwrj3PSQEQsu3T5wY0DmmOJRR4zZDsxUVoC6JVSg2yZGe1ue9/7VhLeI6oLbBBjte
	 Dk29dsNCycOMOqQdgyV3YQXa1n2ldJP5XWcksixI6DwwEXzRT5E1IXGmm/iuARZLRB7jt
	 vESEJUwn/VsMPFi8eu06QVvN6MMH8iP/IBsTX7VWOjJeQR03ZuzRvIjb8BrPhp6ylPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hz7IhKS8;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE87606A32A
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 01:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EE87606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hz7IhKS8
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e9995ce866so10258865ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 18:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792634248; x=1793239048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/p+8Vl7+8PhXJMc34NF0xrQaeakIDsKG9S8+b35h8GU=;
        b=hz7IhKS8JnGZgEIexGY3I/4re8TbOOzx4dsaeiqtAUO3Mlg2//pA7KdBy10wHrc/WE
         oQkv3BwN0H+jxhBBiDVnqP7ZwfcFe/Dxi8cDyAm0+6qK3rEA+Rcl2yt2on5K7RkFfAd1
         JjfV/kqtvP3+GekJ86lvyfLCOfqfl6iFx3ByUKBSkZqqEkHrve8O51W3bDBcuvkErXuh
         /WNVdOyxsOBwIwnKzPKYLibS8H+/yd9dtsUyWlLO/PUUQdtPF++7YKthKoC6GJwUm/GS
         Qwb9Ec4xTK+9kEgeBXfzU4KRlJJ0yqpphEfA5EmlI19T+diFkzHeCGq7ZMN2TI0CTJry
         Z0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634248; x=1793239048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/p+8Vl7+8PhXJMc34NF0xrQaeakIDsKG9S8+b35h8GU=;
        b=Zib4rY3VbwvUBvwPOfmw5it9LeVHrnyKJRFdPFpGO/BTgXS1Y+X0GXdpkj1Rpwf6qF
         qhT/jAtc9ffvXioVcoJFx11keZOXqk1egbABUHsWrOXWE/BX+yMypZ1gTGiO14S6Ahmf
         qcVuDlOUb6QH3TMtKtxQpYB3wSW7GbNZSRp3Xip1A+M3PTdBsXvQqHNGfMj5URp5ux3I
         1II1ASRiZp9f9G776Wl5uISoRLfqOsyRajQpPJcMn1DA8aiuG8DFe8VjnZVgu5cBBka/
         hHj6H3xwsWJoqzXMP9el9yGd4cFhEiDfUSTweJsA+5v13W/5pC1gQfybjMExW5tvfWa+
         Nduw==
X-Forwarded-Encrypted: i=1; AKwUvBxzKnVyT6qErRv999B3KR7J2HxyRJTEwrPnVacXnAJzSXqidyODKSzOX4BLoNz64VzfJuXWu3rWE5nBoL52r/rj@vger.kernel.org
X-Gm-Message-State: AFq9FYJL9QxyOE9iYGKXoSRcmJxl2pQEg7zs4OrAqnWJ7MZmL2zW/k0f
	PJ7MVZome93oXSlm9oiXFtKe9QZEG3n5a+og4zppbc5BULBMYG9EAwWR
X-Gm-Gg: AYBFou1oKu/1MHxCzRQknlO6/kac6xFddxOusA2OLqeWoab/NbNqS46MaDqXdQjFeRr
	CZBuLOL2NNZQ0syzielYJbsUpT+32Vnd/Ua+ZivGmc7qxH6V3JoFQ3qOZOOgOGo/kZbR/YQFehd
	BCiutk4n7XXcBu2uONWH3R3Z/AARk/HyQXcvB6MjtRUOjUooSX34BJKK2qoh0/AtfKZxOS2g7Ky
	gDtm4smMVP3KllyZuDbGMegA/7o+lVeHYc4gawW+R3OrkgOqpZETrHq6hTMbI3rAy4Un5cJA6op
	rP86ZioTLoo2IEKTHUZ1JNbvaQQIqywQUEr3hfbR4oT7DRspBnfQyXTthC0FixvDoDD7MtDn6AV
	OiWYEb1gpHi8ZsZzAM52mDlrtBedYJN/14tu4sZ6xcI1clAYcnHk4ieeLzTTDxdCsnh/8R8xIxh
	+7wrjQmBg2LdKpyfhIZCR+C33sJoMZATAOjy6OGWxk3mxGRkxbl54pViLX30pzw/CiM/TBn35yb
	jD6/Ccpep/YIk6yKhvoPPkztY7ADTx0P5OXv0NElXHNBu3Zw7powh4X3W/7SPC6IOlpVC8toaFu
	tfZMe/W2PJqr0/yExjFSCGSavRRPG7R5PNdzvYy0Ptzr7/iGsl80hAnOeQXEtHq7HyVr6Ig6PyQ
	ez0f51fXYDHXQcfee650CB29p
X-Received: by 2002:a17:902:da8e:b0:2e9:5829:9b41 with SMTP id d9443c01a7336-2ea43e20647mr33495795ad.37.1792634248345;
        Wed, 21 Oct 2026 18:57:28 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4addfbsm16725685ad.74.2026.10.21.18.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:57:27 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	oleg@redhat.com,
	peterz@infradead.org,
	mhiramat@kernel.org,
	jolsa@kernel.org,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	surenb@google.com,
	david@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	hughd@google.com,
	kees@kernel.org,
	mingo@redhat.com,
	tglx@kernel.org,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/9] uprobes: Don't run exit_mmap() under dup_mmap_sem
Date: Thu, 22 Oct 2026 01:57:05 +0000
Message-ID: <20261022015712.1297331-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

build_map_info() takes mm_users of every mm that maps the file and
register_for_each_vma() drops it after the visit. When the process has
exited meanwhile it's the last mmput(), and exit_mmap() of a large mm runs
with dup_mmap_sem held for writing. Every fork() in the system waits for
it. Use mmput_async().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/events/uprobes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 7709ea882477..6792004be6fa 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1250,7 +1250,7 @@ build_map_info(struct address_space *mapping, loff_t offset, bool is_register)
 
 	prev = curr;
 	while (curr) {
-		mmput(curr->mm);
+		mmput_async(curr->mm);
 		curr = curr->next;
 	}
 
@@ -1324,7 +1324,8 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
  unlock:
 		mmap_write_unlock(mm);
  free:
-		mmput(mm);
+		/* exit_mmap() of the last user must not run under dup_mmap_sem */
+		mmput_async(mm);
 		info = free_map_info(info);
 	}
  out:
-- 
2.55.0

