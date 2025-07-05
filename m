Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1932B2E36E0;
	Sat,  5 Jul 2025 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751700656; cv=none; b=cnR17CTnu26GJjNIYhCnMB66XCIhf0VYZgy9gCd19In3XB5GCbUla01kVfOC3jGqpDnWPYe3hA38QBYPfeckD+/E0nq3hs9jDsT1y9x8MnoFczIJIOWBn+tW/3Wtzy7FAdZzvbXnskUib9caYRMwARtrHKWbmIDXigCt4MeWf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751700656; c=relaxed/simple;
	bh=UMKPX2cXG6IsZummxoOvXRavgYNG6TSZTLnhJKiZP3E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sVI6w3m1D0xS5tVRat0Zpkp7tBEUomFQaV2CSwJLM/Bs+Yc3CgNrlpngUNeWgDHSQxgAeUh/nbMzQ0g+H7eN+T128yj5sRkG9dQEwiOyv5AwhnENhJPMq1Xr3Npxd//MYqU4UJTDyekHAgIm58aNx8xMpCNaemNwO4JUy77iE9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVbh1gZu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVbh1gZu"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23526264386so15016545ad.2;
        Sat, 05 Jul 2025 00:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751700653; x=1752305453; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kmdrFnCGQGlfW9T+GcX8uPwJkq6p1K8BDyBOXN/hZ9Y=;
        b=CVbh1gZurpSdHMevf/ic+EjzKn9EjGJaOhwdB1PrV5MYBL1WPaEfw2zP/tFP0V0Ttr
         /4FZi0lzMIj8MUTJP4BPE+oZMri2VvbZISH7EciHV5VZ/M6hzv1RcbdxdYDD8e+g6jmf
         gdfuaGjBASA17Vy8cAZW1NYrx70y477o3B9F6OrddPGgc5Nf4+Tr4SSFPFdTtAN4SlyY
         hctjLTCvsazYFKO5JbOIp3RMFWFK2rgp0e6bzT5VWHoxAs57EOiMQYGHFH+4Eu97wDJD
         R/K8BHqrf5wqX+XbK/4hgzMpp3qclUewgep9y/agaP0BPkTWTYqi4xHO2K1B9oSMNEtS
         CSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751700653; x=1752305453;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmdrFnCGQGlfW9T+GcX8uPwJkq6p1K8BDyBOXN/hZ9Y=;
        b=c7MWIelg/wLGxx0Bg14VJZu4IktGsvOhj7aVV4gWlm9sSLjSZz7/S/hjGGNDOQqqzP
         W/amt07HH5Q/51oJmWjI2W5++nl0WDLAD/z6Mcm1/5wfkYTFrV+My69ytELpnN+0i1Fd
         gwg3euC+SlJgrTb0JVNRQHVhOLmoH0KfTrALRE1BTlCO223TrIX026VGQGXbAcyXFvGd
         9+G/jXjgcV8wAIj3aBuO2EZDBI5Y8cuJxPqSW0ALyHlDGAwU9d6u6Z8d+xvAI7Yy6Jl4
         HOSorTCvmIB3JdgQEE2ZQpcBaHznj7vramDwCmrWHivRNNF8rtuiQp/aOiEMG6BCriDN
         dm2A==
X-Forwarded-Encrypted: i=1; AJvYcCWbGPobcptbffTLUcfTDWkope1SIfi88fcKtQip+NwWAnRN2LGmQkM/2SFAETqTIqhGSNYBJx5NOR8TMHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+cQIlT2j+LQXA4Bwoi4qEq4Bdr3FUdHRjZ6I3yceyW8J405sx
	SdztMgGEpw2zmrxxXvkMSTg6KsrgQvSmzFAIXII3KRjZtEUrxZPNcGxx
X-Gm-Gg: ASbGnctqrlylm/MRCgKKMvxwtQZmAaDjh7RqSUfarjCpoewQwCrUx2THtEdi1HqjMBR
	9Cp4FyN1iWpLbQupvH7Vrs/4OHGBPHSP9vxl+nVVlvMoIhLOswgAhvecXYzt2C8NQVbwFkqQHTg
	I/eXBbta/nG/BzxZH2v2UbznqRyfHtfvT4QHRQ1ZLYqNCHrWJLr6GYv4DI4/A4yWeV5xYO2wBmF
	LPcnI/ixP81BwXfbpBT7XJ4iFXq76jnyR//4Ped485nlFsN+VD+sA7Lm2thWKRdfEbW8u2CZhzf
	0905X8nmjZ7ujsyLfokq+QrWkmMPxQxwAUc4E1f8k8lN4u9Hq+akVAgmzVNUFWV6VeNXDZKC
X-Google-Smtp-Source: AGHT+IE/04DPt7tUykh0udDgUo+PHx7RALY23hqiojGA+UTh4diHLWiAvsyqnxq2PSjlDNOouXdgow==
X-Received: by 2002:a17:902:d511:b0:237:ed38:a5b3 with SMTP id d9443c01a7336-23c8746d7eamr71697155ad.8.1751700653289;
        Sat, 05 Jul 2025 00:30:53 -0700 (PDT)
Received: from brak3rDesk ([115.96.219.186])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c84591cdcsm36002535ad.190.2025.07.05.00.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 00:30:52 -0700 (PDT)
Date: Sat, 5 Jul 2025 13:00:44 +0530
From: Rujra Bhatt <braker.noob.kernel@gmail.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, vgupta@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, skhan@linuxfoundation.org
Subject: [PATCH] arc:kernel:perf_event.c : replaced sprintf with sysfs_emit()
Message-ID: <aGjUpI1yNjEhSiAq@brak3rDesk>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replaced sprintf() with sysfs_emit() in sysfs*_show() function in
perf_event.c file to follow the kernel's guidlines from
documentation/filesystems/sysfs.rst
This will improve consistency, safety, and makes it easier to maintain
and update in future.

Signed-off-by: Rujra Bhatt <braker.noob.kernel@gmail.com>
---
 arch/arc/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index ed6d4f0cd621..424ec072c441 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -648,7 +648,7 @@ static ssize_t arc_pmu_events_sysfs_show(struct device *dev,
 	struct perf_pmu_events_attr *pmu_attr;
 
 	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
-	return sprintf(page, "event=0x%04llx\n", pmu_attr->id);
+	return sysfs_emit(page, "event=0x%04llx\n", pmu_attr->id);
 }
 
 /*
-- 
2.43.0

