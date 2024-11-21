Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429AC1E52D;
	Thu, 21 Nov 2024 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188935; cv=none; b=eosp+0hWf4KNXfr6pYvDixodX+fUdnJQrwCCbE4t8xpRwIaFIS1iFSAqVPvYj+cjpS/S37cX/EAYqk8nPipaGV0s4sZ6HlaTAhu9XhzCUo1JqUItAYFhnjnPKTFEALufXIlDaQi5MWWCbhvr36Pqq2q15ulePXZMpq0lOWms2i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188935; c=relaxed/simple;
	bh=zQDFJpwMhtjgBx4tIIuBR+nJJDKCECfbdIBAqwkGf8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O0dRXYOvEnrSm1lKwD2LHPjhCYoVKQHkZXIORZceBBXeCYdvoLsGlLBpsA+Ig/FePnGuduWOjgY8qfAD7h0PVvNcB2SZutKodW1L4N5oJSgQTmMgT50Jc1Yh2uKfPiIfzvGWUPYy3n0n+x5qJrL/GGhFKff3J6sznah6cOfFasE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7673f1afe2a1-5f2be;
	Thu, 21 Nov 2024 19:35:29 +0800 (CST)
X-RM-TRANSID:2ee7673f1afe2a1-5f2be
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.69])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8673f1b00d7a-cffa7;
	Thu, 21 Nov 2024 19:35:28 +0800 (CST)
X-RM-TRANSID:2ee8673f1b00d7a-cffa7
From: liujing <liujing@cmss.chinamobile.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] perf bench: Fix the wrong format specifier
Date: Thu, 21 Nov 2024 19:34:21 +0800
Message-Id: <20241121113421.4817-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These three variables inner_iterations, iterations, set_bits,
and num_bits have the type of unsigned int, so the output should be in the format of %u.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
index 7e25b0e413f6..06edfd463eb2 100644
--- a/tools/perf/bench/find-bit-bench.c
+++ b/tools/perf/bench/find-bit-bench.c
@@ -104,7 +104,7 @@ static int do_for_each_set_bit(unsigned int num_bits)
 			update_stats(&tb_time_stats, runtime_us);
 		}
 
-		printf("%d operations %d bits set of %d bits\n",
+		printf("%u operations %u bits set of %u bits\n",
 			inner_iterations, set_bits, num_bits);
 		time_average = avg_stats(&fb_time_stats);
 		time_stddev = stddev_stats(&fb_time_stats);
-- 
2.27.0



