Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FECA32FA17
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770324991; cv=none; b=Xa+ZYxBuMgGiBh/biKNBEyj9yLUiWq6CwARJfR8talAq4wyGhdLF9GQgJsqTdeoeWUTOSKDEvyBIDrVD1T+55v7Co9rToaOCtIoQghdDnEXzroiGCnbj15yOLIRlMgZrZo3dez7bQMUjNTm2hOppYtlk8utz7eczSOQ/oK/76M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770324991; c=relaxed/simple;
	bh=2HkTM0bwDV1tzLbS0lGnTyIQVCl7BVPJXtWRaIdThVs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RRwwvPJrF6HRTJAfa/BNkQFyG+3alQk43bBx9m34TysyfLvCf49LuK2BS42aqARK/R9IL24G2aS1wVU70jDDQADK5iUTy2d0rw3p1wXUZf82UaQDcKdAuDrss8FZdqzu0IrO61l7LKaBBjjIQyBpx3Vlw7W+DdcAZpJsFCwf7ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EMVIdS/6; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMVIdS/6"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b7ef896edcso10908966eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 12:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770324990; x=1770929790; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cv/xCo5dLRgb66wYduLIuNe1+gVL5H/6qCq4JS3yGHM=;
        b=EMVIdS/6ayMSet0upjciIFlfprLSmrdo5uenAGPHTmbbV+7E1ciG6/X1VJnnmjkItm
         BHBYYnCss1sSiF9b67RJiUBlY6JWCVS8BdlBSbWmf78uNFSIg0WafHoJKyjS3APULRsf
         DS+cSvNt5+QPkjX6nlPAwicBEDET0lL91O5twvWZ3aZqbir244l6xJhRl/R2vzEq5xgw
         nW67clQFwuC1KL86XBKVAb6rDH3A8h7ok11i1ahWvPjLfw3lzMBYble5ssS42cz7JYoB
         xaik3WjcMrhfrW9mUsLDI3+49td3ArMbb4ZlFuxrLYgbJOKt8RYRRdtjUnifq/SxDMnc
         Fh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770324990; x=1770929790;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cv/xCo5dLRgb66wYduLIuNe1+gVL5H/6qCq4JS3yGHM=;
        b=HLxWYPD1CWpqEinRe0KImu6svqnAEJkWCbIZvI72+lxLf7Wv+LipqxQ7yA+ClqIPzY
         2rDZj+Z7mkPYm/X5ccV1kFixOUmWs7nYm/xZ5v4xc5aw8QZg8iipeduND1UZISFKbXA8
         4FXbh9h9LCabE5iTOer9Km5pQK+5q4IDjQUBe2ABSuIpdN5CtE51Ade61oXEXvHpF1vl
         QxPfNIcuociQkP9ep8pjd9Mn9t2LKI0gl6u8f6V9FIppa/hG6ldDSKAdhFVEFUb/7/kr
         m+rTpVwQ3uF80askUF7dRIK9667Cui3et1+Sxnr94OXAdKNFxvXl2Rks2K1ISLjEm/z/
         0kBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ1jxd0AT+VlKGRO0ewgEgJ41m6cSSoL5djz1bNjJl0zoFTz2/whr4FndK/Ki7YyEjJRZH3x2T/0jSfpIwdzSQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyRXyA5rHlv9KOd42NeYXicS6PlCxdtvhwqvHScKHo4q8+NP8wI
	l+5WSmO1EPHq5GPipiWw9qg8JvLk9zp+ELSguoop/XMBYg8RG06G/3DBvxiCrrU2JJzHlWyPw9q
	XCQN0miy95A==
X-Received: from dyjk30.prod.google.com ([2002:a05:7300:271e:b0:2af:dc89:507f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ad06:b0:2b7:2bf3:ce05
 with SMTP id 5a478bee46e88-2b8564cd63fmr189980eec.28.1770324990205; Thu, 05
 Feb 2026 12:56:30 -0800 (PST)
Date: Thu,  5 Feb 2026 12:56:22 -0800
In-Reply-To: <20260205205622.530825-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205205622.530825-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260205205622.530825-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf test addr2line_inlines: Ensure inline information
 shows on LBR leaves
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Expand the addr2line inline function testing to also run for an LBR
callchain, skipping if LBR support isn't present.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/addr2line_inlines.sh | 28 +++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/tests/shell/addr2line_inlines.sh b/tools/perf/tests/shell/addr2line_inlines.sh
index ce30d9c7e0bf..e8754ef2d7f2 100755
--- a/tools/perf/tests/shell/addr2line_inlines.sh
+++ b/tools/perf/tests/shell/addr2line_inlines.sh
@@ -61,8 +61,36 @@ test_dwarf() {
     fi
 }
 
+test_lbr() {
+    echo "Inline unwinding LBR verification test"
+    if [ ! -f /sys/bus/event_source/devices/cpu/caps/branches ] &&
+       [ ! -f /sys/bus/event_source/devices/cpu_core/caps/branches ]
+    then
+        echo "Skip: only x86 CPUs support LBR"
+        return
+    fi
+
+    # Record data. Currently only dwarf callchains support inlined functions.
+    perf record --call-graph lbr -e cycles:u -o "${perf_data}" -- perf test -w inlineloop 1
+
+    # Check output with inline (default) and srcline
+    perf script -i "${perf_data}" --fields +srcline > "${perf_script_txt}"
+
+    # Expect the leaf and middle functions to occur on lines in the 20s, with
+    # the non-inlined parent function on a line in the 30s.
+    if grep -q "inlineloop.c:2. (inlined)" "${perf_script_txt}" &&
+       grep -q "inlineloop.c:3.$" "${perf_script_txt}"
+    then
+        echo "Inline unwinding lbr verification test [Success]"
+    else
+        echo "Inline unwinding lbr verification test [Failed missing inlined functions]"
+        err=1
+    fi
+}
+
 test_fp
 test_dwarf
+test_lbr
 
 cleanup
 exit $err
-- 
2.53.0.rc2.204.g2597b5adb4-goog

