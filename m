Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793428558;
	b=Da8k+CFpsclvQF64JHCh0OKD4ptvD51qs4rCH1OckedfTMjbrHTRYzglOmmuqGVLLvPl
	 HApVUC/bURNj4mNA8KR9vZ2jCXxW5inp7aZseFNp49MTiRvxd89XPM9XxJfoVOtOVesJv
	 sYTqji4XXZqDs/eopvJUDSddMDK2alLnJ2EWz0xS9U7FMgWclv6s2EoqVmsaBZzLG34w/
	 NO9EXIfpQAHwr4Y0jv0uC/KFR9cW931pqCVCasr7jFsPFXsUVM0pyTTkb6NCNehf0Xq4p
	 HS72j+Yh8VCS2J56zmcUo/OWKNI4Tvc25xlPDYJlAC6WMdxChM0exxt1i5P6t8tLgxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793428558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=NIJgkK/dbVO8vwsNzvrO3xSGo3pRrdpvP8C6zo9SmA4=;
	b=hn7m2qgVvrQ/69PYwaQCQW1MetSi1rbd9PchCqPePbS6rNpWx1RyNW4YRM+WZpdi+zZJ
	 v0Zix31e5aPvKmoPdhQwXD0gUy0cvxlLA4R4cagte3R7SXUCL45++sz+GB8jWRXtjfwJS
	 Dzi5LHyz1NiP5AuoB87nPL+crrHPxgnMR2x41rJk5pzo+f7v3bhJXIwsuipn1H6j5llW9
	 wGJ6kxj25fqRQru6Yrob+7rvotzCq43P9X5UXbrdarmvs3D5I2K08pfAgvfOdHObZfwgU
	 J/v1FF7c/r1GngGAFr1HMvxji4q6gc9CZ57VUk9TSsYbfVdscgMHtfZf17hvmyhU0Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Bp5bIi24;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2C3606A32A
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 06:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B2C3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Bp5bIi24
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-154e9d2d94fso2887544c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 23:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793428558; x=1794033358; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NIJgkK/dbVO8vwsNzvrO3xSGo3pRrdpvP8C6zo9SmA4=;
        b=Bp5bIi242CbFX+oW/oYuXU8EHCU2CU3ItxDrZZAxC+uKxjMC3kMSOkkqa06sU+PLJp
         gZDJDUV+KATWr/S5+F2XwLpiENtaeRzs2NxO4AHon/xHzmrsnNFOkcXSGqshgka6LjNn
         V+d5MURE343+/egKumGpA9g9tIvH6HUmM6ekY179ucsV7cMR+JflO9hc3d05zgwyqdtv
         tSM/TYsTCBnTwJXL+15FuBKa0RjJE+m3yG3CoHwvbJX75QLZq4xuTdvow7jGrUsaAynh
         wmerRKIq5yrX7paenDRfaCiqUojjT8E/8rPqI9h75z44tjHsAXkRsemP1polz/mP9XgX
         DY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793428558; x=1794033358;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NIJgkK/dbVO8vwsNzvrO3xSGo3pRrdpvP8C6zo9SmA4=;
        b=jlpzYI0by4D4Ec9DxebsuYVJznhFXUrbzJbRYh7HJoxaaRnhtM/X3EXojQbtb/grQr
         5j/itH7nFBrLKjPnV5FxEaq27Q+oPfK0nkwOvLGN+pmA0iU8Psukm4WKo6z6ebSzH9GY
         J/EcamQhnh76DSFcqfgXm8yIdzmup/ZLGA35lrwXYc20JeVRxV4cazH+Rn3+BlneMsxn
         VDWlPxEJjvHQ+zIBFG8vRE4Ygbe/L6uMgbyJBp3r5jQ5Pk7gD2omu8H6TcznSDfphtMY
         2zlA+djeY0xxtyE/1A8t7Z3Nz1Z9xGKVKTjBWi+bZKwHx0LsyiVcpSsXh5+EwHXzE/z4
         utRw==
X-Forwarded-Encrypted: i=1; AKwUvByx2wta+ZR4rynup40dXUAyLV/T3E7i5UEMLIQcwBnMW9akdz01TNQGiUHnr0AvH1koIC445wphz3iWN1KlEsFG@vger.kernel.org
X-Gm-Message-State: AFq9FYKT+QJC8o9daVgG4reKCuXiZk3+nV/DKEauU89U2lnIgvz+t7NZ
	np4ltrrm8KWS+Ju3zRHYaS29dyF9cj0Mu0E3sVbNDrM3rQE10cnD0qzY0sjwhx+GU2PA3ofuUZg
	bJy7l1uzodg==
X-Received: from dled18-n2.prod.google.com ([2002:a05:701b:42d2:20b0:191:327b:5758])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f107:b0:1ab:fe29:5081
 with SMTP id a92af1059eb24-1ac5ac4ded4mr5954842c88.20.1793428557302; Fri, 30
 Oct 2026 23:35:57 -0700 (PDT)
Date: Fri, 30 Oct 2026 23:35:47 -0700
In-Reply-To: <20261031063549.1281324-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261031063549.1281324-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261031063549.1281324-2-irogers@google.com>
Subject: [PATCH 1/3] perf callchain: Fix loss of symbol in merge_chain_branch()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Alireza Haghdoost <haghdoost@uber.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit bffb5b0c0976 ("perf map/maps/thread: Changes to reference
counting") replaced passing &list->ms to callchain_cursor_append() in
merge_chain_branch() with a temporary struct map_symbol initialized with
.thread and .map, but omitted .sym = list->ms.sym.

As a result, callchains merged during histogram collapse lose their
resolved struct symbol pointer, causing 'perf report --children' to
print raw hexadecimal addresses instead of function names and inlined
frames on merged callchain branches.

Initialize .sym = list->ms.sym in the temporary struct map_symbol in
merge_chain_branch().

Fixes: bffb5b0c0976 ("perf map/maps/thread: Changes to reference counting")
Suggested-by: Alireza Haghdoost <haghdoost@uber.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/callchain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 31c675cbab63..6d5212be466d 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1092,6 +1092,7 @@ merge_chain_branch(struct callchain_cursor *cursor,
 		struct map_symbol ms = {
 			.thread = thread__get(list->ms.thread),
 			.map = map__get(list->ms.map),
+			.sym = list->ms.sym,
 		};
 		callchain_cursor_append(cursor, list->ip, &ms, false, NULL, 0, 0, 0, list->srcline);
 		list_del_init(&list->list);
-- 
2.56.0.317.g454f8302e1-goog

