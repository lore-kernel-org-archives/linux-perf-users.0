Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793230971;
	b=JL/PinEtnHuUH/VYlkiN3zKDW9RN2DtNjNIiMLMMcwmvEmuoANvmW9WrgxEftf3oUTlf
	 lcFBCDaG9gM1nmkRZS6VX4ump3+sXQl8lINfCY+gOLDiWtM5lcDSoTJGwGdjZmI+Lqr1a
	 n5kcK3ZA5pUfjT9xZ2jSak4/b8EXFLNxvmeBiVTGATQ3MsCFhGDvYwzfyO/1R2DLCAilA
	 /J3/3Xc/wCrXTcqQ9ihiPTX8TcqhW1egdG3Fxqm9rMBfC2d+MvYp5VLrVQaxHl4663F8M
	 GLctEVGKa1TXRI5Bbc26OILjdAlAu/FENw/GRlqzAXDAoBeiw2rVzgOW3wLGS8aPnxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793230971;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Rl3mEnpFINIo/fNdrLGKiGda6V5w+TutGVQ743Jd43c=;
	b=rKH7w4t3i1kBedv73WSNr24SLfcNw1hVgc0+H//Y0LmwTr/TzK1zUmv9boYQMpwW+siF
	 fWwQp+sd059Ekmg0xaHlMeHhcpmkLA5W1Pm2FHVKPjdAwmTbXSxVU2dXyuHzHCI4upG5c
	 6PEdii5P8Le8+9L+oZTqm/AG399E4aYUuhQTEKHkEcxPzVBLfNW/UaSt+GxexHnYGHGOu
	 c+I2yTbvQhKd99KQxaSxDn0PSW6Ndk+akyZBHlpXtZQHztaVt4Cx9U9MqzBu1lwetEy4D
	 kmbOlD4B4F3Pa/talOu/nYdSt/99KR82KaNY7H0cHPztedKntkjOVfZ/9dMUxn03YKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TnrkHmPL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A722B606A31E;
	Wed, 28 Oct 2026 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TnrkHmPL
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793230970;
	b=gKe96VRi4Ay3qvN89F1wn0Xnw+Y1DHkRwJaGn70hF3h72+u9pYnneo9tzKp9vLXeXZtD
	 TxShQR5q+3KJITVa+NsdxjYdYyNVqEJotUcmPBgrvz4rZT/Hv3m1CZcXMhJ9Vy4wj/quL
	 AVBLHz/J6XDShMvA8fI9IWzyFew37CPWNHXf9Kl0idC6MHm8a73DVgW+rJ1B98Axnl22U
	 P1H7gqHnZoDnY454lzEoeZmnIVtpdteMpDrP1gYKpkWqXWvv6rvp4vIQJNAkuyKtRVW4h
	 sRcxU7RQZCR/zSOn5yKL0pO6QRezhY8Gj5oXxIbcGyXyDrvBBl6EFgWU3rOTj9AxVpw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793230970;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Rl3mEnpFINIo/fNdrLGKiGda6V5w+TutGVQ743Jd43c=;
	b=eSErlRV0uk+V22TQk1z63HrSfWKXfvHAVE197znEAqSknwwh0h5EIqyebGibVcLHD3O7
	 oOWs0iC1183+fIuViOR1akBp8auEyro9j2g8tCaMKuUmcmWEZqp2k8u6R1y/3Kv8+ZmkU
	 ZF+t+zkO62DXD3E3xZ57xqme6viVq5JhibvWqbOegWo5CzUlR+i5aGu5HUmFRcmxN6RJg
	 fSnD/Pa+rztM/UFCW0Um9p+DlqzANxUZ17HJhxde+FWXflMkvQC5bWQnt97e08bjkuMzR
	 9ibqm1AQGMwv2fmNcqI9vTC1oVi7fX0vKwBG6vDcEvZ7Qo35W8bEGjmI7mRc3J847yg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1F0651F01828;
	Wed, 28 Oct 2026 23:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793230970;
	bh=Rl3mEnpFINIo/fNdrLGKiGda6V5w+TutGVQ743Jd43c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=TnrkHmPLKVFIFW3dkam2STq9NoGLtSJn8zHngLYonwgM0BbJQRSv2OT0/6YOKrPPk
	 tuTbxo6lLK7CmW3yv5HR0Vv/XQGy0IuJ2vnDOe89ozK0ifcrPWA/GAWvbbFW7PjWkr
	 EzqD2L9l83ww9exh/Tc0zhv1kUs8J/AQYEOySTeYZkj8fI7vnSHlPOrPUqH6KN/pAW
	 OY8Wed7Met1VhfZzmXUcS0Z1czgO7kAMngpyhowU+WtL+zxQFUPGyCWJCYPBPq9OjQ
	 tvVWyHvjzG0ANpzNRI72ulc/T6pqeBvkHSoyR2ABhecfwyryQ6ZXDhmwKPRYFQJlXZ
	 cAxTrsRz5WjKA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8873F45627;
	Wed, 28 Oct 2026 23:42:48 +0000 (UTC)
From: Alireza Haghdoost via B4 Relay <devnull+haghdoost.uber.com@kernel.org>
Date: Wed, 28 Oct 2026 16:42:33 -0700
Subject: [PATCH v6 2/5] perf symbols: Split out name-independent duplicate
 symbol selection
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
Message-Id: <20261028-perf-symbol-memory-send-v6-2-7e90415f0101@uber.com>
References: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com>
In-Reply-To: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andriin@fb.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alireza Haghdoost <haghdoost@uber.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3083; i=haghdoost@uber.com;
 h=from:subject:message-id;
 bh=UFacskGEBu0XEz3nvj7QOau6UP9nsBYAYWQ+E7Nz3js=;
 b=owEBiQJ2/ZANAwAIAVNlBDxl2ALYAcsmYgBq4oh2tWOhJUiFDWi4yQZNya/JlXoiWvKSy0z0g
 Xmh32y/1N+JAk8EAAEIADkWIQS5+sFL3gX/8PrA0S1TZQQ8ZdgC2AUCauKIdhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQU2UEPGXYAtiQQQ/+OgLAXIXP4L/3YiuXilobQUOBhQRAViT
 ulCpV/5ik8ZeNccLISGDCCa/0GAK+DkUs2NmTpQrH83p90bP/1wCCIqH8/BnL1AGecCc2/w8wMf
 Xb0KqXCc6MrGBeEbWqx07Ld3r76dnB/NdzE4zRodO3thk1KZSgKI4LSoZ8BdvMVGddktk2GQtf3
 G6De6qKezufavVgrAT7k2USVJNdxLYBs2U3DNnkLz5IZixaGaLu9FRSIC06RFPyjzdgHdRtGtIG
 8Tkio534MKsOsCphpSWb+oI0jCx7bbL6FeMlSdaJyDiU+RvSocKg63WuJDcU9UHO8y7bBl4acHI
 iHuHPLFKWSDoZKLP+CizVfluafU5dsCM/jhb7f+CgY7MsFGF87pFSWMsxJVYl2SLwKINOKjoTrW
 J4ZrAqymGYVx+Xz5KtINXLsMwMndZO1Is3l4umnQ/D0IFsa2UoIR8jmrbXJfnewzsgFvbtPV5Fp
 dHAUkNAgVzd9ofWX4zKUGQfd8ibzDBDmjzLvS/G5mth0C6gsSJUEMmOvhuWAUqVLtCzZn58n4bM
 R29iSQRBlXKXlTqtwKzmFOeI0ms2rGdwYt0Ef3JcySpYoxpoCK/999tSlDk2zJR08c/Ak08BXr7
 L9ar+AjI13Z4RSGzqNDKZRJO44NA8RWKEmmNXh5765lMIp8lMjug=
X-Developer-Key: i=haghdoost@uber.com; a=openpgp;
 fpr=B9FAC14BDE05FFF0FAC0D12D5365043C65D802D8
X-Endpoint-Received: by B4 Relay for haghdoost@uber.com/default with
 auth_id=764
X-Original-From: Alireza Haghdoost <haghdoost@uber.com>
Reply-To: haghdoost@uber.com
Content-Transfer-Encoding: 7bit

From: Alireza Haghdoost <haghdoost@uber.com>

This patch is a refactoring and does not change behavior. It moves the
size, type and binding checks from choose_best_symbol() to
choose_best_symbol_by_attrs(). It also adds symbol__choice_needs_names()
to report whether choosing between two symbols requires their names.

symbols__fixup_duplicate() keeps one of the symbols that share a start
address. It compares size, type and binding first. If those attributes
are equal, it compares leading underscores, name lengths and the result
of arch__choose_best_symbol().

An unresolved lazy symbol stores a file offset instead of a name
pointer. Thus, the lazy loader cannot call choose_best_symbol() until it
loads both names. The new helper lets the loader keep the names
unresolved when the attributes select a winner. It loads names only when
the attributes are equal and duplicate selection needs them.

Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
---
 tools/perf/util/symbol.c | 26 ++++++++++++++++++++++++--
 tools/perf/util/symbol.h |  1 +
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b61a574ce9a3..2d611c05d000 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -157,11 +157,15 @@ int __weak arch__choose_best_symbol(struct symbol *syma,
 	return SYMBOL_A;
 }
 
-static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
+/*
+ * Choose between two symbols at the same address by size, type and binding.
+ * Returns SYMBOL_A or SYMBOL_B, or -1 if only their names can decide.
+ */
+static int choose_best_symbol_by_attrs(const struct symbol *syma,
+				       const struct symbol *symb)
 {
 	s64 a;
 	s64 b;
-	size_t na, nb;
 
 	/* Prefer a symbol with non zero length */
 	a = syma->end - syma->start;
@@ -194,6 +198,24 @@ static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
 	if (b && !a)
 		return SYMBOL_B;
 
+	return -1;
+}
+
+bool symbol__choice_needs_names(const struct symbol *syma, const struct symbol *symb)
+{
+	return choose_best_symbol_by_attrs(syma, symb) < 0;
+}
+
+static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
+{
+	int ret = choose_best_symbol_by_attrs(syma, symb);
+	s64 a;
+	s64 b;
+	size_t na, nb;
+
+	if (ret >= 0)
+		return ret;
+
 	/* Prefer a symbol with less underscores */
 	a = prefix_underscores_count(syma->name);
 	b = prefix_underscores_count(symb->name);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 46b1649c64fc..d8386c4a7fc5 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -303,6 +303,7 @@ int arch__compare_symbol_names(const char *namea, const char *nameb);
 int arch__compare_symbol_names_n(const char *namea, const char *nameb,
 				 unsigned int n);
 int arch__choose_best_symbol(struct symbol *syma, struct symbol *symb);
+bool symbol__choice_needs_names(const struct symbol *syma, const struct symbol *symb);
 
 enum symbol_tag_include {
 	SYMBOL_TAG_INCLUDE__NONE = 0,

-- 
Git-157)


