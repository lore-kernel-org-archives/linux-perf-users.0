Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F46318A6BA;
	Tue,  5 Nov 2024 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730790063; cv=none; b=SAXmrAx1AdXldmXhIRa1jMGBpjoi4k19EYNGZlqjAjW2ZCbDr/KcdU4BGx8VpMtuBelVf2S/vv5gemF7KzikYlrF9IshghMLDCmy4WW+FjyvPFw7vKSoIP8znjFVAPHWK49vIEjmqfvTZMDTkrCaV6O7OLZ7PF0ixgpWLb8PveU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730790063; c=relaxed/simple;
	bh=AjHIxzPnsgu63d3WwfazvL//43FMvdhRD4E1kZEA2aY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ujRKweh39dnu5dSeOfTyF4ugmiyXQlNYn4dBVWXP1Q7KmMNbpJdH80SKXIjAT4mr7RWI2WhKBy7BBG2dvXqs6b/JlRt/7zHiDhaoYpg1xFbPhtt5AcBaf98seD0PnBPcBEzAS6K7v4WD4kfV72O3Hc7uxz4DkfU9TymM89aG5NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H54RyW2U; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H54RyW2U"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2ed59a35eso4056224a91.0;
        Mon, 04 Nov 2024 23:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730790061; x=1731394861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9KqI7oKzto9F3nY+3finUxtWgNSK50Vh5Z8hrICoANw=;
        b=H54RyW2UjZALDUeROUYDrITECR8fn+dip/u6SYM610+JJ5EIRCocdQaiVZCGEWpJoR
         0++hdHuCnkmk/+B0W2c6W9K3nRKv8NYf/3p8mL9MGM0+tO5FhYUZtYu2v0s4ZMPsvOSq
         c7AHS376eNuDBb9AWyyejSIpKboY7gX2mTRAZfmOpnuviCOXrUjbf077ZomFb+WuSSDZ
         ntlwXoWD43Ww+qC42UmmjI6z2ACwdv/0gwpiXdgPN+WEBB/yNDvH6pHlgiCNJmgp0Kig
         drK5mhMZ/JN/H0NUgQDzIq81xye7J3TwW3O3E8umlKkb59wK61LDQqI+FDhhBUFYnIj7
         7D0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730790061; x=1731394861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9KqI7oKzto9F3nY+3finUxtWgNSK50Vh5Z8hrICoANw=;
        b=H57W5Mc1DsuICKJYBg+jd25kLURj6hHTShxPui/+lqOrfXU8kcRaw5+PXL6y+UKDTW
         PuxK1DK0kXnFkVAenjTbR5EbDEDxV07EXAwZmcYF5gFwKr+pGNctMHjvHtRz5eT90eiv
         L27XMnY/5nUkA7JUYEcjZpnUlgyq6eX2y2pHjMzyHMTqUdEFGaIQbFlevjJYUn8HwILC
         HEhK63m6mpflXW6iuWJKgMEtJe8/4BrNSVQw9hT5KILNL9wpf8A4ukatsmIBc+F76N8D
         j+rEibFsVHbxwChiOGztSChvy0Nr1n8v9IXcfdM5/PDRHz5ftHW3Dj5S46k13gESCk0X
         bnkw==
X-Forwarded-Encrypted: i=1; AJvYcCUEWPeGXQQCbv+OHxmpHYyNB6hHOTF6WjaIXtH73wc3RZ/fcNap65BcXUWkEyDFfi1QJ++uujaceFAsWpA=@vger.kernel.org, AJvYcCXiatKvXQRkx5tr1cJlLW5JYnD5+wOq9AZH53sAd4WwxI341nHudZOir14y7O+C+C5l4oNGISjMVt6L33MKOgs6Mg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPHiBBzQLHc138U34oURDKC+4CdFdi6o5ArtiF5IAr7MHUNuG
	cIIq4VfHwt2aw8z9iACdLV4wV+uvpLqcMhtQiCuw/roebn8XoxQ2
X-Google-Smtp-Source: AGHT+IEkKDcyTwV7/whPZGiRDuDsfmqbjrfDE0QyNSX037grkn8J08+K24f7OamDsQSTsyy3BLP4FA==
X-Received: by 2002:a17:90a:b706:b0:2e2:a097:bb02 with SMTP id 98e67ed59e1d1-2e8f105e828mr40420185a91.11.1730790061392;
        Mon, 04 Nov 2024 23:01:01 -0800 (PST)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e93db18480sm8819376a91.41.2024.11.04.23.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 23:01:00 -0800 (PST)
From: Daniel Yang <danielyangkang@gmail.com>
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
	"GitAuthor: Daniel Yang" <danielyangkang@gmail.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH] Use strscpy() instead of the deprecated strlcpy()
Date: Mon,  4 Nov 2024 23:00:46 -0800
Message-Id: <20241105070046.424750-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The latest kernel doc:
https://www.kernel.org/doc/html/latest/process/deprecated.html
recommends replacing strlcpy with strscpy. Since the return value of
strlcpy is not used, replacing with strscpy should be safe.

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
---
 tools/perf/util/symbol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 3bbf173ad..660ed5626 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1893,7 +1893,7 @@ int dso__load(struct dso *dso, struct map *map)
 			char *new_name = dso__filename_with_chroot(dso, name);
 			if (new_name) {
 				is_reg = is_regular_file(new_name);
-				strlcpy(name, new_name, PATH_MAX);
+				strscpy(name, new_name, PATH_MAX);
 				free(new_name);
 			}
 		}
-- 
2.39.2

