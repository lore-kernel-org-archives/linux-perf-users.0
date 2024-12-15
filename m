Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2181BC9F6;
	Sun, 15 Dec 2024 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734289643; cv=none; b=R24+VU2dqj3ekVXveB0y/oADiWO6Q/2Bg9GSn+ZEqfWR6vCVrvufpaaFzPg4bVI3ffrLH9fA/wm/RnU7dFIPBhIYCTp7iSRSXpPEDAU0fxvueT7SiEzXf+iPzusw5XsAQlPypt/qrdhLRioWYLsklcAmm+bIZFhJj5g5Dckp7j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734289643; c=relaxed/simple;
	bh=6xh0bVck0B8lgk6GVIh6/cpRZPxwDwkzpZZ20BQCKxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFYkG3Tjkb4hrb8gugPsrpI4UnJ2Pob4yP0cxF08qzte5IGv7cLzlI8Lfx1lL9qIPuQCBtVWL05r/3OkXBxxOcPJg/bp+e+Fo4YHEQK3iY0uMOPOXl42Ac0bf04ddNqbT2Xmr4HRJbBuRBYMfIJhuqSpc/iGS+DtNVVRnldVcxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zyh+RwdA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zyh+RwdA"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-728eedfca37so3529701b3a.2;
        Sun, 15 Dec 2024 11:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734289641; x=1734894441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NADZafaFYONt5GwVPkj5cWf8xMDXWYD7ZnFNifYBYQ=;
        b=Zyh+RwdAVqhMZz+9C5HLiQwsds2WhPQg7QAMLjBUAESVsr30Hi2C/35eBL4hCvLvnt
         CJ1AYMWKvcXUOIIg0MFdZofuV60B16mzyd+1e+KFwys6oeJdFsSAILq5PMhs1mXKRiPq
         5Vw7F4BEdUGMiWZkcvp+Yb8pb2DdfJa8KcRAGU3nXSo5RFlMy3frmOakA0Sl6Dg4Giud
         Rua29AU8jpDhp5cHPsx6HN5rqn0qgOuM82CvMfzt0InBe/u0RENUREhwrHKzhwsBNXvA
         q/6L3VmMtPAmgh2kHQUJW1j/dXrgTC6qwx/p+hGtQYY17ZEEsDOCdL8L57P7GDD4aEKx
         NUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734289641; x=1734894441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NADZafaFYONt5GwVPkj5cWf8xMDXWYD7ZnFNifYBYQ=;
        b=O41MYpbnnSH3e1egnf39Y6mIZ/8/7EeuJn0RB5eSK8MKp4wCIaorMo5QoibAz5hKCv
         QkN7Ap8KAeVDlVM9ME6HYPa6m18v6qrVwwFSZ5ffiW/1iN2ryhhs/Jtu5b0LwvCKMdvP
         ykrzGTekUgJogc8XhJPXpgJlojBV+dwOewLoteHZBMzTp9LdSEj1fwuAGaW+rwVcUfgf
         n7EcoPpzncrcWn0AhqXqzGFJ405EW23UmxzyXr/MsiDxr36YPfTS8tPJ2XQ0cKHiv0k2
         BHKbEN0WUQb6QkdyLESjjzZx0Wtb+KeL1aTLVhBvAJixuoJIK+Ju1eup3E5QdpbumWud
         +xxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5iSEqMzi+uqGufSXdaU9iDOuTv+gZVgctBEFiElqF9WYHsnPA+JPjOsMrGCLWitwIBond03OEPKr+twjyxFurzA==@vger.kernel.org, AJvYcCWqe40Vrqlf1KrY/4S56EGr5fkU84HfwYlWH6+Ht3ciG1nRNe+O1rsNNdVa+sXLsT7jyLefoa+Yab0qUjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUph6DB6SVsBUorcoKX2ceBhamO7EWNDMZPTc422SlaDjnNy2i
	XL72Awjpvv77TCf40uJegpAPbkkMT5NTGZAVE3HEsi4Uf/CUMCCx
X-Gm-Gg: ASbGncuIZKorOd1NGp6MZygezbAXiw7Tic9/kf3ZJTXr4Ja0jYBC3wXm4BMnUbryTA/
	zHSUE1rzUF4r7YpW9qFTOv0ssgdBEENDuseOBRO1z1VqAp9d4L8hBtQlb0g9Sbb6OK0yH3GiWx3
	OJlZ9lRfpKf5y6Q77RxhIIjA1gMBG768DE8Tk+aKLqEbUNQ7JdKVfEsEaarLKMdwJB89kQFy3Ku
	LPyexz9FYgFy8ymcne6+sR7GuUu9MWVVrZLuOqvSfULCNJt7HtGlc5gwK+LfBa2Px7vm5XxG8db
	ERs/TRzBo6zh
X-Google-Smtp-Source: AGHT+IGWuZzIHYx26WJG3udF9t3rY1MU/RzOW8QnwyP2bx2TC09CTtFrRw3MM2xcROEJ/OT+lG1Clg==
X-Received: by 2002:a05:6a20:9188:b0:1e1:b727:181a with SMTP id adf61e73a8af0-1e1dfd93f3emr15924394637.24.1734289641167;
        Sun, 15 Dec 2024 11:07:21 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5aaf3e6sm2800453a12.23.2024.12.15.11.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 11:07:20 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v4 2/2] perf docs: Add documentation for --force-btf option
Date: Sun, 15 Dec 2024 11:07:11 -0800
Message-ID: <20241215190712.787847-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190712.787847-1-howardchu95@gmail.com>
References: <20241215190712.787847-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --force-btf option is intended for debugging purposes and is
currently undocumented. Add documentation for it.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/Documentation/perf-trace.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 6e0cc50bbc13..fb3d2af33844 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -241,6 +241,11 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	printing using the existing 'perf trace' syscall arg beautifiers to map integer
 	arguments to strings (pid to comm, syscall id to syscall name, etc).
 
+--force-btf::
+	Use btf_dump to pretty print syscall argument data, instead of using hand-crafted pretty
+	printers. This option is intended for testing BTF integration in perf trace. btf_dump-based
+	pretty-printing serves as a fallback to hand-crafted pretty printers, as the latter can
+	better pretty-print integer flags and struct pointers.
 
 PAGEFAULTS
 ----------
-- 
2.43.0

