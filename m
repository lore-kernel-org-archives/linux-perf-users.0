Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0A71F4CA6
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Mar 2025 05:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741064690; cv=none; b=Jk53CloSTQ2dRGGXt4Lfut3Z0pugJmP/XWg/EfUESmKvZL6xx0T12GJ/fSaCdsXcUqNbk+62MG/LNlGNk/1fe74wuUtommKnZdw5Mj/BhItd59oxAL7xH2dPwJuR+oUVknkN1Q6FT+UvAKcxyGWqpZcfoh2tNu8WkZHHr8eNe9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741064690; c=relaxed/simple;
	bh=nhCPtbgEZDkd1Kvn3UPUrTlm5xI1UpW+IfGhCPsfYms=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=M7258C3cvuZ9u9TUirEX9cXh3CgUcEksrK0cVYEcoSKvYpwsB/JdMno8fqGTZVHWw91cSkk+DgXq43In9cwRLzVqkKdKlKq8IxR/jeA+lHlvuLNx/8uZTnLnURzQMuosSiy9K3VGL0Z1dpfe4Q6NlzBmlME4AYZOCCrm11qtdMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0RL2eoUX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0RL2eoUX"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f27dd44f86so73664587b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Mar 2025 21:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741064688; x=1741669488; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tzAqyNBDcatrD/dNYr5THRvvcwinanMOXL+SW4MgEks=;
        b=0RL2eoUX7RIfqZXCSjM5SQhU/z4TknpBx6tfJnMTpIjku5f9aHfQIGDExbZKHZSzQH
         zuNtG8qkuxoM+tLl+A5zLimPhqq74v4XiBT9AFpPR//UQkAnMcUL3W8x6FkJkVZWUYez
         rJu1rucnNPFRjJPZ6nc8XaINgE7XOCp0abzB0wNYqG47Rs03cNW34m9TzjXbmlze1cSv
         EysktXmM3R3eALOHxbj5WkaEBpsGKfK+IO+Tv+WZ0cjR+ZdFszFHxgnsNIlZNiJVr3Up
         qHRo7bMI4+xCFSZKIcGX0qgOKdBvIwrXSm5Dvynm19ifKhLjGYtBBcn81kh6upR/Ey7e
         976Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741064688; x=1741669488;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzAqyNBDcatrD/dNYr5THRvvcwinanMOXL+SW4MgEks=;
        b=eoKN7IcfiTYmh6acAyD4s2gad8NJvcM3G8QgYgislDKpeiwb+wsHARJf2u57TGFkB2
         iTNENspRNDsjVoJJ2UYtN0tcZFFIpFzgUgLnqKK/cbRB9jnGHvSXt8Kz+9+FUQ+vgW2Q
         u5tH+5RPi6ipd+6ShiNwXt5/b6p13AmwZlFew04+kE5Zil05r5Dujcv3GRhsRBtZ+eVQ
         1er/LDaeGBGAuVc2Y7FOc8CIDxC9Z9KeohXmgiFAe6B43bHkr6bLGqvjewTvvZVlLsPh
         jDghCGFyOsig33zBKIe1503rU5nCgdUuhAqhm5YKz8GQ7i5tbPNRSA2/Ogq4uHfQ09Z/
         sd9A==
X-Forwarded-Encrypted: i=1; AJvYcCWm0oknAIQ+X8hNKEw11N5820e4FBX05lLxqA5UCh6zDDi6uJVi6F3KwjlDjNSCz/n/3YrbYnysSmb5i2PbcdwP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4xAVKVxdK/PY6TyaRvOHvTKe7r0aJFVeiyZlsLstbXauwLRi7
	ZIYfr3qGvRTj+mwPRk7vlC/acLeEU9/uqDBfIcw9Ch5n3jOo8z/pgm9GxLqpZlDmLbYn7y2xAsh
	Kd45W1w==
X-Google-Smtp-Source: AGHT+IGcXI4xtcRg7TZCt539wnaKT0i5MXbKrcmjSAdt+8/cOoexhcuHk6pVgzO15AtSpOO1xbrgGJNcQRci
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8af9:d1f7:bca9:da2])
 (user=irogers job=sendgmr) by 2002:a05:690c:2a81:b0:6f9:ad6e:5945 with SMTP
 id 00721157ae682-6fd49e2336dmr19606227b3.0.1741064687649; Mon, 03 Mar 2025
 21:04:47 -0800 (PST)
Date: Mon,  3 Mar 2025 21:03:05 -0800
In-Reply-To: <20250304050305.901167-1-irogers@google.com>
Message-Id: <20250304050305.901167-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304050305.901167-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v4 11/11] perf syscalltbl: Mask off ABI type for MIPS system calls
From: Ian Rogers <irogers@google.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@rivosinc.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Arnd Bergmann described that MIPS system calls don't necessarily start
from 0 as an ABI prefix is applied:
https://lore.kernel.org/lkml/8ed7dfb2-1e4d-4aa4-a04b-0397a89365d1@app.fastmail.com/
When decoding the "id" (aka system call number) for MIPS ignore values
greater-than 1000.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/syscalltbl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index db0d2b81aed1..ace66e69c1bc 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -46,6 +46,14 @@ const char *syscalltbl__name(int e_machine, int id)
 {
 	const struct syscalltbl *table = find_table(e_machine);
 
+	if (e_machine == EM_MIPS && id > 1000) {
+		/*
+		 * MIPS may encode the N32/64/O32 type in the high part of
+		 * syscall number. Mask this off if present. See the values of
+		 * __NR_N32_Linux, __NR_64_Linux, __NR_O32_Linux and __NR_Linux.
+		 */
+		id = id % 1000;
+	}
 	if (table && id >= 0 && id < table->num_to_name_len)
 		return table->num_to_name[id];
 	return NULL;
-- 
2.48.1.711.g2feabab25a-goog

