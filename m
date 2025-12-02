Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6EF2C324F
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697895; cv=none; b=RGBVdUFMIbkY++EHmv1CA17PO3NKMCKYBUna/CorSscsodhmzVgQZb5lQYYyTCMXsL+WgGKyL07a37lP9k3RyZWJ5i7AtCfQwFTP3U6V0LTfgd0CL0IRww/EsOoVkez+MdidcRk1HAT/gSY90VF/DiUFKAoi+0YUVGSk0j9ukho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697895; c=relaxed/simple;
	bh=dSBO8zU/g3mPU06tLqLyC/GIRciUN2rdNIopz+Gc6Yc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=J9I34L1khitNPqKMhsEXJcR5Wk/VQeF5qkShz0/UC5X6lRqv3lu/3vjVz/dNu2u0K7rAkCwpS7dUNp4uTR4salACqtyJnOkmne4QpT5lq9cl0CXeuZwJqQk7xpg11GjqbHPlqsknDTv5HIRaT39ffsaiyvvDfIYP7lTHJnW8kic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1OAJf23P; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1OAJf23P"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b969f3f5c13so5852018a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697893; x=1765302693; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SWXwpn1Bdj0vV31tEseVJuMADmOQ9ZqTGDxa2hpD15M=;
        b=1OAJf23PbdjymJ7Om/gGq34Dn4HLnrL/zGl/K8mxqiGXKT1PKKZ0OF2PSn+bnwQrfV
         eGKBGmjjGWwzbwwiNN4tag2llKZNl5tdE6p+kOQaS3HpxTwy70FgHhRh/+icyXTxIgpS
         vElm8XHekwLckcbeF/evxfp8aLHdSPdhK64stFdYHKR6TUyyOLN5zeO6UbbCsuNpDpTF
         b+ilGDPt31YNs1tHAKHnwDRgMqm2bhnr4h/0CCFYgVPxVTFZUMyAJ9QXpuI9yEbeNeTb
         aZVy92nTD2hUs3/EptuRNB+gceaoHvPZUm4PsRpyKczTUPLIRLYnlF4JJ983cdnsO9Uu
         3Mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697893; x=1765302693;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWXwpn1Bdj0vV31tEseVJuMADmOQ9ZqTGDxa2hpD15M=;
        b=va6sQ5D0QQtre+Aj/Sr8p09bQ/aDCcDVn638vmiES2oz6t15rBODDv0fPHICqNXAUP
         brooh8NaM7yUuZG7wM56aDkLtCdugd09LjmQTqtDcGu0t5i39G0LadMn3fCtcSPfXmaS
         //RC8SVbHvdrFg9/p0j34LWTDTNnIALFwMe23BEB3GP7LQxyQNHQS5tgKz3nhviwRVLJ
         +8Qvxyk5E+k0ifyaKzX/cHhfxySBUBVLoLr7FBlOyeK4lUxGvm1Bga3m4CX80/CIzddg
         URGG2Ca/WkIXOI/BjpUhZaT8T5y/kY8dvU6+1f2ej36vVBBMJ9VRivvylgaAXity/1e7
         Ab9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXm3CAk27+wJsTXXgww5+QLv0uvMU4ADLzJ2v5zaKw03wz2jd8CCpEkY6CoMDURnfLmKqduf6zSDe542OsGXFsZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwMwpd1rXF+6ZC4fjekSe6xDG7l/txa+zW9Zfa+Wf+eJW44fTAn
	g83igtG3nt14NCkaBUKODzKRIf1nEclwIZqBLaQyOp4tpVQZYG3igCyQ/t6ngp1ospfyCEbSq+e
	BQSFxjAQ/zg==
X-Google-Smtp-Source: AGHT+IH32DlUfru/jZ3w8kB9n4KPWgbxgG2eL603tXP0Gyqx2n0LHx+3xkx53wh9VOYYN+lxAlTh3U8q7iAJ
X-Received: from dycqv11.prod.google.com ([2002:a05:7300:df4b:b0:2a4:63df:76a5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:800d:b0:2a4:3593:4674
 with SMTP id 5a478bee46e88-2a9415a4876mr15036126eec.16.1764697892776; Tue, 02
 Dec 2025 09:51:32 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:02 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-8-irogers@google.com>
Subject: [PATCH v9 07/48] perf jevents: Support parsing negative exponents
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Support negative exponents when parsing from a json metric string by
making the numbers after the 'e' optional in the 'Event' insertion fix
up.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/pmu-events/metric.py      | 2 +-
 tools/perf/pmu-events/metric_test.py | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 847b614d40d5..31eea2f45152 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -573,7 +573,7 @@ def ParsePerfJson(orig: str) -> Expression:
   # a double by the Bison parser
   py = re.sub(r'0Event\(r"[xX]([0-9a-fA-F]*)"\)', r'Event("0x\1")', py)
   # Convert accidentally converted scientific notation constants back
-  py = re.sub(r'([0-9]+)Event\(r"(e[0-9]+)"\)', r'\1\2', py)
+  py = re.sub(r'([0-9]+)Event\(r"(e[0-9]*)"\)', r'\1\2', py)
   # Convert all the known keywords back from events to just the keyword
   keywords = ['if', 'else', 'min', 'max', 'd_ratio', 'source_count', 'has_event', 'strcmp_cpuid_str']
   for kw in keywords:
diff --git a/tools/perf/pmu-events/metric_test.py b/tools/perf/pmu-events/metric_test.py
index ee22ff43ddd7..8acfe4652b55 100755
--- a/tools/perf/pmu-events/metric_test.py
+++ b/tools/perf/pmu-events/metric_test.py
@@ -61,6 +61,10 @@ class TestMetricExpressions(unittest.TestCase):
     after = before
     self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
 
+    before = r'a + 3e-12 + b'
+    after = before
+    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
+
   def test_IfElseTests(self):
     # if-else needs rewriting to Select and back.
     before = r'Event1 if #smt_on else Event2'
-- 
2.52.0.158.g65b55ccf14-goog

