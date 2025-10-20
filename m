Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601E3283FDD
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976572; cv=none; b=ImkSu27Kb9rj1+NmRknuVCJ+ihVSXrK8KcXQ52MSW9VyZJ9VJ8aUs7Ajxlq7zcf3aIMfa4TDqfwbMW6Qz94hsKsuUrbIeNsAnvNiXMcZ1f9fNGW3bEqc06jsxi8WkX/tWIk1R/Lcxz3Jbs0NVWQw5Ec/Y+IKNbjTZwEhPXYbUVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976572; c=relaxed/simple;
	bh=9aleKV3jYb4lyA7qIzUxHQD4EriPvhEU/NjvOR+A/n4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m4uV/x/cXCUISyzOUbVyGIvlg2r+vAqvPEudseVPdRYL/rFbHgVmM47hx6sFd57MZAkWRqn4vVLxRfy43xLFBg0/7WjDFN2hQUFWBJdgoxDOJ98ZPx3UHWV7rHgX/3DBsWwHJELTUWg7ekk+blD6P6zpSJ9H/R321Ls0pW1Jufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eObcZTdW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eObcZTdW"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee130237a8so2962664f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 09:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760976568; x=1761581368; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKgUJxK4ZSlmx1ToeoOvB+8Hg63ofocFdJXNrvPPt2g=;
        b=eObcZTdW6GXt109UhrrGYWlqd2zuCyE2eNKXDgguVEGzkPFQyzyAxCHhyBTu77rsGb
         cDVXtS/9O9wRb3qn4HLFZFXEqimsoAX3J58Wp7IdxuIACeKINtupy9bhgW4txIbKcxP9
         291NG74vFVJJ/X+jSNhb0FEiX8fDY0POwKHkbPiW5PdwSFXn8hYpenoSDSurwHJP31Go
         GeygvXh4evy2EynJmieqJQENk2DzuyHrtDY7v1DP8h6fJiDvk3KSb45ebwo2JaEjQUTt
         dl65GkC787cRTfwddnTdDvT6j7TqqebU2zL/mm6YUE8UEXFKosJtTqGn7XMK2D8hFvI0
         zAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760976568; x=1761581368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKgUJxK4ZSlmx1ToeoOvB+8Hg63ofocFdJXNrvPPt2g=;
        b=eV8vnq8bDhGbPNUx+udDyW2fGfOvtlMCzMWbed3681jyQvyq3I6WSLCBqLPg8LbA86
         +8UfSK5B4CUmL9Q+3J1QUotjHQRBvk8qnetq82NJ8Bz5u6bL0M7SRNNvb4+3ysQ3L1Ck
         wmo4ViZzRj42QakFwmQcy1N42QR0UCtp+MS4L6T8n59sGsmPM/j/EhXI2W17d3F4awLK
         OWyU3vxaDVc48OxSwvMdK0S6s7zFExTIrnJs7ztI72qbyeKa5zfYo5ofSuZ8kZHEHLVE
         JKvltxiGQPZoQGmXvvG2IKrVgZUO9smuPCX/Yy4ThITQYw5Nt6XvmrUBDS97JGRMVdeX
         mQEQ==
X-Gm-Message-State: AOJu0YzLyp4pkTzTIelEa0Zh34GkxKzlZtDkNkY6DeZYGL9035YCiupz
	CdWG5LpjQPVfA7VC1NCdtPgqkDG9QMf3pg+xHFfMC1WJLdUIaLH1/7d+Oq2a/rL7jmc=
X-Gm-Gg: ASbGnctsqZxeXlYjWbunDmgJ0bRgjr38qcIaZKMS1ARlRgR4B3OFZs5aSUQVl00k8QA
	vU7gqf8C/nllCQdRu5LL8v4N/MlBZ9I7nFUmKQcRB2enJTKU2OeMFEHnds0Nxg8hiqY6CNbgHms
	3vpzS/nyMVIxacRVz4ho06INX5gTbknng6E6kNFZqNr3p90I9HZN8ccQ2ZiAbC6Z8XxL6WbRN/J
	j6XQsxPIsz1ydUO6QSS2fhNveZxXp2V9VieLGybtNVSh0uUOB8v11/gnFciDJ//lkk9hIpF6z4s
	0WEImZwG4ViIeXJuuHCO7l8Ee/iQ3YgIpSBKtpvkmovxL+wSufYDM0o4jIIbIzOYc+lWUSgZ2EO
	kzzm2nuQnO4nhcOmdws40CprEq+lLms3DqYt+D2H+NN17CWSfMhaHlSSgOFpiP/L/BO/G7+5fKq
	X6SavbXW7HWQ==
X-Google-Smtp-Source: AGHT+IEphAXj5jrvC/vtHwqvcbcjL58pZTHjVIB8i8Gu48livdnLEA/6pKhx9fzVcD5EDbknNu8zIQ==
X-Received: by 2002:a05:6000:2911:b0:426:fec1:a58e with SMTP id ffacd0b85a97d-42704e0e681mr10197504f8f.53.1760976568568;
        Mon, 20 Oct 2025 09:09:28 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm16408067f8f.28.2025.10.20.09.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:09:28 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 20 Oct 2025 17:08:27 +0100
Subject: [PATCH 2/3] perf jevents: Remove unused makefile variable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-james-perf-fix-json-find-v1-2-627b938ccf0d@linaro.org>
References: <20251020-james-perf-fix-json-find-v1-0-627b938ccf0d@linaro.org>
In-Reply-To: <20251020-james-perf-fix-json-find-v1-0-627b938ccf0d@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

JDIR is unused since commit 4bb55de4ff03 ("perf jevents: Support copying
the source json files to OUTPUT"), remove it.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/pmu-events/Build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index ee8ba74f82de..c5e2d5f13766 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,5 +1,4 @@
 pmu-events-y	+= pmu-events.o
-JDIR		=  pmu-events/arch/$(SRCARCH)
 JSON		=  $(shell find pmu-events/arch -name '*.json' -o -name '*.csv')
 JDIR_TEST	=  pmu-events/arch/test
 JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\

-- 
2.34.1

