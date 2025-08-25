Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61A02D3EC9
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Aug 2025 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151669; cv=none; b=azX1Z9/QuUxTH/rfNGmpHaPcq6fmosOVomVZ0P5y1CPHlZuVuQPSQT5mXUhRpwnbcyIol+GyClkyWSsrPhUihfLe5ztdt07q9iKqjBLEiBPfCf+ZE8TVmFtEkrYuBN/7/1ecg/iOXNRvw5YSrVruy7DzX4DA0Ebor5923OT1cEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151669; c=relaxed/simple;
	bh=J0848xdE00eCnuIJbBHDBLumMe6ywlVkpkxZS/Yo/gc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o/aDzrdWRtyuLoLq3l4/xeOKqoCeuWXrbXWQk9sBKKLRJE4SdxJDnpWo23VEah/d79c/ANX+FYlDLrajW406wwQf1birLoPqXVmxnl3UFnVgUzqFYDETE4kstt5xAXxl3FTOmgR5QOdFTaXZuD9KAfSJgmgH4EjzMZYJBCW11KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y+9pMoZ3; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y+9pMoZ3"
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-70d9eb2eb57so70704466d6.0
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Aug 2025 12:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756151666; x=1756756466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=liGvbjHxhWF7R6ji5wWKy3jFHOE8K50zvgALY4FQNWE=;
        b=y+9pMoZ3k4oi8VYvWgJWOtqCnS+wi7O28MyLOy/uh2kMerQxAhMRQQ0X1vMMlXQxcL
         5vtoW8szwYyeTYTJ+QXJHITGVVF5DUJecliXkxTmQdWfNPTGbwXg4NOkz7zl2xFDHuX6
         Jlynjq0plj5XPIbOTe4qPTDdh3ehhTte/iKDmJqw3dxxrbjzV5LIBZ8AvElkUgm6+nw3
         bhw1YGOtU8GuoaOEYsLNC5WjY+BSvYD0jlyS+VTwZ9F8xgkkJQIA4a74eUdy4b9YCJbL
         iSzwAf1yZBbK0MaNVfnoG6C3DSvkMBVt7zcldEgajbTbL/jZwmYg6mg4KDRxbpw31qmQ
         NU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151666; x=1756756466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=liGvbjHxhWF7R6ji5wWKy3jFHOE8K50zvgALY4FQNWE=;
        b=nMKtFOVLBLu8Mo7wfSgzi7gDoEkNY3q18P/e8aP40dw3Gm5STIpxOt4r69bXAt8QS4
         XKREoa66two+zJOYyQmgB/jPnsVPyHfZxh0BY5consBt/mu/gQosoEK25qJt6htN2HxB
         oK6wlsfHJS0D8GjplrE4gzuHZQAcTV4K/a5M80cdbpCgJ65cQlWU6FWZjdxkP3p7UQ65
         Ik59Ing4GMIujDKJXAeddrNvyMRvbY+Jz/6lCrYvIcMKEgw79Zaf/owReuizvfeUTEkT
         l33NdpNZ9h82feAUGvh03gRLkGfwLpF0N3P4qyRKLJhvmGlOV8z5s39BoRiMF8Z/iS5s
         YqBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl/RMc2vyj0qWGsbAuOAcm41BEZK5H/35bODFbO0UtFnktUcMa3oBSmhufXPsTeCdXaC3Wp1XK+WG/1xf7gNFJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxxpB6zp+m6w7OdEF7KCoX2NzCoECc3n4K57iN8F9rzI68u1SaC
	Gz36SxKDj0YCbwHpShri+tpnVo8lBCiQZzdjvf7fxlF4Gv9OXJbsM5Jm8HzZATzyxYpWEDGEIjK
	biAjmvTlJcQ==
X-Google-Smtp-Source: AGHT+IFPjE7rxhotfinjMJzGshtTnJUXuXaiTTD1yZOG9tQTl4Z8KnJkLgwzypxaROT3OhiVvBRyV1Ify9gT
X-Received: from qknov4.prod.google.com ([2002:a05:620a:6284:b0:7e8:29c0:65b5])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:319e:b0:7e8:384d:3ead
 with SMTP id af79cd13be357-7ea10f53de8mr1248094185a.7.1756151666369; Mon, 25
 Aug 2025 12:54:26 -0700 (PDT)
Date: Mon, 25 Aug 2025 19:54:07 +0000
In-Reply-To: <20250825195412.223077-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825195412.223077-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825195412.223077-6-zecheng@google.com>
Subject: [PATCH v2 05/10] perf dwarf-aux: Find pointer type to a type
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement die_find_pointer_to_type that searches for the pointer type to
a given type in the CU. There's no guarantee that a pointer DIE exists
for every possible base type. Compilers only generate DIEs for types
actually used or defined. Returns NULL if no pointer type is found.

It prepares the support for tracking LEA instructions. When we load the
effective address from a stack position to a register, the register now
holds a pointer type to the type at that stack position.

The performance could be improved by adding a cache for the pointer
types. Currently its impact on the annotation time for vmlinux is low.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/dwarf-aux.c | 69 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h |  4 +++
 2 files changed, 73 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 6fd2db5d9381..6e8877ff2172 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -2117,3 +2117,72 @@ Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset,
 
 	return die_get_member_type(&type_die, offset, die_mem);
 }
+
+struct find_pointer_type_data {
+	/* DIE offset of the type we want to point to */
+	Dwarf_Off target_type_offset;
+	Dwarf_Die *found_die;
+};
+
+static int __die_find_pointer_to_type_cb(Dwarf_Die *die_mem, void *arg)
+{
+	struct find_pointer_type_data *data = arg;
+	Dwarf_Attribute type_attr;
+	Dwarf_Die type_die;
+	Dwarf_Off ref_type_offset;
+
+	if (dwarf_tag(die_mem) != DW_TAG_pointer_type)
+		return DIE_FIND_CB_CONTINUE;
+
+	if (!dwarf_attr(die_mem, DW_AT_type, &type_attr))
+		return DIE_FIND_CB_SIBLING;
+
+	/* Get the DIE this pointer points to */
+	if (!dwarf_formref_die(&type_attr, &type_die))
+		return DIE_FIND_CB_SIBLING;
+
+	ref_type_offset = dwarf_dieoffset(&type_die);
+
+	if (ref_type_offset != 0 && ref_type_offset == data->target_type_offset) {
+		/* This die_mem is a pointer to the target type */
+		if (data->found_die)
+			*data->found_die = *die_mem;
+		return DIE_FIND_CB_END;
+	}
+
+	return DIE_FIND_CB_SIBLING;
+}
+
+/**
+ * die_find_pointer_to_type - Find a DIE for a pointer to a given type
+ * @cu_die: The compilation unit to search within.
+ * @target_type: The DIE of the type you want to find a pointer to.
+ * @result_die: Buffer to store the found DW_TAG_pointer_type DIE.
+ *
+ * Scans the children of the @cu_die for a DW_TAG_pointer_type DIE
+ * whose DW_AT_type attribute references the @target_type.
+ *
+ * Return: @result_die if found, NULL otherwise.
+ */
+Dwarf_Die *die_find_pointer_to_type(Dwarf_Die *cu_die, Dwarf_Die *target_type,
+				   Dwarf_Die *result_die)
+{
+	struct find_pointer_type_data data;
+	Dwarf_Die search_mem;
+
+	if (!cu_die || !target_type || !result_die)
+		return NULL;
+
+	data.target_type_offset = dwarf_dieoffset(target_type);
+	if (data.target_type_offset == 0) {
+		pr_debug("Target type DIE has no offset\n");
+		return NULL;
+	}
+	data.found_die = result_die;
+
+	if (die_find_child(cu_die, __die_find_pointer_to_type_cb, &data, &search_mem))
+		return result_die;
+
+	return NULL;
+}
+
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index cd481ec9c5a1..f20319eb97a9 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -158,6 +158,10 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset, Dwarf_Die *die_m
 /* Return type info where the pointer and offset point to */
 Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset, Dwarf_Die *die_mem);
 
+/* Find a DIE for a pointer to a given type */
+Dwarf_Die *die_find_pointer_to_type(Dwarf_Die *cu_die, Dwarf_Die *target_type,
+				   Dwarf_Die *result_die);
+
 /* Get byte offset range of given variable DIE */
 int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf);
 
-- 
2.51.0.261.g7ce5a0a67e-goog

