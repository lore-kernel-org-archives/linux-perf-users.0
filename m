Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D56221554
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Jan 2026 04:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768104828; cv=none; b=C7T2mEucNlBxrY/SFLEh/XrLVb/cRUb2XyV6muzAMFiWKQTr4xjuOBtg3H62Dv07AZ4fJBoeo+jbAsUA8685tuZhoX73EW8msZSHjBz07kpePvlaJSYZzBE010cFIg/0YbARxAFiZC6kYq7c00czTtVTetyNH9pC//gbzDCOOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768104828; c=relaxed/simple;
	bh=LiM4wPnnfXt1IrKia0iYPEU/QsY83NzXUE/8uw4ggh4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=sobmfYTSRNW+TLSs146r4ovwk7BiCqbl32PXsj/P9x7uzNNJCJHQlAUhorRuC+6PijDKjGMogcYX35gJZWw5MXnxIQcqst8U3qoxfEnkf0DUTiHiDIx6yb+LL0VJ51iJpuxtgk8PeZ6ysfUd3g/qleq5e1KD8EqXw5UPxZ8E9aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=14NzTJmJ; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="14NzTJmJ"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ac39bd5501so4525176eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Jan 2026 20:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768104826; x=1768709626; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WlJfatNqFviEdPO7ixNChUO369/E+qRmLtBoNvsLZg=;
        b=14NzTJmJItv9kX7LipISbRIaBlz+wnMuh/l7GoJsoWrD7CeCiZUADq7RudojUiUEX1
         Hic2V1PysOQOFXa0HXdtkfcnR8/BgphbzfPygZ0APvSLSaS59HW4ln8fKEcVizjLuWk7
         HE25OnmSWAIY6qlmYuwk/ZKioRsXW7Z6dgRbH1j++gAseGhE2NmpTaCCruqcW6Oqrsmp
         74Q3WEGZ0u+I/jCY0czr0ydIGaOdMTLE0uTOgaUndj6ppiLc2/GSTPWP0twNeXVzbQp+
         vmmQX2bt7B/seY67IqP/zBhDmJ4e3lGOfl7I03hOsDQM3YCdAW5z8m2ZZQS4nFHsPCyY
         Xmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768104826; x=1768709626;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WlJfatNqFviEdPO7ixNChUO369/E+qRmLtBoNvsLZg=;
        b=HcsZHQ8EQXa/uKhXhwh3QN5HJliVugvErv/2QishhOiyp5qs6BWDzwnXtPN07J7ydj
         YJa3MSmsKqEZcTTnYh56IhJgQ4LH2vkbEQeO2eUM6oGx8wPDbILH7GpLaxV6s1KMQpsR
         Z5BGSN9qPlD3FV+XfZqEhgaPE6vcWtCaFhKuhkdwyOechaNjzF14rpMbWDIMCVCcOAba
         yeRzH1ERTx8KowrqNpeLjFbqftdMkorqUpjLzknWrlLAJbGPyGPL5H9f/DVC3cUbevn3
         zXDWUfSZ7TTj2TEYXhiCGobJ3XAW3gY0Nsi2V+kgBIJvzTJdCtmW/VLyB2yZBn23/rAU
         H3hw==
X-Forwarded-Encrypted: i=1; AJvYcCUsyOLiuQg2G7Wy9qeZ7vIaSImCAEC5mMLweZ3r1gR9cWxggG++EjdZJZSHmwP1kUBG49LJura/FtdoRHcEGR7G@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6jKwoX9HYdoV+thcbrqEBx774ZoM2pgKNeoE5SbD0EWuNO/Vb
	ZlnDQeS3UheRdJKDLH9ig2j/j92YFn9BXp+/oAfpnlA6hOelFmDPsdMUUuG/wYqHh8JEgGebuN2
	Zg9xGfO59SA==
X-Google-Smtp-Source: AGHT+IEpwPdXc4Q3lwXPOPSrlts+LFdhUOl0o1F42tMjY39XaGnLW0K8ZwodeKhZ9IPGKj2hKxeB+uK2/M51
X-Received: from dlbeq5.prod.google.com ([2002:a05:7022:2605:b0:123:171f:e390])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:62a0:b0:11f:3483:bbb2
 with SMTP id a92af1059eb24-121f8b160a4mr14112685c88.12.1768104825871; Sat, 10
 Jan 2026 20:13:45 -0800 (PST)
Date: Sat, 10 Jan 2026 20:13:32 -0800
In-Reply-To: <20260111041338.1817056-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260111041338.1817056-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260111041338.1817056-2-irogers@google.com>
Subject: [PATCH v3 1/7] perf unwind-libdw: Fix invalid reference counts
From: Ian Rogers <irogers@google.com>
To: Tony Jones <tonyj@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The addition of addr_location__exit causes use-after put on the maps
and map references in the unwind info. Add the gets and then add the
map_symbol__exits.

Fixes: 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/unwind-libdw.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index ae70fb56a057..3ff427a49e4c 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -136,8 +136,8 @@ static int entry(u64 ip, struct unwind_info *ui)
 	}
 
 	e->ip	  = ip;
-	e->ms.maps = al.maps;
-	e->ms.map = al.map;
+	e->ms.maps = maps__get(al.maps);
+	e->ms.map = map__get(al.map);
 	e->ms.sym = al.sym;
 
 	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
@@ -325,6 +325,9 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 	if (err)
 		pr_debug("unwind: failed with '%s'\n", dwfl_errmsg(-1));
 
+	for (i = 0; i < ui->idx; i++)
+		map_symbol__exit(&ui->entries[i].ms);
+
 	dwfl_end(ui->dwfl);
 	free(ui);
 	return 0;
-- 
2.52.0.457.g6b5491de43-goog

