Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209FC3074A1
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775936231; cv=none; b=XDbyBhfngTZxohoBf8z4J7JKhMKq7oZUGkGT9ZU/psZfg4cq8RhBVmoWyQgrOub8Me9k+cFvoJE3kbZSjzvCOYfOUWydx/8LL0oxUggLiK5sEC0Fzk3BQKAj2M2f3o37TAQrNofnye5nm4WgNwQJBR82v9c1Rq+t1LZXwaeaY4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775936231; c=relaxed/simple;
	bh=vm8UaHblBbOTZDpPpX67vhsE9F2Ee+kQpZ/DQHOL/wg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BzCnyLmMv4CtSuSV3VmCQrp12Vb5vUZpa02o12pVEhReyo+bhmJMrL9uWfJHtMWHiINvd9kO5HZNOd6pOx6+43YE8mPdvXBNFxQitZTxfohWh8ws2MehPFB8bc9nTuBhBQIEqroddaziqSqDbB1tKXJlDbhgbbOCJagS3zNNHNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NesmHtCT; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NesmHtCT"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c20d5d7f4so9563194c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 12:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775936229; x=1776541029; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ppMNPJoqhQhvZfkwbBOZZThQ4MM495Y4ISin+CazQpA=;
        b=NesmHtCT8oPheVXzVX8Xlm4sfdEZJXG87xFoZWtdHJr6UCgbYtxq91ldlxHvwpFDEL
         dFFK+ajtCrt/kLaSudyOx7G5m+c3OLeCNOzcElrZqQ1wutWGpqKau0P4kfsPIDpqO/mX
         l6be521AMqbK1SNLiiW0u6zQldXTmIzX/lKmaJBR8KwarzLdKy/MgZ7KlaOb4bFaQeHM
         ieJOxRm18dJgqIz4WN8mBYXLWWEkBzluZTJwwiXApEtlx1T+53aSMB3e0i4hP/FJ8Mrc
         dWBrl5kz3MSuMli5FTzw5X74xKN+YXamm0vYuE+jvVRI2w5A/N9ncS3QiawlvWdE3wJJ
         TnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775936229; x=1776541029;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ppMNPJoqhQhvZfkwbBOZZThQ4MM495Y4ISin+CazQpA=;
        b=IWBLSw0IqsSiJZNgNlZm1h2tq4bStAw0LTxls4lAXJh1nyMdnpkGtRH8eeGCy/WJi6
         PGwGDQi665r3J1NC+MIjGtbfnFMAKLRmQkAif2d2ZytmdPrHtXVPTmxmZe3bEQSGK1zf
         Ln07VGNuaQUWR/a4HqHJlDX+7au8zNtwy8gG0wmhfZKEnQ1kd/8X/TfFXOrKt4U9R5mz
         Sbd8NISfXMhi83FaXJawqULZDV/qUivfKZpVpktQX87I/gswsxF/VwhYEgCTrvSuGWZw
         SSdrmb25e2YVo8En9U2Tueh3W+6WGnDEgz5gcojp9jfngFg5DG40qC4DRgaYQ5tOFMnf
         K4tg==
X-Forwarded-Encrypted: i=1; AJvYcCWBFCWbk+FQHx12MVXcSaXVl4hmB5a+VwM07/awr4N7XbFbNI9rOqwZUOwl57qD294qVFeF4qCJZYt/ajn2Hmdy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8tfj7WSPfx/RVK9CRRa9lvkawAYvSEwy+kUzhoFImhC5APiLB
	xsJ0GTDXE3Ryjsrc8qnH/WsshonvV3IMsm9aQHBSc3vrqvY5nzracAt3uf0MJg9XIRZGxkfaP0y
	ceDHxi2ndVw==
X-Received: from dlbtp7.prod.google.com ([2002:a05:7022:3b87:b0:12c:5db:d6d1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:239a:b0:11f:3483:bba6
 with SMTP id a92af1059eb24-12c34e8015bmr4964304c88.13.1775936228868; Sat, 11
 Apr 2026 12:37:08 -0700 (PDT)
Date: Sat, 11 Apr 2026 12:37:05 -0700
In-Reply-To: <20260410002351.10856-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410002351.10856-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411193705.735269-1-irogers@google.com>
Subject: [PATCH v2] perf test: Fix inet_pton probe failure and unroll call graph
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, collin.funk1@gmail.com, ctshao@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When adding a probe for libc's inet_pton, perf probe may create multiple
probe points (e.g., due to inlining or multiple symbol resolutions),
resulting in multiple identical event names being output (e.g.,
`probe_libc:inet_pton_1`).

The script previously used a brittle pipeline (`tail -n +2 | head -n -5`)
and an awk script to extract the event name. When multiple probes were
added, awk would output the event name multiple times, which expanded
to multiple words in bash. This broke the subsequent `perf record` and
`perf probe -d` commands, causing the test to fail with:
`Error: another command except --add is set.`

Fix this by removing the brittle `tail/head` commands and appending
`| head -n 1` to the awk extraction. This ensures that only a single,
unique event name is captured, regardless of how many probe points
are created.

Additionally, the test artificially limited the backtrace size via
`max-stack=4` and did not specify dwarf call graphs for non-s390x
architectures. In newer libc versions where `inet_pton` is nested
deeper or compiled without frame pointers, `perf script` failed to resolve
the backtrace up to `/bin/ping`. Fix this by explicitly collecting
dwarf call-graphs for all architectures and increasing `max-stack` to 8.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index ab99bef556bf..eca629ee83f0 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -22,9 +22,9 @@ event_pattern='probe_libc:inet_pton(_[[:digit:]]+)?'
 
 add_libc_inet_pton_event() {
 
-	event_name=$(perf probe -f -x $libc -a inet_pton 2>&1 | tail -n +2 | head -n -5 | \
+	event_name=$(perf probe -f -x $libc -a inet_pton 2>&1 | \
 			awk -v ep="$event_pattern" -v l="$libc" '$0 ~ ep && $0 ~ \
-			("\\(on inet_pton in " l "\\)") {print $1}')
+			("\\(on inet_pton in " l "\\)") {print $1}' | head -n 1)
 
 	if [ $? -ne 0 ] || [ -z "$event_name" ] ; then
 		printf "FAIL: could not add event\n"
@@ -40,12 +40,12 @@ trace_libc_inet_pton_backtrace() {
 	echo ".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
 	case "$(uname -m)" in
 	s390x)
-		eventattr='call-graph=dwarf,max-stack=4'
+		eventattr='call-graph=dwarf,max-stack=8'
 		echo "((__GI_)?getaddrinfo|text_to_binary_address)\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
 		echo "(gaih_inet|main)\+0x[[:xdigit:]]+[[:space:]]\(inlined|.*/bin/ping.*\)$" >> $expected
 		;;
 	*)
-		eventattr='max-stack=4'
+		eventattr='call-graph=dwarf,max-stack=8'
 		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
 	esac
-- 
2.53.0.1213.gd9a14994de-goog

