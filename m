Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7154570DA
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291836; cv=none; b=FzJI+pkBRszj6pUv7CGx3kkdk/TFOV+/+m8428D6FIhsBBjnbsq9ZubhVX8lgi2NqXBpffOXiL3KBFGNTFMeAk9Sj1BqGwkfYrN2KV6scHpeXf7TAZBmhknm2Cq64XdNNlWf2tC/wuBHTbJ6EV30JIX/Jw18C1us/OdNkMI97hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291836; c=relaxed/simple;
	bh=gokoKorDgBeOWVaY3qpe9kh4x3B9TYxRvkSF94d5Ktw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SzDoRSwjWygR9h5xRHl61HaZyd11Xg8MSuF6ufUtctHb/jidZKopin+LDO1ssYfXl92WgT8Nqhp09n2yzeFCwyvXgPoRpCndnGQh/UcJ6xCyOQrShCoJC+fNy4RtNWs0PyfN9hSDRCdwbhGZP9+9vsnHG3FdAEmGiDArkIJCKmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DXa89ILh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXa89ILh"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so26802845e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Oct 2026 06:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791291833; x=1791896633; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=En7FMXeIRkCSXxTKcjg0cmpRWFNyaHOnmO3Q3nvCUIY=;
        b=DXa89ILh4CutGYWSvYJJsnnVruLR1l1G4ROmf7nHU6X5SHkWECVVsV1VA76xFJAHfk
         YuHD3hb+2kBNwZxOxE1A0ZfApoBdGPQGSFsTx/tvaDIwZ5j7Fd6JHjkbCPCykpvlN73f
         me6YJMUtucYDZTFEdjKJZYyEHTNF0sx06ULWab1EYKlY7G8LW1SVJcV4W6vjPDAyR9XX
         30sYTohHWYUuz++wIyh7LfDzx3OyjGs4bH+fVAhwx8Qan6YKFBEPDF/cFI+rwz0CQIzR
         3vXU7IwMxPk895Okv7zgcvjxMPfJmPjyY9O4HMDnQt8uwEW3l6geuUfFeLKWEcEOY5Lx
         LtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791291833; x=1791896633;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=En7FMXeIRkCSXxTKcjg0cmpRWFNyaHOnmO3Q3nvCUIY=;
        b=FN4FcVeLQKMrNy6/vfRzv2nopvD80vhI54075knKILza/4l96GXU9W2Cv3V2thxzqj
         k1j2ElUHej0sZ/+ruE1HQm32uqMdsf8lRYC9a5UhLEwiSHlWFM/kzmzRUNiJWkctc0bO
         TgM9e6NkPSci/F0ygIi/Hit2gNC0d45C0A3E/uVf5PztGa6AaOd4VNCKD+atLJEi5XIc
         glWOTmGNxANHUrwNEWVPyiKNst3zW4KPn0vkmttmA6BdaiBOUZaxODggYt7y6I5s7TCX
         hUCA4N3GDfxdkL0Tcrzidt0QvLHk3bBbukPWw68MqHIbbI9yzKyBc4glYas4YWYs6z1l
         P/4w==
X-Forwarded-Encrypted: i=1; AKwUvBzCcWXBOvdHaR13BeXo5lQHmHX21BAnnhy9qKyYCjc4g5UCBsMYJTRd+ncoauppD8IijtDSdNzNeDRX2HwLt2Gm@vger.kernel.org
X-Gm-Message-State: AFuF++m7qLBUDOEGAQ30+zlqZKFhroQB5QJcQWnIDSGPgGw4/muKoeeu
	w0oQV4+YtFN/rmJR+iiI1jMCOk/sDAOMpq8BvbOmEi7LdsFUHmdpNmDSK7dpr1sziRo=
X-Gm-Gg: AYBFou0Y64z/I7NIw47QifOgJGUT8h5JMt25A7MFvz065oV4UXmZmMsewqg5d2wJt6m
	sVMFCAisuZ3yyYYHrjcHaVNY6sRp/eMl1RhbBMe9uKlrCEZq2HD5uSOeyklUZr1t92S3oCLnF4n
	iy+WMgToOu8jHosdPKQEKQ24ilv6XWXlFaTCrQvNXCTXVtDIym8ycyysz7k6cDdyVVSoT7OvV0e
	brJ3i/OuvDvvZsfpBb43vJAO8dnpL6garMwSDqKAkOgA0ttwjYrcZXnHCyAxjly76KmchoE51yK
	cMqt2sCfJlI6tWOxOu92MaGMMojJFXsZJ1d7s//8+CyBbUnytxUFEKP6rF8FhSuC2FxVw5q+UgJ
	1Mzhe3nIH324snLrzBlVbYiQZ0moUJgpobLztph9wAFLdaoWviG5DZBG6UhPlSyb7ee+iEgpZy6
	VO6mEtxg9sms9+hSN0D/YXN2DFs9K90prfDLiAOAJ97te+ttnjrAgXPH+9rYfsTNLk6IEZ72L6N
	A==
X-Received: by 2002:a05:600c:b90:b0:4a1:62b8:9aa1 with SMTP id 5b1f17b1804b1-4a1680b5402mr187005905e9.2.1791291832797;
        Tue, 06 Oct 2026 06:03:52 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178c49c35sm78638295e9.9.2026.10.06.06.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 06:03:52 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/2] perf timechart/treport: Fix mypy errors
Date: Tue, 06 Oct 2026 14:03:30 +0100
Message-Id: <20261006-james-perf-timechart-mypy-v1-0-e2c7edf4dd31@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKPxxGoC/yWMQQrCQBAEvxLm7MAmgUD8iniIa69OYOMys4oh5
 O+Oeiy6qzYyqMDo2GykeInJY3FoDw3F+7TcwHJ1pi50QxvCwPOUYVygiatk+Ekr57WsDJ/Hfux
 jQCL3iyLJ+9c+nf9sz8uMWL9B2vcPgbzSxH0AAAA=
X-Change-ID: 20261006-james-perf-timechart-mypy-e0069393c0ef
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Alice Rogers <alice.mei.rogers@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Two small adjustments to silence Mypy static checks.

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (2):
      perf timechart: Fix task row type narrowing in goto_task()
      perf treport: Fix profile builder type narrowing in progress callback

 tools/perf/python/treport.py    | 5 +++--
 tools/perf/python/ttimechart.py | 5 ++---
 2 files changed, 5 insertions(+), 5 deletions(-)
---
base-commit: 1dc462fc214907671600172280c2e79ef9fe6fcf
change-id: 20261006-james-perf-timechart-mypy-e0069393c0ef

Best regards,
--  
James Clark <james.clark@linaro.org>

