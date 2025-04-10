Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFB128C5DA
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306609; cv=none; b=In0GOqngM2QTxuabDUCd5f4Ccwe/ns4TN4VvTa9MXrRn7vVHIunee+sc3/ihgeZJ5ZdCBaFSuvVIMBOwijRmfSWYmUhp6QflKvceU55Dkb1LuP/klibcg0+8hrmhSnvknQ9sIXShKz/aK0J2NOamQdQlHfyfR9yxjaQCsRQFWd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306609; c=relaxed/simple;
	bh=rjDVXA1e48wiJP09H+3ttLssvR00WBTP8TaXhYipl0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=sGi25EDmHq0EtPrLQCUecIOSFeDVsxe4AFxxvAm7fHFKToHiJu7e2MOeWkbH10/3jow3RZOZND9P8jQW1JqLSVw46oH52bXqAvA8vJ2E/pPztoFIwd7WKs17qTOVM1y5Yh0NqUp1WesDxt1zLK/tkEz5OWYMxgu+mxOY4Zjht10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NAKOTTIp; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NAKOTTIp"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-3fbd6d944bbso828088b6e.3
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 10:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744306606; x=1744911406; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8v+NZetBaqzwnjvAKJtemj1czEgvtWJ39sNPAoy10bc=;
        b=NAKOTTIpT9QtglPYg6rdkzI4CGwVcrjBVtOV+gnssPJGFqCu5W7hhUuEYw2qhJQjl0
         5J9yzpOePjizoDnjgZsAqvtores2uXbMQ2B9jhnxeIVFYUPecyrZu0plRn8UW0BLFm3P
         D52aeUTojCVKsxhqNHhBRzyS6rHo5UNDXdKsUqCbCPWM1yIGyAfwhiIUoZdpjYmnSrfj
         KTRXvQsgbxT1LZVstLu4iWJ7XJYWrCirUneULhReHQjrPwktcOaaR2dlhFVEutgNfDN+
         wuxk5+5OwrOPcLiCMNBmGXa/i3cgCj5HfNzOiMhjczILcFok/D9XDidGTBtYdhutNnYR
         kW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306606; x=1744911406;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8v+NZetBaqzwnjvAKJtemj1czEgvtWJ39sNPAoy10bc=;
        b=FxlNO/5YabK5IMBLkZJ5y1onYfOWO628OKzNsv1jn9VeACCBTNSxQjLytImCBH+nou
         Z533yc9c5ryjIF1cSVNPkpToHS7nO/L3z+ZHkDgWr9CYvtOGX1Muchl2QNSAHctwybC5
         PkO4hgIKFegHXASrDGKCiLKKbMxl14+clcqZcrrh0DdzN0bekTgEWuWUgqv7F9pwVqDz
         0S1U8OLy0NzSne/1/9Gq8aHGqzQrlHr/grYdrVNIUy6+2chhTalxZ2tQDh1UvPz26NlD
         hcHeEy1VP2KkbATcQ9ecftwhnn5+7TGVMYdduFDTm8Qd2wz1a/NGnA8B/7AL6ftmYFGY
         BWMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTM3Jv0AjtUdnDiNFq7Rjc3shj1M8RsbRcHLTet/ArH93CzDg27s0igYSoQ73pR1ZZgeIKkhvSmktCZ9AD7O+J@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9FiA/jWNRKPDj1crsyQ+Jevhk5H9rotjcgWMFqFTFwtrydchI
	lwsImV9hIU36mOYyRlEm1z6UJW4Gu/KGv5pYTlZtekrraQChscgguIRGYZsZmB1Y9VlMZmdBNFh
	hRyyBkw==
X-Google-Smtp-Source: AGHT+IEwb9NbM9CUIgMKI0aGctFt6E85eoY4vwStAAMOKPWtdzhdBRq2bl9/AqJTGoTmUxudC+3nKm0UQUw6
X-Received: from oabwo9.prod.google.com ([2002:a05:6871:a989:b0:29f:d208:6db])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:6f14:b0:29e:53cc:a6c1
 with SMTP id 586e51a60fabf-2d0b3593597mr2371126fac.6.1744306606709; Thu, 10
 Apr 2025 10:36:46 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:36:20 -0700
In-Reply-To: <20250410173631.1713627-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410173631.1713627-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250410173631.1713627-2-irogers@google.com>
Subject: [PATCH v2 01/12] perf tests record: Cleanup improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove the script output file. Add a trap debug message. Minor style
consistency changes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index ba8d873d3ca7..05d91a663fda 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -34,13 +34,15 @@ default_fd_limit=$(ulimit -Sn)
 min_fd_limit=$(($(getconf _NPROCESSORS_ONLN) * 16))
 
 cleanup() {
-  rm -rf "${perfdata}"
-  rm -rf "${perfdata}".old
+  rm -f "${perfdata}"
+  rm -f "${perfdata}".old
+  rm -f "${script_output}"
 
   trap - EXIT TERM INT
 }
 
 trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
   cleanup
   exit 1
 }
@@ -239,7 +241,7 @@ test_leader_sampling() {
     return
   fi
   index=0
-  perf script -i "${perfdata}" > $script_output
+  perf script -i "${perfdata}" > "${script_output}"
   while IFS= read -r line
   do
     # Check if the two instruction counts are equal in each record
@@ -252,7 +254,7 @@ test_leader_sampling() {
     fi
     index=$(($index+1))
     prev_cycles=$cycles
-  done < $script_output
+  done < "${script_output}"
   echo "Basic leader sampling test [Success]"
 }
 
-- 
2.49.0.604.gff1f9ca942-goog

