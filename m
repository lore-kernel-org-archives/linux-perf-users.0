Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48239248F77
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Oct 2025 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927359; cv=none; b=JhwTMFBv9jkR+6vCntOeZfkAeX6FGR00i3tpzqLR5J72G501VsUfN0oC5mqFbCgsCIDnOVBncELS6slfvHXVmzGXzoGNMGwpzOLDKswALy2y8vVKELmS2CRzHNV0DggoZh89uv3TyL9ZMZGWRDwC7+iFcNTCz1xpQw9leZ0Yytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927359; c=relaxed/simple;
	bh=0eHoYPcdGZEMlCC0AF9zZdja0XSKfe7tlSR7tgd1aCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qbSfw/F9M2mWpaITPCd1iNzpnB5AVYCpYjfiTUs7atQZybRf8nBzyrDJmg3V3Ylp9/SE8ghEVbB+xVC7nsIA3XLE6ra6B//2mCS+EK3+8n6I/RYbTtlcMduCgm31khJC0tuQ27rRScIPk/r8A/nCyvUCNzXSzYoi/V2hHlX/Ehc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ep84LZGQ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ep84LZGQ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso490769f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Oct 2025 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759927355; x=1760532155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c1h9bQgnrHSVl4Y0jfCrEgYmaDZISuGnayrwZXACWK0=;
        b=ep84LZGQqU506rpCNI+9n8maxbxPXiny69A/m1brP6uxYWz4nqBu7haOFtb6gaQdQ1
         Ndy8kxJlIp3l/oz/09aP/MD+GAmNbC/NsNLBU2H1Sl8ahQvxmPUGIBMU3BiABNg5rf7H
         pbmU/tFlXjrDNXDm3gG8Oz0hhoKJX9AtkYrgCoci+2+ruUL/VrybNeCM4XBObjYrjrU/
         qbMLNcjhdASimmdQW1KOYHXu/6sDczgTpc4caR7ZqitDeo/FZ0kFLwZVaIgLTf5EPyKB
         P9XMqEdPh1XBGyzWE5MNScBE1CidbhmXYQE4/0gVFwP3GFeexHxa1VfVVvWfEFoPVX8N
         UflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759927355; x=1760532155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1h9bQgnrHSVl4Y0jfCrEgYmaDZISuGnayrwZXACWK0=;
        b=wRf31UuNRb0jkB6snnwTAxJ9xsXoxMNDzhiNTNnBAGHG6EQOzwdNe/RIygc5bxby+r
         81NvU/3qtM4+WCllmXsY6GEbhRc9Ulj6iba1032t+metnxVYO7bz7Be3N5D5LxmgsqDF
         RQhcSlaxEc7XVYBh0GlS2vVEMS4fFkN3eoFvTH12vqwZ3mNtelJGP4fBu6TiKIbljrco
         IFVchpbtidnD84t6avqLCHLjyIT+Rn/QgQkLQKasmRau0S14d9NUFxA/nzum0bTYmEdg
         kiweBhsj6FqCoTw8t7oVrtgBiSc4JsrZT9/XuPXwnxhOQqPbL1FCs2NJsuk2FKNfjixc
         HIyA==
X-Gm-Message-State: AOJu0YykgCA3RV6D/qlO347x3KaAdfynkJ98dJiu2f+ILm1s43lJ5qAH
	3o3hJxBUeU53OLB+n77gI7eichyucsBS6+cMg2VHVtsn6W3sAK9ApWRZdACYLG8E5wIiklBPoJt
	tcylh
X-Gm-Gg: ASbGncuMW0G8xaYoum0M5ouJQXx4opQyHoz0j5INw533KNMqWKcl1JZJbqcwtHunBu9
	uL5cgWe/+iYcpqv4xgOJYDsjqgGqgkI2PqCRTeddytZbUaeG8ZlNI+dxNsc5mJO0K63O02Kav2w
	HJQRCm18q/SnYap2Tl+D1AQWdfN8VyqAR/cKs3WipVkutkrSoKKPfi/ahp6Num8hcs12ibTldu0
	1V1sPp1i+TctfsR+Xq21L/Aw0rlZm5plW+emk0C5gN0crGmtTivo5aTzNLbgUB/gvh0Va7hDrk0
	Z74MAz2UwQWkMNFaCC3OqZyl9wHZqBJ5mqRSHfopWmVn+c66oedIoCsqNvzBAaq0bsHjbeHlnLQ
	m8SwL6L5GRo5CfuQ2Omble46VAKW6BKxgx+JvrZrrOzQoGk7+S0kE2MzCRIUuuMdsusrtEMwblo
	vIDg==
X-Google-Smtp-Source: AGHT+IEHXbTr3EM01NQrVZFVeU0wqRKUe+r4Uos2QGhIy+lPLvKrMSJAAnCKjcEayyikIAHTO7TvsQ==
X-Received: by 2002:a05:6000:2504:b0:3ee:11d1:2a1e with SMTP id ffacd0b85a97d-425829b0d45mr5498131f8f.10.1759927355550;
        Wed, 08 Oct 2025 05:42:35 -0700 (PDT)
Received: from localhost.localdomain ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9bf953esm35978165e9.1.2025.10.08.05.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 05:42:35 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org,
	acme@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf tests: use strdup() in "Object code reading"
Date: Wed,  8 Oct 2025 13:42:00 +0100
Message-Id: <20251008124201.875919-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use strdup() instead of fixed PATH_MAX buffer for storing paths to not
waste memory.

Suggested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
Applies on top of: https://lore.kernel.org/linux-perf-users/CAP-5=fV1N-j+f4GBFnDWsmoMZcz_k0U=nu1A7NZz-g4gzCH4KA@mail.gmail.com/T/#t

Changes since v1: handle strdup() failure

 tools/perf/tests/code-reading.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 4c9fbf6965c4..1acb12b1a2eb 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -43,7 +43,7 @@
 struct tested_section {
 	struct rb_node rb_node;
 	u64 addr;
-	char path[PATH_MAX];
+	char *path;
 };
 
 static bool tested_code_insert_or_exists(const char *path, u64 addr,
@@ -79,7 +79,11 @@ static bool tested_code_insert_or_exists(const char *path, u64 addr,
 		return true;
 
 	data->addr = addr;
-	strlcpy(data->path, path, sizeof(data->path));
+	data->path = strdup(path);
+	if (!data->path) {
+		free(data);
+		return true;
+	}
 	rb_link_node(&data->rb_node, parent, node);
 	rb_insert_color(&data->rb_node, tested_sections);
 	return false;
@@ -94,6 +98,7 @@ static void tested_sections__free(struct rb_root *root)
 						     rb_node);
 
 		rb_erase(node, root);
+		free(ts->path);
 		free(ts);
 	}
 }
-- 
2.34.1

