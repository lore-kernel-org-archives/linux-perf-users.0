Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795548563;
	b=3d+PM/HNIR6idn2n5lrpZIajGCOGP6NrA0qWEQazCglWkGh/dFluITGH9IMUAOeCjBJS
	 DHFlW/yvYGpCIC0vAqeG/FKx66Ycn/PTAi+hpCCOgJRs/1X9RQlxjYh03i3T488RwY79L
	 K8MOiMgz40rLZ0UwynjLvvnoLYnYaspPp0V6YruRvm4LHlfHBR/0yN1iqSCXeNRQPZry+
	 lfZSA0RLTZ60wgnY2WriY4V+/7uFTii5jgpUYI62Jxtr4a9O9d6dzI5ckLap3Kooatx5J
	 pe7t5PyTzGTkO3MmbdNWOSDFIPI2gHpzKfwi253yXYtEMcqox2Z16hMjofjRX0sZ4EQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795548563;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=trkdwYSyqe9riSeTO67T9rZnM10ltkcWbxYDqChDfUE=;
	b=qNk/by4ZMkn7IFvvWqrJVXjYORZ7Jup7j0agAC6hbi4Fy8gsRQRH3B/8BV5n/PENQXZS
	 qU5+kownRCWT4neMcyN5iiwA24BEdPt+Cml16QW+AONxXn4UwyuljdVbJrHdsjm4OWM6d
	 ++nSgQi8X7i00vr4dyHTpr43Ibaluj5vN0TG+3iiz4OdayWayy0ewJJK+ucAomGeuQq/2
	 BZcz7dlQnJeSTr6o7rzLhat659bsok7F2QzN/Y2QjPYDWd4eO8zhUZbzHdIx6ibyo7wMn
	 FjmMF/MIwl5SPrI7KBB2+teGkeonunJpu2A2vreYYW3wDLnFP5zcr4d/Ow7QtoUKsgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HbFJh1IG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3CF606A31E;
	Tue, 24 Nov 2026 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HbFJh1IG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795548562;
	b=KutmOVKb679cveftZjqu2WxXL5p1UNOee+cn4e59qHXKhwyBsl5UooKXaYIqfbOD5zVg
	 V/WlZCsM5wdOnMCi/9dHg2yRUkdwCpuPz0w0f8UtS+CHUw0/t+hioQl+4AieUBAchwkej
	 VP9D1cW+F2S4kjG6Bl+uBVk6fzZD9m1as7/bZ+9cvVC9olyb2oYXwnmAoMp3jvYfolLkp
	 CU5nTfRD+5eC5Mb/Qd7IGSJww1sPXwyLfLGrOBvCIgwVm5CMembe6QbjO6E6mCnHwhitn
	 WKQPNzjVbO/qRoOBh+Ma5RFnSsUcNMBGwYT1orH5JZajSoGZJ6CbNE5b0M9EKxyZW/A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795548562;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=trkdwYSyqe9riSeTO67T9rZnM10ltkcWbxYDqChDfUE=;
	b=SwJtyRls01Kdbr/iN+EDkLBmfLm9MduffmXWyyffNGg1lIZx3jIAD06gK01RSufsd4jp
	 J+sVEiP54dvkUdqj5ArGWvE6ApFVh23lihgOuROSnhvoVpk0/4RguQcRu1QZh/zFAIfAs
	 ginjaWrn/zhe54Einj3NiTN2l6swgYVr+d8CHIgXtLnGLZhVlJDd360BSdRj1FONUdxzc
	 RwzaOyeMfdpqMkHDI12ZYLisSUYBy6uuUzHOL1jFLLQY5v8/IIS4DQXclwHGM6vqf/eWX
	 Faw+UeuRT9GIjbv4dO9I+6Lmh2AoNzWFZbZVI0jJexSqWsrITQ9cYvfeHfT+53OtUmA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 749F21F000E6;
	Tue, 24 Nov 2026 19:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795548562;
	bh=trkdwYSyqe9riSeTO67T9rZnM10ltkcWbxYDqChDfUE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HbFJh1IGyglR+vWlFs04hWR4wdGSylrK8v4tUrZlGta+70VsJDMRrHaCQItW1uSkm
	 YiG8O/gEavWmYLnvRcg168tfGHZBoqkgI2wrJkCDJvQJhIaxfNCfeL1PuJY0T73dqz
	 EvjLjyQyTr/jusE4YIjR7tDSONlP3ALhhenbrUJm9kLnyB/HpospXZ/7LCkGs1PDKQ
	 M2fXxTwrLcVcfbVQaH629yIQxQ7J3Pv9vVdO5W36yRHfUV/ufiua1q6o0S0ws24x1R
	 9GnzwhEjFuR/0etbTe20Rrx+xaX/I/QoZIPXuk9SZv+pPU0cIsyUVVF0qLI5zCo2yF
	 R+3+qETI0SINg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 023D84CB69;
	Tue, 24 Nov 2026 19:29:12 +0000 (UTC)
From: Alireza Haghdoost via B4 Relay <devnull+haghdoost.uber.com@kernel.org>
Date: Tue, 24 Nov 2026 11:28:25 -0800
Subject: [PATCH v9 2/7] perf symbols: Point to the symbol name instead of
 embedding it
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261124-perf-symbol-memory-send-v9-2-56f298185eae@uber.com>
References: <20261124-perf-symbol-memory-send-v9-0-56f298185eae@uber.com>
In-Reply-To: <20261124-perf-symbol-memory-send-v9-0-56f298185eae@uber.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alireza Haghdoost <haghdoost@uber.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2133; i=haghdoost@uber.com;
 h=from:subject:message-id;
 bh=hjmLft94/FwnngU1dtok/b0G4S8C46g9Nqo2+F/0V0Q=;
 b=owEBiQJ2/ZANAwAIAVNlBDxl2ALYAcsmYgBrBeWEUjAKuepLsRNdrYPGyY1QfqA+oD+U/ZNAv
 VVit144baGJAk8EAAEIADkWIQS5+sFL3gX/8PrA0S1TZQQ8ZdgC2AUCawXlhBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQU2UEPGXYAthltg//c5ZN+p7t+CGUbFgeRGXAoBm968Rlw+y
 zCwHkM2Izoj4oRsGO/pEkJQnBJ9mQ5vut6buuhjXim6GI9fVpQRzUIJuzGhC6kt+XT+xmpd9VUx
 p0F9YvMk9Sqfe5e1tnqlYRlBjuYAIG+iDUkZJnrj9A6/EKxbmxGU3DJBeEzIvuEe4T3LgixlDUx
 X1a8hYsS1fRkGY38HDuMQV96MtBt7WsBmnIsllHDv6RqxsIZoHSM6i5ZETP0z/R8aDBwYH3LDYz
 r76eUuJw2jpBL/273LAfMNSVWlupoz9+fsHbYmnUNp3OYm7Tecnt/5chdDUvRAnQD4L1J9RrbQw
 Cg/AN/JBOtlfN+YtedMapFEXLQTpZvkSUystnqCUiqsgtwRvF0GnFMZa8QFdK9NOTxUPjgMvOsg
 eV4HRCJ4fFlNayr2DuvYSqlpHby0SEZzRony8c2ofUIBrhcAYzpTYiN7sAUWu6gdoKLrWD6T4ui
 cAlQvhCbcjEY4ZDN8AZEGTWCKxpQyaWHGPkSYp3P6KL4/lXtaTgZF++mzJl3yQNkHAVth9T7s7O
 a4VdJN+zQwT3grEgw6cJmKb19z7tBqap0nIfHDzjN3ceGzU0x2fv6OETMm6jCX1x/TlB0h91mH3
 7xOQEAeR3vNr+XSd8SJ8B6OQQuKY0L+HNcWOBb0Ho2lJs3rV/xGc=
X-Developer-Key: i=haghdoost@uber.com; a=openpgp;
 fpr=B9FAC14BDE05FFF0FAC0D12D5365043C65D802D8
X-Endpoint-Received: by B4 Relay for haghdoost@uber.com/default with
 auth_id=764
X-Original-From: Alireza Haghdoost <haghdoost@uber.com>
Reply-To: haghdoost@uber.com
Content-Transfer-Encoding: 7bit

From: Alireza Haghdoost <haghdoost@uber.com>

This patch changes the name field of struct symbol from a flexible
array (char name[]) to a pointer (char *name). It does not change
behavior, but each symbol allocation grows by 8 bytes on 64-bit hosts.

The next patch creates symbols whose names are read only when needed.
perf does not know the length of such a name when it creates the symbol,
so it cannot allocate the name after the symbol. It cannot reallocate
the symbol later either, because the symbol array and the callers hold
pointers to it. With a pointer, the name is allocated separately and set
when it is read.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
---
 tools/perf/ui/stdio/hist.c | 1 +
 tools/perf/util/symbol.c   | 1 +
 tools/perf/util/symbol.h   | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 3240c39bd025..45841eac6f52 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -106,6 +106,7 @@ static void init_rem_hits(void)
 		return;
 	}
 
+	rem_sq_bracket->name = (char *)(rem_sq_bracket + 1);
 	strcpy(rem_sq_bracket->name, "[...]");
 	rem_hits.ms.sym = rem_sq_bracket;
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index d9866916fe9a..25efc05c2c7a 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -634,6 +634,7 @@ struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *
 
 	pr_debug4("%s: %s %#" PRIx64 "-%#" PRIx64 "\n",
 		  __func__, name, start, sym->end);
+	sym->name = (char *)(sym + 1);
 	memcpy(sym->name, name, namelen);
 
 	return sym;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 41417bc85bb9..8abf6ec05bd6 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -92,7 +92,7 @@ struct symbol {
 	/** Architecture specific. Unused except on PPC where it holds st_other. */
 	u8		arch_sym;
 	/** The name of length namelen associated with the symbol. */
-	char		name[];
+	char		*name;
 };
 
 /**

-- 
Git-157)


