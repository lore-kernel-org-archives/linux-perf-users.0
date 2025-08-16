Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3D51EA7D2;
	Sat, 16 Aug 2025 03:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755314210; cv=none; b=RsM45SE6A20SNNpzRIhfzeu52azSHFoqvIYXzyMZj2HQziJz7Y6Te1KFKd4uDoDpOFTs1NdEMoD+XD9hMhFPcWGSRpSCwrjMN6dt17GN7sh5Ws/10lQSS/bZSc1pDNacVk67ez3X7kyJeApq1C27OzJy+UFXkxsUxYFZES6FH94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755314210; c=relaxed/simple;
	bh=RAhFOShrd57RG4i4WBYOJrKz76jaNj/ofUtwL8psRyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fta5zOcVTl/dvj+h2PXqu7zX0UA/OmXCyiPt2of4fgTGwRpsyAo4O+7nHEfVTUz8DbSD39fqJchOdYpEo5TPxCy5bClD8IJ3YHclPR0xWzOSGQijSwmav7YTc2HZB5fG+sazbi82yHoMSI6ALFyqhfZ94iRn2dJ1fmr2C/pmvlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0ZAg+KB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0ZAg+KB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2295C4CEF6;
	Sat, 16 Aug 2025 03:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755314210;
	bh=RAhFOShrd57RG4i4WBYOJrKz76jaNj/ofUtwL8psRyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g0ZAg+KBVUHaOH4FakMcg5AAiEnnT9zqlk1s1InmACeJi6IliQ3iDSTfbAruRx+ZC
	 XCiSodYXdHsU62RNjXA22hDRrGcqgkhqCHLwspuCzp+kCWFvU/EjVf1hdx2iwfSr9m
	 8fXSMwYJEszqml/FShjUphuUe+4CVjGBuMRB+zFwC5t6rbmXL0qmbskpz0vORfkJlY
	 tbJvYSNFI1j5JYpEBNlhqja0ILZlBHSQBZiwaEqb0semqHi1WYTw4atMTGzsiCGK7A
	 JwtjuVMYgpjY6E0pkuWC4ladWP3vom4fzMXaymizXl7B+GUo1dzx3yoHUzOVEt1k6o
	 jRA1qhmsXg1EQ==
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
Subject: [PATCH v5 10/12] perf annotate: Hide data-type for stack operation and canary
Date: Fri, 15 Aug 2025 20:16:33 -0700
Message-ID: <20250816031635.25318-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816031635.25318-1-namhyung@kernel.org>
References: <20250816031635.25318-1-namhyung@kernel.org>
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

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 99e976d254493de2..ea68b32da7ce584a 100644
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
@@ -1958,7 +1969,7 @@ static int disasm_line__snprint_type_info(struct disasm_line *dl,
 		return 1;
 
 	data_type = __hist_entry__get_data_type(apd->he, apd->arch, apd->dbg, dl, &offset);
-	if (data_type == NULL || data_type == NO_TYPE)
+	if (!needs_type_info(data_type))
 		return 1;
 
 	printed = scnprintf(buf, len, "\t\t# data-type: %s", data_type->self.type_name);
-- 
2.50.1

