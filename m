Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6349CA5C
	for <linux-perf-users@vger.kernel.org>; Sat, 23 Sep 2023 13:01:46 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C9D3198
	for <linux-perf-users@vger.kernel.org>; Sat, 23 Sep 2023 06:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=iKOLR1/abyyRLoIbTu
	kWraoFan/mPbLAuASXHOWx8XU=; b=YM5SawHGFnUF/x/LXNWE7n1/cG9n8EDvcO
	H6hhxcytedjFyCRsui7uzj3BQwZMQYKTA28SB0TecezfJWiVPx8wDygroQsIht7q
	JaXI6pu1iT/jYaAv66L+dtifPi3cAbt7o9Mfi4zkVQHfrz1n+eLzJ0BGeHOheC7G
	4hXCltrrs=
Received: from localhost.localdomain (unknown [223.104.131.178])
	by zwqz-smtp-mta-g5-0 (Coremail) with SMTP id _____wAnhJ5q4Q5lT5VxCw--.50880S2;
	Sat, 23 Sep 2023 21:00:28 +0800 (CST)
From: liuhaoran <liuhaoran14@163.com>
To: ysato@users.sourceforge.jp
Cc: dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	linux-perf-users@vger.kernel.org,
	liuhaoran <liuhaoran14@163.com>
Subject: [PATCH] sh: perf_event: Add error handling in register_sh_pmu()
Date: Sat, 23 Sep 2023 21:00:14 +0800
Message-Id: <20230923130014.35490-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wAnhJ5q4Q5lT5VxCw--.50880S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr15CF1UAry3XFyrCF1kAFb_yoWkCrc_Gw
	1xt3ykWrs8Ka9IgF9rur40q34kZanY93W3uFyqkFZxGw1kX345Aw1kZ345JrykXr4xAF4D
	KryUWFnavrW29jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjS_MDUUUUU==
X-Originating-IP: [223.104.131.178]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbibAfzgmNfuLIHSgACsj
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
	RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

This patch adds error-handling for the perf_pmu_register()
and cpuhp_setup_state() inside the register_sh_pmu().

Signed-off-by: liuhaoran <liuhaoran14@163.com>
---
 arch/sh/kernel/perf_event.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/perf_event.c b/arch/sh/kernel/perf_event.c
index 1d2507f22437..36a1f04afab8 100644
--- a/arch/sh/kernel/perf_event.c
+++ b/arch/sh/kernel/perf_event.c
@@ -341,6 +341,8 @@ static int sh_pmu_prepare_cpu(unsigned int cpu)
 
 int register_sh_pmu(struct sh_pmu *_pmu)
 {
+	int ret;
+
 	if (sh_pmu)
 		return -EBUSY;
 	sh_pmu = _pmu;
@@ -356,8 +358,16 @@ int register_sh_pmu(struct sh_pmu *_pmu)
 
 	WARN_ON(_pmu->num_events > MAX_HWEVENTS);
 
-	perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
-	cpuhp_setup_state(CPUHP_PERF_SUPERH, "PERF_SUPERH", sh_pmu_prepare_cpu,
-			  NULL);
+	ret = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
+
+	if (ret)
+		return ret;
+
+	ret = cpuhp_setup_state(CPUHP_PERF_SUPERH, "PERF_SUPERH", sh_pmu_prepare_cpu,
+				NULL);
+
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
-- 
2.17.1

