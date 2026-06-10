Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE8737CD47;
	Wed, 10 Jun 2026 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121239; cv=none; b=uZkb3jx37bp58oshtHVJAUvhidi8FYBxe8pZdXDJxpVWsQ1DdP0AJ2H9A6+m4sKPc7WprfBkkyYNyLTGZZwhy1L6ZxWCFwTKW8rC8QBXvZFgzn9evtsoJ+dIB2Igr3AO21kFSF8IwFB28lOPgSSwuY3aAhs/ioo8QReWq/qSnB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121239; c=relaxed/simple;
	bh=4em8vKNteIb1UNqt5h027Y3vkwepxSV6M7Ik10IMRwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gg2TIXjI9QtBADFpWki+ApPjbDCaa599GNONnQa9WehfO20nAcvadx5eljCKHv0y1wQ6fyWWmBu3AhZDJFSs1tHkCpyJ1DIbWXNPLYsq0gvZqQJlQldhZyTC7yI8u2epU1B7fp+8KwQAF3A2CJOAoYwmZTv+1Av/hC0j8rKAHL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/833uLC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/833uLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6741F00898;
	Wed, 10 Jun 2026 19:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121238;
	bh=gi9ig3P9K1UdZqjlNma4F0IVfW4ofvxuYalApT/6lDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B/833uLCGBg1zsAlepFLRkDq+B9rpcc0I2wuwsb4s8wVtiPDot7ljyJv+sclqXP0c
	 ofb6KD9XyHb/YSDXEl9DjCffNClkGe4ClRDuFAJ301cCbryjkN+mOb9U7JkXP5+xuh
	 WxZrzYSVfx+6fwg7ZhpyTod6+ihIT5/QRc7HqouXQywnHpAz93lzNBkJtPnijoTKsA
	 n0NloJpFus/yFmXUBxFuoFWffuPLI9+EhC5zzpy6VOjqHWzHZDiEI57al849EqZcQD
	 WySSRgfcHjg0gy0pPySyu22m6uV3/x9MQmZEDEhvmumiL7UU8D2XFeQynK9565HwuB
	 aA4/t3FxVZIlw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 22/23] perf symbols: Add bounds checks to elf_read_build_id() note iteration
Date: Wed, 10 Jun 2026 16:51:55 -0300
Message-ID: <20260610195157.2091137-23-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610195157.2091137-1-acme@kernel.org>
References: <20260610195157.2091137-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

elf_read_build_id() iterates ELF notes using pointer arithmetic
driven by n_namesz and n_descsz from the note headers.  Neither
the note header read nor the subsequent name/desc advances are
checked against the section boundary.  A malformed ELF file with
oversized note sizes causes out-of-bounds reads past the section
data buffer.

Add two bounds checks: verify the note header fits within the
remaining section data, and verify that namesz + descsz (after
alignment) fits before advancing the pointer.

Fixes: fd7a346ea292074e ("perf symbols: Filename__read_build_id should look at .notes section too")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 10902a5dc6dbe6cc..d84e2e031d430cf5 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -835,10 +835,24 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
 	ptr = data->d_buf;
 	while (ptr < (data->d_buf + data->d_size)) {
 		GElf_Nhdr *nhdr = ptr;
-		size_t namesz = NOTE_ALIGN(nhdr->n_namesz),
-		       descsz = NOTE_ALIGN(nhdr->n_descsz);
+		size_t namesz, descsz, remaining;
 		const char *name;
 
+		/* ensure the note header fits within the section */
+		if (ptr + sizeof(*nhdr) > data->d_buf + data->d_size)
+			break;
+
+		namesz = NOTE_ALIGN(nhdr->n_namesz);
+		descsz = NOTE_ALIGN(nhdr->n_descsz);
+
+		/* validate individually to avoid size_t overflow on 32-bit */
+		remaining = data->d_buf + data->d_size - ptr - sizeof(*nhdr);
+		if (namesz > remaining || descsz > remaining - namesz) {
+			pr_warning("%s: oversized note: n_namesz=%u, n_descsz=%u\n",
+				   __func__, nhdr->n_namesz, nhdr->n_descsz);
+			break;
+		}
+
 		ptr += sizeof(*nhdr);
 		name = ptr;
 		ptr += namesz;
-- 
2.54.0

