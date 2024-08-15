Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB514D2B8;
	Thu, 15 Aug 2024 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723761506; cv=none; b=MZvPLnAUTdeHl4i91gvRD+VCvqvrdz4/M2gjdL9bKfp3MKGx8VNYH56YWC3/9+Sj8HqwzGnU7rQ+Mj9owzjkqUOOvzuCmc/fuqhOPaeBNbm1bW5wNo3YtHY8ovfOCNpNjnpzfB02srtAmOJKmoSeE9UVE4XujAOxEyINokV5b34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723761506; c=relaxed/simple;
	bh=0hxY12D/IW1rjA2V5O/ly52/sioF1NDEALpOM8QJMs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uWS3FCjlgQCGwOnC9FXn16ANpqtsltUrYGr/hdK2My8MY96UZy5gttNyTLg9OBtjMXbLPxs5DcYEARyWxTjUJ3BhDXhUyx1BgeRiktO6/zTQ/1EUy8fYKlX55OkY2INPN9ZFHi+rruXkYWx8Ggo9tpDR0m++kNl22GCQRxUreuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzADGnsu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzADGnsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BA5C32786;
	Thu, 15 Aug 2024 22:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723761506;
	bh=0hxY12D/IW1rjA2V5O/ly52/sioF1NDEALpOM8QJMs0=;
	h=From:To:Cc:Subject:Date:From;
	b=SzADGnsuxV1qZv0UBsdT5yA6xXeYbVYtvYgxspepQ3c3xFZRIeK3IUk4gE6pxl0tY
	 SNNTDoL0S1qwtPqaf7N7RSSPMF9oZh/7LrCZGy2JVuQL+o5nzKByDof/OtgipAn4xr
	 h0hI5mq+d/kjKACUR/1bB9Tn4q9R58J4vTUhXFwYQ/u4liQH1Hq4AFxj9sRPIUvK6I
	 Ri8IPvwCYvHW+k6+DaSJMSu54TR14/OvPRHgrCzhLQdlFGONIr4D2bxACGEtk8cqBi
	 QK+aRO1dE/Q2AScTnXZfg+JunFehJhnagf69ezwfwvdhuaSKN7w9Ge9n+swVEeWJs5
	 pPjcylblnAEwA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH] perf annotate-data: Set bitfield member offset and size properly
Date: Thu, 15 Aug 2024 15:38:23 -0700
Message-ID: <20240815223823.2402285-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bitfield members might not have DW_AT_data_member_location.  Let's
use DW_AT_data_bit_offset to set the member offset correct.  Also use
DW_AT_bit_size for the name like in a C program.

Before:
  Annotate type: 'struct sk_buff' (1 samples)
        Percent     Offset       Size  Field
  -      100.00          0        232  struct sk_buff {
  +        0.00          0         24      union  ;
  +        0.00         24          8      union  ;
  +        0.00         32          8      union  ;
           0.00         40         48      char[] cb;
  +        0.00         88         16      union  ;
           0.00        104          8      long unsigned int      _nfct;
         100.00        112          4      unsigned int   len;
           0.00        116          4      unsigned int   data_len;
           0.00        120          2      __u16  mac_len;
           0.00        122          2      __u16  hdr_len;
           0.00        124          2      __u16  queue_mapping;
           0.00        126          0      __u8[] __cloned_offset;
           0.00          0          1      __u8   cloned;
           0.00          0          1      __u8   nohdr;
           0.00          0          1      __u8   fclone;
           0.00          0          1      __u8   peeked;
           0.00          0          1      __u8   head_frag;
           0.00          0          1      __u8   pfmemalloc;
           0.00          0          1      __u8   pp_recycle;
           0.00        127          1      __u8   active_extensions;
  +        0.00        128         60      union  ;
           0.00        188          4      sk_buff_data_t tail;
           0.00        192          4      sk_buff_data_t end;
           0.00        200          8      unsigned char* head;

After:
  Annotate type: 'struct sk_buff' (1 samples)
        Percent     Offset       Size  Field
  -      100.00          0        232  struct sk_buff {
  +        0.00          0         24      union  ;
  +        0.00         24          8      union  ;
  +        0.00         32          8      union  ;
           0.00         40         48      char[] cb
  +        0.00         88         16      union  ;
           0.00        104          8      long unsigned int      _nfct;
         100.00        112          4      unsigned int   len;
           0.00        116          4      unsigned int   data_len;
           0.00        120          2      __u16  mac_len;
           0.00        122          2      __u16  hdr_len;
           0.00        124          2      __u16  queue_mapping;
           0.00        126          0      __u8[] __cloned_offset;
           0.00        126          1      __u8   cloned:1;
           0.00        126          1      __u8   nohdr:1;
           0.00        126          1      __u8   fclone:2;
           0.00        126          1      __u8   peeked:1;
           0.00        126          1      __u8   head_frag:1;
           0.00        126          1      __u8   pfmemalloc:1;
           0.00        126          1      __u8   pp_recycle:1;
           0.00        127          1      __u8   active_extensions;
  +        0.00        128         60      union  ;
           0.00        188          4      sk_buff_data_t tail;
           0.00        192          4      sk_buff_data_t end;
           0.00        200          8      unsigned char* head;

Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 34 +++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index ff85d190e3ac..d9e0ca61b6b5 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -202,7 +202,7 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	struct annotated_member *parent = arg;
 	struct annotated_member *member;
 	Dwarf_Die member_type, die_mem;
-	Dwarf_Word size, loc;
+	Dwarf_Word size, loc, bit_size = 0;
 	Dwarf_Attribute attr;
 	struct strbuf sb;
 	int tag;
@@ -226,15 +226,37 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	if (dwarf_aggregate_size(&die_mem, &size) < 0)
 		size = 0;
 
-	if (!dwarf_attr_integrate(die, DW_AT_data_member_location, &attr))
-		loc = 0;
-	else
+	if (dwarf_attr_integrate(die, DW_AT_data_member_location, &attr))
 		dwarf_formudata(&attr, &loc);
+	else {
+		/* bitfield member */
+		if (dwarf_attr_integrate(die, DW_AT_data_bit_offset, &attr) &&
+		    dwarf_formudata(&attr, &loc) == 0)
+			loc /= 8;
+		else
+			loc = 0;
+
+		if (dwarf_attr_integrate(die, DW_AT_bit_size, &attr) &&
+		    dwarf_formudata(&attr, &bit_size) == 0)
+			size = (bit_size + 7) / 8;
+	}
 
 	member->type_name = strbuf_detach(&sb, NULL);
 	/* member->var_name can be NULL */
-	if (dwarf_diename(die))
-		member->var_name = strdup(dwarf_diename(die));
+	if (dwarf_diename(die)) {
+		if (bit_size) {
+			if (asprintf(&member->var_name, "%s:%ld",
+				     dwarf_diename(die), (long)bit_size) < 0)
+				member->var_name = NULL;
+		} else {
+			member->var_name = strdup(dwarf_diename(die));
+		}
+
+		if (member->var_name == NULL) {
+			free(member);
+			return DIE_FIND_CB_END;
+		}
+	}
 	member->size = size;
 	member->offset = loc + parent->offset;
 	INIT_LIST_HEAD(&member->children);
-- 
2.46.0.184.g6999bdac58-goog

