Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268BD1E47CC
	for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 03:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402804; cv=none; b=pGB7IopstU6V3u+sOCPznRnEJ/5ScX272us+6xYqIhB0JG5abSdrv1kwdb5ILzMOMMPjd2uuoFfMpyxy0xgqEKyt/QoufdbS8g/GAQ/K34/NvUOTyPBP0bmcJK6MzUoEGVqgSMMRhrfeFQs6w0Us+VPYWfphxIcbAKbDFwaYHIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402804; c=relaxed/simple;
	bh=IyXwtJLrxdIfaysBoqxVyV1K9s0htpjRBN+L5FIf8Jw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mv28EKlAGjL48oSAdJrNx2wzZLWpS2Q7nrbp4zdk8QWGpKh/R9QhuiMJ6jKaz1YA3dXN5tr0XHs2UnT79NE81PA5KmyZI0w6Q0e/e+lBZDqclqytMcNEns+NnLFi5VWKGZPTwTxh1vtFrumUZSTRo/2gerGWXArvW5aHhN2W430=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a7vjQryp; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a7vjQryp"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-310efe825ccso4036712a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 20:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748402802; x=1749007602; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZeVLDEhUDJmAFqCidyDGWPVhZk//2eKpKN6FRpBx+XE=;
        b=a7vjQrypnhNOoYwsIYH5V1uRBV6lOYP+xnrNSfmUwThfqeTS6RpA2TAVMixMchccR8
         Z0pBkPFFTizvLqKkjqHH4xKXMQ+xYenMu467zp1r5zS2es3Zdvk3OL/ALoHU3aKrL25Y
         2CKBfARzha3UXRBkKC2Mw5PU/KD++m9jth2jUj9YZZYvF/KiL2wqdpgJ0FmpcIwxiWRK
         ecHSBd6ngRHRXKkqR9lWtp8BNQSCoqZfCfr6A01FJ9r3u//P0OhRSewYYUKuAjMtppC0
         mDaTkjMAHGlHamHPl48fzPBH5JM1X2npLtRjpiP8ysjYpSXxEqd9Snr0NhF37jkkAShj
         GT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402802; x=1749007602;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeVLDEhUDJmAFqCidyDGWPVhZk//2eKpKN6FRpBx+XE=;
        b=E+ZNqOBWPlxpleq4eQkzqxmCSJfAkU54+eWk4C7x+SngOaw6La+GAu1+ad5vLQQzZg
         Kl1Jn/9CvU9GXy6dGYGMsrD/sbfHOGGkg8AWand7Z7MQKNRJMc937iu2oGkpgWWzBvFh
         Y3XuZa55tv/0ZBzzCtawdZwv/2VljZTLovfipdMRuXtY6Zb1IPwno4w4rIReUZx3UEAm
         gaOUpumPklJFtc+GzZierjqkRu4ICD58ztrC3FFiKWJQd03/XnuwsLSl7HfZ34+oEq6b
         /PMtvO/UJVrRL39HLRE6e00Y7rTcLbnusSAMx/jzT+McEWHUmFgwHVH2vvguFnDneyEm
         a94A==
X-Forwarded-Encrypted: i=1; AJvYcCXv0FLwHd6esCOEjjv1lqtchRV0yQXRy39i0E1OOJ5rQw3UtlHl5dkPvf68kDdq/H6t3yGAJ6iV4AmheWDZ+R07@vger.kernel.org
X-Gm-Message-State: AOJu0YxC8qc9WLDMBrh2Lm76Y6X2qm26NVM5I19E5PYs6eKD4X+LdCo7
	+iAv7/xO4Dsxzd21TI/ohVPtTnx7sfDoY8KD5+ruMbavt5K3eCyQ1S9EZFo6hVGYf6M2jzwkgJO
	QNQjYwYTjEg==
X-Google-Smtp-Source: AGHT+IF5/Db+YfQ6kRPHM9BBYAqg6LR/2oPo56seGYQ+IX3tevLyBAA7kqQ1Bn+Mj1RSMDeJA4slnRMqCIdt
X-Received: from pjbsn15.prod.google.com ([2002:a17:90b:2e8f:b0:30c:4b1f:78ca])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:19cd:b0:311:e637:2880
 with SMTP id 98e67ed59e1d1-311e637296emr1035928a91.26.1748402802410; Tue, 27
 May 2025 20:26:42 -0700 (PDT)
Date: Tue, 27 May 2025 20:26:31 -0700
In-Reply-To: <20250528032637.198960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250528032637.198960-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1238.gf8c92423fb-goog
Message-ID: <20250528032637.198960-2-irogers@google.com>
Subject: [PATCH v2 1/7] perf symbol: Fix use-after-free in filename__read_build_id
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The same buf is used for the program headers and reading notes. As the
notes memory may be reallocated then this corrupts the memory pointed
to by the phdr. Using the same buffer is in any case a logic
error. Rather than deal with the duplicated code, introduce an elf32
boolean and a union for either the elf32 or elf64 headers that are in
use. Let the program headers have their own memory and grow the buffer
for notes as necessary.

Before `perf list -j` compiled with asan would crash with:
```
==4176189==ERROR: AddressSanitizer: heap-use-after-free on address 0x5160000070b8 at pc 0x555d3b15075b bp 0x7ffebb5a8090 sp 0x7ffebb5a8088
READ of size 8 at 0x5160000070b8 thread T0
    #0 0x555d3b15075a in filename__read_build_id tools/perf/util/symbol-minimal.c:212:25
    #1 0x555d3ae43aff in filename__sprintf_build_id tools/perf/util/build-id.c:110:8
...

0x5160000070b8 is located 312 bytes inside of 560-byte region [0x516000006f80,0x5160000071b0)
freed by thread T0 here:
    #0 0x555d3ab21840 in realloc (perf+0x264840) (BuildId: 12dff2f6629f738e5012abdf0e90055518e70b5e)
    #1 0x555d3b1506e7 in filename__read_build_id tools/perf/util/symbol-minimal.c:206:11
...

previously allocated by thread T0 here:
    #0 0x555d3ab21423 in malloc (perf+0x264423) (BuildId: 12dff2f6629f738e5012abdf0e90055518e70b5e)
    #1 0x555d3b1503a2 in filename__read_build_id tools/perf/util/symbol-minimal.c:182:9
...
```

Note: this bug is long standing and not introduced by the other asan
fix in commit fa9c4977fbfb ("perf symbol-minimal: Fix double free in
filename__read_build_id").

Fixes: b691f64360ecec49 ("perf symbols: Implement poor man's ELF parser")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol-minimal.c | 168 +++++++++++++------------------
 1 file changed, 70 insertions(+), 98 deletions(-)

diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index d8da3da01fe6..36c1d3090689 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -90,11 +90,23 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 {
 	FILE *fp;
 	int ret = -1;
-	bool need_swap = false;
+	bool need_swap = false, elf32;
 	u8 e_ident[EI_NIDENT];
-	size_t buf_size;
-	void *buf;
 	int i;
+	union {
+		struct {
+			Elf32_Ehdr ehdr32;
+			Elf32_Phdr *phdr32;
+		};
+		struct {
+			Elf64_Ehdr ehdr64;
+			Elf64_Phdr *phdr64;
+		};
+	} hdrs;
+	void *phdr;
+	size_t phdr_size;
+	void *buf = NULL;
+	size_t buf_size = 0;
 
 	fp = fopen(filename, "r");
 	if (fp == NULL)
@@ -108,119 +120,79 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 		goto out;
 
 	need_swap = check_need_swap(e_ident[EI_DATA]);
+	elf32 = e_ident[EI_CLASS] == ELFCLASS32;
 
-	/* for simplicity */
-	fseek(fp, 0, SEEK_SET);
-
-	if (e_ident[EI_CLASS] == ELFCLASS32) {
-		Elf32_Ehdr ehdr;
-		Elf32_Phdr *phdr;
-
-		if (fread(&ehdr, sizeof(ehdr), 1, fp) != 1)
-			goto out;
+	if (fread(elf32 ? (void *)&hdrs.ehdr32 : (void *)&hdrs.ehdr64,
+		  elf32 ? sizeof(hdrs.ehdr32) : sizeof(hdrs.ehdr64),
+		  1, fp) != 1)
+		goto out;
 
-		if (need_swap) {
-			ehdr.e_phoff = bswap_32(ehdr.e_phoff);
-			ehdr.e_phentsize = bswap_16(ehdr.e_phentsize);
-			ehdr.e_phnum = bswap_16(ehdr.e_phnum);
+	if (need_swap) {
+		if (elf32) {
+			hdrs.ehdr32.e_phoff = bswap_32(hdrs.ehdr32.e_phoff);
+			hdrs.ehdr32.e_phentsize = bswap_16(hdrs.ehdr32.e_phentsize);
+			hdrs.ehdr32.e_phnum = bswap_16(hdrs.ehdr32.e_phnum);
+		} else {
+			hdrs.ehdr64.e_phoff = bswap_64(hdrs.ehdr64.e_phoff);
+			hdrs.ehdr64.e_phentsize = bswap_16(hdrs.ehdr64.e_phentsize);
+			hdrs.ehdr64.e_phnum = bswap_16(hdrs.ehdr64.e_phnum);
 		}
+	}
+	phdr_size = elf32 ? hdrs.ehdr32.e_phentsize * hdrs.ehdr32.e_phnum
+			  : hdrs.ehdr64.e_phentsize * hdrs.ehdr64.e_phnum;
+	phdr = malloc(phdr_size);
+	if (phdr == NULL)
+		goto out;
 
-		buf_size = ehdr.e_phentsize * ehdr.e_phnum;
-		buf = malloc(buf_size);
-		if (buf == NULL)
-			goto out;
-
-		fseek(fp, ehdr.e_phoff, SEEK_SET);
-		if (fread(buf, buf_size, 1, fp) != 1)
-			goto out_free;
-
-		for (i = 0, phdr = buf; i < ehdr.e_phnum; i++, phdr++) {
-			void *tmp;
-			long offset;
-
-			if (need_swap) {
-				phdr->p_type = bswap_32(phdr->p_type);
-				phdr->p_offset = bswap_32(phdr->p_offset);
-				phdr->p_filesz = bswap_32(phdr->p_filesz);
-			}
-
-			if (phdr->p_type != PT_NOTE)
-				continue;
-
-			offset = phdr->p_offset;
-			if (phdr->p_filesz > buf_size) {
-				buf_size = phdr->p_filesz;
-				tmp = realloc(buf, buf_size);
-				if (tmp == NULL)
-					goto out_free;
-				buf = tmp;
-			}
-			fseek(fp, offset, SEEK_SET);
-			if (fread(buf, phdr->p_filesz, 1, fp) != 1)
-				goto out_free;
+	fseek(fp, elf32 ? hdrs.ehdr32.e_phoff : hdrs.ehdr64.e_phoff, SEEK_SET);
+	if (fread(phdr, phdr_size, 1, fp) != 1)
+		goto out_free;
 
-			ret = read_build_id(buf, phdr->p_filesz, bid, need_swap);
-			if (ret == 0) {
-				ret = bid->size;
-				break;
-			}
-		}
-	} else {
-		Elf64_Ehdr ehdr;
-		Elf64_Phdr *phdr;
+	if (elf32)
+		hdrs.phdr32 = phdr;
+	else
+		hdrs.phdr64 = phdr;
 
-		if (fread(&ehdr, sizeof(ehdr), 1, fp) != 1)
-			goto out;
+	for (i = 0; i < elf32 ? hdrs.ehdr32.e_phnum : hdrs.ehdr64.e_phnum; i++) {
+		size_t p_filesz;
 
 		if (need_swap) {
-			ehdr.e_phoff = bswap_64(ehdr.e_phoff);
-			ehdr.e_phentsize = bswap_16(ehdr.e_phentsize);
-			ehdr.e_phnum = bswap_16(ehdr.e_phnum);
+			if (elf32) {
+				hdrs.phdr32[i].p_type = bswap_32(hdrs.phdr32[i].p_type);
+				hdrs.phdr32[i].p_offset = bswap_32(hdrs.phdr32[i].p_offset);
+				hdrs.phdr32[i].p_filesz = bswap_32(hdrs.phdr32[i].p_offset);
+			} else {
+				hdrs.phdr64[i].p_type = bswap_32(hdrs.phdr64[i].p_type);
+				hdrs.phdr64[i].p_offset = bswap_64(hdrs.phdr64[i].p_offset);
+				hdrs.phdr64[i].p_filesz = bswap_64(hdrs.phdr64[i].p_filesz);
+			}
 		}
+		if ((elf32 ? hdrs.phdr32[i].p_type : hdrs.phdr64[i].p_type) != PT_NOTE)
+			continue;
 
-		buf_size = ehdr.e_phentsize * ehdr.e_phnum;
-		buf = malloc(buf_size);
-		if (buf == NULL)
-			goto out;
-
-		fseek(fp, ehdr.e_phoff, SEEK_SET);
-		if (fread(buf, buf_size, 1, fp) != 1)
-			goto out_free;
-
-		for (i = 0, phdr = buf; i < ehdr.e_phnum; i++, phdr++) {
+		p_filesz = elf32 ? hdrs.phdr32[i].p_filesz : hdrs.phdr64[i].p_filesz;
+		if (p_filesz > buf_size) {
 			void *tmp;
-			long offset;
-
-			if (need_swap) {
-				phdr->p_type = bswap_32(phdr->p_type);
-				phdr->p_offset = bswap_64(phdr->p_offset);
-				phdr->p_filesz = bswap_64(phdr->p_filesz);
-			}
-
-			if (phdr->p_type != PT_NOTE)
-				continue;
 
-			offset = phdr->p_offset;
-			if (phdr->p_filesz > buf_size) {
-				buf_size = phdr->p_filesz;
-				tmp = realloc(buf, buf_size);
-				if (tmp == NULL)
-					goto out_free;
-				buf = tmp;
-			}
-			fseek(fp, offset, SEEK_SET);
-			if (fread(buf, phdr->p_filesz, 1, fp) != 1)
+			buf_size = p_filesz;
+			tmp = realloc(buf, buf_size);
+			if (tmp == NULL)
 				goto out_free;
+			buf = tmp;
+		}
+		fseek(fp, elf32 ? hdrs.phdr32[i].p_offset : hdrs.phdr64[i].p_offset, SEEK_SET);
+		if (fread(buf, p_filesz, 1, fp) != 1)
+			goto out_free;
 
-			ret = read_build_id(buf, phdr->p_filesz, bid, need_swap);
-			if (ret == 0) {
-				ret = bid->size;
-				break;
-			}
+		ret = read_build_id(buf, p_filesz, bid, need_swap);
+		if (ret == 0) {
+			ret = bid->size;
+			break;
 		}
 	}
 out_free:
 	free(buf);
+	free(phdr);
 out:
 	fclose(fp);
 	return ret;
-- 
2.49.0.1238.gf8c92423fb-goog

