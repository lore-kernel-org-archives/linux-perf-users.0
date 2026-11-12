Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514744;
	b=DiDDbO11jbOvPl+u/+cWCpIr5u6EkEYJ1zsp55gn8ppr2d3g5oGaqSQ+kY/H5ox8KkuR
	 +QDDqhl9t4hmUcVFBSnHnWBKoRXopSLkCFkAG4yfZZHyGbLA8jyv8PmuJNUWbG2dJfR10
	 QRRbqO9l53qEw0TLGUC6RPX8QaNmw3v6nUI9XkQeEsPSUNVymLdo5/SSw94CR+e06Q3+l
	 ChfE9sdHiH/E7fipR3NkpI6IAPSL0UUXTktnOF4yrzXiOtOX4caIx/SXH2Tdymj4O8RWF
	 b41ezvUEVHGc+SJPNzRN3qYxLybyfh2ax4zB60rxCCXN6BXM+0bTXwdQ0LLN5vfUw3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514744;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Pd/Fz0NSov9VvgLaDQPolSMBTkMy373wbjRwbPkuO9c=;
	b=btabDaPZAzwgLhyRSkjS1ffud4KVQNsg1P87l06FCcGsAaT91Pcb1puFPGgogIqXFxmG
	 c5z8WXPkL5yHM0mZzs/pWdIRYn1b68Bahk9KaCOkuTtDVEyoo9csA8MMyWBQDe5lbVCM+
	 b6x6qy9HI62EjwLOgEZZgC0NP3Yv4H/MYwFMwBOUgGIY5Y5H6L+L1yfW821dyPhynObEk
	 arU4/HxS4EGVdNy73UDwQIQPor/eQpwd+xbGv8qqKkHzqaBIO6aSZYlTjWrfn5IJDLu+5
	 moX0eyGr4GKjPJwE5zjd+P9z5HNN8kQB1JCDcWOLQCwOj2GT7IZ63K/kqcGc4386t7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=serhei.io;
	spf=pass smtp.mailfrom=serhei.io;
	dkim=pass header.d=serhei.io header.i=@serhei.io header.a=rsa-sha256 header.s=fm3 header.b=JOHduZNj;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fGO0UrtO;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D075606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 20:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D075606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=serhei.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=serhei.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=serhei.io header.i=@serhei.io header.a=rsa-sha256 header.s=fm3 header.b=JOHduZNj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fGO0UrtO
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A22BA1400497
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 15:19:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 12 Nov 2026 15:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serhei.io; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1794514742; x=1794601142; bh=Pd
	/Fz0NSov9VvgLaDQPolSMBTkMy373wbjRwbPkuO9c=; b=JOHduZNjrkq/QS6mMO
	zAk1uIWZbV7Y92Iy/FRB6YX2+5TVDTymP34LKlSCSL9S+k7NuK23YSTyEW3RVh2O
	d9U2oVJsaJeEaC6B4YNdmmQvrPlz/kOxWoblhCrco6esXqMdPi37RUG+ZcWenMTC
	DWvtwGxYdNu7sXQhXzZftOhxmTsBOe1DSba8V+3KhkkeqKgSQVB79K0kHpB1AAmK
	TmBFzsIbaG12PmezvzG39P5wDdwDnVc+mVsCu4D9Si5S+q25Lo0sns2IJYc9Vhqj
	uwqbSskZlWvcMxg3SoKJRP6Or/r5eq2SINhCDZq3RWPI0/u3bQihLeGE+PAiit8n
	Qdyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1794514742; x=1794601142; bh=Pd/Fz0NSov9VvgLaDQPolSMBTkMy
	373wbjRwbPkuO9c=; b=fGO0UrtOl9ztH2p1t+cxSj6SiggfL63pUtvAgcArm8qF
	KBGAMLhJjh9IK2/ulZBy0nlCWdLnKCHPBgG/Hp8xxnh0bNKoH8jrYQ/9itxIbZqK
	dmYe35gwhnCTKWT2Nqu1ZGezK7sL9UMpjVv981tKeCot/N454HKaCj8n58Lz3CQa
	l097ys+zFjzR6bp/Lt+pIFxyVZHrzOO7gn6bze6GOqRMiMzCDI8jXkOZLI9s0dh2
	LXLCWeR8Qkn6AITqfMDaKYZZvVb2+8y7KCMJ1l9rEFK6k3mwcfVA91ZiUJNVuAD5
	N6BlGeG6FqkLDfLD3yBgVIshNhVn0d+7twRP7Dqw0Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=serhei.io a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794514742; d=serhei.io;
	mf=PHNlcmhlaUBzZXJoZWkuaW8+;
	rt=PGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:b6omYaGmskOhtMO4m/KIuG1AvayqSI7QnfyH71De1smpZfB
	i0P9zSqBf02vP2o4a516L9TAYOyPgDHNR05FYYGzEQbJ0CfEEm3b1eyHMSAa2yMa
	1h2j31wlonvxtgaUvNjwgmBPf+guXCAKMxaBGltECUivrKix8ymEaIcyxacbCLvB
	fbV8cbysZQ8kIOHYxHLkqrDAnVZjOp9PLLV3ON2AiKmQ0K5DpUyxDfB/jbY73RdI
	cHHFeQQaozpYOnFnT9p1Kxtgof0UuQ5b/sHkJvFl+V+yWnw8+awQDM8gaTqqNwo5
	UQNkxspSXWas5bTau0FpY0AUQjJ01nOvYO3t+UA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:YDtsX0n6DK0q3Y4cpmr5gSLJux7gIoiB2mvugyJ2Slo=:RpmM1chiChDqBEHS9lHvJQUrOiOWom1tibzj6zesxvo=;
X-ME-Sender: <xms:Nh_2aiNiB4BYVafKfF1HyYhgZBvveyU1Gedcr4cGN52F1D82OTBjmQ>
    <xme:Nh_2avPADFpRXHfj1UzNuNNpRrP2OCh7PmDlibVzzYPK12SrvkvpVPZyJWFOmWKvK
    z0ORJiEAUL48dI6PVkZBFJiLgpD_R0KQVUQUdaIS2wgdGp4P9j1PMM>
X-ME-Received: <xmr:Nh_2aim9Gl57DewAEvrwlzXBNd-0grMAnE31wAzqCy6MXJ1UhPdJLoGAfFBEJ46gTx8ekUpm_LAo8QW6l1siLM27OoA>
X-ME-Proxy-Cause: dmFkZTEdJ2UiuK6WZYRL7YvZ1g44i1kvZqB7K/kQ3WpKe0d7p9FtoACs+sGhG1VOXl7LxM
    xVVZqvUaO+RuKdJN6qW5cKxwJO4HKk478+z+L/V8BfONQGIrg9L3nn8eZTt7xWXKrkrfV0
    tAwCSLO+v+5S5DWhUboQKYNVzgLDudGw0dEFm0M06SGT2fHqesE9AoGFug8zd/UFeOXkdG
    p+QmISgVjYGfLdBSup/fUfJshSF37XvaRGBSPNN4HEyrAO4pvZUK/3sMXHDrG8qvWHDCaj
    HXq6d3vCgjdKfZsIgxHfk/buEEKd19fNgZATKnuCDlgWCnLLIBcSyNwaIJKw58ZREfMAU4
    VK1UVjePUEXq1Lhlw0P9L1jWQ7HPIHXKurUlIwYgJszD2X3YJ0/3ARarR8fFUhIAlxzcAq
    EdwSKHx1Jxyo0EZwSJVj7G0YVchZa4p2oYLgUiBQ8roevKO9v57DewuJS/5KVB/yAOtNzT
    5g5bBQbxBLA42zvd4KFRSEd+0WqP35Ri7psRPDQzh0eZ1yw3Fb+gMjZugIj9s83LGUGW3a
    5AzgTmgYpl1eQAFonoZof089ygu/mlgFD7HgalNQhvGFS6lGffgq/Cynm5V8jpQNfyS0gn
    I5BUcG+So0x8q4UwuLNDrTHmXKDAqAKG63U3VnWEgyF3yMMuO8j6grS1ogdg
X-ME-Proxy: <xmx:Nh_2alszBv7f45auLUpZX9obeCnOqKJlGixAPA1HVmxABj1uO7Q1XQ>
    <xmx:Nh_2atq6dswOg4zhRJ8OYEqjVO__X9F3s_u2H9yFIn8gaBWH4-qoCA>
    <xmx:Nh_2arfVlsTdiLTf2rOKWpBq0fQxxUvsLzdqrC0v41BrO0i0sXTa8w>
    <xmx:Nh_2almiQLeFVaB1efvkQq1eRqxv6xcHdmCGCcsg-O69xuxy3cHIeA>
    <xmx:Nh_2amXmYnhiTof1pfQL-jSOmLyhZIvoH566olPJD1-btxr_t1y74s4r>
Feedback-ID: i572946fc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 15:19:01 -0500 (EST)
From: Serhei Makarov <serhei@serhei.io>
To: acme@kernel.org,
	irogers@google.com,
	namhyung@kernel.org,
	james.clark@linaro.org
Cc: jolsa@kernel.org,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	serhei@serhei.io
Subject: [PATCH v2 1/2] perf inject: Support piped data with --convert-callchain
Date: Thu, 12 Nov 2026 15:18:32 -0500
Message-ID: <20261112201833.78630-1-serhei@serhei.io>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When profiling applications without framepointers or non-framepointer
distros, it's helpful to pipe stack sample data directly to perf
inject --convert-callchain, e.g.:

perf record -F 999 --call-graph dwarf -o - -- myapp \
  | perf inject --convert-callchain -i - -o perf.data

This piped setup doesn't store stack samples on disk, removing a major
performance bottleneck for DWARF stack unwinding as noted in [1].

To support piped output, write a modified copy of the event attributes
in perf_event__repipe_attr. This gets around the inability to modify
event attribute records in-place after they are written to the pipe.

[1]: https://rwmj.wordpress.com/2023/02/14/frame-pointers-vs-dwarf-my-verdict/
> The first most obvious thing is that even with the smallest stack
> data collection, DWARF’s perf.data is over 10 times larger, and it
> balloons even larger once you start to collect more reasonable stack
> sizes. For a single minute of data collection, collecting 10s of
> gigabytes of data is not very practical even on high end machines, and
> continuous performance analysis would be impossible at these data
> rates.

Signed-off-by: Serhei Makarov <serhei@serhei.io>

---

v2 changes)
 * Rebased onto perf-tools-next/perf-tools-next which includes the
 existing size-calculation fix (cf Ian Rogers, commit daac18e7c42c).
---
 tools/perf/builtin-inject.c | 68 +++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index ce7562fc788c..9fd02a6f5849 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -229,6 +229,7 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
 				   union perf_event *event,
 				   struct evlist **pevlist)
 {
+	union perf_event *event0;
 	struct perf_inject *inject = container_of(tool, struct perf_inject,
 						  tool);
 	struct perf_event_attr attr;
@@ -258,6 +259,25 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
 		goto out;
 	}
 
+	if (inject->convert_callchain) {
+		/* Copy event to repipe with corrected final attributes,
+		   without confusing downstream users of pevlist: */
+		event0 = event;
+		event = (void *)inject->event_copy;
+		if (event == NULL) {
+			inject->event_copy = malloc(PERF_SAMPLE_MAX_SIZE);
+			if (!inject->event_copy)
+				return -ENOMEM;
+			event = (void *)inject->event_copy;
+		}
+		memcpy(event, event0, event0->header.size);
+
+		event->attr.attr.sample_type &= ~(PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER);
+		event->attr.attr.sample_regs_user = 0;
+		event->attr.attr.sample_stack_user = 0;
+		event->attr.attr.exclude_callchain_user = 0;
+	}
+
 	if (!inject->itrace_synth_opts.set) {
 		ret = perf_event__repipe_synth(tool, event);
 		goto out;
@@ -519,6 +539,18 @@ static int perf_event__repipe_sample(const struct perf_tool *tool,
 	return perf_event__repipe_synth(tool, event);
 }
 
+static bool evsel__has_dwarf_callchain(struct evsel *evsel)
+{
+	struct perf_event_attr *attr = &evsel->core.attr;
+	const u64 dwarf_callchain_flags =
+		PERF_SAMPLE_STACK_USER | PERF_SAMPLE_REGS_USER | PERF_SAMPLE_CALLCHAIN;
+
+	if (!attr->exclude_callchain_user)
+		return false;
+
+	return (attr->sample_type & dwarf_callchain_flags) == dwarf_callchain_flags;
+}
+
 static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
 						union perf_event *event,
 						struct perf_sample *sample,
@@ -526,7 +558,7 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
 	struct evsel *evsel = sample->evsel;
-	struct callchain_cursor *cursor = get_tls_callchain_cursor();
+	struct callchain_cursor *cursor;
 	union perf_event *event_copy = (void *)inject->event_copy;
 	struct callchain_cursor_node *node;
 	struct thread *thread;
@@ -535,6 +567,10 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
 	u64 i, k;
 	int ret;
 
+	if (!evsel__has_dwarf_callchain(evsel))
+		return perf_event__repipe(tool, event, sample, machine);
+	cursor = get_tls_callchain_cursor();
+
 	if (event_copy == NULL) {
 		inject->event_copy = malloc(PERF_SAMPLE_MAX_SIZE);
 		if (!inject->event_copy)
@@ -2650,18 +2686,6 @@ static int __cmd_inject(struct perf_inject *inject)
 	return ret;
 }
 
-static bool evsel__has_dwarf_callchain(struct evsel *evsel)
-{
-	struct perf_event_attr *attr = &evsel->core.attr;
-	const u64 dwarf_callchain_flags =
-		PERF_SAMPLE_STACK_USER | PERF_SAMPLE_REGS_USER | PERF_SAMPLE_CALLCHAIN;
-
-	if (!attr->exclude_callchain_user)
-		return false;
-
-	return (attr->sample_type & dwarf_callchain_flags) == dwarf_callchain_flags;
-}
-
 int cmd_inject(int argc, const char **argv)
 {
 	struct perf_inject inject = {
@@ -2956,15 +2980,15 @@ int cmd_inject(int argc, const char **argv)
 	if (inject.convert_callchain) {
 		struct evsel *evsel;
 
-		if (inject.output.is_pipe || inject.session->data->is_pipe) {
-			pr_err("--convert-callchain cannot work with pipe\n");
-			goto out_delete;
-		}
-
-		evlist__for_each_entry(inject.session->evlist, evsel) {
-			if (!evsel__has_dwarf_callchain(evsel) && !evsel__is_dummy_event(evsel)) {
-				pr_err("--convert-callchain requires DWARF call graph.\n");
-				goto out_delete;
+		/* For on-disk data, check evlist up-front.
+		   For piped data, evlist is not available yet;
+		   check in perf_event__convert_sample_callchain. */
+		if (!inject.session->data->is_pipe) {
+			evlist__for_each_entry(inject.session->evlist, evsel) {
+				if (!evsel__has_dwarf_callchain(evsel) && !evsel__is_dummy_event(evsel)) {
+					pr_err("--convert-callchain requires DWARF call graph.\n");
+					goto out_delete;
+				}
 			}
 		}
 
-- 
2.56.0

