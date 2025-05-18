Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C99A1EB5DA;
	Sun, 18 May 2025 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747595409; cv=none; b=VaqM2Rhmq5/0a5CBFaKeibM7JIqZGqpfRA+H3ZGz3mphR24/2NV4R4Is3InSrSAa9fxoLC7uiOIBMUa/hIRKxKd/jjpNnQ3xRaiRjvhhen17wiLVJ8re4Yzfrj2CGCraO4c6kRFicYhW+9ZNj7eUe4oFtPvDIxXZE9ZZT7pCPwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747595409; c=relaxed/simple;
	bh=z0CasqAEvTfFdfOdHo4OuX7jWHBbJ5PPksEWEZz0WwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9If7d7C7znPGj3hafHOVFKZXr0Q1dUmDKlmdROIxoLMyKvcMeZrcujY5otoCZEvksvIxVYdGZTngYcyLBGEtuIpKQEMhFmaIhDF0pEx7016FMO3MTWv1S6qMMrMTHAE36lmuKSJ6a2cwOXesnMAx8iAhimhpyz+q2VrprOaqMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVFjzAnb; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVFjzAnb"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af5085f7861so2374723a12.3;
        Sun, 18 May 2025 12:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747595407; x=1748200207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPASqWbwMcCUMi4ZOjE3DcJ6mOdKDFpi0lCkuF6a4EE=;
        b=QVFjzAnb2p0UcjrleaQ95tNKCgo5rYBxqRsT1bCix39Gwke0xIT9UnrnDxzHUtXmEo
         5byTltgTkYjC2K67kOUcvs1CaUToLA09a+nPAMLu2zMBaNG1ctLVuLTUjuBIAVb4Wygz
         vPRU0NhG7bW2L2HcPR23AVOSWJfdcW5w0B3Gm5Qj3ihb14MnK9ZaQ0iBMsyltFNkIjXT
         UebEWTQ2ajQRbKAwpCi4IGNU3JTEvYz6P/u0TY6ywMhjZso/rkH3lmX63Fsjb1sKwpvN
         Fe+HerLV+cHq8iyhtzhMtsMix5UyyFuNPENTAAbpgUCIUaduJa1iGL3BLoHmRBHSHGnq
         QmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747595407; x=1748200207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPASqWbwMcCUMi4ZOjE3DcJ6mOdKDFpi0lCkuF6a4EE=;
        b=K4ge7veIQwyJKgEf/UioKEpWXxYyd1YTnIMBdxXB/kgf5jXjuFj64oe/UBIq69lWXp
         4qSpysfPgQs8ja/MuHtldl+HCyvZNW27qPxAqHhvvsyzSfdwnvkFfulSEPZfFHdj1Yvo
         E7ujGRUGf53f0MRqTjyHxrvOCvl/P09w/14HSPRb8t9BWwrW+hJ7gjaVIpqC3/779IIs
         avxcR+0bR8uQ1oP9Q1Ok+OL2qQRJr9uVuC7uZVjLUhdEsnYuXd9mNkzYQpkevN42ZvJM
         HIOfsYq3L+1RtA96SNmxIqns6oyP0YB51I+DLkd8JyNKoLw1cbj7VFE3P//87peq/n3T
         umlg==
X-Forwarded-Encrypted: i=1; AJvYcCVRE78jcW3HnpWBGMr438rpJie0RZFG1tLBGb05D1dMR6fKKA51pRu6JS2puXqfeboJoLCUBYviWHG+tmw=@vger.kernel.org, AJvYcCWWzKDlU3/ZyIv0eGMZGhhjn1xXrFq67AApjRBcM3EV27eFVgW5YX1bCXXpDShTfgO7pvM7n+3zr6HyP3fUzFo/9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoJqHyFtThHSwQnbhnxJ2iS1ZfE0DjoooRqK21Es2xInCiDkCW
	dJvj2Gp1+sR6InJIdoKgBVSVQJqswZxhjz2dF95zoOoRUxKPUPXob/Xc
X-Gm-Gg: ASbGncthXRk+4w7d58MTxFM/vZS7C+kXbaGPtdRfQ9DhimufChrt4o2uzyJz8zdEBuW
	NJa/hw5HW9X+bo6SUZ2Yg4cEux250EFiq0+mU49Y4IJ0nPZfm3nzMIe9C/C/fI+sTTNysh0wiNQ
	tqf33EJJx6hj3xnVGIUpRpZPpbCVZ42EMkHro/4IB3nR21RQAdjjQqltDmSfTvGS++jBd8mfefD
	n1fpmDYqLfns9AyjIYPIilqdBd7t1TU1ipSrGZoZmgcJwCcnl1PwHbbjP4v7UeJRFVIFUonfG7X
	EQwqOwF2OQjZ6p6lkRo74MWMRC/z9uFAxDB6r/PIAOaOxwIsmEtjUanGvDIofSNod9hqgS/c0uv
	tNNpToECvRfZMfzOSceh/6FjUgHNvquw=
X-Google-Smtp-Source: AGHT+IGsxIQ3q9cWJ+EyipAsTSsuKiCIUqXrsmQgjMFkJsHTFQ15ruIkysVpxTG60OserRb8uwfGEg==
X-Received: by 2002:a17:902:ea12:b0:22e:7f20:52c6 with SMTP id d9443c01a7336-231de317d0dmr136676575ad.23.1747595407360;
        Sun, 18 May 2025 12:10:07 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adafedsm46022135ad.56.2025.05.18.12.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 12:10:07 -0700 (PDT)
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
Subject: [PATCH v2 5/5] perf test trace BTF: Use --sort-events in BTF general tests
Date: Sun, 18 May 2025 12:09:57 -0700
Message-ID: <20250518190957.58932-6-howardchu95@gmail.com>
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

Without the '--sort-events' flag, perf trace doesn't receive and process
events based on their arrival time, thus PERF_RECORD_COMM event that
assigns the correct comm to a PID, may be delivered and processed after
regular samples, causing trace outputs not having a 'comm', e.g.
'mv', instead, having the default PID placeholder, e.g. ':14514'.

Hopefully this answers Namhyung's question in [1].

You can simply justify the statement with this diff: [2].

Now, simply run this command multiple times:
    $ touch /tmp/file1 && sudo /tmp/perf trace -e renameat* -- mv /tmp/file1 /tmp/file2 && rm -f /tmp/file2
And you should see two types of results:

    $ touch /tmp/file1 && sudo /tmp/perf trace -e renameat* -- mv /tmp/file1 /tmp/file2 && rm -f /tmp/file2
    [debug] deliver
    [debug] machine__process_comm_event
    [OVERRIDE] old :1221169 new mv str mv
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
	 0.000 ( 0.013 ms): mv/1221169 renameat2(olddfd: CWD, oldname: "/tmp/file1", newdfd: CWD, newname: "/tmp/file2", flags: NOREPLACE) = 0
    [debug] deliver

    $ touch /tmp/file1 && sudo /tmp/perf trace -e renameat* -- mv /tmp/file1 /tmp/file2 && rm -f /tmp/file2
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
	 0.000 ( 0.014 ms): :1221398/1221398 renameat2(olddfd: CWD, oldname: "/tmp/file1", newdfd: CWD, newname: "/tmp/file2", flags: NOREPLACE) = 0
    [debug] deliver
    [debug] deliver
    [debug] machine__process_comm_event
    [OVERRIDE] old :1221398 new mv str mv
    [debug] deliver
    [debug] deliver
    [debug] deliver

Anyway, use --sort-events in BTF general tests to avoid :PID, a comm is
preferred.

[1]: https://lore.kernel.org/linux-perf-users/Z_AeswETE5xLcPT8@google.com/
[2]: https://gist.githubusercontent.com/Sberm/6b72b2a1cf1c62244f1f996481769baf/raw/529667bd74a2e7e1953bbd4be545bf875da8a3e7/unsorted.patch

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/shell/trace_btf_general.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
index 5fa50d815203..30cd3a53f868 100755
--- a/tools/perf/tests/shell/trace_btf_general.sh
+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -27,7 +27,7 @@ check_vmlinux() {
 
 trace_test_string() {
   echo "Testing perf trace's string augmentation"
-  output="$(perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1)"
+  output="$(perf trace --sort-events -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1)"
   if ! echo "$output" | grep -q -E "^mv/[0-9]+ renameat(2)?\(.*, \"${file1}\", .*, \"${file2}\", .*\) += +[0-9]+$"
   then
     printf "String augmentation test failed, output:\n$output\n"
@@ -38,7 +38,7 @@ trace_test_string() {
 trace_test_buffer() {
   echo "Testing perf trace's buffer augmentation"
   # echo will insert a newline (\10) at the end of the buffer
-  output="$(perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1)"
+  output="$(perf trace --sort-events -e write --max-events=1 -- echo "${buffer}" 2>&1)"
   if ! echo "$output" | grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
   then
     printf "Buffer augmentation test failed, output:\n$output\n"
@@ -48,7 +48,7 @@ trace_test_buffer() {
 
 trace_test_struct_btf() {
   echo "Testing perf trace's struct augmentation"
-  output="$(perf trace -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1)"
+  output="$(perf trace --sort-events -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1)"
   if ! echo "$output" | grep -q -E "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,\}, 0x[0-9a-f]+\) += +[0-9]+$"
   then
 	printf "BTF struct augmentation test failed, output:\n$output\n"
-- 
2.45.2

