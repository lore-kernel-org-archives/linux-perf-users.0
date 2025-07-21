Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D952D9495
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102464; cv=none; b=e0PymEhisWUIURMn/N0uyipGEc/HtUrfdaBRAbfgrmIJAlYEYWyTFARJiQGuzwm3lvMqpJQ6UrcULhom9CKRkc5a/8evjJXfERmeyYa2NrViFMEHKDfFlXxhaYNnenPRxGPg+YF5UI63S0Vz2zXO0yHYXND71Axemwd6dUsQJ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102464; c=relaxed/simple;
	bh=luIKfiwgtXeAFEj50ve3W9I2lyEw3hMNW0iXhyMCu40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ld1dlQRjx4qh2W1mFDlec+uiA6n3c4PiJhIORIEL0fAC8lScYm8gxjKBfoOuZ3CLcNbzgBN1R3rikHfKrVmE1Qp9gdPX7/OvvUGCNgEhlTN8CPHohOKt5nMCcH9tn0Lh8BpP/MJgKs6BswGVeH3w4nF2Q0T92k0bu7g4TjG42LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yzeReaVt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yzeReaVt"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so34973715e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 05:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753102460; x=1753707260; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9Rue6bPIg/trhgv/sEGIp6PJe+iLR+ZUbz2D5vC1ck=;
        b=yzeReaVtC1gTdZ22qQr9laznUR9VsPBzpt83ldD/JXfdyYsctknu8lvST5EDOiWss/
         cwj1ui61wPe7h8HomQL/vIhHSThTeJnHmx+ZPpHdgXN/tILKuIW8K+vGo08KuTnezV0p
         AtEoqWjfqUuxaKto73hsk80vMSm8GK43NpqZgSKlDFHz3f7DdDmHaHrMBCj5xojTXGeH
         Fc9tQxS7FrvZV8QPVaVz1Q9XyvMtDuJR9J/6N5+dY8V2x+ePF9ZDPOqhD8n7Nw/sK0Im
         6e1abmjwv6Z0uuBw5DDGtfLyD0B2PAyHlF/za77nJlKXaB4VvXifxQCIbVHRaVcUr3QZ
         Lxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102460; x=1753707260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9Rue6bPIg/trhgv/sEGIp6PJe+iLR+ZUbz2D5vC1ck=;
        b=W2c+3qlrPUpHESeUjFAlOUSwEqcwazQJgWNt1758kWzkvHBQzAAC5AS8h6JoeTUnQ4
         3FBEwc+MWczh4VX7h6qVPlOZqt2oiFoSiusIMqr2W/s6RZckB1DnpAjDIND4yrxVKnzN
         yfHPuWehrN0F8K3eL4J6//YnJx0KMRtDPzWBGXkzG3HWoDgCFTR/wh7UqJheIGa3ZgDg
         Uo4Wj4mYuHuZnlIFgCFhO1etCaiZySfPU3Ni0p+qwiY4leO3dh4rPKspwfoEhN3baYno
         Mo9mibm0aOxtjqJXke+ZfOLdEEiS6o6MjI86e2HAASoJSLzGwa5e7g/ufEwHpFYXrduZ
         Dk4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaA3MO74pjP0lNUVm5jeUzUWnFrLuu5yCjBEkqo4jSusAuLnHxOVzVNYEiejeDuwwMNX6EyjFX0mZivbdd8j1q@vger.kernel.org
X-Gm-Message-State: AOJu0YxGEvk3X29BJGh25bQfKqkHjxDN9n/5FbStwI/qHhFzs3lQecdA
	6ORpuM1iBfqwiU9qvYuhTo0/HmQKyfXqEgdl0WYdQ4uo/ae7ExfniAPBxrueraNVCgo=
X-Gm-Gg: ASbGnctlqZNELNy7hqUwa0J6fzXBy52+eCqbqTf76xTChCAYk1eEls63kJsd1x94FsX
	O6oXqLVMmu2xHvLqp40E2ZWH2pMK5FbwOacCMmbijKEKvxqinQDWqYWO8ZHkSUVJ19dUHoS5iAG
	qpC16Hq/ibt2Hvux+JvmyiaFnuwWBSVytRYBjBl/mOA71vp4Qm2vuvMvf2wSYIrs3MfNhWXAH2b
	9IRoy83hr8JwsHSJ3jO4b4cZ/HDapf8Dh5qBjw0wlaZxeS/0zGwAKEEE+0kYlgXsxP29rrmT46i
	kFDk5hj2QKvLY/3w0pKde+SCAcFy7BlAf4XLgS47hGvdSgGX5CdfYaderfRCxe261Edbo21a8WU
	hkHVKWX7B1MMZ4tJVh8IF1WNVZa+uLEYqai35Qb9YjA==
X-Google-Smtp-Source: AGHT+IGxBZUjqF1XoJ+We5sWi+shDrL0KCK0BKEfbRSuVRqaPLjbWwQUIAjCsxGeF4Kf4L6TaJ/XuA==
X-Received: by 2002:a05:600c:45d0:b0:456:21f4:a0a3 with SMTP id 5b1f17b1804b1-4563561a6c1mr160172795e9.5.1753102460225;
        Mon, 21 Jul 2025 05:54:20 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b75de26sm98995225e9.33.2025.07.21.05.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:54:19 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 13:53:39 +0100
Subject: [PATCH v4 08/12] perf: Add perf_event_attr::config4
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v4-8-0a527410f8fd@linaro.org>
References: <20250721-james-perf-feat_spe_eft-v4-0-0a527410f8fd@linaro.org>
In-Reply-To: <20250721-james-perf-feat_spe_eft-v4-0-0a527410f8fd@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, Leo Yan <leo.yan@arm.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Arm FEAT_SPE_FDS adds the ability to filter on the data source of a
packet using another 64-bits of event filtering control. As the existing
perf_event_attr::configN fields are all used up for SPE PMU, an
additional field is needed. Add a new 'config4' field.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 include/uapi/linux/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 78a362b80027..0d0ed85ad8cb 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -382,6 +382,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER6			120	/* Add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7			128	/* Add: sig_data */
 #define PERF_ATTR_SIZE_VER8			136	/* Add: config3 */
+#define PERF_ATTR_SIZE_VER9			144	/* add: config4 */
 
 /*
  * 'struct perf_event_attr' contains various attributes that define
@@ -543,6 +544,7 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+	__u64	config4; /* extension of config3 */
 };
 
 /*

-- 
2.34.1

