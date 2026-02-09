Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A8E1BC2A
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770645948; cv=none; b=EK81nWMQpqoSoWJc7UUs4Vyso5F7WnTyuKH0I4ttqWfDuGAuAuP+ZaE3Y4R1pH5LVNJI3PtqL9iGTe53ug14ZtmrhiN9qe0uGlxkJAPa2/3dhXmLScrlUNm003jezrwfDftNa/EgeKaHiiv5GQk6ZFLeVrND3/MRpx3eDREdzS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770645948; c=relaxed/simple;
	bh=B/IwUgOd5DXcW9PdwYVAYowMWyd8vMl4Bz2l8VG2QOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWphwzPj/27WjaHFi7GQwewYLt2mVNpzX+au++Nitjid9DAFwRmtho97nT2T211x623P04ifYpPuwvOi6LEi9clW6If//vDKbvv8b0V0mg6xmK2RkviZE5Yf1llg9fsuqjPhNI4wbOgA1r1HPQ+LxcIhwR/qVhTmGVThpGaVsgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6Ds+vkI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6Ds+vkI"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6581234d208so5131089a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 06:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770645946; x=1771250746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cOdIMg4WhLu1S3mr96oc0EMsJ584ffSXVjs2oqKfo7U=;
        b=l6Ds+vkIcJzlXbTiAXY4mbWGd6vGwUjKI0uhSP3Xqi4dYnzYicGxjOrRyXkBO5aGWd
         ry27d4CxLuFjvp/L/E5i9/3/qq1lJnZV+sLuO1Bdc2WDu0/ozmXyvp5FU/4D84hh/Z31
         BZJyPG9ECTEU/sGj77LAELWP37XRhlClrZQbV0qgD993qP/zu1/de4m88OL1DwQB5ksB
         eVxINmpKhe/uo9nNvsGl8scWUfjbPjIDcxRlavBn4Q0e6O4OmlnOSOhxIKAtCXOHY2V1
         IL8DiFGN1NXNzurerNy/sw1XG1FxdygeZtWhQV32tHGfJyhivkxfl6ing9SWNh5+OnrA
         34wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770645946; x=1771250746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOdIMg4WhLu1S3mr96oc0EMsJ584ffSXVjs2oqKfo7U=;
        b=sMOGhA2vp4IqdyAyQ+uG8N0hLS+PyyX9n1gbJeNCxmfWMe1mgI69GmNSJEm9ncwmhN
         MYRMu0UGtsDOsjtraEmydzkm3YvULLFOvv2qsFQ5J9LYO2ohTthv5d2oG26FBIzGx4yp
         lJncPaqnjWYLVZaG96eHKUzu4IKjom9olJqsatScwYzT3aWvMfAxjhCLLVsfI3lcLRJi
         vsOL9OnG04TNXfIcN7TYB2gILKLAyZl6CXObVdb7SAm1AoFj7e1+gGWHuaWPJJ3oSjD3
         mnvobO4uYxMB8WxJN4pIeGGule7og8B9oiY3fHgHqa2S3TN7uWtQG/cvqeCKMC/sduBG
         iAUg==
X-Gm-Message-State: AOJu0YySmBCXJQ7LBhntIwVGvVFwREWsq9EWP2ZtQEgVt4j1S3PR30K+
	SkkyMmoWszzqxx1Ub2seSM7j7BkAxKMzvOhJ2QDEGV97uWn8ESMjFHOaKpLWtg==
X-Gm-Gg: AZuq6aKHJeprGbgfjjw8ouVFnd5Me4ndx71so31wJs5J3vj36BTlC0LzvjPO4VKD93N
	iNwyBkH/FYwO4QRoAPdSrRKr85523P6fGSiPurIdGjQWCbk/7+tdHzuPN6bFqD55IdBp3FQL3vn
	RJVd8OQXuxeNFRUVMI+pz442QC2Ocn0qa+0mlEqanfAxSCZAlw9ywYctTvB+jBlzobQ2Bwiq1b4
	Z8jE18NQyLZVteeSKTDkF7CKid1B5Os4izTZA31ZPnSTZW/u4dXd9K1FmE2lpa4LxhaAxfYxHZ5
	ojE1OFxzHQ1/AIIbG+k9weUotbAu/eVKZNmSL3794szUSywnG9U2YtUMKzrjCd9wW8E8SBpiCTu
	95A4j+i20udT78brnqpAFjbhla2cys3yHYcSyF4Qp7LGrMOxa3BPwTfPTE1ii0GQQ0ZqKzrgbXI
	IuQoK5EwNWNSLo3B3TB+idIZUAKynv5akfK73sVI1FzAW/T/9Mx5sqEKn+x3OF4P7prLXdGfMLX
	JVgO5Kp4oK05ZXwC7M=
X-Received: by 2002:a05:6402:348a:b0:64b:416a:cb48 with SMTP id 4fb4d7f45d1cf-6598416489cmr5862165a12.19.1770645945913;
        Mon, 09 Feb 2026 06:05:45 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.local (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65984019d78sm3007855a12.25.2026.02.09.06.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 06:05:45 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Dmitrii Dolgov <9erthalion6@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v1] perf tests workload: Formatting for code_with_type.rs
Date: Mon,  9 Feb 2026 15:05:32 +0100
Message-ID: <20260209140533.194251-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One part of the rust code for code_with_type workload wasn't properly
formatted. Pass it through rustfmt to fix that.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602091357.oyRv6hgQ-lkp@intel.com/
Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 tools/perf/tests/workloads/code_with_type.rs | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/workloads/code_with_type.rs b/tools/perf/tests/workloads/code_with_type.rs
index 3b91e51919d..3dab39b22dd 100644
--- a/tools/perf/tests/workloads/code_with_type.rs
+++ b/tools/perf/tests/workloads/code_with_type.rs
@@ -10,7 +10,11 @@ struct Buf {
 
 #[no_mangle]
 pub extern "C" fn test_rs(count: u32) {
-    let mut b =  Buf { data1: 0, data2: String::from("data"), data3: 0};
+    let mut b = Buf {
+        data1: 0,
+        data2: String::from("data"),
+        data3: 0,
+    };
 
     for _ in 1..count {
         b.data1 += 1;

base-commit: 335047109d7d488bf5ad32a4076e1a011994cd0e
-- 
2.52.0

