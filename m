Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BB91E89C;
	Tue,  4 Mar 2025 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090540; cv=none; b=Z+xyEh0xUzrt5rfthuOD83/8H9ESXlDq44RGfs5+eCJ6KZd1Jr9h+nZ4C9xIK9a5OXlH6W0JVsc9hnl7kzWD+Woue/5cPqy5pyepJk/6BFKAePuMS4zPwxMChdlTGPhD62VSo+oxIjfd5PbvNdjyaQhtwqM1Y1rQV5y/nwB9+N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090540; c=relaxed/simple;
	bh=PW8zBhlN8EsNmWQ9sP1c71GswroVskXskZ9zdIzQf0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TclLh77Z5KRIVCUVJN40+DKIo5vnzoABzsFHpeaw/zfP+WWH4n+boFIcfqVqI687mO6OI9rlpv+GM1xRDfCuRHLscybO/9pLni1zEwKrUDRR3uCZqpm93cQtAXbsD8tw6APjEaYyc+wdGV8CjY1/xPveTA3yid0RinRp6yCOad4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=JdSLvqSW; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="JdSLvqSW"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 524CEnAi030565
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 4 Mar 2025 13:14:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1741090489; bh=PW8zBhlN8EsNmWQ9sP1c71GswroVskXskZ9zdIzQf0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JdSLvqSWvARzqbVf5RnbVOlURJxtj20iHq1BfrTc+VXsO1gk9HwgYfYH8YDxfUgO0
	 GpMYwtHrTmlKAoS3abdTTMUcDTKDm2ZPdq0wyUn2q1TLbPU2Mj5YQedUkaukkvdelw
	 wSBpg2QGt8diXTNjVjEyEJJ9VqQcgTZar7kRcHN4=
From: Dirk Gouders <dirk@gouders.net>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>
Subject: [PATCH 1/1] perf/Documentation: disable hyphenation for references in manpages
Date: Tue,  4 Mar 2025 13:12:04 +0100
Message-ID: <20250304121347.19861-2-dirk@gouders.net>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250304121347.19861-1-dirk@gouders.net>
References: <20250304121347.19861-1-dirk@gouders.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the generated manual pages, hyphenation is turned off, globally,
but for some unknown reason, that doesn't work for references to other
manual pages e.g. in the SEE ALSO sections.

Fix this by customizing some docbook templates
(citerefentry -> do-citerefentry -> bold) so that hyphenation for the
generated references is explicitely turned off like this:

        \fBperf-stat\fR(1) -> \fB\%perf-stat\fR(1)

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 tools/perf/Documentation/manpage-base.xsl | 44 +++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/Documentation/manpage-base.xsl b/tools/perf/Documentation/manpage-base.xsl
index a264fa616093..0b872a593570 100644
--- a/tools/perf/Documentation/manpage-base.xsl
+++ b/tools/perf/Documentation/manpage-base.xsl
@@ -1,12 +1,56 @@
 <!-- manpage-base.xsl:
      special formatting for manpages rendered from asciidoc+docbook -->
 <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
+                xmlns:exsl="http://exslt.org/common"
 		version="1.0">
 
 <!-- these params silence some output from xmlto -->
 <xsl:param name="man.output.quietly" select="1"/>
 <xsl:param name="refentry.meta.get.quietly" select="1"/>
 
+<!-- template used to produce bold text with hyphenation disabled -->
+<xsl:template name="bold-nh">
+  <xsl:param name="node"/>
+  <xsl:param name="context"/>
+  <xsl:choose>
+    <xsl:when test="not($context[ancestor::title])">
+      <xsl:for-each select="$node/node()">
+        <xsl:text>\fB\%</xsl:text>
+        <xsl:apply-templates select="."/>
+        <xsl:text>\fR</xsl:text>
+      </xsl:for-each>
+    </xsl:when>
+    <xsl:otherwise>
+      <xsl:apply-templates select="$node/node()"/>
+    </xsl:otherwise>
+  </xsl:choose>
+</xsl:template>
+
+<!-- template to produce references with hyphenation disabled -->
+<xsl:template name="do-citerefentry-nh">
+  <xsl:param name="refentrytitle" select="''"/>
+  <xsl:param name="manvolnum" select="''"/>
+  <xsl:variable name="title">
+    <xsl:value-of select="$refentrytitle"/>
+  </xsl:variable>
+  <xsl:call-template name="bold-nh">
+    <xsl:with-param name="node" select="exsl:node-set($title)"/>
+    <xsl:with-param name="context" select="."/>
+  </xsl:call-template>
+  <xsl:text>(</xsl:text>
+  <xsl:value-of select="$manvolnum"/>
+  <xsl:text>)</xsl:text>
+</xsl:template>
+
+<!-- customized citerefentry template to produce references with
+     hyphenation disabled -->
+<xsl:template match="citerefentry">
+  <xsl:call-template name="do-citerefentry-nh">
+    <xsl:with-param name="refentrytitle" select="refentrytitle"/>
+    <xsl:with-param name="manvolnum" select="manvolnum"/>
+  </xsl:call-template>
+</xsl:template>
+
 <!-- convert asciidoc callouts to man page format;
      git.docbook.backslash and git.docbook.dot params
      must be supplied by another XSL file or other means -->
-- 
2.45.3

