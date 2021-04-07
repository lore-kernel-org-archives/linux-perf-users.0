Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E9CC433B4
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Apr 2021 20:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED186120E
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Apr 2021 20:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356241AbhDGU05 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Apr 2021 16:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356254AbhDGU0D (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Apr 2021 16:26:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B8F86100A;
        Wed,  7 Apr 2021 20:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617827153;
        bh=bjKJ1E+uaBjneW4IFp1EjIgo3gf4vDbA/1WYSCxNg3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lwk4/hhs8u/LIKRsr7IYe0rbgjKu3TFv79OAkiawCPn6Ku6kdRjhXxlV9pZKrGUmw
         L1NSL9kMqYkX1yIU1KabV4PgmTKhMgLijEMOaG4O8lRpA9gsOy8opTDcOQEsBMlHar
         bexgrwjT7JqvfYK75S2y4kEVSk5fQZEf7Vfwc/NfldyeB0mM+rPC13BJkJBBZ8JO24
         8fA/0UQKPDFoAzR2BzBv4ov/b/IdrMEHyPSXVJlRDgWpBGgaBVh7Qqqe2uMuI8MWk9
         lW1A0yUkWcLA/IK5439DdNQanmVL+A5eOVVeKR+npG1TPF+RMhYmorSWmSdf+iP7iU
         XeGjE1qewq5rw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3EF0540647; Wed,  7 Apr 2021 17:25:50 -0300 (-03)
Date:   Wed, 7 Apr 2021 17:25:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf annotate: improve --stdio mode
Message-ID: <YG4VTsqJ9V3/hbOG@kernel.org>
References: <a0d53f31-f633-5013-c386-a4452391b081@suse.cz>
 <YDVb4KS/ARbtfoAw@kernel.org>
 <fedc723d-1c8f-fcd7-accb-421707b3a09f@suse.cz>
 <YG4IZhfYiE+2tyw7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YG4IZhfYiE+2tyw7@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Apr 07, 2021 at 04:30:46PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Feb 26, 2021 at 10:24:00AM +0100, Martin Liška escreveu:
> > On 2/23/21 8:47 PM, Arnaldo Carvalho de Melo wrote:
> > Sure. But I think the current format provides quite broken visual layout:
> > 
> >       0.00 :   405ef1: inc    %r15
> >       0.01 :   405ef4: vfmadd213sd 0x2b9b3(%rip),%xmm0,%xmm3        # 4318b0 <_IO_stdin_used+0x8b0>
> >    eff.c:1811    0.67 :   405efd: vfmadd213sd 0x2b9b2(%rip),%xmm0,%xmm3        # 4318b8 <_IO_stdin_used+0x8b8>
> >           :            TA + tmpsd * (TB +
> > 
> > vs.
> > 
> >       0.00 :   405ef1: inc    %r15
> >       0.01 :   405ef4: vfmadd213sd 0x2b9b3(%rip),%xmm0,%xmm3        # 4318b0 <_IO_stdin_used+0x8b0>
> >       0.67 :   405efd: vfmadd213sd 0x2b9b2(%rip),%xmm0,%xmm3        # 4318b8 <_IO_stdin_used+0x8b8> // eff.c:1811
> >            : 1810   TA + tmpsd * (TB +
> > 
> > I bet also the current users of --stdio mode would benefit from it.
> > What do you think?
 
> Agreed, I tried applying but it bitrotted, it seems :-\

I refreshed it, please check.

- Arnaldo

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 18eee25b4976bea8..abe1499a91645375 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1368,7 +1368,6 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 {
 	struct disasm_line *dl = container_of(al, struct disasm_line, al);
 	static const char *prev_line;
-	static const char *prev_color;
 
 	if (al->offset != -1) {
 		double max_percent = 0.0;
@@ -1407,20 +1406,6 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 
 		color = get_percent_color(max_percent);
 
-		/*
-		 * Also color the filename and line if needed, with
-		 * the same color than the percentage. Don't print it
-		 * twice for close colored addr with the same filename:line
-		 */
-		if (al->path) {
-			if (!prev_line || strcmp(prev_line, al->path)
-				       || color != prev_color) {
-				color_fprintf(stdout, color, " %s", al->path);
-				prev_line = al->path;
-				prev_color = color;
-			}
-		}
-
 		for (i = 0; i < nr_percent; i++) {
 			struct annotation_data *data = &al->data[i];
 			double percent;
@@ -1441,6 +1426,19 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 		printf(" : ");
 
 		disasm_line__print(dl, start, addr_fmt_width);
+
+		/*
+		 * Also color the filename and line if needed, with
+		 * the same color than the percentage. Don't print it
+		 * twice for close colored addr with the same filename:line
+		 */
+		if (al->path) {
+			if (!prev_line || strcmp(prev_line, al->path)) {
+				color_fprintf(stdout, color, " // %s", al->path);
+				prev_line = al->path;
+			}
+		}
+
 		printf("\n");
 	} else if (max_lines && printed >= max_lines)
 		return 1;
@@ -1456,7 +1454,7 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 		if (!*al->line)
 			printf(" %*s:\n", width, " ");
 		else
-			printf(" %*s:     %*s %s\n", width, " ", addr_fmt_width, " ", al->line);
+			printf(" %*s: %-*d %s\n", width, " ", addr_fmt_width, al->line_nr, al->line);
 	}
 
 	return 0;
