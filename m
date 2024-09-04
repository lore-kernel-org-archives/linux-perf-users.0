Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB284A31
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 05:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426376; cv=none; b=BhinMZGxUqgl10y8pCczWn8nloqqxSzgq19MXKH7Bd4qyE80H+CKAFlXpZAU2IhARmN0Ud1Y1fX4yhei59Pp+dlOGCNbcFNtAA/BOcE0MyTXqsm51knoEW6/FWqdjIXMT3BepceYQ8uPPOVr8L+6oodpdh/SiIFpi0isxwq6HHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426376; c=relaxed/simple;
	bh=QDLVJmTj2vf/hVHdQ6L7zR2dfVNf7BD0kyHNVViDvMk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VTqQ0H651Mb4wdsArUEfutB1AEMSl9wpNqZderwzXWlLPZTr+FcJW0jNeQ/wxVI2JHFAi53th1n0WTFdUh1J3hqROOVuKHU3cB9TTi+izmSLXu1xdH6FIhb7rDI960Vu2YfWpCh0idAyrSYgnuJbGgbUA17rLsi1LsZVikg++Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fG7tgEP8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fG7tgEP8"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1aa7ef2c65so5698911276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Sep 2024 22:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725426374; x=1726031174; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xXQyzsuqXOgxY2EbjHgMehvTpafBAnrj6hlvtmn8jRc=;
        b=fG7tgEP8zk2s2hOhzFJ3ETSSeWLHhMGhHWJ/yE0zHlGOIN+yF2mlJV/bBM/mI899C0
         jtR3T6M3iATmjOdcXIxJqLbvhI4vqeh9BIrge42hWydufpH5IVtWiObBmoiOf6e27u/A
         au289wU9qzRS3zJgkNXF3AnToBCBRBY5eEFtqx5xDT1okIdNaflWhYmhL4zR6ftjQW/o
         UIyKtMLDQ5vTpD143LGvEFgx8Fht+DCbFa/o8JmSyY/UVP4a83brDvFcRdhuKdnvNLgP
         RBTI75xC54cvlBbRPNl6l+h59nERhiry1vm9U68E+BLj0UCC4Nryj+LKWJ6Wlm2LdPAq
         H0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725426374; x=1726031174;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXQyzsuqXOgxY2EbjHgMehvTpafBAnrj6hlvtmn8jRc=;
        b=uvb8mUxOd68Vn8Ciua3lfmHwJdcwSoNA79kgV897YqF1fy0+cSBfdsp7mnUn4EQ2m5
         jCQjPyQGQn4kGaRBYKX/X+SQYKY8FzCuUrUM8ewNjp2MYx9L2N/hWYZtQrNwlUFhOu+2
         Tb8GcR/Ff+EqJnIPx88J717AX1gYKQwYT3zwyrDLLvrbHHqU9KLeLtcvtAStX164ykVG
         WeY0vdC15agQUP8oSruX8BM50ir5Qpc8ZMvVEZOIZFf0bmMrZvN0Vkk7jEJnlfqq0qtb
         rUiyroYkT3TxtQbBg/4WiuuqW1Y5djJ24mCpHZ3r9wXIJ97GwVMgbUUdvgsvC28itB63
         JtdA==
X-Forwarded-Encrypted: i=1; AJvYcCVfU2wCAriHtpedXE2IbNhgCrNm42JB8mf9wk1h/hnZfUlrFLMfxLyEXcPuDe9CHgPMDJnwQDb2xmgh3hO24AGP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+WTX+x/rEenGsY2b8258Ig2YTda4vh/sEhTKt5o9tzM0bOzhc
	vKebqKdIxH9aWfEqtuuly9Nni7rC7QjT3zV6aoXNqs6/qP0VvijTuwufc9cmg+EApPhxS+6wo9s
	UDeTbkg==
X-Google-Smtp-Source: AGHT+IEufI/N1mCq2pXCk9tatBaD5j0lP+BTxKNNxjNtHgIe6K4bmin79t/VcpfJ4jPssaMitYjpzzgqmNbl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c48b:5e3:a63c:2d09])
 (user=irogers job=sendgmr) by 2002:a25:ba87:0:b0:e17:8e73:866c with SMTP id
 3f1490d57ef6-e1a7a1c734bmr532973276.10.1725426374390; Tue, 03 Sep 2024
 22:06:14 -0700 (PDT)
Date: Tue,  3 Sep 2024 22:06:02 -0700
In-Reply-To: <20240904050606.752788-1-irogers@google.com>
Message-Id: <20240904050606.752788-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904050606.752788-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v2 2/6] perf time-utils: Fix 32-bit nsec parsing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The "time utils" test fails in 32-bit builds:
```
...
parse_nsec_time("18446744073.709551615")
Failed. ptime 4294967295709551615 expected 18446744073709551615
...
```

Switch strtoul to strtoull as an unsigned long in 32-bit build isn't
64-bits.

Fixes: c284d669a20d ("perf tools: Move parse_nsec_time to time-utils.c")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/time-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 302443921681..1b91ccd4d523 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -20,7 +20,7 @@ int parse_nsec_time(const char *str, u64 *ptime)
 	u64 time_sec, time_nsec;
 	char *end;
 
-	time_sec = strtoul(str, &end, 10);
+	time_sec = strtoull(str, &end, 10);
 	if (*end != '.' && *end != '\0')
 		return -1;
 
@@ -38,7 +38,7 @@ int parse_nsec_time(const char *str, u64 *ptime)
 		for (i = strlen(nsec_buf); i < 9; i++)
 			nsec_buf[i] = '0';
 
-		time_nsec = strtoul(nsec_buf, &end, 10);
+		time_nsec = strtoull(nsec_buf, &end, 10);
 		if (*end != '\0')
 			return -1;
 	} else
-- 
2.46.0.469.g59c65b2a67-goog

