Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBC024A058
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765919789; cv=none; b=Kq++JlBZ4sMsx0Kr/+S2GQPX+q+1gG6ympsXt76ylhUDvmZnszxrYw8KvlfnymAHxy3ipo614JWiyjRqZQaCLxg8QqQZlqpy5YvObZsmEsIRL+vVvRdaHQnSrkAovQPor2KCae0/kwEch/I7Br0yMoVRsSb/3mz4vmGnKuQ3+SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765919789; c=relaxed/simple;
	bh=7/tDwGqk6SrzcmW6C2uMBZPZBRZtu5p/C0meNoGA3Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/qXe+qj+z6sIoXMaz4qX2S4fgyd7DJlX7uF5kyzKJDB17IzzwHRV3hn8tL77MtdeeX/qYjSCj5tf7m0jnNpOh07LeirA4a4aad9CZPvhqR40QPJHgnr4CBe+BLxqrvry6ZIHtnbEkQx7qB4Y+bLA7uoqYH4b8pVVlH2KMtmV44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dLr+FgcO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLr+FgcO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765919786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JYyvoAvmvIm4uanb31D4x49l4mxpRuTUWVH4yF4HGLE=;
	b=dLr+FgcO6qYZI6LjWE0su9iXeLliDHT3/7L+k1JrmdcQbU094USDgbFrn8oOx/Mtuhalc+
	qX4PMUTzwq42jwzv6Jxxbm/yVA2n19Rf+JOpzqPNUxP84++bsO9K9tAh6SkjTxMZ42CHnf
	EGbf9Tj4c7lxGjyNNGms4A2h7T2sj/c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-CCCub82DM9yMhnuAywWDCw-1; Tue,
 16 Dec 2025 16:16:22 -0500
X-MC-Unique: CCCub82DM9yMhnuAywWDCw-1
X-Mimecast-MFC-AGG-ID: CCCub82DM9yMhnuAywWDCw_1765919780
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 498341800621;
	Tue, 16 Dec 2025 21:16:19 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.90.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CACC1800576;
	Tue, 16 Dec 2025 21:16:14 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: mpetlan@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	dapeng1.mi@linux.intel.com,
	james.clark@linaro.org,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH] arch/powerpc/perf: Fix perf record -d sample loss on non-marked events
Date: Tue, 16 Dec 2025 16:15:42 -0500
Message-ID: <20251216211541.111795-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Previously, when running "perf record -d" on powerpc, perf would drop all
samples that were not load or store instructions. This is because of an
overly aggressive check introduced in 2ffb26afa642 ("arch/powerpc/perf:
Check the instruction type before creating sample with perf_mem_data_src")
which drops samples when the SIER instruction value is considered
reserved (0 or 7 in ISA 3.0, and 0 in ISA 3.1).

This happens because
1) "perf record -d" sets PERF_SAMPLE_DATA_SRC for general sampling.
2) When sampling non-memory instructions, the SIER instruction type is 0.
3) record_and_restart drops anything with SIER instruction type 0.

"perf mem record" uses marked events by setting MMCRA_SAMPLE_ENABLE
which samples load/store instructions, so a sample with SIER instruction
type of 0 would be an anomaly and should be dropped. So fix this issue by
loosening the check to only include marked events. For non-marked
events, the sample is kept and isa207_get_mem_data_src initializes
data_src to 0, preserving the original fix in 2ffb26afa642.

Fixes: 2ffb26afa642 ("arch/powerpc/perf: Check the instruction type
before creating sample with perf_mem_data_src")

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 arch/powerpc/perf/core-book3s.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 8b0081441f85..bd44b83db9ec 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2304,10 +2304,11 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 	 * In ISA v3.0 and before values "0" and "7" are considered reserved.
 	 * In ISA v3.1, value "7" has been used to indicate "larx/stcx".
 	 * Drop the sample if "type" has reserved values for this field with a
-	 * ISA version check.
+	 * ISA version check for marked events.
 	 */
 	if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
-			ppmu->get_mem_data_src) {
+			ppmu->get_mem_data_src &&
+			(regs->dsisr & MMCRA_SAMPLE_ENABLE)) {
 		val = (regs->dar & SIER_TYPE_MASK) >> SIER_TYPE_SHIFT;
 		if (val == 0 || (val == 7 && !cpu_has_feature(CPU_FTR_ARCH_31))) {
 			record = 0;
-- 
2.51.1

