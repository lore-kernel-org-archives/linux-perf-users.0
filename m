Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EED21CC52;
	Wed, 28 May 2025 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748459522; cv=none; b=VP9YgBscQ1A2qxMRGo4/zhj7U0BUcNc6ph72oH2iXDW2iHXAok95+qtdJeXMSd1j/a8TTYatXy7tgfbNxRs/9nVqN5KmnYkmDbhKa/4/8WixOxqmvNjkK1K940AgY80gskT1sGWMWEoXtZQgvGXxQ8+yRQhuY7if9bFC/bKQxNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748459522; c=relaxed/simple;
	bh=cX550pISPQDK1DwgJ7QJM3dehdOu55JaKjaF8ro+544=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBcgMidryUWTQRTeMTN2Y0cjMA8PfrkzzBpoQrhc4WIIjPOxMNIFlqCPkvrAgRKhxFGbNSuOmOXiUFeZ8OXodclHX4tQv9oRqGP2oh6Z5vh9sat4vkMVPJWlD6Er1AcP7gGwhZt0HqYTrgjc1EdgErDA3NjsiBl4HK25hLNARMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+Kk4P/1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+Kk4P/1"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2346765d5b0so2271855ad.2;
        Wed, 28 May 2025 12:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748459520; x=1749064320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWQbsbybo0AYiSDWMY4Ls7SImui0r/N9voyPkWzUhz8=;
        b=h+Kk4P/1kts58UpcDlhY+nUD1Ug1M0wsIOzrE4jYQhsXA94yE9AntJrxjgGbJpTpps
         gLEBo8qhrqrtA3mjVX0qcHlyxhibvY5JH/WicBRtiruDjFqv/ihX0Vj40fWYmgIFu7+Y
         ojkHhGxF0M9DAZqoeFIXcLrgX6TQrNG8jFW7IRe97kXLL7H9AgzpW/umoDCT7hLNy5Dk
         smq+ABHrmVSOOb9OlYDH8b90qsGWGg4iIRHPTJE4aoxHSMrNrcEpPPRbblZr74b8L+cx
         SccomBdxLhsmlZwDwNuCGzCI1eVx8G8I+LKd0yoxYC7VhGHZDc6SKcb59j56/tDGaGHb
         XGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748459520; x=1749064320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWQbsbybo0AYiSDWMY4Ls7SImui0r/N9voyPkWzUhz8=;
        b=sok5zzOrSDhDClvUJnNDtDoQ3uhQl4ZVKBSTXpVv3HfLWXESm8iwZ+vWDF/RFxRrw1
         lz+JGNO/v1jRcE3EYZ1Mkp3AftWkRukoNWr9RNiklhf4dvOV+btwwsrygUi4ub6xwZmB
         uWkxHj8HKXZ2RkYob49JEDpwRhHvN+W3BB5GrWZN8imXqPO0fB4nTFyWVsgl9jOS5B3E
         I/5QC8E54trC6KGK0jYup6dpmorKztyaexw2UlxGsRVzUM75uUj1ydRPMgTnt1sjKkC6
         IhVaYjINXxz1J22NQhnsMmQOAnksCLkzyHhfdIp15fh8oXgkqKDFmEA4YiR1gGSVo1AT
         CWNw==
X-Forwarded-Encrypted: i=1; AJvYcCVxM+GsKlXj4qxSHfCOlvz5M6wNr/NB/sDvl9kL2M0Zwn8t/1f9lHiaS9aSIBOoZz5epvjsuQbKSwnCZP03RqpUIQ==@vger.kernel.org, AJvYcCWSZjpKFfcbVA6HGJ2WrmhCHUBulA1FtnGvR7NbNyBAtovCoEH+fyC1TrI5al89G9CVLoBEab2AqK/9zVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjI/Z0CYfAv74pQAT12xQLmkJww3o4RtrwfXYFKpBgNN5mhlEH
	gvYxh4r4Ck8bZgoL1Fhj/PCG2EYtP6df2kh859HBd2WNozcV8ewmNmzR
X-Gm-Gg: ASbGncsvvkAWouB3zeqGWuRiq81Ox+E/Dnst7cVVFVnfIb6vM83N3g/X3VFqC0k/tGM
	mYEin631mlY90QtwDUa5o0ldC0zk0fclxmHWYp7+aA+KKm3pvSigUUon290gTXXDofQpbuj5Knv
	rMAIyfc/UEyS+0OSHOW56H5VEiF8QV7DjzGeRMc2vTAqMkXVqzo600gWl2VnX4Ch/IeVVYiqOTs
	LlQeoMGMrjT9nYrMSrQsicNrL+nzywIybrnLnv0DljIc7Nk1q32yJdjGDm3xCc+UNvARKWZ6iNB
	rrA9S7PDfsJQV6EnCMnPPqbM4O3SvKYez9OPgzpPVtskTYWkK5VZEU7Ct0ciAQVhK+t547rw5Rv
	oly8Youn30+xHDOymkyxC2g==
X-Google-Smtp-Source: AGHT+IHYU4oZ9mQEkI4vOkU02K4lNP3QUSc8U901XQ2xdQK+jwkgCE2BGiA6OmUv8eYKqS7wKIt5KQ==
X-Received: by 2002:a17:903:1a30:b0:223:fabd:4f99 with SMTP id d9443c01a7336-23414f334a2mr273797535ad.5.1748459520065;
        Wed, 28 May 2025 12:12:00 -0700 (PDT)
Received: from howard.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm15172215ad.169.2025.05.28.12.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 12:11:59 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v3 6/6] perf test trace BTF: Change the regex pattern in the struct test
Date: Wed, 28 May 2025 12:11:48 -0700
Message-ID: <20250528191148.89118-7-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250528191148.89118-1-howardchu95@gmail.com>
References: <20250528191148.89118-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ian mentioned a reliably occurred failure in the trace_btf_general test
where he obtained trace output of:
    sleep/279619 clock_nanosleep(0, 0, {1,1,}, 0x7ffcd47b6450) = 0

But the regex pattern used for verification is
    "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,\}, ..."

This lead to a mismatch.

The reason is, different sleep commands use different timespec data to
call clock_nanosleep, on my machine, the value of tv_nsec is 0.
~~~
$ sudo /tmp/perf/perf trace -e clock_nanosleep -- sleep 1
     0.000 (1000.196 ms): sleep/54261 clock_nanosleep(rqtp: { .tv_sec:
1, .tv_nsec: 0 }, rmtp: 0x7ffe13529550) = 0
~~~

While Ian had this trace log:
~~~
$ sudo /tmp/perf/perf trace -e clock_nanosleep -- sleep 1
    0.000 (1000.208 ms): sleep/1710732 clock_nanosleep(rqtp: {
.tv_sec: 1, .tv_nsec: 1 }, rmtp: 0x7ffc091f4090) = 0
~~~

Because sleep's behavior of setting 'tv_nsec' is not certain, and tv_sec
is most definitely 1, this patch relaxes the key regex pattern to
'\{1,.*\}' for a better chance of matching.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Reported-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/trace_btf_general.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
index 30cd3a53f868..ef2da806be6b 100755
--- a/tools/perf/tests/shell/trace_btf_general.sh
+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -49,7 +49,7 @@ trace_test_buffer() {
 trace_test_struct_btf() {
   echo "Testing perf trace's struct augmentation"
   output="$(perf trace --sort-events -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1)"
-  if ! echo "$output" | grep -q -E "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,\}, 0x[0-9a-f]+\) += +[0-9]+$"
+  if ! echo "$output" | grep -q -E "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,.*\}, 0x[0-9a-f]+\) += +[0-9]+$"
   then
 	printf "BTF struct augmentation test failed, output:\n$output\n"
     err=1
-- 
2.45.2

