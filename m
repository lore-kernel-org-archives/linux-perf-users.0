Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057191;
	b=ADEpO2U9LbXjYWRvvaPspQO8jcxE8OLdBnkBBH7yj3pzxrTaRhUpC1t3sG1l8q1mN43d
	 tAWVDuHKGUESRx0Cd7y8Mf9dHOnStJ6XKTWPIr5/zieZ+VCmv2AmJ5H94TaezXDfjzrOf
	 2lyvX899fQTW8S3tFSmp4SZ+0RbVr2g4Wu9YTWIhvJy7BlDc5/aOhrF0tz2geuft7Yugz
	 DLCeFjYBSjrXKf9AdMlFkeVgLFa8qL+k9AxBGSos/DKKsbdEPOAYKjKVgs3QrYAdhGZ/r
	 I3mvfJG466WV2de/cqswwRSF9QDWfP6K/PVHhUIcgLyeR6Ga6Jq1kdnR7mqahKsQ51Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BemN4KAEIv94JTaM/LB9CfX7xPFFKwFGGLfkDjDGM5Q=;
	b=wu9gWCzgtQQGrJVGAh34HjyhMC2rqbOe+ifQ/ZqEpDtj7bZnpjc/RGEKBVLkuCTLDJze
	 VX+DPWwz1zC7q9ABQnjDjeKELQzQRcU4g6h6vQ/MHX4lRRjL65JUVeOQ3ghboWRYKv7XB
	 KVxibVHJKZ/Z0oDgMXsUBOalULRBt162ycuEiMxW2/Y4P9ZzH8dF4tU1uW7W2lpVQWFip
	 MOA89d2q34xuLCmsyU//jrvTN+mCxokd0uUxmV+5uZoRtOYk9THUeGqFBatjpfQgwDNSS
	 2RRcYAozdnvCWazX5Skik06KZXc1KjXMbLvCR+/PP7182cev7+JHeOiDRaXh8HE2yEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vUwIT1Vg;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FA5606A32A
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 02:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94FA5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vUwIT1Vg
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-381d542bc29so3265918eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 18:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795057190; x=1795661990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BemN4KAEIv94JTaM/LB9CfX7xPFFKwFGGLfkDjDGM5Q=;
        b=vUwIT1VgurTA5PcH58CV+OidjaQlZarrpDkxokT5Dc2FKUvEj1pnfPS32bbDNcWXOI
         iS7TSFfQuJszS1B/dTp2aGKTksWm1ccF7NBWe8lXiANy+kQGZqppOBJQkkvXLqHddlz7
         Z4mCYbXH/JPRElL7Qy5Zlgy3IQABFFNg90T0B9+tmiXAQqRc6Uo8kR2rMXxdHIM4sVLX
         dASfsJFLI2rMl3+D0xOmaQ17kXymY53zTt17yYv2R+gDZUBsekaZ/W+po1ydfdaEYZOb
         5ZeozYdnX+OMDnyYLCSuvB2clE5P4cp87sv7dwEy1QBvFPJMRTa/EarhKESF/D/jnC0I
         b9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795057190; x=1795661990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BemN4KAEIv94JTaM/LB9CfX7xPFFKwFGGLfkDjDGM5Q=;
        b=ozsD8lsDk3Z3EwkawRI0RBoccAjbe2+dfACjGlA8615tYpVA9vjj5bOy7mT9V+qlr4
         PWEmPLV6HWbFHzznyT5DAhxV3jisuSaDbQ77QQplQGprN2DRnBH2NDLIn56dPP1Augeb
         xIAvpVqgiEHDlkcnCJfYLDkTnUsr8piwCn53HgxrdB8CbRTvJ/ZJgNRzOvz3u7PchCur
         phXXE0UNLMdlF9yqb7TiaWSsOqABrAPYTBvH6FAPBqTwKvv0foRkC5eJ72PvgTiViJ0D
         Ysg/BGqQOlJTtOL33Ih8NBZUBJJ2hqL7PetuOiAjjdFBL0svBrMXw1+fnx/ja7LeuZPI
         XTTA==
X-Forwarded-Encrypted: i=1; AL+hErFSd31WJq0Yk4Z1oAvmUpZnCNmVoNHurmGVWpLoZOIWDVum0a7n2JwrqypzCNOWD+mIz+cLQbRQV1t0osFITCBK@vger.kernel.org
X-Gm-Message-State: APuU4Z94ZxrW30BaHfyMB/2BIs3DtYKg4Ji8CB9so4PuJ0SYjQOETrBg
	c26clvKe0dZ4rlLmJeThRiTGuyulGMuN+VJGY6FxTjJUmJrHJ1JdcF/1
X-Gm-Gg: AZFdTZdEqaS+c6YwP2GlNeTQUxo3V0xoqdd6D4cEMolpV4O1IsVGS75gzuF/+s0NPGv
	VfBt/tff+USEfeaQksr2TpXQGyoz66SIVI1vWAb7W65LDnc3kajVuZOeoFukLKv4XfV4wgoK1ZT
	H6LlmrPTlV//1ExOJwVsvOck3UYtpKckKCTlJHU1h56vdtqHb/Pbl2YotiWpJAv3FukSZKnlGRg
	6feCe7CFUwRsg/b0NM/9j8iQg7lYTmKC9F6DqIA0BnN4/8YjONgTOG+C02sIm5TqZm3rql2wGhF
	vhsiIqaZ8XU+B3D/tNxn7W4VNH+9XfaTPfZh1NC5LEkMeaqnllLNY0ng4X7oDIszPi1onqX/lfI
	EI/dKIIXn05H/ZhtcT7GucQVW5XDrm6A9ohrbW+Arj+2rw9UZadm+lFJZu1DBew9U52Pz1c5JKG
	1SaXWIowNOLkQYeF6/VPV4XMy01aw3tz7Tzgk1a7IdfoTvU7Kj8w55oMkXbJAfVvjDwMGFnMDSf
	pla3GKUvS8qtvVEPzPdmHU03QZCCpbSwsxUPqbAE0SmJuCeX+Aa2SfSb/1QacLp2Y9THvKk4RId
	/5waDjZXq1WWnr6HhBYQwnY9Tl+yFq2ZTgpBh6vu+zPCbKC2ncN2+eUVpsbx20ltaaUJ+Dy/+87
	sKg==
X-Received: by 2002:a05:693c:2805:b0:36c:a1ef:f8f7 with SMTP id 5a478bee46e88-3827dd05b5emr4256126eec.4.1795057189615;
        Wed, 18 Nov 2026 18:59:49 -0800 (PST)
Received: from Desktop ([182.161.246.158])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a63059f8sm19658301eec.9.2026.11.18.18.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 18:59:48 -0800 (PST)
From: JunYoung Lee <ljyoung04@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Require kallsyms permission for the .function filter modifier
Date: Thu, 19 Nov 2026 11:59:41 +0900
Message-ID: <20261119025941.87102-1-ljyoung04@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Steven, Masami,

An unprivileged user can locate the kernel image (KASLR bypass) with
PERF_EVENT_IOC_SET_FILTER at the default perf_event_paranoid=2.
parse_pred() accepts "<field>.function == <addr>" only if the address
resolves in kallsyms, and the perf path has no permission check, so the
ioctl result tells whether an address is kernel text. The details and
the fix are in the patch below.

Affected (reproduced as uid 65534, KASLR on), since e6745a4da964 (v6.3):
- mainline 4405c18c95d2 (v7.4-rc3-230)
- stable 6.12.118

Example on mainline: a counting event on ftrace:print (field "ip") and
561 probes return image_start=0xffffffffa1000000 and
image_end=0xffffffffaae30000. These equal _stext and _end in
/proc/kallsyms as read by root; the same user sees zeros there. No
tracefs and no capabilities are needed. Not affected:
perf_event_paranoid > 2, or perf_event_open blocked.

A C reproducer is available privately on request.

Testing of the patch on mainline with KASAN: for an unprivileged user
every .function form now fails with -EINVAL, and ordinary filters still
work. Root keeps .function via perf and tracefs (it is refused under
kptr_restrict=2, like kallsyms values). ftrace selftests test.d/filter
pass 4/4. checkpatch --strict and W=1 are clean. A 6.12.y backport is
available.

A separate issue seen while testing: as root, a .function filter on the
perf function event (ftrace:function) crashes the kernel with a NULL
dereference in ftrace_function_set_filter_pred(), because pred->regex
is not set on the .function path. It needs CAP_PERFMON. I can send
details if useful.

Found with AI-assisted code analysis. All results come from test runs.

Thanks,
JunYoung Lee

-- >8 --
"<field>.function == <operand>" resolves the operand to a kernel symbol
range. parse_pred() accepts the predicate only if
kallsyms_lookup_size_offset() succeeds, so the result of setting the
filter tells whether an address lies inside the kernel image (or a
module).

perf_event_open() allows any user to open a tracepoint event for
counting at the default perf_event_paranoid=2, and
PERF_EVENT_IOC_SET_FILTER passes the string to the same parser without
a permission check. An unprivileged user can therefore probe addresses
one ioctl at a time and recover _stext and _end exactly (about 560
ioctls on x86-64, under two seconds), while /proc/kallsyms shows that
user zeros.

Apply the rule that /proc/kallsyms uses, kallsyms_show_value() on the
current credentials, before the operand is looked at, so both the
numeric and the symbol name form are refused to callers who may not
see kernel addresses. Root and CAP_SYSLOG keep the modifier under the
default kptr_restrict. With kptr_restrict=2 it is refused to everyone,
the same as kallsyms values are hidden from everyone.

Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to function names")
Cc: stable@vger.kernel.org
Signed-off-by: JunYoung Lee <ljyoung04@gmail.com>
---
 kernel/trace/trace_events_filter.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c10951bcfc5f..895ef6d7652a 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -118,6 +118,7 @@ struct filter_pred {
 	C(IP_FIELD_ONLY,	"Only 'ip' field is supported for function trace"), \
 	C(INVALID_VALUE,	"Invalid value (did you forget quotes)?"), \
 	C(NO_FUNCTION,		"Function not found"),			\
+	C(FUNCTION_PERM,	"Not permitted to filter on kernel addresses"), \
 	C(GLOB_WITHIN,		"'within' filter cannot take glob expressions"), \
 	C(ERRNO,		"Error"),				\
 	C(NO_FILTER,		"No filter found")
@@ -1743,6 +1744,16 @@ static int parse_pred(const char *str, void *data,
 	pred->op = op;
 
 	if (function) {
+		/*
+		 * Whether the operand is accepted, and which events then
+		 * match, tells where kernel text is. perf lets unprivileged
+		 * users set filters, so apply the /proc/kallsyms rule.
+		 */
+		if (!kallsyms_show_value(current_cred())) {
+			parse_error(pe, FILT_ERR_FUNCTION_PERM, pos + i);
+			goto err_free;
+		}
+
 		/* The field must be the same size as long */
 		if (field->size != sizeof(long)) {
 			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
