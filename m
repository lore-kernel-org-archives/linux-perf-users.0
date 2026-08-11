Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E74641A4E3
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464456; cv=none; b=r1KqmeliVyJDGDVqs5NucnqsZv1giTFVwN5rh2d/2JcLq1Dz/Hncz6K5SaL3vso7HilWMlipZw/1e+ZumpL/anYQ6xwv8BtQWThxCQfUwt2B2Vn46/juXHh16oLG/HotcBK11CzZbSLWstqxADdVenbrACs9J3xSplhJfO9Oax8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464456; c=relaxed/simple;
	bh=b4iGCjAETc70J2mY90wjgIvRfv40Kh3jeZC9IcZWgrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fdk2AIOhfGOpIcMjiTBKhBW6RgHZZfHrupfuYoVDgBO7nwuV851q1usGGtTV2ilKAJhmltcRpjbuv43E+aLSyByL9dAZ/trYpyiNzT3qfgF6TfAtHC4F6sQyGhkEJ6Y0k1ofmb6agr/ryBmoc51nPVn8c0zaWeXBK2wGbmmKJZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hDG6nBoS; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hDG6nBoS"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cbb973e6749so3793984a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1786464453; x=1787069253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eCz0YHuViuBY7u6bH/PtQQQ8c7S/xgDkr5juavEWHHA=;
        b=hDG6nBoS/RaRB1vO1cgCc17CBWzxC6NsupXtVyU7ozjYPA8WOvHA2mTHuCt7AjIyhN
         MzN4lGO4emwjGB2zLNiYWC2HgvpAPV0YTwllGpbRpljkUbLM1wUHdlN6WPaZkdyyioA3
         pvOoDkHrt8J9lp8hnG/PwY9+Ss88nKC2W16/twT+mTeUGRqyDSs0Q4DWb0D1MkWOrYkM
         YaDEuGCCgApqGK75nrPs5ulkXTZJvJfc9OBfkCyEmeGa2FztUyECxTl3scsNoFYXPohK
         rvSlt9X1iLONYq4uTtURY1qfPc4bUK9b7t5HBYx1WtyoOviC2+ErVqD6+iBv+E9xQgQ1
         lG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786464453; x=1787069253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eCz0YHuViuBY7u6bH/PtQQQ8c7S/xgDkr5juavEWHHA=;
        b=Dz37l9mHt7ESjrz3f/0Fk2pc6rJS1m4uN2lgWHlEZSmQpczkaiqS8+8AmsumqG3qo4
         OSMm10ol61cWMvp4kmJ7c0wiiV5sWKojT2XS8J7Bu003JNBusNDO2zJ0ijdBjlCXaJ34
         F5imkd91U4F5grKIN0yXTtGD8DEHery07cei/1G7JzhZDuQxO97zTBnSi3KOTNUhivKC
         1Z8iM+Zo3bNbWMQQyPVquYYBBqNiClWCkt2AfpnheP+5OdCGvPcxGEj/w4L5zMgeex0F
         mJa4dbyR8C+xqjDfSH5FwFm7UR7xhEJQ0Q9xuLdzKVhNFIEknjaBwMiqCnQmPaItGLsD
         +E7Q==
X-Forwarded-Encrypted: i=1; AHgh+RpsNBeeKeCUmQu8Y6xnUAwJXlEtyT9wecQniTG7yip0dyL/lO8/T2QeERtVSSCMW6kiLh8bj2FZhRSuC8SqMJOc@vger.kernel.org
X-Gm-Message-State: AOJu0YxIdPqGLCuar/BFGfSHL2ve20Nyisxhlkb0JE25sSGMIKeWOrUG
	zpsr4AREwJtKJtTEo68bwRiiOaEKSLRkR4/4uoUGAcFymBE816kbamP+9h2DedKvhdY=
X-Gm-Gg: AR+sD12J0C4iWF+jxlRJVp1SkMIbyrrQITlSbFTnYujbyqmLqSjOMID4JM8c511zxPb
	a/P/efO5zWe1tqeyUwhCEDlN2JifVwyNBZ5bi5fhGe2yXUvYRmudR6AC0zkpwmmGeBJN2b3YGR2
	OjOZKc3A6WgTU+e1wvhkNBThhPMrDSrXwcyrVavctjrsH1OSrrZElY0vNImKkfPvFYKu1tl7kU/
	WT5y6vHZv6eMMHRcFnbpu/A1clHjAB02YyUWF6Iebwm0yN4aezm4RFL6ulEZL9xGA1qFhhxZwLH
	oQLflD3O/j5eg9gCPfPW7wcZr/MAoRETT7HzbUoL5XD4bWIO+IFHKQejAZjvJMUl00GyelXu6Wi
	FTxuEEtmNJVmpErLylOqFfOGaKEkQw35AuNmBVhjEGsYkVVcEhElN0CvhlQ+ybNwuMDoReRXve5
	b9kOkkg/dYUjX4bwIljbIusqOvEuMXkAsuobpG3BugiWeg6twEK00t2Ci6z/QlqiU6MfuKp1GDL
	jFNt256nqpVUDm+0WI=
X-Received: by 2002:a05:6a21:6497:b0:3b7:aefe:4367 with SMTP id adf61e73a8af0-3cc2bb05975mr6307163637.33.1786464452412;
        Tue, 11 Aug 2026 09:07:32 -0700 (PDT)
Received: from FJ7FR2JRQ3 ([178.93.176.7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf3d0517csm893108eec.9.2026.08.11.09.07.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 09:07:31 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>
Cc: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [PATCH v2 2/2] perf/dwc_pcie: Skip sibling walks for new group leaders
Date: Wed, 12 Aug 2026 00:07:20 +0800
Message-ID: <20260811160720.28580-1-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260811131714.12779-1-zhangzhanpeng.jasper@bytedance.com>
References: <20260811131714.12779-1-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

for_each_sibling_event() requires the event context lock to be held.
perf_try_init_event() only takes that lock when initializing a group
member.
The DWC PCIe PMU walks the sibling list twice for every event, including a
new group leader whose event_init() method runs without the lock. Although
the leader cannot have siblings yet, the lock assertion is evaluated before
the empty list is walked and produces two lockdep warnings.

Skip both sibling walks while initializing a group leader. Group member
validation is unchanged and continues to run with the event context mutex
held.

Fixes: af9597adc2f1 ("drivers/perf: add DesignWare PCIe PMU driver")
Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
A system-wide DWC PCIe PMU perf stat completed successfully with the same
debug configuration, without lockdep reports or kernel taint.

 drivers/perf/dwc_pcie_pmu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 7b2e28aade73..a6667ac19a99 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -417,6 +417,10 @@ static int dwc_pcie_pmu_validate_group(struct perf_event *event)
 		if (dwc_pcie_pmu_validate_add_lane_event(leader, val_lane_events))
 			return -ENOSPC;
 
+	/* A new group leader cannot have any siblings yet. */
+	if (event == leader)
+		return 0;
+
 	for_each_sibling_event(sibling, leader) {
 		type = DWC_PCIE_EVENT_TYPE(sibling);
 		if (type == DWC_PCIE_TIME_BASE_EVENT) {
@@ -452,9 +456,11 @@ static int dwc_pcie_pmu_event_init(struct perf_event *event)
 	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
-	for_each_sibling_event(sibling, event->group_leader) {
-		if (sibling->pmu != event->pmu && !is_software_event(sibling))
-			return -EINVAL;
+	if (event != event->group_leader) {
+		for_each_sibling_event(sibling, event->group_leader) {
+			if (sibling->pmu != event->pmu && !is_software_event(sibling))
+				return -EINVAL;
+		}
 	}
 
 	if (type < 0 || type >= DWC_PCIE_EVENT_TYPE_MAX)
-- 
2.50.1 (Apple Git-155)
