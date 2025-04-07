Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A567E2066EB;
	Mon,  7 Apr 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041480; cv=none; b=kuwxn/fgYc3qi4v396g/M72W69G40SOZ/oihga6wF4a7RaUuIvCOBipVF3DVDW85hIB2rVqM5nrIcDJjGAILV79r8pJloAWylGV2DAIdHCD7Jpcjy1b8c8GlfMoOl73bMM/V871yBYV0KVH43v1FC20kcsmvJrxOznNkkpCWEEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041480; c=relaxed/simple;
	bh=baR4bplDuqt/sCxYhK7lP+YHa9RfGk9mYm8bvFs/FC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VABlemRPsh7Yo7R+sahaRVGYDAU79DlHHo5mo6ktoEsDKyPFeYoiOV0jN8EG8eepTzD3eYGTT+IgCdwTqv6ZpptaE3yhS/BBNlH18l/MpLCLdd5DC1ZBMeCETL25JqLZKEZMAIBd2XHlP4BbfWHc+nQkkEBKcXsc53t6HzySDpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FBqbBD4h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zemMXxUz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FBqbBD4h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zemMXxUz"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744041474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I7A8axH4bDyGkgb2D5b9OYUNDGIoTyQiCHQW8iBy5yA=;
	b=FBqbBD4hCnHSyJ5CyBTOKIHHR8bJ8jPGhftdVwGG9pTIOLfrPK7hpZzhQLTBqcDjnbuFSi
	I3J5coLgd2dFtEywhfwvHUahFISWDEEyyrByyPOVjOAxNMWfuUMKlrlPvNjsutFJDJxlFn
	7VfvMB3GGYd0AZz/40i4G9SOm6Zmee5MaONJhhikz4/OxVPC1gD7JZ20fCXrlhLTnRcaUX
	oS5fyPA4FGXpyWXIvPSWBPeD8QR8oeWHnUsReuRW9se1sxvr5yQfmtEfsKxRQIkRINRN8w
	vb5yGy397JFYGbaJri5svQ86UJF/p4dU+qH/txEB3lNT7oapPkXYYjK58gBWjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744041474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I7A8axH4bDyGkgb2D5b9OYUNDGIoTyQiCHQW8iBy5yA=;
	b=zemMXxUzU+XE4JLXSAOTdPDEqTj+XuKfWrob8+pC2NpV8vjrlVGdLmlb3OtwoUki+NQ6VM
	tOZjQ0YMro0Mn0DA==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v11 17/19] tools headers: Synchronize prctl.h ABI header
Date: Mon,  7 Apr 2025 17:57:40 +0200
Message-ID: <20250407155742.968816-18-bigeasy@linutronix.de>
In-Reply-To: <20250407155742.968816-1-bigeasy@linutronix.de>
References: <20250407155742.968816-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Synchronize prctl.h with current uapi version after adding
PR_FUTEX_HASH.

Cc: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/include/uapi/linux/prctl.h | 43 +++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/pr=
ctl.h
index 35791791a879b..3b93fb906e3c5 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -230,7 +230,7 @@ struct prctl_mm_map {
 # define PR_PAC_APDBKEY			(1UL << 3)
 # define PR_PAC_APGAKEY			(1UL << 4)
=20
-/* Tagged user address controls for arm64 */
+/* Tagged user address controls for arm64 and RISC-V */
 #define PR_SET_TAGGED_ADDR_CTRL		55
 #define PR_GET_TAGGED_ADDR_CTRL		56
 # define PR_TAGGED_ADDR_ENABLE		(1UL << 0)
@@ -244,6 +244,9 @@ struct prctl_mm_map {
 # define PR_MTE_TAG_MASK		(0xffffUL << PR_MTE_TAG_SHIFT)
 /* Unused; kept only for source compatibility */
 # define PR_MTE_TCF_SHIFT		1
+/* RISC-V pointer masking tag length */
+# define PR_PMLEN_SHIFT			24
+# define PR_PMLEN_MASK			(0x7fUL << PR_PMLEN_SHIFT)
=20
 /* Control reclaim behavior when allocating memory */
 #define PR_SET_IO_FLUSHER		57
@@ -328,4 +331,42 @@ struct prctl_mm_map {
 # define PR_PPC_DEXCR_CTRL_CLEAR_ONEXEC	0x10 /* Clear the aspect on exec */
 # define PR_PPC_DEXCR_CTRL_MASK		0x1f
=20
+/*
+ * Get the current shadow stack configuration for the current thread,
+ * this will be the value configured via PR_SET_SHADOW_STACK_STATUS.
+ */
+#define PR_GET_SHADOW_STACK_STATUS      74
+
+/*
+ * Set the current shadow stack configuration.  Enabling the shadow
+ * stack will cause a shadow stack to be allocated for the thread.
+ */
+#define PR_SET_SHADOW_STACK_STATUS      75
+# define PR_SHADOW_STACK_ENABLE         (1UL << 0)
+# define PR_SHADOW_STACK_WRITE		(1UL << 1)
+# define PR_SHADOW_STACK_PUSH		(1UL << 2)
+
+/*
+ * Prevent further changes to the specified shadow stack
+ * configuration.  All bits may be locked via this call, including
+ * undefined bits.
+ */
+#define PR_LOCK_SHADOW_STACK_STATUS      76
+
+/*
+ * Controls the mode of timer_create() for CRIU restore operations.
+ * Enabling this allows CRIU to restore timers with explicit IDs.
+ *
+ * Don't use for normal operations as the result might be undefined.
+ */
+#define PR_TIMER_CREATE_RESTORE_IDS		77
+# define PR_TIMER_CREATE_RESTORE_IDS_OFF	0
+# define PR_TIMER_CREATE_RESTORE_IDS_ON		1
+# define PR_TIMER_CREATE_RESTORE_IDS_GET	2
+
+/* FUTEX hash management */
+#define PR_FUTEX_HASH			78
+# define PR_FUTEX_HASH_SET_SLOTS	1
+# define PR_FUTEX_HASH_GET_SLOTS	2
+
 #endif /* _LINUX_PRCTL_H */
--=20
2.49.0

