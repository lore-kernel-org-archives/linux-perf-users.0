Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794633000;
	b=IewvUKzCgvQ7t3qzNq3iwGxHI7/3xMu0566y/WDYEU33Y7pv1eJaPYYRQtV1I+gHNv2x
	 Hj3smb84PFvm5QlStyZNRCFPTjxhfL8dYfBV+AmjVrBLKzkmvmuRdvvbs2JjZlAJkUJa+
	 xYKGsPN1fxfnW5jXlaJWUN9XQIuXaVDtWAMfjxWIBHOhfQHfWZe7peWOqB543L2Xz6CmA
	 ArZ8yyGm2W8wVWHJ5a5KGRsdwyJDX00OsWSusPHXry8q+iCjJqqW+HymD0W5100y00euE
	 NIhkH/nU7ygA6xR6GX1PpAnp6bk7wSa5w16hjAcHooNl7tjb1v4W+KUlAtcX9FgF4og==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633000;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+meceOzdP1l/lT0bUltE0+hi1b2jrbiaM47e+BK0Lkk=;
	b=eVJLWPIFWqbXnmQNOCI0EsNQ5p8ecHiKi/NZp4tlns7fHk7ctgDd98rFDy2fI/AHIGaP
	 xoSyIt9qjoxFP+E7SD9I8V6OZ32OCTRkCgWxyQMqpy/F3sojb0bKKLQ6Me5oTFA7XL9Rt
	 UNeiO4kW5oik7sqzcHi++pAEbBsf2k6IycvtNN1k0qo69VZuTMIwrz0I2Tht1HWrGBxtC
	 vDyTuN5DQsG/NXsno+bP4AbueA7Rri+6QPO8kqs0o0jawskcLv1A1+3qV7gJ6/oi+OHk0
	 IKH0anF/38jnUU31dz79EzjIFaSjTlNR+al1w5HRD85ia2oumbOanxYGq8yFYCsB/5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESQYyUmH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4725B606A8AF;
	Sat, 14 Nov 2026 05:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESQYyUmH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794632999;
	b=ttTsBa6GX1WwZqliFY19XG+7b2hcxWBLXBh6GhEIp7Op41f6uxJbG45h+bMu6mP8ygGK
	 QHT5UKDEH6FrcuLFrZ292ukKWyA13Tytay8gWZuvkeByE2dAzDe15t+3FN4Yk1gH7HGYl
	 7UejtqdLkp9f+sI8X1HawK3spHAeZYevR/4lHQX6byL9xR0ZitUFJDAM4xxgin4BcBcBJ
	 N0Ox6VexrM0iW+4VCyrVbL7H5KXxQXopEXL1r04BD2WiAs4nTmSTxi2+SF24iuvKj1NSs
	 RlokM6a+rTfbwDcQfmvpK45iVdk9MnopMt/Aru/lPBAVvvrTVK5mEydUZy2hEA2xf2Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794632999;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+meceOzdP1l/lT0bUltE0+hi1b2jrbiaM47e+BK0Lkk=;
	b=cDHoL4kp2q2mc+07XlMeEZbJ/aLJ0eRYcv9W/2lT6OZwrtrCoMl9Gq8YysrdF7RLg0db
	 Llc69+TT6+IuCZaQxsbuG6KCA/z5BhHL96CTEkIDrN6cCDCJxkYQoU0/2XlTaDFMWP1ja
	 jQ2YnXk6Cr2PuiJtZZDu1aYgYk9bY2qIYhGC0M9xkf7OZZ/Fm4iNHANfya7JcAyIb9Lfl
	 jRQXqTCa4uwDwNr4zvA9VkGdOQh3w2tFF19IwtEKbomPB4nu6h+R8f/qMkDiAteqGZU17
	 XgRcGCrsW4KVOqY6omJWiPoDntHpkCuIZeoBAOtSmH7Ls9NT1MK43acjftAhZDeAAdA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0D7C51F000C8;
	Sat, 14 Nov 2026 05:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794632999;
	bh=+meceOzdP1l/lT0bUltE0+hi1b2jrbiaM47e+BK0Lkk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ESQYyUmHuxzkzSasdw2CTATQwihqFyJOJk3bFyT7hXlqA4AOxx+qOV3Q+SvPs0xZe
	 siqi5BVyU8TdL0Dr/iighuvCK0vIakPQ2piImGT/UwYKuApKIjRIk8z/FanHPZy18A
	 NhnseCJGfkbUnpz/dn0dROuzmC8mSD/DpRriwLzagwekdF4xmNHlNSd0A2+jWqvmcI
	 UTLZs2X16fHL4f0xhRzPsk7CQ/zw5KXcgXsBQM/jZtv02HmRxGayfWWssdy7nuqVHQ
	 uiSBQnnZyqOxe3ipeA5knqLREBV3YRDPtakQzK78DyZhN1+OpwY7D9zRh7S2qL3T+Z
	 FUQdcXloeR3LA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8E58C49CA6;
	Sat, 14 Nov 2026 05:09:58 +0000 (UTC)
From: Alireza Haghdoost via B4 Relay <devnull+haghdoost.uber.com@kernel.org>
Date: Fri, 13 Nov 2026 21:09:07 -0800
Subject: [PATCH v7 2/4] perf symbols: Point to the symbol name instead of
 embedding it
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-perf-symbol-memory-send-v7-2-d992eced9f9c@uber.com>
References: <20261113-perf-symbol-memory-send-v7-0-d992eced9f9c@uber.com>
In-Reply-To: <20261113-perf-symbol-memory-send-v7-0-d992eced9f9c@uber.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andriin@fb.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alireza Haghdoost <haghdoost@uber.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2165; i=haghdoost@uber.com;
 h=from:subject:message-id;
 bh=5Vgr4AxcBlLUBP0rquFzxB5nBuvrWCjr8gPD/q+/iIM=;
 b=owEBiQJ2/ZANAwAIAVNlBDxl2ALYAcsmYgBq9+0kmE9p4X1qwosXQYvGbY/ESDG0k6M0O/a2O
 h07TLHfpFmJAk8EAAEIADkWIQS5+sFL3gX/8PrA0S1TZQQ8ZdgC2AUCavftJBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQU2UEPGXYAtj5cg/8DrWyiGSKdMn5ny8I4L32N9i9rMFVWJe
 9rzqbhMoZHy8b3Ikza7w1l0GHwfrw3hDawLx9VsBxgcI20UVnSIX9+V8YuvXCJU4NtgmiiV9tA7
 mPvmqNqDbroRXTwcqLIpLw50y/lCcl8+daWCMOxAW0kKZ6D9M70Y6I6BnAzNIUd22QB1AGWpJ7A
 ufW3lhViVaOK08s9E/NUOm2iwMaNnmTuI/i9oX36Fk/Ekmsfz2vFSiV7TU6ZwA+fEWBoxw6tzon
 teK6a+jse422nrfYjyAKk1GQr0nIGh5oUt62uraph/TZUivbYyHWNrbeifeKdxEwte/K0JlMcBx
 7Ce1u9lLJXQaFSV7594xMJ4gOiw0+3qCf4UtaOfkqawtvTf3tTu5c8rFcUYns2O57axD7+zQgQH
 d/azPVw+x4XXDzBF0dh807L3uaDFb6b3ur0EkBCDZz1Xc1M4BQdEzsnG1YmDhnkrg6L9u9k/F6E
 e9z0dPAxgf57cdvVEPY6ZD5eKIDt5aEtwD6eB8dK5kyH8QsOoTPvr4fGqrmN37i9g5bFlG6Xqq6
 gfGk0ylbip1oiw8ZENTUSivU8E92P3Lv5mdDwjsKf7OcE8+6DXTNda9fYSLogs0MofWizpuNoET
 hJNAssTEYvbREOIDrVVTn7zUaMj4hvCS+ltbHEho64fOBn0nEy4o=
X-Developer-Key: i=haghdoost@uber.com; a=openpgp;
 fpr=B9FAC14BDE05FFF0FAC0D12D5365043C65D802D8
X-Endpoint-Received: by B4 Relay for haghdoost@uber.com/default with
 auth_id=764
X-Original-From: Alireza Haghdoost <haghdoost@uber.com>
Reply-To: haghdoost@uber.com
Content-Transfer-Encoding: 7bit

From: Alireza Haghdoost <haghdoost@uber.com>

This patch changes the name field of struct symbol from a flexible
array (char name[]) to a pointer (char *name). It does not change
behavior, but each symbol allocation grows by 8 bytes on 64-bit hosts.

The next patch creates symbols whose names are read only when needed.
perf does not know the length of such a name when it creates the symbol,
so it cannot allocate the name after the symbol. It cannot reallocate
the symbol later either, because the rb-tree and the callers hold
pointers to it. With a pointer, the name is allocated separately and set
when it is read.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
---
 tools/perf/ui/stdio/hist.c | 1 +
 tools/perf/util/symbol.c   | 1 +
 tools/perf/util/symbol.h   | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 8c4c8925df2c..c65e3aa73a13 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -106,6 +106,7 @@ static void init_rem_hits(void)
 		return;
 	}
 
+	rem_sq_bracket->name = (char *)(rem_sq_bracket + 1);
 	strcpy(rem_sq_bracket->name, "[...]");
 	rem_hits.ms.sym = rem_sq_bracket;
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 2d611c05d000..02c077d7e2a6 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -362,6 +362,7 @@ struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *
 
 	pr_debug4("%s: %s %#" PRIx64 "-%#" PRIx64 "\n",
 		  __func__, name, start, sym->end);
+	sym->name = (char *)(sym + 1);
 	memcpy(sym->name, name, namelen);
 
 	return sym;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index ae7ede8f6070..c8b94f54f0e6 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -93,7 +93,7 @@ struct symbol {
 	/** Architecture specific. Unused except on PPC where it holds st_other. */
 	u8		arch_sym;
 	/** The name of length namelen associated with the symbol. */
-	char		name[];
+	char		*name;
 };
 
 void symbol__delete(struct symbol *sym);

-- 
Git-157)


