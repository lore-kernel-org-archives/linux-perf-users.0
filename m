Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DF12E175F;
	Wed,  3 Sep 2025 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885925; cv=none; b=ut8ZRY95Y7F3Oy9H9ZKRDzwHeKqH0XraNBgnAGM5ZLKxU05kfuzz1KoP/hgadwrG/0fBGQmeqOk35MxiVYWm3qgZr7o+WBiRphHEYg7WFVexnn4c/UeaJDqLYPX13Mu7kxamfoDKcfT1+x5X4s9FsKmwvWIwT2/yWMT5mZTrF48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885925; c=relaxed/simple;
	bh=snFeoODT9BJH68tR+iP0pMSIayjTcR3o9mxxuFpWSE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJOnLLuAg+IoskN5dzQOv1BPoPoxJU/59abwNWk+0Bm/4wQ90vb0XUBvi6WIvd65Yc0vck8wbgOqZxP82LevAvPqSi1cU8oLbLjIVRw0bWvjmpG7FW6QoQ2wa6CSXgp78yYdUqzP0BLs4SEM14HTRtgHWZw+m01Dmu4BokmdRfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4qupqUW; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4qupqUW"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e98a18faa35so4087576276.0;
        Wed, 03 Sep 2025 00:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756885922; x=1757490722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOZrAAm7MRXs3mhO/TBGbkWZ+JqR99C9rh5CL922LRU=;
        b=H4qupqUWRgK/5ltHN/Uw4rtw7K8J1I7mbYVpVI+kOSv+apjIM9hJBszLKvxQcfERTR
         haEo1U7YiHpzgqekjmwELfK2pNKsoo+Y5HKqLq7tde8cjC0DFHEhCPp2U9ZsEzATDdOg
         y1hM6aaFz6F26e+UbyXbORNy4LHWfY8njF7yDH95lmxmPr64pXiYwjp90KgnfhiC+sQi
         gyuQAcdPoS/SaBnJEl9/khrlL/fX+GrsPzeiaVKC1eUw/qhuIVbqykHvD+vXTn81YHCz
         N8hngowmh7Ik4HyEPN+/+jKfZeCl4GaINDR061mzmIMwSbnhnaYMBbL2E39IN9rGUMH/
         TZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756885922; x=1757490722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOZrAAm7MRXs3mhO/TBGbkWZ+JqR99C9rh5CL922LRU=;
        b=GZMpW22BX8qTBnHY6Ba1EeIcxkTbsAQZJegNdxbVCn+sxULvPzuzdMEQSZSlM0h12N
         Aa7iDvmIi5lt5PQH/xQxkZ0+dutVHrSL7RKmzD7oWwaSoDrJZxvmGf742Q8xIoAvP3qL
         c5ohOlXE6xYMqZaZieiMIbD789aiqvkWNHkSOWzcrt8uLxI1kSqzCelweWfHa2GdClxC
         fwR0J0Hz6fKuS5ZNSr6lbv2SRciOQNyAIzju4B9Wj7mZftDPFhYhtB3vNALj2RgvByL2
         0VuKOWDlsUBVVuEb4dkiz6k+9XI2u5zwutsFEa9CRZLZXkUhtj+PIoe/BcxUwRB5XZMn
         /tGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaQg+876CrcXe7MRAFeaWN6lUMmO+UpkaqEG/havyzeM/3gN+WHc32ENmhYMqwLF6yKx0bRbqOjEActM6hNURx@vger.kernel.org
X-Gm-Message-State: AOJu0YyT5W82jJS9HJxmQfFcbwHjVluR5hVO2WLytk162nrc+8G8zZ3+
	GEElYVj95vDJZjCW8YyaXZgj4N/BL3YUxYECrnH7ad4CYiqIhsS3sUUC
X-Gm-Gg: ASbGncuK6iwRfn4sHNZ8RfGXMI1J4+2EHqFiJ2DjzvPDC/4jIDAZFPwMuGG3wI1uJY1
	1Rdv6hlkNZ2+ixJBsOWEsW1ClEdDKiWNpUHYCudzD/YZ/b1e4EerH0D0aovrI1fgc/9sxJfd6jo
	Zxi3lQ2ZwT23bv+yUg4ArO2RifhbemrzujD6NlYNEeqsOuDjUBz7O8XoBhNiVrenQH5oZ9WPOes
	k9Aiu90ts3rOVdL52HoFNCA58sRahzkQnBlnmuSnFmFESK9aNwz0ZROpjh1eP90cbC0yfpj/Dpr
	C/wKlLk2byxTjePVi47d+MCzWLhVlr3LdMDGFLjrusmtNotV/HAEAYqhR9l62XcDX/iY2ERQako
	u20KG5Ghs1jDnSnG6qVfFBkU5USmZyOdQzmUyc7ayqSw=
X-Google-Smtp-Source: AGHT+IGGlCydcbCwnYjVP4S78cXr3DYHM86OjR2Ma+Y6m0u1jhxiHyX2LJKGAS25ZQhtAPDCxTvu7w==
X-Received: by 2002:a05:6902:3188:b0:e96:fee4:5204 with SMTP id 3f1490d57ef6-e98a575a7d6mr13556559276.2.1756885922454;
        Wed, 03 Sep 2025 00:52:02 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a301:1000::20f3])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbe08c80bsm1288391276.29.2025.09.03.00.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 00:52:01 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 2/3] perf/hw_breakpoint: Parse before reserving slots
Date: Wed,  3 Sep 2025 15:51:39 +0800
Message-ID: <20250903075144.3722848-2-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903075144.3722848-1-wangjinchao600@gmail.com>
References: <20250903075144.3722848-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reserve operations update global slot accounting across CPUs and are more
expensive than local parsing. Parsing only validates and decodes attributes
for the given breakpoint.

By moving parsing ahead of reserving, invalid attributes are rejected
before touching global state. This not only fails fast but also avoids
unnecessary reserve and release cycles.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/events/hw_breakpoint.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 6066aff38eec..1db2c5e24d0e 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -706,15 +706,13 @@ int register_perf_hw_breakpoint(struct perf_event *bp)
 	struct arch_hw_breakpoint hw = { };
 	int err;
 
-	err = reserve_bp_slot(bp);
+	err = hw_breakpoint_parse(bp, &bp->attr, &hw);
 	if (err)
 		return err;
 
-	err = hw_breakpoint_parse(bp, &bp->attr, &hw);
-	if (err) {
-		release_bp_slot(bp);
+	err = reserve_bp_slot(bp);
+	if (err)
 		return err;
-	}
 
 	bp->hw.info = hw;
 
-- 
2.43.0

