Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988C6285CB4;
	Wed, 16 Jul 2025 05:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752642064; cv=none; b=lD9+cu+mDRRGhwA758+pGURRuTvfSMhBLUUwhv5CerAdPaw0Rh9JWljNAiFhqywfWn0OsfZQtctKQrK+RIaCMy1cHMXViEAlpgIFWncGrFwD59d6mJEFyUJdNg4+VZlqWo/pdRqVSoFmOAqPBaqPS355DSX0zBI/fYwSNqcRobw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752642064; c=relaxed/simple;
	bh=dGkePWjxmc1b+xI6uDt27ho5uz1BYPXe3lQGO5In9qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJ/KZysgaJaCKcv/tJd1jvFXkQccorEUxlN3tYHCXU6oXf8oZRCAQsTXAHuLceynK+OxbSfRe8pwVdn9C+m9GkWfPP8U9x1f1+nOZXaNrf6COh+ltDyPvJlwmou4mVeEWbIzDfHOxZPObMoRigsszW/8rUbIm95yO4rhD1AEVcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLAN9u5J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLAN9u5J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9BEC4CEF4;
	Wed, 16 Jul 2025 05:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752642064;
	bh=dGkePWjxmc1b+xI6uDt27ho5uz1BYPXe3lQGO5In9qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLAN9u5J62zUALQZAN5GMiJHS5WpnqH3DqN6XpU+7eiq+eaTjsaVAXtI6gzRP1c/Y
	 2eA9AeK03ekrw3cKN0t8bcC0608NbmljYzTJhzsjlm1iFqllPwY/90bmOw5DshannT
	 ljX80Y+JpTFIWWHoQZ7zdSTW2bwEqpJOKsLXLmDOa+0OBNB0xkATwyLYLxuUHmjnSz
	 CXRK5sGtaQsJdQ670wDDoKfIdxZJG8itdbN/U34BTEWW6xM8meh/x7HL/8jYH4/Amf
	 qB7mtR0f2TB0eGxo+COCNADbXAitoCulAsaaQHuRLRWZsxWf0TFuniPolpB7d/EUZf
	 aBS+THNEou7sw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 8/8] perf annotate: Hide data-type for stack operation and canary
Date: Tue, 15 Jul 2025 22:00:54 -0700
Message-ID: <20250716050054.14130-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716050054.14130-1-namhyung@kernel.org>
References: <20250716050054.14130-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's mostly unnecessary to print when it has no actual type information
like in the stack operations and canary.  Let's have them if -v option
is given.

Before:
  $ perf annotate --code-with-type
  ...
         : 0    0xd640 <_dl_relocate_object>:
    0.00 :      0:       endbr64
    0.00 :      4:       pushq   %rbp           # data-type: (stack operation)
    0.00 :      5:       movq    %rsp, %rbp
    0.00 :      8:       pushq   %r15           # data-type: (stack operation)
    0.00 :      a:       pushq   %r14           # data-type: (stack operation)
    0.00 :      c:       pushq   %r13           # data-type: (stack operation)
    0.00 :      e:       pushq   %r12           # data-type: (stack operation)
    0.00 :     10:       pushq   %rbx           # data-type: (stack operation)
    0.00 :     11:       subq    $0xf8, %rsp
    ...
    0.00 :     d4:       testl   %eax, %eax
    0.00 :     d6:       jne     0xf424
    0.00 :     dc:       movq    0xf0(%r14), %rbx               # data-type: struct link_map +0xf0
    0.00 :     e3:       testq   %rbx, %rbx
    0.00 :     e6:       jne     0xf2dd
    0.00 :     ec:       cmpq    $0, 0xf8(%r14)         # data-type: struct link_map +0xf8
    ...

After:
         : 0    0xd640 <_dl_relocate_object>:
    0.00 :      0:       endbr64
    0.00 :      4:       pushq   %rbp
    0.00 :      5:       movq    %rsp, %rbp
    0.00 :      8:       pushq   %r15
    0.00 :      a:       pushq   %r14
    0.00 :      c:       pushq   %r13
    0.00 :      e:       pushq   %r12
    0.00 :     10:       pushq   %rbx
    0.00 :     11:       subq    $0xf8, %rsp
    ...
    0.00 :     d4:       testl   %eax, %eax
    0.00 :     d6:       jne     0xf424
    0.00 :     dc:       movq    0xf0(%r14), %rbx               # data-type: struct link_map +0xf0
    0.00 :     e3:       testq   %rbx, %rbx
    0.00 :     e6:       jne     0xf2dd
    0.00 :     ec:       cmpq    $0, 0xf8(%r14)         # data-type: struct link_map +0xf8
    ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 06ddc7a9f58722a4..6fc07971631ac8a3 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -765,6 +765,17 @@ __hist_entry__get_data_type(struct hist_entry *he, struct arch *arch,
 			    struct debuginfo *dbg, struct disasm_line *dl,
 			    int *type_offset);
 
+static bool needs_type_info(struct annotated_data_type *data_type)
+{
+	if (data_type == NULL || data_type == NO_TYPE)
+		return false;
+
+	if (verbose)
+		return true;
+
+	return (data_type != &stackop_type) && (data_type != &canary_type);
+}
+
 static int
 annotation_line__print(struct annotation_line *al, struct annotation_print_data *apd,
 		       struct annotation_options *opts, int printed,
@@ -844,7 +855,7 @@ annotation_line__print(struct annotation_line *al, struct annotation_print_data
 
 			data_type = __hist_entry__get_data_type(apd->he, apd->arch,
 								apd->dbg, dl, &offset);
-			if (data_type && data_type != NO_TYPE) {
+			if (needs_type_info(data_type)) {
 				char buf[4096];
 
 				printf("\t\t# data-type: %s",
@@ -2138,7 +2149,7 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 								apd->dbg,
 								disasm_line(al),
 								&offset);
-			if (data_type && data_type != NO_TYPE) {
+			if (needs_type_info(data_type)) {
 				char member[256];
 
 				printed = scnprintf(bf, sizeof(bf),
-- 
2.50.0

