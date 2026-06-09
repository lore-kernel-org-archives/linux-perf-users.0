Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C826E4CA270
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029285; cv=none; b=kx0J9vcFtl0dOpyEFdz2kisi6LHxkSe8Tk4xVhFUWMl0spCq9DkxSyaNqOQhQ8BHh0JoD6xh27n6RewbYMtjVufe8+ROr8XIcqyZHCqos3AUA5jKTr8UsmHU0pjmiPJ9QHJ2GzwCoN9lkd0v3u+q0ziB1Y45cgZz31rO7EDl978=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029285; c=relaxed/simple;
	bh=4ObXKdkZc4ocOIK2lDt0OccDqxweKbrLgkneTUU5Xv0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FBtU/pr9KXRjRYJB09JIAEc8el7qIuQlWAy+7gK1n12BI5tiKh51/08AG8qp5FLnAvnpJXMv6r3BktwvD9XVpg5hgqKwayZIt7cmgFg466/qJ5nTp6452lF+Y0g1vMJqRUFjYhBWhKNGHu2isrKJeVWcRYKRSBzlvfMLLYol2fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oxG2Renz; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxG2Renz"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-3074d4102a9so2617185eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781029283; x=1781634083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=omsBmJ7x+9JSipgFVEe37bwtm75uDjA1mG7cR0sEMt0=;
        b=oxG2Renz1mwksXsrGNvbKjkfYlA+kf28GJdPm3umwbmYuqaxeQVuXCRlXiuKxi7Q/8
         oxWD9PgQ3wcPdJEFLFFWdsnwvX6p6ZYkNvpSw811SRhztDwu/7sAzyiQvAvQVQUO4XDJ
         I+NAJEifvB2XQlmx5RS0H1xiN2EKn82rxay/o1vNXDdxkzKA/NPK2IuXTvVCOLjEEzDO
         ye+4V/jvU3qkX1ij0wMLZgAS6z6FRTYyPwvhaFIH8iD3rCrZhP3NMpdlyPrFEE4wHW36
         3SVq7uslKHqw0GmDoOvwAhTE0FWGkICwG2cELWUBh9mmDP9nNCNIokoMJw/lUtIkA9ql
         IObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781029283; x=1781634083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omsBmJ7x+9JSipgFVEe37bwtm75uDjA1mG7cR0sEMt0=;
        b=jGhG7doW57Zy2bYH+kiYTS4/9YLXiEg08qaA0HdVm1bC+U4mo5vEh1pcVOSRCMO21i
         Tlml+ZexAJ2MKrj27OGRY+gzpk3WTcPf3s4viPfQj7z5bx1VUC/DwTcz1k4ie1ZgqP2t
         Mc6UgVzZsFeI8+0GuOakoihNcUi3cm7TjYWsTMH2+weOtCuHSNeT60siQAle/88dEHVQ
         CtO9r2Qb1C3BNsvovUpHAGnQ+d4TMxvSWLcOQ/kn5lnWm/OQoS2i/B2w95rn7PatlHh8
         WXFbqLRuhDVGKOPHhcrhU5Z++RCHXLEFU2lRnaZjM6fzdlio0qsmJzMxiXq0E/Xckktl
         pB+g==
X-Forwarded-Encrypted: i=1; AFNElJ9YHeXypvlctURveUjdi3E661MT/aVJiaS8ECO4EHTBg0e6m1IOnvwwrpDNegWuy+4ZTUx5EzREMLOoacX0m2km@vger.kernel.org
X-Gm-Message-State: AOJu0YzwlLlrcjZNjdZ3rcJCqP22rQYsVgtj1LnwBf9XrT8IdwmwE4bM
	gaA0NVp8igTBzxKnnKVB8jpvt7KLlNvAYsO0juYmvkYzPzyblQLS/keNGi+hreM3fSJAFLLdU+Y
	0tHSmAxVfIA==
X-Received: from dycrt13.prod.google.com ([2002:a05:693c:2d8d:b0:2de:831d:2756])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2216:b0:2ef:8b91:212
 with SMTP id 5a478bee46e88-3077b064168mr14529423eec.14.1781029282633; Tue, 09
 Jun 2026 11:21:22 -0700 (PDT)
Date: Tue,  9 Jun 2026 11:21:06 -0700
In-Reply-To: <20260609182108.975586-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609070732.545416-1-irogers@google.com> <20260609182108.975586-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609182108.975586-6-irogers@google.com>
Subject: [PATCH v3 5/7] perf test: Enhance annotate test coverage and isolate config
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, 
	alexandre.chartre@oracle.com, blakejones@google.com, bpf@vger.kernel.org, 
	costa.shul@redhat.com, dsterba@suse.com, james.clark@linaro.org, 
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark@klomp.org, mingo@redhat.com, 
	mjeanson@efficios.com, nathan@kernel.org, peterz@infradead.org, 
	rong.bao@csmantle.top, serhei@serhei.io, terrelln@fb.com, tglozar@redhat.com, 
	tianyou.li@intel.com, yuzhuo@google.com, zecheng@google.com
Content-Type: text/plain; charset="UTF-8"

Update the annotate.sh shell test to test different disassembler
backends (objdump, llvm, capstone, libasm) utilizing the new
--disassembler command-line option.
Isolate the test script from host environment pollution by exporting
PERF_CONFIG=/dev/null at the start of the script, ensuring it runs
hermetically.

Assisted-by: Antigravity:Google Gemini 3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/annotate.sh | 60 ++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
index 689de58e9238..eae6a46a247b 100755
--- a/tools/perf/tests/shell/annotate.sh
+++ b/tools/perf/tests/shell/annotate.sh
@@ -4,6 +4,8 @@
 
 set -e
 
+export PERF_CONFIG=/dev/null
+
 shelldir=$(dirname "$0")
 
 # shellcheck source=lib/perf_has_symbol.sh
@@ -106,8 +108,66 @@ test_basic() {
   echo "${mode} annotate test [Success]"
 }
 
+test_disassembler() {
+  disassembler=$1
+  feature=$2
+  local ret=0
+
+  if [ -n "${feature}" ]
+  then
+    if ! perf check feature "${feature}" > /dev/null 2>&1
+    then
+      echo "Skip test for ${disassembler} (feature ${feature} not supported)"
+      return 0
+    fi
+  fi
+
+  echo "Test annotate with disassembler: ${disassembler}"
+
+  perf annotate --no-demangle -i "${perfdata}" --stdio \
+    --percent-limit 10 --disassembler "${disassembler}" \
+    2> /dev/null > "${perfout}" || ret=$?
+
+  if [ "${ret}" -ne 0 ]
+  then
+    echo "annotate with ${disassembler} [Failed: perf annotate error]"
+    err=1
+    return 0
+  fi
+
+  # check if it has the target symbol
+  if ! grep -q "${testsym}" "${perfout}"
+  then
+    echo "annotate with ${disassembler} [Failed: missing target symbol]"
+    err=1
+    return 0
+  fi
+
+  # check if it has the disassembly lines
+  if ! grep -q "${disasm_regex}" "${perfout}"
+  then
+    echo "annotate with ${disassembler} [Failed: missing disasm output]"
+    err=1
+    return 0
+  fi
+
+  echo "annotate with ${disassembler} [Success]"
+  return 0
+}
+
 test_basic Basic
 test_basic Pipe
 
+# Restore perfdata to a regular format for disassembler tests
+perf record -o "${perfdata}" ${testprog} > /dev/null 2>&1
+
+if [ "${err}" -eq 0 ]
+then
+  test_disassembler "objdump" ""
+  test_disassembler "llvm" "libLLVM"
+  test_disassembler "capstone" "libcapstone"
+  test_disassembler "libasm" "libasm"
+fi
+
 cleanup
 exit $err
-- 
2.54.0.1099.g489fc7bff1-goog

