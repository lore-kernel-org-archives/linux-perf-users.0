Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCB01DBB3A;
	Sat, 14 Jun 2025 04:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749876222; cv=none; b=TTRn/G7xE5/poNyTtyW4RLeXipB1H6Pr5Hgh44nkVSo9lF5vIImrK7KIhq4xdp+lOjfOyhaULwfSQ8UBZ5PbEZsRPSUeuAel9xXgxJTLO+uOdYXye1ts7OuIsNTLhiwIWACzqyHt+HxFtX79VoPa+6yQUaFpwiADN0fzLCSQqrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749876222; c=relaxed/simple;
	bh=dzshMKCTThoIISZ/hbu/5/BBKFX5VGz2/btDz3gC8bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odlAypuY1EdIQ8VxSTlYMMtz1n69OL5uur//4TdwUnovHINVnMujRnuC6reTRKVT6D7Qdx5ObNgy2tXQQ3MOGJ4BUsExqxCcvvqdd/uGUoKuyC0xc1thfRvCc3u4bM/1YMOdX6ZLfy5AMfpjuW2YLNjQ7WhmCch30+cXJVjN9UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9mqhlcg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9mqhlcg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA9FC4CEF8;
	Sat, 14 Jun 2025 04:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749876222;
	bh=dzshMKCTThoIISZ/hbu/5/BBKFX5VGz2/btDz3gC8bA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n9mqhlcgqqSJJxw8lyV44X97bY2fgediJIjgbdc8ZgQlIdrI0ar8mCXnB5Yf7k1vZ
	 6Fp5b92ZjMP7cw9wAKIkhiKj/JqGWUwg6rQ3ZMb8/qjIxLv6FEDRcnFCSInM8Ksnma
	 wfh1+MHISROEmHr/TRLlwTSbWGt2od6jz48i8+M/7C8IRIzks1ywALtwVl4L8smSnD
	 GRje3t8CyuONwyfT6anRVI6ICB78Fq1B7JXfKfaVju5QjgLeRe+rdqfRV37LLkNFIU
	 CKjXkBu+YG13bIYp66ZyVLMquIPhdLvSc92BgLQB2bMJkYTN5gcpuB6JSoGj0a2LPv
	 qW1e4xWMbtOiw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Yuzhuo Jing <yuzhuo@google.com>
Subject: [PATCH v2 3/4] perf genelf: Remove libcrypto dependency and use built-in sha1()
Date: Fri, 13 Jun 2025 21:41:32 -0700
Message-ID: <20250614044133.660848-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250614044133.660848-1-ebiggers@kernel.org>
References: <20250614044133.660848-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuzhuo Jing <yuzhuo@google.com>

genelf is the only file in perf that depends on libcrypto (or openssl)
which only calculates a Build ID (SHA1, MD5, or URANDOM).  SHA1 was
expected to be the default option, but MD5 was used by default due to
previous issues when linking against Java.  This commit switches genelf
to use the in-house sha1(), and also removes MD5 and URANDOM options
since we have a reliable SHA1 implementation to rely on.  It passes the
tools/perf/tests/shell/test_java_symbol.sh test.

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tools/perf/util/genelf.c | 85 ++--------------------------------------
 1 file changed, 3 insertions(+), 82 deletions(-)

diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index cdce7f173d00a..fcf86a27f69e1 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -10,45 +10,25 @@
 #include <sys/types.h>
 #include <stddef.h>
 #include <libelf.h>
 #include <string.h>
 #include <stdlib.h>
-#include <unistd.h>
 #include <inttypes.h>
-#include <fcntl.h>
 #include <err.h>
 #ifdef HAVE_LIBDW_SUPPORT
 #include <dwarf.h>
 #endif
 
 #include "genelf.h"
+#include "sha1.h"
 #include "../util/jitdump.h"
 #include <linux/compiler.h>
 
 #ifndef NT_GNU_BUILD_ID
 #define NT_GNU_BUILD_ID 3
 #endif
 
-#define BUILD_ID_URANDOM /* different uuid for each run */
-
-#ifdef HAVE_LIBCRYPTO_SUPPORT
-
-#define BUILD_ID_MD5
-#undef BUILD_ID_SHA	/* does not seem to work well when linked with Java */
-#undef BUILD_ID_URANDOM /* different uuid for each run */
-
-#ifdef BUILD_ID_SHA
-#include <openssl/sha.h>
-#endif
-
-#ifdef BUILD_ID_MD5
-#include <openssl/evp.h>
-#include <openssl/md5.h>
-#endif
-#endif
-
-
 typedef struct {
   unsigned int namesz;  /* Size of entry's owner string */
   unsigned int descsz;  /* Size of the note descriptor */
   unsigned int type;    /* Interpretation of the descriptor */
   char         name[0]; /* Start of the name+desc data */
@@ -69,11 +49,11 @@ static char shd_string_table[] = {
 };
 
 static struct buildid_note {
 	Elf_Note desc;		/* descsz: size of build-id, must be multiple of 4 */
 	char	 name[4];	/* GNU\0 */
-	char	 build_id[20];
+	u8	 build_id[SHA1_DIGEST_SIZE];
 } bnote;
 
 static Elf_Sym symtab[]={
 	/* symbol 0 MUST be the undefined symbol */
 	{ .st_name  = 0, /* index in sym_string table */
@@ -90,69 +70,10 @@ static Elf_Sym symtab[]={
 	  .st_other = ELF_ST_VIS(STV_DEFAULT),
 	  .st_size  = 0, /* for now */
 	}
 };
 
-#ifdef BUILD_ID_URANDOM
-static void
-gen_build_id(struct buildid_note *note,
-	     unsigned long load_addr __maybe_unused,
-	     const void *code __maybe_unused,
-	     size_t csize __maybe_unused)
-{
-	int fd;
-	size_t sz = sizeof(note->build_id);
-	ssize_t sret;
-
-	fd = open("/dev/urandom", O_RDONLY);
-	if (fd == -1)
-		err(1, "cannot access /dev/urandom for buildid");
-
-	sret = read(fd, note->build_id, sz);
-
-	close(fd);
-
-	if (sret != (ssize_t)sz)
-		memset(note->build_id, 0, sz);
-}
-#endif
-
-#ifdef BUILD_ID_SHA
-static void
-gen_build_id(struct buildid_note *note,
-	     unsigned long load_addr __maybe_unused,
-	     const void *code,
-	     size_t csize)
-{
-	if (sizeof(note->build_id) < SHA_DIGEST_LENGTH)
-		errx(1, "build_id too small for SHA1");
-
-	SHA1(code, csize, (unsigned char *)note->build_id);
-}
-#endif
-
-#ifdef BUILD_ID_MD5
-static void
-gen_build_id(struct buildid_note *note, unsigned long load_addr, const void *code, size_t csize)
-{
-	EVP_MD_CTX *mdctx;
-
-	if (sizeof(note->build_id) < 16)
-		errx(1, "build_id too small for MD5");
-
-	mdctx = EVP_MD_CTX_new();
-	if (!mdctx)
-		errx(2, "failed to create EVP_MD_CTX");
-
-	EVP_DigestInit_ex(mdctx, EVP_md5(), NULL);
-	EVP_DigestUpdate(mdctx, &load_addr, sizeof(load_addr));
-	EVP_DigestUpdate(mdctx, code, csize);
-	EVP_DigestFinal_ex(mdctx, (unsigned char *)note->build_id, NULL);
-	EVP_MD_CTX_free(mdctx);
-}
-#endif
-
 static int
 jit_add_eh_frame_info(Elf *e, void* unwinding, uint64_t unwinding_header_size,
 		      uint64_t unwinding_size, uint64_t base_offset)
 {
 	Elf_Data *d;
@@ -471,11 +392,11 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
 	}
 
 	/*
 	 * build-id generation
 	 */
-	gen_build_id(&bnote, load_addr, code, csize);
+	sha1(code, csize, bnote.build_id);
 	bnote.desc.namesz = sizeof(bnote.name); /* must include 0 termination */
 	bnote.desc.descsz = sizeof(bnote.build_id);
 	bnote.desc.type   = NT_GNU_BUILD_ID;
 	strcpy(bnote.name, "GNU");
 
-- 
2.49.0

