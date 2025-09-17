Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3DD26F292
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139094; cv=none; b=p6JIfKjBvbWCyxFc6At5Uj2TPYa7UJkvbqMvn7xWVyPeoD2ghnxrRCQHB3u3qowhjzqWt0sMHr6ZU7ESWmY4i9FhA3nN/bjuZWNYADyxVYjYRO325yzRlFVjRuGC2Oz56KFPiXgTZb4oxJiD9tE2iz/8u1ADEfCRl7WIW07WL6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139094; c=relaxed/simple;
	bh=685j0taKtKunwkJ8HlGLSk+D+ryDsJA6qFtnq5hZIBA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qskgu6QBD9Mh/nOiPmt5NY4ucamnK/v3+sXEEC9rXmid2e1+LRjy5kHWvdNUKjmZnaL2MvR6AQwl7xnNJ5kHvyVeB/v31qS7HCdDqTCr+nGwAZitL7O1igij+RDrZvyAJ0jWMHDONp1svOc2m9czhWzExJzAs8VGBtkWXUZ7FaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hcC3l5rl; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hcC3l5rl"
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-816a52d9a6bso24008985a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 12:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758139092; x=1758743892; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bkIQMBhakJ32peLTS+evkX+NHcKo052jbZJFoM1YbHs=;
        b=hcC3l5rlu2nVKwZ27+kdWVbspa0Pyt8PAaIj8Js3Esa0eWMCipYDesXm4gZMeGSyvn
         n3q8uL9rJfQQQEvRmQGTg5WOrmlZCamc8z05wSeK6hzVZthXNrnHbMHL8GkyMFqIfidw
         QQv4yUFDNT7pAIXjyzofv4Ol9PaDoplyoqC1Bpnoa4oiu93iu5ygbg9UznlvBjNoE7Ps
         7xI5265BI5H7aCMhKv7qw9rlRaA+KrtlbNQ/v0VQvWZT3PO0WyhszVVykA/uhJIuEkvw
         GAjgTGtXWdNDA8GkkRN1k0GNGaVsr55now8FqmODmy3MAYDmcPiXx69T8YHe4+FtrqFz
         pkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139092; x=1758743892;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkIQMBhakJ32peLTS+evkX+NHcKo052jbZJFoM1YbHs=;
        b=K/cf5HjgVpo7s7qKUdU2wqow9wXdeKkfontnUfOPo739jGH6rATOA8Pmi+7y/+6nle
         0b4TvSR5A6SZ9Z9+CeKowrxZCxRzWhhByIU3nVrVLX4motSeSE3tXy+/hHHwOTVdVF1M
         +l+78+4BweJ2P94rVObm19NKAI99o6gwLZY+EgoGcRgAa/4Cg9QX0+YX0yKpQscNeFoZ
         ud2ZYWlgPY8jQB0A8pIXDoz/vYicqWc3igpm5ruvM9EjD3/fgZ9Y70UeteK8W3tTvsCK
         lT9JG5URlwbn0J7tM5tC57OKBWAuef51p0XiFPFGoHeI46VW2cBYZ5VgdtC0aBOhpJws
         eMgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNJSAgpa46Uc55Yzjr2c3TlgrFfNVLr+WRCWU+gA/cbO/MKv3lGH1ykbqU3K/P7H/Lc5944WzlTUXwWwUcgBwF@vger.kernel.org
X-Gm-Message-State: AOJu0YzmyitmAGJyQeYa4eW66lJwT+PIBt3FcVhH7IK9oJ8ykRrYdkSh
	wNWz0iV5QZA6BHZohZHBu/CD/RXQuSL97oGC7bGcisbTHs7lSH7lxKQi595oy2hR+ehmIGGivzp
	BtHahs0BImw==
X-Google-Smtp-Source: AGHT+IFM2EWO+kmcC4eFMQ0HsyVb/F6wpZ2gs7sPIfCCXWLTCD5JSXyqjFL3cGUFyfbblycNjAs7PV7U89aH
X-Received: from qknqj16.prod.google.com ([2002:a05:620a:8810:b0:813:8240:dae])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:390b:b0:829:6dbd:64ce
 with SMTP id af79cd13be357-8310765c285mr394346685a.17.1758139092000; Wed, 17
 Sep 2025 12:58:12 -0700 (PDT)
Date: Wed, 17 Sep 2025 19:57:59 +0000
In-Reply-To: <20250917195808.2514277-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917195808.2514277-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917195808.2514277-2-zecheng@google.com>
Subject: [PATCH v3 01/10] perf annotate: Skip annotating data types to lea instructions
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce a helper function is_address_gen_insn() to check
arch-dependent address generation instructions like lea in x86. Remove
type annotation on these instructions since they are not accessing
memory. It should be counted as `no_mem_ops`.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/annotate.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c9b220d9f924..e2370b7fd599 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2699,6 +2699,19 @@ static bool is_stack_canary(struct arch *arch, struct annotated_op_loc *loc)
 	return false;
 }
 
+/**
+ * Returns true if the instruction has a memory operand without
+ * performing a load/store
+ */
+static bool is_address_gen_insn(struct arch *arch, struct disasm_line *dl)
+{
+	if (arch__is(arch, "x86"))
+		if (!strncmp(dl->ins.name, "lea", 3))
+			return true;
+
+	return false;
+}
+
 static struct disasm_line *
 annotation__prev_asm_line(struct annotation *notes, struct disasm_line *curr)
 {
@@ -2807,6 +2820,12 @@ __hist_entry__get_data_type(struct hist_entry *he, struct arch *arch,
 		return &stackop_type;
 	}
 
+	if (is_address_gen_insn(arch, dl)) {
+		istat->bad++;
+		ann_data_stat.no_mem_ops++;
+		return NO_TYPE;
+	}
+
 	for_each_insn_op_loc(&loc, i, op_loc) {
 		struct data_loc_info dloc = {
 			.arch = arch,
-- 
2.51.0.384.g4c02a37b29-goog

