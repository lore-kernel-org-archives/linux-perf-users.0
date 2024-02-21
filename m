Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8434639AFD
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Feb 2024 03:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708486932; cv=none; b=X0MiP8P6aWPTC6d+BRXLFYPi0Kx7rGO9VNWWdRfGE+ozr4W1cyZ/oBtVtLPnAZa/lRTCnFF57/5mRg/1W+KcVFEy4H0fytDoPcAzLnkEkYmlX0OVUEgemO4upvxaJ0cmjF7mkQIQqpcgmVZOVH9SobgVABws4fQJ7ybD8nBK/d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708486932; c=relaxed/simple;
	bh=9QHqj0EQvOX6+a6MNptism09KshtnOJS+VQ0pDYpZf8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OGoH5kyoRQmIqt4NeTT9JpJxTf4O1e3Szb4DrnNuz637LzCuFNxvKlrVXfHT0qdjZ0Q4Ap4/KGV+tJ0W36CH8151rlXXn5UOaMCN7KfRtgfGW9LlDvmb1wEw4uZNm8YgU8vBOZ0ko7A6ytSPgV32Hl0B4MOrFI4WHbpyAb2L4Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cz5q/b+E; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cz5q/b+E"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso9161639276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Feb 2024 19:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708486929; x=1709091729; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OwHudnCNl5wfpV2IMol1tp79ctLuVP/i5n4Lz8j3mXY=;
        b=cz5q/b+EfWRt2txHILY61V/gXJBUL2CSnvB009BhTjTdw0aWlisPpCaFRExuFxZ1uF
         Y3WlZN5mnjzsqRFTaNoGjelMHbxXk+4n7L7BvT7JRhEUYrdpSbjP7rERkiRlJBezQSTp
         XcHIOqPVFIR6HR9+Wudknqxh2oWHF0fUfqUCXIVCQK7Ql8dbeuopjnFCa2R52wevmNZO
         aq/+IaFdflieT2tcK/0j6Ui0b7DHwu78N8hGKTzTll8emsj9rD2uinslvX8g+CoTELyA
         2IXklu85A8AW3tqVTP9f+EXf+jHh4WlNSstn3f6Bpe4yS4ph436vFtCEvylHz56y65US
         S/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708486929; x=1709091729;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OwHudnCNl5wfpV2IMol1tp79ctLuVP/i5n4Lz8j3mXY=;
        b=KVlCChG/eogXE2rBrUhTA16/0dWTsGU8cAU3h0lcSpaCkCpps7rXV3K0pe1a/A5Ztn
         CmF7xYyD56RUMQvH8UWwFUOvUByxXiizhJX0sKUTT8qih5RjKOkVy/rXI774GbofIA5a
         I8WymP9rWR1BocPg6/oxkEEs4Br9QqS4hhZn8sRCk/YeYNf0PCrYd+OtTKG51e+6COjf
         M1aPIrey4mwJOn9ZloqPE2LjtJfYkmVV5in8FoGZvduaWKvwtrgwjQ4QhMUNFWko7fkI
         pR0ORar38oMoyCXzHfetiZsK14mHBoiGfgPo8nNbqhLHmfu7fS8QOhiyzhisFNhR/9qp
         SKQA==
X-Forwarded-Encrypted: i=1; AJvYcCVQcVrSSguMfWo+sAS4PMAp1frmHwc2m/u+wz0XtHl+K2lW0/k7UsxxFSgzDl4XifcsC/yPFH9OyBEHS/PQLb9O6PhdpxcaZBp+dsKoEq5YyQ==
X-Gm-Message-State: AOJu0YxzTKtEF3MF23CACWVgQC7eWmBygCoBcpkw7Pb0S3vdA3jaHrYB
	H7UrtxmONaCGnLchWknqTgSYGuaOd7pX2u28Ouj1HxnyYflT5IHg4o8zAnAD4AtUsmg842aQlSI
	lmn4cng==
X-Google-Smtp-Source: AGHT+IGpVA7if143B0lJXVmaSTTYwpcK6AvkiAGNahJ11h9vd94Ww2nCxr5eJbFyGeAX/DDo5vhoCpkHB36Q
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3c02:f882:5876:b7ab])
 (user=irogers job=sendgmr) by 2002:a25:a447:0:b0:dcc:41ad:fb3b with SMTP id
 f65-20020a25a447000000b00dcc41adfb3bmr602386ybi.10.1708486929422; Tue, 20 Feb
 2024 19:42:09 -0800 (PST)
Date: Tue, 20 Feb 2024 19:41:50 -0800
In-Reply-To: <20240221034155.1500118-1-irogers@google.com>
Message-Id: <20240221034155.1500118-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221034155.1500118-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v6 3/8] perf tests: Avoid fork in perf_has_symbol test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

perf test -vv Symbols is used to indentify symbols within the perf
binary. Add the -F flag so that the test command doesn't fork the test
before running. This removes a little overhead.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/perf_has_symbol.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/perf_has_symbol.sh b/tools/perf/tests/shell/lib/perf_has_symbol.sh
index 5d59c32ae3e7..561c93b75d77 100644
--- a/tools/perf/tests/shell/lib/perf_has_symbol.sh
+++ b/tools/perf/tests/shell/lib/perf_has_symbol.sh
@@ -3,7 +3,7 @@
 
 perf_has_symbol()
 {
-	if perf test -vv "Symbols" 2>&1 | grep "[[:space:]]$1$"; then
+	if perf test -vv -F "Symbols" 2>&1 | grep "[[:space:]]$1$"; then
 		echo "perf does have symbol '$1'"
 		return 0
 	fi
-- 
2.44.0.rc0.258.g7320e95886-goog

