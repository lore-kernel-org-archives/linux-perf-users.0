Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EC621C9E0;
	Wed, 28 May 2025 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748459520; cv=none; b=gD0muCOee5kRcj+7s68aUhaW7tT/WDqkiKgfboi5t2F+1YKnxAEIex/n+QbOrIItWGTgMVYBRAW3WRqgCb3upbHs+5NCkpuH09OEBO/6L7m9HZjUbK5RZyZa9Nw1L+/QnYOiSwdKKJL3oOpgVNEOE3+kgb3dlM7CrJrqeDbHysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748459520; c=relaxed/simple;
	bh=z0CasqAEvTfFdfOdHo4OuX7jWHBbJ5PPksEWEZz0WwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIBIS9LFIJJVSsnGLrcMgnrtHptXsZI1JuJyeEH670lZstU5tN4ja0nbw0nw3qnsDsODLnCUg9qS63fx6ELi9fcsbW8BVbZQVQFiWx0d2I87MgzOobvdm/6pSX4Izn6z6Tq1AEkcrHHZQFE0/xpRkykP70/4rvkow1UFMWlQHaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VR6fG1Fd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR6fG1Fd"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-234f17910d8so2048385ad.3;
        Wed, 28 May 2025 12:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748459518; x=1749064318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPASqWbwMcCUMi4ZOjE3DcJ6mOdKDFpi0lCkuF6a4EE=;
        b=VR6fG1FdZyrbSv8tsZurKS2TKaf+fcLRPwWPz12ieuqfEZdvAMtKjwcSo8/tfEwSzx
         anSngFcocQrG6UnUmL+vxcijy6csKiWazW2mp/s/H3UU3cXynEI1mzEjFZq0sdCmnazG
         SJbXsZLH/9t6REpfGwHYNa1vgoROG1YyniQXEVNR3Y0daLKegliPjrtK4CTxnxkyqI+3
         mJcXqzqzOI0+TXBw1085ctiDxCQhFpI2bIn1yDnDlbDNRzBrXPx3yY8t291x1igBtRUK
         jybQO6lGqiWJWKFfgRXOn/gB+31hDNmB7tMxx04pXXMyWWwPPhMt7rrGN3oc7/DXvYxZ
         Gylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748459518; x=1749064318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPASqWbwMcCUMi4ZOjE3DcJ6mOdKDFpi0lCkuF6a4EE=;
        b=CxRYPMTc0mNaCqo7jQ8qEi0cpBdCIlfhe+ziHJlzG86ftHoUjL3KOaC6JQ9Fb8aJJr
         yexGBNu5uuYrc0H5SSp/hDfqZcKXy/kQ5Kl+tRjXqFh3/lc9VAnx+NicEMnKf5oeQ3zP
         dHTunf0yrIydTkdeSEM1cTg2bWvFRCpdCqnkw14ki4MS7T9iQB6T0QJ03G6p5W3+hdVB
         gF1ZehV4E16V+iaSP7tMvpKSmaKheINVx7Y3v2JLDzjSCHAod3ZwW6NyNxZmwsr4IeNJ
         0/d2CvYBUioKdLgfyIgGBg4Kcap0nvaEaz/v/AD/WsDfdKaQ1QXz4zI2u10iLwsrKnIx
         fdmw==
X-Forwarded-Encrypted: i=1; AJvYcCVz3DnTG3mSYFgHJTd2cSiw9oCW6A/qJh15TR7sip+mREATH01eMRCwQWdO8+Z3xMLe5fh/fpSPuEiJYO8=@vger.kernel.org, AJvYcCXLYzjHQM4/mA20R6Q+hzhNm4Cs22W4Mtr5pdH1ec3QttEwGzqVqi0dnlx6ABQnL7JX7sRJeQpxaK2f3kpv5WbgqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnWQ0rGMzheTw7tbXEglgz3KzzT08UBlKQm7DECdRYvACbXV/8
	AR5XeSmmV1lfn/9smWsF6uiPzETca2KW/EtMGUEpwAbqjMS8jAObrILW
X-Gm-Gg: ASbGncucXDdfg7lBee7R5NITVyscnFVHyRjKI4388iDcCzLy8eiwGjXCghmD4geZkJQ
	IhtyHcW3yf94+WFa8Ztvx4HvjGK0U6pEWqZt644bEExXoYxcHTSaBcRVIQOSHa1+AN54tJQsYwX
	+26tFKILExX7efdzMzvooxGro9F2qQmxZJLBFCIoxe3WhYoZ0SZuW1WeBbhRAFDWDsL7aBaJPlO
	6OACkH1TIFz+Ro6wgx8btmDpDEHN3BjcQoUg+ZytXkycCIMnyWUl4UkikUWfBC10c7s1xC8J1CC
	uavAHu3XUrv4vCucb8DuK+NQMY7C9VNRrhut89Gg55oillutdEQCa+PjLmQ1+6Ka/NJVJ3/w6VE
	VoGXrjB0F8MU=
X-Google-Smtp-Source: AGHT+IFNVo+OnHeeFkizMDit6woU+hKXUKf9ITrqjlo4oR9kFZG3EH+RCKYme07nPbuYwtPOq0PPlw==
X-Received: by 2002:a17:902:e74b:b0:21f:768:cced with SMTP id d9443c01a7336-23414f3abb3mr235504275ad.8.1748459518550;
        Wed, 28 May 2025 12:11:58 -0700 (PDT)
Received: from howard.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm15172215ad.169.2025.05.28.12.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 12:11:58 -0700 (PDT)
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
Subject: [PATCH v3 5/6] perf test trace BTF: Use --sort-events in BTF general tests
Date: Wed, 28 May 2025 12:11:47 -0700
Message-ID: <20250528191148.89118-6-howardchu95@gmail.com>
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

