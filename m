Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3BA1DED5C;
	Wed, 24 Dec 2025 04:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766549022; cv=none; b=bpS7U+SellCx/DVlxir6lfBLgy5F0JstUdFjWvCovsbrxTGHRjNIiVvBJ5k8bWKkZxQqMALw7V4jOjNJNBa8kKvaAZwn8epheLHSrprhrIEwBd7A8V5F+Zm1VnzmJRAmovuhD/37IJsafGZ2Ws/5P5J3A+8N+gC3Pq9kKpAmDhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766549022; c=relaxed/simple;
	bh=yWmYbd7ObM1gWpWRA6xOT4CtQ2WgtxNVRKPxsZ+S33M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KyWdJQUUCNL7yRafdSD/Aqw4fB3HbaKmECKk4PxShzk/dpVWl7D6gq2bfEjjEZqQHd9GNQN8B7h6mIaVtpR2iYKIwAql4Qypjwbpgn4YFvc23REf5ZujH7PU5Eaui6YY7FCTaOdVljBzzhAvHwpnNSAFpT0nEsRh/aF9FL0UDRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.209])
	by APP-01 (Coremail) with SMTP id qwCowACXQW1qZEtpliSkAQ--.15559S2;
	Wed, 24 Dec 2025 11:56:26 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	yuzhuo@google.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Subject: [PATCH] perf jit: close agent in Agent_OnLoad()
Date: Wed, 24 Dec 2025 11:56:25 +0800
Message-Id: <20251224035625.1532794-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXQW1qZEtpliSkAQ--.15559S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF17try8Kr4DZFWDuw4kWFg_yoW8ZF4UpF
	n8Cayq9ryfZFWfZryxZan3G3Wj9rWfKF47WrZrCa15Aw1ftr9Fkw4IyayYqr4UWryDWw4j
	vw4DtFyrZF18AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBgsGE2lLRjtnLgAAsO

close agent on error paths in Agent_OnLoad().

Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 tools/perf/jvmti/libjvmti.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
index 82514e6532b8..fd7efae40102 100644
--- a/tools/perf/jvmti/libjvmti.c
+++ b/tools/perf/jvmti/libjvmti.c
@@ -355,7 +355,7 @@ Agent_OnLoad(JavaVM *jvm, char *options, void *reserved __maybe_unused)
 	ret = (*jvm)->GetEnv(jvm, (void *)&jvmti, JVMTI_VERSION_1);
 	if (ret != JNI_OK) {
 		warnx("jvmti: jvmti version 1 not supported");
-		return -1;
+		goto close_agent;
 	}
 
 	/*
@@ -368,7 +368,7 @@ Agent_OnLoad(JavaVM *jvm, char *options, void *reserved __maybe_unused)
 	ret = (*jvmti)->AddCapabilities(jvmti, &caps1);
 	if (ret != JVMTI_ERROR_NONE) {
 		print_error(jvmti, "AddCapabilities", ret);
-		return -1;
+		goto close_agent;
 	}
 	ret = (*jvmti)->GetJLocationFormat(jvmti, &format);
         if (ret == JVMTI_ERROR_NONE && format == JVMTI_JLOCATION_JVMBCI) {
@@ -390,23 +390,27 @@ Agent_OnLoad(JavaVM *jvm, char *options, void *reserved __maybe_unused)
 	ret = (*jvmti)->SetEventCallbacks(jvmti, &cb, sizeof(cb));
 	if (ret != JVMTI_ERROR_NONE) {
 		print_error(jvmti, "SetEventCallbacks", ret);
-		return -1;
+		goto close_agent;
 	}
 
 	ret = (*jvmti)->SetEventNotificationMode(jvmti, JVMTI_ENABLE,
 			JVMTI_EVENT_COMPILED_METHOD_LOAD, NULL);
 	if (ret != JVMTI_ERROR_NONE) {
 		print_error(jvmti, "SetEventNotificationMode(METHOD_LOAD)", ret);
-		return -1;
+		goto close_agent;
 	}
 
 	ret = (*jvmti)->SetEventNotificationMode(jvmti, JVMTI_ENABLE,
 			JVMTI_EVENT_DYNAMIC_CODE_GENERATED, NULL);
 	if (ret != JVMTI_ERROR_NONE) {
 		print_error(jvmti, "SetEventNotificationMode(CODE_GENERATED)", ret);
-		return -1;
+		goto close_agent;
 	}
 	return 0;
+
+close_agent:
+	jvmti_close(jvmti_agent);
+	return -1;
 }
 
 JNIEXPORT void JNICALL
-- 
2.25.1

