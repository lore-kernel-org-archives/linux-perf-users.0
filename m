Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4C832ED27;
	Tue,  6 Jan 2026 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767704405; cv=none; b=bbSQJQFXuos2CJLWgVijgxeX/6Zq/82VItcLTsMkPaDu7LvlFaE9UDGtYo+ENrsS/5mvvbCcvVOf7Ceaaa55bmdlMXd9v13UedHdqz+rfbziD6DHr/p3J5cCU6CwAps4qsUhwdtnmmp/5bBr5mYjlUYI4APdFi1QpuOiuurNUN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767704405; c=relaxed/simple;
	bh=vAi3vHWL+hCIaUx9qETT/L4cHRPYEbm4AszZVm0QYnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q3M9h27DVhnQRuRvVAEUNkQ7NTPKogvh6P1duXFYJsoXFFU2INFuKSth4ftOSPXWci5nGLlIQ7Elawalj5qoUBRtK2Bs/jwsnvZ4C2mcJu/uCr0hr7TtkJjwq6mxKY9JtWTUinKMJEYehAmUMB76UTHUzq5LgLqc24g3nWg217o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=KmIx2r9/; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="KmIx2r9/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1767704377; bh=vAi3vHWL+hCIaUx9qETT/L4cHRPYEbm4AszZVm0QYnU=;
	h=From:Date:Subject:To:Cc:From;
	b=KmIx2r9/rI7pE5k4bNfPgmq3LFh9bI/tMStj1BnmH6FPb/TdX/RqImg/+M5NwyTZR
	 cCBy0yvBBXjraOAUfSX+csjwxOcHolmGYK6umFP0yIRnc3JD+W+sltidHCJGhSh7xh
	 ynoveXEGFmhFsEUVCG4Odlk/g5/voicnF3qOD/j0=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.54.3)
	(envelope-from <n.schier@avm.de>)
	id 695d0739-3a9b-7f0000032729-7f000001e8ba-1
	for <multiple-recipients>; Tue, 06 Jan 2026 13:59:37 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue,  6 Jan 2026 13:59:37 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 6ED11807F6;
	Tue,  6 Jan 2026 13:59:37 +0100 (CET)
Received: from l-nschier-z2.ads.avm.de (unknown [IPv6:fde4:4c1b:acd5:7792::1])
	by buildd.core.avm.de (Postfix) with ESMTP id 5DCB9181236;
	Tue, 06 Jan 2026 13:59:37 +0100 (CET)
Received: from localhost ([::1] helo=l-nschier-z2.ads.avm.de)
	by l-nschier-z2.ads.avm.de with esmtp (Exim 4.99.1)
	(envelope-from <n.schier@avm.de>)
	id 1vd6eu-00000009ell-0no8;
	Tue, 06 Jan 2026 13:59:36 +0100
From: Nicolas Schier <n.schier@avm.de>
Date: Tue, 06 Jan 2026 13:59:25 +0100
Subject: [PATCH v2] perf test perftool_testsuite: Add missing shellcheck
 source directive
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-perf-add-shellcheck-sc1090-annotation-v2-1-bd52dc47369e@avm.de>
X-B4-Tracking: v=1; b=H4sIACwHXWkC/5WNQQ7CIBAAv9Jwdg1L1bSe/IfpYQuLECs00BBN0
 7+L/YHHmcPMKjInz1lcm1UkLj77GCqoQyO0o/Bg8KayUFKdUakeZk4WyBjIjqdJO9ZPyBplL4F
 CiAsttQCWdTfyeGo1sqitObH17/1zHyo7n5eYPvu24M/+eygICLJrO4XEbOlyo/I6GhbDtm1fy
 mhJh9cAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5836; i=n.schier@avm.de;
 h=from:subject:message-id; bh=vAi3vHWL+hCIaUx9qETT/L4cHRPYEbm4AszZVm0QYnU=;
 b=owEBbQKS/ZANAwAIAYjGvJyImm24AcsmYgBpXQc3YvCbmYrN39sOn3bAcJCPbVPY00TiMWaD0
 0ty+wZbeBSJAjMEAAEIAB0WIQQO/4WJ63TpgecLpGmIxryciJptuAUCaV0HNwAKCRCIxryciJpt
 uB0ND/4rRHLT5jJ1Iv7Pp8u3n6tPn6MjdGWnnGgW7+MD8sETNw7RXMPTKKffz3bjGB34EJ9GtYf
 8Ba4XB99l0+WwVNWi+AmQh6w72bIt+ZweST5uMb0mt1Vro7pFMLhesAJPhIfNEi+z2qAyb90uDN
 i6Q37XZhF1K+PRUdNurxJmACbX2aBvfwKpmDT8L4zluGzbXpHzfUqBu/q/eR7TgUWlY5Nn3ukTv
 9NRn/lGW45Ftv36xioFU5pEGkKjYETLy4UvaOIkLJT2vYEeIB8BH81+bcTf+8ZFnhvQKQXkiFPm
 UEEQWw9zaeYxepXjVQXGk+f2skFmVwhN0trHRlQcoD/pxVRvhFeOYQby445P6NwxmT9EWwParEv
 InQAxzNZSSMhdcxekFLLqtcUcD2+InNP/K6jKLfCjb9CrwyMc7A2RiUsHgolk6eC+Xie0gcGogl
 9ZS99UWpM6z12CmnXsJ6tTiJvTk0VIs95GDED5MXJyESccEgk6uh84IHxsCQIeAUAHS6XCgZW2D
 AB6dx/ie1xJku7teXugd1Cb9nhDhE+rft3GfM+21ca4NeCL+Xiu910xX1kafY3nnvg4x5qrRvLx
 av6tM/Lg9vH4XnDohkZq88xENE9KGbOkwzQk2IL8JP50ipADSKqlTHf6noKVgrRbfQhE6pZXvWi
 isxDSifGrFRl0rg==
X-Developer-Key: i=n.schier@avm.de; a=openpgp;
 fpr=7CF67EF8868721AFE53D73FDBDE3A6CC4E333CC8
X-purgate-ID: 149429::1767704377-29F426FC-3797FCCB/0/0
X-purgate-type: clean
X-purgate-size: 5838
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

Add shellcheck source directive to prevent old versions of shellcheck to
issue warning SC1090 for perf shell scripts, e.g.:

    In tests/shell/base_probe/test_line_semantics.sh line 20:
    . "$DIR_PATH/../common/init.sh"
      ^---------------------------^ SC1090: Can't follow non-constant source. Use a directive to specify location.

shellcheck versions since 0.7.2 handle such dynamic source includes in a
more friendly manner [1]; older versions show the warning and thus
break the perf build unless NO_SHELLCHECK is set to '1'.

Fixes: 241f21be7d0f ("perf test perftool_testsuite: Use absolute paths")
Link: https://github.com/koalaman/shellcheck/issues/1998 # [1]
Signed-off-by: Nicolas Schier <n.schier@avm.de>
---
Changes in v2:
  * Extend commit message and mention affected shellcheck versions
    (< 0.7.2)
  * Link to v1: https://lore.kernel.org/r/20251229-perf-add-shellcheck-sc1090-annotation-v1-1-083821aeefa6@avm.de
---
Another way w/o new shellcheck directives would be to update the minimum
shellcheck version in tools/perf/Makefile.perf to 0.7.2.  I'll send
that as an alternative patch.

Newer versions of shellcheck are available since e.g.
Debian bookworm 12 (released: 2023/06), Ubuntu jammy 22.04 (released:
2022/04), Fedora 37 (released: 2022/11)
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
base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
change-id: 20251229-perf-add-shellcheck-sc1090-annotation-fec8beb43c1e

Best regards,
-- 
Nicolas Schier

