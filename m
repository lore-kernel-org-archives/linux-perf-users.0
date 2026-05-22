Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13D233EB1A
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489251; cv=none; b=LmEvbsD1SmEC9AinV5L+CTSoKbtHbM13AZhyY5g580TMu2jTHhkwVrnTa4KdBD8OzoqEXpSpZc1BCChjiIwEGDzMGDuT3/r5PlGXfPmD/vbYvC6S5eWAr8z7X9YwdIxV2M0NgNh8v1SsS8L5MPxNKB7rw+xXKQV2Mg1tAB8b+GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489251; c=relaxed/simple;
	bh=mMukkELF64vPLpVVMICsa3x2PclcZaqcw9gihFqiBKg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=W6Qi2F4wguvMuxxmWdl94aN8iNPVPTizK8a4aQ7fZqVlyTlxPbD5mVHhJNdlNGgYzQIiF/lCgaStvL2yHC0Mt7FHRSrGIWvsQEH52dNJ+6bvvdPFjHs004mTgOfx+z/pkH+HAh8MIvmvzECr18mpV3OI05ADs9zZyyhUPcajcb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G/SjEtVh; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/SjEtVh"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-132d631edaaso46041774c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779489249; x=1780094049; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PbZge+S6GxcXFo7SrT3BdTOqtxic4O2pzIUUOXH6H6k=;
        b=G/SjEtVhG3+WIZs9HsOGURl9Jz7AlpmtIJiY/kgqlLDHtiuAsb3M6tbwMP7Ajls1RW
         7AmwGl80yka072XN+JCK0y7dDohRArmUrJpWowEHsVWNQrUqLaYFVA0UWUxJe+Snfpvr
         X8dUcfVlDBFgTLWjm0wHqy3XXDhTa8r94QB4n4Sgk7tLoxcIyTbr9VG01lCg8IcQ12Rw
         IeNGngeGYbBjsAFdGWOHXq2dWGJC6/fayaYxRM4BZDPdBII1DUaG9HN3+GwGlwTFiSMe
         RP9mJQbmXrzTs7JKTcCKTs09r+kdwc1g1qqExcxEa3v9UWiiqzDoqggWqxFUzGBR6zIV
         NFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779489249; x=1780094049;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbZge+S6GxcXFo7SrT3BdTOqtxic4O2pzIUUOXH6H6k=;
        b=Cn8yTCHdEgvrGqaS+thIXpa2aXdA2ygOYMnlP9A/jef3I35fTJswt7cpboFuqmmYVZ
         mkfAc3u7AtTQ+NlLa63oCF+r8BuPAd4D6hkuH6JNYC7hpgAN2pOZrOgaeo9hKq0tNrYg
         0Uf0EpYwFNBC2mpA9zNkBq9NpFldn8iHaO5IcALILj7a5wL8mTGtFsIZb+BniL3hgfdB
         tVXZM9+detiX419mSnTKD8YWdKT2Uz616TIJH43XbuL0ZGD1rEFSdPGB78nrJyICcilP
         5sZtMkqfXhdb6Io0DT+yGk0DL1b6//3rOcGo/1a7OAOk+0NP69kfBiygmTrsiMDCto7Q
         sRSQ==
X-Forwarded-Encrypted: i=1; AFNElJ8BG1OM+f93HWwdaOKvb851dRLAw0Pvymlui2hpspVM4tFyqDsJvSqQ37gV6sq0/NBJ6Tg0nt2RlipLsNKARkkl@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1VJaF4ZVKos1eN1yNKIS4LFFIKN47/4fGujAH+GZqRo7wRjPy
	Gl8rDP4w3+WTlgRitFaxGe4ZABy9qh3XmDie2E+AqvvGlwFbvyO9QQ/KeyT/KIDCiOylMpYIvDX
	Qs6XE9GNi/A==
X-Received: from dlb38.prod.google.com ([2002:a05:7022:626:b0:134:a774:d28e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6727:b0:134:a701:de8
 with SMTP id a92af1059eb24-1365f810954mr2223740c88.5.1779489248683; Fri, 22
 May 2026 15:34:08 -0700 (PDT)
Date: Fri, 22 May 2026 15:33:31 -0700
In-Reply-To: <20260522223342.2393553-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522223342.2393553-4-irogers@google.com>
Subject: [RFC PATCH v1 03/14] perf stat: Extend STD output linter to test
 basic New API checks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch extends the standard console (STD) output linter script
tools/perf/tests/shell/stat+std_output.sh to run the basic no-argument
check a second time using the --new print flag:

  perf_cmd="--new -o ${stat_output}"
  check_no_args "STD (New API)" "$perf_cmd"

This ensures that standard console outputs produced by the decoupled
printing callbacks are formally validated by the test suite.

Signed-off-by: Ian Rogers <irogers@google.com>

TAG=agy
CONV=7c33d6a0-70a2-454a-82f7-4de2101a5b9c
---
 tools/perf/tests/shell/stat+std_output.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 9c4b92ecf448..233e0a50eb33 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -118,5 +118,9 @@ then
 else
 	echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, per_die and per_socket since socket id exposed via topology is invalid"
 fi
+# New API basic checks
+perf_cmd="--new -o ${stat_output}"
+check_no_args "STD (New API)" "$perf_cmd"
+
 cleanup
 exit 0
-- 
2.54.0.794.g4f17f83d09-goog

