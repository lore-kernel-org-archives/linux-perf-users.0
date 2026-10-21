Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622175;
	b=pLhV6jJ79Re3AQJfltohQsQe+wxXotOwB4JbpbL8QMP/fuyGZrSBCJU9ECRdDI2C091X
	 yD8djNh2LlxIAMQJugiBGgiMWXpWfVlMATrrnDrnwJ4qmX+lWWgUwNVMTkFjIKFKjNJL2
	 hUj3CU+pXEJRKElGsnskAsRyRjCEe+bOZj17Jr39obiVXN01MossnPHSwPF4yiTEMpam4
	 DX2WOdTf0J1Dw4+o4HtDiOXBuHdoR3s87fIanWH3btWLDITiWCSME4UQdzhimAWPCOxQS
	 CpT71k7/3OelO4DU9PeLTQp55wQhGoqPH39MLNPdjp2yB8AezRTdkT6ws9yyT6q2ZBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622175;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mCz5faZcAW52tJYBbukECioPM85ClEcij99Okwm51M0=;
	b=n0990mRG+5dJlQyFtZX5nD5IBW32boRRKJFuV3xLEOh0oTTIpXggRPKKN1PCTdJHhnHR
	 slnMIuUu9MSX+jreecsfMyPL+umGHtYG+c/8ZSygD+aj7JbjMK/cK6WOlq56ZZWLxnoju
	 qInPVsl7b1HO0OuQXc4v6KLycWKuiKTQRj8NW27Oa4ZFHDAQuyzUncLxEtik9USKmurNx
	 W5uNpUP2gSQ1yNp/mOl/U8PEj04jH2Lnq6KL0nCsvB6vaG6gWH37vvQynOg2BSuEfo5Yx
	 SJ48/7gMOsrxaeHp8di2rkhWJixpANRXKmML9PwoybqEzn+ET/+/fo8KozMJtU6UAoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WR/k/TqQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339D1606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WR/k/TqQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32851F000C1;
	Wed, 21 Oct 2026 22:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622174;
	bh=mCz5faZcAW52tJYBbukECioPM85ClEcij99Okwm51M0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WR/k/TqQN9l4w9C7JGFWxcSWwgJFd5N/GY+vfBT4AadLtEEvnS1DKQcE0UwoxSyTR
	 ia9afB81ytj8wVumuTokCBVvRCIhgbt/ScFtnGwdoiwfdLVzBi6NCzLOLhAmyIoK/O
	 nnNtoHixNyNo4oWm1bydF/D7+ATol38vd/IahSdbu1vSq1fTZS6e7EAln3MZ5cMs4n
	 orDUM3+SClcXDXb1BTxMyN9THhljUvqQW+LekBlZvX7SWh6CdsHPjdYIzlIpCOnaTE
	 7k3q018WLSIDnPgmxa8FC9ciA0xPhZF2aGSInR8Pm2e9MiPOpP1JKWA2NBFggBaOPF
	 v0MQs3IS232qA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Yuyang Huang <sigefriedhyy@gmail.com>
Subject: [PATCH v2 03/12] tools headers UAPI: Sync linux/rtnetlink.h with the kernel sources
Date: Wed, 21 Oct 2026 19:35:42 -0300
Message-ID: <20261021223555.28372-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021223555.28372-1-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in:

  cc17e386f8a5 ("ipv6: add ip6_del_rt_reason()")

That just rebuilds perf, silencing this build warning.

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/rtnetlink.h include/uapi/linux/rtnetlink.h

Please see tools/include/uapi/README for further details.

Cc: Yuyang Huang <sigefriedhyy@gmail.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/rtnetlink.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/include/uapi/linux/rtnetlink.h b/tools/include/uapi/linux/rtnetlink.h
index 27265fd31e5fc99c..3988b51db539fe4f 100644
--- a/tools/include/uapi/linux/rtnetlink.h
+++ b/tools/include/uapi/linux/rtnetlink.h
@@ -399,6 +399,7 @@ enum rtattr_type_t {
 	RTA_DPORT,
 	RTA_NH_ID,
 	RTA_FLOWLABEL,
+	RTA_DEL_REASON,
 	__RTA_MAX
 };
 
@@ -407,6 +408,30 @@ enum rtattr_type_t {
 #define RTM_RTA(r)  ((struct rtattr*)(((char*)(r)) + NLMSG_ALIGN(sizeof(struct rtmsg))))
 #define RTM_PAYLOAD(n) NLMSG_PAYLOAD(n,sizeof(struct rtmsg))
 
+/* RTA_DEL_REASON: why the kernel deleted the route. u32.
+ * Emitted only on RTM_DELROUTE notifications, and only when the deletion
+ * path records a cause. Absence means either an older kernel or a
+ * deletion path that does not (yet) record its cause - consumers must
+ * treat "absent" and "unspec" identically. New causes may be appended.
+ * Currently only IPv6 deletion paths record a cause.
+ *
+ * The attribute is notification-only: the kernel rejects it in
+ * requests, so a notification must not be echoed back verbatim.
+ *
+ * The value space is family-agnostic: a value must never be
+ * reinterpreted per address family. A cause that only one family can
+ * produce still gets its own value rather than reusing another
+ * family's.
+ */
+enum rt_del_reason {
+	RT_DEL_REASON_UNSPEC,		/* cause not recorded */
+	RT_DEL_REASON_EXPIRED,		/* RTF_EXPIRES lifetime ran out (GC) */
+	RT_DEL_REASON_RA_WITHDRAWN,	/* zero-lifetime RA / PIO / RIO */
+	__RT_DEL_REASON_MAX
+};
+
+#define RT_DEL_REASON_MAX (__RT_DEL_REASON_MAX - 1)
+
 /* RTM_MULTIPATH --- array of struct rtnexthop.
  *
  * "struct rtnexthop" describes all necessary nexthop information,
-- 
2.56.0

