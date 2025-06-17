Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203141EDA1E
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750199658; cv=none; b=bw4sXS0azxg8yYy6mjCEs0KVXJcQJcoa3S0praNpLLFw7UwzFhkowHHDlrEjXolvD0kFveWD2fwgbJu4hvoTHlCQv5rW484G93SExhQDzlHFkFR6k213BO79HBbunmgWRqQph5w0rw8rkba1IurYq9Y7wMonVnk1Mrq5Y68aoX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750199658; c=relaxed/simple;
	bh=eCuGjp6hG/MXH23RM/BMJyOq9nbIlhN/iGtH2KuanSk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=scCUVfS+dpTfblhIfuDjjt95e2ZPMppObWE4zuWnUw1r4Vwx5jElNmnrpTNoQTPbOsLQc9/WcHNPOwp05AovfJjTMefl75yto8LI5mGjw0AOx5VGWvnPAhJW6Op5f1w3ptThWXodwadWtyPV1DgJ5hAs1K7Q+WMXqkaQRtofRRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=li9dyRK3; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="li9dyRK3"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b31831b0335so4487865a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 15:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750199656; x=1750804456; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ole7/QKvdk2YX82faNIgxPbHeQ2syHOfB0nwCHGLyac=;
        b=li9dyRK3VgVWyVRWS/UMsyI7UwoyCj8jyvY2OjEmNP8w85A1+NTaoSM9YARLeNiuv+
         6Lqu9s4CUMlQJ8lOf+ZozPtl5YXid951dT4KnsK6+FBek2uPAkhjQL77tILfWjT+MZ1j
         8jBtJpQgBEtduXkceonaZsfSUogG+nq69D2XaZ3DVtrwIPWiALuDwfnvT6J/vOW7XoyM
         MXoB6idVTnCdkfalgEwWvuCh04hPE/GthpOnioblbe3Beg+Q72UQRSGrbX9axc9ikyXi
         +ujQl2I7g+DOal4HaGMBvjU35kmoYzB+2SvVhddnwJ0os4G71F/cMO7+qBLzmi9AdM51
         SjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750199656; x=1750804456;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ole7/QKvdk2YX82faNIgxPbHeQ2syHOfB0nwCHGLyac=;
        b=Yt0rYX2QzGQQPhjJa2B3WCZt3Aa6hoNmyAzC790f60X3uzrnpaK/Ucqmmg4UxLXYVb
         nMnhTMIkQNwYKvfx0tSkVxCVQtlIHITEuM6+0WlkMCclydkyEWOmc1huuI6mR46bHHyj
         qP2CPcf39uRgjW+Vf7EWQVWcCyU0Yp3Sm0OD8T+YXrIY311tvASEVSlz8v4/loiMHjRS
         lUtiZTBHUJCxl14hgJEJlFco7BNJQTa+ojzIZfHCCtmUJquRsxXL7EkyBFQJmBZj/g7y
         zyaSo323uXActGNuHavX03Q7vSsKeYVFRwzjmatgMsJt2uA80lYz5O5rcyTOXjI+0N92
         sOlA==
X-Forwarded-Encrypted: i=1; AJvYcCWL7C/x7cuay26ryvHcHdjZa1KQfKsOrM7mO0vwFy9DRssoSXiDmoXGw33FfneJJ/6221klqNYEhtZQlDyRrPj8@vger.kernel.org
X-Gm-Message-State: AOJu0YzoE5RoTKQXYd39mlo+kTbBPTtINoPwVsSQwQO3mqQHwpg1e3hH
	mdcPIW0eHouxrrZTNJ4q0yPbIh211HZD1hC/+TQhpO9TJgSif1iiEJGMh/XLXwD1aHZ0Fw2FV0p
	oliXb+4mVtQ==
X-Google-Smtp-Source: AGHT+IFqo/2say/u+Lf3kECAVOASzRCWN1tWiNcZXQsgMOYI5Al6Fu55dP/lwgpwm2CkUARyqbdTct5OAd3H
X-Received: from pgct18.prod.google.com ([2002:a05:6a02:5292:b0:b2f:6348:f715])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4983:b0:21f:bdd5:d71b
 with SMTP id adf61e73a8af0-21fbdd5d743mr22982667637.2.1750199656506; Tue, 17
 Jun 2025 15:34:16 -0700 (PDT)
Date: Tue, 17 Jun 2025 15:33:54 -0700
In-Reply-To: <20250617223356.2752099-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250617223356.2752099-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc2.761.g2dc52ea45b-goog
Message-ID: <20250617223356.2752099-2-irogers@google.com>
Subject: [PATCH v2 2/4] perf evsel: Missed close when probing hybrid core PMUs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Andi Kleen <ak@linux.intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add missing close to avoid leaking perf events. In past perfs this
mattered little as the function was just used by perf list. As the
function is now used to detect hybrid PMUs leaking the perf event is
somewhat more painful.

Fixes: b41f1cec91c3 ("perf list: Skip unsupported events")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/print-events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index a786cbfb0ff5..83aaf7cda635 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -268,6 +268,7 @@ bool is_event_supported(u8 type, u64 config)
 			ret = evsel__open(evsel, NULL, tmap) >= 0;
 		}
 
+		evsel__close(evsel);
 		evsel__delete(evsel);
 	}
 
-- 
2.50.0.rc2.761.g2dc52ea45b-goog

