Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793230970;
	b=0NDIRO1wLYOA0j5Ia+If2+FAliYe6ZrnUbhnaKk4+/Sczarbv6L35rGc7wRXCybekHrb
	 r11fPcC8TQB2gi3LSMgml0ADyQ1P5tpLbni+o70elZCGMmLWyih+abKhHZXcYMAiu+Ej5
	 D/E+L9JjkHgvLu03R7cIW2vP5Q8mhV7Ie2HAqW1VDhBdMV97laDR2Id46HSE9S1GAcbRB
	 o3ia0k/cRatso2Mp4MiMnJNXIW6tr6AS5xc/4xUUqW5POoZ7xuXZP9I0NU8lxKk/oKofB
	 SlRpAtvZcdGXcnZdxYZW9mlVaCxhKlE2MzESXSjpL8Fea3d0/iofYBwhJ9HxaB2jNpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793230970;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ue+SkYqQqe5VSCHqCo+TzbjmpcMaMN37a534Nw3oPGU=;
	b=CTMlrgrg3UO9LesIAtscDaOjmTEA5pMDm6ulauAFV+0cXMwn23OwGRf95gfarb3agCot
	 lkE4OuUP9t1j0jQEAR+sBMgyYjwKaS3I0Y7sJMpuFNG3cx1yWByC7anw3ZgdUu1LVSjvy
	 lwWYol+5s4CjITW33b9C0M72QwFSgBDiGIoUkszTeG2ce0bdV3Vx7QYUo41TVRiGneyK2
	 78hoMLncM0SVieUzEuQqW6aafhxGX1a7UVHJdDEgTiPVaAMelmBnufXI//9m6uzYgfp+8
	 tKPshC4P0Y15+jGWBOCk1tsLgZ4o6P1KFc6GXZsKxANrMd742u3lUyxCCF1borRD7Wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gq5JEGqS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E76C606A31A;
	Wed, 28 Oct 2026 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gq5JEGqS
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793230969;
	b=D337mHypAdgJ8PiC772/p1ZDzv/xf7EqkPiEKSlLk64SUIWp3tKFslH2eiy2P7B2bPou
	 c14DswgPgM4lKFnZLITnd9Wovv6+dmPIKYPdDjgl5oErb/AlfUUdZIdTMLhSDun/1jPXX
	 uaMur6itVkiJruwYJ7RC9B2zumHH8EHpmwljCfDC9umXYSGB7ZNcL0R83Va4oQcht2txA
	 h+XQrsBL39oRBq7GB5pGwM2PNlTqTiCUhTe6ho8GAlCCdvV8g+M6sppQPAuDoJlmeJTMG
	 E8TX8k69p9OR/LbcsvHPcMlseqrU4x5kTHt38hEoKJx/uHwP9qVichIPMbpy8iELyMw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793230969;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ue+SkYqQqe5VSCHqCo+TzbjmpcMaMN37a534Nw3oPGU=;
	b=MmlUwL17rgatn+xXsg4xNbURK7yIpQ5TQnpFIdrpDfONq8IY+/cKeD9yjX+zejKCpizM
	 pBHY7qZN43pSzChtVImhcbllSX4pu52tjR6uQQ8lSOq7sBYWm7T3Tojns0Zckuzho2SRd
	 SUqbqs8Rjj2Re7FlrrT1OVCI0WlAoQzYpkRwxjC5YoJ3ejhuTn9LnZXL6DQGThkwqLxhS
	 ZiIljGqffQdpoSPOzsCiWDT/4Kw++C20PXK72pWazQr8HaI5oo+v27/2lHd0Lka6LtIDT
	 jREnCprBABiR+DLNur2S5sgIPMSUyJ7zyqAhdJxtspF3HSoIkMuxYyZaeKh0Nyd595A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 213251F01829;
	Wed, 28 Oct 2026 23:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793230969;
	bh=ue+SkYqQqe5VSCHqCo+TzbjmpcMaMN37a534Nw3oPGU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Gq5JEGqS1MOX1q7EYr7GhvY/gA9GB6FephXw62JAqNhJAFJDfU/ucI7iS2BQKvl5v
	 QiRtny1q/FmCHHh1Vcf4NoVKRhFOTQ+vtur0f93C/8rveKYXF1plu31a6loIyUzxdO
	 7engLVQG0zLzFcMu7LNXIbd/JqokmEMe3vylwuaUc8VnCbB+WZkds2rtfUXgbhb+EL
	 nEJhAX1jv7DLFcwatjeETX3YbxmjIL0jZazvcIZ90VszC9NFr62uikes7K2DfLcs0l
	 EiGvynZbfuXI59i9AXuYBkGdbM8TwZVLfnRq98CwkkB1WpqAD0l9Fgtj6hB0QGDBxx
	 Wbujh/P5Jk9CA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7CDF24560C;
	Wed, 28 Oct 2026 23:42:48 +0000 (UTC)
From: Alireza Haghdoost via B4 Relay <devnull+haghdoost.uber.com@kernel.org>
Date: Wed, 28 Oct 2026 16:42:32 -0700
Subject: [PATCH v6 1/5] perf symbols: Fix broken ELF_C_READ_MMAP fallback
 guard
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
Message-Id: <20261028-perf-symbol-memory-send-v6-1-7e90415f0101@uber.com>
References: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com>
In-Reply-To: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547; i=haghdoost@uber.com;
 h=from:subject:message-id;
 bh=H5Vq85Tm8NQPhPTcLutXNXbbky/gSKya9t0e+xIFiws=;
 b=owEBiQJ2/ZANAwAIAVNlBDxl2ALYAcsmYgBq4oh2LqSn5XngUQDSAEoTLgT/5b2zfuYksBeYI
 ZDSUKLlcPuJAk8EAAEIADkWIQS5+sFL3gX/8PrA0S1TZQQ8ZdgC2AUCauKIdhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQU2UEPGXYAth2Pg//UVVLtgzlKwHvZfFlAinqpW7I/jmD4e3
 g147t8ap/MTn8EYSpn9SbBwWhKiTNaeoz3bUJ1yxSFreOIW2BOEYwtTqniwWDjmSm1KlbWz3NTi
 zkxahL0JeWC1lvkw/ZXY13ouV3TdyC7wMa9Kiu1bBIgKKMQNvghDwpLsdRyvUH2XyIQuuClfSjL
 GpAC18gM7THMUDILw10kwxvIihabJ3fiv/XrG9nuDR7qnBoJHuk6Jsau3QnohtZucLFUWYbUXCi
 cIV3QOxufvTtrJpaw0vEgmK0RAlljnI4AvY1vpBdL1DIBYs0faf8bn6hNnVGXmwYsUO22sHHrcM
 ellJAIX3hKv2CpcY+bDYmsPq4ZWBIxI//K3b2ljBbpnPaBU8CXkXoSi8I+Osyh41Z6vXKY8t+6Z
 Ez0FSWcYwryv/RU2dhv77RzIcwJ/xjxHjb5ToqxIt1LThWxzTgV5KsaJfpFFvaLlhAHMQI5XbsK
 MQNXMeSq4Qq7i/EhyCTOWykIX0+wmdWjCvUvkWvG+fgdkHK4BlJk8P/kCC7zhvo9F0Pyjq4wH/D
 YAiwP3itAN+5UbtgY5P73/pUhr1lOHbrnelZJrx+5mVZ0+NblpMskKz3RlLvtLKmNa+sgHUUuv+
 fRzcefTAsiK+ZQLHCcRvt3Rks056A4nRxVeyOcqznkI5+ZfBXywI=
X-Developer-Key: i=haghdoost@uber.com; a=openpgp;
 fpr=B9FAC14BDE05FFF0FAC0D12D5365043C65D802D8
X-Endpoint-Received: by B4 Relay for haghdoost@uber.com/default with
 auth_id=764
X-Original-From: Alireza Haghdoost <haghdoost@uber.com>
Reply-To: haghdoost@uber.com
Content-Transfer-Encoding: 7bit

From: Alireza Haghdoost <haghdoost@uber.com>

Commit 22dd1ac91a77 ("tools: Remove feature-libelf-mmap feature
detection") replaced perf's compile-time feature test with an #ifdef on
ELF_C_READ_MMAP. ELF_C_READ_MMAP is an Elf_Cmd enumerator rather than a
preprocessor macro, so the condition is always false and perf silently
uses ELF_C_READ.

Perf already requires a sufficiently recent elfutils version that
provides ELF_C_READ_MMAP. Use the enumerator directly instead of
restoring a feature probe or retaining an unreachable fallback.

Fixes: 22dd1ac91a77 ("tools: Remove feature-libelf-mmap feature detection")
Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol.h | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index d0bac824c79c..46b1649c64fc 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -57,15 +57,7 @@ static inline bool is_livepatch_symbol(const char *str)
 	return strstarts(str, KLP_SYM_PREFIX);
 }
 
-/*
- * libelf 0.8.x and earlier do not support ELF_C_READ_MMAP;
- * for newer versions we can use mmap to reduce memory usage:
- */
-#ifdef ELF_C_READ_MMAP
-# define PERF_ELF_C_READ_MMAP ELF_C_READ_MMAP
-#else
-# define PERF_ELF_C_READ_MMAP ELF_C_READ
-#endif
+#define PERF_ELF_C_READ_MMAP ELF_C_READ_MMAP
 
 #ifdef HAVE_LIBELF_SUPPORT
 Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,

-- 
Git-157)


