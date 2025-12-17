Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DA7355051;
	Wed, 17 Dec 2025 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975368; cv=none; b=pJF8AjOlpiYRBl0/C7qQrltVNbDB3gymU/ft+keKg1t4+Av4rXDzULncL7X1aZZGjqzgzALAgrNybO0qTU1NkNK7skMOXAANB0sBV1vVsAfCwF+ddX2qH1K8t6BQhpu+RRf1m/UxeNRCzYEy7ZhoaKGaIMr80jKP8PDC3tEK0DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975368; c=relaxed/simple;
	bh=YjVIwhTQ2SwgawEShPDHGHYPEBaT6eS66eWlv+BMAfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DX4wROp61wh4z7FandzZTyvFc1/1ohvPjzuNVKzpemX7eH7huM3ccnwRN8vYDdb6cYMSLp876vAHgDUysuE5wa92WImu5cf0QuqzY7DuegiQVQUSNlH5lClRJQ2yXq6BaVB5ZOmg8A/ZWFiK8/vK5IRDERq3ACeF2/hKCkKcHkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iyOJ5Qs5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iyOJ5Qs5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A67C19421;
	Wed, 17 Dec 2025 12:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765975367;
	bh=YjVIwhTQ2SwgawEShPDHGHYPEBaT6eS66eWlv+BMAfU=;
	h=From:To:Cc:Subject:Date:From;
	b=iyOJ5Qs5swxyIER+TkMNU47YoJZxsk3At9Ta4CBXmmyEAwGG67cKd3uxnUmlxHrwW
	 z4XoJIQxomVa0/wSqfPvS/2P1FFhm5+9jLNL+Q3rsKEPDSLpocTQZVTKzHI5e9p911
	 XM5UKeE6AFZz0WBb6Fsdma56yUugvByDN0DSHvu4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf/x86/uncore: clean up const mismatch
Date: Wed, 17 Dec 2025 13:42:41 +0100
Message-ID: <2025121741-headstand-stratus-f5eb@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2470; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=YjVIwhTQ2SwgawEShPDHGHYPEBaT6eS66eWlv+BMAfU=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlOSx0jdu7dkz9Rfw/n7g9392n3dDgz71pff05v5scLs Ycm3c6s6IhlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJ3ExlmF9v/7a9ePO077qR Ilpv5xxZF5CzegbDgta6732vOhNzHt+LzXui/lr+yJOZTwE=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

In some cmp functions, a const pointer is cast out to a non-const
pointer by using container_of() which is not correct.  Fix this up by
properly marking the pointers as const, which preserves the correct
type of the pointer passed into the functions.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-perf-users@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/uncore_discovery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 7d57ce706feb..330bca2f14b3 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -52,7 +52,7 @@ static int get_device_die_id(struct pci_dev *dev)
 
 static inline int __type_cmp(const void *key, const struct rb_node *b)
 {
-	struct intel_uncore_discovery_type *type_b = __node_2_type(b);
+	const struct intel_uncore_discovery_type *type_b = __node_2_type(b);
 	const u16 *type_id = key;
 
 	if (type_b->type > *type_id)
@@ -115,7 +115,7 @@ get_uncore_discovery_type(struct uncore_unit_discovery *unit)
 
 static inline int pmu_idx_cmp(const void *key, const struct rb_node *b)
 {
-	struct intel_uncore_discovery_unit *unit;
+	const struct intel_uncore_discovery_unit *unit;
 	const unsigned int *id = key;
 
 	unit = rb_entry(b, struct intel_uncore_discovery_unit, node);
@@ -173,7 +173,7 @@ int intel_uncore_find_discovery_unit_id(struct rb_root *units, int die,
 
 static inline bool unit_less(struct rb_node *a, const struct rb_node *b)
 {
-	struct intel_uncore_discovery_unit *a_node, *b_node;
+	const struct intel_uncore_discovery_unit *a_node, *b_node;
 
 	a_node = rb_entry(a, struct intel_uncore_discovery_unit, node);
 	b_node = rb_entry(b, struct intel_uncore_discovery_unit, node);
-- 
2.52.0

