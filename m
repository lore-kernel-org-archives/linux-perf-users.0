Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACCB1E5724
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808719; cv=none; b=mwDuwqmn686cIu8x0d2Y8JHxQUP6M0yecoQ/TJpMgeZgyYTO+jiNi8cIgKtjf/QJWfB8VZDIr2nDM3YjDeWIco7+d90TSbRZwlGBCWxDd8wFO4hTCFV0KSXbZ4bTfdckJm4o9PicrCigIIJWp7L/3JMQebGztcM/IpIEv6Rensk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808719; c=relaxed/simple;
	bh=9AiGGaUHOh2C6AJyqb34e8YM2g4s5YiIRtvd0EhU/V4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aS0mDeEucv8aE9rKqBS4LTQVjfVTvam+YJXus3FOFf0zrZr6CTxucq1u4JbWC9h3eJh2ZLCIQEUGp13iAsLTgJXWpnkNqhTLBI1XZUi9gB57tDSC/m9fdehhbVPK84r8MYtJPEi3vdvKGqlJVmYGP7gVFEQt1wE7dPyUoRdDJkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=MDeubYlM; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MDeubYlM"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30edbb0dc5fso2082540eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 01:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1782808718; x=1783413518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pcbh2hH4jKecepaLWhXNqv0o5ONWwPeeMm+RS/NEOcE=;
        b=MDeubYlME/qzxH67+X+b3vX8oG4UKNwNPDVMZ81WzkDj9ZWTmAZpJjW0iK1L9nGJKV
         PQkTEosYUeGlDeeXNyQR5XBNBGvS2Po6HiBC+84YBaH0ncIo2GKgTygIj7btA83tlUQQ
         fggkZ1VYvWDsQDlAzWPXqLuL99TVxrnIUTVnkFDL1WXrezU6UYFcGSVU0qs6eFjVku2J
         /qeztdiZJ5ow+H5JwgwTOALgNWxiBWgM1gljNHM3vl0GDd+O56bFXQmLAX2lTumHL8+1
         puHkz/NuTVhHCgOmkz1ANNxGLmQcE0VypQ/jnB1apjWFK/k1u1tAeHcmw8abNUe8Hxm6
         Nn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782808718; x=1783413518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcbh2hH4jKecepaLWhXNqv0o5ONWwPeeMm+RS/NEOcE=;
        b=dsu78KebE+yJrOHO4Q6AL/1RoLku0izvPBAuHw77XRDLHvzQMUwbXTzhyiZdALwnds
         HOMSTcOe1qandGuLPZr+leCx0YBaiukzm3oH9Ni8W1Y+cgbNuJF4UggBJcS0JbsvX+xl
         f4IaQObtm+4uMysEJOBluE0fOHNBg8ZmhmJPVOKIRaoJQbV07xRU5HQuHxHFThHCu9mI
         9A45DM7ryqihXpn2HO3JH27wQaQ3rui8T2kuvoCvEobVTlrtL43+kJ3DLFzqh+uDyePl
         SbSRQEZVrV62hea4Y9XkBbzVtQQ/4n5WxVPdeE5WsM4dv9WmJT9ys0FAgl1YArNu28Mr
         6MbQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5Ird8Bob3G3w00o9Rz46/hPkoUMqCK1KufanfmXFw7UApzpW0ze1VAZYpPrJZHmtAubckCoOUdmG4j79LENf0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1KWERlRHWnLv575arYglt1dD74j+FXsoxi1PZ/oi5tLfd7l3y
	+v11ccUNYzpOnSGVfURJ/XI9u2wfJy4Fb5DGiocpcK3kQdZCLqJY/CK7BF6ddxRBz90=
X-Gm-Gg: AfdE7cmUEvZoai3yhaghTucWvJ4Nj7O7l28Q4hRSNrGZt8B3YjSaC5mnnUm5rE7dob+
	K+C+JZ3WLftzp2qKJsrDsTtIAIW5ZAVGSnwwY0N0XgR8H0PclGCIZjyjYLcDBxlD/8mO0TrvzEb
	eq5zQhMbk0KRx6O9NvqwAfXWLwnHAzsthv+sw830SNfbPute0W7ZimDXoN3UXmRB53GemD7wa1+
	cYnTpQo3O/l85ipdiXLyPGtZbhJ0AAO/0bA0NVGcUQWy6O4V63HHu3QZ52f+AgTWgGYlFUbIMZG
	fhataRSuJChsxDmBPzd+KWzEzdxhLB6H7Ua+9pbsitFnXRGRhFn88r+Z6qeASWWReIRvQnUkUyI
	lrlpec2SIQRa9Iv2p1VXMEKLGE8HmeIAtydk/A9q1wW3z3Jr/IQlo24koTmek3taQ0Yar2VGb3B
	7rJ0yEPzvkf7czNi23NaJjrKRIIKaWzbCUbz0=
X-Received: by 2002:a05:7300:1824:b0:30e:da5b:2725 with SMTP id 5a478bee46e88-30ee12c0a42mr2097408eec.6.1782808717684;
        Tue, 30 Jun 2026 01:38:37 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f5aeb0sm6756444eec.3.2026.06.30.01.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 01:38:37 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	mark.rutland@arm.com,
	andrew.jones@oss.qualcomm.com,
	guoren@kernel.org,
	david.laight.linux@gmail.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 0/2] RISC-V IOMMU HPM support
Date: Tue, 30 Jun 2026 01:38:05 -0700
Message-ID: <20260630083833.1275837-1-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements support for the RISC-V IOMMU hardware performance
monitor.

The RISC-V IOMMU PMU driver is implemented as an auxiliary device driver
created by the parent RISC-V IOMMU driver. Therefore, the child driver
can obtain resources and information from the parent device, such as
the MMIO base address and IRQ number.

Changed in v2:
- Rebased onto v7.2-rc1
- Use hi-lo-hi mechanism to read counter.
  Suggested by Guo Ren and David Laight

Changed in v1:
- Rebased onto v6.19-rc8
- Pick all suggestions and feedbacks from v1 series
- Add cpu hotplug implementation to avoid race enablement
- Move PMU-related definition from header to c file
- Change PMU driver to auxiliary device driver

Changed in RFC:
- Rebase onto v6.13-rc7
- Clear interrupt pending before handling interrupt
- Fix the counter value issue caused by OF bit in the cycle counter.
- Invoke riscv_iommu_hpm_disable() instead of riscv_iommu_pmu_uninit()
  in riscv_iommu_remove()

Zong Li (2):
  drivers/perf: riscv-iommu: add risc-v iommu pmu driver
  iommu/riscv: create a auxiliary device for HPM

 drivers/iommu/riscv/iommu-bits.h |  61 ---
 drivers/iommu/riscv/iommu.c      |  19 +
 drivers/perf/Kconfig             |  12 +
 drivers/perf/Makefile            |   1 +
 drivers/perf/riscv_iommu_pmu.c   | 703 +++++++++++++++++++++++++++++++
 5 files changed, 735 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

