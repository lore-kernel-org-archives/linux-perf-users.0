Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFE22C0F63
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 02:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479602; cv=none; b=dKATJHEWPCQ1oRKOafb/HtEjjTopXXPT+5asSmuL4do+Vk/1HQXWz9+PYl9KCgcgtOUqTuamZN5Fs4aliavdGtTCOWYCeov5VdKBdfBqGtaFhX+1NMAJ4AqdYp5uuOAKdhowhU4ywCLzTYRng7O+sn023IAJjuJiZcQkUQcgpp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479602; c=relaxed/simple;
	bh=SoMJumxPd4W2dw4TJ+tdyjRZta389m1tZHjTj6591bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBGL9l/75Qz5RHATJAHvs497jqCRwjMNAPXTKHDw1UQC2kEm39At3BjrKXi+byLqJm6D0usVY0pFrrpEcgJsVqVjn51m6tlQ+D/lOeVk8c3PS8irQvfCrBiCMkg8WblzoNjTqYqcVmgyzxtleDJlUclQ2WDDVIzv/QCS2pTvFXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=fMk6hrak; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="fMk6hrak"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78f89501423so55810927b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 18:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1769479599; x=1770084399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEdogTaDxzCQioYG14x9ed5a66Fqemos79HWYjw4Gx4=;
        b=fMk6hrakbIcwGZiZY5V0M2CHU3dYcC5DHHrYURBVxSGVxSh89KRf+6ABCNEPnde13K
         GdOkd4/o3jMbx56Tx1lmexWtuRU90RNFs/wMro5cATpzrJJOWLkGU4zGEWpNtbY2jeFj
         7APjH+KLA1GR7VEwzPw6JE5FOTzJhfhjbfKzYCRbH97FCzq6WZ+Yc9J+svgY647PgXPv
         IPtI+lvocB5jJcHTXmHnRWigffcE+8qKK5S4TP4hwVcLjaLo04Ox62YIFN2CG8R5AGZF
         yibJvX6a9nUccFLm3QsR+IEPGQZ9lK9GPqpU/GdfkRyv0ptxWu7Hp0IfUmjAYFla6Do9
         LgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769479599; x=1770084399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jEdogTaDxzCQioYG14x9ed5a66Fqemos79HWYjw4Gx4=;
        b=XDC4I35pTVbayca/Gik31lJ/r4xGRRL0aDsxoUZJYM93GmcWye6EJ4vP5EpVRUA6hV
         EifNWRhITO+6kCRvEjtNhS5SubMV1GElAy8ZB8nFxYGAqc6uRhVzu79mOIT9rOnbnnaK
         71tAFMwVWFHM+Me+Numw17lRjRZm2sshf4FLVCd2x/jLjryI5/u1Y+9z9yuLh94DpEMg
         NE+ElrcQa0CscCb04DGSqOu+ZqX+bC9AUHSLbu4a5x55GQfc2Ow/PPQxTsFD8fRDEp88
         c9AtbVspCsbJllueA/K9nTYde2Yg3RkPZ/kIE9ZTPcUUoaDefp6VfGjdfYbvXS9Cf8AE
         iuoA==
X-Forwarded-Encrypted: i=1; AJvYcCX2kVw8R67WlB2AlI4qf6Heki1aEru4PejiOyXU1J1aJnAfAvKXA5yBIKI+EBQem32Q6ivXod6WlSDB2+5DF42C@vger.kernel.org
X-Gm-Message-State: AOJu0YwLmGc9hem6TIs7smuWhv/8J3P4n29SfGqzKlICqeF2pIXJVdZL
	ncFfLzXaTZht0YMXH/k2sKuw7fuHejX8A6SxMDp3sz75R2S7mDINF0/CekQ5ZXXhZw==
X-Gm-Gg: AZuq6aIayQCj/Qx4nEfD0IJ75OtmjOllrNq1S4S2+yFRfiI7MYW0zMbkp/SG+l5ajhX
	3hu9rqRYAY5qY5+HC9L77iGRgVg7uFAnr6sIEPEuGb7x/d9CWYWacFv8AqB4sjW4rtQdmEeyZa4
	Q/GSio6/RUkhxqoSH6kbKKiVbFj0fUqmpqb82sId9ii3v5vD3YADlydIPffbzT8lO7G99DBaQat
	GN8SsYdhbeh+Nh8vVvdxcK4SIGFXFXSNk46It3YmWEu3MzdoDvK3uhl0Ba7h6mXnGfAQ1iUXLGL
	rlLOTLkV3pdx6q8nC8QcnGiAU5bNxtSAA/BiRpXpMBNySbdRtjH4dog9bnUT3Y8u3CWE6SilNtU
	vmep9UUsGiZkm3IToRgZBcqfmqyDumLNsGOqmKeN/Zvb+OsqhLZej1Tfl0ezefV0UdniVcWq/0l
	OU2DR0GufU9w==
X-Received: by 2002:a05:690e:c4a:b0:63f:b2b3:8c2d with SMTP id 956f58d0204a3-6498faa7712mr48308d50.17.1769479599102;
        Mon, 26 Jan 2026 18:06:39 -0800 (PST)
Received: from um773-cachyos ([2600:1700:cc0:94af:eca6:9ff9:6f3c:5de9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6496855d65esm4217415d50.12.2026.01.26.18.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:06:38 -0800 (PST)
From: Zecheng Li <zli94@ncsu.edu>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Zecheng Li <zli94@ncsu.edu>,
	xliuprof@google.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 05/11] perf dwarf-aux: Handle array types in die_get_member_type
Date: Mon, 26 Jan 2026 21:04:58 -0500
Message-ID: <20260127020617.2804780-6-zli94@ncsu.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127020617.2804780-1-zli94@ncsu.edu>
References: <20260127020617.2804780-1-zli94@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a struct member is an array type, die_get_member_type() would stop
iterating since array types weren't handled in the loop. This caused
accesses to array elements within structs to not resolve properly.

Add array type handling by resolving the array to its element type and
calculating the offset within an element using modulo arithmetic

This improves type annotation coverage for struct members that are
arrays.

Signed-off-by: Zecheng Li <zli94@ncsu.edu>
---
 tools/perf/util/dwarf-aux.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index ce816aefa95b..ee72b7a4a65d 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -2125,13 +2125,28 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
 
 		tag = dwarf_tag(&mb_type);
 
-		if (tag == DW_TAG_structure_type || tag == DW_TAG_union_type) {
+		if (tag == DW_TAG_structure_type || tag == DW_TAG_union_type ||
+		    tag == DW_TAG_array_type) {
 			Dwarf_Word loc;
 
 			/* Update offset for the start of the member struct */
 			if (die_get_data_member_location(member, &loc) == 0)
 				offset -= loc;
 		}
+
+		/* Handle array types: resolve to the element type by one level */
+		if (tag == DW_TAG_array_type) {
+			Dwarf_Word size;
+
+			if (die_get_real_type(&mb_type, &mb_type) == NULL)
+				return NULL;
+
+			if (dwarf_aggregate_size(&mb_type, &size) < 0)
+				return NULL;
+
+			offset = offset % size;
+			tag = dwarf_tag(&mb_type);
+		}
 	}
 	*die_mem = mb_type;
 	return die_mem;
-- 
2.52.0

