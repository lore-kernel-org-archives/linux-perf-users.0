Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFD8C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 11:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AA7E61130
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 11:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240868AbhJGLIF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:08:05 -0400
Received: from foss.arm.com ([217.140.110.172]:45870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240919AbhJGLIF (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 07:08:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5587D113E;
        Thu,  7 Oct 2021 04:06:11 -0700 (PDT)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 99DBB3F70D;
        Thu,  7 Oct 2021 04:06:07 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, john.garry@huawei.com, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org
Cc:     Nick.Forrington@arm.com, Andrew.Kilroy@arm.com,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] perf tools: Make the JSON parser more conformant when in strict mode
Date:   Thu,  7 Oct 2021 12:05:41 +0100
Message-Id: <20211007110543.564963-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211007110543.564963-1-james.clark@arm.com>
References: <20211007110543.564963-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Return an error when a trailing comma is found or a new item is
encountered before a comma or an opening brace. This ensures that the
perf json files conform more closely to the spec at https://www.json.org

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/pmu-events/jsmn.c | 42 ++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jsmn.c b/tools/perf/pmu-events/jsmn.c
index 11d1fa18bfa5..8124d2d3ff0c 100644
--- a/tools/perf/pmu-events/jsmn.c
+++ b/tools/perf/pmu-events/jsmn.c
@@ -176,6 +176,14 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
 	jsmnerr_t r;
 	int i;
 	jsmntok_t *token;
+#ifdef JSMN_STRICT
+	/*
+	 * Keeps track of whether a new object/list/primitive is expected. New items are only
+	 * allowed after an opening brace, comma or colon. A closing brace after a comma is not
+	 * valid JSON.
+	 */
+	int expecting_item = 1;
+#endif
 
 	for (; parser->pos < len; parser->pos++) {
 		char c;
@@ -185,6 +193,10 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
 		switch (c) {
 		case '{':
 		case '[':
+#ifdef JSMN_STRICT
+			if (!expecting_item)
+				return JSMN_ERROR_INVAL;
+#endif
 			token = jsmn_alloc_token(parser, tokens, num_tokens);
 			if (token == NULL)
 				return JSMN_ERROR_NOMEM;
@@ -196,6 +208,10 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
 			break;
 		case '}':
 		case ']':
+#ifdef JSMN_STRICT
+			if (expecting_item)
+				return JSMN_ERROR_INVAL;
+#endif
 			type = (c == '}' ? JSMN_OBJECT : JSMN_ARRAY);
 			for (i = parser->toknext - 1; i >= 0; i--) {
 				token = &tokens[i];
@@ -219,6 +235,11 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
 			}
 			break;
 		case '\"':
+#ifdef JSMN_STRICT
+			if (!expecting_item)
+				return JSMN_ERROR_INVAL;
+			expecting_item = 0;
+#endif
 			r = jsmn_parse_string(parser, js, len, tokens,
 					      num_tokens);
 			if (r < 0)
@@ -229,11 +250,15 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
 		case '\t':
 		case '\r':
 		case '\n':
-		case ':':
-		case ',':
 		case ' ':
 			break;
 #ifdef JSMN_STRICT
+		case ':':
+		case ',':
+			if (expecting_item)
+				return JSMN_ERROR_INVAL;
+			expecting_item = 1;
+			break;
 			/*
 			 * In strict mode primitives are:
 			 * numbers and booleans.
@@ -253,6 +278,9 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
 		case 'f':
 		case 'n':
 #else
+		case ':':
+		case ',':
+			break;
 			/*
 			 * In non-strict mode every unquoted value
 			 * is a primitive.
@@ -260,6 +288,12 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
 			/*FALL THROUGH */
 		default:
 #endif
+
+#ifdef JSMN_STRICT
+			if (!expecting_item)
+				return JSMN_ERROR_INVAL;
+			expecting_item = 0;
+#endif
 			r = jsmn_parse_primitive(parser, js, len, tokens,
 						 num_tokens);
 			if (r < 0)
@@ -282,7 +316,11 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
 			return JSMN_ERROR_PART;
 	}
 
+#ifdef JSMN_STRICT
+	return expecting_item ? JSMN_ERROR_INVAL : JSMN_SUCCESS;
+#else
 	return JSMN_SUCCESS;
+#endif
 }
 
 /*
-- 
2.28.0

