Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681773;
	b=zOA2BNSOVLahpwxGvqEtt19WV6EdkNBZWOJmglcqYPBoFkedg5IsfWHv5kxUaxZmhteL
	 TXQN73cYi1uj2svPdgYkQm023Jx2w884L/ilf1wJBYu+8LOohEeG5oWjcaOvanSxsiUSJ
	 IFysOf8klER3EiChqyyjk3VlbXu3eL8q+bUB2/9HYUmvOwyB7joR9kP6m2+ifrSqK5C5n
	 EugK8IKDkf6gQ+YD9UFlUIj7xBiZhRvkLgmSdqQTp3VpanApDHFusZnpoIq+0etqH81C8
	 1SGW/GYGqi8bxVbMMEbw0lqJ3PcGNEeXoe5WuBEfvphp/f1MI0oFVcD3pyqfEipakxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681773;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=g8kf8/GeH/g1HWFh6tDbyo06gdYqxLTJw8CjiHPTWWo=;
	b=tlLX3SJDMghphIY2WlEOXbqJlL8JZGPEBRB6q+TOVjKT4WenX0Oy/TL/vr/AmFNbiz5P
	 DpOFYXjnhx8pqxJ5IOUxSptE7LsbZfHIrEBxS6G8oJdYmGhmsBqkEBd3isCq72+g2QgOJ
	 Uypi+o7IoFTqKj1Gm1OJuUxqySbYFxPGM1x67v0Fl3U8VBpI3KalT2l4rAoC74BpFl7zn
	 nw2v2comnjaOojEmFvLeDIvADnlL+4cTimyIogAuB3qVM6+gJqvbjVjLO0NsRw2elX28S
	 Qw2W/90KZgOK6McNIOQ4XAesSgKzT+O3t/RwnIg3VdhuJ7Mj8Qv1VzHQHq4mLF9Udag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=WGqhDXyN;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5343E606A31C;
	Thu, 26 Nov 2026 08:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5343E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=WGqhDXyN
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 561726a28;
	Thu, 26 Nov 2026 16:29:28 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: will@kernel.org,
	mark.rutland@arm.com,
	agustinv@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf: qcom_l3_pmu: Remove CPU hotplug instances on probe failure
Date: Thu, 26 Nov 2026 16:29:25 +0800
Message-ID: <20261126-a35bb25eb5-u21-0@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
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
X-HM-Tid: 0aa216f94d3303a1kunm5cc7b3d23c2e50
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTB8eVk1DGkJLQh8dTBkeSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=WGqhDXyNpObUhpFwumADEkdXBBrKtopgU2let9BhoQMYMAGA1+aLf4CubUzWyWeKeFDP9J714hmE8j8oNLvfVW8lh+OUDoOzZMhjQjvL3qxTgdHUFPPkuEMKypDOcwre3LIHM4APPeLUBy9C7Pc8yi2sZoJpI4lsCpGVs46aB8o=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=g8kf8/GeH/g1HWFh6tDbyo06gdYqxLTJw8CjiHPTWWo=;
	h=date:mime-version:subject:message-id:from;

If perf PMU registration fails after CPU hotplug setup, the hotplug
callbacks retain a pointer to freed device data. A completed probe also
lacks a corresponding removal path.

Remove the hotplug instance on failure and detach it before
unregistering the PMU on removal.

This issue was found by our static analysis tool under development.

Fixes: 3071f13d75f6 ("perf: qcom: Add L3 cache PMU driver")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/perf/qcom_l3_pmu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index 3e0c00e3733f..afb13882f0da 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -780,14 +780,25 @@ static int qcom_l3_cache_pmu_probe(struct platform_device *pdev)
 	ret = perf_pmu_register(&l3pmu->pmu, name, -1);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register L3 cache PMU (%d)\n", ret);
+		cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
+						    &l3pmu->node);
 		return ret;
 	}
 
+	platform_set_drvdata(pdev, l3pmu);
 	dev_info(&pdev->dev, "Registered %s, type: %d\n", name, l3pmu->pmu.type);
 
 	return 0;
 }
 
+static void qcom_l3_cache_pmu_remove(struct platform_device *pdev)
+{
+	struct l3cache_pmu *l3pmu = platform_get_drvdata(pdev);
+
+	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE, &l3pmu->node);
+	perf_pmu_unregister(&l3pmu->pmu);
+}
+
 static const struct acpi_device_id qcom_l3_cache_pmu_acpi_match[] = {
 	{ "QCOM8081", },
 	{ }
@@ -801,6 +812,7 @@ static struct platform_driver qcom_l3_cache_pmu_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = qcom_l3_cache_pmu_probe,
+	.remove = qcom_l3_cache_pmu_remove,
 };
 
 static int __init register_qcom_l3_cache_pmu_driver(void)

base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
-- 
2.43.0

