Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA0F28935F;
	Wed, 11 Jun 2025 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649178; cv=none; b=LhghGsjS1eDAu1/8B11B4dzdnLPusUHhby3cAX4htulUsHE9sz3aekB2eqPImF1vIF+XalOEr2/cF2gUeyPs2NUHGJUo2MhtjW3NF7AFONICk7taQlp563NczVRI9q3svti2t8FKUWEp/AXvRZiVjmzoZ0zciTRPTMVTcebq6es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649178; c=relaxed/simple;
	bh=5JaOacqFAetTQHP/6uBPTMlQ7/J4216HlL4n2Z0BrWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nSV+OcsTD2wVdrqnI7YsBFI4PBvs+S4m2cb1FShj9Qoo7ARPCjBmWHMeCLB84sq1DsYrOa9Cy/EtxK5ZzgqewdKaQWL97tNWA2iqLD78eGI2dJfr4Hfh5AGTiP/IGda1nW0Xtf4n0hwmBmtxCZeFTiVcuV57+UU/eiTNb2/9/iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXxl3dMV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXxl3dMV"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a35c894313so5879327f8f.2;
        Wed, 11 Jun 2025 06:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749649175; x=1750253975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u9OUAwlLvZYK3shMSnqjjuC2PPRPGLPZ13mljQCRh5Q=;
        b=XXxl3dMVqSj4a7twLC+0YpdQQlPFWcycTmr5cM2ZndJiIMw5a4tlTQpk10UlNLQok8
         soOmAZgQCTIMk1jhKaTCjpQPbuWNn1aX7SOX9K/qXIyPW0cO0kxZ1BEoAqvTnFQIqlXU
         YC03wJwgGt0GsuNS0wNgddYGMdnudE4MN9eciwjD4PL5ciG8VEBol7FjD6vVyMxezxGD
         /jWRlaNfr8o0L53VMxeIIUdg681ot/bKUsi9zZBMQJs97lhEwgSkqmVSyPqNYvT3xhPx
         /12RUNNr38tv1dWEtl7dUW2GFspYMwV+/LshWOu7OGQbhZrcazmaNG0w28+OnsmBGapF
         /10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749649175; x=1750253975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9OUAwlLvZYK3shMSnqjjuC2PPRPGLPZ13mljQCRh5Q=;
        b=kXXvcoV5UsJQ2qRWhcu+0zUNd40UdBycqxfPo13LhzJPzFRtoh7rfwRcdC3BOZxgLp
         9zMUxBcm0/q5x0iNVoytaaKY8gMuS7XJ0RLafWaIioI1I3QYDxklfIS6MN+iqY/oHF9U
         MYq9BV2PFjD/2qVvjdI8lapPhhXK2Jv2zCG16bvCMkEU78hCg1FoNJ0OnunE6iM2LURy
         PLAv5+Rgg7BWlaq4Oq5JtP6yPHFffVFSXkx/4JwnHasz/EupmH/zmKJZ1cZqJxbP9GIX
         T80Np6l8PC4A/knjkUVLTJJWDw1pvltFigbkfKMa35WqY7vbtvp5hdvepZQM8evjJOt6
         Oi6A==
X-Forwarded-Encrypted: i=1; AJvYcCUMZt2bEorGnTogdhxbu0lb+fl4s6mzBfygYl7DtCYV0mPlZQpfZ3ayqcHnwWrMVUqazs0M8euhWk1g+ipIzA0OAg==@vger.kernel.org, AJvYcCVBYMakqiZVSxTEdbQsQpKQNHp4MwR/C15hf5arPBNi6lzBm9/dys8UL+CK6g+KjyclkkGF3c3St+Z/c7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxswyMBzIWWodvz/N4d23YKZZOQhgaWZ4E0P+0P91JzB6zwd8zY
	6i/FqONhhKPr6XHgF4bjndN4n0PfX5+9kipWWF6UK9nj4GMmw1ZBOwsGPKq8D1pf/5Q=
X-Gm-Gg: ASbGncvOTtiI7bW+ybsr6nnMgltJ64DWia87U+ogMt2diW6oL+mQnpmXhMeFoLUQuTN
	0ru4WAd36lWzkoQICh0bq6uI3K7qlWTR+tXgL5fMgby6AakLtgL/7A/+zTwH/4BOvuAzT9w7P93
	Qgg5udOM98dCRAeMACw3ckmMk1cWshsBjek/6mFvPvqKC7BSUQwS143oPHdBdysChEzAVcSouWR
	rfucJfwiktlAM9L9uWdR6n9mC0zrStbjtN9VMcYg/GGl2oACRSJBEM33UVo/+X7qEQDoHmfLCMz
	4CWuh2JTg49I2xc4Ggcz3UokJ2EdErvclSwdUyRLyUxhzPxEUvCYrXwYsMY9
X-Google-Smtp-Source: AGHT+IHpYQTbruYDidDeB7dU9KJaK2k3lDmibncj0a707Hx+03zVcqPkk8SaraSqhwcSRXdxImzQ2Q==
X-Received: by 2002:a05:6000:2888:b0:3a4:e667:922e with SMTP id ffacd0b85a97d-3a5586c3053mr2264184f8f.4.1749649175173;
        Wed, 11 Jun 2025 06:39:35 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453251b6c19sm21702805e9.40.2025.06.11.06.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 06:39:34 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf: imx9_perf: make the read-only array mask static const
Date: Wed, 11 Jun 2025 14:39:17 +0100
Message-ID: <20250611133917.170888-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only array mask on the stack at run time,
instead make it static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/perf/fsl_imx9_ddr_perf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 843f163e6c33..267754fdf581 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -461,9 +461,11 @@ static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
 					  int counter, int axi_id, int axi_mask)
 {
 	u32 pmcfg1, pmcfg2;
-	u32 mask[] = {  MX93_PMCFG1_RD_TRANS_FILT_EN,
-			MX93_PMCFG1_WR_TRANS_FILT_EN,
-			MX93_PMCFG1_RD_BT_FILT_EN };
+	static const u32 mask[] = {
+		MX93_PMCFG1_RD_TRANS_FILT_EN,
+		MX93_PMCFG1_WR_TRANS_FILT_EN,
+		MX93_PMCFG1_RD_BT_FILT_EN
+	};
 
 	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
 
-- 
2.49.0

