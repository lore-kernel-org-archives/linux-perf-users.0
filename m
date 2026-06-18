Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C03D3FD13F;
	Thu, 18 Jun 2026 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795788; cv=none; b=uyfm4/eLPFKjqEZByqqNG3VNEXQBoGrbu7v/LA1CGPT2CRWN3/7Rj4FTr7e1FpdbLpohU4sQsYeyOG0TD8K+XnRjTxU33KbSxqvtxGhoqUnliFhTJVTCyCgt/lvrpHLyWYTZm7AhhahnarStVI+VvnSSHYKxw/bE0JKsEdvI8Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795788; c=relaxed/simple;
	bh=8Z3xwV/6GQhZARPC+6W004BfEgJFPFIEP6uW7N/YOkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKG47jWBgwM6W5AtMpP79LALeyBZbBnUS8w7JWgEahrXPuzmXCxYLMgW7za6bhjBinTyqd+OE0ZOULqXEG3f8LDbVQX+ZY7lfx92mEZVnsztjaD8VKk8sSp8wVNA1Njtu6D+flepZ2GnG6dskXOJ9Lmif/6WmvvL/j626bBfuek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSufCNTA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSufCNTA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278BD1F000E9;
	Thu, 18 Jun 2026 15:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795787;
	bh=D+QUsj/ZpLLWjABAuN1T9iR5LOfK4ZYb6QPuT9oUn8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SSufCNTA5h6pn8cFMp+Na7p42qqBiLd8RHLPto5ruKHQByHAGVjBNaeZobtukVeou
	 oFmDoxEv0F10PK7FBK4bj8R3mV+4HwPqM4cS+qStErvInEUpwmqD3lBCmBSqtOAZ1h
	 USOOpZFCu+xL/uJWHeBuWB1NDw502KN+WaARwtHRlL/lK1uKNuOqe34ebXCexXMWnf
	 PDvff6lBiFxc89UP5ms6ErAuhZj/NMHKlpJu7FXcd9RNhR5WYlBGh9Y0r3L1NtWkjZ
	 V/4oQsGJHEAff9FM+rhPAsmNuouLS0VYEyYlWnVcQQ7objMrXRuHVZBp8F6cT+S1Nr
	 JmBUD753j+IIw==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/7] encoders: Fix diagnostic messages for unexpected tags in enumerations
Date: Thu, 18 Jun 2026 12:16:03 -0300
Message-ID: <20260618151606.82747-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618151606.82747-1-acme@kernel.org>
References: <20260618151606.82747-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Print the actual unexpected child tag's name and id instead of the
parent enumeration's, so the diagnostic message is useful for debugging.

Fixes: a1b3ec41fcc2433d ("dwarf_loader: Initial support for DW_TAG_subprogram in DW_TAG_enumeration")
Assisted-by: Claude:claude-opus-4-6-1m
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_encoder.c     | 2 +-
 ctf_encoder.c     | 2 +-
 dwarves_fprintf.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index be880f3fdb32f792..12c22b003b7990bf 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1800,7 +1800,7 @@ static int32_t btf_encoder__add_enum_type(struct btf_encoder *encoder, struct ta
 	type__for_each_enumerator(etype, pos) {
 		if (pos->tag.tag != DW_TAG_enumerator) {
 			fprintf(stderr, "Unexpected DW_TAG_%s <%llx>, skipping it...\n",
-				dwarf_tag_name(tag->tag), tag__orig_id(tag, cu));
+				dwarf_tag_name(pos->tag.tag), tag__orig_id(&pos->tag, cu));
 			continue;
 		}
 		name = enumerator__name(pos);
diff --git a/ctf_encoder.c b/ctf_encoder.c
index 1c61c76ba20e06bc..f2c63c2b039026f8 100644
--- a/ctf_encoder.c
+++ b/ctf_encoder.c
@@ -157,7 +157,7 @@ static int enumeration_type__encode(struct tag *tag, const struct cu *cu, uint32
 	type__for_each_enumerator(etype, pos) {
 		if (pos->tag.tag != DW_TAG_enumerator) {
 			fprintf(stderr, "Unexpected DW_TAG_%s <%llx>, skipping it...\n",
-				dwarf_tag_name(tag->tag), tag__orig_id(tag, cu));
+				dwarf_tag_name(pos->tag.tag), tag__orig_id(&pos->tag, cu));
 			continue;
 		}
 		ctf__add_enumerator(ctf, pos->name, pos->value, &position);
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index a3c8b391b9222fcd..4b6edcce81ebce71 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -501,8 +501,8 @@ size_t enumeration__fprintf(const struct tag *tag, const struct cu *cu,
 						   (unsigned long long)pos->value);
 			break;
 		default:
-			printed += fprintf(fp, "/* Unexpected %s <%llx> */\n", dwarf_tag_name(tag->tag),
-					   tag__orig_id(tag, cu));
+			printed += fprintf(fp, "/* Unexpected %s <%llx> */\n", dwarf_tag_name(pos->tag.tag),
+					   tag__orig_id(&pos->tag, cu));
 			continue;
 		}
 		printed += fprintf(fp, ",\n");
-- 
2.54.0

