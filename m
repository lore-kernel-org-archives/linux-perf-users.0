Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825976;
	b=c55p6XflSvTez+xjjXRdwEqRbXORS0N9a/TxoE16YOAgH5eVJEjWxebznh/Qz7eeGkrn
	 U9niUmW/+2l8KD1xeV+OadV9nbZSQYyImn7FK3sXFI1/u/2o/qR7XepYaSw+OC6fQU3Nv
	 KbI+YqtDf/PminS/Wotph62nU4sEEZGoNy1GAUUH1TyGeaPzH+hoUrKeKgIEBJwJXpHpz
	 v314cGhTP1gAoiw8SwbMza9bh0KembgO9BcqcgHhrQADaxmtiWwNwhK1Djiddqt5rgJR9
	 +hnk52GTLOWpo0A7iAkJ5USuiw6DMFBz5V0YDL20Xf+2O6qQylAffRvCygFjMLRdawg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=t2QoGiIe6qh+xXGRXPEuyCoTeHTjKPAeQiniSi4k+CI=;
	b=YLD7plMQUP8mQMa3umK8bDBHtcpzDDYfWageFDFxJJn3cpwDtjGHgQ6FmD/qnvza8UYX
	 4oTz2Ix2rZjot1klN33vNaF56Zz5apaRAG72CTw+qhWFiw4WHPoeAz8yI6Bx4G8BzZaJJ
	 aesPH1TnR1EXDLA0SLxQHXJEi7QOLLmfTyfK9s3xEgxnpJXSJfHhyORjUWt0p2X1XNo7E
	 Qc2TVnVVrB8CRdjtbiamblZuT83ybtHXyIk+/eZxZCMlVlTi/QZDkLNoDwJbBVjevNSLQ
	 QIP/XvtSD2vEf1QX7/qvQ8d5OoKu+pMRyo4TSmdttX7mOJ9hq06R3TtJzjz1ckYwyjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nDAM62lI;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4744609ED55
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 20:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4744609ED55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nDAM62lI
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc7e92f36f9so947005a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 12:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793825975; x=1794430775; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t2QoGiIe6qh+xXGRXPEuyCoTeHTjKPAeQiniSi4k+CI=;
        b=nDAM62lIQ8NbNsJL+tf2Dzwhvn4xbKxKPf2dw2UNumEgfXSxIIe8WLKUYsWiByH8lO
         6euqFRYZs/8VBDb9AZhjZFYshBs4ZR8gCl41nWKPRcLft4PX9qZaoNhmWFTxAoUap6St
         zNyjUMTCy2pJmBEjxdTDp9LmP1BJEaux8K3OkFFTZMTtADrwuru7TOn5gYdabINQBd6I
         hhpSeF6HbXGrjJRymc4Ze7o4nW0TKKHvRhpmkc4PC9ULG0Z9YqhlAk6Vm6/W/lipBj44
         tXbjuKmUjsrYGVFiHqIGKdzfi/vPb3GDw9oOVPYYNeMWxe5qOzA18q57LRZvDYDibIoc
         UMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825975; x=1794430775;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t2QoGiIe6qh+xXGRXPEuyCoTeHTjKPAeQiniSi4k+CI=;
        b=Ev/9qQyg6H4wQsUnNSuVZhmX0KuvMOsit7isQ219ZD6JmDMMIlf3Vj5lPOzGFdnEJH
         xdedNYFUnEezwKHce7OMZ8ywRDde3E0OVk3oRbJ8tjUkFya/lovlcBcgn2XGPqAO6Rri
         E5o4AUrdggQOtaldcoFp23PW9l8wtSALPgbRgszkwdMhIbSCAI+/aOMmCwJX2TsMXC+J
         OenVUIgAyakiChtWAzAmaETuEPrCWlO2w545YsfTk9tqlezpShDW5Bd2akN+OIc7naCC
         dzF49D5rlkASn31+jRbk3b7rrburjyzq3eC8yWWoEqGRhWU9fRZlLi0xGKz3ltU9vStJ
         ko4Q==
X-Forwarded-Encrypted: i=1; AKwUvBxKT6I5+jW4Jx0JadXkGlqrrgh3A3FpbeCQLmWHo6LywPMBBB0X+V1puEM/oF6KJyga6GgTrUSSLuwXVnTcW6/f@vger.kernel.org
X-Gm-Message-State: APuU4Z+H6cXkdm4KQHXUUV55F6DIPd5SC5y1GLB1VnMgSYp5KiSM8SSk
	y5EUT2w4rbD5npBRuEJAapwtnoM4O8TliAeBip08Sc5m6CJUwXhoW+QNTrpZ0nVNHF7M1/DoFlI
	HhCZefcfQtQ==
X-Received: from pldr21.prod.google.com ([2002:a17:903:4115:b0:2e9:b079:3771])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e749:b0:2ed:2305:5244
 with SMTP id d9443c01a7336-2ed23056137mr7115475ad.46.1793825974846; Wed, 04
 Nov 2026 12:59:34 -0800 (PST)
Date: Wed,  4 Nov 2026 12:58:58 -0800
In-Reply-To: <20261104205909.2078411-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104205909.2078411-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261104205909.2078411-9-irogers@google.com>
Subject: [PATCH v9 08/19] perf dsos: Skip BPF and OOL DSOs in dsos__find_kernel_dso()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

In machine__process_ksymbol_register(), set the binary type of non-OOL
ksymbol DSOs to DSO_BINARY_TYPE__BPF_IMAGE (which
machine__process_bpf_event_load() upgrades to
DSO_BINARY_TYPE__BPF_PROG_INFO on PERF_BPF_EVENT_PROG_LOAD), and update
dsos__find_kernel_dso_cb() to skip DSO_BINARY_TYPE__BPF_PROG_INFO,
DSO_BINARY_TYPE__BPF_IMAGE, and DSO_BINARY_TYPE__OOL so that
dsos__find_kernel_dso() does not match ksymbol DSOs in machine->dsos.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c    | 3 +++
 tools/perf/util/machine.c | 9 ++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 1574c8885d78..fbbf98c4ccae 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -475,6 +475,9 @@ static int dsos__find_kernel_dso_cb(struct dso *dso, void *data)
 	 * is_kernel_module() treats it as a kernel cpumode.
 	 */
 	if (!dso__kernel(dso) ||
+	    dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO ||
+	    dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE ||
+	    dso__binary_type(dso) == DSO_BINARY_TYPE__OOL ||
 	    is_kernel_module(dso__long_name(dso), PERF_RECORD_MISC_CPUMODE_UNKNOWN))
 		return 0;
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 076d167380f2..b958c6935a56 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -769,6 +769,10 @@ static int machine__process_ksymbol_register(struct machine *machine,
 			dso__set_binary_type(dso, DSO_BINARY_TYPE__OOL);
 			dso__data(dso)->file_size = event->ksymbol.len;
 			dso__set_loaded(dso);
+		} else {
+			dso__set_binary_type(dso, DSO_BINARY_TYPE__BPF_IMAGE);
+			if (is_bpf_image(event->ksymbol.name))
+				dso__set_long_name(dso, "", false);
 		}
 
 		map__set_start(map, event->ksymbol.addr);
@@ -780,11 +784,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		}
 
 		dso__set_loaded(dso);
-
-		if (is_bpf_image(event->ksymbol.name)) {
-			dso__set_binary_type(dso, DSO_BINARY_TYPE__BPF_IMAGE);
-			dso__set_long_name(dso, "", false);
-		}
 	} else {
 		dso = dso__get(map__dso(map));
 	}
-- 
2.56.0.455.g6c5a503b38-goog

