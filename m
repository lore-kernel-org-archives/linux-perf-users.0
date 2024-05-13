Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88467145B30
	for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586564; cv=none; b=m+qBQ1Nw9qlDobobHj3ebe73/cKo7fyCCa8VVv538UTHz1wQeAKVa7Gjs0eP2I9lQR81z6dkbSrHOe5GnXIxtbX7s2TbE4iK53dskyzPMq7CVbEPa9W6ELsWXQnnlrND/Ed8GIAa00L5SeT0jvN/slumq7QPTep0bThp92osDbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586564; c=relaxed/simple;
	bh=G0Wxv8Mr3gKi571FDo6mPoWa+cS4/DlqZzx4ZahtWhk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BhxdSAVqpnMpQIt1AQq+wrrJSM/805pzG7Dn/F86kxkCccR39w4l7pXI2ctGORee9EPbT2gF1imlfZbS7mD8Q211mnuzQTxfq+Dict4ligaTBDGkcgbJKVGDM7zC3t/qnyY3zNq0HRz5WQaAJZ7GtpEZ8Hg2RXAhMgwKKmC+S4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CUCKKwqU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CUCKKwqU"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ee7963db64so33661545ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 00:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715586561; x=1716191361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ce6cAtkfdDJ8qQDyG9L+69C5l2y3I58tgkjiw/QsktI=;
        b=CUCKKwqUevQwNv02m7TkbtrAN8z26k9dUe7xANRRKSUYwefDZU7dztOgXR2/XWSKvq
         WljQ5Ro5lyEMxuhQ9iXJ8OsPnsevz5zMePMOrzjd0VnHWHpsN09sy3qeDNYe+9pYsQXb
         0kcx5KgsvYTcp1w8J4/XjWkGqx6LvOXTpI6rsfMWPP6XE2VVle+XTFcqBMqrZ1fbudPb
         U+j5fl8bikeVzyRBEWg8uv+S+I7BmqkED1nrcc8WD3btfzz7Lz3SAKR1VA9qq+1iBknM
         QnRZrtKV3BzJAqBAwKBF+NPXpVIQXORpnMk4KwIgftnComaX/wsCrB6taSUfN+BzYTTR
         LZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715586561; x=1716191361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ce6cAtkfdDJ8qQDyG9L+69C5l2y3I58tgkjiw/QsktI=;
        b=IQBCYoRtXWEtdp2icm2j9keM1gWU9tJumd1aqeGByaSHiuhNq0i4VbcMN2uGSquR2H
         oYNNev/9VGry9r2maO5aIhE/m8ItkKjAMwjUqfkTx6qJtiFpH4YHg1qflj+mtVmzQJbl
         16zjQocEfd8K/KKvgiHebGxY4grk/911ViL9Ax/W0En9LUehMamXnZkPgvA29NmeNnUG
         oilFMYu1gyn5t57rH4KVlNuIQsc6sEDJB+Bcv7DKyGyaUKQiu2wU7uM8gFpuZD2qVUbB
         KSZeuQingv1QG2Y3geJudqltKDya7YwB8hI+zcsnICFRVwonKVZ94pYlUlW3FIN33nuo
         JKow==
X-Forwarded-Encrypted: i=1; AJvYcCV1WZ9PLMgxPbl6DHDK1ZhmjlYf5aZs8yyE7Dhu7cETmTkZwZw/OgzJ13PGX0snNiQghmwqH6tO3x+qRCSSP+wDf2j7Bx3iy0pS8gEysCleFA==
X-Gm-Message-State: AOJu0Yxlbfl1Nuxd3BSDhCV6ehacnTFZ+Cf2hyIbj0MjALqy1KUR817m
	2BxRPSvEQvyUJHCPomiqRRO9H23llet01vdkNBUo9dhkknK1u50YQ8zTUmusMzYXs/7rh6f53om
	2
X-Google-Smtp-Source: AGHT+IHsZkaJ8aFaqG2a2zjY3RR4Sd5vDyKdRVfmpduYP6Mph7JtbC4FwjhzP0o2kan4XSnp00oQJA==
X-Received: by 2002:a17:902:d38d:b0:1e5:963d:963 with SMTP id d9443c01a7336-1ef44059de3mr109780255ad.68.1715586560881;
        Mon, 13 May 2024 00:49:20 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badadacsm73396695ad.111.2024.05.13.00.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 00:49:20 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v2 0/2] perf build: Specify libtraceevent dir to rpath for asan/msan build on 64-bit
Date: Mon, 13 May 2024 15:49:08 +0800
Message-Id: <20240513074910.1660373-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is for asan build issues. For detailed discussion, see:
https://lore.kernel.org/all/CAP-5=fXJAu8OO_Gaw45Hx3uq6N8VQBNFhqcUy3Zm2vKT-TDSOQ@mail.gmail.com/
https://lore.kernel.org/all/CAP-5=fXYH4JnfQH98vPRttViBfYAWGA-aoGXO7q+R_Wt8AqFSw@mail.gmail.com/

Yang Jihong (2):
  perf build: Specify libtraceevent dir to rpath for asan/msan build
  perf build: Add libtraceevent lib64 to -L directory & rpath on 64-bit

 tools/perf/Makefile.config | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.25.1

