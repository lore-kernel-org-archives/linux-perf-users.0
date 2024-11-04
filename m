Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1C31FCC4B
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755166; cv=none; b=HUMVg7r8l+Ze/UhPti58fVvTrOTGMXYFZMesXmtGcktp+GyBrX2gkUnbAj6zPePunga/bIk+e2GztFssx/r6T1gTNEF+w97jJQ16TKD3C4Sy6aTDPj62y9NxHCUVzyu5NvEB5CSlMnfy7h8QgKcQEXPrH3KtplpSfDgxOU4Mp0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755166; c=relaxed/simple;
	bh=ckz2b09PADmewB6PWKzCnnP2d1FGRyLX6Oab2Bw7LRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XGjd51gbygqasko5tuKN/juyLOpYJTaHjnB9qrKJdSGLaIJhNMZLRVlATGvgsVZhBpU1E10ymms3DecqTk8tu8Ra2tB/536dHuIQfwMQOGE70iOuryVw7cmNwVbDDhxnfee1mbHLDfJIOxTtYSK9zVM5itpi54cgFylavv1crLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=R7Ijie7k; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="R7Ijie7k"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-720c2db824eso4355739b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2024 13:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730755164; x=1731359964; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B7VFZJDeshaBgjeWIFYPhisTVO49atYEdsiOoKJAJfU=;
        b=R7Ijie7kXJ8wsjT/1pYW8Ej/7SP9EUPXbJmPf55xHJjY24BK5/aBwywefTSSryZgix
         uQb0v/Szql9jyAhFGv3Oh+IkheILL6qV4UJSyyqnbp78lTSCtrAEuNljUH+r3ExlnaVa
         1qSkS2sObX7KyXnVzd6EaSAb8AUnGNwtPNuLjaUXih0m+APvnQX5bYjRD+cLa6sftzx3
         Ot/nVU1zZxwo7ou3NWzVez16nHssRn3iXeqdBhYTwum5CZBowe2v8DxbWaHYx7DIAK1S
         tPG6ixLxKQYCgPziSKl4WOQem45JsWga1Nv509CGl1aZun5iyeUJZS5j4vjA//PZ/IDl
         66RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755164; x=1731359964;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7VFZJDeshaBgjeWIFYPhisTVO49atYEdsiOoKJAJfU=;
        b=iWxNw6sssyRK8+0+l6Sc8w8U/tKYLdsZsRB2fbVAppBuVBT34o64NzJJUwsAi2sr4i
         ZAcEMwQ6ajGOKeJTdC9xXvKR47tQ2YBxLpSoVp78GLt00LePEEL1Jlnxa9UndLuLh1Mo
         4UDvkm9AmplzREsWXGulPpiv2BSQymOHQ84anOzxNAGbWUJTObTbsiOIxpV1hSmZcoXF
         MHPSHxe5uUDKhjHx4+3kqiE+FISlEWIMhw31tKyDAp4o759LIuiaII0XFW3oOavdaglZ
         dUWgPqa6AMTxOc9L4CZaWTCcUG6amr9ic2a3DpeQ8XHIv1WRwiozZct1Jgb6rxj326XP
         xZuA==
X-Gm-Message-State: AOJu0Ywf+UcHcZwAOCDWfNC3U8XTnMqMBzlqNS9ZvI/t58vUxTc/QrkK
	WzKpI8iUYbUuBOAr63At4smZ8nUFVD/KYpwfIcI53JKA/su0FQgm3mgfXR3uMqsMdrJc+mehp1+
	M
X-Google-Smtp-Source: AGHT+IGxdnQJocTNFzEN9oyHKVuXZJvNTwlFkn8XBlUG6umm69XvTTuY4E2zmsa/aNVVZeehrny4Vw==
X-Received: by 2002:a05:6a20:7f93:b0:1db:f0af:2277 with SMTP id adf61e73a8af0-1dbf0af227fmr639531637.38.1730755163757;
        Mon, 04 Nov 2024 13:19:23 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f3e0efa90csm1270988a12.2.2024.11.04.13.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:19:23 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 04 Nov 2024 13:19:15 -0800
Subject: [PATCH] perf: Add all shellcheck_log to gitignore
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-shellcheck_gitignore-v1-1-ffc179f57dc9@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAFI6KWcC/x3MQQqAIBBA0avIrBMcE4KuEhFpkw6FhkYE0d2Tl
 m/x/wOFMlOBXjyQ6eLCKVZgI8CFOXqSvFSDVtogKiNLoH13gdw2eT7Zx5RJalQOW7Rtpy3U9Mi
 08v1vh/F9P3EJMlFmAAAA
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=853; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=ckz2b09PADmewB6PWKzCnnP2d1FGRyLX6Oab2Bw7LRc=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7qmVQivWdGPzzMWVzaeetaT0DZ94/mJvy+d+/BFJyPhj
 4qpTtGnjlIWBjEOBlkxRRaeaw3MrXf0y46Klk2AmcPKBDKEgYtTACZiuIvhf/kymWdLeYv3BR6+
 tiPwrIaL3ZT2N4uXn4xJa9ySJqG9egojw8f/lw6Hl0Y/TPJeft5go35n3kW1QMalr6fnLZzp8EB
 wMy8A
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Instead of adding specific shellcheck_log files to the gitignore, add
all of them to prevent these files from cluttering the git status.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/.gitignore | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index f5b81d439387..19ce1cd56f8c 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -39,9 +39,7 @@ trace/beauty/generated/
 pmu-events/pmu-events.c
 pmu-events/jevents
 pmu-events/metric_test.log
-tests/shell/*.shellcheck_log
-tests/shell/coresight/*.shellcheck_log
-tests/shell/lib/*.shellcheck_log
+*.shellcheck_log
 feature/
 libapi/
 libbpf/

---
base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
change-id: 20241104-shellcheck_gitignore-210c131b372b
-- 
- Charlie

