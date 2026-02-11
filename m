Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0401D2C15BB
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Feb 2026 01:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770774778; cv=none; b=TUoI8A3Tu001zhODL7kU66eL94qrHsCaQhqZbyKy5E8rGTil0mBFUbDlI01YN1pLU7njgjyJNo2pm36KNQUAhvSOJilX/usy+gAPvte3TO3nqhTM7ZRoMQJWI5U/QDSutlPhKVcx8j7soWuQ1IBH7NAhU5LJfrrgeD3Gfy85XfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770774778; c=relaxed/simple;
	bh=DTG0wCe4l1QOCzgg/LUvHjey36vrzgciu/XJHppJvVg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jbEh3iFWgyCKLFKmeHjnG80E4McfD0HdqOLQfybC9GiguFB/ga/+/VeC1wFQL18CBtVU7fzEjuUZfMm7hV6kVqBUapSfBgO0OoOpDnS2yo10bjl8I72m8AytyGgjaEXL7QwHrwLwpv+SKtSPxkJKM5/9HwoBn6LkYo+DPzG9vCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EPT4UQg4; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EPT4UQg4"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b7ef896edcso23271443eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 17:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770774776; x=1771379576; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wopudxpZqJa8+pPTelgcXkgtvWVCN6h00NLP/d6pFt0=;
        b=EPT4UQg4wGMjKEr6fw/SZpIem8oUJTSWpL1LBvmu1UmNmLbo8USfntb+oD1GUtstI4
         azGm0+zRf8aQrCXLkszSKmJdgA/EeWORur/qc0dhfaowUvyh/rrJ4GR2rem04BYNROqK
         XxLNIwAIxc41Gmp5FjmcHlKxEpyJu2KX3I+VnyldeKMjb6c9ZpYGcAqcEgMWaqCQupMN
         mOOHytKOCjyq1ozZiX5PbdKvPH0/YN+HvhFGI/13JhbPdzoGLqVId75NpxOWkAiU69It
         74k0oLcl8qHrxYHsyiXSJjLt/5TdA2nejbfHWEo6EZSi1GsgHJVbkY7lgZYfy8ReL9qt
         MCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770774776; x=1771379576;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wopudxpZqJa8+pPTelgcXkgtvWVCN6h00NLP/d6pFt0=;
        b=HbCNMdFYxRkp/gnhbPVyeSEyyBLSaokeZw5yA+xIaQ0oomhm5r1/8CfTUJ62+egIh9
         F7EcNk5t6mefFfgcDjOQDwTzp9OqTi1i9AhNEFWXkLeIA8/zELN+cVrO11J5nVPfGLeN
         5n8zsvwj8CoTnyg1yir1+GVBaxJ7KRVQGRFOj+7PyqM3zjo7MPfEyvVDVcbb/2NfeBvg
         3i3AnTW6PiJp/eIykshIH//rXrFuH/nEwCHqNSnDY2gpDIff934sVbzPvP+iuGxsi0iw
         fxhQDRttLVl/fuuEmSq2MEJ7hy3tyBiLdYEgQ8uhef8IYKB2bvDAarFXizozSEzYQFrD
         WbQA==
X-Forwarded-Encrypted: i=1; AJvYcCUz8zlwrflvaRZ9yqu3MjvN3a6lKbM1ukmw/LfSdaWWQ1D5L/6Hw+w2psOhjv0vqG9kq95oh0fQclK++9UJD8BW@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk0JTiX8SB1s+zS/DcVdpu80cD2BZpKd5Wjqcibbnrfi+j9z4+
	408IwfuGdslasp11N78ZvxifNGEfDKKF+XmVAcQp2L5j3713/z7/vjC1EM5v4n3R0pJe6xEVjxc
	9i6iIRr+GtA==
X-Received: from dycnr4-n2.prod.google.com ([2002:a05:7300:e9c4:20b0:2ba:895a:ddb2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:dc05:b0:2ba:8f47:fe4f
 with SMTP id 5a478bee46e88-2ba9e080163mr116493eec.18.1770774776135; Tue, 10
 Feb 2026 17:52:56 -0800 (PST)
Date: Tue, 10 Feb 2026 17:52:41 -0800
In-Reply-To: <20260211015242.2700218-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260211015242.2700218-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260211015242.2700218-5-irogers@google.com>
Subject: [PATCH v1 4/5] perf test: Test pipe mode with data conversion --to-json
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Derek Foreman <derek.foreman@collabora.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add pipe mode test for json data conversion. Tidy up exit and cleanup
code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../shell/test_perf_data_converter_json.sh    | 33 ++++++++++++++-----
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/shell/test_perf_data_converter_json.sh b/tools/perf/tests/shell/test_perf_data_converter_json.sh
index c4f1b59d116f..35d81e39a26c 100755
--- a/tools/perf/tests/shell/test_perf_data_converter_json.sh
+++ b/tools/perf/tests/shell/test_perf_data_converter_json.sh
@@ -15,29 +15,42 @@ result=$(mktemp /tmp/__perf_test.output.json.XXXXX)
 
 cleanup()
 {
-	rm -f "${perfdata}"
+	rm -f "${perfdata}*"
 	rm -f "${result}"
 	trap - exit term int
 }
 
 trap_cleanup()
 {
+	echo "Unexpected signal in ${FUNCNAME[1]}"
 	cleanup
-	exit ${err}
+	exit 1
 }
 trap trap_cleanup exit term int
 
 test_json_converter_command()
 {
-	echo "Testing Perf Data Convertion Command to JSON"
-	perf record -o "$perfdata" -F 99 -g -- perf test -w noploop > /dev/null 2>&1
-	perf data convert --to-json "$result" --force -i "$perfdata" >/dev/null 2>&1
+	echo "Testing Perf Data Conversion Command to JSON"
+	perf record -o "$perfdata" -F 99 -g -- perf test -w noploop
+	perf data convert --to-json "$result" --force -i "$perfdata"
 	if [ "$(cat ${result} | wc -l)" -gt "0" ] ; then
 		echo "Perf Data Converter Command to JSON [SUCCESS]"
 	else
 		echo "Perf Data Converter Command to JSON [FAILED]"
 		err=1
-		exit
+	fi
+}
+
+test_json_converter_pipe()
+{
+	echo "Testing Perf Data Conversion Command to JSON (Pipe mode)"
+	perf record -o - -F 99 -g -- perf test -w noploop > "$perfdata"
+	cat "$perfdata" | perf data convert --to-json "$result" --force -i -
+	if [ "$(cat ${result} | wc -l)" -gt "0" ] ; then
+		echo "Perf Data Converter Command to JSON (Pipe mode) [SUCCESS]"
+	else
+		echo "Perf Data Converter Command to JSON (Pipe mode) [FAILED]"
+		err=1
 	fi
 }
 
@@ -50,16 +63,18 @@ validate_json_format()
 		else
 			echo "The file does not contain valid JSON format [FAILED]"
 			err=1
-			exit
 		fi
 	else
 		echo "File not found [FAILED]"
-		err=2
-		exit
+		err=1
 	fi
 }
 
 test_json_converter_command
 validate_json_format
 
+test_json_converter_pipe
+validate_json_format
+
+cleanup
 exit ${err}
-- 
2.53.0.239.g8d8fc8a987-goog

