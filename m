Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13A616FF44;
	Sun, 18 May 2025 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747595404; cv=none; b=KYYlaTljS+pRlqxkJ5EXSxUZqox5bR5TEbhv2I5ItZV6s0EWK7C2XSuBmLAILGnO3NtAevSOxuME/x1OEq7tta0dq5Az6Qq50zM5Gb2qEIDttPQzwgHJuO84tQv8zh8OA6UtXD9a+YaOXEjnVHEgGgNSRpi6dO0hU/eGNjavDBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747595404; c=relaxed/simple;
	bh=8TFIlL+9Nqb7USj2bx1x7nSvC+emH7rIhEN9SdoxRiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijTJ4LFxPPtxriTplmC+uwiOcnOweNaKMHNc0AOSvMww5MYLZQPeSh+lgQWJg44oNWKM0t7Z3BBW7W/hpaqvqNn/PrZRbu67BbeV7O8CWS8/7bHEHUSOKLtu+RVIhGK8p+sj3oK3ZL7sqHhqWi9QU8AaQhyCL21waYBlFv8RyI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhA+1lK+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhA+1lK+"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2302d90c7f7so47714055ad.3;
        Sun, 18 May 2025 12:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747595402; x=1748200202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ujzt0Z1mlstm8/GkFppvnEuth0oQ41DBzEMpZiCaoQ=;
        b=NhA+1lK+VoHVh7KKez4Lb4nI+aRwdehHDf1+kamc8w2xWJXZnwrOYrvULZK0yHJci2
         uXspu5DaKAfTKSn3KzaSQhjZ/4nkaj+3ejjYTTONAKB+CfgcAwDnoafUEp95VdPYKpCj
         pyhmWGVS2QjXkcerBe4jdWjBrJoMM9C+F+pfl4f9DxA5AhTl8nOf0+GsEPJE2/RyKhLV
         mbMQ5MOlXc14PpoGzgf4uc2EA1JSQ82qYVFQXfgAUmPzvvf7pZW4kSBnE9o3gpJu/c4f
         2gmLIDO6gbNOe6zP3Sv/GMY5R+HOvl1NG5ICUdd4nOfmjrQM5LJUy0zNI1mXVDPIUZbl
         ap+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747595402; x=1748200202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ujzt0Z1mlstm8/GkFppvnEuth0oQ41DBzEMpZiCaoQ=;
        b=JknxJ47F14FT9oyNR/tdxqPUvW0lqnQMtB2UO+HxdZp+QpILhNBo9bCAve+Dvh6bUa
         mRjhV1XJRSOHSM+hfDt7knbCob/wmvQAt4Xlb4icuhpsTWnpMITcKxTwlGv3M3lnwyQG
         axYKNmD/UjrNIUxGePzTvi2x9pNSLXGiWwtZHRwES/GsjBF2tH/1tDgotgCGWWDY64m7
         /vVKt6E9qzTCoEbuA0PM9mz+HY9FqHIHuL2CcXqhrqcBUHDxuHZeC7bfw1TrPnwcytzF
         xokmj9Iho97i1DWFeBkXchFtHOknDLtP+IzWI5WSV9tWc8lRphFuHWhTjagZAl20F3Ul
         EE5A==
X-Forwarded-Encrypted: i=1; AJvYcCUclXTdMLo2AXLc9KhtjgzWAPFbwBaVL17m69NtXGOkGFCGxXFtJYlOweYHMKP8dsum0xleH29RSrpsV5A=@vger.kernel.org, AJvYcCWZlcS6HdCopjpzUX1X/77qHl3FNaA4srpKpJjYCz2yXzFXqlkPBZHBIjg4CBYtCMPi6IUS1IrV6duZ/8kW+M+Bsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNPy5pI+f6F5gl8esOJX0fPQ6TpL5JgDQpLrW3t8PIizKvv3qO
	3mMSjj7/WIYIAz3hp1OlJPWkgj3CZrZNvvSvFAoWYPFQcqmS+gKmiP2b
X-Gm-Gg: ASbGncskfWrHpnrNbCbw9t+FvKYLmE5x1WTleUl1Ln40QEawVvu1BQ0G2RTqRxSXTZn
	EUonv1AwWw3wGWvSDZU+6VgK2xTlOjTM6y2hXfSxV0MmniejFVNjL6L5KHdPtvD6gXWz6qsE15q
	Eigx9xLgF6vqn4Dgar9DzYaPT6kWDyrIsFadUEPaFETzHKfm8eaNBUOnF+PDwUXHsfO2zOY5qKC
	sJtiecKpIC/wPrcDOjYt8FnneVKlzQGXIFaw/wvaBUG2VXsnfi2nNq1z/l59/NZGkZyItjLkGuC
	sYn5PwTqwrruNTfoPwPfnzW9GGSRrXQLdBu9T2XNHco5dD8TPrgYHYq6hJXlz42Pc7oUkjGOHlo
	doyG7AUEa7Qc4UG88P6xaO2f53Wab9mo=
X-Google-Smtp-Source: AGHT+IHn3gpN7eO0RbqSUsuf3uyvSj2hHfe+JZJwLdbfEmAmLCno1DtUKlaV3l64I9H6FuMJA01j9g==
X-Received: by 2002:a17:903:2f43:b0:22e:3c2:d477 with SMTP id d9443c01a7336-231d43bdf52mr159364385ad.25.1747595402064;
        Sun, 18 May 2025 12:10:02 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adafedsm46022135ad.56.2025.05.18.12.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 12:10:01 -0700 (PDT)
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
Subject: [PATCH v2 1/5] perf test trace: Use shell's -f flag to check if vmlinux exists
Date: Sun, 18 May 2025 12:09:53 -0700
Message-ID: <20250518190957.58932-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250518190957.58932-1-howardchu95@gmail.com>
References: <20250518190957.58932-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To match the style of the existing codebase, no functional changes
were applied.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/shell/trace_btf_enum.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
index f0b49f7fb57d..b3775209a0b1 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -17,7 +17,7 @@ skip_if_no_perf_trace || exit 2
 
 check_vmlinux() {
   echo "Checking if vmlinux exists"
-  if ! ls /sys/kernel/btf/vmlinux 1>/dev/null 2>&1
+  if [ ! -f /sys/kernel/btf/vmlinux ]
   then
     echo "trace+enum test [Skipped missing vmlinux BTF support]"
     err=2
-- 
2.45.2

