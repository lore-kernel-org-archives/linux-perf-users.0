Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7AD23ABB0;
	Mon, 29 Dec 2025 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766993486; cv=none; b=P+2RC+LDi5/mu8tBsHoq8wVJ5+UY9lMX1s5UcsV2GYpauGAsBNvmshAJ70n2Rq9H4mW91xjc9Naif1hiW6rzmXVZ5ICNRxEcjZYr7Ms+qTvEeE2GpJ6flHFxPoXZjra1GbSTA4JgvE7zw5PT2n+h4eLeXLC+94ZgEALdJv2gbIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766993486; c=relaxed/simple;
	bh=yvVGu+9NRDvndkSZT1QQsXflu+D+xDjVRN3FIwO78Ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=te2tX6R9TX6DY/EAx3SgpC0t2SQ4CmK6NMXgk3Jw/Q8ss4Iz0SX671MJYzZTZjKSvA17UjSaK1mdeuQWox4q+ecpwxjEwfGJGNRX0VczM9SBufMd8bilMl4N5F197sGIlilIXoQEKX6bdpJcjrWUr/WB0CX244rNgYORwVkY5II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=Ehl8ZmBG; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="Ehl8ZmBG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1766993143; bh=yvVGu+9NRDvndkSZT1QQsXflu+D+xDjVRN3FIwO78Ws=;
	h=From:Date:Subject:To:Cc:From;
	b=Ehl8ZmBGU5UdRdiCb6ucNAbN9nx3XwLX764UhELtq0fawrlgVJUnhunNSUMG94LtF
	 qsiFnpfJGoYt11R2Q5mR53+4pcs5CawPj+aN7llx4yOTQ0U6Yx0CNAwu4TnL8Cp+eJ
	 92TjK0GIyAxmL2ThCQoIj3BSJ372V5izfDSY6Lt4=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.54.3)
	(envelope-from <n.schier@avm.de>)
	id 69522cf6-bfa0-7f0000032729-7f00000187a0-1
	for <multiple-recipients>; Mon, 29 Dec 2025 08:25:43 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon, 29 Dec 2025 08:25:42 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id DBD8E80859;
	Mon, 29 Dec 2025 08:25:42 +0100 (CET)
Received: from l-nschier-z2.ads.avm.de (unknown [IPv6:fde4:4c1b:acd5:7792::1])
	by buildd.core.avm.de (Postfix) with ESMTP id CC7F4181327;
	Mon, 29 Dec 2025 08:25:42 +0100 (CET)
Received: from localhost ([::1] helo=l-nschier-z2.ads.avm.de)
	by l-nschier-z2.ads.avm.de with esmtp (Exim 4.99.1)
	(envelope-from <n.schier@avm.de>)
	id 1va7dN-0000000B2EP-3UdH;
	Mon, 29 Dec 2025 08:25:41 +0100
From: Nicolas Schier <n.schier@avm.de>
Date: Mon, 29 Dec 2025 08:25:25 +0100
Subject: [PATCH] perf test perftool_testsuite: Add missing shellcheck
 source directive
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251229-perf-add-shellcheck-sc1090-annotation-v1-1-083821aeefa6@avm.de>
X-B4-Tracking: v=1; b=H4sIAOUsUmkC/x3NQQrCMBBG4auUWTuQRAXrVcRFOvljBktaMkWE0
 rsbXL7N93YyNIXRfdip4aOmS+3hTwNJifUF1tSbggtXH8LIK1rmmBJbwTxLgbzZxLvRcax12eL
 WBc6Q24TpchYP6tbakPX7/zyex/EDlsZQ33cAAAA=
X-Change-ID: 20251229-perf-add-shellcheck-sc1090-annotation-fec8beb43c1e
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Veronika Molnarova <vmolnaro@redhat.com>, Jakub Brnak <jbrnak@redhat.com>, 
 Michael Petlan <mpetlan@redhat.com>
Cc: Philipp Hahn <p.hahn@avm.de>, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolas Schier <nsc@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4954; i=n.schier@avm.de;
 h=from:subject:message-id; bh=yvVGu+9NRDvndkSZT1QQsXflu+D+xDjVRN3FIwO78Ws=;
 b=owEBbQKS/ZANAwAIAYjGvJyImm24AcsmYgBpUiz1IpoKsI+xZ2a5egRmwJjMcUSCuDDlt5WiA
 Aune0VH7oyJAjMEAAEIAB0WIQQO/4WJ63TpgecLpGmIxryciJptuAUCaVIs9QAKCRCIxryciJpt
 uAkWEACR12SEgrFkRyd1GpblEefbZoO2K7d4G6oMBkf/t5kpPLGLOVP+ZGY8TrLqNyDBrvm9q2k
 PZmJQUq9nW7AEBuGdUZNvVQoJ8+9XU+9yab+sR9xfH6+cFPeVkfQ7G0ODJeOxnjgTxZfTpnRleq
 wvDmIk2td236i/7Au78ZrzzcmPfE6mhAFVe20XbejCCbvQF6y97qfjBAkHiqHImiu8T5HoNGxF7
 M/3YoLfzOVR8/pdWOQAM+0gBh9EDBI/FY94pYQyXInREDuhYkHqR26ZFzBBV2+Spl1QphAOrT4S
 r9lVfLEgljB5n1pJ3WgBW6THB66ENJVZIx4nQgE8lkDGq13SVVGDnzuSCj1splHyZORQgHs3jbD
 omFF6Qqkn5suEKi1PIOqvu2ExOdniBDimBhNMNv1sEBGkRVJKYyUPKN26N8WzEo9dFa8/WvaGZy
 2ytgR4/BO3EWTfB98DS1XWUDWUOQF3UduLaCshn1uyRy0muirqYYnRqokhoCtoQ79dfuY1oEDtK
 DISsdx8S30qPhpvloA0I17ryxJQAfl5Hf6PjuLRC3W4bJh8zQUif7sg1qxZZvGqly79gDQ2lxru
 NKv1Vw4eH/t2W/eHteEkd2xCr8lMXHj8TAvvoCh6tb8ua7DnpM5FZS2amBK4Be/czk6bMciJzlI
 5zZo22p7yEbl7Sw==
X-Developer-Key: i=n.schier@avm.de; a=openpgp;
 fpr=7CF67EF8868721AFE53D73FDBDE3A6CC4E333CC8
X-purgate-ID: 149429::1766993143-7FE0E3EE-E4A7BFBE/0/0
X-purgate-type: clean
X-purgate-size: 4956
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

Add shellcheck source directive to prevent shellcheck SC1090 warning
like:

    In tests/shell/base_probe/test_line_semantics.sh line 20:
    . "$DIR_PATH/../common/init.sh"
      ^---------------------------^ SC1090: Can't follow non-constant source. Use a directive to specify location.

Fixes: 241f21be7d0f ("perf test perftool_testsuite: Use absolute paths")
Signed-off-by: Nicolas Schier <n.schier@avm.de>
---
 tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh | 1 +
 tools/perf/tests/shell/base_probe/test_adding_kernel.sh      | 1 +
 tools/perf/tests/shell/base_probe/test_basic.sh              | 1 +
 tools/perf/tests/shell/base_probe/test_invalid_options.sh    | 1 +
 tools/perf/tests/shell/base_probe/test_line_semantics.sh     | 1 +
 tools/perf/tests/shell/base_report/setup.sh                  | 1 +
 tools/perf/tests/shell/base_report/test_basic.sh             | 1 +
 7 files changed, 7 insertions(+)

diff --git a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
index f74aab5c5d7f85b04f68090515acdfa49b6bccf3..06fca7d2cbb407eaea57df79bef11e26b49f9841 100755
--- a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
+++ b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
@@ -17,6 +17,7 @@ DIR_PATH="$(dirname $0)"
 TEST_RESULT=0
 
 # include working environment
+# shellcheck source=tests/shell/common/init.sh
 . "$DIR_PATH/../common/init.sh"
 
 # skip if not supported
diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
index 555a825d55f24543e3b6d105660c2cb505080e04..b6f9c4a697921b232a4795afcba10882e6101ce9 100755
--- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
+++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
@@ -17,6 +17,7 @@ DIR_PATH="$(dirname $0)"
 TEST_RESULT=0
 
 # include working environment
+# shellcheck source=tests/shell/common/init.sh
 . "$DIR_PATH/../common/init.sh"
 
 # shellcheck source=lib/probe_vfs_getname.sh
diff --git a/tools/perf/tests/shell/base_probe/test_basic.sh b/tools/perf/tests/shell/base_probe/test_basic.sh
index 162838ddc974d04d806b22366866f8201802f969..f2db48cb9b8feffc6de1f3ea50a1dc99cb44f377 100755
--- a/tools/perf/tests/shell/base_probe/test_basic.sh
+++ b/tools/perf/tests/shell/base_probe/test_basic.sh
@@ -16,6 +16,7 @@ DIR_PATH="$(dirname $0)"
 TEST_RESULT=0
 
 # include working environment
+# shellcheck source=tests/shell/common/init.sh
 . "$DIR_PATH/../common/init.sh"
 
 if ! check_kprobes_available; then
diff --git a/tools/perf/tests/shell/base_probe/test_invalid_options.sh b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
index 44a3ae014bfa2ffa831b86796b2e5187311d7303..3ae9afe6288b04d90777ebf5cdc64342f270eb75 100755
--- a/tools/perf/tests/shell/base_probe/test_invalid_options.sh
+++ b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
@@ -16,6 +16,7 @@ DIR_PATH="$(dirname $0)"
 TEST_RESULT=0
 
 # include working environment
+# shellcheck source=tests/shell/common/init.sh
 . "$DIR_PATH/../common/init.sh"
 
 if ! check_kprobes_available; then
diff --git a/tools/perf/tests/shell/base_probe/test_line_semantics.sh b/tools/perf/tests/shell/base_probe/test_line_semantics.sh
index 576442d87a44400a65edce95b23070ce56f32993..4a1189c6cb0cbc269672c47efa617d20b0b4e795 100755
--- a/tools/perf/tests/shell/base_probe/test_line_semantics.sh
+++ b/tools/perf/tests/shell/base_probe/test_line_semantics.sh
@@ -17,6 +17,7 @@ DIR_PATH="$(dirname $0)"
 TEST_RESULT=0
 
 # include working environment
+# shellcheck source=tests/shell/common/init.sh
 . "$DIR_PATH/../common/init.sh"
 
 if ! check_kprobes_available; then
diff --git a/tools/perf/tests/shell/base_report/setup.sh b/tools/perf/tests/shell/base_report/setup.sh
index bb49b0fabb11499d4fb20d3c8c325d7f081cf18b..bc1dd8c128a6a57fd0a8ba94e51f0b11453a31de 100755
--- a/tools/perf/tests/shell/base_report/setup.sh
+++ b/tools/perf/tests/shell/base_report/setup.sh
@@ -15,6 +15,7 @@
 DIR_PATH="$(dirname $0)"
 
 # include working environment
+# shellcheck source=tests/shell/common/init.sh
 . "$DIR_PATH/../common/init.sh"
 
 TEST_RESULT=0
diff --git a/tools/perf/tests/shell/base_report/test_basic.sh b/tools/perf/tests/shell/base_report/test_basic.sh
index 0dfe7e5fd1ca609535fa70b03c8301373ec3fe6f..4cbc7c67f7bb9ccd79f950b731c604a426c5bfd0 100755
--- a/tools/perf/tests/shell/base_report/test_basic.sh
+++ b/tools/perf/tests/shell/base_report/test_basic.sh
@@ -16,6 +16,7 @@ DIR_PATH="$(dirname $0)"
 TEST_RESULT=0
 
 # include working environment
+# shellcheck source=tests/shell/common/init.sh
 . "$DIR_PATH/../common/init.sh"
 
 

---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251229-perf-add-shellcheck-sc1090-annotation-fec8beb43c1e

Best regards,
-- 
Nicolas Schier

