Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFB8C43216
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 15:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FCCF6101E
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 15:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbhHIPfA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 11:35:00 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47725 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234934AbhHIPeC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 11:34:02 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 07AF45C017C;
        Mon,  9 Aug 2021 11:33:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 09 Aug 2021 11:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
        from:to:cc:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm3; bh=GuQ3t8asJUM3Hiy+Ty+shtYHpK
        tsHUjYSTv9E22Sm5I=; b=u4jLJAnBvr3rnpqpbaA0DRUuM4L7CkEiGWmXpoHIaQ
        rDYdj2g9MkTeWV91i/x9QF9gGJ/ht7a8FULqKPsQOUMtaeBMzbxhnvVxTd4O3eSW
        4Io2+E3jo3xiRM0Yhd30uPS/5wwxSybvA1Gyc8oe6jE0BQfw5AGVZtyXRdt9vyyC
        qzr8GcJlcqfgaldp+91SbkuuvAihQCQgHpkBnLVlgAMVufgBJDnG/eSv5eH/aWly
        W7uErYtz0wZbvqZwHphOCyQn/kg/hkSahNG2gMn0B8h5TmjAc9VCDhN+ztUJ+X/y
        zglLvIwSdDtDI/tObFuhRjNmWYRCRfsZrc8RtoWkaYCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=GuQ3t8
        asJUM3Hiy+Ty+shtYHpKtsHUjYSTv9E22Sm5I=; b=dBKbkEfFJSMrbqKQG0x1Mc
        NZyMSUTGwdvXa2eb6P+TMQDpzjidi++mMUrNGOiPEJ+M6C+sy0wa2OG9pbwF4CWx
        /0p2kKr7UZWtVqPUSlrmJBBCb1rjfM2egXBaMAUKBj+ApFQhBr7jOBlAhk3bpf04
        B+M/WS/ttQkqMWEJ2jpcUI60dcjTh1g/0ugnNjjnklxpxRrBJyMfNbOpSpsLWPyU
        KBzxgFyyow1SxfIF+NHpRBMiMFEgjZm+08+/n6txLPwiwG5clpTJyVCAEMO0FHsO
        Gm2z40iOhTnDSnU7OeKtkOoBiVCvBiSr6E45I8kF8+KlnLbOYJaMHgKEbe+DNzNA
        ==
X-ME-Sender: <xms:0koRYeUIjXEOzXHfr5xfHX3NZIubGbVuWHQHykOZkVQCV3pcaLcFMg>
    <xme:0koRYamjHCDHDZMZF98krujM4yrqqi-qmeJosuVs9LHPiennv3PV3P_lIQaO4hMKx
    C_drpVJMCCYKzqlww>
X-ME-Received: <xmr:0koRYSbdZ8zokm2BF0sKv5aT69YEg4krbjkXmAgshf9-ZwwiUN4_W7_COY9itk6IcJe5n6CwzgU6zLF5VWxsWQmJ1TTtjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeejgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeetlhihshhsrgcu
    tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpedtleegvd
    etfeehuddthfeuheefvedvtedtgfevkeetgefftdetleevjefhleevgeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehqhihlihhsshesvghvvg
    drqhihlhhishhsrdhnvght
X-ME-Proxy: <xmx:0koRYVW51HDgLFES2d4wfoLShb8SrirBvrpihP1Hvjo6KMBKSxd10Q>
    <xmx:0koRYYkLtfXArof-yJNpRXd3bEKojMMS282qZJbX8srXr_aFgKcb1w>
    <xmx:0koRYaebpTfO9we8X3oLfxRrIMc-5zIf-qaKCqPnyPWdbaW_XZCQ-g>
    <xmx:00oRYSVqittr4krcEgd5udMfcxb_CmLwfDmoOa2kqBFnAWlPIW_kzQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Aug 2021 11:33:38 -0400 (EDT)
Received: by eve.qyliss.net (Postfix, from userid 1000)
        id 937AD16D3; Mon,  9 Aug 2021 15:33:34 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     linux-perf-users@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Alyssa Ross <hi@alyssa.is>
Subject: [PATCH] tools/perf/Documentation: fix accidental em-dashes
Date:   Mon,  9 Aug 2021 15:32:26 +0000
Message-Id: <20210809153226.332545-1-hi@alyssa.is>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

" -- " is an em dash (—) in asciidoc, so all these examples that were
supposed to be producing a literal two dashes were being misrendered.

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 tools/perf/Documentation/intel-hybrid.txt |  2 +-
 tools/perf/Documentation/perf-c2c.txt     |  2 +-
 tools/perf/Documentation/perf-iostat.txt  |  4 ++--
 tools/perf/Documentation/perf-record.txt  |  2 +-
 tools/perf/Documentation/perf-stat.txt    | 14 +++++++-------
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/intel-hybrid.txt b/tools/perf/Documentation/intel-hybrid.txt
index 07f0aa3bf682..c9302096dc46 100644
--- a/tools/perf/Documentation/intel-hybrid.txt
+++ b/tools/perf/Documentation/intel-hybrid.txt
@@ -140,7 +140,7 @@ displayed. The percentage is the event's running time/enabling time.
 One example, 'triad_loop' runs on cpu16 (atom core), while we can see the
 scaled value for core cycles is 160,444,092 and the percentage is 0.47%.
 
-perf stat -e cycles -- taskset -c 16 ./triad_loop
+perf stat -e cycles \-- taskset -c 16 ./triad_loop
 
 As previous, two events are created.
 
diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index c81d72e3eecf..de6beedb7283 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'perf c2c record' [<options>] <command>
-'perf c2c record' [<options>] -- [<record command options>] <command>
+'perf c2c record' [<options>] \-- [<record command options>] <command>
 'perf c2c report' [<options>]
 
 DESCRIPTION
diff --git a/tools/perf/Documentation/perf-iostat.txt b/tools/perf/Documentation/perf-iostat.txt
index 165176944031..04d510364384 100644
--- a/tools/perf/Documentation/perf-iostat.txt
+++ b/tools/perf/Documentation/perf-iostat.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'perf iostat' list
-'perf iostat' <ports> -- <command> [<options>]
+'perf iostat' <ports> \-- <command> [<options>]
 
 DESCRIPTION
 -----------
@@ -85,4 +85,4 @@ EXAMPLES
 
 SEE ALSO
 --------
-linkperf:perf-stat[1]
\ No newline at end of file
+linkperf:perf-stat[1]
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d71bac847936..f1079ee7f2ec 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'perf record' [-e <EVENT> | --event=EVENT] [-a] <command>
-'perf record' [-e <EVENT> | --event=EVENT] [-a] -- <command> [<options>]
+'perf record' [-e <EVENT> | --event=EVENT] [-a] \-- <command> [<options>]
 
 DESCRIPTION
 -----------
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 45c2467e4eb2..4c9310be6acc 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -9,8 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'perf stat' [-e <EVENT> | --event=EVENT] [-a] <command>
-'perf stat' [-e <EVENT> | --event=EVENT] [-a] -- <command> [<options>]
-'perf stat' [-e <EVENT> | --event=EVENT] [-a] record [-o file] -- <command> [<options>]
+'perf stat' [-e <EVENT> | --event=EVENT] [-a] \-- <command> [<options>]
+'perf stat' [-e <EVENT> | --event=EVENT] [-a] record [-o file] \-- <command> [<options>]
 'perf stat' report [-i file]
 
 DESCRIPTION
@@ -217,8 +217,8 @@ Append to the output file designated with the -o option. Ignored if -o is not sp
 
 Log output to fd, instead of stderr.  Complementary to --output, and mutually exclusive
 with it.  --append may be used here.  Examples:
-     3>results  perf stat --log-fd 3          -- $cmd
-     3>>results perf stat --log-fd 3 --append -- $cmd
+     3>results  perf stat --log-fd 3          \-- $cmd
+     3>>results perf stat --log-fd 3 --append \-- $cmd
 
 --control=fifo:ctl-fifo[,ack-fifo]::
 --control=fd:ctl-fd[,ack-fd]::
@@ -245,7 +245,7 @@ disable events during measurements:
 
  perf stat -D -1 -e cpu-cycles -a -I 1000       \
            --control fd:${ctl_fd},${ctl_fd_ack} \
-           -- sleep 30 &
+           \-- sleep 30 &
  perf_pid=$!
 
  sleep 5  && echo 'enable' >&${ctl_fd} && read -u ${ctl_fd_ack} e1 && echo "enabled(${e1})"
@@ -265,7 +265,7 @@ disable events during measurements:
 --post::
 	Pre and post measurement hooks, e.g.:
 
-perf stat --repeat 10 --null --sync --pre 'make -s O=defconfig-build/clean' -- make -s -j64 O=defconfig-build/ bzImage
+perf stat --repeat 10 --null --sync --pre 'make -s O=defconfig-build/clean' \-- make -s -j64 O=defconfig-build/ bzImage
 
 -I msecs::
 --interval-print msecs::
@@ -496,7 +496,7 @@ $ perf config stat.no-csv-summary=true
 EXAMPLES
 --------
 
-$ perf stat -- make
+$ perf stat \-- make
 
    Performance counter stats for 'make':
 
-- 
2.32.0

