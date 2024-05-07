Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72E8A93C;
	Tue,  7 May 2024 04:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715055220; cv=none; b=cvSfamZGRUi5PCu1chdkzRr1mt61pT8K/f53R++AKch0FWJ5kw396omWgmwv82A3th/aLgCIinczYYReEXpDpLQ3b5RTQn85oNE1rMCedle0LFQXe4/goIla8dQKfitJbpj2pSo74QCm7DxAOfyI0RUuPe+AT1t1A3Ki8lMOsqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715055220; c=relaxed/simple;
	bh=dN7X54J93eDiO9uLDsvJZ+5zjtYlYn/Su5NC4HEspTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N2FPuZePUIha9YiQ5T1fcebUMN3sUHRUpvHjy6oyxb53tssbeV4qZdcDnsQNKkMcls+zVYWIAdlf6oim4/aXKL8Puj9zWxXEQF+lHnoFitaNLrOAteWCuiL3eH9+FjpTrT8BktahkMa7S2TIRNi47+3oJVBYqe1S3DvGf9jjEKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKvjkxGR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKvjkxGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D8FC2BBFC;
	Tue,  7 May 2024 04:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715055220;
	bh=dN7X54J93eDiO9uLDsvJZ+5zjtYlYn/Su5NC4HEspTY=;
	h=From:To:Cc:Subject:Date:From;
	b=aKvjkxGR1+4drcXwiFonJt7HTraV5UAJscPVqV7kT3M6KhyuBSvhVmG7HS40FUX79
	 ielvzYYMD013TCwFzdLYy1gByxP8Tm+dhvuwAoxZOCAhAiSrVKXE/2a/7IpHODeO9j
	 JIbzsH6WGmpnFbKjx7jXQPsk87g2uvzXJt6e6tNE14KdN++9csC8R1Phzl1vRrCtuy
	 6e4CcxdsRW6WPgHH1/YZMH0IZ400KJfOk/RI7hGPePdyi2ADonOm0IcFmLjlG54HiU
	 HnTu/suD+AbWV1sccl8wMbZBXVWvgTc/KwB8x9oIWjVAUPZlRn8QsZZSxIbCtmqojY
	 SceIaTOBUZwBQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] perf dwarf-aux: Print array type name with "[]"
Date: Mon,  6 May 2024 21:13:38 -0700
Message-ID: <20240507041338.2081775-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's confusing both pointers and arrays are printed as *.  Let's print
array types with [] so that we can identify them easily.  Although it's
interchangable, sometimes it can cause confusion with size like in the
below example.

Note that it is not the same with C syntax where it goes to the variable
names, but we want to have it in the type names (like in Go language).

Before:
  mov [20] 0x68(reg5) -> reg0 type='struct page**' size=0x80 (die:0x4e61d32)

After:
  mov [20] 0x68(reg5) -> reg0 type='struct page*[]' size=0x80 (die:0x4e61d32)

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index c0a492e65388..ec988f294497 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1110,8 +1110,10 @@ int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
 	const char *tmp = "";
 
 	tag = dwarf_tag(type_die);
-	if (tag == DW_TAG_array_type || tag == DW_TAG_pointer_type)
+	if (tag == DW_TAG_pointer_type)
 		tmp = "*";
+	else if (tag == DW_TAG_array_type)
+		tmp = "[]";
 	else if (tag == DW_TAG_subroutine_type) {
 		/* Function pointer */
 		return strbuf_add(buf, "(function_type)", 15);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

