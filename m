Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEF026C3BD
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 00:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775780637; cv=none; b=K/J41GMWuv6gFPllhxdPrmy7Ii1kvt0PVeROxbcHD/usVG1t/+AMYftOtfeWsGN10Opn2hb62b4NfA1+D5fUFKHZd/Tok8bvEBSAu9zC2xkblbDCP0/jCMRnAodLP77MK6BTPVSNXT+/w3heUqTBgUYhoXIGquOaJNmt4IEC8yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775780637; c=relaxed/simple;
	bh=0aeGwRNW0xmntzjfP7YxxLFi+8s2M7WGQMmYb7loLl8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=VRE4+XQvVs2VUk0CfYGc0+IbeRT4aUQ3og3AIxey8YimJpKpoUh8ptTYxvm7F1ETNZZxnBacQzxzZK3Db/VrNPFqVu7gRJ6CzO8TzBvVF1ga/DsTodJiRyiekBtkOnVmYbOiMz1TUVVgG1XDNI6cGxAdMMvmGf3cvBsQVR+309w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I+r6veey; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+r6veey"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c16233ee11so1980476eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Apr 2026 17:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775780635; x=1776385435; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=auhMbk+xHy2gdDd91CGiDgq/1FaWJaoeUXnY1AfHXxs=;
        b=I+r6veeyXOIyUFLEJIfjuxBPTpmQIE7mg3p1u0W90HYG0zCPPH7G7SOPhphjfnz3ZD
         TxbXH+cldjb9DWCrMARB+pWoLBszuwptQeXsTfcc3/4j5G/9dcx42xLgSQgD7mCiLLs1
         woBD+BMF7HRwy/ohWDO/yMLUSNPT+6v11OxMDjsd3aZzoXwBGUWuthsolcdlArNH+ZXm
         cMqYf/Dfkee/LiywlGMbF6uKEmEVNHx6eo1UsrLMpu1Von9ug1Gs1LBQH9L1fcesJd1u
         W8pUU/ojrY+o0aFdS1VuzyMatwDkPf9IgO4e4PCPjbZ/LEqaSqukxRqwUED15egsXjAU
         YXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775780635; x=1776385435;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=auhMbk+xHy2gdDd91CGiDgq/1FaWJaoeUXnY1AfHXxs=;
        b=g54LuFI0JLGAdWkNxANqZ0vB+N26erTRX16YruPUWc/HP9yDDT0XSzVKTyRvvv3ktr
         e9RFkY1SjoUNZ47F+LHzeoggevXz4b9rJuXOM3Qpe3f4xSfBZb32Ny9THEgQfHSAPJtB
         Sol58E69WXBgY62beRbyQSxSo+xMFTVJF2jlMiPK8tv55aS1anS3jZskpYwPNxAfoMU7
         f51spScfwoW5LgMv+cjP/dCAPFvorjAoqPN2fvyOBZs7A+MAOv/sbqtmMKPo6EbqEt4W
         vOg8+C4YZkQXhrN7D07xMrCeV1PS8auyFgqoL2MMZaLj8kJ9UnJOLy2uA0H1ESWdwMlz
         8GHA==
X-Forwarded-Encrypted: i=1; AJvYcCXj/xLYH1HaX+iyPxINvhMCPNWDnN8KP//Twq80pOQ2q4+55yn4ZLpScsJ06AlGlwHwYdY/Ex/Q60j8G8z6bMkO@vger.kernel.org
X-Gm-Message-State: AOJu0Yym9rsYmKzJkvfD7mO6SNAuGDayYqcGf0bOzvoR/qY6XP9vYMOc
	Tpae0F5orx7v33lnCKa2bMdy1sgz4C+4MJavQRcy7+mUWTN1Z80ky0B844ni4VfIoXm/TGsCnjl
	YNOrVRGXEBw==
X-Received: from dycng24.prod.google.com ([2002:a05:7300:ce18:b0:2ca:8cd8:d7e0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2b05:b0:2c8:8954:1441
 with SMTP id 5a478bee46e88-2d5891764cdmr655590eec.17.1775780634492; Thu, 09
 Apr 2026 17:23:54 -0700 (PDT)
Date: Thu,  9 Apr 2026 17:23:51 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410002351.10856-1-irogers@google.com>
Subject: [PATCH v1] perf test: Fix inet_pton probe failure due to multiple probes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
`| sort -u` to the awk extraction. This ensures that only a single,
unique event name is captured, regardless of how many probe points
are created.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index ab99bef556bf..b717063f70c2 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -22,9 +22,9 @@ event_pattern='probe_libc:inet_pton(_[[:digit:]]+)?'
 
 add_libc_inet_pton_event() {
 
-	event_name=$(perf probe -f -x $libc -a inet_pton 2>&1 | tail -n +2 | head -n -5 | \
+	event_name=$(perf probe -f -x $libc -a inet_pton 2>&1 | \
 			awk -v ep="$event_pattern" -v l="$libc" '$0 ~ ep && $0 ~ \
-			("\\(on inet_pton in " l "\\)") {print $1}')
+			("\\(on inet_pton in " l "\\)") {print $1}' | sort -u)
 
 	if [ $? -ne 0 ] || [ -z "$event_name" ] ; then
 		printf "FAIL: could not add event\n"
-- 
2.53.0.1213.gd9a14994de-goog

